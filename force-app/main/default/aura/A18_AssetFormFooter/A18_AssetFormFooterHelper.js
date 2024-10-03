/**
 * Created by Piotr Kucia on 23.07.2018.
 */
({
    createAsset: function(component, newAsset) {
        var createEvent = component.getEvent("addAsset");
        createEvent.setParams({ "newAsset": newAsset });
        createEvent.fire();
    },
})