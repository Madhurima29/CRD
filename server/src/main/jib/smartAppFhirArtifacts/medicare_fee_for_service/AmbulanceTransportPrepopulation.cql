library NonEmergentAmbulanceTransport

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include MATGlobalCommonFunctions_FHIR4 version '4.0.000' called Global

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "ICD-9-CM": 'http://hl7.org/fhir/sid/icd-9'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'
codesystem "NUCCPT":'https://www.nlm.nih.gov/research/umls/sourcereleasedocs/current/NUCCPT/sourcerepresentation.html'

//Reduced mobility
code "Z74.0": 'Z74.0' from "ICD-10-CM"
//Need for assistance with personal care
code "Z74.1": 'Z74.1' from "ICD-10-CM"
//Other problems related to care provider dependency
code "Z74.8": 'Z74.8' from "ICD-10-CM"
//Dependence on other enabling machines and devices
code "Z99.8": 'Z99.8' from "ICD-10-CM"
//Dialysis
code "Z99.2": 'Z99.2' from "ICD-10-CM"
//Difficulty in walking, not elsewhere classified
code "R26.2": 'R26.2' from "ICD-10-CM"
//Fall from moving wheelchair
code "V00.811": 'V00.811' from "ICD-10-CM"

//Osteoarthritis of knee, unspecified
code "M17.9": 'M17.9' from "ICD-10-CM"
//Muscle weakness (generalized)
code "M62.81": 'M62.81' from "ICD-10-CM"
//Physical deconditioning
code "R53.81": 'R53.81' from "ICD-10-CM"
//Lack of physical exercise
code "Z72.3": 'Z72.3' from "ICD-10-CM"

//Sequelae of cerebrovascular disease
code "I69": 'I69' from "ICD-10-CM"

//Presence of other orthopedic joint implants
code "Z96.698": 'Z96.698' from "ICD-10-CM"

//Acquired absence of limb
code "Z89": 'Z89' from "ICD-10-CM"

//Acute embolism and thrombosis of unspecified deep veins of lower extremity
code "I82.40": 'I82.40' from "ICD-10-CM"
//Other symptoms involving nervous and musculoskeletal systems
code "781.99": '781.99' from "ICD-9-CM"

//Nonunion of fracture
code "733.82": '733.82' from "ICD-9-CM"

//Bed confinement status
code "Z74.01": 'Z74.01' from "ICD-10-CM"
//Wound care
code "97597": '97597' from "CPT"
code "97598": '97598' from "CPT"
code "11042": '11042' from "CPT"
code "11043": '11043' from "CPT"
code "11044": '11044' from "CPT"
code "11045": '11045' from "CPT"
code "11046": '11046' from "CPT"
code "11047": '11047' from "CPT"

//Unspecified injury at unspecified level of cervical spinal cord, initial encounter
code "S14.109A": 'S14.109A' from "ICD-10-CM"

//transient paralysis
code "R29.5": 'R29.5' from "ICD-10-CM"

//Demyelinating disease of central nervous system, unspecified
code "G37.9": 'G37.9' from "ICD-10-CM"

// Special radiation treatment
code "77470": '77470' from "CPT"

//Under care of public health physician (finding)
code "305524001": '305524001' from "SNOMED-CT"

// Physician supervision of a hospice patient
code "99377": '99377' from "CPT"

//Physician Assistants & Advanced Practice Nursing Providers; Clinical Nurse Specialist, Home Health
code "364SH0200X" : '364SH0200X' from "NUCCPT"

//Medicare or comparable number 
code "45397-7" : '45397-7' from "LOINC"

//National provider ID
code "45952-9" : '45952-9' from "LOINC"

//CMS certification number
code "46456-0" : '46456-0' from "LOINC"

//Facility Address
code "65833-6" : '65833-6' from "LOINC"

//hcpcs codes for NonEmergentAmbulanceTransport
code "A0426" : 'A0426' from "HCPCS"
code "A0428" : 'A0428' from "HCPCS"

//Chemotherapy Administration 
code "Q0083" : 'Q0083' from "HCPCS"
code "Q0084" : 'Q0084' from "HCPCS"
code "Q0085" : 'Q0085' from "HCPCS"
code "Q0081" : 'Q0081' from "HCPCS"
code "90772": '90772' from "CPT"
code "90773": '90773' from "CPT"
code "90774": '90774' from "CPT"
code "90775": '90775' from "CPT"
code "90776": '90776' from "CPT"
code "90779": '90779' from "CPT"

