// ignore_for_file: file_names

class WhsDetails {
  String? whsName;
  String? whsCode;
  String? gitWhs;
  String? companyName;
  String? whsPhoNo;
  String? whsmailID;
  String? whsGst;
  String? whsAddress;
  String? whsDistric;
  String? whsCity;
  String? pinCode;
  String? whsState;
  String? createdateTime;
  int? dbDocEntry;
  WhsDetails({
    required this.whsName,
    required this.whsCode,
    required this.gitWhs,
    required this.companyName,
    this.whsPhoNo,
    this.createdateTime,
    required this.whsmailID,
    required this.whsGst,
    required this.whsAddress,
    required this.whsDistric,
    required this.pinCode,
    required this.whsState,
    required this.whsCity,
    this.dbDocEntry,
  });
}

class CalCulteStReq {
  double? totalItem;
  double? qty;
  double? totalweight;
  double? totalLiter;

  CalCulteStReq(
      {required this.qty,
      required this.totalItem,
      required this.totalLiter,
      required this.totalweight});
}
