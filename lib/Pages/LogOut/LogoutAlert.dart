import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posproject/Constant/ConstantRoutes.dart';
import 'package:posproject/Controller/LogoutController/LogOutControllers.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Constant/Screen.dart';

class LogoutAlertDialog extends StatefulWidget {
  const LogoutAlertDialog({super.key});

  @override
  State<LogoutAlertDialog> createState() => _LogoutAlertDialogState();
}

class _LogoutAlertDialogState extends State<LogoutAlertDialog> {
  Future<SharedPreferences> pref = SharedPreferences.getInstance();
  DateTime? currentBackPress;
  Future<bool> onBackPressHome(BuildContext context) {
    DateTime now = DateTime.now();
    if (currentBackPress == null ||
        now.difference(currentBackPress!) > const Duration(seconds: 2)) {
      Get.back();
      currentBackPress = now;

      return Future.value(false);
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () => context.read<LogoutCtrl>().onbackpress3(),
      child: AlertDialog(
        insetPadding: const EdgeInsets.all(10),
        contentPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        // title: Text("Are you sure?"),
        // content: Text("Do you want to exit?"),
        content: SizedBox(
          width: Screens.width(context) * 0.42,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                // width: Screens.width(context),
                width: Screens.width(context) * 0.5,
                height: Screens.bodyheight(context) * 0.06,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,

                      textStyle: const TextStyle(),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      )), //Radius.circular(6)
                    ),
                    child: const Text("Alert",
                        style: TextStyle(fontSize: 15, color: Colors.white))),
              ),
              SizedBox(
                height: Screens.padingHeight(context) * 0.01,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 40),
                  width: Screens.width(context) * 0.85,
                  child: const Divider(
                    color: Colors.grey,
                  )),
              Container(
                  alignment: Alignment.center,
                  // width: Screens.width(context)*0.5,
                  // padding: EdgeInsets.only(left:20),
                  child: const Text(
                    "Logging out will erase all the master data and documents in hold. ",
                    style: TextStyle(fontSize: 15),
                  )),
              SizedBox(
                height: Screens.padingHeight(context) * 0.01,
              ),
              Container(
                  alignment: Alignment.center,
                  // padding: EdgeInsets.only(left:20),
                  child: const Text("Do you want to continue?",
                      style: TextStyle(fontSize: 15))),
              Container(
                  padding: const EdgeInsets.only(left: 40),
                  width: Screens.width(context) * 0.85,
                  child: const Divider(color: Colors.grey)),
              SizedBox(
                height: Screens.bodyheight(context) * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: Screens.width(context) * 0.2,
                    height: Screens.bodyheight(context) * 0.06,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,

                          // primary: theme.primaryColor,
                          textStyle: const TextStyle(color: Colors.white),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(0),
                          )),
                        ),
                        onPressed: () async {
                          Get.offAllNamed(ConstantRoutes.dashboard);
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  SizedBox(
                    width: Screens.width(context) * 0.2,
                    height: Screens.bodyheight(context) * 0.06,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,

                          // primary: theme.primaryColor,
                          textStyle: const TextStyle(color: Colors.white),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(10),
                          )),
                        ),
                        onPressed: () {
                          context.read<LogoutCtrl>().clearData(context);
                        },
                        child: const Text(
                          "Logout",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
        // actions: [
        //   TextButton(
        //     onPressed: () => Navigator.of(context).pop(false),
        //     child: Text("No"),
        //   ),
        //   TextButton(
        //       onPressed: () {
        //         exit(0);
        //       },
        //       child: Text("yes"))
        // ],
      ),
    );
  }
}
