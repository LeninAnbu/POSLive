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

// "itemname", "itemcode", "quantity", "maximumQty", "minimumQty", "displayQty", "searchString", "category", "liter", "category1", "weight", "hsnsac", "isActive", "isfreeby", "isinventory", "issellpricebyscrbat", "itemnamelong", "itemnameshort", "skucode", "subcategory", "sellprice", "mrpprice", "specialprice", "maxdiscount", "taxrate", "snapdatetime", "purchasedate", "createdateTime", "updatedDatetime", "createdUserID", "updateduserid", "lastupdateIp", "U_Pack_Size", "U_TINS_PER_BOX", "U_Specific_Gravity", "U_Pack_Size_uom
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
  double? uSpecificGravity;
  ProductMasterModslData({
    required this.uPackSize,
    required this.uTINSPERBOX,
    required this.itemName,
    required this.uSpecificGravity,
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
// {\"itemname\":\"2K EPOXY HARDNER - 1LTR\",\"itemcode\":\"10000019E\",\"maximumQty\":\"10\",\"minimumQty\":\"100\",\"displayQty\":\"10\",\"searchString\":\"10000019E,2K EPOXY HARDNER - 1LTR,2K EPOXY HARDNER - 1LTR,GALAXY\",\"category\":\"\",\"BRAND\":\"GALAXY\",\"liter\":1.000000,\"category1\":\"\",\"BRAND1\":\"GALAXY\",\"weight\":0.000000,\"hsnsac\":\"\",\"isActive\":\"N\",\"isfreeby\":\"FALSE\",\"isinventory\":\"TRUE\",\"issellpricebyscrbat\":\"FALSE\",\"itemnamelong\":\"10000019E,2K EPOXY HARDNER - 1LTR,2K EPOXY HARDNER - 1LTR,GALAXY\",\"taxrate\":18.000000,\"itemnameshort\":\"2K EPOXY HARDNER - 1LTR\",\"skucode\":\"10000019E\",\"subcategory\":\"\",\"sellprice\":17500.000000,\"mrpprice\":17500.000000,\"specialprice\":17500.000000,\"maxdiscount\":\"50\",\"snapdatetime\":\"2024-09-16T13:38:02.557\",\"purchasedate\":\"2024-09-16T13:38:02.557\",\"createdateTime\":\"2024-09-16T13:38:02.557\",\"updatedDatetime\":\"2024-09-16T13:38:02.557\",\"createdUserID\":\"1\",\"updateduserid\":\"1\",\"lastupdateIp\":\"\",\"U_Pack_Size\":1.000000,\"U_TINS_PER_BOX\":0,\"U_Specific_Gravity\":0.950000,\"U_Pack_Size_uom\":\"L\"}
  factory ProductMasterModslData.fromJson(Map<String, dynamic> json) {
    // log('taxcoddeeeee::${json.toString()}');
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
      brand: json['BRAND'] ?? '',
      brand1: json['BRAND1'] ?? '',
      category: json['category'] ?? '',
      category1: json['category1'].toString(),
      serialBatch: '',
      // quantity: json['quantity'] == null
      //     ? 0
      //     : int.parse(json['quantity'].toString()),
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
  // Map<String, Object?> toMap() => {
  //       PosColumn.branch: Branch,
  //       PosColumn.itemCode: ItemCode,
  //       PosColumn.itemName: ItemName,
  //       PosColumn.transId: TransID,
  //       PosColumn.serialBatch: SerialBatch,
  //       PosColumn.qty: Qty,
  //       PosColumn.openQty: OpenQty,
  //       PosColumn.venCode: VenCode,
  //       PosColumn.venName: VenName,
  //       PosColumn.inDate: Branch,
  //       PosColumn.inType: ItemCode,
  //       PosColumn.sellPrice: SellPrice,
  //       PosColumn.mrp: MRP,
  //       PosColumn.cost: Cost,
  //       PosColumn.taxRate: TaxRate,
  //       PosColumn.taxType: TaxType,
  //     };
}
