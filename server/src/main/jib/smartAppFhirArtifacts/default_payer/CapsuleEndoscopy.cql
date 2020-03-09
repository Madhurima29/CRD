library CapsuleEndoscopy
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

//Crohn's Disease
code "K50.00" : 'K50.00' from "ICD-10-CM"

//Small Bowel Tumours
code "C17.9" : 'C17.9' from "ICD-10-CM"

//Colon Capsule Endoscopy
code "107940005" : '107940005' from "SNOMED-CT"

//Esophaegal Capsule Endoscopy
code "Z13.810" : 'Z13.810' from "ICD-10-CM"

//Patency Capsule
code "Z18.89" : 'Z18.89' from "ICD-10-CM"

//Peutz-Jehgers Syndrome
code "Q85.8" : 'Q85.8' from "ICD-10-CM"

//Juvenile Polyposis Syndrome
code "D12.6" : 'D12.6' from "ICD-10-CM"

//Gastrointestinal Bleeding
code "K92.2" : 'K92.2' from "ICD-10-CM"

//Celiac Disease
code "K90.0" : 'K90.0' from "ICD-10-CM"

parameter "Measurement Period" Interval<DateTime>

context Patient
	
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

define BeneficiaryIdentificationNumber: 
	if exists("Coverage Subscriber") then
	(Last(
  	"Coverage Subscriber".identifier identifier
   	where identifier.system.value ='urn:oid:1.1.1.1.1.1' or identifier.system.value ='urn:oid:2.16.840.1.113883.3.787.0.0' or identifier.system.value ='http://hl7.org/fhir/sid/us-medicare' or identifier.system.value ='urn:oid:2.2.2.2.2.2')).value.value
	else ''


// Practitioner info

//define "Encounter resource": 
//	(singleton from([Encounter]E where (Last(E.participant p where p.individual is not null) is not null)))enc
//	return enc.participant

//define "Encounter participant":
//	Last(("Encounter resource" p where p.type is not null)P
//		sort by start of period)

define "Encounter resource": 
	(Last([Encounter]E sort by start of period)).participant

define "Encounter participant":
	"Encounter resource"

define Practitioner: //Last([Practitioner])
	if "Encounter participant" is not null then
	Last(
  		[Practitioner]practitioner 
			with "Encounter participant" E
    		such that ('Practitioner/' + practitioner.id.value) = E.individual.reference.value)
	else Last([Practitioner])
    
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
    		where identifier.system.value = 'http://hl7.org.fhir/sid/us-npi')).value.value

define PractitionerPTAN:
	(singleton from (
  		"Practitioner".identifier identifier
    		where identifier.type.coding[0].system.value = 'http://terminology.hl7.org/CodeSystem/v2-0203' and identifier.type.coding[0].code.value = 'TAX')).value.value

define PractitionerAddressObject: 
	if exists("Practitioner".address) then
	singleton from ("Practitioner".address[0]) else null  

define PractitionerAddress: 
	if exists("PractitionerAddressObject") then
	"PractitionerAddressObject".line[0].value +', ' +"PractitionerAddressObject".city.value +', ' +"PractitionerAddressObject".state.value+', ' +"PractitionerAddressObject".postalCode.value
	else ''


//Diagnoses
define "Crohn's Disease Code":
	if exists([Condition]P
		where P.code.coding[0].code.value= 'K50.00' 
			) then 'Crohns Disease'
	else ''

define "Celiac Disease Code":
	if exists([Condition]P
		where P.code.coding[0].code.value= 'K90.0' 
			) then ', Celiac Disease'
	else ''

define "Gastrointestinal Bleeding Code":
	if exists([Condition]P
		where P.code.coding[0].code.value= 'K92.2' 
			) then ', Gastrointestinal Bleeding'
	else ''

define "Juvenile Polyposis Syndrome Code":
	if exists([Condition]P
		where P.code.coding[0].code.value= 'D12.6' 
			) then ', Juvenile Polyposis Syndrome'
	else ''

define "Peutz-Jehgers Syndrome Code":
	if exists([Condition]P
		where P.code.coding[0].code.value= 'Q85.8' 
			) then ', Peutz-Jehgers Syndrome'
	else ''

define "Patency Capsule Code":
	if exists([Condition]P
		where P.code.coding[0].code.value= 'Z18.89' 
			) then ', Patency Capsule'
	else ''

define "Small Bowel Tumours Code":
	if exists([Condition]P
		where P.code.coding[0].code.value= 'C17.9' 
			) then ', Small Bowel Tumours'
	else ''

define "Colon Capsule Endoscopy Code":
	if exists([Condition]P
		where P.code.coding[0].code.value= '107940005' 
			) then ', Colon Capsule Endoscopy'
	else ''

define "Esophaegal Capsule Endoscopy Code":
	if exists([Condition]P
		where P.code.coding[0].code.value= 'Z13.810' 
			) then ', Esophaegal Capsule Endoscopy'
	else ''

define "Intestinal Disease":
	"Esophaegal Capsule Endoscopy Code"+"Colon Capsule Endoscopy Code"+"Small Bowel Tumours Code"+"Patency Capsule Code"+"Peutz-Jehgers Syndrome Code"+"Juvenile Polyposis Syndrome Code"+"Gastrointestinal Bleeding Code"+"Celiac Disease Code"+"Crohn's Disease Code"

define "Date of Onset": 
	//if exists([Encounter]) then
	Last([Encounter]).period.start.value


//Requestor info
define Requestor: 
	Practitioner	 
	
define RequestorNameObject: 
	singleton from ("Requestor".name[0])
	
define SubmitterName: 
	//PractitionerFirstName + ' '+ PractitionerMiddleInitial + ' '+ PractitionerLastName
	RequestorFirstName + ' '+ RequestorLastName

define RequestorLastName: "RequestorNameObject".family.value

define RequestorMiddleInitial: GetMiddleInitials("RequestorNameObject")

define RequestorFirstName: "RequestorNameObject".given[0].value

define SubmitterTelephone: 
	if "Requestor".telecom[0] is not null then
	(singleton from (
  		"Requestor".telecom[0])).value.value
	else ''

define function GetMiddleInitials(name FHIR.HumanName):
  Substring(Combine((name.given given return Substring(given.value,0,1)),', '),3)

define function GetProcedure(ProcedureList List<Procedure>, ProcedureCode String):
  ProcedureList P where P.code.coding[0].code.value= ProcedureCode
