/**
 * Created by Piotr Kucia on 01.08.2018.
 */
({
    //lightning data service method to create new Request record
    doInit: function(component, event, helper) {
        // Prepare a new record from template
        component.find("requestRecordCreator").getNewRecord(
            "Request__c", // sObject type (objectApiName)
            null,      // recordTypeId
            false,     // skip cache?
            $A.getCallback(function() {
                var rec = component.get("v.newRequest");
                var error = component.get("v.newRequestError");
                if(error || (rec === null)) {
                    console.log("Error initializing record template: " + error);
                    return;
                }
                console.log("Record template initialized: " + rec.sobjectType);
            })
        );
    },
    //lightning data service method to create new Request record
    handleSaveRequest: function(component, event, helper) {
        var validRequest = component.find('requestform').reduce(function (validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);

        if(component.get('v.simpleNewRequest.Priority__c') == null) {
            validRequest = false;
            component.set('v.priorityErrorFlag', true);
        }

        if(validRequest) {
            component.set("v.simpleNewRequest.AccountId", component.get("v.recordId"));
            component.find("requestRecordCreator").saveRecord(function(saveResult) {
                if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                    // record is saved successfully
                    console.log("SUCCESS");
                    component.set('v.requestAddedFlag', true);
                    component.set('v.priorityErrorFlag', false);
                } else if (saveResult.state === "INCOMPLETE") {
                    // handle the incomplete state
                    console.log("User is offline, device doesn't support drafts.");
                } else if (saveResult.state === "ERROR") {
                    // handle the error state
                    console.log('Problem saving asset, error: ' + JSON.stringify(saveResult.error));
                } else {
                    console.log('Unknown problem, state: ' + saveResult.state + ', error: ' + JSON.stringify(saveResult.error));
                }
            });
        }
    },
    //sets confirmation flags to false and clears object
    clickCancel : function(component, event, helper) {
        component.set('v.requestAddedFlag', false);
        component.set('v.priorityErrorFlag', false);
        component.set("v.newRequest",{
                        'Name': '',
                        'Who__c': '',
                        'What__c': '',
                        'Priority__c': '',
                        'Reason__c': ''});
    }
})