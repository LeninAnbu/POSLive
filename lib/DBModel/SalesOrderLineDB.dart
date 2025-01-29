const String tableSalesOrderLine = "SalesOrderLine";

class SalesOrderLineT {
  static String docentry = "docentry";
  static String basedocentry = "basedocentry";
  static String baselineID = "baselineID";
  static String baseType = "baseType";
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

class SalesOrderLineTDB {
  String? docentry;
  String? lineID;
  String? basedocentry;
  String? baselineID;
  String? basetype;
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

  SalesOrderLineTDB({
    this.balqty,
    this.createdUser,
    required this.basic,
    required this.basetype,
    required this.basedocentry,
    required this.baselineID,
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
  factory SalesOrderLineTDB.fromjson(Map<String, dynamic> resp) {
    return SalesOrderLineTDB(
      balqty: resp['balqty'],
      createdUser: resp['createdUser'],
      basedocentry: resp['basedocentry'].toString(),
      baselineID: resp['baselineID'].toString(),
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
      basetype: resp['baseType'].toString(),
    );
  }
  Map<String, Object?> toMap(int docEntry) => {
        SalesOrderLineT.basedocentry: basedocentry,
        SalesOrderLineT.baselineID: baselineID,
        SalesOrderLineT.baseType: basetype,
        SalesOrderLineT.basic: basic,
        SalesOrderLineT.balqty: balqty, //itemname
        SalesOrderLineT.branch: branch,
        SalesOrderLineT.itemname: itemname,
        SalesOrderLineT.terminal: terminal,
        SalesOrderLineT.createdUser: createdUser,
        SalesOrderLineT.createdUserID: createdUserID,
        SalesOrderLineT.createdateTime: createdateTime,
        SalesOrderLineT.discamt: discamt,
        SalesOrderLineT.discperc: discperc,
        SalesOrderLineT.discperunit: discperunit,
        SalesOrderLineT.docentry: docEntry,
        SalesOrderLineT.itemcode: itemcode,
        SalesOrderLineT.lastupdateIp: lastupdateIp,
        SalesOrderLineT.lineID: lineID,
        SalesOrderLineT.linetotal: linetotal,
        SalesOrderLineT.netlinetotal: netlinetotal,
        SalesOrderLineT.price: price,
        SalesOrderLineT.quantity: quantity,
        SalesOrderLineT.serialbatch: serialbatch,
        SalesOrderLineT.taxrate: taxrate,
        SalesOrderLineT.taxtotal: taxtotal,
        SalesOrderLineT.updatedDatetime: updatedDatetime,
        SalesOrderLineT.maxdiscount: maxdiscount,
        SalesOrderLineT.updateduserid: updateduserid
      };
}
