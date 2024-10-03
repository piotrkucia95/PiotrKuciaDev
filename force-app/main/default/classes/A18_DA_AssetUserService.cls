/**
 * Created by Piotr Kucia on 10.07.2018.
 */

public with sharing class A18_DA_AssetUserService {

    public static void addAssetUser(Asset_To_User__c assetToUser) {
        insert assetToUser;
    }

    public static void updateAssetUser(Asset_To_User__c assetToUser) {
        update assetToUser;
    }

    public static void deleteAssetUser(ID assetToUserId) {
        delete [SELECT Id FROM Asset_To_User__c WHERE Id = :assetToUserId];
    }

    public static List<Asset_To_User__c> searchAssetUsers(String searchPhrase, String status) {
        List<Schema.PicklistEntry> statusValues = Asset_To_User__c.Status__c.getDescribe().getPicklistValues();
        List<String> validStatuses = new List<String>();

        for (Schema.PicklistEntry statusValue : statusValues) {
            validStatuses.add(statusValue.getValue());
        }

        //obtaining data about fields to search and fields to order by
        Asset_User_Search_Settings__c searchSetting = Asset_User_Search_Settings__c.getInstance();
        String searchFields = A18_CustomSettingsValidation.validateQueryFields(searchSetting.Search_Fields__c.split(';'), 'AssetToUser');
        String orderFields = A18_CustomSettingsValidation.validateQueryFields(searchSetting.Order_Fields__c.split(';'), 'AssetToUser');
        String orderDirection = A18_CustomSettingsValidation.validateQueryDirection(searchSetting.Order_Direction__c);

        if(validStatuses.contains(status) && status != NULL){
            List<Asset_To_User__c> AssetToUserList = Database.query('SELECT ' + searchFields +' FROM Asset_To_User__c WHERE Name LIKE\''+ '%' + searchPhrase +'\''+ '%' + ' AND Status__c=' +'\''  +status +'\'' +  ' ORDER BY ' + orderFields + ' ' + orderDirection);
            return AssetToUserList;
        } else if(validStatuses.contains(status) || status == NULL){
            List<Asset_To_User__c> AssetToUserList = Database.query('SELECT ' + searchFields +' FROM Asset_To_User__c WHERE Name LIKE\''+ '%' + searchPhrase + '%' +'\'');
            return AssetToUserList;
        } else {
            return NULL;
        }
    }

    public List<Schema.PicklistEntry> getAssetStatuses() {
        return Asset_To_User__c.Status__c.getDescribe().getPicklistValues();
    }

    public static List<Asset_To_User__c> getAssetUsers() {
        return [SELECT Name, Id, Asset__c, Start_Date__c, End_Date__c, Status__c, User__c FROM Asset_To_User__c];
    }
}