/**
 * Created by Piotr Kucia on 10.07.2018.
 */

public with sharing class A18_CS_AssetUserService {

    private A18_DM_AssetUserService DMAssetUserService;

    public A18_CS_AssetUserService() {
        this.DMAssetUserService = new A18_DM_AssetUserService();
    }

    public static void addAssetUser(A18_DTO.AssetUser assetUserDTO) {
        Asset_To_User__c assetUser = A18_AssetUserAssembler.convertToDomain(assetUserDTO);
        A18_DM_AssetUserService.addAssetUser(assetUser);
    }

    public static void updateAssetUser(A18_DTO.AssetUser assetUserDTO) {
        Asset_To_User__c assetUser = A18_AssetUserAssembler.convertToDomain(assetUserDTO);
        A18_DM_AssetUserService.updateAssetUser(assetUser);
    }

    public static void deleteAssetUser(Id assetId) {
        A18_DM_AssetUserService.deleteAssetUser(assetId);
    }

    public List<A18_DTO.AssetStatus> getAssetStatuses() {
        List<Schema.PicklistEntry> statusPicklistEntryList = DMAssetUserService.getAssetStatuses();
        List<A18_DTO.AssetStatus> DTOAssetStatuses = new List<A18_DTO.AssetStatus>();

        for(Schema.PicklistEntry status : statusPicklistEntryList){
            DTOAssetStatuses.add(A18_AssetUserAssembler.convertAssetStatusToDTO(status));
        }

        return DTOAssetStatuses;
    }

    public static List<A18_DTO.AssetUser> searchAssetUsers(String searchPhrase, String status) {
        List<Asset_To_User__c> searchResults = A18_DM_AssetUserService.searchAssetUsers(searchPhrase, status);
        List<A18_DTO.AssetUser> DTOFoundAssetUsers = new List<A18_DTO.AssetUser>();

        for(Asset_To_User__c searchResult : searchResults){
            DTOFoundAssetUsers.add(A18_AssetUserAssembler.convertToDTO(searchResult));
        }
        return DTOFoundAssetUsers;
    }

    public static List<A18_DTO.AssetUser> getAssetUsers() {
        List<Asset_To_User__c> assetsToUsers = A18_DM_AssetUserService.getAssetUsers();
        List<A18_DTO.AssetUser> DTOAssetUsers = new List<A18_DTO.AssetUser>();

        for(Asset_To_User__c assetUser : assetsToUsers) {
            DTOAssetUsers.add(A18_AssetUserAssembler.convertToDTO(assetUser));
        }
        return DTOAssetUsers;
    }
}