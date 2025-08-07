import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posproject/Pages/LoginScreen/LoginScreen.dart';
import 'package:provider/provider.dart';

import '../../../Constant/ConstantRoutes.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/ForgotPasswordController/ForgotPasswordController.dart';
import '../../../Widgets/custom_elevatedBtn.dart';
import 'custom_shake_transtition.dart';

class ConfirmPasswordPage extends StatefulWidget {
  const ConfirmPasswordPage({super.key});

  @override
  State<ConfirmPasswordPage> createState() => _ConfirmPasswordPageState();
}

class _ConfirmPasswordPageState extends State<ConfirmPasswordPage> {
  Paddings constant = Paddings();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WillPopScope(
        onWillPop: () {
          onbackpresslogin();

          return Future.value(false);
        },
        child: Scaffold(
            body: ChangeNotifierProvider<ForgotPasswordController>(
                create: (context) => ForgotPasswordController(),
                builder: (context, child) {
                  return Consumer<ForgotPasswordController>(
                      builder: (BuildContext context, prdconf, Widget? child) {
                    return SafeArea(
                        child: Row(
                      children: [
                        Container(
                          height: Screens.padingHeight(context),
                          width: Screens.width(context) * 0.50,
                          color: Theme.of(context).primaryColor,
                        ),
                        Container(
                          width: Screens.width(context) * 0.50,
                          padding: constant.padding2(context),
                          child: Center(
                            child: Form(
                              key: prdconf.formkey[2],
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height:
                                          Screens.padingHeight(context) * 0.04),
                                  CustomShakeTransition(
                                    child: Text(
                                      "New Password",
                                      style: theme.textTheme.titleLarge
                                          ?.copyWith(color: theme.primaryColor),
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.01,
                                  ),
                                  CustomShakeTransition(
                                    duration: const Duration(milliseconds: 900),
                                    child: SizedBox(
                                      width: Screens.width(context) * 0.3,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (prdconf.mycontroller[4].text !=
                                              prdconf.mycontroller[5].text) {
                                            return "*Not Match";
                                          } else if (prdconf
                                              .mycontroller[4].text.isEmpty) {
                                            return "Please Enter Password";
                                          }

                                          return null;
                                        },
                                        obscureText: true,
                                        controller: prdconf.mycontroller[4],
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 10),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Colors.red),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Colors.red),
                                          ),
                                        ),
                                        cursorColor: Colors.green,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          Screens.padingHeight(context) * 0.05),
                                  CustomShakeTransition(
                                    child: Text(
                                      "Confirm Password",
                                      style: theme.textTheme.titleLarge
                                          ?.copyWith(color: theme.primaryColor),
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.01,
                                  ),
                                  CustomShakeTransition(
                                    duration: const Duration(milliseconds: 900),
                                    child: SizedBox(
                                      width: Screens.width(context) * 0.3,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (prdconf.mycontroller[4].text !=
                                              prdconf.mycontroller[5].text) {
                                            return "*Not Match";
                                          } else if (prdconf
                                              .mycontroller[4].text.isEmpty) {
                                            return "Please Enter Password";
                                          }

                                          return null;
                                        },
                                        obscureText: true,
                                        controller: prdconf.mycontroller[5],
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 10),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Colors.red),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Colors.red),
                                          ),
                                        ),
                                        cursorColor: Colors.green,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.06,
                                  ),
                                  SizedBox(
                                    width: Screens.width(context) * 0.3,
                                    child: CustomSpinkitdButton(
                                      onTap: () {
                                        prdconf.valdationconfirmpwd(context);
                                      },
                                      isLoading: prdconf.isLoadingRest,
                                      labelLoading: 'Reseting',
                                      label: 'Reset',
                                      textcolor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ));
                  });
                })));
  }

  DateTime? currentBackPressprofile;
  Future<bool> onbackpressprofile() {
    DateTime now = DateTime.now();
    if (currentBackPressprofile == null ||
        now.difference(currentBackPressprofile!) > const Duration(seconds: 2)) {
      currentBackPressprofile = now;
      Get.offAllNamed(ConstantRoutes.newprofile);
      return Future.value(false);
    }
    return Future.value(false);
  }

  DateTime? currentBackPressLogin;

  Future<bool> onbackpresslogin() {
    DateTime now = DateTime.now();
    if (currentBackPressLogin == null ||
        now.difference(currentBackPressLogin!) > const Duration(seconds: 2)) {
      currentBackPressLogin = now;
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));

      return Future.value(false);
    }
    return Future.value(false);
  }
}
