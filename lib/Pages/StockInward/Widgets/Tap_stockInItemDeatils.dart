import 'package:flutter/material.dart';
import 'package:posproject/Pages/StockInward/Widgets/TapStockInItemList.dart';
import 'package:provider/provider.dart';
import '../../../../Constant/Screen.dart';

import '../../../../../Controller/StockInwardController/StockInwardContler.dart';
import 'StockInScanPage.dart';

class StockInTabPageviewerSecond extends StatefulWidget {
  const StockInTabPageviewerSecond({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  State<StockInTabPageviewerSecond> createState() =>
      _StockInTabPageviewerSecondState();
}

class _StockInTabPageviewerSecondState
    extends State<StockInTabPageviewerSecond> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey.withOpacity(0.05),
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
            StockInwardPageviewerLeft(
              theme: widget.theme,
              stockInWidth: Screens.width(context) * 0.48,
              stockInheight: Screens.bodyheight(context) * 0.9002,
              index: context.watch<StockInwrdController>().get_i_value,
              data: context.watch<StockInwrdController>().passdata,
              datatotal: context.watch<StockInwrdController>().stockInward,
            ),
            SizedBox(
                width: Screens.width(context) * 0.48,
                child: StockInscanPage(
                  searchHeight: Screens.bodyheight(context) * 0.78,
                  searchWidth: Screens.width(context) * 0.5,
                  index: context.watch<StockInwrdController>().get_i_value,
                  ind: context.watch<StockInwrdController>().batch_i,
                  theme: widget.theme,
                  datalist:
                      context.watch<StockInwrdController>().batch_datalist,
                )),
          ],
        ));
  }
}
