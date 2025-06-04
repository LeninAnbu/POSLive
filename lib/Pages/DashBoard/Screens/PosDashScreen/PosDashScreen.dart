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
                SizedBox(
                  height: Screens.padingHeight(context) * 0.01,
                ),
                SizedBox(height: Screens.padingHeight(context) * 0.015),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: Screens.padingHeight(context) * 0.015,
                ),
              ],
            ),
            const SingleChildScrollView(child: QuickOptions())
          ],
        ));
  }
}
