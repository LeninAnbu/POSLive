const String tableSalesOrderHeader = "SalesOrderHeader";

class SalesOrderHeaderT {
  static String docentry = "docentry";
  static String doctype = "doctype";
  static String objtype = 'objtype';
  static String objname = 'objname';
  static String editType = 'editType';
  static String terminal = "terminal";
  static String branch = "branch";
  static String basedocentry = "basedocentry";
  static String sodocno = "sodocno";
  static String customerSeriesNum = 'customerSeriesNum';
  static String sodocseries = "sodocseries";
  static String sodocseriesno = "sodocseriesno";
  static String sotransdate = "sotransdate";
  static String sodoctime = "sodoctime";
  static String sosystime = "sosystime";
  static String documentno = 'documentno';
  static String seresid = "seresid";
  static String seriesnum = "seriesnum";
  static String transactiondate = "transactiondate";
  static String transtime = "transtime";
  static String sysdatetime = "sysdatetime";
  static String customercode = "customercode";
  static String customername = 'customername';
  static String customerphono = 'customerphono';
  static String customeremail = 'customeremail';
  static String customeraccbal = 'customeraccbal';
  static String customerpoint = 'customerpoint';
  static String premiumid = "premiumid";
  static String customertype = "customertype";
  static String taxno = "taxno";
  static String city = "city";
  static String state = "state";
  static String pinno = "pinno";
  static String tinNo = "TinNo";
  static String vatno = "VatNo";
  static String gst = "gst";
  static String country = "country";
  static String shipaddresid = "shipaddresid";
  static String billaddressid = "billaddressid";
  static String billtype = "billtype";
  static String docbasic = 'docbasic';
  static String taxamount = "taxamount";
  static String docdiscuntpercen = "docdiscuntpercen";
  static String docdiscamt = "docdiscamt";
  static String doctotal = "doctotal";
  static String baltopay = "baltopay";
  static String remarks = "remarks";
  static String createdbyuser = 'createdbyuser';
  static String docstatus = "docstatus";
  static String paystatus = "paystatus";
  static String amtpaid = "amtpaid";
  static String salesexec = "salesexec";
  static String createdateTime = 'createdateTime';
  static String updatedDatetime = "UpdatedDatetime";
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
  static String sapDocentry = "sapDocentry";
  static String sapDocNo = "sapDocNo";
  static String qStatus = "qStatus";
  static String totalltr = "totalltr";
  static String totalweight = "totalweight";
  static String uDeviceId = 'U_DeviceId';
  static String custRefNo = 'CustRefNo';
  static String uOrderDate = 'U_OrderDate';
  static String uOrderType = 'U_Order_Type';
  static String uGPApproval = 'U_GP_Approval';
  static String uReceivedTime = 'U_Received_Time';
}

class SalesOrderHeaderModelDB {
  String editType;
  String tinNo;
  String vatno;
  String custRefNo;
  String? customerSeriesNum;
  String? billaddressid;
  String? docentry;
  String? basedocentry;
  String? terminal;
  String? doctype;
  String? objtype;
  String? objname;
  String? branch;
  String? sodocno;
  String? sodocseries;
  String? sodocseriesno;
  String? sotransdate;
  String? sodoctime;
  String? sosystime;
  String? documentno;
  String? seresid;
  String? seriesnum;
  String? transactiondate;
  String? transtime;
  String? sysdatetime;
  String? customercode;
  String? customername;
  String? customeraccbal;
  String? customeremail;
  String? customerphono;
  String? customerpoint;
  String? premiumid;
  String? customertype;
  String? taxno;
  String? addressName1;
  String? street;
  String? block;
  String? country;
  String? city;
  String? state;
  String? pinno;
  String? gst;
  String? shipaddresid;
  String? billtype;
  String? docbasic;
  String? taxamount;
  String? docdiscuntpercen;
  String? docdiscamt;
  String? doctotal;
  String? baltopay;
  String? remarks;
  String? createdbyuser;
  String? docstatus;
  String? paystatus;
  String? amtpaid;
  String? salesexec;
  String? createdateTime;
  String? updatedDatetime;
  String? createdUserID;
  String? updateduserid;
  String? lastupdateIp;
  int? sapDocentry;
  int? sapDocNo;
  String? qStatus;
  double? totalltr;
  double? totalweight;
  String uDeviceId;
  String? uOrderDate;
  String? uOrderType;
  String? uGPApproval;
  String? uReceivedTime;
  SalesOrderHeaderModelDB({
    required this.uDeviceId,
    required this.tinNo,
    required this.vatno,
    required this.custRefNo,
    required this.editType,
    required this.amtpaid,
    required this.customerSeriesNum,
    this.billaddressid,
    required this.country,
    required this.city,
    required this.state,
    required this.gst,
    required this.pinno,
    required this.baltopay,
    required this.basedocentry,
    this.addressName1,
    this.street,
    this.block,
    required this.uOrderDate,
    required this.uOrderType,
    required this.uGPApproval,
    required this.uReceivedTime,
    required this.billtype,
    required this.branch,
    required this.createdUserID,
    required this.createdateTime,
    required this.createdbyuser,
    required this.customerphono,
    required this.customeremail,
    required this.customerpoint,
    required this.customeraccbal,
    required this.customercode,
    required this.customername,
    required this.customertype,
    required this.docbasic,
    required this.docdiscamt,
    required this.docdiscuntpercen,
    this.docentry,
    this.doctype,
    this.objtype,
    this.objname,
    required this.terminal,
    required this.docstatus,
    required this.doctotal,
    this.documentno,
    required this.lastupdateIp,
    required this.paystatus,
    required this.totalltr,
    required this.totalweight,
    required this.premiumid,
    required this.remarks,
    required this.salesexec,
    required this.seresid,
    required this.seriesnum,
    required this.shipaddresid,
    required this.sodocno,
    required this.sodocseries,
    required this.sodocseriesno,
    required this.sodoctime,
    required this.sosystime,
    required this.sotransdate,
    required this.sysdatetime,
    required this.taxamount,
    required this.taxno,
    required this.transactiondate,
    required this.transtime,
    required this.updatedDatetime,
    required this.updateduserid,
    required this.sapDocentry,
    required this.sapDocNo,
    this.qStatus,
  });

