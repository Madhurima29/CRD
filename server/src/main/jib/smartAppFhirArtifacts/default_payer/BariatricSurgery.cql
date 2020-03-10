library BariatricSurgery
using FHIR version '4.0.0'
include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'
codesystem "NUCCPT":'https://www.nlm.nih.gov/research/umls/sourcereleasedocs/current/NUCCPT/sourcerepresentation.html'

valueset "Body mass index [BMI]":'2.16.840.1.113883.6.103'
valueset "Co-morbid conditions (finding)":'2.16.840.1.113883.3.88.12.3221.7.4'
valueset "Body mass index 30+ - obesity (finding)":'2.16.840.1.113883.3.88.12.3221.7.4'
valueset "Obesity (disorder)":'2.16.840.1.113883.3.88.12.3221.7.4'
valueset "Absence of therapeutic response (finding)":'2.16.840.1.113883.3.88.12.3221.7.4'
valueset "Laparoscopic adjustable gastric banding (procedure)":'2.16.840.1.113883.3.88.12.80.28'
valueset "Laparoscopic sleeve gastrectomy (procedure)":'2.16.840.1.113883.3.88.12.80.28'
valueset "Gastric stapling for obesity (procedure)":'2.16.840.1.113883.3.88.12.80.28'
valueset "Stapling of stomach (procedure)":'2.16.840.1.113883.3.88.12.80.28'
valueset "Intestinal bypass for morbid obesity (procedure)":'2.16.840.1.113883.3.88.12.80.28'
valueset "Insertion of gastric balloon (procedure)":'2.16.840.1.113883.3.88.12.80.28'
valueset "Bariatric operative procedure (procedure)":'2.16.840.1.113883.3.88.12.80.28'

code "Weight": '3141-9' from "LOINC" display 'Weight'
code "Height": '3137-7' from "LOINC" display 'Height'
code "BMI": '39156-5' from "LOINC" display 'BMI'
code "E66.01" : 'E66.01' from "ICD-10-CM"
code "E66.2" : 'E66.2' from "ICD-10-CM"
code "E11.9" : 'E11.9' from "ICD-10-CM"
code "I51.9" : 'I51.9' from "ICD-10-CM"
code "I25.10" : 'I25.10' from "ICD-10-CM"
code "G47.33": 'G47.33' from "ICD-10-CM"

parameter "Measurement Period" Interval<DateTime>

context Patient

define "F2FEncounterCodes": { '99354', '99355', '99356', '99357' }

define "BariatricSurgeryCodes": { '0312T', '0313T', '0314T', '0315T', '0316T', '0317T', '43644', '43645', '43647', '43648', '43659', '43770', '43771', '43772', '43773', '43774', '43775', '43842','43843', '43845', '43846', '43847', '43848', '43881', '43882', '43886', '43887', '43888,', '64590', '64595', '43860', '43865'}
   
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
//Other info

//define PerformedType: {'Initial'}

define "Class3Obesity":
{
if exists([Condition]P where P.code.coding[0].code.value ='E66.01' and (P.onset as Period) starts during "Measurement Period") then 'Class 3 Obesity' else '',
if exists([Condition]P where P.code.coding[0].code.value ='E66.2' and (P.onset as Period) starts during "Measurement Period") then 'Class 2 Obesity' else ''
}

define "SecondaryDiagnosis":
{
if exists([Condition]P where P.code.coding[1].code.value ='E11.9' and (P.onset as Period) starts during "Measurement Period") then 'Type 2 Diabetes' else '',
if exists([Condition]P where P.code.coding[1].code.value ='I51.9' and (P.onset as Period) starts during "Measurement Period") then 'Cardiovascular Disease' else '',
if exists([Condition]P where P.code.coding[1].code.value ='I25.10' and (P.onset as Period) starts during "Measurement Period") then 'Coronary Artery Disease' else '',
if exists([Condition]P where P.code.coding[1].code.value ='G47.33' and (P.onset as Period) starts during "Measurement Period") then 'Obstructive Sleep Apnea' else ''
}

//define "Co-morbidities": {'Cardiac disease'}

define Facility:
if exists([Organization]) and Last([Encounter]) is not null then
singleton from (
  [Organization]org
    where ('Organization/' + org.id.value) = Last([Encounter]).serviceProvider.reference.value)
else null

define FacilityName:
if exists("Facility") then "Facility".name.value else ''

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
