/**
 * Created by Piotr Kucia on 02.08.2018.
 */
({
    //parses json to lightning object
    init : function(component, event, helper) {
        var assetObject = JSON.parse(component.get('v.assetJSON'));
        component.set('v.asset', assetObject);
    },
    //creates event informing about checking 'is broken' toggle
    markAsBroken : function(component, event, helper) {
        var asset = component.get("v.asset");
        var createEvent = component.getEvent("assetBroken");
        createEvent.setParams({ "asset": asset });
        createEvent.fire();
    }
})