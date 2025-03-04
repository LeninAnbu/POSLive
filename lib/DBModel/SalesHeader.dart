const String tableSalesHeader = "SalesHeader ";

class SalesHeaderT {
  static String docentry = "docentry";
  static String doctype = "doctype";
  static String objtype = 'objtype';
  static String objname = 'objname';
  static String vatNo = 'VatNo';
  static String tinNo = 'TinNo';

  static String terminal = "terminal";
  static String branch = "branch";
  static String basedocentry = "basedocentry";
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
  static String customerSeriesNum = 'customerSeriesNum';
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
  // static String addressName1 = "addressName1";
  // static String street = "street";
  // static String block = 'block';

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
  static String totalltr = "totalltr";
  static String totalweight = "totalweight";
}

class SalesHeaderTModelDB {
  String? customerSeriesNum;
  String? billaddressid;
  String? docentry;
  String? basedocentry;
  String? tinNo;
  String? vatNo;

  String? terminal;
  String? doctype;
  String? objtype;
  double? totalweight;
  double? totalltr;
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

  SalesHeaderTModelDB({
    required this.customerSeriesNum,
    required this.amtpaid,
    this.billaddressid,
    required this.country,
    required this.city,
    required this.state,
    required this.gst,
    required this.pinno,
    required this.baltopay,
    required this.totalweight,
    required this.totalltr,
    required this.tinNo,
    required this.vatNo,
    this.addressName1,
    this.street,
    this.block,
    required this.basedocentry,
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

  factory SalesHeaderTModelDB.fromjson(Map<String, dynamic> resp) {
    return SalesHeaderTModelDB(
        street: resp['street'],
        block: resp['block'],
        docentry: resp['docentry'].toString(),
        doctype: resp['doctype'],
        objtype: resp['objtype'],
        objname: resp['objname'],
        documentno: resp['documentno'],
        amtpaid: resp['amtpaid'],
        country: resp['country'],
        vatNo: resp['VatNo'],
        tinNo: resp['TinNo'],
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
        totalltr: double.parse(resp['totalltr'].toString()),
        totalweight: double.parse(resp['totalweight'].toString()),
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
        sapDocNo: resp['sapDocNo'] == null
            ? null
            : int.parse(resp['sapDocNo'].toString()),
        sapDocentry: resp['sapDocentry'] == null
            ? null
            : int.parse(resp['sapDocentry'].toString()),
        qStatus: 'Y',
        basedocentry: resp['basedocentry'].toString(),
        customerSeriesNum: resp['customerSeriesNum'].toString());
  }

  Map<String, Object?> toMap() => {
        SalesHeaderT.customerSeriesNum: customerSeriesNum,
        SalesHeaderT.customerphono: customerphono,
        SalesHeaderT.basedocentry: basedocentry,
        SalesHeaderT.terminal: terminal,
        SalesHeaderT.customeraccbal: customeraccbal,
        SalesHeaderT.customeremail: customeremail,
        SalesHeaderT.customerpoint: customerpoint,
        SalesHeaderT.amtpaid: amtpaid,
        SalesHeaderT.baltopay: baltopay,
        SalesHeaderT.billaddressid: billaddressid,
        // SalesHeaderT.addressName1: addressName1,
        // SalesHeaderT.street: street,
        // SalesHeaderT.block: block,
        SalesHeaderT.country: country,
        SalesHeaderT.city: city,
        SalesHeaderT.state: state,
        SalesHeaderT.pinno: pinno,
        SalesHeaderT.gst: gst,
        SalesHeaderT.billtype: billtype,
        SalesHeaderT.branch: branch,
        SalesHeaderT.totalltr: totalltr,
        SalesHeaderT.totalweight: totalweight,
        SalesHeaderT.createdUserID: createdUserID,
        SalesHeaderT.createdateTime: createdateTime,
        SalesHeaderT.createdbyuser: createdbyuser,
        SalesHeaderT.customercode: customercode,
        SalesHeaderT.customername: customername,
        SalesHeaderT.customertype: customertype,
        SalesHeaderT.docbasic: docbasic,
        SalesHeaderT.docdiscamt: docdiscamt,
        SalesHeaderT.docdiscuntpercen: docdiscuntpercen,
        SalesHeaderT.docentry: docentry,
        SalesHeaderT.doctype: doctype,
        SalesHeaderT.objtype: objtype,
        SalesHeaderT.objname: objname,
        SalesHeaderT.tinNo: tinNo,
        SalesHeaderT.vatNo: vatNo,

        SalesHeaderT.docstatus: docstatus,
        SalesHeaderT.doctotal: doctotal,
        SalesHeaderT.documentno: documentno,
        SalesHeaderT.lastupdateIp: lastupdateIp,
        SalesHeaderT.paystatus: paystatus,
        SalesHeaderT.premiumid: premiumid,
        SalesHeaderT.remarks: remarks,
        SalesHeaderT.salesexec: salesexec,
        SalesHeaderT.seresid: seresid,
        SalesHeaderT.seriesnum: seriesnum,
        SalesHeaderT.shipaddresid: shipaddresid,
        SalesHeaderT.sodocno: sodocno,
        SalesHeaderT.sodocseries: sodocseries,
        SalesHeaderT.sodocseriesno: sodocseriesno,
        SalesHeaderT.sodoctime: sodoctime,
        SalesHeaderT.sotransdate: sotransdate,
        SalesHeaderT.sosystime: sosystime,
        SalesHeaderT.sysdatetime: sysdatetime,
        SalesHeaderT.taxamount: taxamount,
        SalesHeaderT.taxno: taxno,
        SalesHeaderT.transactiondate: transactiondate,
        SalesHeaderT.transtime: transtime,
        SalesHeaderT.updatedDatetime: updatedDatetime,
        SalesHeaderT.updateduserid: updateduserid,
        SalesHeaderT.sapDocentry: sapDocentry,
        SalesHeaderT.sapDocNo: sapDocNo,
        SalesHeaderT.qStatus: qStatus,
      };
}
