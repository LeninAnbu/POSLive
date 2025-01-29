import 'package:flutter/material.dart';

import '../../../../../Controller/StockListsController/StockListsController.dart';
import '../Widget/MobStockList.dart';

class StockMobScreens extends StatelessWidget {
  StockMobScreens({super.key, required this.stkCtrl});
  StockController stkCtrl;
  @override
  Widget build(BuildContext context) {
    return MobStockList(stkCtrl: stkCtrl);
  }
}
