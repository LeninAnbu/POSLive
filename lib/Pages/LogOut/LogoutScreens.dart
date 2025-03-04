import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:posproject/Constant/ConstantRoutes.dart';
import 'package:posproject/Controller/LogoutController/LogOutControllers.dart';

import 'package:posproject/Pages/LoginScreen/LoginScreen.dart';
import 'package:provider/provider.dart';

import 'LogoutAlert.dart';

class LogoutScreenPage extends StatefulWidget {
  const LogoutScreenPage({super.key});

  @override
  State<LogoutScreenPage> createState() => _LogoutScreenPageState();
}

class _LogoutScreenPageState extends State<LogoutScreenPage> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration.zero, () {
      onBackPressLogout();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // final localizations = Localizations.of(context, AppLocalizations);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: (() {
        context.read<LogoutCtrl>().onbackpress2();
        return Future.value(false);
      }),
      child: Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                centerTitle: true,
                automaticallyImplyLeading: false,
                title: const Text('Logout'),
              ),
              Container(
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }

  DateTime? currentBackPressHome;
  Future<bool> onBackPressHome(BuildContext context) {
    Get.back();
    Get.back();

    DateTime now = DateTime.now();
    if (currentBackPressHome == null ||
        now.difference(currentBackPressHome!) > const Duration(seconds: 2)) {
      currentBackPressHome = now;
      Get.offAllNamed<dynamic>(ConstantRoutes.dashboard);

      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => LoginScreen()));

      return Future.value(true);
    }
    return Future.value(false);
  }

  onBackPressLogout() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return LogoutAlertDialog();
        });
  }
}
