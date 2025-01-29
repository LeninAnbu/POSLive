const String tableReceiptLine1 = "ReceiptLine1";

class ReceiptLineT {
  static String docentry = "docentry";
  static String rcEntry = "rc_entry";
  static String transType = "transType";
  static String branch = "branch";
  static String terminal = "terminal";
  static String transDocEnty = "transDocEnty";
  static String transDocDate = "TransDocDate";
  static String transDocNum = "TransDocNum";
  static String transAmount = "TransAmount";
  static String createdateTime = 'createdateTime';
  static String updatedDatetime = "UpdatedDatetime";
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
  static String sapDocentry = "sapDocentry";
  static String sapDocNo = "sapDocNo";
  static String qStatus = "qStatus";
}

class ReceiptLineTDB {
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
  ReceiptLineTDB(
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

  factory ReceiptLineTDB.fromjson(Map<String, dynamic> resp) {
    return ReceiptLineTDB(
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
        ReceiptLineT.docentry: docentry,
        ReceiptLineT.branch: branch,
        ReceiptLineT.terminal: terminal,
        ReceiptLineT.transAmount: TransAmount,
        ReceiptLineT.transDocDate: TransDocDate,
        ReceiptLineT.transDocNum: TransDocNum,
        ReceiptLineT.createdUserID: createdUserID,
        ReceiptLineT.createdateTime: createdateTime,
        ReceiptLineT.rcEntry: rc_entry,
        ReceiptLineT.transDocEnty: transDocEnty,
        ReceiptLineT.transType: transType,
        ReceiptLineT.createdUserID: createdUserID,
        ReceiptLineT.createdateTime: createdateTime,
        ReceiptLineT.lastupdateIp: lastupdateIp,
        ReceiptLineT.updatedDatetime: updatedDatetime,
        ReceiptLineT.updateduserid: updateduserid,
        ReceiptLineT.sapDocentry: sapDocentry,
        ReceiptLineT.sapDocNo: sapDocNo,
        ReceiptLineT.qStatus: qStatus,
      };
}
