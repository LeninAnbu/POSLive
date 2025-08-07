import 'dart:developer';

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

      return SeriesListModel(
          odataMetadata: json["odata.metadata"],
          seriesvalue: List<SeriesValue>.from(
              json["value"].map((x) => SeriesValue.fromJson(x))),
          stsCode: stsCode);
    } else {
      return SeriesListModel(
          odataMetadata: null, seriesvalue: [], stsCode: stsCode);
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
}

class SeriesValue {
  String periodIndicator;
  String name;
  int series;

  SeriesValue({
    required this.periodIndicator,
    required this.name,
    required this.series,
  });

  factory SeriesValue.fromJson(Map<String, dynamic> json) => SeriesValue(
        periodIndicator: json["PeriodIndicator"] ?? '',
        name: json["Name"] ?? '',
        series: json["Series"],
      );

  Map<String, dynamic> toJson() => {
        "PeriodIndicator": periodIndicator,
        "Name": name,
        "Series": series,
      };
}

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
      lang: jsons['lang'] as String,
      value: jsons['value'] as String,
    );
  }
}