//Pain, unspecified
code "R52": 'R52' from "ICD-10-CM"

//Pressure ulcer of unspecified buttock, stage 2
code "L89.302": 'L89.302' from "ICD-10-CM"

//Morbid (severe) obesity due to excess calories
code "E66.01": 'E66.01' from "ICD-10-CM"

//Need for isolation
code "V07.0": 'V07.0' from "ICD-10-CM"

//Als specialized service disposable supplies; iv drug therapy 
code "A0394" : 'A0394' from "HCPCS"

//Violent behavior
code "R45.6": 'R45.6' from "ICD-10-CM"

//Personal history of self-harm
code "Z91.5": 'Z91.5' from "ICD-10-CM"

//Disorientation, unspecified
code "R41.0": 'R41.0' from "ICD-10-CM"

//Conduct disorder, unspecified
code "F91.9": 'F91.9' from "ICD-10-CM"

//Other fatigue
code "R53.83": 'R53.83' from "ICD-10-CM"

//Unspecified coma
code "R40.20": 'R40.20' from "ICD-10-CM"

//Limitation of activities due to disability
code "Z73.6": 'Z73.6' from "ICD-10-CM"

//parameter service_request ServiceRequest
parameter "Measurement Period" Interval<DateTime>

context Patient

define NonEmergentAmbulanceTransportCodes : {'A0426','A0428'}

define WoundCare:{'97597','97598','11042','11043','11044','11045','11046','11047'}

define Chemotherapy: {'Q0083','Q0084','Q0085','Q0081','90772','90773','90774','90775','90776','90779'}

define NonEmergentAmbulanceTransport:
	singleton from (
  		[Procedure] service
    		where service.code.coding[0].code.value in "NonEmergentAmbulanceTransportCodes"
    		 )
    		
define Today: Today()

// Beneficiary info
define BeneficiaryNameObject: 
	singleton from (Patient.name name where name.use.value='official')

define BeneficiaryName: 
	if (PatientFirstName is not null and PatientMiddleInitial is not null and PatientLastName is not null) then
	PatientFirstName +' '+PatientMiddleInitial + ' '+ PatientLastName
	else PatientFirstName + ' '+ PatientLastName

define PatientLastName: "BeneficiaryNameObject".family.value

define PatientMiddleInitial: 
	if (Length("BeneficiaryNameObject".given)>1) then GetMiddleInitials("BeneficiaryNameObject")
	else ''
	
define PatientFirstName: "BeneficiaryNameObject".given[0].value

define BeneficiaryGender: Patient.gender.value

define BeneficiaryDateOfBirth: Patient.birthDate.value

define "Coverage Subscriber":
	if exists([Coverage]) then
	([Patient]P where 'Patient/'+Patient.id.value= singleton from([Coverage]).subscriber.reference.value)
	else null

define BeneficiaryMedicareNumber: 
	if exists("Coverage Subscriber") then
	(Last(
  	"Coverage Subscriber".identifier identifier
   	where identifier.system.value ='urn:oid:1.1.1.1.1.1' or identifier.system.value ='urn:oid:2.16.840.1.113883.3.787.0.0' or identifier.system.value ='http://hl7.org/fhir/sid/us-medicare' or identifier.system.value ='urn:oid:2.2.2.2.2.2')).value.value
	else ''


define "Encounter resource": 
	(Last([Encounter]E sort by start of period)).participant

define "Encounter participant":
	"Encounter resource"

define Practitioner: //Last([Practitioner])
	singleton from([Practitioner]practitioner 
			with [ServiceRequest]SR
			such that ('Practitioner/' + practitioner.id.value) = SR.requester.reference.value)
    
define PractitionerNameObject: 
	if "Practitioner" is not null then
	singleton from ("Practitioner".name[0]) else null
	
define PractitionerName: 
	//PractitionerFirstName + ' '+ PractitionerMiddleInitial + ' '+ PractitionerLastName
	PractitionerFirstName + ' '+ PractitionerLastName

define PractitionerLastName: "PractitionerNameObject".family.value

