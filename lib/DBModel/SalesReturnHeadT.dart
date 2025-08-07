const String tableSalesRetHeader = "SalesReturnHeader";

class SalesReturnHeaderT {
  static String docentry = "docentry";
  static String doctype = "doctype";
  static String objtype = 'objtype';
  static String objname = 'objname';
  static String basedocentry = "basedocentry";
  static String branch = "branch";
  static String terminal = "terminal";
  static String basedocnum = "basedocnum";
  static String sodocno = "sodocno";
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
  static String billaddressid = "billaddressid";
  static String city = "city";
  static String state = "state";
  static String pinno = "pinno";
  static String gst = "gst";
  static String country = "country";
  static String shipaddresid = "shipaddresid";
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
  static String uDeviceId = 'U_DeviceId';
  static String sapInvoicedocentry = 'sapInvoicedocentry';
  static String sapInvoicedocnum = 'sapInvoicedocnum';
  static String totalltr = "totalltr";
  static String totalweight = "totalweight";
}

class SalesReturnTModelDB {
  String? terminal;
  String? branch;

  String? docentry;
  String? doctype;
  String? objtype;
  String? objname;
  String? basedocentry;
  String? basedocnum;
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
  String? billaddressid;
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
  String uDeviceId;
  String? salesexec;
  String? createdateTime;
  String? updatedDatetime;
  String? createdUserID;
  String? updateduserid;
  String? lastupdateIp;
  String? sapInvoicedocentry;
  String? sapInvoicedocnum;
  String? sapDocentry;
  String? sapDocNo;
  String? qStatus;
  double? totalltr;
  double? totalweight;

  SalesReturnTModelDB({
    required this.amtpaid,
    required this.country,
    required this.city,
    required this.state,
    required this.gst,
    required this.pinno,
    required this.baltopay,
    required this.billaddressid,
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
    required this.uDeviceId,
    required this.customername,
    required this.customertype,
    required this.docbasic,
    required this.docdiscamt,
    required this.docdiscuntpercen,
    required this.terminal,
    required this.docentry,
    required this.doctype,
    this.objtype,
    this.objname,
    required this.basedocentry,
    required this.basedocnum,
    required this.docstatus,
    required this.doctotal,
    required this.documentno,
    required this.lastupdateIp,
    required this.paystatus,
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
    required this.qStatus,
    required this.sapInvoicedocentry,
    required this.sapInvoicedocnum,
    required this.sapDocentry,
    required this.sapDocNo,
    required this.totalltr,
    required this.totalweight,
  });
  factory SalesReturnTModelDB.fromjson(Map<String, dynamic> resp) {
    return SalesReturnTModelDB(
      docentry: resp['docentry'].toString(),
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
      transtime: resp['transtime'],
      updatedDatetime: resp['UpdatedDatetime'],
      updateduserid: resp['updateduserid'].toString(),
      basedocentry: resp['basedocentry'],
      basedocnum: resp['basedocnum'],
      billaddressid: resp['billaddressid'],
      totalweight: double.parse(resp['totalweight'].toString()),
      totalltr: double.parse(resp['totalltr'].toString()),
      qStatus: 'Y',
      sapInvoicedocentry: resp['sapInvoicedocentry'].toString(),
      sapInvoicedocnum: resp['sapInvoicedocnum'].toString(),
      sapDocNo: resp['sapDocNo'],
      uDeviceId: resp['U_DeviceTransID'] ?? '',
      sapDocentry: resp['sapDocentry'],
    );
  }

  Map<String, dynamic> toJson() => {
        'docentry': docentry,
        'documentno': documentno,
        'doctype': doctype,
        "city": city,
        "state": state,
        "gst": gst,
        "pinno": pinno,
        "baltopay": baltopay,
        "billtype": billtype,
        "branch": branch,
        "createdUserID": createdUserID.toString(),
        "createdateTime": createdateTime,
        "createdbyuser": createdbyuser,
        "customerphono": customerphono,
        "customeremail": customeremail,
        "customerpoint": customerpoint,
        "customeraccbal": customeraccbal,
        "customercode": customercode,
        "customername": customername,
        "customertype": customertype,
        "docbasic": docbasic,
        "docdiscamt": docdiscamt,
        "docdiscuntpercen": docdiscuntpercen,
        "terminal": terminal,
        "docstatus": docstatus,
        "doctotal": doctotal,
        "lastupdateIp": lastupdateIp,
        "paystatus": paystatus,
        "premiumid": premiumid,
        "remarks": remarks,
        "salesexec": salesexec,
        "seresid": seresid,
        "seriesnum": seriesnum,
        "shipaddresid": shipaddresid,
        "sodocno": sodocno,
        "sodocseries": sodocseries,
        "sodocseriesno": sodocseriesno,
        "sodoctime": sodoctime,
        "sosystime": sosystime,
        "sotransdate": sotransdate,
        "sysdatetime": sysdatetime,
        "taxamount": taxamount,
        "taxno": taxno,
        "transactiondate": transactiondate,
        "transtime": transtime,
        "updatedDatetime": updatedDatetime,
        "UpdatedDatetime": updateduserid.toString(),
        "basedocentry": basedocentry,
        "basedocnum": basedocnum,
        "billaddressid": billaddressid,
        "totalweight": totalweight.toString(),
        "totalltr": totalltr.toString(),
        "qStatus": qStatus,
        "sapInvoicedocentry": sapInvoicedocentry.toString(),
        "sapInvoicedocnum": sapInvoicedocnum.toString(),
        "sapDocNo": sapDocNo,
        "sapDocentry": sapDocentry,
        'U_DeviceTransID': uDeviceId
      };