  factory SalesOrderHeaderModelDB.fromjson(Map<String, dynamic> resp) {
    return SalesOrderHeaderModelDB(
      street: resp['street'],
      tinNo: resp['TinNo'],
      vatno: resp['VatNo'],
      block: resp['block'],
      docentry: resp['docentry'].toString(),
      basedocentry: resp['basedocentry'].toString(),
      doctype: resp['doctype'],
      objtype: resp['objtype'],
      objname: resp['objname'],
      documentno: resp['documentno'],
      amtpaid: resp['amtpaid'],
      country: resp['country'],
      city: resp['city'],
      state: resp['state'],
      gst: resp['gst'],
      pinno: resp['pinno'],
      baltopay: resp['baltopay'],
      billtype: resp['billtype'],
      branch: resp['branch'],
      createdUserID: resp['createdUserID'].toString(),
      createdateTime: resp['createdateTime'],
      createdbyuser: resp['createdbyuser'],
      customerphono: resp['customerphono'],
      customeremail: resp['customeremail'],
      customerpoint: resp['customerpoint'],
      customeraccbal: resp['customeraccbal'],
      customercode: resp['customercode'],
      customername: resp['customername'],
      customertype: resp['customertype'],
      docbasic: resp['docbasic'],
      docdiscamt: resp['docdiscamt'],
      docdiscuntpercen: resp['docdiscuntpercen'],
      terminal: resp['terminal'],
      docstatus: resp['docstatus'],
      doctotal: resp['doctotal'],
      lastupdateIp: resp['lastupdateIp'],
      paystatus: resp['paystatus'],
      premiumid: resp['premiumid'],
      remarks: resp['remarks'],
      salesexec: resp['salesexec'],
      seresid: resp['seresid'],
      seriesnum: resp['seriesnum'],
      shipaddresid: resp['shipaddresid'],
      sodocno: resp['sodocno'],
      sodocseries: resp['sodocseries'],
      sodocseriesno: resp['sodocseriesno'],
      sodoctime: resp['sodoctime'],
      sosystime: resp['sosystime'],
      sotransdate: resp['sotransdate'],
      sysdatetime: resp['sysdatetime'],
      taxamount: resp['taxamount'],
      taxno: resp['taxno'],
      transactiondate: resp['transactiondate'],
      totalweight: double.parse(resp['totalweight'].toString()),
      totalltr: double.parse(resp['totalltr'].toString()),
      transtime: resp['transtime'],
      updatedDatetime: resp['UpdatedDatetime'],
      updateduserid: resp['updateduserid'].toString(),
      sapDocNo: resp['sapDocNo'] == null
          ? null
          : int.parse(resp['sapDocNo'].toString()),
      sapDocentry: resp['sapDocentry'] == null
          ? null
          : int.parse(resp['sapDocentry'].toString()),
      qStatus: 'Y',
      customerSeriesNum: resp['customerSeriesNum'].toString(),
      editType: resp['editType'].toString(),
      uOrderDate: resp['U_OrderDate'].toString(),
      uOrderType: resp['U_Order_Type'].toString(),
      uGPApproval: resp['U_GP_Approval'].toString(),
      uReceivedTime: resp['U_Received_Time'].toString(),
      uDeviceId: resp['U_DeviceId'].toString(),
      custRefNo: resp['CustRefNo'].toString(),
    );
  }

