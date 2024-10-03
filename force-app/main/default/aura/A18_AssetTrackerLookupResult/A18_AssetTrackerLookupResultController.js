/**
 * Created by Piotr Kucia on 09.08.18.
 */

({
    selectRecord : function(component, event, helper){
        // get the selected record from list
        var getSelectRecord = component.get("v.oRecord");
        if(component.get('v.objectAPIName') == 'asset__c') {
            var compEvent = component.getEvent("oSelectedAssetEvent");
            compEvent.setParams({"recordByEvent" : getSelectRecord });
            compEvent.fire();
        } else {
            var compEvent = component.getEvent("oSelectedUserEvent");
            compEvent.setParams({"recordByEvent" : getSelectRecord });
            compEvent.fire();
        }
    },
})