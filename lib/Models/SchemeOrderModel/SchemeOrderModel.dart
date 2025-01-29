import 'dart:developer';

class SchemeOrderModal {
  SchemeOrderModal(
      {required this.status,
      required this.message,
      this.saleOrder,
      required this.statuscode,
      this.exception});

  bool? status;
  String? message;
  List<SchemeOrderModalData>? saleOrder;
  String? exception;
  int statuscode;

  factory SchemeOrderModal.fromJson(
      Map<String, dynamic> jsons, int statuscode) {
    if (jsons['saleOrder'] != null) {
      var list = jsons['saleOrder'] as List;

      List<SchemeOrderModalData> dataList = list
          .map((dynamic enquiries) => SchemeOrderModalData.fromJson(enquiries))
          .toList();
      return SchemeOrderModal(
          saleOrder: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          statuscode: statuscode);
    } else {
      log("stcode$statuscode");
      return SchemeOrderModal(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          saleOrder: null,
          statuscode: statuscode);
    }
  }
  factory SchemeOrderModal.issue(int statuscode) {
    return SchemeOrderModal(
        status: null, message: null, saleOrder: null, statuscode: statuscode);
  }

  factory SchemeOrderModal.exception(String e, int statuscode) {
    return SchemeOrderModal(
        status: null,
        message: null,
        exception: e,
        statuscode: statuscode,
        saleOrder: null);
  }
}

class SchemeOrderModalData {
  int docEntry;
  String schemeEntry;
  int lineNum;

  double discPer;
  double discVal;

  SchemeOrderModalData(
      {required this.docEntry,
      required this.schemeEntry,
      required this.lineNum,
      required this.discPer,
      required this.discVal});

  factory SchemeOrderModalData.fromJson(dynamic jsons) {
    log('jsons::${jsons}');
    return SchemeOrderModalData(
      docEntry: int.parse(jsons['docEntry'].toString()),
      schemeEntry: jsons['schemeEntry'].toString(),
      lineNum: int.parse(jsons['lineNum'].toString()),
      discPer: double.parse(jsons['discPer'].toString()),
      discVal: double.parse(jsons['discVal'].toString()),
    );
  }
}

// for api

class SalesOrderScheme {
  String lineno;
  String itemCode;
  String quantity;
  String priceBefDi;
  String uCartons;
  String balance;
  String customer;
  String warehouse;

  SalesOrderScheme(
      {required this.itemCode,
      required this.priceBefDi,
      required this.quantity,
      required this.uCartons,
      required this.lineno,
      required this.balance,
      required this.customer,
      required this.warehouse});

  Map<String, dynamic> toMap() {
    // log("ZZZZZZZZZZZZZZZZ");
    // log("LineNum:$lineno");
    // log("ItemCode::$ItemCode");
    // log("Quantit:$Quantity");
    // log("balance:$balance");
    // log("PriceBefDi:$PriceBefDi");
    // log("U_Cartons:$UCartons");
    // log("Customer:$customer");

    Map<String, String> map = {
      "LineNum": lineno,
      "ItemCode": itemCode,
      "Quantity": quantity,
      "PriceBefDi": priceBefDi,
      "U_Cartons": uCartons,
      "Balance": balance,
      "Customer": customer,
      "Warehouse": warehouse,
    };
    return map;
  }

  //   Map<String, dynamic> tojson() {
  //   Map<String, String> map = {
  //     "ItemCode": itemCode,
  //     "ItemDescription": itemName,
  //     "DiscountPercent": discounpercent.toString(),
  //     "TaxCode": taxCode.toString(),
  //     "Quantity": qty.toString(),
  //     "UnitPrice": price.toString(),
  //     "Currency": "TZS",
  //     "ShipToCode": LogisticOrderState.shipto.toString(),
  //     "WarehouseCode": GetValues.branch.toString(),
  //   };
  //   return map;
  // }

  //  "LineNum": "1",
  //           "ItemCode": "1000002D",
  //           "Quantity": "1000.000000",
  //           "PriceBefDi": "18000.00000",
  //           "UCartons": "0"
}
