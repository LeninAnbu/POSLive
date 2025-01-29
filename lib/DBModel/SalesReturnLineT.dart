const String tableSalesReturnLine = "SalesReturnLine";

class SalesReturnLineT {
  static String docentry = "docentry";
  static String lineID = "lineID";
  static String itemname = "itemname";
  static String baselineID = "baselineID";
  static String basedocentry = "basedocentry";
  static String itemcode = "itemcode";
  static String serialbatch = "serialbatch";
  static String quantity = "quantity";
  static String price = "price";
  static String linetotal = "linetotal";
  static String taxrate = "taxrate";
  static String discperc = 'discperc';
  static String discperunit = "discperunit";
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

class SalesReturnLineTDB {
  String? docentry;
  String? itemname;
  String? basedocentry;
  String? baselineID;
  String? lineID;
  String? itemcode;
  String? serialbatch;
  String? quantity;
  String? price;
  String? linetotal;
  String? taxrate;
  String? discperc;
  String? discperunit;
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

  SalesReturnLineTDB(
      {required this.baselineID,
      required this.basedocentry,
      this.createdUser,
      required this.basic,
      required this.itemname,
      required this.branch,
      required this.terminal,
      required this.createdUserID,
      required this.createdateTime,
      required this.discamt,
      required this.discperc,
      required this.discperunit,
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
      required this.updateduserid});
  factory SalesReturnLineTDB.fromjson(Map<String, dynamic> resp) {
    return SalesReturnLineTDB(
        createdUser: resp['createdUser'],
        basic: resp['basic'],
        branch: resp['branch'],
        terminal: resp['terminal'],
        createdUserID: resp['createdUserID'].toString(),
        createdateTime: resp['createdateTime'],
        discamt: resp['discamt'].toString(),
        discperc: resp['discperc'],
        discperunit: resp['discperunit'].toString(),
        docentry: resp['docentry'].toString(),
        itemcode: resp['itemcode'],
        itemname: resp['itemname'],
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
        basedocentry: resp['basedocentry'],
        baselineID: resp['baselineID']);
  }

  Map<String, dynamic> toJson() => {
        "createdUser": createdUser,
        "basic": basic,
        "branch": branch,
        "terminal": terminal,
        "createdUserID": createdUserID,
        "createdateTime": createdateTime,
        "discamt": discamt.toString(),
        "discperc": discperc,
        "discperunit": discperunit.toString(),
        "docentry": docentry.toString(),
        "itemcode": itemcode,
        "itemname": itemname,
        "lastupdateIp": lastupdateIp,
        "lineID": lineID.toString(),
        "linetotal": linetotal.toString(),
        "netlinetotal": netlinetotal.toString(),
        "price": price.toString(),
        "quantity": quantity.toString(),
        "serialbatch": serialbatch,
        "taxrate": taxrate.toString(),
        "taxtotal": taxtotal.toString(),
        "updatedDatetime": updatedDatetime,
        "updateduserid": updateduserid.toString(),
        "basedocentry": basedocentry,
        "baselineID": baselineID,
      };
  Map<String, Object?> toMap(int docEntry) => {
        SalesReturnLineT.basic: basic,
        SalesReturnLineT.branch: branch,
        SalesReturnLineT.terminal: terminal,
        SalesReturnLineT.baselineID: baselineID,
        SalesReturnLineT.createdUser: createdUser,
        SalesReturnLineT.createdUserID: createdUserID,
        SalesReturnLineT.createdateTime: createdateTime,
        SalesReturnLineT.discamt: discamt,
        SalesReturnLineT.discperc: discperc,
        SalesReturnLineT.discperunit: discperunit,
        SalesReturnLineT.docentry: docEntry,
        SalesReturnLineT.basedocentry: basedocentry,
        SalesReturnLineT.itemcode: itemcode,
        SalesReturnLineT.itemname: itemname,
        SalesReturnLineT.lastupdateIp: lastupdateIp,
        SalesReturnLineT.lineID: lineID,
        SalesReturnLineT.linetotal: linetotal,
        SalesReturnLineT.netlinetotal: netlinetotal,
        SalesReturnLineT.price: price,
        SalesReturnLineT.quantity: quantity,
        SalesReturnLineT.serialbatch: serialbatch,
        SalesReturnLineT.taxrate: taxrate,
        SalesReturnLineT.taxtotal: taxtotal,
        SalesReturnLineT.updatedDatetime: updatedDatetime,
        SalesReturnLineT.updateduserid: updateduserid
      };
}
