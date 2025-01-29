import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Constant/Screen.dart';
import '../../../../Controller/StockOutwardController/StockOutwardController.dart';
import 'StockOutScanPage.dart';
import 'TapStockOutItemList.dart';

class StockOutTabPageviewerSecond extends StatefulWidget {
  const StockOutTabPageviewerSecond({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  State<StockOutTabPageviewerSecond> createState() =>
      _StockOutTabPageviewerSecondState();
}

class _StockOutTabPageviewerSecondState
    extends State<StockOutTabPageviewerSecond> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey.withOpacity(0.05),
        padding: EdgeInsets.only(
          top: Screens.bodyheight(context) * 0.02,
          left: Screens.width(context) * 0.01,
          right: Screens.width(context) * 0.01,
          bottom: Screens.bodyheight(context) * 0.01,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StockOutwardPageviewerLeft(
                theme: widget.theme,
                stockInWidth: Screens.width(context) * 0.5,
                stockInheight: Screens.bodyheight(context) * 0.9002,
                index: context.watch<StockOutwardController>().get_i_value,
                data: context.watch<StockOutwardController>().passdata,
                datatotal:
                    context.watch<StockOutwardController>().StockOutward),
            SizedBox(
                width: Screens.width(context) * 0.48,
                child: StockOutscanPage(
                  searchHeight: Screens.bodyheight(context) * 0.782,
                  searchWidth: Screens.width(context) * 0.6,
                  index: context.watch<StockOutwardController>().get_i_value,
                  theme: widget.theme,
                  datalist:
                      context.watch<StockOutwardController>().batch_datalist,
                )),
          ],
        ));
  }
}
