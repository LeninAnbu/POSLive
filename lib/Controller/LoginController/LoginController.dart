import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:platform_device_id/platform_device_id.dart';
import 'package:posproject/DBModel/UserDBModel.dart';
import 'package:posproject/Service/loginUserApi.dart';
import 'package:posproject/Service/UsersAPI.dart';
import 'package:sqflite/sqflite.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/SharedPreference.dart';
import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';
import '../../Models/Service Model/LoginUserModel.dart';
import '../../main.dart';

class LoginController extends ChangeNotifier {
  Future<void> init() async {
    // isalreadyset=false;
    await SharedPref.clearHost();
    await SharedPref.clearSiteCode();
    await SharedPref.clearDeviceID();
    await SharedPref.clearTerminal();
    await SharedPref.clearUserSP();
    await SharedPref.clearSapDB();
    disableBtn = false;
    incorrectPwd = '';
    createDB();
    getDeviceID();
  }

  List<GlobalKey<FormState>> formkey =
      List.generate(10, (i) => GlobalKey<FormState>());
  List<TextEditingController> mycontroller =
      List.generate(50, (i) => TextEditingController());
  static bool loginPageScrn = false;
  bool hidePassword = true;
  bool get getHidepassword => hidePassword;
  String settingMsg = '';
  String get getSettingMsg => settingMsg;
  String siteCode = '';
  List<String> catchmsg = [];
  List<UserModelDB> usersValues = [];

  createDB() async {
    await DBHelper.getInstance().then((value) {});
  }

  void obsecure() {
    hidePassword = !hidePassword;
    notifyListeners();
  }

  bool disableBtn = false;
  void validate(BuildContext context, ThemeData theme) async {
    disableBtn = true;
    if (formkey[0].currentState!.validate()) {
      String? host = await SharedPref.getHostDSP();
      String? siteCode = await SharedPref.getBranchSSP();
      if (host != null && siteCode != null) {
        callLoginApi(context, theme);
      }
    }
  }

  final formkeysetting = GlobalKey<FormState>();
  void settingvalidate(BuildContext context) async {
    if (formkey[1].currentState!.validate()) {
      await SharedPref.saveHostSP(mycontroller[2].text.trim());
      await SharedPref.saveBranchSP(mycontroller[4].text.toUpperCase().trim());
      await SharedPref.saveTerminal(mycontroller[5].text.toUpperCase().trim());
      siteCode = mycontroller[4].text.toUpperCase();
      settingMsg = "";
      getIP();
      setreadonly();
      await insertuserTable();
      notifyListeners();
      Navigator.pop(context);
    }
  }

  getIP() async {
    String? ip = await SharedPref.getHostDSP();
    String? branch = await getBranch();
    String? terminal = await getTerminal();

    if (ip != null &&
        ip != 'null' &&
        branch != null &&
        branch != 'null' &&
        terminal != null &&
        terminal != 'null') {
      AppConstant.branch = branch.toString();
      AppConstant.terminal = terminal.toString();
      AppConstant.ip = ip;
      receivervb();
    }
  }

  void clearSp() async {
    await SharedPref.clearDeviceID();
    await SharedPref.clearHost();
    await SharedPref.clearSiteCode();
  }

  clearController() async {
    mycontroller[2].clear();
    mycontroller[4].clear();
  }

  bool isalreadyset = false;

