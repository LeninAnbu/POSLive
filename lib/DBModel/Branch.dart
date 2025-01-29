const String tableBranch = "BranchMaster";

class BranchT {
  static String whsCode = "WhsCode";
  static String whsName = "WhsName";
  static String cashAccount = 'CashAccount';
  static String creditAccount = 'CreditAccount';
  static String chequeAccount = 'ChequeAccount';
  static String transFerAccount = 'TransFerAccount';
  static String walletAccount = 'WalletAccount';
  static String gitWhs = 'GITWhs';

  // static String priceList = 'PriceList';
  // static String customerGroup = "CustomerGroup";
  // static String customerAcct = 'CustomerAcct';
  // static String disAcct1 = 'DisAcct1';
  // static String disAcct2 = 'DisAcct2';
  // static String creditCard = 'CreditCard';
  // static String stateCode = 'StateCode';
  // static String gSTNo = 'GSTNo';
  static String location = 'Location';
  static String companyName = 'CompanyName';
  static String companyHeader = 'CompanyHeader';
  static String e_Mail = 'E_Mail';
  static String cOGSAcct = 'COGSAcct';
  static String pAN = 'PAN';
  static String address1 = 'Address1';
  static String address2 = 'Address2';
  static String city = 'City';
  static String pincode = 'Pincode';

// \"PAN\":null,\"Address1\":null,\"Address2\":null,\"City\":null,\"Pincode\":null},
}

class BranchTModelDB {
  String? whsCode;
  String? whsName;
  // String? priceList;
  // String? customerGroup;
  String? cashAccount;
  String? creditAccount;
  String? chequeAccount;
  String? transFerAccount;
  String? wallerAccount;
  String? gitWhs;

  // String? customerAcct;
  // String? disAcct1;
  // String? disAcct2;
  // String? creditCard;
  // String? stateCode;
  // String? gSTNo;
  String? location;
  String? companyName;
  String? companyHeader;
  String? e_Mail;
  // String? cOGSAcct;
  // String? pAN;
  // String? address1;
  // String? address2;
  // String? city;
  // String? pincode;

  BranchTModelDB({
    required this.whsCode,
    required this.whsName,
    required this.wallerAccount,
    required this.gitWhs,
    required this.cashAccount,
    required this.creditAccount,
    required this.chequeAccount,
    required this.transFerAccount,
    // required this.customerAcct,
    // required this.disAcct1,
    // required this.disAcct2,
    // required this.creditCard,
    // required this.stateCode,
    // required this.gSTNo,
    required this.location,
    required this.companyName,
    required this.companyHeader,
    required this.e_Mail,
    // required this.cOGSAcct,
    // required this.pAN,
    // required this.address1,
    // required this.address2,
    // required this.city,
    // required this.pincode,
  });

  Map<String, Object?> toMap() => {
        BranchT.whsCode: whsCode,
        BranchT.whsName: whsName,
        BranchT.gitWhs: gitWhs,
        BranchT.cashAccount: cashAccount,
        BranchT.chequeAccount: chequeAccount,
        BranchT.creditAccount: creditAccount,
        BranchT.transFerAccount: transFerAccount,
        BranchT.walletAccount: wallerAccount,
        // BranchT.address2: address2,
        // BranchT.cOGSAcct: cOGSAcct,
        // BranchT.city: city,
        BranchT.companyHeader: companyHeader,
        BranchT.companyName: companyName,
        // BranchT.creditCard: creditCard,
        // BranchT.customerAcct: customerAcct,
        // BranchT.customerGroup: customerGroup,
        // BranchT.disAcct1: disAcct1,
        // BranchT.disAcct2: disAcct2,
        BranchT.e_Mail: e_Mail,
        // BranchT.gSTNo: gSTNo,
        BranchT.location: location,
        // BranchT.pincode: pincode,
        // BranchT.pAN: pAN,
        // BranchT.priceList: priceList,
        // BranchT.stateCode: stateCode,
      };
}
// class BranchT {
//   static String branchID = "branchID";
//   static String branchname = "branchname";
//   static String address1 = "address1";
//   static String address2 = "address2";
//   static String address3 = "address3";
//   static String city = 'city';
//   static String stateCode = "stateCode";
//   static String countrycode = "countrycode";
//   static String geolocation1 = "geolocation1";
//   static String geolocation2 = "geolocation2";
//   static String taxno = "taxno";
//   static String businessname = "businessname";
//   static String phoneno1 = "phoneno1";
//   static String phoneno2 = "phoneno2";
//   static String emalid = "emalid";
//   static String httplogo = 'httplogo';
//   static String status = "status";
//   static String licensekey = "licensekey";
//   static String defaultcurrency = "defaultcurrency";
//   static String createdateTime = 'createdateTime';
//   static String updatedDatetime = "UpdatedDatetime";
//   static String createdUserID = "createdUserID";
//   static String updateduserid = "updateduserid";
//   static String lastupdateIp = "lastupdateIp";
// }

