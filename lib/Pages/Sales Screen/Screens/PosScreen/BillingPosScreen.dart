import 'package:flutter/material.dart';
import 'package:posproject/Controller/SalesInvoice/SalesInvoiceController.dart';
import 'package:posproject/Pages/Sales%20Screen/Widgets/BillingOptions.dart';

import '../../../../Constant/Screen.dart';
import '../../Widgets/BottomButton.dart';
import '../../Widgets/CashandCheque.dart';
import '../../Widgets/CustomerDetails.dart';
import '../../Widgets/Paymentpage.dart';
import '../../Widgets/QuickOptions.dart';
import '../../Widgets/ItemLists.dart';

class PosScreen extends StatelessWidget {
  PosScreen({super.key, required this.theme, required this.prdSCD});

  final ThemeData theme;
  PosController prdSCD;

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
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SearchWidget(
                  searchHeight: Screens.padingHeight(context) * 0.69,
                  searchWidth: Screens.width(context) * 0.48,
                  theme: theme,
                ),
                PaymentDetails(
                  theme: theme,
                  paymentWidth: Screens.width(context) * 0.48,
                  paymentHeight: Screens.padingHeight(context) * 0.22,
                )
              ],
            ),
            SizedBox(
                width: Screens.width(context) * 0.39,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomerDetails(
                      custWidth: Screens.width(context) * 0.39,
                      custHeight: Screens.padingHeight(context) * 0.45,
                      theme: theme,
                    ),
                    CashWidget(
                      theme: theme,
                      cashWidth: Screens.width(context) * 0.39,
                      cashHeight: Screens.padingHeight(context) * 0.2,
                    ),
                    BottomButtons(
                      theme: theme,
                      btnheight: Screens.padingHeight(context) * 0.3,
                      btnWidth: Screens.width(context) * 0.38,
                    )
                  ],
                )),
            SingleChildScrollView(
              child: Column(
                children: [
                  BillingOptions(
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
