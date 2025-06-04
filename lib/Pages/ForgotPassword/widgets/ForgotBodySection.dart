import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/ForgotPasswordController/ForgotPasswordController.dart';
import '../../../Widgets/custom_elevatedBtn.dart';

class ForgotBodySection extends StatefulWidget {
  ForgotBodySection(
      {super.key, required this.forgetHeight, required this.forgetwidth});

  double forgetHeight;
  double forgetwidth;

  @override
  _ForgotBodySectionState createState() => _ForgotBodySectionState();
}

class _ForgotBodySectionState extends State<ForgotBodySection> {
  Paddings constant = Paddings();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider<ForgotPasswordController>(
        create: (context) => ForgotPasswordController(),
        builder: (context, child) {
          return Consumer<ForgotPasswordController>(
              builder: (BuildContext context, prdfpw, Widget? child) {
            return Container(
                alignment: Alignment.center,
                width: widget.forgetwidth,
                padding: constant.padding2(context),
                child: Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: widget.forgetwidth,
                          child: Text(
                            "Forgot Password",
                            style: theme.textTheme.titleLarge
                                ?.copyWith(color: theme.primaryColor),
                          ),
                        ),
                        Form(
                          key: prdfpw.formkey[0],
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: widget.forgetHeight * 0.04,
                                ),
                                Center(
                                  child: Container(
                                      padding: EdgeInsets.all(
                                          widget.forgetHeight * 0.02),
                                      width: widget.forgetwidth * 0.65,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                prdfpw.getmanagerotpcompleted ==
                                                        true
                                                    ? theme.primaryColor
                                                    : Colors.grey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Column(
                                        children: [
                                          Text(
                                            "User OTP",
                                            style: theme.textTheme.titleMedium
                                                ?.copyWith(
                                                    color:
                                                        prdfpw.getmanagerotpcompleted ==
                                                                true
                                                            ? theme.primaryColor
                                                            : Colors.grey),
                                          ),
                                          SizedBox(
                                            height: widget.forgetHeight * 0.03,
                                          ),
                                          PinCodeTextField(
                                            autoFocus: true,
                                            enablePinAutofill: true,
                                            enabled: prdfpw.getmanagerboxenable,
                                            appContext: context,
                                            pastedTextStyle: TextStyle(
                                              color: Colors.blue.shade600, //
                                              fontWeight: FontWeight.bold,
                                            ),
                                            autoDisposeControllers: true,
                                            length: 4,
                                            obscureText: true,
                                            obscuringCharacter: '*',
                                            blinkWhenObscuring: true,
                                            animationType: AnimationType.fade,
                                            pinTheme: PinTheme(
                                              shape: PinCodeFieldShape.box,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              fieldHeight:
                                                  widget.forgetHeight * 0.07,
                                              fieldWidth:
                                                  widget.forgetwidth * 0.12,
                                              inactiveFillColor: Colors.white,
                                              inactiveColor:
                                                  prdfpw.getmanagerotpcompleted ==
                                                          true
                                                      ? theme.primaryColor
                                                      : Colors.grey,
                                              activeFillColor: Colors.white,
                                              activeColor:
                                                  prdfpw.getmanagerotpcompleted ==
                                                          true
                                                      ? theme.primaryColor
                                                      : Colors.grey,
                                              selectedColor: theme.primaryColor,
                                              selectedFillColor:
                                                  theme.disabledColor,
                                            ),
                                            cursorColor: theme.primaryColor,
                                            animationDuration: const Duration(
                                                milliseconds: 300),
                                            enableActiveFill: true,
                                            controller: prdfpw.mycontroller[6],
                                            keyboardType: TextInputType.number,
                                            boxShadows: const [
                                              BoxShadow(
                                                offset: Offset(0, 1),
                                                color: Colors.black12,
                                                blurRadius: 10,
                                              )
                                            ],
                                            onCompleted: (manval) {
                                              prdfpw.managerpincodecompleted(
                                                  context);
                                            },
                                            onChanged: (manvalue) {},
                                            beforeTextPaste: (text) {
                                              return true;
                                            },
                                          ),
                                          Visibility(
                                            visible:
                                                prdfpw.getmanagertimmervisible,
                                            child: TweenAnimationBuilder<
                                                    Duration>(
                                                duration:
                                                    const Duration(seconds: 60),
                                                tween: Tween(
                                                    begin: const Duration(
                                                        seconds: 60),
                                                    end: Duration.zero),
                                                onEnd: () {
                                                  prdfpw.onTime();
                                                },
                                                builder: (BuildContext context,
                                                    Duration value,
                                                    Widget? child) {
                                                  final minutes =
                                                      value.inMinutes;

                                                  final seconds =
                                                      value.inSeconds % 60;

                                                  return Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          vertical:
                                                              Screens.width(
                                                                      context) *
                                                                  0.005),
                                                      child: Text(
                                                          '$minutes:$seconds',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: widget
                                                                      .forgetwidth *
                                                                  0.055)));
                                                }),
                                          ),
                                          SizedBox(
                                            height: widget.forgetHeight * 0.03,
                                          ),
                                          CustomSpinkitdButton(
                                            onTap: prdfpw.getisButtonDisabled ==
                                                    true
                                                ? null
                                                : () {
                                                    prdfpw.userwhatsappOTP(
                                                        context);
                                                  },
                                            label: prdfpw.getresendOTP == false
                                                ? 'Send OTP'
                                                : "Resend OTP",
                                            labelLoading:
                                                prdfpw.getresendOTP == false
                                                    ? "Send OTP"
                                                    : "Resend OTP",
                                            textcolor:
                                                prdfpw.getmanagerotpcompleted ==
                                                        true
                                                    ? Colors.white
                                                    : Colors.grey,
                                          )
                                        ],
                                      )),
                                ),
                              ]),
                        ),
                        SizedBox(height: widget.forgetHeight * 0.08),
                        Form(
                            key: prdfpw.formkey[1],
                            child: Center(
                              child: Container(
                                  width: widget.forgetwidth * 0.65,
                                  padding: EdgeInsets.all(
                                      widget.forgetHeight * 0.02),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: prdfpw.getusergray == true
                                            ? Colors.grey
                                            : theme.primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Manager OTP",
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                          color: prdfpw.getusergray == true
                                              ? Colors.grey
                                              : theme.primaryColor,
                                        ),
                                      ),
                                      SizedBox(
                                          height: widget.forgetHeight * 0.03),
                                      PinCodeTextField(
                                        autoFocus: true,
                                        enablePinAutofill: true,
                                        enabled: prdfpw.getuserboxenable,
                                        appContext: context,
                                        pastedTextStyle: TextStyle(
                                          color: Colors.blue.shade600, //
                                          fontWeight: FontWeight.bold,
                                        ),
                                        autoDisposeControllers: false,
                                        length: 4,
                                        obscureText: true,
                                        obscuringCharacter: '*',
                                        blinkWhenObscuring: true,
                                        animationType: AnimationType.fade,
                                        pinTheme: PinTheme(
                                          shape: PinCodeFieldShape.box,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          fieldHeight:
                                              widget.forgetHeight * 0.07,
                                          fieldWidth: widget.forgetwidth * 0.12,
                                          inactiveFillColor: Colors.white,
                                          inactiveColor:
                                              prdfpw.getusergray == true
                                                  ? Colors.grey
                                                  : theme.primaryColor,
                                          activeFillColor: Colors.white,
                                          activeColor:
                                              prdfpw.getusergray == true
                                                  ? Colors.grey
                                                  : theme.primaryColor,
                                          selectedColor: theme.primaryColor,
                                          selectedFillColor:
                                              theme.disabledColor,
                                        ),
                                        cursorColor: theme.primaryColor,
                                        animationDuration:
                                            const Duration(milliseconds: 300),
                                        enableActiveFill: true,
                                        controller: prdfpw.mycontroller[7],
                                        keyboardType: TextInputType.number,
                                        boxShadows: const [
                                          BoxShadow(
                                            offset: Offset(0, 1),
                                            color: Colors.black12,
                                            blurRadius: 10,
                                          )
                                        ],
                                        onCompleted: (userv) {
                                          prdfpw.userPincodeCompleted(context);
                                        },
                                        onChanged: (uservalue) {},
                                        beforeTextPaste: (usertext) {
                                          return true;
                                        },
                                      ),
                                      Visibility(
                                        visible: prdfpw.getusertimmervisible,
                                        child: TweenAnimationBuilder<Duration>(
                                            duration:
                                                const Duration(seconds: 60),
                                            tween: Tween(
                                                begin:
                                                    const Duration(seconds: 60),
                                                end: Duration.zero),
                                            onEnd: () {
                                              prdfpw.useronTime();
                                            },
                                            builder: (BuildContext context,
                                                Duration value, Widget? child) {
                                              final minutes = value.inMinutes;

                                              final seconds =
                                                  value.inSeconds % 60;

                                              return Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical:
                                                          widget.forgetwidth *
                                                              0.005),
                                                  child: Text(
                                                      '$minutes:$seconds',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: widget
                                                                  .forgetwidth *
                                                              0.055)));
                                            }),
                                      ),
                                      SizedBox(
                                          height: widget.forgetHeight * 0.03),
                                      CustomSpinkitdButton(
                                          onTap:
                                              prdfpw.getuserisButtonDisabled ==
                                                      true
                                                  ? null
                                                  : () {
                                                      prdfpw.managwhatsappOTP(
                                                          context);
                                                    },
                                          label:
                                              prdfpw.getuserresendOTP == false
                                                  ? 'Send OTP'
                                                  : "Resend OTP",
                                          labelLoading:
                                              prdfpw.getuserresendOTP == false
                                                  ? "Send OTP"
                                                  : "Resend OTP",
                                          textcolor: prdfpw.getusergray == true
                                              ? Colors.grey
                                              : Colors.white)
                                    ],
                                  )),
                            ))
                      ]),
                ));
          });
        });
  }
}
