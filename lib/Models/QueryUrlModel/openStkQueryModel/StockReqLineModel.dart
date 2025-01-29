// {status: true, msg: Success,
//data: [{"DocEntry":326488,"DocNum":14286,"DocDate":"2020-11-17T00:00:00","CardCode":"D0935",
//"CardName":"ADVERTISEMENT A/C- CORPORATE","DocTotal":133222.000000,"WhsCode":"HOFG"},
//{"DocEntry":344890,"DocNum":4001298,"DocDate":"2021-04-27T00:00:00","CardCode":"D6080","CardName":"SHUBI INVESTMENT - MBEYA","DocTotal":5715920.000000,"WhsCode":"HOFG"},{"DocEntry":366317,"DocNum":8447,"DocDate":"2021-11-10T00:00:00","CardCode":"D0999","CardName":"CASH SALES HO A/C","DocTotal":228448.000000,"WhsCode":"HOFG"},{"DocEntry":368144,"DocNum":8921,"DocDate":"2021-11-25T00:00:00","CardCode":"D0935","CardName":"ADVERTISEMENT A/C- CORPORATE","DocTotal":23600.000000,"WhsCode":"HOFG"},{"DocEntry":368145,"DocNum":8922,"DocDate":"2021-11-25T00:00:00","CardCode":"D0935","CardName":"ADVERTISEMENT A/C- CORPORATE","DocTotal":29500.000000,"WhsCode":"HOFG"}
import 'dart:convert';
import 'dart:developer';

class OpenStockLineModl {
  OpenStockLineModl({
    required this.status,
    required this.message,
    required this.activitiesData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<OpenStockLineModlData>? activitiesData;
  String? error;
  int? statusCode;

  factory OpenStockLineModl.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      // log('OpenStockLineresp::${jsons['data'].toString()}');

      // var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'].toString() != 'No data found') {
        log('dddddddd');
        var list = jsonDecode(jsons['data']) as List; //jsonDecode
        List<OpenStockLineModlData> dataList = list
            .map((dynamic enquiries) =>
                OpenStockLineModlData.fromJson(enquiries))
            .toList();
        return OpenStockLineModl(
          activitiesData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return OpenStockLineModl(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          activitiesData: [],
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return OpenStockLineModl(
        message: null,
        status: null,
        activitiesData: [],
        error: '',
        statusCode: stcode,
      );
    }
  }
  factory OpenStockLineModl.error(String e, int stcode) {
    return OpenStockLineModl(
      message: null,
      status: null,
      activitiesData: null,
      error: e,
      statusCode: stcode,
    );
  }
}

// {"DocEntry":326488,"DocNum":14286,"DocDate":"2020-11-17T00:00:00","CardCode":"D0935",
//"CardName":"ADVERTISEMENT A/C- CORPORATE","DocTotal":133222.000000,"WhsCode":"HOFG"},
class OpenStockLineModlData {
  int docEntry;
  int lineNum;
  String itemCode;
  String description;
  double qty;
  double stock;
  double transQty;
  double openQty;

  double unitPrice;
  int? invoiceClr;
  bool? checkBClr;
  OpenStockLineModlData(
      {required this.description,
      required this.itemCode,
      required this.docEntry,
      required this.stock,
      this.checkBClr,
      this.invoiceClr,
      required this.qty,
      required this.transQty,
      required this.lineNum,
      required this.openQty,
      required this.unitPrice});

  factory OpenStockLineModlData.fromJson(dynamic jsons) {
    return OpenStockLineModlData(
        lineNum: jsons['LineNum'] ?? 0,
        qty: jsons['Quantity'] ?? 0,
        openQty: jsons['OpenQty'] ?? 0,
        transQty: jsons['TransferedQty'] ?? 0,
        unitPrice: jsons['Price'] ?? 0,
        docEntry: jsons['DocEntry'] ?? 0,
        stock: jsons['STOCK'] ?? 0,
        itemCode: jsons['ItemCode'] ?? '',
        description: jsons['Dscription'] ?? '');
  }
}
