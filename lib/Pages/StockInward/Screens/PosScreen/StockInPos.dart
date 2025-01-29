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
            // Container(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            // StockInReqList(
            //   searchHeight: Screens.padingHeight(context) * 0.92,
            //   searchWidth: Screens.width(context) * 0.48,
            //   theme: theme,
            //   prdsrch: prdSCD,
            // ),
            // SalesReturnPayment(
            //   theme: theme,
            //   prdPmt: prdSCD,
            //   paymentWidth: Screens.width(context) * 0.48,
            //   paymentHeight: Screens.padingHeight(context) * 0.45,
            // ),
            // ],
            //   ),
            // ),
            SizedBox(
                width: Screens.width(context) * 0.39,
                child: const SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // StockInward(
                      //   theme: theme,
                      //   stockInWidth: Screens.width(context) * 0.39,
                      //   stockInheight: Screens.padingHeight(context) * 0.92,
                      //   posC: prdSCD,
                      //   data: prdSCD.passdata,
                      //   index: prdSCD.get_i_value,
                      //   datatotal: prdSCD.StockInward,
                      // ),
                      //  InvoiceInfo(
                      //           theme: theme,
                      //           posController: prdSCD,
                      //          cashWidth: Screens.width(context) * 0.39,
                      //           cashHeight: Screens.padingHeight(context) * 0.2,
                      //         ),
                      //         PaymentModeBtn(
                      //           theme: theme,
                      //           posController: prdSCD,
                      //           cashWidth: Screens.width(context) * 0.39,
                      //           cashHeight: Screens.padingHeight(context) * 0.09,
                      //         ),
                      // StockInwardBottomBtn(
                      //   theme: theme,
                      //   btnheight: Screens.padingHeight(context) * 0.05,
                      //   btnWidth: Screens.width(context) * 0.38,
                      //   posController: prdSCD,
                      //   data: prdSCD.passdata,
                      // )
                    ],
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
