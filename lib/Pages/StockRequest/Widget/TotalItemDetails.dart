import 'package:flutter/material.dart';
import 'package:posproject/Controller/StockRequestController/StockRequestController.dart';
import 'package:provider/provider.dart';

class ItemDetails extends StatelessWidget {
  ItemDetails(
      {super.key,
      required this.itemHeight,
      required this.itemWidth,
      required this.theme});
  double itemHeight;
  double itemWidth;
  final ThemeData theme;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: itemHeight,
      width: itemWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color:
            context.watch<StockReqController>().getScanneditemData2.isNotEmpty
                ? Colors.grey[300]
                : Colors.white,
      ),
      padding: EdgeInsets.only(
        top: itemHeight * 0.03,
        left: itemHeight * 0.03,
        right: itemHeight * 0.03,
        bottom: itemHeight * 0.01,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(itemHeight * 0.06),
            width: itemWidth * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(itemHeight * 0.06),
                      width: itemWidth * 0.19,
                      child: Text(
                        "Total Items",
                        style: theme.textTheme.bodyLarge?.copyWith(),
                      ),
                    ),
                    Container(
                      width: itemWidth * 0.19,
                      alignment: Alignment.centerRight,
                      child: context
                              .watch<StockReqController>()
                              .getScanneditemData2
                              .isNotEmpty
                          ? Text(
                              context
                                  .watch<StockReqController>()
                                  .getScanneditemData2
                                  .length
                                  .toStringAsFixed(0),
                              style: theme.textTheme.bodyLarge)
                          : context.watch<StockReqController>().calCulteStReq ==
                                  null
                              ? const Text(
                                  "0",
                                )
                              : Text(
                                  context
                                      .watch<StockReqController>()
                                      .getScanneditemData
                                      .length
                                      .toStringAsFixed(0),
                                  style: theme.textTheme.bodyLarge),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(itemHeight * 0.02),
                      width: itemWidth * 0.19,
                      child: Text(
                        "Quantity",
                        style: theme.textTheme.bodyLarge?.copyWith(),
                      ),
                    ),
                    Container(
                      width: itemWidth * 0.19,
                      alignment: Alignment.centerRight,
                      child: context
                              .watch<StockReqController>()
                              .getScanneditemData2
                              .isNotEmpty
                          ? Text(
                              context
                                  .watch<StockReqController>()
                                  .getNoOfQty2()
                                  .toStringAsFixed(0),
                              style: theme.textTheme.bodyLarge?.copyWith(),
                            )
                          : context.watch<StockReqController>().calCulteStReq ==
                                  null
                              ? const Text(
                                  "0",
                                )
                              : Text(
                                  context
                                      .read<StockReqController>()
                                      .getNoOfQty()
                                      .toStringAsFixed(0),
                                  style: theme.textTheme.bodyLarge?.copyWith(),
                                ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(itemHeight * 0.02),
            width: itemWidth * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: itemWidth * 0.19,
                        child: Text(
                          'Total Weight',
                          style: theme.textTheme.bodyLarge?.copyWith(),
                        )),
                    Container(
                      padding: EdgeInsets.all(itemHeight * 0.06),
                      alignment: Alignment.centerRight,
                      width: itemWidth * 0.19,
                      child: context
                                  .watch<StockReqController>()
                                  .scanneditemData2
                                  .isNotEmpty &&
                              context.watch<StockReqController>().totwieght !=
                                  null
                          ? Text(
                              "${context.watch<StockReqController>().totwieght!.toStringAsFixed(2)}kg",
                              style: theme.textTheme.bodyLarge)
                          : context.watch<StockReqController>().calCulteStReq ==
                                  null
                              ? Text(".00 kg", style: theme.textTheme.bodyLarge)
                              : Text(
                                  "${context.read<StockReqController>().totalWeight().toStringAsFixed(2)}kg",
                                  style: theme.textTheme.bodyLarge),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: itemWidth * 0.19,
                        child: Text(
                          'Total Ltr',
                          style: theme.textTheme.bodyLarge?.copyWith(),
                        )),
                    Container(
                      padding: EdgeInsets.all(itemHeight * 0.02),
                      alignment: Alignment.centerRight,
                      width: itemWidth * 0.19,
                      child: context
                                  .watch<StockReqController>()
                                  .scanneditemData2
                                  .isNotEmpty &&
                              context.watch<StockReqController>().totLiter !=
                                  null
                          ? Text(
                              context
                                  .watch<StockReqController>()
                                  .totLiter!
                                  .toStringAsFixed(2),
                              style: theme.textTheme.bodyLarge?.copyWith(),
                            )
                          : context.watch<StockReqController>().calCulteStReq ==
                                  null
                              ? const Text(
                                  ".00 ltr",
                                )
                              : Text(
                                  context
                                      .read<StockReqController>()
                                      .totalLiter()
                                      .toStringAsFixed(2),
                                  style: theme.textTheme.bodyLarge?.copyWith(),
                                ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
