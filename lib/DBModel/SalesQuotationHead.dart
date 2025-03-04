const String tableSalesQuotationHeader = "SalesQuotationHeader";

class SalesQuotationHeaderT {
  static String docentry = "docentry";
  static String doctype = "doctype";
  static String objtype = 'objtype';
  static String objname = 'objname';
  static String editType = 'editType';
  static String terminal = "terminal";
  static String branch = "branch";
  static String sodocno = "sodocno";
  static String sodocseries = "sodocseries";
  static String sodocseriesno = "sodocseriesno";
  static String sotransdate = "sotransdate";
  static String sodoctime = "sodoctime";
  static String sosystime = "sosystime";
  static String documentno = 'documentno';
  static String seresid = "seresid";
  static String seriesnum = "seriesnum";
  static String customerSeriesNum = "CustomerSeriesNum";
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
  static String tinNo = "TinNo";
  static String vatno = "VatNo";

  static String city = "city";
  static String state = "state";
  static String pinno = "pinno";
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
}

class SalesQuotationHeaderModelDB {
  String? billaddressid;
  String? docentry;
  String? terminal;
  String editType;
  String? customerSeriesNum;
  String? doctype;
  String? objtype;
  String? objname;
  String? branch;
  String? sodocno;
  String tinNo;
  String vatno;
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

  SalesQuotationHeaderModelDB({
    required this.editType,
    required this.amtpaid,
    this.billaddressid,
    required this.country,
    required this.tinNo,
    required this.vatno,
    required this.city,
    required this.state,
    required this.gst,
    required this.pinno,
    required this.baltopay,
    this.addressName1,
    this.street,
    this.block,
    required this.customerSeriesNum,
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

  factory SalesQuotationHeaderModelDB.fromjson(Map<String, dynamic> resp) {
    return SalesQuotationHeaderModelDB(
        tinNo: resp['TinNo'],
        vatno: resp['VatNo'],
        street: resp['street'],
        block: resp['block'],
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
        editType:
            resp['editType'].isNotEmpty ? resp['editType'].toString() : '');
  }

  Map<String, Object?> toMap() => {
        SalesQuotationHeaderT.editType: editType,
        SalesQuotationHeaderT.customerphono: customerphono,
        SalesQuotationHeaderT.terminal: terminal,
        SalesQuotationHeaderT.customeraccbal: customeraccbal,
        SalesQuotationHeaderT.customeremail: customeremail,
        SalesQuotationHeaderT.customerpoint: customerpoint,
        SalesQuotationHeaderT.amtpaid: amtpaid,
        SalesQuotationHeaderT.baltopay: baltopay,
        SalesQuotationHeaderT.billaddressid: billaddressid,
        SalesQuotationHeaderT.country: country,
        SalesQuotationHeaderT.city: city,
        SalesQuotationHeaderT.state: state,
        SalesQuotationHeaderT.pinno: pinno,
        SalesQuotationHeaderT.tinNo: tinNo,
        SalesQuotationHeaderT.vatno: vatno,
        SalesQuotationHeaderT.totalweight: totalweight,
        SalesQuotationHeaderT.totalltr: totalltr,
        SalesQuotationHeaderT.gst: gst,
        SalesQuotationHeaderT.billtype: billtype,
        SalesQuotationHeaderT.branch: branch,
        SalesQuotationHeaderT.customerSeriesNum: customerSeriesNum,
        SalesQuotationHeaderT.createdUserID: createdUserID,
        SalesQuotationHeaderT.createdateTime: createdateTime,
        SalesQuotationHeaderT.createdbyuser: createdbyuser,
        SalesQuotationHeaderT.customercode: customercode,
        SalesQuotationHeaderT.customername: customername,
        SalesQuotationHeaderT.customertype: customertype,
        SalesQuotationHeaderT.docbasic: docbasic,
        SalesQuotationHeaderT.docdiscamt: docdiscamt,
        SalesQuotationHeaderT.docdiscuntpercen: docdiscuntpercen,
        SalesQuotationHeaderT.docentry: docentry,
        SalesQuotationHeaderT.doctype: doctype,
        SalesQuotationHeaderT.objtype: objtype,
        SalesQuotationHeaderT.objname: objname,
        SalesQuotationHeaderT.docstatus: docstatus,
        SalesQuotationHeaderT.doctotal: doctotal,
        SalesQuotationHeaderT.documentno: documentno,
        SalesQuotationHeaderT.lastupdateIp: lastupdateIp,
        SalesQuotationHeaderT.paystatus: paystatus,
        SalesQuotationHeaderT.premiumid: premiumid,
        SalesQuotationHeaderT.remarks: remarks,
        SalesQuotationHeaderT.salesexec: salesexec,
        SalesQuotationHeaderT.seresid: seresid,
        SalesQuotationHeaderT.seriesnum: seriesnum,
        SalesQuotationHeaderT.shipaddresid: shipaddresid,
        SalesQuotationHeaderT.sodocno: sodocno,
        SalesQuotationHeaderT.sodocseries: sodocseries,
        SalesQuotationHeaderT.sodocseriesno: sodocseriesno,
        SalesQuotationHeaderT.sodoctime: sodoctime,
        SalesQuotationHeaderT.sotransdate: sotransdate,
        SalesQuotationHeaderT.sosystime: sosystime,
        SalesQuotationHeaderT.sysdatetime: sysdatetime,
        SalesQuotationHeaderT.taxamount: taxamount,
        SalesQuotationHeaderT.taxno: taxno,
        SalesQuotationHeaderT.transactiondate: transactiondate,
        SalesQuotationHeaderT.transtime: transtime,
        SalesQuotationHeaderT.updatedDatetime: updatedDatetime,
        SalesQuotationHeaderT.updateduserid: updateduserid,
        SalesQuotationHeaderT.sapDocentry: sapDocentry,
        SalesQuotationHeaderT.sapDocNo: sapDocNo,
        SalesQuotationHeaderT.qStatus: qStatus,
      };
}