  Map<String, Object?> toMap() => {
        SalesOrderHeaderT.basedocentry: basedocentry,
        SalesOrderHeaderT.editType: editType,
        SalesOrderHeaderT.tinNo: tinNo,
        SalesOrderHeaderT.vatno: vatno,
        SalesOrderHeaderT.customerphono: customerphono,
        SalesOrderHeaderT.terminal: terminal,
        SalesOrderHeaderT.customeraccbal: customeraccbal,
        SalesOrderHeaderT.customeremail: customeremail,
        SalesOrderHeaderT.customerpoint: customerpoint,
        SalesOrderHeaderT.amtpaid: amtpaid,
        SalesOrderHeaderT.baltopay: baltopay,
        SalesOrderHeaderT.billaddressid: billaddressid,
        SalesOrderHeaderT.customerSeriesNum: customerSeriesNum,
        SalesOrderHeaderT.country: country,
        SalesOrderHeaderT.city: city,
        SalesOrderHeaderT.state: state,
        SalesOrderHeaderT.pinno: pinno,
        SalesOrderHeaderT.totalweight: totalweight,
        SalesOrderHeaderT.totalltr: totalltr,
        SalesOrderHeaderT.gst: gst,
        SalesOrderHeaderT.billtype: billtype,
        SalesOrderHeaderT.branch: branch,
        SalesOrderHeaderT.createdUserID: createdUserID,
        SalesOrderHeaderT.createdateTime: createdateTime,
        SalesOrderHeaderT.createdbyuser: createdbyuser,
        SalesOrderHeaderT.customercode: customercode,
        SalesOrderHeaderT.customername: customername,
        SalesOrderHeaderT.customertype: customertype,
        SalesOrderHeaderT.docbasic: docbasic,
        SalesOrderHeaderT.docdiscamt: docdiscamt,
        SalesOrderHeaderT.docdiscuntpercen: docdiscuntpercen,
        SalesOrderHeaderT.docentry: docentry,
        SalesOrderHeaderT.doctype: doctype,
        SalesOrderHeaderT.objtype: objtype,
        SalesOrderHeaderT.objname: objname,
        SalesOrderHeaderT.docstatus: docstatus,
        SalesOrderHeaderT.doctotal: doctotal,
        SalesOrderHeaderT.documentno: documentno,
        SalesOrderHeaderT.lastupdateIp: lastupdateIp,
        SalesOrderHeaderT.paystatus: paystatus,
        SalesOrderHeaderT.premiumid: premiumid,
        SalesOrderHeaderT.remarks: remarks,
        SalesOrderHeaderT.salesexec: salesexec,
        SalesOrderHeaderT.seresid: seresid,
        SalesOrderHeaderT.seriesnum: seriesnum,
        SalesOrderHeaderT.shipaddresid: shipaddresid,
        SalesOrderHeaderT.sodocno: sodocno,
        SalesOrderHeaderT.sodocseries: sodocseries,
        SalesOrderHeaderT.sodocseriesno: sodocseriesno,
        SalesOrderHeaderT.sodoctime: sodoctime,
        SalesOrderHeaderT.sotransdate: sotransdate,
        SalesOrderHeaderT.sosystime: sosystime,
        SalesOrderHeaderT.sysdatetime: sysdatetime,
        SalesOrderHeaderT.taxamount: taxamount,
        SalesOrderHeaderT.taxno: taxno,
        SalesOrderHeaderT.transactiondate: transactiondate,
        SalesOrderHeaderT.transtime: transtime,
        SalesOrderHeaderT.updatedDatetime: updatedDatetime,
        SalesOrderHeaderT.updateduserid: updateduserid,
        SalesOrderHeaderT.sapDocentry: sapDocentry,
        SalesOrderHeaderT.sapDocNo: sapDocNo,
        SalesOrderHeaderT.qStatus: qStatus,
        SalesOrderHeaderT.uGPApproval: uGPApproval,
        SalesOrderHeaderT.uOrderDate: uOrderDate,
        SalesOrderHeaderT.uOrderType: uOrderType,
        SalesOrderHeaderT.uReceivedTime: uReceivedTime,
        SalesOrderHeaderT.uDeviceId: uDeviceId,
        SalesOrderHeaderT.custRefNo: custRefNo,
      };
}
