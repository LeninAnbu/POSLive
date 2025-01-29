
const String tableCountry = "Country";

class CountryT {
  static String countrycode = "countrycode";
  static String countryname= "countryname";
  static String createdateTime = 'createdateTime';
  static String updatedDatetime = "UpdatedDatetime";
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
} 
class CountryTModelDB {
  String? countrycode;
  String? countryname;
  String? createdateTime;
  String? updatedDatetime;
  int? createdUserID;
  int? updateduserid;
  String? lastupdateIp;

  CountryTModelDB({
    required this.countrycode,
    required this.countryname,
    required this.createdUserID,
    required this.createdateTime,
    required this.lastupdateIp,
    required this.updatedDatetime,
    required this.updateduserid
  });


        Map<String, Object?> toMap() => {
       CountryT.countrycode:countrycode,
       CountryT.countryname:countryname,
       CountryT.createdUserID:createdUserID,
       CountryT.createdateTime:createdateTime,
       CountryT.lastupdateIp:lastupdateIp,
       CountryT.updatedDatetime:updatedDatetime,
       CountryT.updateduserid:updateduserid
      };
}
