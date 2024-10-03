/**
 * Created by Piotr Kucia on 06.08.18.
 */
({
    //gets asset to user list fromm backend (json)
    init : function(component, event, helper) {
        helper.loadAssetUsers(component);
    },
    //displays add asset to user modal
    showModal : function(component, event, handler) {
        var childComponent = component.find("assetUserModal");
        childComponent.toggleModal();
    },
    handleAddAssetUser : function(component, event, helper) {
        var newAssetUser = event.getParam("newAssetUser");
        var action = component.get("c.addAssetUser");
        var newAssetUserJSON = JSON.stringify(newAssetUser);
        action.setParams({
            "dtoString": newAssetUserJSON
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var childComponent = component.find('assetUserModal');
                childComponent.notifySuccess();
                component.set('v.assetUsers', []);
                component.set('v.changeFlag', !component.get('v.changeFlag'));
            } else {
                console.log("Failed with state: " + state);
                var childComponent = component.find('assetUserModal');
                childComponent.notifyError();
            }
        });
        $A.enqueueAction(action);
    },
    handleEditAssetUser : function(component, event, helper) {
        var newAssetUser = event.getParam("newAssetUser");
        var action = component.get("c.updateAssetUser");
        var newAssetUserJSON = JSON.stringify(newAssetUser);
        console.log(newAssetUserJSON);
        action.setParams({
            "dtoString": newAssetUserJSON
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.assetUsers', []);
                component.set('v.changeFlag', !component.get('v.changeFlag'));
            } else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },
    handleDeleteAssetUser : function(component, event, helper) {
        var assetUserId = event.getParam("assetUserId");
        var action = component.get("c.deleteAssetUser");
        action.setParams({
            "assetToUserId": assetUserId
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.assetUsers', []);
                component.set('v.changeFlag', !component.get('v.changeFlag'));
            } else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },
    //gets searched assets to users from backend (json)
    assetUserSearch : function(component, event, helper) {
        var searchPhrase = component.get('v.assetUserSearchPhrase');
        var action = component.get("c.searchAssetUsers");
        action.setParams({
            "searchPhrase" : searchPhrase,
            "status" : null
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.assetUsers", response.getReturnValue());
            } else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },
})