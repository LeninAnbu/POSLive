import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:posproject/Pages/PaymentReceipt/Widget/PayBtmBtn.dart';
import 'package:posproject/Pages/PaymentReceipt/Widget/payCustomerdetails.dart';
import 'package:provider/provider.dart';
import '../../../../Constant/Screen.dart';
import '../../../../Controller/PaymentReceiptController/PayReceiptController.dart';
import '../../Widget/InventoriesList.dart';
import '../../Widget/PayTypeBtns.dart';
import '../../Widget/Paymethod.dart';

class PaymentTab extends StatelessWidget {
  const PaymentTab({
    super.key,
    required this.theme,
  });

  final ThemeData theme;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
              color: Colors.grey.withOpacity(0.05),
              height: Screens.bodyheight(context) * 0.96,
              padding: EdgeInsets.only(
                top: Screens.bodyheight(context) * 0.02,
                left: Screens.bodyheight(context) * 0.01,
                right: Screens.bodyheight(context) * 0.01,
                bottom: Screens.bodyheight(context) * 0.01,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: Screens.width(context) * 0.5,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Inventories(
                              searchHeight: Screens.bodyheight(context) * 0.7,
                              searchWidth: Screens.width(context) * 0.48,
                              theme: theme,
                            ),
                            PayReceiptPayDetails(
                              theme: theme,
                              paymentWidth: Screens.width(context) * 0.48,
                              paymentHeight: Screens.bodyheight(context) * 0.15,
                            )
                          ])),
                  SizedBox(
                      width: Screens.width(context) * 0.48,
                      // color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          context.watch<PayreceiptController>().loadingscrn ==
                                  true
                              ? SizedBox(
                                  width: Screens.width(context) * 0.48,
                                  height: Screens.bodyheight(context) * 0.32,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: theme.primaryColor,
                                    ),
                                  ),
                                )
                              : PayCustomerDetails(
                                  custWidth: Screens.width(context) * 0.48,
                                  custHeight:
                                      Screens.bodyheight(context) * 0.32,
                                  theme: theme,
                                ),
                          //         ItemDetails(
                          //           itemHeight: Screens.bodyheight(context) * 0.08,
                          //           itemWidth: Screens.width(context) * 0.48,
                          //           prdPmt: prdSCD,
                          //           theme: theme,
                          //         ),
                          context
                                          .watch<PayreceiptController>()
                                          .getselectedcust2 !=
                                      null ||
                                  context
                                      .watch<PayreceiptController>()
                                      .getScanneditemData2
                                      .isNotEmpty
                              ? Container()
                              : PayTypeBtns(
                                  cashWidth: Screens.width(context) * 0.48,
                                  cashHeight:
                                      Screens.bodyheight(context) * 0.16,
                                  theme: theme,
                                ),
                          PayBtmBtn(
                              theme: theme,
                              btnheight: Screens.bodyheight(context) * 0.3,
                              btnWidth: Screens.width(context) * 0.48)
                        ],
                      )),
                ],
              )),
          Visibility(
            visible: context.watch<PayreceiptController>().ondDisablebutton,
            child: Container(
              width: Screens.width(context),
              height: Screens.bodyheight(context) * 0.95,
              color: Colors.white60,
              child: Center(
                child: SpinKitFadingCircle(
                  size: Screens.bodyheight(context) * 0.08,
                  color: theme.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
