// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:posproject/Controller/LoginController/LoginController.dart';
import 'package:posproject/Pages/LoginScreen/Widgets/FooterContainer.dart';

import '../../../Constant/Screen.dart';
import '../../ForgotPassword/Screens/Screens.dart';

class PosLoginScreen extends StatelessWidget {
  PosLoginScreen({
    super.key,
    required this.logCon,
  });
  LoginController logCon;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: Screens.width(context),
      height: Screens.padingHeight(context),
      //     color: Colors.red,

      child: Row(children: [
        Container(
          width: Screens.width(context) * 0.50,
          color: Theme.of(context).primaryColor,
        ),
        Container(
          width: Screens.width(context) * 0.50,
          padding: EdgeInsets.only(left: 20, right: 20, top: 30),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: Screens.bodyheight(context) * 0.35,
                  width: Screens.width(context) * 1.0,
                  // color: Colors.amber,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Welcome to Login',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),

                      // Text('Hello Again!',
                      //     style: TextStyle(
                      //         color: Colors.black, fontWeight: FontWeight.bold,fontSize: 20)),
                    ],
                  ),
                ),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.02,
                ),
                Container(
                  // color: Colors.red,
                  // margin: EdgeInsets.symmetric(vertical: 10),
                  height: Screens.bodyheight(context) * 0.50,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Form(
                    key: logCon.formkey[0],
                    child: Column(
                      children: [
                        logCon.getSettingMsg.isNotEmpty
                            ? SizedBox(
                                width: Screens.width(context),
                                child: Text(
                                  logCon.getSettingMsg,
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.red),
                                ),
                              )
                            : Container(),
                        logCon.getSettingMsg.isNotEmpty
                            ? SizedBox(
                                height: Screens.bodyheight(context) * 0.02)
                            : SizedBox(
                                height: 0,
                              ),
                        SizedBox(
                          width: Screens.width(context) * 0.30,
                          //color: Colors.amber,
                          child: TextFormField(
                            autofocus: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.grey[200],
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 3)),
                              labelText: 'Email',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'UserName Required';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.02,
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.30,
                          child: TextFormField(
                            autofocus: true,
                            decoration: InputDecoration(
                              fillColor: Colors.grey[200],
                              filled: true,
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 3)),
                              suffixIcon: IconButton(
                                icon: logCon.getHidepassword
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                                onPressed: () {
                                  logCon.obsecure();
                                },
                              ),
                              labelText: 'Password',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'password Required';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.01,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotMainScreen()));
                          },
                          child: Container(
                            width: Screens.width(context) * 0.30,
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Recover Password?',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        //   ],
                        // ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.02,
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.30,
                          child: ElevatedButton(
                            onPressed: () {
                              logCon.validate(context, theme);
                            },
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(600, 50),
                                backgroundColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                )),
                            child: Text('Login'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FooterContainer(height: Screens.bodyheight(context) * 0.1)
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
