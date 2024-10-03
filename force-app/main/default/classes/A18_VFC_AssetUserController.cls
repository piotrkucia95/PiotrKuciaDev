/**
 * Created by Piotr Kucia on 10.07.2018.
 */

public with sharing class A18_VFC_AssetUserController {

    private A18_CS_AssetUserService CSAssetUserService;

    public A18_VFC_AssetUserController() {
        this.CSAssetUserService = new A18_CS_AssetUserService();
    }

    public void addAssetUser(A18_DTO.AssetUser assetUserDTO) {
        CSAssetUserService.addAssetUser(assetUserDTO);
    }

    public void updateAssetUser(A18_DTO.AssetUser assetUserDTO) {
        CSAssetUserService.updateAssetUser(assetUserDTO);
    }

    public void deleteAssetUser(ID assetToUserId) {
        CSAssetUserService.deleteAssetUser(assetToUserId);
    }

    public List<A18_DTO.AssetStatus> getAssetStatuses() {
        return CSAssetUserService.getAssetStatuses();
    }

    public List<A18_DTO.AssetUser> searchAssetUsers(String searchPhrase, String status) {
        return CSAssetUserService.searchAssetUsers(searchPhrase, status);
    }

}