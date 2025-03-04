import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posproject/Pages/LoginScreen/LoginScreen.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../Constant/ConstantRoutes.dart';
import '../../Constant/SharedPreference.dart';
import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';
import '../LoginController/LoginController.dart';

class LogoutCtrl extends ChangeNotifier {
  init() {}
  PageController page = PageController(initialPage: 0);
  DateTime? currentBackPressTime;
  DateTime? currentBackPressTime2;

  Future<bool> onbackpress3() {
    Get.back();
    final now = DateTime.now();

    if (currentBackPressTime2 == null ||
        now.difference(currentBackPressTime2!) > const Duration(seconds: 2)) {
      currentBackPressTime2 = now;

      Get.offAllNamed<dynamic>(ConstantRoutes.dashboard);
      notifyListeners();
      return Future.value(false);
    } else {
      return Future.value(false);
    }
  }

  Future<bool> onbackpress2() {
    final now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.offAllNamed<dynamic>(ConstantRoutes.dashboard);
      return Future.value(false);
    } else {
      return Future.value(false);
    }
  }

  clearData(BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;

    await DBOperation.truncateItemMaster(db);
    await DBOperation.truncateStockSnap(db);
    await DBOperation.truncateBranchMaster(db);
    await DBOperation.truncateCouponDetailsMaster(db);
    await DBOperation.truncateCustomerMasterAddress(db);
    await DBOperation.truncateCustomerMaster(db);
    await DBOperation.deleteNotifyAll(db);
    await DBOperation.truncateUserMaster(db);
    await DBOperation.deleteSalesQuot(db);
    await DBOperation.deleteSalesOrder(db);
    await DBOperation.deleteInvoicewholedata(db);
    await DBOperation.dltsalesret(db);
    await DBOperation.deletereceipt(db);
    await DBOperation.deleteStockreq(db);
    await DBOperation.deleteStOutTable(db);
    await DBOperation.deleteStkInward(db);
    await DBOperation.deleteExpense(db);
    await SharedPref.clearHost();
    await SharedPref.clearLoggedIN();
    await SharedPref.clearSiteCode();
    await SharedPref.clearTerminal();
    await SharedPref.clrBranchSSP();
    await SharedPref.clrUserIdSP();
    await SharedPref.clrdsappassword();
    await SharedPref.clrsapusername();
    context.read<LoginController>().mycontroller[0].text = '';
    context.read<LoginController>().mycontroller[1].text = '';
    context.read<LoginController>().mycontroller[2].text = '';
    context.read<LoginController>().mycontroller[4].text = '';
    context.read<LoginController>().mycontroller[5].text = '';

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));

    notifyListeners();
  }
}
