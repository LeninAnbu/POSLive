// To parse this JSON data, do
//
//     final seriesListModel = seriesListModelFromJson(jsonString);

import 'dart:developer';

// SeriesListModel seriesListModelFromJson(String str) =>
//     SeriesListModel.fromJson(json.decode(str));

// String seriesListModelToJson(SeriesListModel data) =>
//     json.encode(data.toJson());

class SeriesListModel {
  String? odataMetadata;
  List<SeriesValue>? seriesvalue;
  Errors? error;
  String? exception;
  int? stsCode;
  SeriesListModel(
      {this.odataMetadata,
      this.seriesvalue,
      this.stsCode,
      this.error,
      this.exception});

  factory SeriesListModel.fromJson(Map<String, dynamic> json, int stsCode) {
    if (stsCode >= 200 && stsCode <= 210) {
      log('step1');
      // var list = jsonDecode(json['value']) as List;
      // log('step2::$list');

      // List<SeriesValue> dataList =
      //     list.map((data) => SeriesValue.fromJson(data)).toList();

      return SeriesListModel(
          odataMetadata: json["odata.metadata"],
          seriesvalue: List<SeriesValue>.from(
              json["value"].map((x) => SeriesValue.fromJson(x))),
          stsCode: stsCode
          //  List<SeriesValue>.from(
          //     json["value"].map((x) => SeriesValue.fromJson(x))),
          );
    } else {
      return SeriesListModel(
          odataMetadata: null, seriesvalue: [], stsCode: stsCode
          //  List<SeriesValue>.from(
          //     json["value"].map((x) => SeriesValue.fromJson(x))),
          );
    }
  }
  factory SeriesListModel.issue(String e, int stsCode) {
    return SeriesListModel(exception: e, stsCode: stsCode);
  }
  factory SeriesListModel.error(Map<String, dynamic> json, int stsCode) {
    return SeriesListModel(
      error: Errors.fromJson(json['error']),
    );
  }
  // Map<String, dynamic> toJson() => {
  //       "odata.metadata": odataMetadata,
  //       "value": List<dynamic>.from(value.map((x) => x.toJson())),
  //     };
}

class SeriesValue {
  String periodIndicator;
  String name;
  int series;

  // String document;
  // DocumentSubType documentSubType;
  // int initialNumber;
  // int lastNumber;
  // int nextNumber;
  // String prefix;
  // dynamic suffix;
  // dynamic remarks;
  // GroupCode groupCode;
  // CostAccountOnly locked;

  // CostAccountOnly isDigitalSeries;
  // dynamic digitNumber;
  // SeriesType seriesType;
  // CostAccountOnly isManual;
  // dynamic bplid;
  // dynamic atDocumentType;
  // CostAccountOnly isElectronicCommEnabled;
  // CostAccountOnly costAccountOnly;
  // dynamic invoiceType;
  // dynamic invoiceTypeOfNegativeInvoice;
  // dynamic portugalSeriesAction;
  // dynamic portugalSeriesStatus;
  // dynamic portugalSeriesPhase;

  SeriesValue({
    required this.periodIndicator,
    required this.name,
    required this.series,

    // required this.document,
    // required this.documentSubType,
    // required this.initialNumber,
    // required this.lastNumber,
    // required this.nextNumber,
    // required this.prefix,
    // required this.suffix,
    // required this.remarks,
    // required this.groupCode,
    // required this.locked,

    // required this.isDigitalSeries,
    // required this.digitNumber,
    // required this.seriesType,
    // required this.isManual,
    // required this.bplid,
    // required this.atDocumentType,
    // required this.isElectronicCommEnabled,
    // required this.costAccountOnly,
    // required this.invoiceType,
    // required this.invoiceTypeOfNegativeInvoice,
    // required this.portugalSeriesAction,
    // required this.portugalSeriesStatus,
    // required this.portugalSeriesPhase,
  });

