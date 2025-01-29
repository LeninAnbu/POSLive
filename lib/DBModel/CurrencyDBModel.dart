const String tableCurrency = "Currency";

class CurrencyT {
  static String currencycode = "currencycode";
  static String currencyname = "currencyname";
  static String currencysymbol = "currencysymbol";
  static String createdateTime = 'createdateTime';
  static String updatedDatetime = "UpdatedDatetime";
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
}

class CurrencyTModelDB {
  String? currencycode;
  String? currencyname;
  String? currencysymbol;
  String? createdateTime;
  String? updatedDatetime;
  int? createdUserID;
  int? updateduserid;
  String? lastupdateIp;

  CurrencyTModelDB({
      required this.currencycode,
      required this.currencyname,
      required this.currencysymbol,
      required this.createdUserID,
      required this.createdateTime,
      required this.lastupdateIp,
      required this.updatedDatetime,
      required this.updateduserid
      });

  Map<String, Object?> toMap() => {
        CurrencyT.currencycode:currencycode,
        CurrencyT.currencyname:currencyname,
        CurrencyT.currencysymbol:currencysymbol,
        CurrencyT.createdUserID: createdUserID,
        CurrencyT.createdateTime: createdateTime,
        CurrencyT.lastupdateIp: lastupdateIp,
        CurrencyT.updatedDatetime: updatedDatetime,
        CurrencyT.updateduserid: updateduserid,
      };
}
