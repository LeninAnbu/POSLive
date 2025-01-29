import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Controller/StockListsController/StockListsController.dart';
import 'package:posproject/Pages/Stockslist/Widget/SearchList.dart';
import 'package:posproject/Pages/Stockslist/Widget/ViewAll.dart';

import '../../Widget/StockListScreen.dart';

class PosStockMainScreen extends StatelessWidget {
  PosStockMainScreen({super.key, required this.stkCtrl});
  StockController stkCtrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: Screens.padingHeight(context) * 0.03,
          bottom: Screens.padingHeight(context) * 0.02,
          left: Screens.width(context) * 0.01,
          right: Screens.width(context) * 0.01),
      color: Colors.grey.withOpacity(0.05),
      height: Screens.padingHeight(context) * 0.97,
      width: Screens.width(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              child: stkCtrl.viewAll == true
                  ? ViewAllDetails(
                      stkCtrl: stkCtrl,
                      stkHeight: Screens.padingHeight(context) * 0.96,
                      stkWidth: Screens.width(context) * 0.485,
                    )
                  : StockListScreen(
                      stkCtrl: stkCtrl,
                      stkHeight: Screens.padingHeight(context) * 0.96,
                      stkWidth: Screens.width(context) * 0.485,
                    )),
          SearchStockList(
            stkCtrl: stkCtrl,
            stkHeight: Screens.padingHeight(context) * 0.96,
            stkWidth: Screens.width(context) * 0.485,
          )
        ],
      ),
    );
  }
}
