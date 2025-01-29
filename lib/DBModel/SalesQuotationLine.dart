const String tableSalesQuotationLine = "SalesQuotationLine";

class SalesQuotationLineT {
  static String docentry = "docentry";
  static String sapDocentry = "sapDocentry";
  static String balqty = "balqty";
  static String lineID = "lineID";
  static String itemcode = "itemcode";
  static String itemname = "itemname";
  static String serialbatch = "serialbatch";
  static String quantity = "quantity";
  static String price = "price";
  static String linetotal = "linetotal";
  static String taxrate = "taxrate";
  static String discperc = 'discperc';
  static String discperunit = "discperunit";
  static String maxdiscount = "maxdiscount";
  static String basic = "basic";
  static String taxtotal = "taxtotal";
  static String discamt = "discamt";
  static String netlinetotal = "netlinetotal";
  static String branch = "branch";
  static String terminal = "terminal";
  static String createdUser = 'createdUser';
  static String createdateTime = 'createdateTime';
  static String updatedDatetime = "UpdatedDatetime";
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
}

class SalesQuotationLineTDB {
  String? docentry;
  String sapdocentry;
  String? sapdocNum;
  String? lineID;
  String? itemcode;
  String? itemname;
  String? serialbatch;
  String? quantity;
  String? price;
  String? linetotal;
  String? taxrate;
  String? discperc;
  String? discperunit;
  String? maxdiscount;
  String? basic;
  String? taxtotal;
  String? discamt;
  String? netlinetotal;
  String? branch;
  String? terminal;
  String? createdUser;
  String? createdateTime;
  String? updatedDatetime;
  String? createdUserID;
  String? updateduserid;
  String? lastupdateIp;
  int? balqty;

  SalesQuotationLineTDB({
    this.balqty,
    this.createdUser,
    required this.sapdocentry,
    this.sapdocNum,
    required this.basic,
    required this.itemname,
    required this.branch,
    required this.terminal,
    required this.createdUserID,
    required this.createdateTime,
    required this.discamt,
    required this.discperc,
    required this.discperunit,
    required this.maxdiscount,
    required this.docentry,
    required this.itemcode,
    required this.lastupdateIp,
    required this.lineID,
    required this.linetotal,
    required this.netlinetotal,
    required this.price,
    required this.quantity,
    required this.serialbatch,
    required this.taxrate,
    required this.taxtotal,
    required this.updatedDatetime,
    required this.updateduserid,
  });
  factory SalesQuotationLineTDB.fromjson(Map<String, dynamic> resp) {
    return SalesQuotationLineTDB(
        balqty: resp['balqty'],
        createdUser: resp['createdUser'],
        basic: resp['basic'],
        branch: resp['branch'],
        terminal: resp['terminal'],
        createdUserID: resp['createdUserID'].toString(),
        createdateTime: resp['createdateTime'],
        discamt: resp['discamt'].toString(),
        discperc: resp['discperc'],
        discperunit: resp['discperunit'].toString(),
        maxdiscount: resp['maxdiscount'].toString(),
        docentry: resp['docentry'].toString(),
        itemcode: resp['itemcode'],
        lastupdateIp: resp['lastupdateIp'],
        lineID: resp['lineID'].toString(),
        linetotal: resp['linetotal'].toString(),
        netlinetotal: resp['netlinetotal'].toString(),
        price: resp['price'].toString(),
        quantity: resp['quantity'].toString(),
        serialbatch: resp['serialbatch'],
        taxrate: resp['taxrate'].toString(),
        taxtotal: resp['taxtotal'].toString(),
        updatedDatetime: resp['updatedDatetime'],
        updateduserid: resp['updateduserid'].toString(),
        itemname: resp['itemname'].toString(),
        sapdocentry: resp['sapDocentry'].toString(),
        sapdocNum: resp['sapDocNum'].toString());
  }
  Map<String, Object?> toMap(int docEntry) => {
        SalesQuotationLineT.basic: basic,
        SalesQuotationLineT.sapDocentry: sapdocentry,
        SalesQuotationLineT.balqty: balqty, //itemname
        SalesQuotationLineT.branch: branch,
        SalesQuotationLineT.itemname: itemname,
        SalesQuotationLineT.terminal: terminal,
        SalesQuotationLineT.createdUser: createdUser,
        SalesQuotationLineT.createdUserID: createdUserID,
        SalesQuotationLineT.createdateTime: createdateTime,
        SalesQuotationLineT.discamt: discamt,
        SalesQuotationLineT.discperc: discperc,
        SalesQuotationLineT.discperunit: discperunit,
        SalesQuotationLineT.docentry: docEntry,
        SalesQuotationLineT.itemcode: itemcode,
        SalesQuotationLineT.lastupdateIp: lastupdateIp,
        SalesQuotationLineT.lineID: lineID,
        SalesQuotationLineT.linetotal: linetotal,
        SalesQuotationLineT.netlinetotal: netlinetotal,
        SalesQuotationLineT.price: price,
        SalesQuotationLineT.quantity: quantity,
        SalesQuotationLineT.serialbatch: serialbatch,
        SalesQuotationLineT.taxrate: taxrate,
        SalesQuotationLineT.taxtotal: taxtotal,
        SalesQuotationLineT.updatedDatetime: updatedDatetime,
        SalesQuotationLineT.maxdiscount: maxdiscount,
        SalesQuotationLineT.updateduserid: updateduserid
      };
}
