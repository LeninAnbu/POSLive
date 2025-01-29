// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'Widget/BodyContainer.dart';
import 'Widget/FooterContainer.dart';
import 'Widget/HeadingContainer.dart';

class MobileLoginScreen extends StatelessWidget {
  MobileLoginScreen({
    super.key, //required this.logCon,
    this.height,
    this.width,
  });
//final LoginController logCon;
  double? height;
  double? width;
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Container(
      // color: Colors.amber,
      width: Screens.width(context),
      padding: EdgeInsets.only(
        left: Screens.width(context) * 0.02,
        right: Screens.width(context) * 0.02,
        top: Screens.padingHeight(context) * 0.02,
      ),
      //  child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HeadingContainerMob(),
          SizedBox(
            height: Screens.bodyheight(context) * 0.01,
          ),
          BodyContainerMob(//logCon: logCon,
              ),
          //SizedBox(height: Screens.bodyheight(context)*0.19,),
          FooterContainerMob(
            //logCon: logCon,
            height: Screens.bodyheight(context) * 0.20,
          ),
        ],
      ),
      // ),
    );
  }
}
