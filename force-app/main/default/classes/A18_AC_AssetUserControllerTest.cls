/**
 * Created by Piotr Kucia on 15.07.18.
 */

@IsTest
private class A18_AC_AssetUserControllerTest {

    static testMethod void testAddAssetUser() {
        A18_AC_AssetUserController assetUserController = new A18_AC_AssetUserController();
        A18_DTO.AssetUser testDTO = new A18_DTO.AssetUser();

        testDTO.assetId = 'a010X00000shiPVQAY';
        testDTO.endDate = Date.today();
        testDTO.startDate = Date.today();
        testDTO.status = 'Delivered';
        testDTO.userId = '0050X000005xZtIQAU';

        assetUserController.addAssetUser(testDTO);
    }

    static testMethod void testUpdateAssetUser() {
        A18_AC_AssetUserController assetUserController = new A18_AC_AssetUserController();
        A18_DTO.AssetUser testDTO = new A18_DTO.AssetUser();

        testDTO.assetId = 'a010X00000shiPVQAY';
        testDTO.endDate = Date.today();
        testDTO.startDate = Date.today();
        testDTO.status = 'Delivered';
        testDTO.userId = '0050X000005xZtIQAU';

        assetUserController.updateAssetUser(testDTO);
    }

    static testMethod void testDeleteAssetUser() {
        A18_AC_AssetUserController assetUserController = new A18_AC_AssetUserController();
        assetUserController.deleteAssetUser('5003000000D8cuI');
    }

    static testMethod void testGetAssetStatuses() {
        A18_AC_AssetUserController assetUserController = new A18_AC_AssetUserController();
        assetUserController.getAssetStatuses();
    }

    static testMethod void testSearchAssetUsers() {
        A18_AC_AssetUserController assetUserController = new A18_AC_AssetUserController();
        assetUserController.searchAssetUsers('Mouse for Adam B', 'Delivered');
    }
}