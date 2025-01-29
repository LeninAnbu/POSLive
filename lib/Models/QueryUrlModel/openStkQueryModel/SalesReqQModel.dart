// {status: true, msg: Success,
//data: [{"DocEntry":326488,"DocNum":14286,"DocDate":"2020-11-17T00:00:00","CardCode":"D0935",
//"CardName":"ADVERTISEMENT A/C- CORPORATE","DocTotal":133222.000000,"WhsCode":"HOFG"},
//{"DocEntry":344890,"DocNum":4001298,"DocDate":"2021-04-27T00:00:00","CardCode":"D6080","CardName":"SHUBI INVESTMENT - MBEYA","DocTotal":5715920.000000,"WhsCode":"HOFG"},{"DocEntry":366317,"DocNum":8447,"DocDate":"2021-11-10T00:00:00","CardCode":"D0999","CardName":"CASH SALES HO A/C","DocTotal":228448.000000,"WhsCode":"HOFG"},{"DocEntry":368144,"DocNum":8921,"DocDate":"2021-11-25T00:00:00","CardCode":"D0935","CardName":"ADVERTISEMENT A/C- CORPORATE","DocTotal":23600.000000,"WhsCode":"HOFG"},{"DocEntry":368145,"DocNum":8922,"DocDate":"2021-11-25T00:00:00","CardCode":"D0935","CardName":"ADVERTISEMENT A/C- CORPORATE","DocTotal":29500.000000,"WhsCode":"HOFG"}
import 'dart:convert';
import 'dart:developer';

class OpenSalesReqHeadersModl {
  OpenSalesReqHeadersModl({
    required this.status,
    required this.message,
    required this.activitiesData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<OpenSalesReqHeadersModlData>? activitiesData;
  String? error;
  int? statusCode;

  factory OpenSalesReqHeadersModl.fromJson(
      Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      // log('resprespresp::${jsons['data'].toString()}');

      // var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'].toString() != 'No data found') {
        log('dddddddd');
        var list = jsonDecode(jsons['data']) as List; //jsonDecode
        List<OpenSalesReqHeadersModlData> dataList = list
            .map((dynamic enquiries) =>
                OpenSalesReqHeadersModlData.fromJson(enquiries))
            .toList();
        return OpenSalesReqHeadersModl(
          activitiesData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return OpenSalesReqHeadersModl(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          activitiesData: [],
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return OpenSalesReqHeadersModl(
        message: null,
        status: null,
        activitiesData: [],
        error: '',
        statusCode: stcode,
      );
    }
  }
  factory OpenSalesReqHeadersModl.error(String e, int stcode) {
    return OpenSalesReqHeadersModl(
      message: null,
      status: null,
      activitiesData: null,
      error: '$e',
      statusCode: stcode,
    );
  }
}

// {"DocEntry":326488,"DocNum":14286,"DocDate":"2020-11-17T00:00:00","CardCode":"D0935",
//"CardName":"ADVERTISEMENT A/C- CORPORATE","DocTotal":133222.000000,"WhsCode":"HOFG"},
class OpenSalesReqHeadersModlData {
  int docEntry;
  int docNum;
  String toWhsCode;
  String docDate;
  String cardCode;
  double docTotal;
  String fromWhs;
  String uwhsCode;
  String docStatus; //CardName
  String cardName;
  String? comments;
  int? invoiceClr;
  bool? checkBClr;
  OpenSalesReqHeadersModlData(
      {required this.docDate,
      required this.toWhsCode,
      required this.docEntry,
      required this.cardCode,
      required this.docTotal,
      this.checkBClr,
      this.comments,
      this.invoiceClr,
      required this.cardName,
      required this.docNum,
      required this.fromWhs,
      required this.docStatus,
      required this.uwhsCode});

  // "data": "[{\"docentry\":41949,\"docnum\":9691,\"docdate\":\"2024-12-11T00:00:00\",\"ReqWhs\":\"ARSFG\",\"FromWhsCod\":\"HOFG\",\"DocStatus\":\"C\"}
  factory OpenSalesReqHeadersModlData.fromJson(dynamic jsons) {
    return OpenSalesReqHeadersModlData(
        docDate: jsons['DocDate'] ?? '',
        toWhsCode: jsons['ToWhsCode'] ?? '',
        cardCode: jsons['CardCode'] ?? '',
        comments: jsons['Comments'] ?? '',
        fromWhs: jsons['FromWhsCod'] ?? "",
        docTotal: jsons['DocTotal'] ?? 0,
        docStatus: jsons['DocStatus'] ?? "",
        cardName: jsons['CardName'] ?? "",
        docEntry: jsons['DocEntry'] ?? 0,
        docNum: jsons['DocNum'] ?? 0,
        uwhsCode: jsons['U_ReqWhs'] ?? "");
  }
}
