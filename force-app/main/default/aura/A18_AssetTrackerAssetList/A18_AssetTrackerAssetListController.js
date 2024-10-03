/**
 * Created by Piotr Kucia on 03.08.2018.
 */
({
    //gets list of assets from backend (json format)
    init : function(component, event, helper) {
        helper.loadAssets(component);
    },
    //displays add asset form modal
    showModal : function(component, event, handler) {
        var childComponent = component.find("assetModal");
        childComponent.toggleModal();
    },
    handleAddAsset : function(component, event, helper) {
        var newAsset = event.getParam("newAsset");
        var action = component.get("c.addAsset");
        var newAssetJSONString = JSON.stringify(newAsset);
        action.setParams({
            "dtoString": newAssetJSONString
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var childComponent = component.find('assetModal');
                childComponent.notifySuccess();
                component.set('v.assets', []);
                component.set('v.changeFlag', !component.get('v.changeFlag'));
            } else {
                console.log("Failed with state: " + state);
                var childComponent = component.find('assetModal');
                childComponent.notifyError();
            }
        });
        $A.enqueueAction(action);
    },
    handleEditAsset : function(component, event, helper) {
        var newAsset = event.getParam("newAsset");
        var action = component.get("c.updateAsset");
        var newAssetJSONString = JSON.stringify(newAsset);
        action.setParams({
            "dtoString": newAssetJSONString
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.assets', []);
                component.set('v.changeFlag', !component.get('v.changeFlag'));
            } else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },
    handleDeleteAsset : function(component, event, helper) {
        var assetId = event.getParam("assetId");
        var action = component.get("c.deleteAsset");
        action.setParams({
            "assetId": assetId
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.assets', []);
                component.set('v.changeFlag', !component.get('v.changeFlag'));
            } else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },
    //gets list of searched assets
    assetSearch : function(component, event, helper) {
        var searchPhrase = component.get('v.assetSearchPhrase');
        var action = component.get("c.searchAssets");
        action.setParams({
            "searchPhrase" : searchPhrase,
            "recordTypeId" : null
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.assets", response.getReturnValue());
            } else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },
})