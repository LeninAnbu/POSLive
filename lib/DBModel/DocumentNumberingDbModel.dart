const String tableDmtNum = "DocumentNumbering";


class DocNumT {
  static String seriesid = "seriesid";
  static String seriesname = "seriesname";
  static String transactiontype = "transactiontype";
  static String branch = "branch";
  static String user = "user";
  static String fromdate = "fromdate";
  static String todate = "todate";
  static String startno = "startno";
  static String endno = "endno";
  static String nextno = "nextno";
  static String prefix = "prefix";
  static String status = "status";
  static String createdateTime = 'createdateTime';
  static String updatedDatetime = "UpdatedDatetime";
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
}

class DocNumTModelDB {
  String? seriesid;
  String? seriesname;
  String? transactiontype;
  String? branch;
  String? user;
  String? fromdate;
  String? todate;
  String? startno;
  String? endno;
  String? nextno;
  String? prefix;
  String? status;   
  String? createdateTime;
  String? updatedDatetime;
  int? createdUserID;
  int? updateduserid;
  String? lastupdateIp;

  DocNumTModelDB({
      required this.branch,
      required this.createdUserID,
      required this.createdateTime,
      required this.endno,
      required this.fromdate,
      required this.lastupdateIp,
      required this.nextno,
      required this.prefix,
      required this.seriesid,
      required this.seriesname,
      required this.startno,
      required this.status,
      required this.todate,
      required this.transactiontype,
      required this.updatedDatetime,
      required this.updateduserid,
      required this.user
      });

  Map<String, Object?> toMap() => {
        DocNumT.branch:branch,
        DocNumT.endno:endno,
        DocNumT.fromdate:fromdate,
        DocNumT.nextno:nextno,
        DocNumT.prefix:prefix,
        DocNumT.seriesid:seriesid,
        DocNumT.seriesname:seriesname,
        DocNumT.startno:startno,
        DocNumT.status:status,
        DocNumT.todate:todate,
        DocNumT.transactiontype:transactiontype,
        DocNumT.user:user,
        DocNumT.createdUserID: createdUserID,
        DocNumT.createdateTime: createdateTime,
        DocNumT.lastupdateIp: lastupdateIp,
        DocNumT.updatedDatetime: updatedDatetime,
        DocNumT.updateduserid: updateduserid,
      };
}
