import 'package:flutter/material.dart';
import 'package:posproject/Pages/SalesReturn/SalesReturnScreens/MobileScreen/Widegt/SalesReturnAppBar.dart';
import '../../../../Constant/Screen.dart';
import '../../../../Controller/SalesReturnController/SalesReturnController.dart';
import 'Widegt/SRBottomBtn.dart';
import 'Widegt/SRInvcWid.dart';
import 'Widegt/SRItemWidget.dart';
import 'Widegt/SRAmountCalWid.dart';
import 'Widegt/SRPaymentWidget.dart';
import 'Widegt/SalesRtnInvcWid.dart';

class SalesReturnMobile extends StatelessWidget {
  SalesReturnMobile({super.key, required this.salesReturnController});
  SalesReturnController salesReturnController;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: Screens.padingHeight(context),
      width: Screens.width(context),
      child: SingleChildScrollView(
        child: Column(children: [
          appbarRetMS("Sales Retrun", theme, context,
              salesReturnController: salesReturnController),
          SizedBox(height: Screens.bodyheight(context) * 0.01),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: Screens.width(context) * 0.02,
                vertical: Screens.padingHeight(context) * 0.01),
            child: Column(
              children: [
                SRInvcCusWid(
                    salesReturnController: salesReturnController, theme: theme),
                SizedBox(height: Screens.bodyheight(context) * 0.01),
                SRInvcWidget(
                    theme: theme, salesReturnController: salesReturnController),
                SizedBox(height: Screens.bodyheight(context) * 0.01),
                // salesReturnController.getScanneditemData.isEmpty
                //     ? SizedBox(
                //         height: 0,
                //       )
                //     :
                SRItemWid(
                    salesReturnController: salesReturnController, theme: theme),
                // SizedBox(height: Screens.bodyheight(context) * 0.01),
                // SRAmountSlctWidget(  theme: theme, salesReturnController: salesReturnController,
                // ),
                SizedBox(height: Screens.bodyheight(context) * 0.01),
                salesReturnController.getpaymentWay.isNotEmpty
                    ? SRPaymentWidget(
                        salesReturnController: salesReturnController,
                      )
                    : const SizedBox(height: 0),
                SizedBox(height: Screens.bodyheight(context) * 0.01),
                SRAmountCaltnWidget(
                    theme: theme, salesReturnController: salesReturnController),
                SizedBox(height: Screens.bodyheight(context) * 0.01),
                SRBottomBtn(
                    theme: theme, salesReturnController: salesReturnController)
              ],
            ),
          )
        ]),
      ),
    );
  }
}
