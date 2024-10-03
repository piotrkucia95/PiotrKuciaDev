/**
 * Created by Piotr Kucia on 16.07.2018.
 */
//example trigger
trigger OpportunityTrigger on Opportunity (before update) {
    for(Opportunity newOpportunity : Trigger.new){
        Opportunity oldOpportunity = Trigger.oldMap.get(newOpportunity.Id);

        if(oldOpportunity.StageName == 'Closed Won'){
            newOpportunity.addError('You cannot edit that record!');
        }
    }
}