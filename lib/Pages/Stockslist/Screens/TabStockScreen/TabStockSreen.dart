import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Controller/StockListsController/StockListsController.dart';
import 'package:posproject/Pages/Stockslist/Widget/StockListScreen.dart';
import 'package:provider/provider.dart';

import '../../Widget/SearchList.dart';
import '../../Widget/ViewAll.dart';

class TabStockScreen extends StatefulWidget {
  const TabStockScreen({
    super.key,
  });

  @override
  State<TabStockScreen> createState() => _TabStockScreenState();
}

class _TabStockScreenState extends State<TabStockScreen> {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              child: context.watch<StockController>().viewAll.isNotEmpty
                  ? ViewAllDetails(
                      stkCtrl: context.read<StockController>(),
                      stkHeight: Screens.bodyheight(context) * 0.94,
                      stkWidth: Screens.width(context) * 0.485,
                    )
                  : StockListScreen(
                      stkCtrl: context.read<StockController>(),
                      stkHeight: Screens.bodyheight(context) * 0.96,
                      stkWidth: Screens.width(context) * 0.485,
                    )),
          SearchStockList(
            stkCtrl: context.read<StockController>(),
            stkHeight: Screens.bodyheight(context) * 0.94,
            stkWidth: Screens.width(context) * 0.485,
          )
        ],
      ),
    );
  }
}
