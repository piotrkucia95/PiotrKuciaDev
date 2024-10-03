/**
 * Created by Piotr Kucia on 01.08.2018.
 */
({
    //displays/hides modal
    toggleModal : function(component, event, helper){
        var modalVisible = component.get('v.modalVisible');
        modalVisible = !modalVisible;
        component.set("v.modalVisible", modalVisible);
        if(!modalVisible ) {
            if(component.get('v.objectType') == 'Request') var childComponent = component.find("requestForm");
            else if(component.get('v.objectType') == 'Asset') var childComponent = component.find("assetForm");
            else if(component.get('v.objectType') == 'Asset To User') var childComponent = component.find("assetToUserForm");
            childComponent.handleCancel();
        }
    },
    //activates aura:method from request form
    saveRequest : function(component, event, helper) {
        var childComponent = component.find("requestForm");
        childComponent.handleSaveRequest();
    },
    //activates aura:method from asset form
    addAsset : function(component, event, helper) {
        var childComponent = component.find("assetForm");
        childComponent.handleAddAsset();
    },
    //activates aura:method from asset form
    editAsset : function(component, event, helper) {
        var childComponent = component.find("assetForm");
        childComponent.handleEditAsset();
        component.set('v.editFlag', false);
    },
    //activates aura:method from asset to user form
    addAssetUser : function(component, event, helper) {
        var childComponent = component.find("assetToUserForm");
        childComponent.handleAddAssetUser();
    },
    //activates aura:method from asset to user form
    editAssetUser : function(component, event, helper) {
        var childComponent = component.find("assetToUserForm");
        childComponent.handleEditAssetUser();
        component.set('v.editFlag', false);
    },
    notifySuccess : function(component, event, helper) {
        var objectType = component.get('v.objectType');
        if(objectType == 'Asset') {
            var childComponent = component.find("assetForm");
            childComponent.notifySuccess();
        } else if(objectType == "Asset To User") {
            var childComponent = component.find("assetToUserForm");
            childComponent.notifySuccess();
        }
    },
    notifyError : function(component, event, helper) {
        var objectType = component.get('v.objectType');
        if(objectType == 'Asset') {
            var childComponent = component.find("assetForm");
            childComponent.notifyError();
        } else if(objectType == "Asset To User") {
            var childComponent = component.find("assetToUserForm");
            childComponent.notifyError();
        }
    },
})