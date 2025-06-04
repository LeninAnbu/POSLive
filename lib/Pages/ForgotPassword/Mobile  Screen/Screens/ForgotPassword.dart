import 'package:flutter/material.dart';
import 'package:posproject/Constant/padings.dart';
import '../../../../Constant/Screen.dart';

import '../widgets/ForgotBodySection.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
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
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [MobForgotBodySection()],
            ),
          ),
        )));
  }
}
