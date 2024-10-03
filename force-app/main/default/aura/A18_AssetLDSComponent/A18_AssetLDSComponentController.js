/**
 * Created by Piotr Kucia on 24.07.2018.
 */

({
    doInit: function(component, event, helper) {
        // Prepare a new record from template
        component.find("assetRecordCreator").getNewRecord(
            "Asset__c", // sObject type (objectApiName)
            null,      // recordTypeId
            false,     // skip cache?
            $A.getCallback(function() {
                var rec = component.get("v.newAsset");
                var error = component.get("v.newAssetError");
                if(error || (rec === null)) {
                    console.log("Error initializing record template: " + error);
                    return;
                }
            })
        );
    },
    handleSaveAsset: function(component, event, helper) {
        component.set("v.simpleNewAsset.AccountId", component.get("v.recordId"));
        component.find("assetRecordCreator").saveRecord(function(saveResult) {
            if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
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
    },
    clickCancel : function(component, event, helper) {
        component.set("v.newAsset",{
                        'Name': '',
                        'Description__c': '',
                        'Due_Date__c': '',
                        'Invoice_Number__c': '',
                        'Price': ''});
    }
})