  factory SeriesValue.fromJson(Map<String, dynamic> json) => SeriesValue(
        periodIndicator: json["PeriodIndicator"] ?? '',
        name: json["Name"] ?? '',
        series: json["Series"],
        // document: json["Document"],
        // documentSubType: documentSubTypeValues.map[json["DocumentSubType"]]!,
        // initialNumber: json["InitialNumber"],
        // lastNumber: json["LastNumber"],
        // nextNumber: json["NextNumber"],
        // prefix: json["Prefix"],
        // suffix: json["Suffix"],
        // remarks: json["Remarks"],
        // groupCode: groupCodeValues.map[json["GroupCode"]]!,
        // locked: costAccountOnlyValues.map[json["Locked"]]!,

        // isDigitalSeries: costAccountOnlyValues.map[json["IsDigitalSeries"]]!,
        // digitNumber: json["DigitNumber"],
        // seriesType: seriesTypeValues.map[json["SeriesType"]]!,
        // isManual: costAccountOnlyValues.map[json["IsManual"]]!,
        // bplid: json["BPLID"],
        // atDocumentType: json["ATDocumentType"],
        // isElectronicCommEnabled:
        //     costAccountOnlyValues.map[json["IsElectronicCommEnabled"]]!,
        // costAccountOnly: costAccountOnlyValues.map[json["CostAccountOnly"]]!,
        // invoiceType: json["InvoiceType"],
        // invoiceTypeOfNegativeInvoice: json["InvoiceTypeOfNegativeInvoice"],
        // portugalSeriesAction: json["PortugalSeriesAction"],
        // portugalSeriesStatus: json["PortugalSeriesStatus"],
        // portugalSeriesPhase: json["PortugalSeriesPhase"],
      );

  Map<String, dynamic> toJson() => {
        "PeriodIndicator": periodIndicator,
        "Name": name,
        "Series": series,
        // "Document": document,
        // "DocumentSubType": documentSubTypeValues.reverse[documentSubType],
        // "InitialNumber": initialNumber,
        // "LastNumber": lastNumber,
        // "NextNumber": nextNumber,
        // "Prefix": prefix,
        // "Suffix": suffix,
        // "Remarks": remarks,
        // "GroupCode": groupCodeValues.reverse[groupCode],
        // "Locked": costAccountOnlyValues.reverse[locked],

        // "IsDigitalSeries": costAccountOnlyValues.reverse[isDigitalSeries],
        // "DigitNumber": digitNumber,
        // "SeriesType": seriesTypeValues.reverse[seriesType],
        // "IsManual": costAccountOnlyValues.reverse[isManual],
        // "BPLID": bplid,
        // "ATDocumentType": atDocumentType,
        // "IsElectronicCommEnabled":
        //     costAccountOnlyValues.reverse[isElectronicCommEnabled],
        // "CostAccountOnly": costAccountOnlyValues.reverse[costAccountOnly],
        // "InvoiceType": invoiceType,
        // "InvoiceTypeOfNegativeInvoice": invoiceTypeOfNegativeInvoice,
        // "PortugalSeriesAction": portugalSeriesAction,
        // "PortugalSeriesStatus": portugalSeriesStatus,
        // "PortugalSeriesPhase": portugalSeriesPhase,
      };
}

// import 'dart:convert';

// SeriesModal logindataFromJson(String str) =>
//     SeriesModal.fromJson(json.decode(str) as Map<String, dynamic>);

// class SeriesModal {
//   SeriesModal({
//     this.Series,
//     this.error,
//     this.exception,
//   });

//   int? Series;
// Errors? error;
// String? exception;

//   factory SeriesModal.fromJson(Map<String, dynamic> json) {
//     return SeriesModal(
//       Series: json['Series'] as int,
//     );
//   }
// factory SeriesModal.issue(String e) {
//   return SeriesModal(
//     exception: e,
//   );
// }

// factory SeriesModal.error(Map<String, dynamic> json) {
//   return SeriesModal(
//     error: Errors.fromJson(json['error']),
//   );
// }
// }

class Errors {
  int? code;
  Message? message;
  Errors({
    this.code,
    this.message,
  });

  factory Errors.fromJson(dynamic jsons) {
    return Errors(
      code: jsons['code'] as int,
      message: Message.fromJson(jsons['message']),
    );
  }
}

class Message {
  String? lang;
  String? value;
  Message({
    this.lang,
    this.value,
  });

  factory Message.fromJson(dynamic jsons) {
    return Message(
      //  groupCode: jsons['GroupCode'] as int,
      lang: jsons['lang'] as String,
      value: jsons['value'] as String,
    );
  }
}
