/**
 * Created by Piotr Kucia on 10.07.2018.
 */

public with sharing class A18_VFC_AssetController {

    private A18_CS_AssetService CSAssetService;
    public String searchText;
    public List<A18_DTO.Asset> results;

    public A18_VFC_AssetController(){
        this.CSAssetService = new A18_CS_AssetService();
        //results = CSAssetService.getAssets();
    }

    public void addAsset(A18_DTO.Asset assetDTO){
        CSAssetService.addAsset(assetDTO);
    }

    public void updateAsset(A18_DTO.Asset assetDTO){
        CSAssetService.updateAsset(assetDTO);
    }

    public void deleteAsset(ID assetId){
        CSAssetService.deleteAssets(assetId);
    }

    public List<A18_DTO.AssetRecordType> getAssetRecordTypes(){
        return CSAssetService.getAssetRecordTypes();
    }

    public List<A18_DTO.Asset> getAssets(){
        results = CSAssetService.getAssets();
        return results;
    }

    public List<A18_DTO.Asset> searchAssets(String searchPhrase, ID recordTypeId){
        return CSAssetService.searchAssets(searchPhrase, recordTypeId);
    }


    public String getSearchText() {
        return searchText;
    }

    public void setSearchText(String s) {
        searchText = s;
    }

    public List<A18_DTO.Asset> getResults() {
        return results;
    }

    public PageReference doSearch() {
        results = CSAssetService.searchAssets(searchText, NULL);
        return null;
    }


}