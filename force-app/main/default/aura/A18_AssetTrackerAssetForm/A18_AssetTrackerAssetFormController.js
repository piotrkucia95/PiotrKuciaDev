/**
 * Created by Piotr Kucia on 04.08.18.
 */
({
    //TODO Dropdown lists for asset id and user id

    //checks if the form is valid and sends event if so
    handleAddAsset : function(component, event, helper) {
        var validAsset = component.find('assetform').reduce(function (validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);

        if(validAsset) {
            var newAsset = component.get("v.newAsset");
            var createEvent = component.getEvent("addAsset");
            createEvent.setParams({ "newAsset": newAsset });
            createEvent.fire();
        }
    },
    //checks if the form is valid and sends event if so
    handleEditAsset : function(component, event, helper) {
        var validRequest = component.find('assetform').reduce(function (validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);

        if(validRequest) {
            var newAsset = component.get("v.newAsset");
            var createEvent = component.getEvent("editAsset");
            createEvent.setParams({ "newAsset": newAsset });
            createEvent.fire();
        }
    },
    //sets confirmation flags to false
    clickCancel : function(component, event, helper) {
        component.set('v.assetAddedFlag', false);
        component.set('v.assetErrorFlag', false);
    },
    notifySuccess : function(component, event, helper) {
        component.set('v.assetAddedFlag', true);
    },
    notifyError : function(component, event, helper) {
        component.set('v.assetErrorFlag', true);
    },
})