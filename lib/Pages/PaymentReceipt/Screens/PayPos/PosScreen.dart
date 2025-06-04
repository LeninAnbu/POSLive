import 'package:flutter/material.dart';
import 'package:posproject/Pages/PaymentReceipt/Widget/InventoriesList.dart';
import '../../../../Constant/Screen.dart';
import '../../../Sales Screen/Widgets/QuickOptions.dart';
import '../../Widget/PayBillingOption.dart';
import '../../Widget/PayBtmBtn.dart';
import '../../Widget/PayTypeBtns.dart';
import '../../Widget/Paymethod.dart';
import '../../Widget/payCustomerdetails.dart';

class PaymentRecieptPos extends StatelessWidget {
  const PaymentRecieptPos({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Inventories(
                    searchHeight: Screens.padingHeight(context) * 0.8,
                    searchWidth: Screens.width(context) * 0.48,
                    theme: theme,
                  ),
                  PayReceiptPayDetails(
                    theme: theme,
                    paymentWidth: Screens.width(context) * 0.48,
                    paymentHeight: Screens.padingHeight(context) * 0.12,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PayCustomerDetails(
                    custWidth: Screens.width(context) * 0.39,
                    custHeight: Screens.padingHeight(context) * 0.8,
                    theme: theme,
                  ),
                  PayTypeBtns(
                    cashWidth: Screens.width(context) * 0.39,
                    cashHeight: Screens.padingHeight(context) * 0.2,
                    theme: theme,
                  ),
                  PayBtmBtn(
                    theme: theme,
                    btnheight: Screens.padingHeight(context) * 0.38,
                    btnWidth: Screens.width(context) * 0.39,
                  )
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    PayBillingOptions(
                      theme: theme,
                    ),
                    const QuickOptions(),
                  ],
                ),
              )
            ]));
  }
}
