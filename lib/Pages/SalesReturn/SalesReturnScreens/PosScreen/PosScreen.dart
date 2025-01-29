import 'package:flutter/material.dart';
import 'package:posproject/Pages/SalesReturn/Widget/ItemList.dart';
import 'package:posproject/Pages/SalesReturn/Widget/SalesReturnPayment.dart';

import '../../../../Constant/Screen.dart';
import '../../../../Controller/SalesReturnController/SalesReturnController.dart';
import '../../../Sales Screen/Widgets/QuickOptions.dart';
import '../../Widget/BillingOptRet.dart';
import '../../Widget/BottomBtn.dart';
import '../../Widget/CustomerListt.dart';
import '../../Widget/InvoiceInfo.dart';

class SalesReturnPosScreen extends StatelessWidget {
  SalesReturnPosScreen({super.key, required this.theme, required this.prdSR});

  final ThemeData theme;
  SalesReturnController prdSR;
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
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SalesReturnItem(
                  searchHeight: Screens.padingHeight(context) * 0.69,
                  searchWidth: Screens.width(context) * 0.48,
                  theme: theme,
                  // prdsrch: prdSR,
                ),
                SalesReturnPayment(
                    theme: theme,
                    // prdSR: prdSR,
                    paymentWidth: Screens.width(context) * 0.48,
                    paymentHeight: Screens.padingHeight(context) * 0.22),
              ],
            ),
            SizedBox(
                width: Screens.width(context) * 0.39,
                //  color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomerListt(
                      custWidth: Screens.width(context) * 0.39,
                      custHeight: Screens.padingHeight(context) * 0.45,
                      theme: theme,
                      // prdSR: prdSR,
                    ),
                    InvoiceInfo(
                      theme: theme,
                      // posSR: prdSR,
                      cashWidth: Screens.width(context) * 0.39,
                      cashHeight: Screens.padingHeight(context) * 0.22,
                    ),
                    // PaymentModeBtn(
                    //   theme: theme,
                    //   salesReturnController: prdSR,
                    //   cashWidth: Screens.width(context) * 0.39,
                    //   cashHeight: Screens.padingHeight(context) * 0.09,
                    //   dialogheight: Screens.bodyheight(context) * 0.2,
                    //   dialogwidth:  Screens.width(context) * 0.48,
                    // ),
                    BottomBtn(
                      theme: theme,
                      btnheight: Screens.padingHeight(context) * 0.35,
                      btnWidth: Screens.width(context) * 0.38,
                      // posSR: prdSR,
                    )
                  ],
                )),
            SingleChildScrollView(
              child: Column(
                children: [
                  BillingOptRet(
                    salesReturnController: prdSR,
                    theme: theme,
                  ),
                  const QuickOptions(),
                ],
              ),
            )
          ],
        ));
  }
}
