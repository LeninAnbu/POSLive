import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Controller/ForgotPasswordController/ForgotPasswordController.dart';
import 'package:posproject/Pages/ForgotPassword/widgets/ForgotPassword.dart';
import 'package:provider/provider.dart';

import '../../../Widgets/Drawer.dart';
import '../../../Widgets/MobileDrawer.dart';
import '../Mobile  Screen/Screens/ForgotPassword.dart';

class ForgotMainScreen extends StatefulWidget {
  const ForgotMainScreen({super.key});

  @override
  State<ForgotMainScreen> createState() => _ForgotMainScreenState();
}

class _ForgotMainScreenState extends State<ForgotMainScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        return Scaffold(
          drawer: naviDrawerMob(context),
          body: ChangeNotifierProvider<ForgotPasswordController>(
              create: (context) => ForgotPasswordController(),
              builder: (context, child) {
                return Consumer<ForgotPasswordController>(
                    builder: (BuildContext context, prdSCD, Widget? child) {
                  return const SafeArea(
                    child: RegisterPage(),
                  );
                });
              }),
        );
      } else if (constraints.maxWidth <= 1300) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: naviDrawer(),
          body: ChangeNotifierProvider<ForgotPasswordController>(
              create: (context) => ForgotPasswordController(),
              builder: (context, child) {
                return Consumer<ForgotPasswordController>(
                    builder: (BuildContext context, prdSCD, Widget? child) {
                  return SafeArea(
                      child: ForgotPasswordPage(
                          forgetHeight: Screens.bodyheight(context),
                          forgetwidth: Screens.width(context) * 0.5));
                });
              }),
        );
      } else {
        return Scaffold(
          body: ChangeNotifierProvider<ForgotPasswordController>(
              create: (context) => ForgotPasswordController(),
              builder: (context, child) {
                return Consumer<ForgotPasswordController>(
                    builder: (BuildContext context, prdSCD, Widget? child) {
                  return SafeArea(
                      child: ForgotPasswordPage(
                    forgetHeight: Screens.padingHeight(context),
                    forgetwidth: Screens.width(context) * 0.5,
                  ));
                });
              }),
        );
      }
    });
  }
}
