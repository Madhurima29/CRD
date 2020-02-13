package org.hl7.davinci.endpoint.cdshooks.services.crd.r4;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.parser.IParser;
import com.google.gson.JsonObject;

import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;
import javax.validation.Valid;
import org.cdshooks.FhirAuthorization;
import org.cdshooks.Hook;
import org.hl7.davinci.PrefetchTemplateElement;
import org.hl7.davinci.RequestIncompleteException;
import org.hl7.davinci.endpoint.cdshooks.services.crd.CdsService;
import org.hl7.davinci.endpoint.cql.r4.CqlExecutionContextBuilder;
import org.hl7.davinci.endpoint.rules.CoverageRequirementRuleCriteria;
import org.hl7.davinci.endpoint.rules.CoverageRequirementRuleFinder;
import org.hl7.davinci.endpoint.rules.CoverageRequirementRuleQuery;
import org.hl7.davinci.endpoint.rules.CoverageRequirementRuleResult;
import org.hl7.davinci.endpoint.cql.bundle.CqlBundle;
import org.hl7.davinci.endpoint.database.CoverageRequirementRule;
import org.hl7.davinci.endpoint.results.CRDResult;
import org.hl7.davinci.r4.FhirComponents;
import org.hl7.davinci.r4.Utilities;
import org.hl7.davinci.r4.crdhook.CrdPrefetchTemplateElements;
import org.hl7.davinci.r4.crdhook.orderreview.OrderReviewRequest;
import org.hl7.davinci.r4.crdhook.orderselect.OrderSelectRequest;
import org.hl7.fhir.instance.model.api.IBaseResource;
import org.hl7.fhir.r4.model.Bundle;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.opencds.cqf.cql.execution.Context;

import org.hl7.fhir.r4.model.Coding;
import org.hl7.fhir.r4.model.Coverage;
import org.hl7.fhir.r4.model.DeviceRequest;
import org.hl7.fhir.r4.model.Identifier;
import org.hl7.fhir.r4.model.Organization;
import org.hl7.fhir.r4.model.Patient;
import org.hl7.fhir.r4.model.Reference;
import org.hl7.fhir.r4.model.Resource;
import org.hl7.fhir.r4.model.ResourceType;
import org.hl7.fhir.r4.model.ServiceRequest;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

@Component("r4_OrderSelectService")
public class OrderSelectService extends CdsService<OrderSelectRequest> {

    public static final String ID = "order-select-crd";
    public static final String TITLE = "order-review Coverage Requirements Discovery";
    public static final Hook HOOK = Hook.ORDER_SELECT;
    public static final String DESCRIPTION
            = "Get information regarding the coverage requirements for durable medical equipment";
    public static final List<PrefetchTemplateElement> PREFETCH_ELEMENTS = Arrays.asList(
            CrdPrefetchTemplateElements.DEVICE_REQUEST_BUNDLE,
            CrdPrefetchTemplateElements.SUPPLY_REQUEST_BUNDLE,
            CrdPrefetchTemplateElements.NUTRITION_ORDER_BUNDLE,
            CrdPrefetchTemplateElements.MEDICATION_REQUEST_BUNDLE,
            CrdPrefetchTemplateElements.SERVICE_REQUEST_BUNDLE);
    public static final FhirComponents FHIRCOMPONENTS = new FhirComponents();
    static final Logger logger = LoggerFactory.getLogger(OrderSelectService.class);

    public OrderSelectService() {
        super(ID, HOOK, TITLE, DESCRIPTION, PREFETCH_ELEMENTS, FHIRCOMPONENTS);
    }

    @Override
    public List<CoverageRequirementRuleResult> createCqlExecutionContexts(OrderSelectRequest orderSelectRequest, CoverageRequirementRuleFinder ruleFinder) {

        List<String> selections = Arrays.asList(orderSelectRequest.getContext().getSelections());

        FhirBundleProcessor fhirBundleProcessor = new FhirBundleProcessor(orderSelectRequest.getPrefetch(), ruleFinder, selections);
        fhirBundleProcessor.processDeviceRequests();
        fhirBundleProcessor.processMedicationRequests();
        fhirBundleProcessor.processServiceRequests();
        List<CoverageRequirementRuleResult> results = fhirBundleProcessor.getResults();

        if (results.isEmpty()) {
            throw RequestIncompleteException.NoSupportedBundlesFound();
        }
        return results;
    }

