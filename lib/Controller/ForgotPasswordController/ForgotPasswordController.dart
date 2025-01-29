import 'dart:math';

import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Pages/ForgotPassword/widgets/ConfirmPassword.dart';
import 'package:posproject/Pages/LoginScreen/LoginScreen.dart';

import '../../Pages/ForgotPassword/Mobile  Screen/widgets/MobConfirmPassword.dart';

class ForgotPasswordController extends ChangeNotifier {
  ForgotPasswordController() {
    disPosed();
  }
  List<GlobalKey<FormState>> formkey =
      List.generate(50, (i) => GlobalKey<FormState>());
  List<TextEditingController> mycontroller =
      List.generate(100, (i) => TextEditingController());

  String otpMsg = '';
  String get getotpMsg => otpMsg;
  String otpexp = '';
  String get getotpexp => otpexp;

  int? randomnum;
  String? randomgenerate;
  String? get getrandomgenerate => randomgenerate;
  String? userrandomgenerate;
  String? get getuserrandomgenerate => userrandomgenerate;

  bool? isLoading = false;

  bool managertimmervisible = false;
  bool get getmanagertimmervisible => managertimmervisible;
  bool usertimmervisible = false;
  bool get getusertimmervisible => usertimmervisible;

  bool resendOTP = false;
  bool get getresendOTP => resendOTP;
  bool userresendOTP = false;
  bool get getuserresendOTP => userresendOTP;

  bool managerotpcompleted = true;
  bool get getmanagerotpcompleted => managerotpcompleted;
  bool usergray = true;
  bool get getusergray => usergray;

  bool isLoadingRest = false;

  bool isButtonDisabled = false;
  bool get getisButtonDisabled => isButtonDisabled;
  bool userisButtonDisabled = true;
  bool get getuserisButtonDisabled => userisButtonDisabled;

  bool managerboxenable = false;
  bool get getmanagerboxenable => managerboxenable;
  bool userboxenable = false;
  bool get getuserboxenable => userboxenable;

  String errorMsh = '';
  bool erroMsgVisble = false;

  disPosed() {
    mycontroller[0].clear();
    mycontroller[1].clear();
    mycontroller[2].clear();
    mycontroller[3].clear();
    mycontroller[4].clear();
    mycontroller[5].clear();
    mycontroller[6].clear();
    mycontroller[7].clear();
    isLoading = false;

    managertimmervisible = false;
    usertimmervisible = false;
    resendOTP = false;

    isLoadingRest = false;
    managerotpcompleted = true;
    usergray = true;
    userboxenable = false;
    managerboxenable = false;
    userisButtonDisabled = true;
    randomgenerate = '';
    userrandomgenerate = '';

    notifyListeners();
  }

  managerpincodecompleted(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    if (mycontroller[6].text == randomgenerate) {
      managerotpcompleted = false;
      usergray = false;
      isButtonDisabled = true;
      userisButtonDisabled = false;
      managertimmervisible = false;
      managerboxenable = false;
      resendOTP = false;
    } else if (resendOTP == true) {
      resendOTP = true;
      showOtpNotMatchedtDialog(context, "User OTP is not matched");
      mycontroller[6].clear();
    } else {
      resendOTP = false;
      managertimmervisible = true;
      isButtonDisabled = true;
      managerotpcompleted = true;
      userisButtonDisabled = true;

      showOtpNotMatchedtDialog(context, "User OTP is not matched");
      mycontroller[6].clear();
    }
    notifyListeners();
  }

  userPincodeCompleted(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    if (mycontroller[7].text == userrandomgenerate) {
      usertimmervisible = false;
      userisButtonDisabled = true;
      usergray = true;
      usertimmervisible = false;
      userboxenable = false;

      userresendOTP = false;

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ConfirmPasswordPage()));

