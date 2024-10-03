/**
 * Created by Piotr Kucia on 12.07.2018.
 */

public with sharing class A18_AssetUserAssembler {

    public static A18_DTO.AssetUser convertToDTO(Asset_To_User__c assetUser){
        A18_DTO.AssetUser DTOAssetUser = new A18_DTO.AssetUser();

        DTOAssetUser.name = assetUser.Name;
        DTOAssetUser.id = assetUser.Id;
        DTOAssetUser.asset = assetUser.Asset__c;
        DTOAssetUser.startDate = assetUser.Start_Date__c;
        DTOAssetUser.endDate = assetUser.End_Date__c;
        DTOAssetUser.status = assetUser.Status__c;
        DTOAssetUser.user = assetUser.User__c;

        return DTOAssetUser;
    }

    public static Asset_To_User__c convertToDomain(A18_DTO.AssetUser assetUser){
        Asset_To_User__c CAssetUser = new Asset_To_User__c();

        CAssetUser.Name = assetUser.name;
        if(assetUser.id != NULL) {
            CAssetUser.Id = assetUser.id;
        } else {
            CAssetUser.Asset__c = assetUser.asset;
            CAssetUser.User__c = assetUser.user;
        }
        CAssetUser.Start_Date__c = assetUser.startDate;
        CAssetUser.End_Date__c = assetUser.endDate;
        CAssetUser.Status__c = assetUser.status;

        return CAssetUser;
    }

    public static A18_DTO.AssetStatus convertAssetStatusToDTO(Schema.PicklistEntry statusPicklist){
        A18_DTO.AssetStatus DTOAssetStatus = new A18_DTO.AssetStatus();

        DTOAssetStatus.value = statusPicklist.getValue();
        DTOAssetStatus.label = statusPicklist.getLabel();

        return DTOAssetStatus;
    }

}