  Map<String, Object?> toMap() => {
        SalesReturnHeaderT.customerphono: customerphono,
        SalesReturnHeaderT.terminal: terminal,
        SalesReturnHeaderT.uDeviceId: uDeviceId,
        SalesReturnHeaderT.customeraccbal: customeraccbal,
        SalesReturnHeaderT.customeremail: customeremail,
        SalesReturnHeaderT.customerpoint: customerpoint,
        SalesReturnHeaderT.amtpaid: amtpaid,
        SalesReturnHeaderT.baltopay: baltopay,
        SalesReturnHeaderT.billaddressid: billaddressid,
        SalesReturnHeaderT.country: country,
        SalesReturnHeaderT.city: city,
        SalesReturnHeaderT.state: state,
        SalesReturnHeaderT.pinno: pinno,
        SalesReturnHeaderT.gst: gst,
        SalesReturnHeaderT.billtype: billtype,
        SalesReturnHeaderT.branch: branch,
        SalesReturnHeaderT.totalltr: totalltr,
        SalesReturnHeaderT.totalweight: totalweight,
        SalesReturnHeaderT.createdUserID: createdUserID,
        SalesReturnHeaderT.createdateTime: createdateTime,
        SalesReturnHeaderT.createdbyuser: createdbyuser,
        SalesReturnHeaderT.customercode: customercode,
        SalesReturnHeaderT.customername: customername,
        SalesReturnHeaderT.customertype: customertype,
        SalesReturnHeaderT.docbasic: docbasic,
        SalesReturnHeaderT.docdiscamt: docdiscamt,
        SalesReturnHeaderT.docdiscuntpercen: docdiscuntpercen,
        SalesReturnHeaderT.docentry: docentry,
        SalesReturnHeaderT.doctype: doctype,
        SalesReturnHeaderT.objtype: objtype,
        SalesReturnHeaderT.objname: objname,
        SalesReturnHeaderT.basedocentry: basedocentry,
        SalesReturnHeaderT.basedocnum: basedocnum,
        SalesReturnHeaderT.docstatus: docstatus,
        SalesReturnHeaderT.doctotal: doctotal,
        SalesReturnHeaderT.documentno: documentno,
        SalesReturnHeaderT.lastupdateIp: lastupdateIp,
        SalesReturnHeaderT.paystatus: paystatus,
        SalesReturnHeaderT.premiumid: premiumid,
        SalesReturnHeaderT.remarks: remarks,
        SalesReturnHeaderT.salesexec: salesexec,
        SalesReturnHeaderT.seresid: seresid,
        SalesReturnHeaderT.seriesnum: seriesnum,
        SalesReturnHeaderT.shipaddresid: shipaddresid,
        SalesReturnHeaderT.sodocno: sodocno,
        SalesReturnHeaderT.sodocseries: sodocseries,
        SalesReturnHeaderT.sodocseriesno: sodocseriesno,
        SalesReturnHeaderT.sodoctime: sodoctime,
        SalesReturnHeaderT.sotransdate: sotransdate,
        SalesReturnHeaderT.sosystime: sosystime,
        SalesReturnHeaderT.sysdatetime: sysdatetime,
        SalesReturnHeaderT.taxamount: taxamount,
        SalesReturnHeaderT.taxno: taxno,
        SalesReturnHeaderT.transactiondate: transactiondate,
        SalesReturnHeaderT.transtime: transtime,
        SalesReturnHeaderT.updatedDatetime: updatedDatetime,
        SalesReturnHeaderT.updateduserid: updateduserid,
        SalesReturnHeaderT.qStatus: qStatus,
        SalesReturnHeaderT.sapInvoicedocentry: sapInvoicedocentry,
        SalesReturnHeaderT.sapInvoicedocnum: sapInvoicedocnum,
        SalesReturnHeaderT.sapDocentry: sapDocentry,
        SalesReturnHeaderT.sapDocNo: sapDocNo
      };
}
