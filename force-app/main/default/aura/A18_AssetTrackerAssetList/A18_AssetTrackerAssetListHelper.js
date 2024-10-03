/**
 * Created by Piotr Kucia on 05.08.18.
 */
({
    loadAssets : function(component) {
        var action = component.get("c.getAssets");
        action.setCallback(this, function(response) {
        var state = response.getState();
        if (state === "SUCCESS") {
            component.set("v.assets", response.getReturnValue());
        } else {
            console.log("Failed with state: " + state);
        }
        });
        $A.enqueueAction(action);
    }
})