// class BranchTModelDB {
//   String? branchID;
//   String? branchname;
//   String? address1;
//   String? address2;
//   String? address3;
//   String city;
//   String? stateCode;
//   String? countrycode;
//   String? geolocation1;
//   String? geolocation2;
//   String? licensekey;
//   String? taxno;
//   String? businessname;
//   String? phoneno1;
//   String? phoneno2;
//   String? emalid;
//   String? httplogo;
//   String? status;
//   String? defaultcurrency;
//   String? createdateTime;
//   String? updatedDatetime;
//   int? createdUserID;
//   int? updateduserid;
//   String? lastupdateIp;

  // BranchTModelDB(
  //     {required this.address1,
//       required this.address2,
//       required this.address3,
//       required this.branchID,
//       required this.branchname,
//       required this.businessname,
//       required this.city,
//       required this.countrycode,
//       required this.createdUserID,
//       required this.createdateTime,
//       required this.emalid,
//       required this.geolocation1,
//       required this.geolocation2,
//       required this.httplogo,
//       required this.lastupdateIp,
//       required this.phoneno1,
//       required this.phoneno2,
//       required this.stateCode,
//       required this.status,
//       required this.taxno,
//       required this.updatedDatetime,
//       required this.updateduserid,
//       required this.defaultcurrency});
// //   createdUserID:item['createdUserID'] ,
//   factory BranchTModelDB.fromMap(Map<String, dynamic> item) => BranchTModelDB(
//       address1: item['createdUserID'],
//       address2: item['createdUserID'],
//       address3: item['createdUserID'],
//       branchID: item['createdUserID'],
//       branchname: item['createdUserID'],
//       businessname: item['createdUserID'],
//       city: item['createdUserID'],
//       countrycode: item['createdUserID'],
//       createdUserID: item['createdUserID'],
//       createdateTime: item['createdUserID'],
//       emalid: item['createdUserID'],
//       geolocation1: item['createdUserID'],
//       geolocation2: item['createdUserID'],
//       httplogo: item['createdUserID'],
//       lastupdateIp: item['createdUserID'],
//       phoneno1: item['createdUserID'],
//       phoneno2: item['createdUserID'],
//       stateCode: item['createdUserID'],
//       status: item['createdUserID'],
//       defaultcurrency: item['createdUserID'],
//       taxno: item['createdUserID'],
//       updatedDatetime: item['createdUserID'],
//       updateduserid: item['createdUserID']);

  
//         BranchT.address1: address1,
//         BranchT.address2: address2,
//         BranchT.address3: address3,
//         BranchT.branchID: branchID,
//         BranchT.branchname: branchname,
//         BranchT.businessname: businessname,
//         BranchT.city: city,
//         BranchT.countrycode: countrycode,
//         BranchT.createdateTime: createdateTime,
//         BranchT.defaultcurrency: defaultcurrency,
//         BranchT.createdUserID: createdUserID,
//         BranchT.emalid: emalid,
//         BranchT.geolocation1: geolocation1,
//         BranchT.geolocation2: geolocation2,
//         BranchT.httplogo: httplogo,
//         BranchT.lastupdateIp: lastupdateIp,
//         BranchT.licensekey: licensekey,
//         BranchT.phoneno1: phoneno1,
//         BranchT.phoneno2: phoneno2,
//         BranchT.stateCode: stateCode,
//         BranchT.status: status,
//         BranchT.taxno: taxno,
//         BranchT.updatedDatetime: updatedDatetime,
//         BranchT.updateduserid: updateduserid
//       };
// }
