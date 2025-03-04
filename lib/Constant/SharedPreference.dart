import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static String sPLocale = "Locale";
//  static String sPLocale = "Locale";
  static String spStgIP = "SettingIP";
  static String spHost = "spHost";
  static String spDeviceID = "spDeviceID";
  static String spSiteCode = "spSiteCode";
  static String islogggedIN = "IslogggedIN";
  static String spUser = "spUser";
  static String splicense = "license";
  static String spuserId = "userId";
  static String branchSp = "branchSp";
  static String terminal = "terminal";
  static String slpCode = "slpCode";
  static String sapDB = "sapDB";
  static String isDatadownloaded = "isDatadownloaded";
  static String queueName = "isQueueName";
  static String consumercount = "isConsumerCount";

  static String sapusername = "sapusername";
  static String sappassword = "sapassword";
  static Future<bool> saveQeueName(String isDatad) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(queueName, isDatad);
  }

  static Future<bool> saveConsumercount(String isDatad) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(consumercount, isDatad);
  }

  static Future<String?> getQueueName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(queueName);
  }

  static Future<String?> getConsumerCount() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(consumercount);
  }

  static Future<bool> saveDatadonld(bool isDatad) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(isDatadownloaded, isDatad);
  }

  static Future<bool?> getDatadonld() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(isDatadownloaded);
  }

  static Future<bool> saveLocaleSP(String locale) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sPLocale, locale);
  }

  static Future<String?> getLocaleSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sPLocale);
  }

  static Future<bool> saveStngIPSP(String stngIP) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(spStgIP, stngIP);
  }

  static Future<String?> getStngIPSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(spStgIP);
  }
  // static Future<bool> saveLocaleSP(String locale) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   return await preferences.setString(sPLocale, locale);
  // }

  // static Future<String?> getLocaleSP() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   return await preferences.getString(sPLocale);
  // }

  static Future<bool> saveHostSP(String spHost1) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(spHost, spHost1);
  }

  static Future<String?> getHostDSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(spHost);
  }

  static clearHost() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(spHost);
  }

  static Future<bool> saveDeviceIDSP(String spDeviceID1) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(spDeviceID, spDeviceID1);
  }

  static Future<String?> getDeviceIDSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(spDeviceID);
  }

  static clearDeviceID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(spDeviceID);
  }

  static Future<bool> saveSiteCodeSP(String spSiteCode1) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(spSiteCode, spSiteCode1);
  }

  static Future<String?> getSiteCodeSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(spSiteCode);
  }

  static clearSiteCode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(spSiteCode);
  }

  static Future<bool> saveLoggedInSP(bool isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(islogggedIN, isUserLoggedIn);
  }

  static Future<bool?> getLoggedINSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(islogggedIN);
  }

  static clearLoggedIN() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(islogggedIN);
  }

  static Future<bool> saveUserSP(String spUser1) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(spUser, spUser1);
  }

  static Future<String?> getUSerSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(spUser);
  }

  static clearUserSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(spUser);
  }

  static Future<bool> saveLicenseSP(String license1) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(splicense, license1);
  }

  static Future<String?> getLicenseSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(splicense);
  }

  static clrLicenseSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(splicense);
  }

  static Future<bool> saveUserIdeSP(String userId1) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(spuserId, userId1);
  }

  static Future<String?> getUserIdSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(spuserId);
  }

  static clrUserIdSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(spuserId);
  }

  static Future<bool> saveBranchSP(String branchSp1) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(branchSp, branchSp1);
  }

  static Future<String?> getBranchSSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(branchSp);
  }

  static Future<bool> saveSlpCode(String slpcode1) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(slpCode, slpcode1);
  }

  static Future<String?> getslpCode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(slpCode);
  }

  static Future<bool> saveSapDB(String sapdb) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sapDB, sapdb);
  }

  static Future<bool> clearSapDB() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.remove(sapDB);
  }

  static Future<String?> getSapDB() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sapDB);
  }

  static Future<bool> saveSapUserName(String sapdb) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sapusername, sapdb);
  }

  static Future<String?> getSapUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sapusername);
  }

  static Future<bool> saveSapPassword(String sapdb) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sappassword, sapdb);
  }

  static Future<String?> getSapPassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sappassword);
  }

  static clrBranchSSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(branchSp);
  }

  static clrsapusername() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(sapusername);
  }

  static clrdsappassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(sappassword);
  }

  static Future<bool> saveTerminal(String terminal1) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(terminal, terminal1);
  }

  static Future<String?> getTerminal() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(terminal);
  }

  static clearTerminal() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(terminal);
  }
}
