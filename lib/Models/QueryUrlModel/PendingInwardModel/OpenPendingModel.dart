// {status: true, msg: Success, data: [{"DocEntry":631504,"DocNum":40726,"DocDate":"2024-10-04T00:00:00","ToWhsCode":"HOGIT","Filler":"ARSFG","Comments":"","Dscription":"200105E","FromWhsCod":"ARSFG","Towhs":"HOGIT","Quantity":5.000000,"Price":3188.966000,"BatchNum":"24-18888","Batch Qty":5.000000,"BT_Line":3},{"DocEntry":631504,"DocNum":40726,"DocDate":"2024-10-04T00:00:00","ToWhsCode":"HOGIT","Filler":"ARSFG","Comments":"","Dscription":"100681A","FromWhsCod":"ARSFG","Towhs":"HOGIT","Quantity":10.000000,"Price":41797.022000,"BatchNum":"24-24590","Batch Qty":10.000000,"BT_Line":3}]}
import 'dart:convert';
import 'dart:developer';

class OpenStockOutLineModl {
  OpenStockOutLineModl({
    required this.status,
    required this.message,
    required this.openOutwardData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<OpenStockOutLineModlData>? openOutwardData;
  String? error;
  int? statusCode;

  factory OpenStockOutLineModl.fromJson(
      Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      // log('resprespresp::${jsons['data'].toString()}');

      // var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'].toString() != 'No data found') {
        log('dddddddd');
        var list = jsonDecode(jsons['data']) as List; //jsonDecode
        List<OpenStockOutLineModlData> dataList = list
            .map((dynamic enquiries) =>
                OpenStockOutLineModlData.fromJson(enquiries))
            .toList();
        return OpenStockOutLineModl(
          openOutwardData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return OpenStockOutLineModl(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          openOutwardData: [],
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return OpenStockOutLineModl(
        message: null,
        status: null,
        openOutwardData: [],
        error: '',
        statusCode: stcode,
      );
    }
  }
  factory OpenStockOutLineModl.error(String e, int stcode) {
    return OpenStockOutLineModl(
      message: null,
      status: null,
      openOutwardData: null,
      error: e,
      statusCode: stcode,
    );
  }
}

class OpenStockOutLineModlData {
  int docEntry;
  int docNum;
  String docDate;
  String towhsCode;
  String frmWhs;
  String comments;
  String itemCode;
  String description;
  double qty;
  double price;
  String batchNum;
  double batchQty;
  double requestQty;
  int batchLine;
  int? invoiceClr;
  bool? checkBClr;
  //{"DocEntry":631506,"DocNum":40728,"DocDate":"2024-10-09T00:00:00","ToWhsCode":"HOGIT","From whs":"ARSFG","Comments":"","ItemCode":"200105E","Dscription":"HIGH GLOSS ENAMEL LIGHT BLUE - 1LTR","FromWhsCod":"ARSFG","Towhs":"HOGIT","Quantity":20.000000,"Price":3188.966000,"BatchNum":"24-18888","Batch Qty":20.000000,"BT_Line":5,"REQUEST QTY":50.000000}
  OpenStockOutLineModlData(
      {required this.description,
      required this.itemCode,
      required this.docEntry,
      required this.docDate,
      required this.docNum,
      required this.towhsCode,
      required this.frmWhs,
      required this.batchNum,
      required this.price,
      this.checkBClr,
      this.invoiceClr,
      required this.qty,
      required this.batchQty,
      required this.requestQty,
      required this.comments,
      required this.batchLine});
// tion":"HIGH GLOSS ENAMEL LIGHT BLUE - 1LTR","FromWhsCod":"ARSFG","Towhs":"HOGIT","Quantity":20.000000,"Price":3188.966000,
//"BatchNum":"24-18888","Batch Qty":20.000000,"BT_Line":5,"REQUEST QTY":50.000000},{"DocEntry":631506,"DocNum":40728,
//"DocDate":"2024-10-09T00:00:00","ToWhsCode":"HOGIT","From whs":"ARSFG","Comments":"","ItemCode":"100681A",
//"Dscription":"DELUX PRO GUARD EMULSION DEEP - 20LTR","FromWhsCod":"ARSFG","Towhs":"HOGIT","Quantity":10.000000,
//"Price":41797.022000,"BatchNum":"24-24590","Batch Qty":10.000000,"BT_Line":5,"REQUEST QTY":40.000000}]
  factory OpenStockOutLineModlData.fromJson(dynamic jsons) {
    return OpenStockOutLineModlData(
        docNum: jsons['DocNum'] ?? 0,
        docEntry: jsons['DocEntry'] ?? 0,
        comments: jsons['Comments'] ?? '',
        docDate: jsons['DocDate'] ?? '',
        frmWhs: jsons['FromWhsCod'] ?? '',
        towhsCode: jsons['ToWhsCode'] ?? '',
        qty: jsons['Quantity'] ?? 0,
        batchQty: jsons['Batch Qty'] ?? 0,
        requestQty: jsons['REQUEST QTY'] ?? 0,
        batchLine: jsons['BT_Line'] ?? 0,
        batchNum: jsons['BatchNum'] ?? '',
        price: jsons['Price'] ?? 0,
        itemCode: jsons['ItemCode'] ?? '',
        description: jsons['Dscription'] ?? '');
  }
}