define PractitionerMiddleInitial: GetMiddleInitials("PractitionerNameObject")

define PractitionerFirstName: "PractitionerNameObject".given[0].value

define PractitionerNPI:  //'1986352488'
	(singleton from (
  		"Practitioner".identifier identifier
    		where identifier.system.value = 'http://hl7.org/fhir/sid/us-npi')).value.value

define PractitionerPTAN:
	(singleton from (
  		"Practitioner".identifier identifier
    		where identifier.type.coding[0].system.value = 'http://terminology.hl7.org/CodeSystem/v2-0203' and identifier.type.coding[0].code.value = 'TAX')).value.value

define PractitionerTelephone:
	if "Practitioner".telecom[0] is not null then
	(singleton from (
  		"Practitioner".telecom[0])).value.value
	else ''

define PractitionerAddressObject: 
	if exists("Practitioner".address) then
	singleton from ("Practitioner".address[0]) else null  

define PractitionerAddress: 
	if exists("PractitionerAddressObject") then
	"PractitionerAddressObject".line[0].value +', ' +"PractitionerAddressObject".city.value +', ' +"PractitionerAddressObject".state.value+', ' +"PractitionerAddressObject".postalCode.value
	else ''


// Ambulance Supplier info

define ServiceRequestObject:
	singleton from ([ServiceRequest])

define AmbulanceSupplier: 
	singleton from (
  		[Organization] org
    		with ("ServiceRequestObject".performer) P 
    		such that P.reference.value = ('Organization/' + org.id.value))

	
define AmbulanceSupplierName: //'Nc Curdy, Michael'
	"AmbulanceSupplier".name.value

define AmbulanceSupplierNPI: //'1935467921'
(singleton from (
  		"AmbulanceSupplier".identifier identifier
    		where identifier.system.value = 'http://hl7.org/fhir/sid/us-npi')).value.value

define AmbulanceSupplierPTAN: (singleton from (
  "AmbulanceSupplier".identifier identifier
    where identifier.type.coding[0].system.value = 'http://terminology.hl7.org/CodeSystem/v2-0203' and identifier.type.coding[0].code.value = 'PRN')).value.value
    
define AmbulanceSupplierAddressObject: 
	singleton from ("AmbulanceSupplier".address)  

define AmbulanceSupplierAddress: //'711-2800 Nulla St., Mankato, Mississippi, 96522' 
	if exists("AmbulanceSupplierAddressObject") then
	"AmbulanceSupplierAddressObject".line[0].value +', ' +"AmbulanceSupplierAddressObject".city.value +', ' +"AmbulanceSupplierAddressObject".state.value+', ' +"AmbulanceSupplierAddressObject".postalCode.value
	else ''

define StartDate: (start of Global."Normalize Interval"("ServiceRequestObject".occurrence))

define NumofTransports: ("ServiceRequestObject".quantity as Quantity).value.value

define TransportState: AmbulanceSupplier.address[0].state.value

define SubmissionDate: Today

define TransportContraindicated: true

define MedicallyRequired: true

define Dialysis:
	
	([Procedure] c where c.code.coding[0].code.value= 'Z99.2')P
	with [ServiceRequest]SR 
	such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value)
	
define RadiationTherapy: 
	([Procedure] c where c.code.coding[0].code.value= '77470')P
	with [ServiceRequest]SR 
	such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value)
	
define WoundCareCondition:
	([Procedure] c where c.code.coding[0].code.value in "WoundCare")P
	with [ServiceRequest]SR 
	such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value)

define ChemotherapyCondition:
	([Procedure] c where c.code.coding[0].code.value in "Chemotherapy")P
	with [ServiceRequest]SR 
	such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value)

define BedConfined: 
	if (exists(([Observation] c where c.code.coding[0].code.value= 'Z74.01')P
			with [ServiceRequest]SR 
			such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value)) 
		or exists(([Observation] c where c.code.coding[0].code.value= 'R26.2')P
			with [ServiceRequest]SR 
			such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value))
		or exists(([Observation] c where c.code.coding[0].code.value= 'Z74.1')P
			with [ServiceRequest]SR 
			such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value)))
	then true
	else false

