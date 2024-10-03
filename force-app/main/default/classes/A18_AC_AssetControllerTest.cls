/**
 * Created by Piotr Kucia on 15.07.18.
 */

@IsTest
private class A18_AC_AssetControllerTest {

    @IsTest static List<A18_DTO.Asset> dataLoadingTest(){
        List<Asset__c> testAssets = Test.loadData(Asset__c.getSObjectType(), 'Test_Data');
        List<A18_DTO.Asset> testAssetsDTO = new List<A18_DTO.Asset>();
        for(Asset__c a: testAssets){
            testAssetsDTO.add(A18_AssetAssembler.convertToDTO(a));
        }
        return testAssetsDTO;
    }

    static testMethod void testAddAsset() {
        //createData
        List<A18_DTO.Asset> testData = dataLoadingTest();
        A18_AC_AssetController assetController= new A18_AC_AssetController();
        Integer size1 =assetController.getAssets().size();
        Integer size2 =testData.size();

        //perform test
        for(A18_DTO.Asset asset : testData){
            assetController.addAsset(asset);
        }

        //verify
        System.assertEquals(assetController.getAssets().size(), size1+size2);
    }

    static testMethod void testUpdateAsset() {
        List<A18_DTO.Asset> testData = dataLoadingTest();
        A18_AC_AssetController assetController= new A18_AC_AssetController();

        for(A18_DTO.Asset asset : testData){
            assetController.updateAsset(asset);
        }
    }

    static testMethod void testDeleteAsset() {
        A18_AC_AssetController assetController = new A18_AC_AssetController();

        assetController.deleteAsset('5003000000D8cuI');

        List<Asset__c> assetList = new List<Asset__c>();
        for(A18_DTO.Asset asset : assetController.getAssets()){
            assetList.add(A18_AssetAssembler.convertToDomain(asset));
        }

        //verify
        for(Asset__c asset : assetList){
            System.assertNotEquals(asset.Id, '5003000000D8cuI');
        }
    }

    static testMethod void testGetAssets() {
        A18_AC_AssetController assetController = new A18_AC_AssetController();
        assetController.getAssets();
    }

    static testMethod void testGetAssetRecordTypes() {
        A18_AC_AssetController assetController = new A18_AC_AssetController();
        assetController.getAssetRecordTypes();
    }

    static testMethod void testSearchAssets() {
        A18_AC_AssetController assetController = new A18_AC_AssetController();
        assetController.searchAssets('Computer', '5003000000D8cuI');
    }
}