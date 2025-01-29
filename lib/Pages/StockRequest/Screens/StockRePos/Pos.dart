import 'package:flutter/material.dart';
import 'package:posproject/Controller/StockRequestController/StockRequestController.dart';
import 'package:posproject/Pages/StockRequest/Widget/BillingOptions.dart';

import '../../../../Constant/Screen.dart';
import '../../../Sales Screen/Widgets/QuickOptions.dart';

class StockReqPos extends StatelessWidget {
  StockReqPos({super.key, required this.theme, required this.prdSCD});

  final ThemeData theme;
  StockReqController prdSCD;

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
              // Container(
              //   child: RequestItem(
              //     searchHeight: Screens.padingHeight(context) * 0.92,
              //     searchWidth: Screens.width(context) * 0.48,
              //     theme: theme,
              //     prdsrch: prdSCD,
              //   ),
              // ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // StockReqCustomer(
                      //   custWidth: Screens.width(context) * 0.4,
                      //   custHeight: Screens.padingHeight(context) * 0.8,
                      //   theme: theme,
                      //   SR_Con: prdSCD,
                      // ),
                      // SizedBox(
                      //   height: Screens.padingHeight(context) * 0.05,
                      // ),
                      // ItemDetails(
                      //   itemHeight: Screens.padingHeight(context) * 0.07,
                      //   itemWidth: Screens.width(context) * 0.4,
                      //   theme: theme,
                      //   prdPmt: prdSCD,
                      // ),
                      // SizedBox(
                      //   height: Screens.padingHeight(context) * 0.05,
                      // ),
                      // LoadButtons(
                      //   SRCon:prdSCD ,
                      //   loadheight: Screens.padingHeight(context) * 0.14,
                      //   loadWidth: Screens.width(context) * 0.4,
                      // ),
                    ],
                  ),
                  // StockReqBottomBtn(
                  //   theme: theme,
                  //   btnheight: Screens.padingHeight(context) * 0.1,
                  //   btnWidth: Screens.width(context) * 0.4,
                  //   SR_Con: prdSCD,
                  // )
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    ReqBillingOptions(theme: theme, posController: prdSCD),
                    const QuickOptions()
                  ],
                ),
              ),
            ]));
  }
}
