({
    onInit : function(component, event, helper) {
        var action = component.get('c.fetchContcts');
        action.setCallback(this, function(response){
            var responseValue = response.getReturnValue();
            component.set('v.conList', responseValue);
        });
        $A.enqueueAction(action);
    },
    getRowActions: function (cmp, row, doneCallback) {
        var actions = [];
        actions.push({
            'label': 'Edit',
            'iconName': 'action:edit',
            'name': 'Edit'
        });
        actions.push({
            'label': 'Delete',
            'iconName': 'action:delete',
            'name': 'Delete'
        });
        actions.push({
            'label': 'Show Details',
            'iconName': 'action:preview',
            'name': 'Show_Details'
        });
        /*if (row['isActive__c']) {
            actions.push({
                'label': 'Deactivate',
                'iconName': 'utility:block_visitor',
                'name': 'deactivate'
            });
        } else {
            actions.push({
                'label': 'Activate',
                'iconName': 'utility:adduser',
                'name': 'activate'
            });
        }*/
        // simulate a trip to the server
        setTimeout($A.getCallback(function () {
            doneCallback(actions);
        }), 200);
    },
    activateContact: function (cmp, row) {
        var rows = cmp.get('v.conList');
        var rowIndex = rows.indexOf(row);
        rows[rowIndex]['isActive__c'] = true;
        rows[rowIndex]['active'] = 'Active';
        cmp.set('v.conList', rows);
    },
    deactivateContact: function (cmp, row) {
        var rows = cmp.get('v.conList');
        var rowIndex = rows.indexOf(row);
        rows[rowIndex]['isActive__c'] = false;
        rows[rowIndex]['active'] = 'Inactive';
        cmp.set('v.conList', rows);
    },
    deleteContact : function (component, contact) {
        // Put the logic for deleting the contact Here
    },
    editContact : function (component, contact) {
        // Open the modal to Edit complete Contact in Modal using force:recordEdit
    },
    showDetails : function (component, contact) {
        component.set('v.showRecordid', contact.Id);
    },
    sortData: function (cmp, fieldName, sortDirection) {
        var data = cmp.get("v.conList");
        var reverse = sortDirection !== 'asc';
        //sorts the rows based on the column header that's clicked
        data.sort(this.sortBy(fieldName, reverse))
        cmp.set("v.conList", data);
    },
    sortBy: function (field, reverse, primer) {
        var key = primer ?
            function(x) {return primer(x[field])} :
            function(x) {return x[field]};
        //checks if the two rows should switch places
        reverse = !reverse ? 1 : -1;
        return function (a, b) {
            return a = key(a), b = key(b), reverse * ((a > b) - (b > a));
        }
    },
    GetSortOrderAsc : function(component,prop){
        var a=component.get('v.conList');
        return function(a, b) {
            if (a[prop] > b[prop]) {
                return 1;
            } else if (a[prop] < b[prop]) {
                return -1;
            }
            return 0;
        }

    },
    GetSortOrderDsc : function(component,prop){
        var a=component.get('v.conList');
        return function(a, b) {
            if (a[prop] > b[prop]) {
                return -1;
            } else if (a[prop] < b[prop]) {
                return 1;
            }
            return 0;
        }

    }
})