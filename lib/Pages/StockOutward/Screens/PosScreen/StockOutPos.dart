import 'package:flutter/material.dart';
import 'package:posproject/Pages/StockOutward/Widgets/BillingOptions.dart';

import '../../../../Constant/Screen.dart';
import '../../../../Controller/StockOutwardController/StockOutwardController.dart';
import '../../../Sales Screen/Widgets/QuickOptions.dart';

class StockOutPos extends StatelessWidget {
  StockOutPos({super.key, required this.theme, required this.stOutCon});

  final ThemeData theme;
  StockOutwardController stOutCon;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey.withOpacity(0.05),
        height: Screens.padingHeight(context),
        padding: EdgeInsets.only(
          top: Screens.padingHeight(context) * 0.02,
          left: Screens.padingHeight(context) * 0.01,
          right: Screens.padingHeight(context) * 0.01,
          bottom: Screens.padingHeight(context) * 0.01,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: Screens.width(context) * 0.39,
                child: const SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [],
                  ),
                )),
            SingleChildScrollView(
              child: Column(
                children: [
                  BillingOptions(theme: theme, posController: stOutCon),
                  const QuickOptions()
                ],
              ),
            ),
          ],
        ));
  }
}
