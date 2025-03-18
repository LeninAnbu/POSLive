const String tableExpense = "Expense";

class ExpenseT {
  static String docentry = "docentry";
  static String lineid = "lineid";
  static String documentno = "documentno";
  static String expensecode = "expencecode";
  static String reference = "reference";
  static String rcamount = "rcamount";
  static String remarks = "remarks";
  static String attachment = "attachment";
  static String paidto = "paidto";
  static String paidfrom = "paidfrom";
  static String docstatus = "docstatus";
  static String doctype = "doctype";
  static String createdateTime = 'createdateTime';
  static String rcmode = "rcmode";
  static String terminal = "terminal";
  static String branch = "branch";
  static String sapDocentry = "sapDocentry";
  static String sapDocNo = "sapDocNo";
  static String uDeviceId = 'U_DeviceId';
  static String uRVC = 'U_RVC';
  static String taxCode = 'TaxCode';
  static String distRule = 'DistRule';
  static String projectCode = 'projectCode';

  static String qStatus = "qStatus";
}

class ExpenseDBModel {
  String? terminal;
  String? attachment;
  String? remarks;
  String? branch;
  String? lineid;
  String? docentry;
  String? documentno;
  String? expensecode;
  String? reference;
  String? rcamount;
  String? paidto;
  String? paidfrom;
  String? docstatus;
  String? doctype;
  String? createdateTime;
  String? rcmode;
  int? sapDocentry;
  int? sapDocNo;
  String? uDeviceId;
  String? uRVC;
  String? taxCode;
  String? distRule;
  String? projectCode;

  String? qStatus;

  ExpenseDBModel({
    required this.terminal,
    this.docentry,
    required this.lineid,
    this.attachment,
    required this.documentno,
    required this.distRule,
    required this.taxCode,
    required this.uRVC,
    required this.projectCode,
    required this.expensecode,
    required this.reference,
    required this.remarks,
    required this.rcamount,
    required this.uDeviceId,
    required this.paidto,
    required this.paidfrom,
    required this.docstatus,
    required this.doctype,
    required this.createdateTime,
    required this.rcmode,
    required this.branch,
    required this.sapDocentry,
    required this.sapDocNo,
    this.qStatus,
  });

  factory ExpenseDBModel.fromjson(Map<String, dynamic> resp) {
    return ExpenseDBModel(
        docentry: resp['docentry'].toString(),
        projectCode: resp['docentry'].toString(),
        terminal: resp['terminal'],
        lineid: resp['lineid'].toString(),
        documentno: resp['documentno'].toString(),
        expensecode: resp['expensecode'].toString(),
        reference: resp['reference'],
        rcamount: resp['rcamount'].toString(),
        paidto: resp['paidto'],
        distRule: resp['reference'],
        uRVC: resp['rcamount'].toString(),
        taxCode: resp['paidto'],
        paidfrom: resp['paidfrom'],
        remarks: resp['remarks'],
        docstatus: resp['docstatus'],
        doctype: resp['doctype'],
        createdateTime: resp['createdateTime'],
        rcmode: resp['rcmode'],
        branch: resp['branch'],
        sapDocNo: resp['sapDocNo'] == null
            ? null
            : int.parse(resp['sapDocNo'].toString()),
        sapDocentry: resp['sapDocentry'] == null
            ? null
            : int.parse(resp['sapDocentry'].toString()),
        qStatus: 'Y',
        uDeviceId: '');
  }
  Map<String, Object?> toMap() => {
        ExpenseT.docentry: docentry,
        ExpenseT.attachment: attachment,
        ExpenseT.lineid: lineid,
        ExpenseT.terminal: terminal,
        ExpenseT.documentno: documentno,
        ExpenseT.expensecode: expensecode,
        ExpenseT.reference: reference,
        ExpenseT.rcamount: rcamount,
        ExpenseT.paidto: paidto,
        ExpenseT.paidfrom: paidfrom,
        ExpenseT.uDeviceId: uDeviceId,
        ExpenseT.docstatus: docstatus,
        ExpenseT.remarks: remarks,
        ExpenseT.doctype: doctype,
        ExpenseT.createdateTime: createdateTime,
        ExpenseT.rcmode: rcmode,
        ExpenseT.branch: branch,
        ExpenseT.sapDocentry: sapDocentry,
        ExpenseT.sapDocNo: sapDocNo,
        ExpenseT.qStatus: qStatus,
        ExpenseT.projectCode: projectCode,
        ExpenseT.uRVC: uRVC,
        ExpenseT.taxCode: taxCode,
        ExpenseT.distRule: distRule,
      };
}
