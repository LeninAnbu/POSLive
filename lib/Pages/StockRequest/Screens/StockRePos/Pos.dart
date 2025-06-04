import 'package:flutter/material.dart';
import 'package:posproject/Controller/StockRequestController/StockRequestController.dart';
import 'package:posproject/Pages/StockRequest/Widget/BillingOptions.dart';

import '../../../../Constant/Screen.dart';
import '../../../Sales Screen/Widgets/QuickOptions.dart';

class StockReqPos extends StatelessWidget {
  StockReqPos({super.key, required this.theme, required this.prdSCD});

  final ThemeData theme;
  StockReqController prdSCD;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey.withOpacity(0.05),
        height: Screens.padingHeight(context),
        padding: EdgeInsets.only(
          top: Screens.padingHeight(context) * 0.01,
          left: Screens.padingHeight(context) * 0.01,
          right: Screens.padingHeight(context) * 0.01,
          bottom: Screens.padingHeight(context) * 0.01,
        ),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [],
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    ReqBillingOptions(theme: theme, posController: prdSCD),
                    const QuickOptions()
                  ],
                ),
              ),
            ]));
  }
}
