import 'package:flutter/material.dart';

import '../../../../Constant/Screen.dart';
import '../../../../Controller/DashBoardController/DashboardController.dart';
import '../../../Sales Screen/Widgets/QuickOptions.dart';

class PosDashScreen extends StatelessWidget {
  PosDashScreen({super.key, required this.prdDBC, required this.theme});
  DashBoardController prdDBC;
  ThemeData theme;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey.withOpacity(0.05),
        padding: EdgeInsets.only(
          top: Screens.padingHeight(context) * 0.01,
          left: Screens.width(context) * 0.01,
          right: Screens.width(context) * 0.01,
          bottom: Screens.padingHeight(context) * 0.01,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // UserLoginDetail(
                //   prdDBC: prdDBC,
                //   theme: theme,
                //   userWidth: Screens.width(context) * 0.47,
                //   userheight: Screens.padingHeight(context) * 0.03,
                // ),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.01,
                ),
                // salesDetails(
                //   prdDBC: prdDBC,
                //   theme: theme,
                //   salesWidth: Screens.width(context) * 0.47,
                //   salesheight: Screens.padingHeight(context) * 0.4,
                // ),
                SizedBox(height: Screens.padingHeight(context) * 0.015),
                // Announcement(
                //   prdDBC: prdDBC,
                //   theme: theme,
                //   dbHeight: Screens.padingHeight(context) * 0.35,
                //   dbWidth: Screens.width(context) * 0.47,
                // )
              ],
            ),
            Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // StockTable(
                //   prdDBC: prdDBC,
                //   theme: theme,
                //   dbHeight: Screens.padingHeight(context) * 0.39,
                //   dbWidth: Screens.width(context) * 0.39,
                // ),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.015,
                ),
                // SizedBox(height: Screens.padingHeight(context) * 0.02),
                // Transaction(
                //   prdDBC: prdDBC,
                //   theme: theme,
                //   dbHeight: Screens.padingHeight(context) * 0.45,
                //   dbWidth: Screens.width(context) * 0.39,
                // )
              ],
            ),
            const SingleChildScrollView(child: QuickOptions())
          ],
        ));
  }
}
