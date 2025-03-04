class AREinvoiceModel {
  AREinvoiceModel({
    required this.status,
    required this.message,
    required this.fetchBatchData,
    required this.error,
    required this.failedMsg,
    required this.statusCode,
  });

  int? status;
  String? message;
  AREinvoiceModelData? fetchBatchData;
  String? error;
  String? failedMsg;
  int? statusCode;

  factory AREinvoiceModel.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      if (jsons['statusMessage'].toString() == 'Success') {
        return AREinvoiceModel(
          fetchBatchData: AREinvoiceModelData.fromJson(jsons["responseData"]),
          message: jsons['statusMessage'].toString(),
          status: jsons['statusCode'],
          error: null,
          failedMsg: '',
          statusCode: stcode,
        );
      } else {
        return AREinvoiceModel(
          message: jsons['statusMessage'].toString(),
          status: jsons['statusCode'],
          fetchBatchData: null,
          error: jsons["responseData"].toString(),
          failedMsg: jsons["Error"] ?? '',
          statusCode: stcode,
        );
      }
    } else {
      return AREinvoiceModel(
        message: null,
        status: null,
        fetchBatchData: null,
        failedMsg: jsons["Error"].toString() ?? '',
        error: jsons["responseData"].toString(),
        statusCode: stcode,
      );
    }
  }
  factory AREinvoiceModel.error(String e, int stcode) {
    return AREinvoiceModel(
      message: null,
      status: null,
      fetchBatchData: null,
      failedMsg: '',
      error: e,
      statusCode: stcode,
    );
  }
}

class AREinvoiceModelData {
  String eInvoiceStatus;
  String savingQRFile;
  String updateToSAP;
  String qrValue;
  String qrPath;
  double rctCde;
  String zno;
  String vfdIn;
  String idate;
  String? itime;

  AREinvoiceModelData({
    required this.eInvoiceStatus,
    required this.savingQRFile,
    required this.updateToSAP,
    required this.qrValue,
    required this.qrPath,
    required this.rctCde,
    required this.zno,
    required this.vfdIn,
    required this.idate,
    required this.itime,
  });

  factory AREinvoiceModelData.fromJson(Map<String, dynamic> jsons) {
    return AREinvoiceModelData(
      eInvoiceStatus: jsons['eInvoiceStatus'] ?? '',
      savingQRFile: jsons['savingQRFile'] ?? '',
      qrValue: jsons['qrValue'] ?? '',
      qrPath: jsons['qrPath'] ?? '',
      rctCde: jsons['rctCde'] ?? '',
      zno: jsons['zno'] ?? '',
      vfdIn: jsons['vfdIn'] ?? '',
      idate: jsons['idate'] ?? '',
      itime: jsons['itime'] ?? '',
      updateToSAP: jsons['updateToSAP'] ?? '',
    );
  }
}
