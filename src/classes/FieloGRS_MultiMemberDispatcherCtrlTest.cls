@isTest
public class FieloGRS_MultiMemberDispatcherCtrlTest {

	@testSetup static void testSetup() {
		//Test Program Creation
        FieloPLT__Program__c testProgram = new FieloPLT__Program__c();
        testProgram.Name = 'Test Program';
        testProgram.FieloPLT__OnlineTransactionProcessing__c = true;
        testProgram.FieloGRS__GRSMemberFieldset__c = '[{"grsFieldName":"employeeId","sfFieldName":"Id"},{"grsFieldName":"firstName","sfFieldName":"FieloPLT__Contact__r.FirstName"},{"grsFieldName":"lastName","sfFieldName":"FieloPLT__Contact__r.LastName"},{"grsFieldName":"email","sfFieldName":"FieloPLT__Email__c"},{"grsFieldName":"address1","sfFieldName":"FieloPLT__Contact__r.MailingStreet"},{"grsFieldName":"city","sfFieldName":"FieloPLT__Contact__r.MailingCity"},{"grsFieldName":"postalCode","sfFieldName":"FieloPLT__Contact__r.MailingPostalCode"},{"grsFieldName":"provinceState","sfFieldName":"FieloPLT__Contact__r.MailingStateCode"},{"grsFieldName":"country","sfFieldName":"FieloPLT__Contact__r.MailingCountryCode"},{"grsFieldName":"telephone","sfFieldName":"FieloPLT__Contact__r.Phone"},{"grsFieldName":"language","sfFieldName":"FieloPLT__User__r.LanguageLocaleKey","isLocale":true}]';
        testProgram.FieloGRS__GRSMetadataFieldset__c = '[{"id":"tier", "name":"tier", "fieldName":"FieloPLT__CurrentLevelMember__r.FieloPLT__Level__r.Name"},{"id":"account_type", "name":"account_type", "dataValue":"test"}]';
        insert testProgram;

        FieloPLT__Level__c level = new FieloPLT__Level__c();
        level.FieloPLT__Program__c = testProgram.Id;
        level.name = 'Gold';
        insert level;

        //Program Point Type and Point Type Id
        FieloPLT__ProgramPointType__c ppt = [SELECT Id, FieloPLT__PointType__c, FieloPLT__RequestPointApproval__c FROM FieloPLT__ProgramPointType__c WHERE FieloPLT__Program__c =: testProgram.Id limit 1];
        ppt.FieloPLT__RequestPointApproval__c = true;
        update ppt;
        Id pointTypeId = ppt.FieloPLT__PointType__c;
        
        testProgram.FieloGRS__GRSPointType__c = pointTypeId;
        update testProgram;

        //Test Member Creation
        FieloPLT__Member__c testMember = new FieloPLT__Member__c();
        testMember.Name = 'Test Member';
        testMember.FieloPLT__Email__c = testMember.Name.deleteWhitespace() + '@fielo.com';
        testMember.FieloPLT__Program__c = testProgram.id;
        testMember.FieloPLT__User__c = UserInfo.getUserId();
        insert testMember;

        FieloPLT__LevelMember__c memberLevel = new FieloPLT__LevelMember__c();
        memberLevel.FieloPLT__Level__c = level.Id;
        memberLevel.FieloPLT__Member__c = testMember.Id;
        insert memberLevel;

        update new FieloPLT__Member__c(Id = testMember.Id,FieloPLT__CurrentLevelMember__c = memberLevel.Id);
	}

	public static testMethod void testSetCurrentMember() {
		Test.startTest();
		FieloPLT__Member__c member = FieloGRS_MultiMemberEventDispatcherCtrl.setCurrentMember((FieloPLT__Member__c)[SELECT Id, Name FROM FieloPLT__Member__c LIMIT 1]);
		Test.stopTest();
	}
}