// {status: true, msg: Success,
// data: [{"DocEntry":326488,"LineNum":3,"ItemCode":"K5500073E","Dscription":"GALAXY 2 K PU ENAMEL BLACK - 1+0.25+0.25KIT",
// "OpenQty":1.000000,"WhsCode":"HOFG"},
//{"DocEntry":344890,"LineNum":0,"ItemCode":"8950198K","Dscription":"RON 10YR WOODSTAIN  MAHOGANY - 2.5LTR","OpenQty":56.000000,"WhsCode":"HOFG"},{"DocEntry":366317,"LineNum":0,"ItemCode":"K6000022D","Dscription":"GALAXY 2K EPOXY HB PRIMER YELLOW - 4+1+1 LTR","OpenQty":2.000000,"WhsCode":"HOFG"},{"DocEntry":368144,"LineNum":0,"ItemCode":"655013E","Dscription":"GALAXY 2K PU ENAMEL TENNISCOURT G 615 - 1 LTR","OpenQty":1.000000,"WhsCode":"HOFG"},{"DocEntry":368145,"LineNum":0,"ItemCode":"K550080E","Dscription":"GALAXY 2K PU ENAMEL S 7010-R90B (DARK GREY APS) - 1+0.25+0.25 KIT","OpenQty":1.000000,"WhsCode":"HOFG"},{"DocEntry":412657,"LineNum":0,"ItemCode":"100651A","Dscription":"DELUX WEATHERGUARD EMULSION PEACH BLOOM (06 C 33) - 20LTR","OpenQty":12.000000,"WhsCode":"HOFG"}

import 'dart:convert';

class OpenSalesOrderLine {
  OpenSalesOrderLine({
    required this.status,
    required this.message,
    required this.activitiesData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<OpenSalesOrderLineData>? activitiesData;
  String? error;
  int? statusCode;

  factory OpenSalesOrderLine.fromJson(String resp, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'] != 'No data found') {
        var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
        List<OpenSalesOrderLineData> dataList = list
            .map((dynamic enquiries) =>
                OpenSalesOrderLineData.fromJson(enquiries))
            .toList();
        return OpenSalesOrderLine(
          activitiesData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return OpenSalesOrderLine(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          activitiesData: [],
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return OpenSalesOrderLine(
        message: null,
        status: null,
        activitiesData: null,
        error: resp,
        statusCode: stcode,
      );
    }
  }
}

// {"DocEntry":326488,"LineNum":3,"ItemCode":"K5500073E","Dscription":"GALAXY 2 K PU ENAMEL BLACK - 1+0.25+0.25KIT",
// "OpenQty":1.000000,"WhsCode":"HOFG"},
class OpenSalesOrderLineData {
  int docEntry;
  int lineNum;
  String itemCode;
  String description;
  double openQty;
  double? price;
  double? discPrcnt;
  String whsCode;
  double? uPackSize;
  double? stock;
  int? invoiceClr;
  bool? checkBClr;
  bool? valueInsert;
//PriceBefDi

  OpenSalesOrderLineData(
      {required this.itemCode,
      required this.lineNum,
      required this.docEntry,
      required this.uPackSize,
      this.stock,
      required this.description,
      required this.openQty,
      this.price,
      this.valueInsert,
      this.discPrcnt,
      this.checkBClr,
      this.invoiceClr,
      required this.whsCode});

  factory OpenSalesOrderLineData.fromJson(dynamic jsons) {
    return OpenSalesOrderLineData(
        itemCode: jsons['ItemCode'] ?? '',
        description: jsons['Dscription'] ?? '',
        docEntry: jsons['DocEntry'] ?? 0,
        price: jsons['PriceBefDi'] ?? 0,
        uPackSize: jsons['U_Pack_Size'] ?? 0,
        stock: jsons['stock'] ?? 0,
        discPrcnt: jsons['DiscPrcnt'] ?? 0,
        lineNum: jsons['LineNum'] ?? '',
        openQty: jsons['OpenQty'] ?? 0,
        whsCode: jsons['WhsCode'] ?? '');
  }
}
