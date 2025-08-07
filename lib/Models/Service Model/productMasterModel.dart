import 'dart:convert';

class ProductMasterModsl {
  List<ProductMasterModslData> productItemData;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  ProductMasterModsl(
      {required this.productItemData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory ProductMasterModsl.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["data"] != null) {
      var list = jsonDecode(jsons["data"]) as List;
      List<ProductMasterModslData> dataList =
          list.map((data) => ProductMasterModslData.fromJson(data)).toList();
      return ProductMasterModsl(
          productItemData: dataList,
          message: jsons["message"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    } else {
      return ProductMasterModsl(
          productItemData: [],
          message: jsons["message"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    }
  }

  factory ProductMasterModsl.error(String jsons, int stcode) {
    return ProductMasterModsl(
        productItemData: [],
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class ProductMasterModslData {
  int? autoId;
  String? itemcode;
  String? itemName;
  String? serialBatch;
  String? itemnamelong;
  String? itemnameshort;
  String? skucode;
  double? sellprice;
  double? mrpprice;
  int? quantity;
  String? brand;
  String? brand1;

  String? category;
  String? category1;
  String? subcategory;
  String? hsnsac;
  double? taxrate;
  String? isinventory;
  String? isfreeby;
  String? isActive;
  String? createdateTime;
  String? updatedDatetime;
  String? createdUserID;
  String? updateduserid;
  String? lastupdateIp;
  String? issellpricebyscrbat;
  String? maxdiscount;
  String? maximumQty;
  String? minimumQty;
  String? isserialBatch;
  double? weight;
  double? liter;
  double? specialprice;
  String? snapdatetime;
  String? displayQty;
  String? searchString;
  String? purchasedate;
  double? uPackSize;
  int? uTINSPERBOX;
  String? uPackSizeuom;
  String? managedby;

  double? uSpecificGravity;
  ProductMasterModslData({
    required this.uPackSize,
    required this.uTINSPERBOX,
    required this.itemName,
    required this.uSpecificGravity,
    required this.managedby,
    this.isserialBatch,
    this.serialBatch,
    required this.uPackSizeuom,
    this.autoId,
    required this.maximumQty,
    required this.minimumQty,
    required this.weight,
    required this.liter,
    required this.displayQty,
    required this.searchString,
    required this.brand,
    required this.brand1,
    required this.category,
    required this.category1,
    this.quantity,
    this.purchasedate,
    this.snapdatetime,
    this.specialprice,
    required this.createdUserID,
    required this.createdateTime,
    required this.mrpprice,
    required this.sellprice,
    required this.hsnsac,
    required this.isActive,
    required this.isfreeby,
    required this.isinventory,
    required this.issellpricebyscrbat,
    required this.itemcode,
    required this.itemnamelong,
    required this.itemnameshort,
    required this.lastupdateIp,
    required this.maxdiscount,
    required this.skucode,
    required this.subcategory,
    required this.taxrate,
    required this.updatedDatetime,
    required this.updateduserid,
  });

  factory ProductMasterModslData.fromJson(Map<String, dynamic> json) {
    return ProductMasterModslData(
      autoId: json['AutoId'] == null ? 0 : int.parse(json['AutoId'].toString()),
      maximumQty:
          json['maximumQty'] == null ? '' : json['maximumQty'].toString(),
      minimumQty:
          json['minimumQty'] == null ? '' : json['minimumQty'].toString(),
      weight: json['weight'] ?? 0.00,
      liter: json['weight'] == null ? 0.00 : json['liter'],
      displayQty:
          json['displayQty'] == null ? '' : json['displayQty'].toString(),
      searchString: json['searchString'] ?? '',
      createdUserID: json['createdUserID'] ?? '',
      createdateTime: json['createdateTime'] ?? '',
      lastupdateIp: json['lastupdateIp'] ?? '',
      managedby: json['ManageBy'] ?? '',
      brand: json['BRAND'] ?? '',
      brand1: json['BRAND1'] ?? '',
      category: json['category'] ?? '',
      category1: json['category1'].toString(),
      serialBatch: '',
      updatedDatetime: json['updatedDatetime'] ?? '',
      updateduserid: json['updateduserid'] ?? '',
      mrpprice: json['mrpprice'],
      sellprice: json['sellprice'] ?? "",
      taxrate: json['taxrate'] ?? "",
      hsnsac: json['hsnsac'] ?? '',
      isActive: json['isActive'] ?? '',
      subcategory: json['subcategory'] ?? '',
      skucode: json['skucode'] ?? '',
      isfreeby: json['isfreeby'] ?? '',
      isinventory: json['isinventory'] ?? '',
      issellpricebyscrbat: json['issellpricebyscrbat'].toString(),
      itemcode: json['itemcode'] ?? '',
      itemName: json['itemname'] ?? '',
      itemnamelong: json['itemnamelong'] ?? '',
      maxdiscount:
          json['maxdiscount'] == null ? '' : json['maxdiscount'].toString(),
      itemnameshort: json['itemnameshort'] ?? '',
      uPackSize: json['U_Pack_Size'],
      specialprice: json['specialprice'],
      snapdatetime: json['snapdatetime'],
      purchasedate: json['purchasedate'],
      uTINSPERBOX: json['U_TINS_PER_BOX'],
      uSpecificGravity: json['U_Specific_Gravity'],
      uPackSizeuom: json['U_Pack_Size_uom'].toString(),
    );
  }
}
