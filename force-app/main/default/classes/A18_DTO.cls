/**
 * Created by Piotr Kucia on 12.07.2018.
 */

public with sharing class A18_DTO {

    public class Asset {
        public String name{get; set;}
        public Id id{get; set;}
        public String description{get; set;}
        public Date dueDate{get; set;}
        public String invoiceNumber{get; set;}
        public Decimal price{get; set;}
        public Date purchaseDate{get; set;}
        public Boolean isBroken{get; set;}
    }

    public class AssetRecordType {
        public ID id;
        public String label;
    }

    public class AssetFilter {

    }

    public class AssetStatus {
        public String value;
        public String label;
    }


    public class AssetUser {
        public String name{get; set;}
        public ID id{get; set;}
        public String asset{get; set;}
        public Date startDate{get; set;}
        public Date endDate{get; set;}
        public String status{get; set;}
        public String user{get; set;}
    }

}