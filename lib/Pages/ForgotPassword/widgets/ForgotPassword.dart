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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            width: Screens.width(context),
            height: Screens.padingHeight(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
