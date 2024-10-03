({
    init: function (cmp, event, helper) {
        var headerActions = [
            {
                label: 'All',
                checked: true,
                name:'all'
            },
            {
                label: 'Published',
                checked: false,
                name:'show_published'
            },
            {
                label: 'Unpublished',
                checked: false,
                name:'show_unpublished'
            },
        ];
         var actions = helper.getRowActions.bind(this, cmp);
         cmp.set('v.columns', [
             { label: 'Name', fieldName: 'Name', type: 'text', sortable:true },
             { label: 'Title', fieldName: 'Title', type: 'text', sortable:true },
             { label: 'Phone', fieldName: 'Phone', type: 'phone', sortable:true },
             { label: 'Email', fieldName: 'Email', type: 'email', sortable:true },
             { type: 'action', typeAttributes: { rowActions: actions } }
         ]);
          helper.onInit(cmp, event, helper);
     },
     handleRowAction: function (cmp, event, helper) {
        var action = event.getParam('action');
        var row = event.getParam('row');
        switch (action.name) {
            case 'activate':
                helper.activateContact(cmp, row)
                break;
            case 'deactivate':
                helper.deactivateContact(cmp, row);
                break;
            case 'Delete':
                helper.deleteContact(cmp, row);
                break;
            case  'Edit' :
                helper.editContact(cmp, row);
                break;
            case 'Show_Details' :
                helper.showDetails(cmp, row);
                break;
        }
    },
    // Client-side controller called by the onsort event handler
    updateColumnSorting: function (cmp, event, helper) {
        var fieldName = event.getParam('fieldName');
        var sortDirection = event.getParam('sortDirection');
        var tableComp = cmp.find('contactTable');
        // assign the latest attribute with the sorted column fieldName and sorted direction
        tableComp.set("v.sortedBy", fieldName);
        tableComp.set("v.sortedDirection", sortDirection);
        helper.sortData(cmp, fieldName, sortDirection);
    }
})