define SittingPosition:
	if (exists(([Observation] c where c.code.coding[0].code.value= 'V00.811')P
			with [ServiceRequest]SR 
			such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value)) 
		and exists(([Condition] c where c.code.coding[0].code.value= 'M62.81')P
			with [ServiceRequest]SR 
			such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value))
		and exists(([Condition] c where c.code.coding[0].code.value= 'R53.81')P
			with [ServiceRequest]SR 
			such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value)))
	then true
	else false

define FracturesCondition:
	([Condition] c where c.code.coding[0].code.value ='733.82')P
			with [ServiceRequest]SR 
			such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value)

define Osteoarthritis:
	([Condition] c where c.code.coding[0].code.value ='M17.9')P
			with [ServiceRequest]SR 
			such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value)

define MuscularWeakness:
	if (exists(([Observation] c where c.code.coding[0].code.value= 'Z72.3')P
			with [ServiceRequest]SR 
			such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value)) 
		and exists(([Condition] c where c.code.coding[0].code.value= 'M62.81')P
			with [ServiceRequest]SR 
			such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value))
		and exists(([Condition] c where c.code.coding[0].code.value= 'R53.81')P
			with [ServiceRequest]SR 
			such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value)))
	then true
	else false

define OrthopedicJointImplants:
	([Condition] c where c.code.coding[0].code.value ='Z96.698')P
			with [ServiceRequest]SR 
			such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value)

define Amputation:
	([Condition] c where c.code.coding[0].code.value ='Z89')P
			with [ServiceRequest]SR 
			such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value)

define CVAWithSequelae:
	([Condition] c where c.code.coding[0].code.value ='I69')P
			with [ServiceRequest]SR 
			such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value)

define DVT:
	([Condition] c where c.code.coding[0].code.value ='I82.40')P
			with [ServiceRequest]SR 
			such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value)

define DemyelinatingDisease:
	([Condition] c where c.code.coding[0].code.value ='G37.9')P
			with [ServiceRequest]SR 
			such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value)

define Ulcer:
	if (exists(([Condition] c where c.code.coding[0].code.value= 'L89.302')P
			with [ServiceRequest]SR 
			such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value)))
	then true
	else false

define MorbidObesity:
	if (exists(([Observation] c where c.code.coding[0].code.value= 'Z74.1')P
			with [ServiceRequest]SR 
			such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value)) 
		and exists(([Observation] c where c.code.coding[0].code.value= 'Z99.8')P
			with [ServiceRequest]SR 
			such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value)) 
		and exists(([Condition] c where c.code.coding[0].code.value= 'E66.01')P
			with [ServiceRequest]SR 
			such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value)))
	then true
	else false

define IVMedications: 
	([Procedure] c where c.code.coding[0].code.value= 'A0394')P
			with [ServiceRequest]SR 
			such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value)

define Isolation: 
	([Observation] c where c.code.coding[0].code.value= 'V07.0')P
			with [ServiceRequest]SR 
			such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value)

define Danger:
	if (exists(([Observation] c where c.code.coding[0].code.value= 'Z91.5')P
			with [ServiceRequest]SR 
			such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value)) 
		or exists(([Condition] c where c.code.coding[0].code.value= 'R45.6')P
			with [ServiceRequest]SR 
			such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value)))
	then true
	else false

define MentalCondition:
	if (exists(([Condition] c where c.code.coding[0].code.value= 'R41.0')P
			with [ServiceRequest]SR 
			such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value)) 
		or exists(([Condition] c where c.code.coding[0].code.value= 'F91.9')P
			with [ServiceRequest]SR 
			such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value)) 
		or exists(([Condition] c where c.code.coding[0].code.value= 'R53.83')P
			with [ServiceRequest]SR 
			such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value))
		or exists(([Condition] c where c.code.coding[0].code.value= 'R40.20')P
			with [ServiceRequest]SR 
			such that exists(SR.reasonReference R where Global."GetId"(R.reference.value)= P.id.value)))
	then true
	else false

