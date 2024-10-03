/**
 * Created by Piotr Kucia on 23.07.2018.
 */
({
    clickAdd: function(component, event, helper) {
        var newAsset = component.get("v.newAsset");
        newAsset.isBroken = false;
        if(newAsset.name != null){
            helper.createAsset(component, newAsset);
        } else {}
    },
    clickCancel : function(component, event, helper) {
        component.set("v.newAsset",{
                        'name': '',
                        'description': '',
                        'dueDate': '',
                        'invoiceNumber': '',
                        'price': ''});
    },
})