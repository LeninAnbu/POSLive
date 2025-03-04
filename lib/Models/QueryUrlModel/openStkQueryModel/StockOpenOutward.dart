// {status: true, msg: Success,
//data: [{"DocEntry":326488,"DocNum":14286,"DocDate":"2020-11-17T00:00:00","CardCode":"D0935",
//"CardName":"ADVERTISEMENT A/C- CORPORATE","DocTotal":133222.000000,"WhsCode":"HOFG"},
//{"DocEntry":344890,"DocNum":4001298,"DocDate":"2021-04-27T00:00:00","CardCode":"D6080","CardName":"SHUBI INVESTMENT - MBEYA","DocTotal":5715920.000000,"WhsCode":"HOFG"},{"DocEntry":366317,"DocNum":8447,"DocDate":"2021-11-10T00:00:00","CardCode":"D0999","CardName":"CASH SALES HO A/C","DocTotal":228448.000000,"WhsCode":"HOFG"},{"DocEntry":368144,"DocNum":8921,"DocDate":"2021-11-25T00:00:00","CardCode":"D0935","CardName":"ADVERTISEMENT A/C- CORPORATE","DocTotal":23600.000000,"WhsCode":"HOFG"},{"DocEntry":368145,"DocNum":8922,"DocDate":"2021-11-25T00:00:00","CardCode":"D0935","CardName":"ADVERTISEMENT A/C- CORPORATE","DocTotal":29500.000000,"WhsCode":"HOFG"}
import 'dart:convert';
import 'dart:developer';

class OpenStkOutwardModl {
  OpenStkOutwardModl({
    required this.status,
    required this.message,
    required this.activitiesData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<OpenStkOutwardModlData>? activitiesData;
  String? error;
  int? statusCode;

  factory OpenStkOutwardModl.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      // var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'].toString() != 'No data found') {
        log('dddddddd');
        var list = jsonDecode(jsons['data']) as List; //jsonDecode
        List<OpenStkOutwardModlData> dataList = list
            .map((dynamic enquiries) =>
                OpenStkOutwardModlData.fromJson(enquiries))
            .toList();
        return OpenStkOutwardModl(
          activitiesData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return OpenStkOutwardModl(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          activitiesData: [],
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return OpenStkOutwardModl(
        message: null,
        status: null,
        activitiesData: [],
        error: '',
        statusCode: stcode,
      );
    }
  }
  factory OpenStkOutwardModl.error(String e, int stcode) {
    return OpenStkOutwardModl(
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
class OpenStkOutwardModlData {
  int docEntry;
  int docNum;
  String docDate;
  String cardCode;

  // double docTotal;
  String fromwhsCode;
  String? tomwhsCode;

  // String cardName;
  int? invoiceClr;
  bool? checkBClr;
  OpenStkOutwardModlData(
      {required this.docDate,
      required this.docEntry,
      this.checkBClr,
      this.invoiceClr,
      required this.cardCode,
      required this.docNum,
      this.tomwhsCode,
      required this.fromwhsCode});

  factory OpenStkOutwardModlData.fromJson(dynamic jsons) {
    return OpenStkOutwardModlData(
      docDate: jsons['DocDate'] ?? '',
      fromwhsCode: jsons['FromWhs'] ?? '',
      cardCode: jsons['CardCode'] ?? '',
      docEntry: jsons['DocEntry'] ?? 0,
      docNum: jsons['DocNum'] ?? 0,
    );
  }
}