define RelevantDiagnoses: 
	{
	if exists("Dialysis") then 'Dialysis' else null,
	if exists("RiskOfFalling") then 'Risk of falling off wheelchair or stretcher while in motion (not related to obesity)' else 'null',

	if exists("WoundCareCondition")  then 'Wound care' else null,

	if exists("RadiationTherapy")  then 'Radiation therapy' else 'null',

	if exists("ChemotherapyCondition")  then 'Chemotherapy' else 'null',

	if "BedConfined" then 'Bed confined (Unable to ambulate, Unable to get out of bed without assistance, Unable to safely sit in a chair or wheelchair)' else 'null',

	if "SittingPosition"  then 'Unable to maintain erect sitting position in a chair for time needed to transport, due to moderate muscular weakness and de-conditioning' else 'null',

	if exists("FracturesCondition")  then 'Non-healed fractures requiring ambulance' else 'null',

	if exists("Osteoarthritis")  then 'Incapacitating Osteoarthritis' else 'null',

	if "MuscularWeakness"  then 'Severe muscular weakness and de-conditioned state precludes any significant physical activity' else 'null',

	if exists("OrthopedicJointImplants")  then 'Orthopedic device required in transit' else 'null',

	if exists("Amputation")  then 'Amputation(s)' else 'null',

	if exists("CVAWithSequelae")  then 'CVA with sequelae (late effect of CVA) that impair mobility and result in be confinement' else 'null',

	if exists("DVT")  then 'DVT requires elevation of lower extremity' else 'null',

	if exists("DemyelinatingDisease")  then 'Progressive demyelinating disease' else 'null',

	if exists([Condition] c where c.code.coding[0].code.value ='R52')  then 'Moderate to severe pain on movement' else 'null',

	if "Ulcer" then 'Unable to sit in chair or wheelchair due to Grade II or greater decubitus ulcers on buttocks'  else 'null',

	if "MorbidObesity" then 'Morbid obesity requires additional personnel/equipment to handle' else 'null',

	if exists("IVMedications")  then 'IV medications/fluids required during transport' else 'null',

	if exists("Isolation")  then 'Special handling en route – isolation' else 'null',

	if "Danger" then 'Danger to self or others' else 'null',

	if "MentalCondition" then 'Confused, combative, lethargic, comatose' else 'null'

	} except('null')

define RiskOfFalling: 
	singleton from ([Observation] c where c.code.coding[0].code.value= 'V00.811')

/*define LocationFromObject:
	singleton from ([Location] l1 where  ('Location/' + l1.id.value) = "ServiceRequestObject".deliverFrom.reference.value)
	
define LocationToObject:
	singleton from ([Location] l2 where ('Location/' + l2.id.value) = "ServiceRequestObject".deliverTo.reference.value)
*/


define TransportFromAddressObject: singleton from (Patient.address[0])  

define TransportFrom: //'15208 West 119th Street, Olathe, KS, 66213'
	if exists(TransportFromAddressObject) then
	"TransportFromAddressObject".line[0].value +', ' +"TransportFromAddressObject".city.value +', ' +"TransportFromAddressObject".state.value+', ' +"TransportFromAddressObject".postalCode.value
	else ''

/*
define LocationToAddressObject: singleton from ("LocationToObject".address)  

define TransportTo: //'1234 Blvd, Overland Park, KS, 66213'
	if exists(LocationToAddressObject) then
	"LocationToAddressObject".line[0].value +', ' +"LocationToAddressObject".city.value +', ' +"LocationToAddressObject".state.value+', ' +"LocationToAddressObject".postalCode.value
	else ''
*/

define RoundTrip: false

define "ExpeditedRequestBoolean":
	true

//Requestor info
define Requestor: 
	Practitioner	 
	
define RequestorNameObject: 
	singleton from ("Requestor".name[0])
	
define RequestorName: 
	//PractitionerFirstName + ' '+ PractitionerMiddleInitial + ' '+ PractitionerLastName
	RequestorFirstName + ' '+ RequestorLastName

define RequestorLastName: "RequestorNameObject".family.value

define RequestorMiddleInitial: GetMiddleInitials("RequestorNameObject")

define RequestorFirstName: "RequestorNameObject".given[0].value

define RequestorTelephone: 
	if "Requestor".telecom[0] is not null then
	(singleton from (
  		"Requestor".telecom[0])).value.value
	else ''

define Typeofrequest: 
	'Initial'

define function GetMiddleInitials(name FHIR.HumanName):
  Substring(Combine((name.given given return Substring(given.value,0,1)),', '),3)


define function GetProcedure(ProcedureList List<Procedure>, ProcedureCode String):
  ProcedureList P where P.code.coding[0].code.value= ProcedureCode
