import 'package:posproject/Models/ServiceLayerModel/ErrorModell/ErrorModelSl.dart';

class ForwardLeadUser {
  int stCode;
  ErrorModel? error;

  ForwardLeadUser({required this.stCode, this.error});

  factory ForwardLeadUser.fromjson(int stcode) {
    return ForwardLeadUser(stCode: stcode, error: null);
  }

  factory ForwardLeadUser.issue(Map<String, dynamic> json, int stcode) {
    return ForwardLeadUser(
        stCode: stcode, error: ErrorModel.fromJson(json['error']));
  }
}
