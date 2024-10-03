/**
 * Created by Piotr Kucia on 06.08.18.
 */
({
    //checks if the form is valid and sends event if so
    handleAddAssetUser : function(component, event, helper) {
        var validAssetUser = component.find('assetuserform').reduce(function (validSoFar, inputCmp) {
          inputCmp.showHelpMessageIfInvalid();
          return validSoFar && inputCmp.get('v.validity').valid;
        }, true);

        if(validAssetUser) {
          var newAssetUser = component.get("v.newAssetUser");
          var createEvent = component.getEvent("addAssetUser");
          createEvent.setParams({ "newAssetUser": newAssetUser });
          createEvent.fire();
        }

        component.set('v.assetUserAddedFlag', false);
        component.set('v.assetUserErrorFlag', false);
    },
    //checks if the form is valid and sends event if so
    handleEditAssetUser : function(component, event, helper) {
        var validAssetUser = component.find('assetuserform').reduce(function (validSoFar, inputCmp) {
          inputCmp.showHelpMessageIfInvalid();
          return validSoFar && inputCmp.get('v.validity').valid;
        }, true);

        if(validAssetUser) {
          var newAssetUser = component.get("v.newAssetUser");
          var createEvent = component.getEvent("editAssetUser");
          createEvent.setParams({ "newAssetUser": newAssetUser });
          createEvent.fire();
        }
    },
    //sets confirmation flags to false
    clickCancel : function(component, event, helper) {
        component.set('v.assetUserAddedFlag', false);
        component.set('v.assetUserErrorFlag', false);
    },
    //gets asset/user id from lookup relation
    handleAssetSelect : function(component, event, helper) {
         var asset = event.getParam("recordByEvent");
         component.set('v.newAssetUser.asset', asset.Id);
    },
    handleUserSelect : function(component, event, helper) {
         var user = event.getParam("recordByEvent");
         component.set('v.newAssetUser.user', user.Id);
    },
    handleClearAsset : function(component, event, helper) {
         component.set('v.newAssetUser.asset', '');
    },
    handleClearUser : function(component, event, helper) {
         component.set('v.newAssetUser.user', '');
    },
    notifySuccess : function(component, event, helper) {
        component.set('v.assetUserAddedFlag', true);
    },
    notifyError : function(component, event, helper) {
        component.set('v.assetUserErrorFlag', true);
    },
})