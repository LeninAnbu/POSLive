import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Controller/LoginController/LoginController.dart';
import 'MobileScreen/MbLoginScn.dart';
import 'TabScreen/TabLoginScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<LoginController>().init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        return WillPopScope(
          onWillPop: () async =>
              await context.read<LoginController>().onWillPop(context),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(child: MobileLoginScreen()),
          ),
        );
      } else if (constraints.maxWidth <= 1300) {
        return WillPopScope(
          onWillPop: () async =>
              await context.read<LoginController>().onWillPop(context),
          child: const Scaffold(
            resizeToAvoidBottomInset: true,
            body: SafeArea(child: TabLoginScreen()),
          ),
        );
      } else {
        return ChangeNotifierProvider<LoginController>(
            create: (context) => LoginController(),
            builder: (context, child) {
              return Consumer<LoginController>(
                  builder: (BuildContext context, logCon, Widget? child) {
                return WillPopScope(
                  onWillPop: () async => await logCon.onWillPop(context),
                  child: Scaffold(body: SafeArea(child: TabLoginScreen())),
                );
              });
            });
      }
    });
  }
}