    public List<CRDResult> getRequirements(@Valid @RequestBody OrderSelectRequest request) {
        List<CRDResult> results = new ArrayList<>();

        List<ServiceRequest> serviceRequestList = extractServiceRequests(request);
        System.out.println("Getting requirements for ");
        for (Iterator<ServiceRequest> iterator = serviceRequestList.iterator(); iterator.hasNext();) {

            ServiceRequest next = iterator.next();
            System.out.println("got the service request for " + next.getId());

            results.add(getResult(request, next));

        }
        if (results.isEmpty()) {
            CRDResult result = new CRDResult();
            result.addError("Could not get any Service requests");
        }

        return results;

    }

    private CRDResult getResult(@Valid @RequestBody OrderSelectRequest request,
            ServiceRequest serviceRequest) {
        ServiceRequest ps = new ServiceRequest();
        Coverage coverage = null;
        Patient patient = null;
        Organization org = null;
        String patientId = request.getContext().getPatientId();

        Bundle serviceRequestBundle = new Bundle();
        if (request.getPrefetch() != null) {
            serviceRequestBundle = request.getPrefetch().getServiceRequestBundle();
            coverage = getCoverage(serviceRequestBundle, serviceRequest);
            if (coverage != null) {
                org = getOrganization(serviceRequestBundle, coverage);
                patient = getPatient(serviceRequestBundle, coverage, patientId);
            }

        }

        if (patient == null) {

            patient = getPatientFromFhir(patientId, request.getFhirServer(), request.getFhirAuthorization());
        }

        if (org == null) {
            List<Organization> orgs = getOrganizationFromFhirbyPatientId(patientId, request.getFhirServer(), request.getFhirAuthorization());
            for (Iterator<Organization> iterator = orgs.iterator(); iterator.hasNext();) {
                org = iterator.next();

            }

        }

        return checkPriorServiceAuthRequirements(serviceRequest, org, patient);
    }

    private Patient getPatientFromFhir(String id, String fullUrl, FhirAuthorization auth) {
        String query = "/Patient/" + id;
        IBaseResource resource = executeFhirQuery(fullUrl, auth, query);
        if (resource instanceof Patient) {
            return (Patient) resource;
        }
        
        return null;
    }

    private Coverage getCoverageFromFhir(String id, String fullUrl, FhirAuthorization auth) {
        String query = "/Coverage/" + id;
        IBaseResource resource = executeFhirQuery(fullUrl, auth, query);
        if (resource instanceof Coverage) {
            return (Coverage) resource;
        }
        return null;
    }

    private Organization getOrganizationFromFhir(String id, String fullUrl, FhirAuthorization auth) {
        String query = "/Organization/" + id;
        IBaseResource resource = executeFhirQuery(fullUrl, auth, query);
        if (resource instanceof Organization) {
            return (Organization) resource;
        }
        return null;
    }

    private List<Organization> getOrganizationFromFhirbyPatientId(String patientid, String fullUrl, FhirAuthorization auth) {
        String query = "/Coverage?patient=" + patientid;
        List<Organization> orgs = new ArrayList();
        IBaseResource resource = executeFhirQuery(fullUrl, auth, query);
        if (resource instanceof Bundle) {
            Bundle bundle = (Bundle) resource;
            List<Bundle.BundleEntryComponent> entries = bundle.getEntry();
            for (Iterator<Bundle.BundleEntryComponent> iterator = entries.iterator(); iterator.hasNext();) {
                Bundle.BundleEntryComponent next = iterator.next();
                if (next.getResource().getResourceType() == ResourceType.Coverage) {
                    Coverage cov = (Coverage) (next.getResource());
                    List<Reference> orgRefs = cov.getPayor();
                    System.out.println("Got covs" + orgRefs.size());
                    for (Iterator<Reference> iterator1 = orgRefs.iterator(); iterator1.hasNext();) {
                        Reference next1 = iterator1.next();
                        System.out.println("element " + next1.getReferenceElement().getValue());
                        orgs.add(getOrganizationFromFhir(next1.getReferenceElement().getIdPart(), fullUrl, auth));

                    }
                }

            }

        }
        return orgs;
    }

