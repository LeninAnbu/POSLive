import 'package:flutter/material.dart';
import 'package:posproject/Pages/StocksCheck/Widget/Search.dart';

import '../../../../Constant/Screen.dart';

class TabStockCheckScreen extends StatefulWidget {
  const TabStockCheckScreen({
    super.key,
  });

  @override
  State<TabStockCheckScreen> createState() => _TabStockCheckScreenState();
}

class _TabStockCheckScreenState extends State<TabStockCheckScreen> {
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Search_Widget(
                searchHeight: Screens.bodyheight(context),
                searchWidth: Screens.width(context))
          ],
        ),
      ),
    );
  }
}
