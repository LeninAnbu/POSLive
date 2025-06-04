import 'package:flutter/material.dart';

import '../../../../../Constant/Screen.dart';
import '../../../../../Controller/CustomerController/CustomerController.dart';
import '../Widget/MobCustomerdetailPage.dart';
import '../Widget/MobSearchwidget.dart';

class MobCustomerScreens extends StatelessWidget {
  MobCustomerScreens({super.key, required this.stkCtrl});
  CustomerController stkCtrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.withOpacity(0.05),
      ),
      padding: EdgeInsets.only(
          top: Screens.bodyheight(context) * 0.01,
          bottom: Screens.bodyheight(context) * 0.01,
          left: Screens.width(context) * 0.01,
          right: Screens.width(context) * 0.01),
      width: Screens.width(context),
      height: Screens.bodyheight(context) * 0.95,
      child: PageView(
        scrollDirection: Axis.horizontal,
        pageSnapping: true,
        controller: stkCtrl.tappage,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MobSearchWidget(
                    stChCon: stkCtrl,
                    searchHeight: Screens.bodyheight(context),
                    searchWidth: Screens.width(context)),
              ],
            ),
          ),
          MobCustomerdetailPage(
            stChCon: stkCtrl,
            searchHeight: Screens.bodyheight(context),
            searchWidth: Screens.width(context),
            cusList: stkCtrl.cusList1,
          )
        ],
      ),
    );
  }
}
