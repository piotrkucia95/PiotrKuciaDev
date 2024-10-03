/**
 * Created by Piotr Kucia on 23.07.2018.
 */
({
    doInit: function(component, event, helper) {
        var action1 = component.get("c.getCurrentUser");
        var action2 = component.get("c.checkUserGroup");
        action1.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.user", response.getReturnValue());
            } else {
                console.log("Failed with state: " + state);
            }
        });
        action2.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.userType", response.getReturnValue());
            } else {
                console.log("Failed with state: " + state);
            }
        });

        $A.enqueueAction(action1);
        $A.enqueueAction(action2);
    },
    handleAddAsset : function(component, event, helper) {
        var newAsset = event.getParam("newAsset");
        helper.createAsset(component, newAsset);
        component.set("v.newAsset",{
                                'name': '',
                                'description': '',
                                'dueDate': '',
                                'invoiceNumber': '',
                                'price': '',
                                'purchaseDate': ''});
    },
})