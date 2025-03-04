// {
//     "status": true,
//     "msg": "Success",
//     "data": "[{\"DocEntry\":564936,\"DocNum\":1016798,\"DocDate\":\"2024-10-18T00:00:00\",\"CardCode\":\"D5348\",\"CardName\":\"BOA VIDA COMPANY LIMITED - ARUSHA CASH ACC\",\"LineNum\":0,\"ItemCode\":\"1000002E\",\"Dscription\":\"RED OXIDE PRIMER - 1LTR\",\"OpenQty\":5.000000,\"BatchNum\":\"24-20268\",\"WhsCode\":\"ARSFG\",\"TaxCode\":\"O1\",\"Price\":5237.460000},{\"DocEntry\":564936,\"DocNum\":1016798,\"DocDate\":\"2024-10-18T00:00:00\",\"CardCode\":\"D5348\",\"CardName\":\"BOA VIDA COMPANY LIMITED - ARUSHA CASH ACC\",\"LineNum\":1,\"ItemCode\":\"1000002F\",\"Dscription\":\"RED OXIDE PRIMER - 0.5LTR\",\"OpenQty\":10.000000,\"BatchNum\":\"23-22810\",\"WhsCode\":\"ARSFG\",\"TaxCode\":\"O1\",\"Price\":3162.240000}]"
// }
import 'dart:convert';
import 'dart:developer';

class OpenSalesReturnModel {
  OpenSalesReturnModel({
    required this.status,
    required this.message,
    required this.activitiesData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<OpenSalesReturnModelData>? activitiesData;
  String? error;
  int? statusCode;

  factory OpenSalesReturnModel.fromJson(
      Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      // log('resprespresp::${jsons['data'].toString()}');
      // var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'].toString() != 'No data found') {
        log('dddddddd');
        var list = jsonDecode(jsons['data']) as List; //jsonDecode
        List<OpenSalesReturnModelData> dataList = list
            .map((dynamic enquiries) =>
                OpenSalesReturnModelData.fromJson(enquiries))
            .toList();
        return OpenSalesReturnModel(
          activitiesData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return OpenSalesReturnModel(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          activitiesData: [],
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return OpenSalesReturnModel(
        message: null,
        status: null,
        activitiesData: [],
        error: '',
        statusCode: stcode,
      );
    }
  }
  factory OpenSalesReturnModel.error(String e, int stcode) {
    return OpenSalesReturnModel(
      message: null,
      status: null,
      activitiesData: null,
      error: e,
      statusCode: stcode,
    );
  }
}

class OpenSalesReturnModelData {
  int docEntry;
  int docNum;
  int lineNum;
  double price;
  String cardCode;
  String itemCode;
  String itemName;
  String docDate;
  String batchNum;
  String taxCode;
  double openQty;
  double Qty;

  double discount;
  double? docTotal;

  String whsCode;
  String cardName;
  int? invoiceClr;
  bool? checkBClr;
  OpenSalesReturnModelData(
      {required this.itemCode,
      required this.cardCode,
      required this.batchNum,
      required this.docTotal,
      required this.cardName,
      required this.docEntry,
      required this.docDate,
      required this.price,
      required this.discount,
      required this.Qty,
      this.checkBClr,
      this.invoiceClr,
      required this.taxCode,
      required this.docNum,
      required this.lineNum,
      required this.itemName,
      required this.openQty,
      required this.whsCode});

  factory OpenSalesReturnModelData.fromJson(dynamic jsons) {
    return OpenSalesReturnModelData(
        itemCode: jsons['ItemCode'] ?? '',
        cardCode: jsons['CardCode'] ?? "",
        cardName: jsons['CardName'] ?? "",
        itemName: jsons['Dscription'] ?? "",
        batchNum: jsons['BatchNum'] ?? "",
        taxCode: jsons['TaxCode'] ?? "",
        docDate: jsons['DocDate'] ?? "",
        docTotal: jsons['DocTotal'] ?? 0,
        docEntry: jsons['DocEntry'] ?? 0,
        docNum: jsons['DocNum'] ?? 0,
        lineNum: jsons['LineNum'] ?? 0,
        openQty: jsons['OpenQty'] ?? 0,
        Qty: jsons['quantity'] ?? 0,
        price: jsons['PriceBefDi'] ?? 0,
        discount: jsons['DiscPrcnt'] ?? 0,
        whsCode: jsons['WhsCode'] ?? "");
  }
}
