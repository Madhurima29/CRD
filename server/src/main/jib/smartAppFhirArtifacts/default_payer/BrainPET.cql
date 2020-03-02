library BrainPET
using FHIR version '4.0.0'
include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "RXNORM" : 'http://www.nlm.nih.gov/research/umls/rxnorm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'
codesystem "NUCCPT":'https://www.nlm.nih.gov/research/umls/sourcereleasedocs/current/NUCCPT/sourcerepresentation.html'

//Medicare or comparable number 
code "45397-7" : '45397-7' from "LOINC"
//National provider ID
code "45952-9" : '45952-9' from "LOINC"
//CMS certification number
code "46456-0" : '46456-0' from "LOINC"
//Facility Address
code "65833-6" : '65833-6' from "LOINC"

//Dementia
code "F03.90" : 'F03.90' from "ICD-10-CM"

//Alzheimer's Disease
code "G30.9" : 'G30.9' from "ICD-10-CM"

//Frontotemporal Dementia
code "G31.09" : 'G31.09' from "ICD-10-CM"

//Epilepsy, unspecified
code "G40.919" : 'G40.919' from "ICD-10-CM"

//Malignant(Primary) Neoplasm
code "C80.1" : 'C80.1' from "ICD-10-CM"

parameter "Measurement Period" Interval<DateTime>

context Patient
	
define Today: Today()

// Beneficiary info
define BeneficiaryNameObject: 
	singleton from (Patient.name)

define BeneficiaryName: 
	PatientFirstName +' '+PatientMiddleInitial + ' '+ PatientLastName
	//PatientFirstName + ' '+ PatientLastName

define PatientLastName: "BeneficiaryNameObject".family.value

define PatientMiddleInitial: 
	if (Length("BeneficiaryNameObject".given)>1) then GetMiddleInitials("BeneficiaryNameObject")
	else ''
	
define PatientFirstName: "BeneficiaryNameObject".given[0].value

define BeneficiaryGender: Patient.gender.value

define BeneficiaryDateOfBirth: Patient.birthDate.value

define BeneficiaryIdentificationNumber: 
	(singleton from (
  	Patient.identifier identifier
   	where identifier.system.value ='urn:oid:1.1.1.1.1.1' or identifier.system.value ='http://hl7.org/fhir/sid/us-medicare')).value.value


// Practitioner info
define Practitioner: 
	singleton from (
  		[Practitioner]practitioner)
    		//where ('Practitioner/' + practitioner.id.value) = singleton from ([ServiceRequest]).performer[0].reference.value)
    
define PractitionerNameObject: 
	singleton from ("Practitioner".name)
	
define PractitionerName: 
	//PractitionerFirstName + ' '+ PractitionerMiddleInitial + ' '+ PractitionerLastName
	PractitionerFirstName + ' '+ PractitionerLastName

define PractitionerLastName: "PractitionerNameObject".family.value

define PractitionerMiddleInitial: GetMiddleInitials("PractitionerNameObject")

define PractitionerFirstName: "PractitionerNameObject".given[0].value

define PractitionerNPI: ''
	//(singleton from (
  	//	"Practitioner".identifier identifier
    	//	where identifier.system.value = 'http://hl7.org.fhir/sid/us-npi')).value.value

define PractitionerPTAN:
	''

define PractitionerAddressObject: singleton from ("Practitioner".address address where address.use.value = 'home')  

define PractitionerAddress: 
	"PractitionerAddressObject".line[0].value +', ' +"PractitionerAddressObject".city.value +', ' +"PractitionerAddressObject".state.value+', ' +"PractitionerAddressObject".postalCode.value


//Facility info
define Facility: 
	 singleton from (
  		[Organization]org
    		where ('Organization/' + org.id.value) = singleton from ([Encounter]).serviceProvider.reference.value)

define FacilityName: Facility.name.value

define FacilityNPI: (singleton from (
  		"Facility".identifier identifier
    		where identifier.system.value = 'http://hl7.org.fhir/sid/us-npi')).value.value

define FacilityTaxID:
	(singleton from (
  		"Facility".identifier identifier
    		where identifier.type.coding[0].system.value = 'http://terminology.hl7.org/CodeSystem/v2-0203' and identifier.type.coding[0].code.value = 'TAX')).value.value

define FacilityAddressObject: singleton from ("Facility".address address where address.use.value = 'work')  

define FacilityAddress: 
	"FacilityAddressObject".line[0].value +', ' +"FacilityAddressObject".city.value +', ' +"FacilityAddressObject".state.value+', ' +"FacilityAddressObject".postalCode.value


//Diagnoses/Procedures
define "Dementia":
	if exists([Condition]P
		where FHIRHelpers.ToConcept(P.code).codes[0]~"F03.90" 
			and (P.onset as Period) starts during "Measurement Period") then 'F03.90'
	else ''

define "Alzheimer's Disease":
	if exists([Condition]P
		where FHIRHelpers.ToConcept(P.code).codes[0]~"G30.9" 
			and (P.onset as Period) starts during "Measurement Period") then 'G30.9'
	else ''

define "Frontotemporal Dementia":
	if exists([Condition]P
		where FHIRHelpers.ToConcept(P.code).codes[0]~"G31.09" 
			and (P.onset as Period) starts during "Measurement Period") then 'G31.09'
	else ''

define "Epilepsy, unspecified":
	if exists([Condition]P
		where FHIRHelpers.ToConcept(P.code).codes[0]~"G40.919" 
			and (P.onset as Period) starts during "Measurement Period") then 'G40.919'
	else ''

define "Dementia/AD":
	{"Dementia","Alzheimer's Disease","Frontotemporal Dementia","Epilepsy, unspecified"}

define "Date of Service": singleton from([Encounter]).period.start.value

define "Malignant Neoplasm":
	if exists([Condition]P
		where FHIRHelpers.ToConcept(P.code).codes[0]~"C80.1" 
			and (P.onset as Period) starts during "Measurement Period") then 'C80.1'
	else ''


//Requestor info
define Requestor: 
	 singleton from (
  		[Practitioner]practitioner)
    		//where ('Practitioner/' + practitioner.id.value) = singleton from ([ServiceRequest]).performer[0].reference.value)

define RequestorNameObject: 
	singleton from ("Requestor".name)
	
define SubmitterName: 
	//PractitionerFirstName + ' '+ PractitionerMiddleInitial + ' '+ PractitionerLastName
	RequestorFirstName + ' '+ RequestorLastName

define RequestorLastName: "RequestorNameObject".family.value

define RequestorMiddleInitial: GetMiddleInitials("RequestorNameObject")

define RequestorFirstName: "RequestorNameObject".given[0].value

define SubmitterTelephone: 
	(singleton from (
  		"Requestor".telecom tele
    		where tele.system.value = 'phone')).value.value

define function GetMiddleInitials(name FHIR.HumanName):
  Substring(Combine((name.given given return Substring(given.value,0,1)),', '),3)

define function GetProcedure(ProcedureList List<Procedure>, ProcedureCode String):
  ProcedureList P where P.code.coding[0].code.value= ProcedureCode
