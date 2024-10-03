/**
 * Created by Piotr Kucia on 10.07.2018.
 */

public with sharing class A18_DM_AssetUserService {

    private A18_DA_AssetUserService DAAssetUserService;

    public A18_DM_AssetUserService() {
        this.DAAssetUserService = new A18_DA_AssetUserService();
    }

    public static void addAssetUser(Asset_To_User__c assetToUser) {
        A18_DA_AssetUserService.addAssetUser(assetToUser);
    }

    public static void updateAssetUser(Asset_To_User__c assetToUser){
        A18_DA_AssetUserService.updateAssetUser(assetToUser);
    }

    public static void deleteAssetUser(Id assetToUserId) {
        A18_DA_AssetUserService.deleteAssetUser(assetToUserId);
    }

    public List<Schema.PicklistEntry> getAssetStatuses() {
        return DAAssetUserService.getAssetStatuses();
    }

    public static List<Asset_To_User__c > searchAssetUsers(String searchPhrase, String status) {
        return A18_DA_AssetUserService.searchAssetUsers(searchPhrase, status);
    }

    public static List<Asset_To_User__c> getAssetUsers() {
        return A18_DA_AssetUserService.getAssetUsers();
    }
}