    private List<Coverage> getCoverageFromFhirbyPatientId(String patientid, String fullUrl, FhirAuthorization auth) {
        String query = "/Coverage?patient=id";
        List<Coverage> coverages = new ArrayList();
        IBaseResource resource = executeFhirQuery(fullUrl, auth, query);
        if (resource.getIdElement().getIdPart().equals("Bundle")) {
            Bundle bundle = (Bundle) resource;
            List<Bundle.BundleEntryComponent> entries = bundle.getEntry();
            for (Iterator<Bundle.BundleEntryComponent> iterator = entries.iterator(); iterator.hasNext();) {
                Bundle.BundleEntryComponent next = iterator.next();
                if (next.getResource().getResourceType() == ResourceType.Coverage) {
                    Coverage cov = (Coverage) (next.getResource());
                    coverages.add(cov);
                }

            }

        }
        return coverages;
    }

    private IBaseResource executeFhirQuery(String fullUrl, FhirAuthorization auth,
            String query) {

        String token = auth.getAccessToken();

        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
        if (token != null) {
            headers.set("Authorization", "Bearer " + token);
        }
        HttpEntity<String> entity = new HttpEntity<>("", headers);
        try {
            logger.debug("Fetching: " + fullUrl);
            System.out.println("The full url is " + fullUrl);
            System.out.println("The toekn url is " + token);
            System.out.println("The query is " + query);

            ResponseEntity<String> response = restTemplate.exchange(fullUrl + query, HttpMethod.GET,
                    entity, String.class);
            System.out.println("The response is " + response.getBody());
            System.out.println("======================================" );
            System.out.println("======================================" );
            return FhirContext.forR4().newJsonParser().parseResource(response.getBody());
        } catch (RestClientException e) {
            logger.warn("Unable to make the fetch request", e);
            return null;
        }
    }

    private Patient getPatient(Bundle serviceRequestBundle, Coverage coverage, String patientId) {
        if (serviceRequestBundle != null) {
            List<Bundle.BundleEntryComponent> components = serviceRequestBundle.getEntry();
            for (Iterator<Bundle.BundleEntryComponent> iterator = components.iterator(); iterator.hasNext();) {
                Bundle.BundleEntryComponent next = iterator.next();
                if (next.getResource().getResourceType() == ResourceType.Patient) {
                    Patient patient = (Patient) (next.getResource());
                    if (coverage.getBeneficiary() != null
                            && coverage.getBeneficiary().getReference() != null) {
                        System.out.println("checking  patient " + patient.getId());
                        System.out.println("with " + coverage.getBeneficiary().getReference());
                        if (coverage.getBeneficiary().getReference().equals(patient.getId())) {
                            return patient;
                        }
                    } else if (patient.getId().equals("Patient/" + patientId)) {
                        System.out.println("checking  only patient " + patient.getId());
                        return patient;
                    } else {
                        System.out.println("did not match   patient " + patient.getId());

                    }
                }
            }
        }
        return null;
    }

    private Organization getOrganization(Bundle serviceRequestBundle, Coverage coverage) {
        if (serviceRequestBundle != null) {
            List<Bundle.BundleEntryComponent> components = serviceRequestBundle.getEntry();
            for (Iterator<Bundle.BundleEntryComponent> iterator = components.iterator(); iterator.hasNext();) {
                Bundle.BundleEntryComponent next = iterator.next();
                if (next.getResource().getResourceType() == ResourceType.Organization) {
                    Organization org = (Organization) (next.getResource());
                    if (coverage.getBeneficiary() != null) {
                        List<Reference> payors = coverage.getPayor();
                        for (Iterator<Reference> iterator1 = payors.iterator(); iterator1.hasNext();) {
                            Reference next1 = iterator1.next();
                            if (next1.getReference().equals(org.getId())) {
                                return org;
                            }

                        }
                    }
                }
            }
        }
        return null;
    }

