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
        // color: Colors.red,
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
            // Container(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            // StockOutReqList(
            //   searchHeight: Screens.padingHeight(context) * 0.9,
            //   searchWidth: Screens.width(context) * 0.48,
            //   theme: theme,
            //   StOut_Con: StOut_Con,
            // ),

            SizedBox(
                width: Screens.width(context) * 0.39,
                child: const SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // StockOutward(
                      //   theme: theme,
                      //   stockInWidth: Screens.width(context) * 0.39,
                      //   stockInheight: Screens.padingHeight(context) * 0.92,
                      //   StOut_Con: StOut_Con,
                      //   data: StOut_Con.passdata,
                      //   index: StOut_Con.get_i_value,
                      //   datatotal: StOut_Con.StockOutward,
                      // ),
                      //  InvoiceInfo(
                      //           theme: theme,
                      //           posController: StOut_Con,
                      //          cashWidth: Screens.width(context) * 0.39,
                      //           cashHeight: Screens.padingHeight(context) * 0.2,
                      //         ),
                      //         PaymentModeBtn(
                      //           theme: theme,
                      //           posController: StOut_Con,
                      //           cashWidth: Screens.width(context) * 0.39,
                      //           cashHeight: Screens.padingHeight(context) * 0.09,
                      //         ),
                      // StockInwardBottomBtn(
                      //   theme: theme,
                      //   btnheight: Screens.padingHeight(context) * 0.05,
                      //   btnWidth: Screens.width(context) * 0.38,
                      //   posController: StOut_Con,
                      //   data: StOut_Con.passdata,
                      // )
                    ],
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
