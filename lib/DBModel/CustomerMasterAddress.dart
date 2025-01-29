const String tableCustomerMasterAdress = "CustomerMasterAddress";

class CustomerMasterAddressT {
  static String autoid = "autoid";
  static String custcode = "custcode";
  static String addresstype = 'addresstype';
  static String address1 = "address1";
  static String address2 = "address2";
  static String address3 = "address3";
  static String city = 'city';
  static String pincode = 'pincode';
  static String statecode = "statecode";
  static String countrycode = "countrycode";
  static String geolocation1 = "geolocation1";
  static String geolocation2 = "geolocation2";
  static String branch = "branch";
  static String terminal = "terminal";
  static String createdateTime = 'createdateTime';
  static String updatedDatetime = "UpdatedDatetime";
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
}

class CustomerAddressModelDB {
  String? autoid;
  String? pincode;
  String? custcode;
  String? address1;
  String? address2;
  String? address3;
  String? addresstype;
  String? city;
  String statecode;
  String? countrycode;
  String? geolocation1;
  String? geolocation2;
  String? branch;
  String? terminal;
  String? createdateTime;
  String? updatedDatetime;
  String? createdUserID;
  String? updateduserid;
  String? lastupdateIp;

  CustomerAddressModelDB(
      {required this.createdUserID,
      required this.createdateTime,
      required this.lastupdateIp,
      required this.updatedDatetime,
      required this.updateduserid,
      required this.address1,
      required this.address2,
      required this.address3,
      required this.addresstype,
      required this.pincode,
      this.autoid,
      required this.city,
      required this.countrycode,
      required this.custcode,
      required this.branch,
      required this.terminal,
      required this.geolocation1,
      required this.geolocation2,
      required this.statecode});
//   createdUserID:item['createdUserID'] ,
  factory CustomerAddressModelDB.fromMap(Map<String, dynamic> item) =>
      CustomerAddressModelDB(
          createdUserID: item['createdUserID'],
          createdateTime: item['createdUserID'],
          lastupdateIp: item['createdUserID'],
          updatedDatetime: item['createdUserID'],
          updateduserid: item['createdUserID'],
          address1: item['createdUserID'],
          address2: item['createdUserID'],
          address3: item['createdUserID'],
          autoid: item['autoid'],
          city: item['createdUserID'],
          countrycode: item['createdUserID'],
          custcode: item['createdUserID'],
          geolocation1: item['createdUserID'],
          pincode: item['createdUserID'],
          geolocation2: item['createdUserID'],
          branch: item['branch'],
          addresstype: item['addresstype'],
          terminal: item['terminal'],
          statecode: item['createdUserID']);

  Map<String, Object?> toMap() => {
        CustomerMasterAddressT.address1: address1,
        CustomerMasterAddressT.address2: address2,
        CustomerMasterAddressT.address3: address3,
        CustomerMasterAddressT.autoid: autoid,
        CustomerMasterAddressT.city: city, //addresstype
        CustomerMasterAddressT.addresstype: addresstype,
        CustomerMasterAddressT.branch: branch,
        CustomerMasterAddressT.terminal: terminal,
        CustomerMasterAddressT.countrycode: countrycode,
        CustomerMasterAddressT.createdUserID: createdUserID,
        CustomerMasterAddressT.createdateTime: createdUserID,
        CustomerMasterAddressT.custcode: custcode,
        CustomerMasterAddressT.geolocation1: geolocation1,
        CustomerMasterAddressT.geolocation2: geolocation2,
        CustomerMasterAddressT.lastupdateIp: lastupdateIp,
        CustomerMasterAddressT.statecode: statecode, //pincode
        CustomerMasterAddressT.pincode: pincode, //pincode
        CustomerMasterAddressT.updatedDatetime: updatedDatetime,
        CustomerMasterAddressT.updateduserid: updateduserid,
      };
}
