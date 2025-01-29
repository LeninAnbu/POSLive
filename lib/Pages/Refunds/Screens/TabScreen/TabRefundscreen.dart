import 'package:flutter/material.dart';
import '../../../../Constant/Screen.dart';
import '../../widgets/RefundInventoriesList.dart';
import '../../widgets/RefundBtmBtn.dart';
import '../../widgets/RefundTypeBtns.dart';
import '../../widgets/Refundmethod.dart';
import '../../widgets/RefundCustomerdetails.dart';

class RefundTabScreen extends StatelessWidget {
  const RefundTabScreen({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      RefundInventoriesList(
                        searchHeight: Screens.bodyheight(context) * 0.7,
                        searchWidth: Screens.width(context) * 0.48,
                        theme: theme,
                        // prdsrch: prdSCD,
                      ),
                      RefundPayDetails(
                        theme: theme,
                        // prdPmt: prdSCD,
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
                    RefundCustomerDetails(
                      custWidth: Screens.width(context) * 0.48,
                      custHeight: Screens.bodyheight(context) * 0.48,
                      theme: theme,
                      // prdCD: prdSCD,
                    ),
                    //         ItemDetails(
                    //           itemHeight: Screens.bodyheight(context) * 0.08,
                    //           itemWidth: Screens.width(context) * 0.48,
                    //           prdPmt: prdSCD,
                    //           theme: theme,
                    //         ),
                    RefundModeTypeBtns(
                      // payController: prdSCD,
                      cashWidth: Screens.width(context) * 0.48,
                      cashHeight: Screens.bodyheight(context) * 0.15,
                      theme: theme,
                    ),
                    RefundBtmBtn(
                      theme: theme,
                      btnheight: Screens.bodyheight(context) * 0.33,
                      btnWidth: Screens.width(context) * 0.48,
                      // payController: prdSCD,
                    )
                  ],
                )),
          ],
        ));
  }
}
