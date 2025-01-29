const String tablePriceMaster = "PriceMaster";

class PriceMasterT {
  static String itemcode = "Itemcode";
  static String pricelistID = "pricelistID";
  static String currencycode = "currencycode";
  static String price = "price";
  static String createdateTime = 'createdateTime';
  static String updatedDatetime = "UpdatedDatetime";
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
}

class PriceMasterModelDB {
  String? itemcode;
  int? pricelistID;
  int? currencycode;
  double? price;
  String? createdateTime;
  String? updatedDatetime;
  String? createdUserID;
  int? updateduserid;
  int? lastupdateIp;

  PriceMasterModelDB({
    required this.createdUserID,
    required this.createdateTime,
    required this.itemcode,
    required this.lastupdateIp,
    required this.updatedDatetime,
    required this.updateduserid,
    required this.currencycode,
    required this.price,
    required this.pricelistID
  });

  factory PriceMasterModelDB.fromMap(Map<String, dynamic> item) =>
      PriceMasterModelDB(
        createdUserID:item['createdUserID'] , 
        createdateTime: item['createdUserID'] , 
        itemcode: item['createdUserID'] , 
        lastupdateIp: item['createdUserID'] , 
        updatedDatetime: item['createdUserID'] , 
        updateduserid: item['createdUserID'] , 
        currencycode: item['createdUserID'] , 
        price: item['createdUserID'] , 
        pricelistID: item['createdUserID'] 
        );

        Map<String, Object?> toMap() => {
        PriceMasterT.createdUserID : createdUserID,
        PriceMasterT.createdateTime:createdateTime,
        PriceMasterT.currencycode:currencycode,
        PriceMasterT.itemcode:itemcode,
        PriceMasterT.lastupdateIp:lastupdateIp,
        PriceMasterT.price:price,
        PriceMasterT.pricelistID:pricelistID,
        PriceMasterT.updatedDatetime:updatedDatetime,
        PriceMasterT.updateduserid:updateduserid,
      };
}
