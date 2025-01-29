// ignore_for_file: non_constant_identifier_names

const String tableRefundLine1 = "RefundLine1";

class RefundLineT {
  static String docentry = "docentry";
  static String rc_entry = "rc_entry";
  static String transType = "transType";
  static String branch = "branch";
  static String terminal = "terminal";
  static String transDocEnty = "transDocEnty";
  static String TransDocDate = "TransDocDate";
  static String TransDocNum = "TransDocNum";
  static String TransAmount = "TransAmount";
  static String createdateTime = 'createdateTime';
  static String updatedDatetime = "UpdatedDatetime";
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
  static String sapDocentry = "sapDocentry";
  static String sapDocNo = "sapDocNo";
  static String qStatus = "qStatus";
}

class RefundLineTDB {
  int? docentry;
  int? rc_entry;
  String? terminal;
  String? branch;
  String? transType;
  String? transDocEnty;
  String? TransDocDate;
  String? TransDocNum;
  String? TransAmount;
  String? createdateTime;
  String? updatedDatetime;
  String? createdUserID;
  String? updateduserid;
  String? lastupdateIp;
  int? sapDocentry;
  int? sapDocNo;
  String? qStatus;
  RefundLineTDB(
      {required this.TransAmount,
      required this.TransDocDate,
      required this.branch,
      required this.terminal,
      required this.TransDocNum,
      required this.createdUserID,
      required this.createdateTime,
      required this.docentry,
      required this.lastupdateIp,
      required this.rc_entry,
      required this.transDocEnty,
      required this.transType,
      required this.sapDocentry,
      required this.sapDocNo,
      this.qStatus,
      required this.updatedDatetime,
      required this.updateduserid});

  factory RefundLineTDB.fromjson(Map<String, dynamic> resp) {
    return RefundLineTDB(
        TransAmount: resp['TransAmount'].toString(),
        TransDocDate: resp['TransDocDate'] ?? "",
        branch: resp['branch'] ?? "",
        terminal: resp['terminal'] ?? "",
        TransDocNum: resp['TransDocNum'] ?? "",
        createdUserID: resp['createdUserID'].toString(),
        createdateTime: resp['createdateTime'] ?? "",
        docentry: resp['docentry'],
        lastupdateIp: resp['lastupdateIp'] ?? "",
        rc_entry: resp['rc_entry'] ?? "",
        transDocEnty: resp['transDocEnty'].toString(),
        transType: resp['transType'] ?? "",
        updatedDatetime: resp['updatedDatetime'] ?? "",
        sapDocNo: resp['sapDocNo'] == null
            ? null
            : int.parse(resp['sapDocNo'].toString()),
        sapDocentry: resp['sapDocentry'] == null
            ? null
            : int.parse(resp['sapDocentry'].toString()),
        qStatus: 'Y',
        updateduserid: resp['updateduserid'].toString());
  }

  Map<String, Object?> toMap(int docentry) => {
        RefundLineT.docentry: docentry,
        RefundLineT.TransAmount: TransAmount,
        RefundLineT.branch: branch,
        RefundLineT.terminal: terminal,
        RefundLineT.TransDocDate: TransDocDate,
        RefundLineT.TransDocNum: TransDocNum,
        RefundLineT.createdUserID: createdUserID,
        RefundLineT.createdateTime: createdateTime,
        RefundLineT.rc_entry: rc_entry,
        RefundLineT.transDocEnty: transDocEnty,
        RefundLineT.transType: transType,
        RefundLineT.createdUserID: createdUserID,
        RefundLineT.createdateTime: createdateTime,
        RefundLineT.lastupdateIp: lastupdateIp,
        RefundLineT.updatedDatetime: updatedDatetime,
        RefundLineT.updateduserid: updateduserid,
        RefundLineT.sapDocentry: sapDocentry,
        RefundLineT.sapDocNo: sapDocNo,
        RefundLineT.qStatus: qStatus,
      };
}