  getDeviceID() async {
    // int? logRecord = await getUserData();
    // if (logRecord! < 1) {
    //   insertDb('U101', 'bala', '1234', 'B1234', 'HOFG', 'T1', 'Y', 'user',
    //       'buson123B', '', '2023-02-01', '2023-02-01', 1, 1, '192.198.182.1');
    //   insertDb('U102', 'test', '1234', 'B1234', 'HOFG', 'T2', 'Y', 'user',
    //       'buson123B', '', '2023-02-01', '2023-02-01', 1, 1, '192.198.182.1');
    //   insertDb('U103', 'paramesh', '1234', 'B1234', 'HOFG', 'T3', 'Y', 'user',
    //       'buson123B', '', '2023-02-01', '2023-02-01', 1, 1, '192.198.182.1');
    //   insertDb('U104', 'anbu', '1234', 'B1234', 'HOFG', 'T4', 'Y', 'user',
    //       'buson123B', '', '2023-02-01', '2023-02-01', 1, 1, '192.198.182.1');
    //   insertDb('U105', 'sharmi', '1234', 'B1234', 'ARSFG', 'T1', 'Y', 'user',
    //       'buson123B', '', '2023-02-01', '2023-02-01', 1, 1, '192.198.182.1');
    //        insertDb('U107', 'admin', '1234', 'B1234', 'ARSFG', 'T2', 'Y', 'user',
    //       'buson123B', '', '2023-02-01', '2023-02-01', 1, 1, '192.198.182.1');
    //         insertDb('U106', 'bala1', '1234', 'B1234', 'HOGIT', 'T1', 'Y', 'user',
    //       'buson123B', '', '2023-02-01', '2023-02-01', 1, 1, '192.198.182.1');
    // }
    mycontroller[2].clear();
    mycontroller[3].clear();
    mycontroller[4].clear();
    mycontroller[5].clear();

    String? spDeviceID = await SharedPref.getDeviceIDSP();
    String? host = await SharedPref.getHostDSP();
    String? siteCode2 = await SharedPref.getBranchSSP();
    String? terminal = await SharedPref.getTerminal();
    int alreadyset = 0;
    siteCode = siteCode2.toString();
    if (spDeviceID == null) {
      spDeviceID = await config.getdeviceId();
      SharedPref.saveDeviceIDSP(spDeviceID.toString());
      mycontroller[3].text = (await SharedPref.getDeviceIDSP())!;
      notifyListeners();
    } else
      mycontroller[3].text = (await SharedPref.getDeviceIDSP())!;
    notifyListeners();

    if (host != null) {
      mycontroller[2].text = host;
      alreadyset = alreadyset + 1;
    }
    if (siteCode2 != null || siteCode2 != 'null') {
      mycontroller[4].text = siteCode2.toString();
      alreadyset = alreadyset + 1;
    }
    if (terminal != null) {
      mycontroller[5].text = terminal.toString();
      alreadyset = alreadyset + 1;
    }
    if (siteCode2 == null || host == null) {
      mycontroller[4].text = "";
      settingMsg = "Complete the setup..!!";
      notifyListeners();
    } else if ((siteCode2 != null || siteCode2 != 'null') || host != null) {
      settingMsg = "";
      notifyListeners();
    }

    setreadonly();

    if (mycontroller[4].text == "null") {
      mycontroller[4].text = "";
    }
  }

  setreadonly() async {
    String? host = await SharedPref.getHostDSP();
    String? siteCode2 = await SharedPref.getSiteCodeSP();
    String? terminal = await SharedPref.getTerminal();
    int alreadyset = 0;

    if (host != null) {
      alreadyset = alreadyset + 1;
    }
    if (siteCode2 != null || siteCode2 != 'null') {
      alreadyset = alreadyset + 1;
    }
    if (terminal != null) {
      alreadyset = alreadyset + 1;
    }
    if (alreadyset == 3) {
      isalreadyset = true;
    }

    notifyListeners();
  }

  checkWithDB(BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> result = await DBOperation.checkUSerAvail(
        db, mycontroller[0].text.trim(), mycontroller[1].text.trim(), siteCode);
    if (result.isNotEmpty) {
      await SharedPref.saveBranchSP(result[0]['branch'].toString());
      await SharedPref.saveLicenseSP(result[0]['licensekey'].toString());
      await SharedPref.saveLoggedInSP(true);
      await SharedPref.saveUserIdeSP(result[0]['autoId'].toString());
      await SharedPref.saveUserSP(result[0]['usercode'].toString());

      settingMsg = '';
      notifyListeners();
      Get.offNamed(ConstantRoutes.downloadPage);
    } else if (result.isEmpty) {
      settingMsg = 'Invalid Credential..!!';
      notifyListeners();
    }
  }

