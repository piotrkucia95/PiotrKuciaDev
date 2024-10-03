/**
 * Created by Piotr Kucia on 12.07.2018.
 */

public with sharing class A18_CS_AssetService {

    private A18_DM_AssetService DMAssetService;

    public A18_CS_AssetService() {
        DMAssetService = new A18_DM_AssetService();
    }

    public static void addAsset(A18_DTO.Asset assetDTO) {
        Asset__c asset = A18_AssetAssembler.convertToDomain(assetDTO);
        A18_DM_AssetService.addAsset(asset);
    }

    public static void updateAsset(A18_DTO.Asset assetDTO) {
        Asset__c asset = A18_AssetAssembler.convertToDomain(assetDTO);
        A18_DM_AssetService.updateAsset(asset);
    }

    public static void deleteAssets(ID assetId) {
        A18_DM_AssetService.deleteAssets(assetId);
    }

    public static List<A18_DTO.Asset> getAssets() {
        List<Asset__c> assets = A18_DM_AssetService.getAssets();
        List<A18_DTO.Asset> DTOAssets = new List<A18_DTO.Asset>();

        for(Asset__c asset : assets){
            DTOAssets.add(A18_AssetAssembler.convertToDTO(asset));

        }
        return DTOAssets;
    }

    public static List<A18_DTO.Asset> searchAssets(String searchPhrase, ID recordTypeId){
        List<Asset__c> searchResults = A18_DM_AssetService.searchAssets(searchPhrase, recordTypeId);
        List<A18_DTO.Asset> DTOFoundAssets = new List<A18_DTO.Asset>();

        for(Asset__c searchResult : searchResults){
            DTOFoundAssets.add(A18_AssetAssembler.convertToDTO(searchResult));
        }
        return DTOFoundAssets;
    }

    public List<A18_DTO.AssetRecordType> getAssetRecordTypes() {
        List<Schema.RecordTypeInfo> recordTypeList = DMAssetService.getAssetRecordTypes();
        List<A18_DTO.AssetRecordType> DTOAssetRecordTypes = new List<A18_DTO.AssetRecordType>();

        for(Schema.recordTypeInfo recordType : recordTypeList){
            DTOAssetRecordTypes.add(A18_AssetAssembler.convertRecordTypeToDTO(recordType));
        }

        return DTOAssetRecordTypes;
    }

    public static List<A18_DTO.Asset> getAssetsAssignedToUser(Id userId) {
        List<Asset__c> assets = A18_DM_AssetService.getAssetsAssignedToUser(userId);
        List<A18_DTO.Asset> DTOAssets = new List<A18_DTO.Asset>();

        for(Asset__c asset : assets){
            DTOAssets.add(A18_AssetAssembler.convertToDTO(asset));

        }
        return DTOAssets;
    }
}