      notifyListeners();
    } else if (userresendOTP == true) {
      userresendOTP = true;
      showOtpNotMatchedtDialog(context, "Manager OTP is not matched");
      mycontroller[7].clear();
    } else {
      userresendOTP = false;
      usertimmervisible = true;
      usergray = false;
      userisButtonDisabled = true;
      showOtpNotMatchedtDialog(context, "Manager OTP is not matched");
      mycontroller[7].clear();
    }
    notifyListeners();
    Future.delayed(const Duration(seconds: 3));
  }

  onTime() {
    isButtonDisabled = false;
    managertimmervisible = false;
    resendOTP = true;
    managerboxenable = false;
    randomgenerate = '';
    mycontroller[6].clear();
    notifyListeners();
  }

  useronTime() {
    userisButtonDisabled = false;
    usertimmervisible = false;
    userresendOTP = true;
    userboxenable = false;
    mycontroller[7].clear();
    userrandomgenerate = '';
    notifyListeners();
  }

  userwhatsappOTP(BuildContext context) async {
    isButtonDisabled = true;
    notifyListeners();
    randomgenerate = await generateRandomNumber();

    var snackBar = SnackBar(
        duration: const Duration(seconds: 6),
        content: Text('User OTP is $randomgenerate'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    managerboxenable = true;
    managertimmervisible = true;
    if (resendOTP == true) {
      managertimmervisible = false;
      managerotpcompleted = true;
      resendOTP = true;

      Future.delayed(const Duration(seconds: 1), () {
        managertimmervisible = true;

        notifyListeners();
      });
    } else {
      isButtonDisabled = true;
      managertimmervisible = true;
    }
    notifyListeners();
  }

  managwhatsappOTP(BuildContext context) async {
    userisButtonDisabled = true;
    notifyListeners();
    userrandomgenerate = await generateRandomNumber();

    var snackBar = SnackBar(
        duration: const Duration(seconds: 6),
        dismissDirection: DismissDirection.up,
        content: Text('User OTP is $userrandomgenerate'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    usertimmervisible = true;
    userboxenable = true;
    userisButtonDisabled = true;
    usergray = false;
    if (userresendOTP == true) {
      userisButtonDisabled = false;
      usertimmervisible = false;
      usergray = false;
      Future.delayed(const Duration(seconds: 1), () {
        usertimmervisible = true;

        usergray = false;
        notifyListeners();
      });
    }
  }

  showOtpNotMatchedtDialog(BuildContext context, String texterror) {
    final theme = Theme.of(context);
    AlertDialog alert = AlertDialog(
      content: Text(
        texterror,
        style: theme.textTheme.bodyMedium?.copyWith(color: theme.primaryColor),
      ),
      actions: [
        MaterialButton(
          child: Container(
              width: Screens.padingHeight(context) * 0.5,
              height: Screens.padingHeight(context) * 0.05,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: theme.primaryColor),
              child: Center(
                child: Text("OK",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white)),
              )),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  valdationconfirmpwd(BuildContext context) {
    if (formkey[2].currentState!.validate()) {
      if (mycontroller[4].text == mycontroller[5].text) {
        confirmpwd(context);
        notifyListeners();
      } else {}
    }
  }

  String confirmpwed = '';

  confirmpwd(BuildContext context) async {
    confirmpwed = mycontroller[5].text;

    confirmPwdDialog(context, "Your Password is Successfully Changed");
    isLoading = false;
    erroMsgVisble = false;
    errorMsh = '';

    notifyListeners();
  }

  confirmPwdDialog(BuildContext context, String texterror) {
    showDialog<dynamic>(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            final theme = Theme.of(context);
            return WillPopScope(
              onWillPop: () => Future.value(false),
              child: AlertDialog(
                content: Text(
                  texterror,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: theme.primaryColor),
                ),
                actions: [
                  MaterialButton(
                    child: Container(
                        width: Screens.padingHeight(context) * 0.5,
                        height: Screens.padingHeight(context) * 0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: theme.primaryColor),
                        child: Center(
                          child: Text("OK",
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white)),
                        )),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                  )
                ],
              ),
            );
          });
        });
  }

  Future<String> generateRandomNumber() {
    var random = Random();
    for (var i = 0; i < 4; i++) {
      randomnum = random.nextInt(9999) + 1000;
    }
    notifyListeners();

    return Future.value(randomnum.toString().substring(0, 4));
  }

  forMobUserPincodeCompleted(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    if (mycontroller[7].text == userrandomgenerate) {
      usertimmervisible = false;
      userisButtonDisabled = true;
      usergray = true;
      usertimmervisible = false;
      userboxenable = false;

      userresendOTP = false;

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const MobileConfirmPassword()));

      notifyListeners();
    } else if (userresendOTP == true) {
      userresendOTP = true;
      showOtpNotMatchedtDialog(context, "Manager OTP is not matched");
      mycontroller[7].clear();
    } else {
      userresendOTP = false;
      usertimmervisible = true;
      usergray = false;
      userisButtonDisabled = true;
      showOtpNotMatchedtDialog(context, "Manager OTP is not matched");
      mycontroller[7].clear();
    }
    notifyListeners();
    Future.delayed(const Duration(seconds: 3));
  }
}
