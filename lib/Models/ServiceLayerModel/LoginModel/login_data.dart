import 'dart:convert';

import '../../DataModel/SeriesMode/SeriesModels.dart';

Logindata logindataFromJson(String str, int st) =>
    Logindata.fromJson(json.decode(str) as Map<String, dynamic>, st);

//String logindataToJson(Logindata data) => json.encode(data.toJson());

class Logindata {
  Logindata(
      {this.odataMetadata,
      this.sessionId,
      this.version,
      this.sessionTimeout,
      this.error,
      this.exception,
      required this.stCode});

  String? odataMetadata;
  String? sessionId;
  String? version;
  int? sessionTimeout;
  Errors? error;
  String? exception;
  int? stCode;

  factory Logindata.fromJson(Map<String, dynamic> json, int stcode) {
    return Logindata(
        odataMetadata: json["odata.metadata"] as String,
        sessionId: json["SessionId"] as String,
        version: json["Version"] as String,
        sessionTimeout: json["SessionTimeout"] as int,
        // ignore: avoid_redundant_argument_values
        error: null,
        exception: null,
        stCode: stcode);
    // }
  }
  factory Logindata.issue(String e, int stcode) {
    return Logindata(
        odataMetadata: null,
        sessionId: null,
        version: null,
        sessionTimeout: null,
        error: null,
        exception: e,
        stCode: stcode);
  }

  factory Logindata.error(Map<String, dynamic> json, int stcode) {
    return Logindata(
        odataMetadata: null,
        sessionId: null,
        version: null,
        sessionTimeout: null,
        error: Errors.fromJson(json['error']),
        exception: null,
        stCode: stcode);
  }
}
