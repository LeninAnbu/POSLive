import 'package:flutter/material.dart';
import 'package:posproject/Pages/Sales%20Screen/Widgets/QuickOptions.dart';
import 'package:posproject/Pages/StockInward/Widgets/BillingOptions.dart';
// import 'package:posproject/Pages/Sales%20Screen/Widgets/BillingOptions.dart';

import '../../../../Constant/Screen.dart';

import '../../../../../Controller/StockInwardController/StockInwardContler.dart';

class StockInPos extends StatelessWidget {
  StockInPos({super.key, required this.theme, required this.prdSCD});

  final ThemeData theme;
  StockInwrdController prdSCD;

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
                  BillingOptions(
                    theme: theme,
                  ),
                  const QuickOptions()
                ],
              ),
            ),
          ],
        ));
  }
}
