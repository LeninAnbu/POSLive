import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'Widget/BodyContainer.dart';
import 'Widget/FooterContainer.dart';
import 'Widget/HeadingContainer.dart';

class MobileLoginScreen extends StatelessWidget {
  MobileLoginScreen({
    super.key,
    this.height,
    this.width,
  });

  double? height;
  double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Screens.width(context),
      padding: EdgeInsets.only(
        left: Screens.width(context) * 0.02,
        right: Screens.width(context) * 0.02,
        top: Screens.padingHeight(context) * 0.02,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HeadingContainerMob(),
          SizedBox(
            height: Screens.bodyheight(context) * 0.01,
          ),
          BodyContainerMob(),
          FooterContainerMob(
            height: Screens.bodyheight(context) * 0.20,
          ),
        ],
      ),
    );
  }
}
