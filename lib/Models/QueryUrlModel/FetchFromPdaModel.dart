import 'dart:convert';
import 'dart:developer';

class FetchBatchFromPdaModel {
  FetchBatchFromPdaModel({
    required this.status,
    required this.message,
    required this.fetchBatchData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<FetchFromPdaModelData>? fetchBatchData;
  String? error;
  int? statusCode;

  factory FetchBatchFromPdaModel.fromJson(
      Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      if (jsons['data'].toString() != 'No data found') {
        log('dddddddd');
        var list = jsonDecode(jsons['data']) as List;
        List<FetchFromPdaModelData> dataList = list
            .map((dynamic enquiries) =>
                FetchFromPdaModelData.fromJson(enquiries))
            .toList();
        return FetchBatchFromPdaModel(
          fetchBatchData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return FetchBatchFromPdaModel(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          fetchBatchData: [],
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return FetchBatchFromPdaModel(
        message: null,
        status: null,
        fetchBatchData: [],
        error: '',
        statusCode: stcode,
      );
    }
  }
  factory FetchBatchFromPdaModel.error(String e, int stcode) {
    return FetchBatchFromPdaModel(
      message: null,
      status: null,
      fetchBatchData: null,
      error: e,
      statusCode: stcode,
    );
  }
}

class FetchFromPdaModelData {
  String rowID;
  int docID;
  String docKeyCode;
  int docEntry;
  int lineID;
  double pickedQty;
  String objType;

  String batchNum;
  String itemCode;
  String? itemName;
  String whsCode;

  int? invoiceClr;
  bool? checkBClr;
  FetchFromPdaModelData({
    required this.rowID,
    required this.itemCode,
    required this.docID,
    required this.batchNum,
    this.itemName,
    this.checkBClr,
    this.invoiceClr,
    required this.pickedQty,
    required this.docKeyCode,
    required this.docEntry,
    required this.objType,
    required this.whsCode,
    required this.lineID,
  });

  factory FetchFromPdaModelData.fromJson(dynamic jsons) {
    return FetchFromPdaModelData(
      rowID: jsons['RowID'] ?? 0,
      docEntry: jsons['DocEntry'] ?? '',
      docID: jsons['DocID'] ?? '',
      docKeyCode: jsons['DocKeyCode'] ?? '',
      objType: jsons['ObjType'] ?? '',
      lineID: jsons['LineID'] ?? '',
      whsCode: jsons['WhsCode'] ?? '',
      pickedQty: jsons['PickedQty'] ?? 0,
      batchNum: jsons['BatchID'] ?? '',
      itemCode: jsons['ItemCode'] ?? '',
    );
  }
}
