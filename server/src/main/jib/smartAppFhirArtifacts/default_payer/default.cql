library Default
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

define PractitionerAddressObject: 
	if exists("Practitioner".address) then
	singleton from ("Practitioner".address[0]) else null  

define PractitionerAddress: 
	if exists("PractitionerAddressObject") then
	"PractitionerAddressObject".line[0].value +', ' +"PractitionerAddressObject".city.value +', ' +"PractitionerAddressObject".state.value+', ' +"PractitionerAddressObject".postalCode.value
	else ''


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
