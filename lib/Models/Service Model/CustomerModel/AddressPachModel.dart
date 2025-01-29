import '../../DataModel/SeriesMode/SeriesModels.dart';

class CreatePatchModel {
  CreatePatchModel(
      {required this.error, required this.statusCode, required this.errorMsg});

  String? error;
  int? statusCode;
  Errors? errorMsg;

  factory CreatePatchModel.fromJson(int stcode) {
    return CreatePatchModel(error: null, statusCode: stcode, errorMsg: null);
  }
  factory CreatePatchModel.fromJson2(Map<String, dynamic> jsons, int stcode) {
    return CreatePatchModel(
      error: null,
      statusCode: stcode,
      errorMsg: Errors.fromJson(jsons["error"]),
    );
  }
  factory CreatePatchModel.issue(String resp, int stcode) {
    return CreatePatchModel(error: resp, statusCode: stcode, errorMsg: null);
  }
}
