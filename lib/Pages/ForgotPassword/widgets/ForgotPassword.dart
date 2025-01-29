// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import 'ForgotBodySection.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage(
      {super.key, required this.forgetHeight, required this.forgetwidth});
  double forgetHeight;
  double forgetwidth;
  @override
  State<ForgotPasswordPage> createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  Paddings constant = Paddings();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // context.read<ForgotPasswordController>().disPosed();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            width: Screens.width(context),
            height: Screens.padingHeight(context),
            //  decoration: BoxDecoration(
            //    color: Colors.white
            //  ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              //  Stack(
              children: [
                Container(
                  width: widget.forgetwidth * 1,
                  color: Theme.of(context).primaryColor,
                ),
                ForgotBodySection(
                  forgetHeight: widget.forgetHeight,
                  forgetwidth: widget.forgetwidth * 1,
                )
              ],
            ),
          ),
        )));
  }
}
