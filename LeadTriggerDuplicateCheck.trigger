trigger LeadTriggerDuplicateCheck on Lead (before insert, before update) {

    //sets to store value to check for duplicates
    Set<String> emailSet = new Set<String>();

    // add values to the set
    for (Lead llead : Trigger.new) {
        if(llead.Email != null && llead.Email != '') {
            emailSet.add(llead.Email);
        }

    }

    //construct the query
    String queryEmail = 'SELECT Email, suploLocation__SICCode__c FROM Lead WHERE Email IN : emailSet';

    //List to Store records lead
    List<Lead> existingleadList = new List<Lead>();

    //get existing record that match criteria
    existingleadList = Database.query(queryEmail);

    //if there are duplication
    if (existingleadList.size() > 0){
        for (Lead newLead : Trigger.new) {
            for (Lead existinglead : existingleadList) {
                if(newLead.Email == existingLead.Email) {
                    newLead.Description = 'this is duplicate!!!'; //give explanation in description field
                }

            }
        }
    }

}
