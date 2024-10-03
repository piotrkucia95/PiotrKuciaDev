/**
 * Created by Piotr Kucia on 10.07.2018.
 */

public with sharing class A18_AC_AssetUserController {

    private A18_CS_AssetUserService CSAssetUserService;

    public A18_AC_AssetUserController() {
        this.CSAssetUserService = new A18_CS_AssetUserService();
    }

    public static A18_DTO.AssetUser createAssetUserDTOFromJSON(String JSONString) {
        Map<String,String> dtoMap = new Map<String,String>();
        dtoMap = (Map<String,String>)System.JSON.deserialize(JSONString,Map<String,String>.class);
        A18_DTO.AssetUser dtoAssetUser = new A18_DTO.AssetUser();

        if(dtoMap.get('name') != NULL) dtoAssetUser.name = dtoMap.get('name');
        if(dtoMap.get('id') != NULL) dtoAssetUser.id = dtoMap.get('id');
        if(dtoMap.get('asset') != NULL) dtoAssetUser.asset = dtoMap.get('asset');
        if(dtoMap.get('user') != NULL) dtoAssetUser.user = dtoMap.get('user');
        if(dtoMap.get('startDate') != NULL) dtoAssetUser.startDate = Date.valueOf(dtoMap.get('startDate'));
        if(dtoMap.get('endDate') != NULL) dtoAssetUser.endDate = Date.valueOf(dtoMap.get('endDate'));
        if(dtoMap.get('status') != NULL) dtoAssetUser.status = dtoMap.get('status');

        return dtoAssetUser;
    }

    @AuraEnabled
    public static void addAssetUser(String dtoString) {
        try {
            A18_DTO.AssetUser dtoAssetUser = createAssetUserDTOFromJSON(dtoString);
            A18_CS_AssetUserService.addAssetUser(dtoAssetUser);
        } catch(Exception e) {
            throw new AuraHandledException('Error: ' + e.getMessage());
        }
    }

    @AuraEnabled
    public static void updateAssetUser(String dtoString) {
        try {
            A18_DTO.AssetUser dtoAssetUser = createAssetUserDTOFromJSON(dtoString);
            A18_CS_AssetUserService.updateAssetUser(dtoAssetUser);
        } catch(Exception e) {
            throw new AuraHandledException('Error: ' + e.getMessage());
        }
    }

    @AuraEnabled
    public static void deleteAssetUser(ID assetToUserId) {
        try {
            A18_CS_AssetUserService.deleteAssetUser(assetToUserId);
        } catch(Exception e) {
            throw new AuraHandledException('Error: ' + e.getMessage());
        }
    }

    @AuraEnabled
    public static List<String> searchAssetUsers(String searchPhrase, String status) {
        List<A18_DTO.AssetUser> assetUsersDTO = A18_CS_AssetUserService.searchAssetUsers(searchPhrase, status);
        List<Id> assetIdList = new List<Id>();
        List<Id> userIdList = new List<Id>();
        for(A18_DTO.AssetUser assetDTO : assetUsersDTO) {
            assetIdList.add(assetDTO.asset);
            userIdList.add(assetDTO.user);
        }
        List<Asset__c> assetList = [SELECT Name FROM Asset__c WHERE Id IN :assetIdList];
        List<User> userList = [SELECT FirstName, LastName FROM User WHERE Id IN :userIdList];
        for(A18_DTO.AssetUser assetUser : assetUsersDTO) {
            for(Asset__c asset : assetList) {
                if(assetUser.asset == (String)asset.Id) {
                    assetUser.asset = asset.Name;
                    break;
                }
            }
            for(User user : userList) {
                if(assetUser.user == (String)user.Id) {
                    assetUser.user = user.FirstName + ' ' + user.LastName;
                    break;
                }
            }
        }
        List<String> DTOStrings = new List<String>();
        for(A18_DTO.AssetUser assetUserDTO : assetUsersDTO) {
            DTOStrings.add(JSON.serialize(assetUserDTO));
        }
        return DTOStrings;
    }

    public List<A18_DTO.AssetStatus> getAssetStatuses() {
        return CSAssetUserService.getAssetStatuses();
    }

    @AuraEnabled
    public static List<String> getAssetUsers() {
        List<A18_DTO.AssetUser> assetUsersDTO = A18_CS_AssetUserService.getAssetUsers();
        List<Id> assetIdList = new List<Id>();
        List<Id> userIdList = new List<Id>();
        for(A18_DTO.AssetUser assetDTO : assetUsersDTO) {
            assetIdList.add(assetDTO.asset);
            userIdList.add(assetDTO.user);
        }
        List<Asset__c> assetList = [SELECT Name FROM Asset__c WHERE Id IN :assetIdList];
        List<User> userList = [SELECT FirstName, LastName FROM User WHERE Id IN :userIdList];
        for(A18_DTO.AssetUser assetUser : assetUsersDTO) {
            for(Asset__c asset : assetList) {
                if(assetUser.asset == (String)asset.Id) {
                    assetUser.asset = asset.Name;
                    break;
                }
            }
            for(User user : userList) {
                if(assetUser.user == (String)user.Id) {
                    assetUser.user = user.FirstName + ' ' + user.LastName;
                    break;
                }
            }
        }
        List<String> DTOStrings = new List<String>();
        for(A18_DTO.AssetUser assetUserDTO : assetUsersDTO) {
            DTOStrings.add(JSON.serialize(assetUserDTO));
        }
        return DTOStrings;
    }

    @AuraEnabled
    public static List < sObject > fetchLookUpValues(String searchKeyWord, String ObjectName, List<sObject> ExcludeitemsList) {
        String searchKey = '%' + searchKeyWord + '%';
        List < sObject > returnList = new List < sObject > ();

        List<string> lstExcludeitems = new List<string>();
        for(sObject item : ExcludeitemsList ){
            lstExcludeitems.add(item.id);
        }

        // Create a Dynamic SOQL Query For Fetch Record List with LIMIT 5 and exclude already selected records
        String sQuery =  'select id, Name from ' +ObjectName + ' where Name LIKE: searchKey AND Id NOT IN : lstExcludeitems order by createdDate DESC limit 5';
        List < sObject > lstOfRecords = Database.query(sQuery);

        for (sObject obj: lstOfRecords) {
            returnList.add(obj);
        }
        return returnList;
    }
}