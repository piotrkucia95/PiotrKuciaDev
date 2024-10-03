/**
 * Created by Piotr Kucia on 06.08.18.
 */
({
    //parses json asset to user to lightning object
    init : function(component, event, helper) {
        var assetUserObject = JSON.parse(component.get('v.assetUserJSON'));
        component.set('v.assetUser', assetUserObject);
    },
    //displays edit modal
    showEditModal : function(component, event, helper) {
        var modalVisible = !component.get('v.editModalVisible');
        component.set('v.editModalVisible', modalVisible);
    },
    //displays delete modal
    showDeleteModal : function(component, event, helper) {
        var modalVisible = !component.get('v.deleteModalVisible');
        component.set('v.deleteModalVisible', modalVisible);
        component.set('v.assetUserDeletedFlag', false);
    },
    //creates event to informing about asset to user deletion
    deleteAssetUser : function(component, event, helper) {
        var assetUser = component.get('v.assetUser');
        component.set('v.assetUserDeletedFlag', true);
        var createEvent = component.getEvent("deleteAssetUser");
        createEvent.setParams({ "assetUserId": assetUser.id });
        createEvent.fire();
    },
})