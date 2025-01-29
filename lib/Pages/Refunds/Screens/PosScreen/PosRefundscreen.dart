// import 'package:flutter/material.dart';
// class StockReqPos extends StatelessWidget {
//   const StockReqPos({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
import 'package:flutter/material.dart';
import 'package:posproject/Pages/Refunds/widgets/RefundInventoriesList.dart';
import 'package:posproject/Pages/Refunds/widgets/RefundBtmBtn.dart';
import '../../../../Constant/Screen.dart';
import '../../../Sales Screen/Widgets/QuickOptions.dart';
import '../../widgets/RefundBillingOption.dart';
import '../../widgets/RefundTypeBtns.dart';
import '../../widgets/Refundmethod.dart';
import '../../widgets/RefundCustomerdetails.dart';

class RefundScreen extends StatelessWidget {
  const RefundScreen({
    super.key,
    required this.theme,
  });

  final ThemeData theme;
  // PayreceiptController prdSCD;

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
                  RefundInventoriesList(
                    searchHeight: Screens.padingHeight(context) * 0.8,
                    searchWidth: Screens.width(context) * 0.48,
                    theme: theme,
                    // prdsrch: prdSCD,
                  ),
                  RefundPayDetails(
                    theme: theme,
                    // prdPmt: prdSCD,
                    paymentWidth: Screens.width(context) * 0.48,
                    paymentHeight: Screens.padingHeight(context) * 0.12,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RefundCustomerDetails(
                    custWidth: Screens.width(context) * 0.39,
                    custHeight: Screens.padingHeight(context) * 0.8,
                    theme: theme,
                    // prdCD: prdSCD,
                  ),
                  RefundModeTypeBtns(
                    cashWidth: Screens.width(context) * 0.39,
                    cashHeight: Screens.padingHeight(context) * 0.2,
                    theme: theme,
                    // payController: prdSCD,
                  ),
                  RefundBtmBtn(
                    theme: theme,
                    btnheight: Screens.padingHeight(context) * 0.38,
                    btnWidth: Screens.width(context) * 0.39,
                    // payController: prdSCD,
                  )
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    RefundBillingOptions(
                      theme: theme,
                    ),
                    const QuickOptions(),
                  ],
                ),
              )
            ]));
  }
}