  insertuserTable() async {
    usersValues = [];
    final Database db = (await DBHelper.getInstance())!;
    await DBOperation.truncateUserMaster(db);
    await UsersAPI.getData(
      AppConstant.branch,
    ).then((value) async {
      if (value.statuscode >= 200 && value.statuscode <= 210) {
        if (value.loginuserList != null) {
          for (int i = 0; i < value.loginuserList!.length; i++) {
            usersValues.add(UserModelDB(
                usercode: value.loginuserList![i].usercode,
                userName: value.loginuserList![i].userName,
                branch: value.loginuserList![i].branch,
                terminal: value.loginuserList![i].terminal,
                createdUserID: value.loginuserList![i].createdUserID,
                createdateTime: value.loginuserList![i].createdateTime,
                lastpasswordchanged:
                    value.loginuserList![i].lastpasswordchanged,
                lastupdateIp: value.loginuserList![i].lastupdateIp,
                licensekey: value.loginuserList![i].licensekey,
                lockpin: value.loginuserList![i].lockpin,
                password: value.loginuserList![i].password,
                updatedDatetime: value.loginuserList![i].updatedDatetime,
                updateduserid: value.loginuserList![i].updateduserid,
                userstatus: value.loginuserList![i].userstatus,
                usertype: value.loginuserList![i].usertype));
          }

          await DBOperation.insertUsers(db, usersValues).then((value) {
            notifyListeners();
          });
          await DBOperation.getusers(db);
          notifyListeners();
        } else if (value.loginuserList == null) {
          catchmsg.add("Users details: ${value.exception!}");
        }
      } else if (value.statuscode >= 400 && value.statuscode <= 410) {
        catchmsg.add("Users details: ${value.exception!}");

        await Get.defaultDialog(
                title: "Alert",
                middleText: 'Something Went Wrong',
                backgroundColor: Colors.white,
                titleStyle: const TextStyle(color: Colors.red),
                middleTextStyle: const TextStyle(color: Colors.black),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: const Text("Close"),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                ],
                radius: 5)
            .then((value) {
          notifyListeners();
        });
      } else {
        incorrectPwd = 'Something went wrong. Try again';
        catchmsg.add("Users details: ${value.exception!}");
      }
    });
  }

  getFCM() async {
    String? tokenFCM = await getTokenn();
    log("FCM tocken: " + tokenFCM!);
  }

  Future<String?> getTokenn() async {
    return firebaseMessaging.getToken();
  }

  String incorrectPwd = '';
  List<LoginUserData> userdetails = [];
  callLoginApi(BuildContext context, ThemeData theme) async {
    incorrectPwd = '';
    String? tokenFCM = await getTokenn();
    log("FCM tocken: " + tokenFCM!);

    final Database db = (await DBHelper.getInstance())!;
    if (mycontroller[0].text.isNotEmpty && mycontroller[1].text.isNotEmpty) {
      List<Map<String, Object?>> userData = await DBOperation.getusersvaldata(
          db, mycontroller[0].text.toString());
      log("userData::" + userData.length.toString());
      if (userData.isNotEmpty) {
        for (int i = 0; i < userData.length; i++) {
          userdetails.add(LoginUserData(
            autoId: int.parse(userData[i]['autoId'].toString()),
            usercode: userData[i]['usercode'].toString(),
            userName: userData[i]['userName'].toString(),
            branch: userData[i]['branch'].toString(),
            terminal: userData[i]['terminal'].toString(),
            createdUserID: userData[i]['createdUserID'].toString(),
            createdateTime: userData[i]['createdateTime'].toString(),
            lastpasswordchanged: userData[i]['lastpasswordchanged'].toString(),
            lastupdateIp: userData[i]['lastupdateIp'].toString(),
            licensekey: userData[i]['licensekey'].toString(),
            lockpin: userData[i]['lockpin'].toString(),
            password: userData[i]['password'].toString(),
            updatedDatetime: userData[i]['UpdatedDatetime'].toString(),
            updateduserid: int.parse(userData[i]['updateduserid'].toString()),
            userstatus: userData[i]['userstatus'].toString(),
            usertype: userData[i]['usertype'].toString(),
          ));
          notifyListeners();
        }

        await LoginUserAPI.getData(userdetails[0].usercode.toString(), tokenFCM)
            .then((value) async {
          if (value.statuscode >= 200 && value.statuscode <= 210) {
            if (value.loginuserList != null) {
              for (int i = 0; i < value.loginuserList!.length; i++) {
                if (value.loginuserList![i].userName.toString().toLowerCase() ==
                        mycontroller[0].text.toLowerCase() &&
                    value.loginuserList![i].password.toString().toLowerCase() ==
                        mycontroller[1].text.toString().toLowerCase()) {
                  await SharedPref.saveBranchSP(
                      value.loginuserList![i].branch.toString());
                  await SharedPref.saveSlpCode(
                      value.loginuserList![i].slpCode.toString());
                  await SharedPref.saveSapDB(
                      value.loginuserList![i].sapDB.toString());
                  await SharedPref.saveSapUserName(
                      value.loginuserList![i].sapUserName.toString());
                  await SharedPref.saveSapPassword(
                      value.loginuserList![i].sapPassword.toString());
                  await SharedPref.saveLicenseSP(
                      value.loginuserList![i].licensekey.toString());
                  await SharedPref.saveLoggedInSP(true);
                  await SharedPref.saveUserIdeSP(
                      value.loginuserList![i].autoId.toString());
                  await SharedPref.saveUserSP(
                      value.loginuserList![i].usercode.toString());
                  Get.offNamed(ConstantRoutes.downloadPage);
                  notifyListeners();
                } else {
                  settingMsg = 'Invalid Credential..!!';
                  notifyListeners();
                }
              }
              notifyListeners();

              notifyListeners();
            } else if (value.loginuserList == null) {
              disableBtn = false;

              settingMsg = 'Invalid Credential..!!';
              // catchmsg.add("Users details: " + value.exception!);
              notifyListeners();
            }
          } else if (value.statuscode >= 400 && value.statuscode <= 410) {
            disableBtn = false;
            incorrectPwd = value.exception!;
            catchmsg.add("Users details: ${value.exception!}");
          } else {
            disableBtn = false;

            catchmsg.add("Users details: ${value.exception!}");
          }
        });
        notifyListeners();
      } else {
        disableBtn = false;
        bool? havenet = await config.haveInterNet();
        if (havenet == false) {
          log('haveInterNet::${havenet}');
          incorrectPwd = 'Check Your Internet';
          notifyListeners();
        } else {
          incorrectPwd = 'Invalid username and password';
          notifyListeners();
        }
      }
    }
  }

  Future<bool> onWillPop(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Are you sure?"),
            content: const Text("Do you want to exit an app"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("No"),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text("yes"))
            ],
          ),
        )) ??
        false;
  }

  insertDb(String usc, usn, pass, lockpin, brch, termial, usrSts, usrtp, lcsky,
      lstpasc, creDt, upDT, int cUID, int upUID, lasIP) async {
    final Database db = (await DBHelper.getInstance())!;
    db.rawQuery("""
insert into Users 
(usercode,username,password,lockpin,branch,terminal,userstatus,usertype,licensekey,lastpasswordchanged,
createdateTime,UpdatedDatetime,createdUserID,updateduserid,lastupdateIp)
values 
('$usc','$usn','$pass','$lockpin','$brch','$termial','$usrSts','$usrtp','$lcsky','$lstpasc',
'$creDt','$upDT','$cUID','$upUID','$lasIP')
 """);
  }

  Future<int?> getUserData() async {
    final Database db = (await DBHelper.getInstance())!;
    final List<Map<String, Object?>> result =
        await db.rawQuery("select * from Users");

    return result.length;
  }

  deleteUser() async {
    final Database db = (await DBHelper.getInstance())!;

    db.rawQuery("delete from users where autoId = 4 ");

    final List<Map<String, Object?>> result =
        await db.rawQuery("select * from Users");

    log('1 $result');
  }
}
