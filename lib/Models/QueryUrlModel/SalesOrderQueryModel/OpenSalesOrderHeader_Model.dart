// {status: true, msg: Success,
//data: [{"DocEntry":326488,"DocNum":14286,"DocDate":"2020-11-17T00:00:00","CardCode":"D0935",
//"CardName":"ADVERTISEMENT A/C- CORPORATE","DocTotal":133222.000000,"WhsCode":"HOFG"},
//{"DocEntry":344890,"DocNum":4001298,"DocDate":"2021-04-27T00:00:00","CardCode":"D6080","CardName":"SHUBI INVESTMENT - MBEYA","DocTotal":5715920.000000,"WhsCode":"HOFG"},{"DocEntry":366317,"DocNum":8447,"DocDate":"2021-11-10T00:00:00","CardCode":"D0999","CardName":"CASH SALES HO A/C","DocTotal":228448.000000,"WhsCode":"HOFG"},{"DocEntry":368144,"DocNum":8921,"DocDate":"2021-11-25T00:00:00","CardCode":"D0935","CardName":"ADVERTISEMENT A/C- CORPORATE","DocTotal":23600.000000,"WhsCode":"HOFG"},{"DocEntry":368145,"DocNum":8922,"DocDate":"2021-11-25T00:00:00","CardCode":"D0935","CardName":"ADVERTISEMENT A/C- CORPORATE","DocTotal":29500.000000,"WhsCode":"HOFG"}
import 'dart:convert';
import 'dart:developer';

class OpenSalesOrderHeader {
  OpenSalesOrderHeader({
    required this.status,
    required this.message,
    required this.activitiesData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<OpenSalesOrderHeaderData>? activitiesData;
  String? error;
  int? statusCode;

  factory OpenSalesOrderHeader.fromJson(
      Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      // log('resprespresp::${jsons['data'].toString()}');
      // var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'].toString() != 'No data found') {
        log('dddddddd');
        var list = jsonDecode(jsons['data']) as List; //jsonDecode
        List<OpenSalesOrderHeaderData> dataList = list
            .map((dynamic enquiries) =>
                OpenSalesOrderHeaderData.fromJson(enquiries))
            .toList();
        return OpenSalesOrderHeader(
          activitiesData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return OpenSalesOrderHeader(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          activitiesData: [],
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return OpenSalesOrderHeader(
        message: null,
        status: null,
        activitiesData: [],
        error: '',
        statusCode: stcode,
      );
    }
  }
  factory OpenSalesOrderHeader.error(String e, int stcode) {
    return OpenSalesOrderHeader(
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
class OpenSalesOrderHeaderData {
  int docEntry;
  int docNum;
  String cardCode;
  String docDate;
  double docTotal;
  String whsCode;
  String cardName;
  String? docStatus;
  String? comments;
  int? invoiceClr;
  bool? checkBClr;
  OpenSalesOrderHeaderData(
      {required this.docDate,
      required this.cardCode,
      required this.cardName,
      required this.comments,
      required this.docEntry,
      this.docStatus,
      this.checkBClr,
      this.invoiceClr,
      required this.docNum,
      required this.docTotal,
      required this.whsCode});

  factory OpenSalesOrderHeaderData.fromJson(dynamic jsons) {
    return OpenSalesOrderHeaderData(
        docDate: jsons['DocDate'] ?? '',
        cardCode: jsons['CardCode'] ?? "",
        cardName: jsons['CardName'] ?? "",
        comments: jsons['Comments'] ?? '',
        docStatus: jsons['DocStatus'] ?? "",
        docEntry: jsons['DocEntry'] ?? 0,
        docNum: jsons['DocNum'] ?? 0,
        docTotal: jsons['DocTotal'] ?? 0,
        whsCode: jsons['WhsCode'] ?? "");
  }
}
