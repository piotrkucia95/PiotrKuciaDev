/**
 * Created by Piotr Kucia on 23.07.2018.
 */
({
    createAsset : function(component, newAsset) {
        var action = component.get("c.addAsset");
        var newAssetJSONString = JSON.stringify(newAsset);

        action.setParams({
            "dtoString": newAssetJSONString
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {}
            else console.log("Failed with state: " + state);
        });
        $A.enqueueAction(action);
    },
})