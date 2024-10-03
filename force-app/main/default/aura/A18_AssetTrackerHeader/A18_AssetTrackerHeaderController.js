/**
 * Created by Piotr Kucia on 30.07.2018.
 */
({
    //gets info about currently logged user - who is this and the group he belongs to
    init : function(component, event, helper) {
        var action1 = component.get("c.getCurrentUser");
        var action2 = component.get("c.checkUserGroup");

        action1.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.userWrapper.user", response.getReturnValue());
            } else {
                console.log("Failed with state: " + state);
            }
        });
        action2.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.userWrapper.userType", response.getReturnValue());
            } else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action1);
        $A.enqueueAction(action2);
    },
    //when user info is loaded sends application event
    handleUserWrapperChange : function(component, event, helper) {
        var userWrapper = component.get('v.userWrapper');
        if(!$A.util.isUndefinedOrNull(userWrapper.user) && !$A.util.isEmpty(userWrapper.userType)){
            var userEvent = $A.get("e.c:A18_AssetTrackerUserInfoEvent");
            var user = component.get("v.userWrapper.user");
            var userType = component.get("v.userWrapper.userType");
            userEvent.setParam("userType", userType);
            userEvent.setParam("user", user);
            userEvent.fire();
        }
    },
    logOut : function (component, event, helper) {
        window.location.replace("https://pkucia-developer-edition.eu10.force.com/AssetTrackerCommunity/servlet/networks/switch?startURL=%2Fsecur%2Flogout.jsp");
    },
    goToSalesforce : function (component, event, helper) {
        window.open("https://pkucia-dev-ed.lightning.force.com/", '_blank');
    },
    goToPolsource : function (component, event, helper) {
        window.open("http://www.polsource.com", '_blank');
    },
    goHome : function (component, event, helper) {
        window.location.replace("https://pkucia-developer-edition.eu10.force.com/AssetTrackerCommunity/s");
    },
    goMyAssets : function (component, event, helper) {
        window.location.replace("https://pkucia-developer-edition.eu10.force.com/AssetTrackerCommunity/s/my-assets");
    },
    goAssets : function (component, event, helper) {
        window.location.replace("https://pkucia-developer-edition.eu10.force.com/AssetTrackerCommunity/s/assets");
    },
    goAssetUsers : function (component, event, helper) {
        window.location.replace("https://pkucia-developer-edition.eu10.force.com/AssetTrackerCommunity/s/assets-to-users");
    },
    goRequests : function (component, event, helper) {
        window.location.replace("https://pkucia-developer-edition.eu10.force.com/AssetTrackerCommunity/s/requests");
    },
})