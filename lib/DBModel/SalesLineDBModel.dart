const String tableSalesLine = "SalesLine";

class SalesLineT {
  static String docentry = "docentry";
  static String basedocentry = "basedocentry";
  static String baselineID = "baselineID";
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
  static String pails = "pails";
  static String cartons = "cartons";
  static String looseTins = "looseTins";
  static String tonnage = "tonnage";
  static String totalPack = "totalPack";
  static String branch = "branch";
  static String terminal = "terminal";
  static String createdUser = 'createdUser';
  static String createdateTime = 'createdateTime';
  static String updatedDatetime = "UpdatedDatetime";
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
}

class SalesLineTDB {
  double? pails;
  int? cartons;
  double looseTins;
  double tonnage;
  double totalPack;
  String? docentry;
  String? lineID;
  String? itemcode;
  String? itemname;
  String? basedocentry;
  String? baselineID;
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

  SalesLineTDB({
    this.balqty,
    this.createdUser,
    required this.pails,
    required this.cartons,
    required this.looseTins,
    required this.tonnage,
    required this.totalPack,
    required this.basic,
    required this.baselineID,
    required this.basedocentry,
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
  factory SalesLineTDB.fromjson(Map<String, dynamic> resp) {
    return SalesLineTDB(
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
        basedocentry: resp['basedocentry'].toString(),
        baselineID: resp['baselineID'].toString(),
        itemname: resp['itemname'].toString(),
        pails: resp['pails'],
        cartons: resp['cartons'],
        looseTins: double.parse(resp['looseTins'].toString()),
        tonnage: double.parse(resp['tonnage'].toString()),
        totalPack: double.parse(resp['totalPack'].toString()));
  }
  Map<String, Object?> toMap(int docEntry) => {
        SalesLineT.pails: pails,
        SalesLineT.cartons: cartons,
        SalesLineT.looseTins: looseTins,
        SalesLineT.tonnage: tonnage,
        SalesLineT.totalPack: totalPack,
        SalesLineT.basic: basic,
        SalesLineT.balqty: balqty, //itemname
        SalesLineT.branch: branch,
        SalesLineT.basedocentry: basedocentry,
        SalesLineT.baselineID: baselineID,
        SalesLineT.itemname: itemname,
        SalesLineT.terminal: terminal,
        SalesLineT.createdUser: createdUser,
        SalesLineT.createdUserID: createdUserID,
        SalesLineT.createdateTime: createdateTime,
        SalesLineT.discamt: discamt,
        SalesLineT.discperc: discperc,
        SalesLineT.discperunit: discperunit,
        SalesLineT.docentry: docEntry,
        SalesLineT.itemcode: itemcode,
        SalesLineT.lastupdateIp: lastupdateIp,
        SalesLineT.lineID: lineID,
        SalesLineT.linetotal: linetotal,
        SalesLineT.netlinetotal: netlinetotal,
        SalesLineT.price: price,
        SalesLineT.quantity: quantity,
        SalesLineT.serialbatch: serialbatch,
        SalesLineT.taxrate: taxrate,
        SalesLineT.taxtotal: taxtotal,
        SalesLineT.updatedDatetime: updatedDatetime,
        SalesLineT.maxdiscount: maxdiscount,
        SalesLineT.updateduserid: updateduserid
      };
}