    private Coverage getCoverage(Bundle serviceRequestBundle, ServiceRequest serviceRequest) {
        if (serviceRequestBundle != null) {
            List<Bundle.BundleEntryComponent> components = serviceRequestBundle.getEntry();
            for (Iterator<Bundle.BundleEntryComponent> iterator = components.iterator(); iterator.hasNext();) {
                Bundle.BundleEntryComponent next = iterator.next();

                if (next.getResource().getResourceType() == ResourceType.Coverage) {
                    Coverage tempCov = (Coverage) (next.getResource());
                    if (serviceRequest.getInsurance() != null) {
                        List<Reference> srCoverages = serviceRequest.getInsurance();
                        System.out.println("The coverages size is" + srCoverages.size());
                        for (Iterator<Reference> iterator1 = srCoverages.iterator();
                                iterator1.hasNext();) {
                            Reference next1 = iterator1.next();
                            System.out.println("The next1 is " + next1.getReference());
                            if (next1.getReference().equals(tempCov.getId())) {
                                System.out.println("got coverage ");
                                return tempCov;
                            }

                        }

                    }
                }

            }
        }
        return null;
    }

    private CRDResult getRequirementForService(ServiceRequest serviceRequest) {
        CRDResult result = new CRDResult();
        try {
            if (serviceRequest.getInsurance() == null) {
                result.addError("Insurance/Coverage information not provided");
                return result;
            } else {
                List<Coverage> coverages = serviceRequest.getInsurance().stream()
                        .map(reference -> (Coverage) reference.getResource()).collect(Collectors.toList());
                List<Organization> payors = Utilities.getPayors(coverages);
                for (Iterator<Organization> iterator = payors.iterator(); iterator.hasNext();) {
                    Organization next = iterator.next();
                    Patient patient = (Patient) serviceRequest.getSubject().getResource();
                    return checkPriorServiceAuthRequirements(serviceRequest, next, patient);

                }
            }

        } catch (Exception e) {
            result.addError("Unexpected Error occured");
            logger.info("Error occured in getRequirementForService:" + e.getMessage());
            e.printStackTrace();
        }

        result.addError("Could not fetch any payors from the coverage information provided");

        return result;
    }

    private List<ServiceRequest> extractServiceRequests(OrderSelectRequest orderSelectRequest) {

        //Bundle serviceRequestBundle = orderSelectRequest.getPrefetch().getServiceRequestBundle();
        Bundle serviceRequestBundle = orderSelectRequest.getContext().getDraftOrders();
        if (serviceRequestBundle == null) {
            System.out.println("null bundle " + orderSelectRequest.getContext().getPatientId());

        }

        List<ServiceRequest> serviceRequestList = Utilities
                .getResourcesOfTypeFromBundle(ServiceRequest.class, serviceRequestBundle);
        System.out.println("The bundle for orders size is " + serviceRequestList.size());
        return serviceRequestList;

    }

    private CRDResult checkPriorServiceAuthRequirements(ServiceRequest ser, Organization payer, Patient patient) {
        CRDResult result = new CRDResult();

        if (payer == null) {
            result.addError("Payer information not complete");
        }
        if (ser == null) {
            result.addError("Service request information not complete");
        }
        if (patient == null) {
            result.addError("patient information not complete");
        }

        if (result.getErrors().isEmpty()) {
            Identifier payerIdentifier = getPayerIdentifier(payer);
            payer.getIdentifier().add(payerIdentifier);

            Bundle bundle = new Bundle();

            bundle.addEntry().setResource(payer);
            bundle.addEntry().setResource(ser);
            bundle.addEntry().setResource(patient);
            return getResult(bundle);
        }
        return result;
    }

}
