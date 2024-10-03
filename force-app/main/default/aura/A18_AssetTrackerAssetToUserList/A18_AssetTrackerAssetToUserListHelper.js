/**
 * Created by Piotr Kucia on 06.08.18.
 */
({
    loadAssetUsers : function(component) {
        var action = component.get("c.getAssetUsers");
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