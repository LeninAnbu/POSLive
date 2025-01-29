import 'package:flutter/material.dart';
import '../../../../Constant/Screen.dart';
import '../../../../Controller/SalesQuotationController/SalesQuotationController.dart';
import '../../Widgets/BillingOptions.dart';
import '../../Widgets/BottomButton.dart';
import '../../Widgets/CashandCheque.dart';
import '../../Widgets/CustomerDetails.dart';
import '../../Widgets/Paymentpage.dart';
import '../../Widgets/QuickOptions.dart';
import '../../Widgets/ItemLists.dart';

class SOPosScreen extends StatelessWidget {
  SOPosScreen({super.key, required this.theme, required this.prdSCD});

  final ThemeData theme;
  SalesQuotationCon prdSCD;

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
                SQuotationSearchWidget(
                  searchHeight: Screens.padingHeight(context) * 0.69,
                  searchWidth: Screens.width(context) * 0.48,
                  theme: theme,
                ),
                SQuotationPayDetails(
                  theme: theme,
                  paymentWidth: Screens.width(context) * 0.48,
                  paymentHeight: Screens.padingHeight(context) * 0.22,
                )
              ],
            ),
            SizedBox(
                width: Screens.width(context) * 0.39,
                //  color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SQCustomerDetails(
                      custWidth: Screens.width(context) * 0.39,
                      custHeight: Screens.padingHeight(context) * 0.45,
                      theme: theme,
                    ),
                    SQCashWidget(
                      theme: theme,
                      cashWidth: Screens.width(context) * 0.39,
                      cashHeight: Screens.padingHeight(context) * 0.2,
                    ),
                    SQBottomButtons(
                        theme: theme,
                        btnheight: Screens.padingHeight(context) * 0.3,
                        btnWidth: Screens.width(context) * 0.38)
                  ],
                )),
            SingleChildScrollView(
              child: Column(
                children: [
                  SQBillingOptions(
                    theme: theme,
                    sqController: prdSCD,
                  ),
                  const QuickOptions(),
                ],
              ),
            )
          ],
        ));
  }
}
