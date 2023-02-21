@isTest
public class LeadDuplicateTriggerTest {
    static testMethod void doLeadDuplicateTest() {
        Set<String> emailSet = new Set<String>();
        emailSet.add('tes01t@duptest.com');
        emailSet.add('test02@duptest.com');
        emailSet.add('test03@duptest.com');
        emailSet.add('test04@duptest.com');
        System.assert([SELECT count() FROM Lead WHERE Email IN:emailSet] == 0);

        //insert the database with some lead and make sure lead can be inserted using bulk successfully
        Lead lead01 = new Lead (LastName = 'Test01', Company='Company01', Email='test01@duptest.com');
        Lead lead02 = new Lead (LastName = 'Test02', Company='Company02', Email='test06@duptest.com');
        Lead lead03 = new Lead (LastName = 'Test03', Company='Company03', Email='test07@duptest.com');
        Lead lead04 = new Lead (LastName = 'Test04', Company='Company04', Email='test08@duptest.com');
        Lead[] leads = new Lead[]{lead01,lead02, lead03, lead04};
        insert leads;

        //now make sure that those lead above can be change (the email). lead 01 is not being change but still being pass to update call.
        lead02.Email = 'test02@duptest.com';
        lead03.Email = 'test03@duptest.com';
        lead04.Email = 'test04@duptest.com';
        update leads;

        //make sure that single ro lead duplicate prevention works on insert
        Lead dup01 = new Lead(LastName = 'Test01Dup', Company='CompanyDup01', Email='test01@duptest.com');
        insert dup01;
    }

}
