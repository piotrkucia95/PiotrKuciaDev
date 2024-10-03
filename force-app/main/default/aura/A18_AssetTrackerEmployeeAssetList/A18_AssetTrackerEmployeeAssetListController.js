/**
 * Created by Piotr Kucia on 01.08.2018.
 */
({
    //gets assets assigned to user when gets information of user from header
    handleUserChange : function(component, event, helper) {
        var action = component.get("c.getAssetsAssignedToUser");
        var userId = component.get('v.user.Id');
        action.setParams({
            "userId": userId
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.myAssets", response.getReturnValue());
            } else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },
    //gets user info from event sent by header
    handleUserInfoEvent : function(component, event, handler) {
        var user = event.getParam("user");
        component.set("v.user", user);
    },
    //updates asset when gets event send by specific list item
    handleAssetBroken : function(component, event, helper) {
        var assetJSON = JSON.stringify(event.getParam("asset"));
        var action = component.get("c.updateAsset");
        action.setParams({
            "dtoString": assetJSON
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {}
            else console.log("Failed with state: " + state);
        });
        $A.enqueueAction(action);
    }
})