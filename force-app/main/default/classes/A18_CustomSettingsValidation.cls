/**
 * Created by Piotr Kucia on 15.07.18.
 */

public with sharing class A18_CustomSettingsValidation {

    //checks if object contains fields attached in 'queryFields' list and makes coma separated string to add to query
    public static String validateQueryFields(List<String> queryFields, String objectType){
        List<String> fieldsList = queryFields;
        Set<String> assetObjectFields = Schema.getGlobalDescribe().get('Asset__c').getDescribe().fields.getMap().keySet();
        Set<String> assetUserObjectFields = Schema.getGlobalDescribe().get('Asset_To_User__c').getDescribe().fields.getMap().keySet();
        List<String> queryFieldsList = new List<String>();

        for(String field : fieldsList){
            if(assetObjectFields.contains(field) && objectType == 'Asset'){
                queryFieldsList.add(field);
            }
            if(assetUserObjectFields.contains(field) && objectType == 'AssetToUser'){
                queryFieldsList.add(field);
            }
        }

        if(queryFieldsList.isEmpty()) {
            queryFieldsList.add('Name');
            if(objectType == 'Asset') queryFieldsList.add('Description__c');
        }
        String queryFieldsString = queryFieldsList[0];

        for(Integer i = 1; i<queryFieldsList.size(); i++){
            queryFieldsString += (', ' + queryFieldsList[i]);
        }

        return queryFieldsString;
    }

    //checks if orderDirection contains correct value - ASC or DESC
    public static String validateQueryDirection(String orderDirection){
        String direction = orderDirection;
        if(orderDirection == null || (orderDirection != 'ASC' && orderDirection != 'DESC')) {
            direction = 'ASC';
        }
        return direction;
    }

}