import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../Constant/Screen.dart';
import '../../../Controller/StockInwardController/StockInwardContler.dart';
import '../../../Models/DataModel/StockInwardModel/StockInwardListModel.dart';

class StockInwardPageviewerLeft extends StatelessWidget {
  StockInwardPageviewerLeft(
      {super.key,
      required this.theme,
      required this.stockInWidth,
      required this.stockInheight,
      required this.index,
      required this.data,
      required this.datatotal});
  ThemeData theme;
  double stockInheight;
  double stockInWidth;
  int index;
  List<StockInwardDetails>? data;
  List<StockInwardList>? datatotal;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: stockInWidth,
          height: stockInheight * 1.08,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: stockInheight * 0.01,
                  left: stockInheight * 0.01,
                  right: stockInheight * 0.01,
                  bottom: stockInheight * 0.01,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                  color: theme.primaryColor,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: stockInWidth * 0.5,
                          child: Text(
                            'Item Name',
                            style: theme.textTheme.bodyLarge!
                                .copyWith(color: Colors.white),
                          )),
                      Container(
                          alignment: Alignment.center,
                          width: stockInWidth * 0.15,
                          child: Text(
                            'Requested Quantity',
                            style: theme.textTheme.bodyLarge!
                                .copyWith(color: Colors.white),
                          )),
                      Container(
                          alignment: Alignment.center,
                          width: stockInWidth * 0.15,
                          child: Text(
                            'Transfered Quantity',
                            style: theme.textTheme.bodyLarge!
                                .copyWith(color: Colors.white),
                          )),
                      Container(
                          alignment: Alignment.center,
                          width: stockInWidth * 0.15,
                          child: Text(
                            'Scanned Quantity',
                            style: theme.textTheme.bodyLarge!
                                .copyWith(color: Colors.white),
                          ))
                    ]),
              ),
              Card(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: stockInWidth,
                    padding: EdgeInsets.only(
                      top: stockInheight * 0.01,
                      left: stockInheight * 0.01,
                      right: stockInheight * 0.01,
                      bottom: stockInheight * 0.01,
                    ),
                    decoration: BoxDecoration(
                        color: data != null &&
                                data![context.watch<StockInwrdController>().selectIndex2]
                                        .Scanned_Qty !=
                                    0 &&
                                data![context.watch<StockInwrdController>().selectIndex2].qty !=
                                    (data![context.watch<StockInwrdController>().selectIndex2]
                                            .Scanned_Qty! +
                                        data![context.watch<StockInwrdController>().selectIndex2]
                                            .trans_Qty!)
                            ? const Color(0xFFfcedee)
                            : data![context.watch<StockInwrdController>().selectIndex2].Scanned_Qty != 0 &&
                                    data![context.watch<StockInwrdController>().selectIndex2].qty ==
                                        (data![context.watch<StockInwrdController>().selectIndex2]
                                                .Scanned_Qty! +
                                            data![context.watch<StockInwrdController>().selectIndex2]
                                                .trans_Qty!)
                                ? const Color(0xFFebfaef)
                                : data![context.watch<StockInwrdController>().selectIndex2].Scanned_Qty == 0 &&
                                        data![context.watch<StockInwrdController>().selectIndex2].qty !=
                                            (data![context.watch<StockInwrdController>().selectIndex2]
                                                    .Scanned_Qty! +
                                                data![context.watch<StockInwrdController>().selectIndex2]
                                                    .trans_Qty!)
                                    ? Colors.grey.withOpacity(0.04)
                                    : Colors.grey.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.green)),
                    child: IntrinsicHeight(
                      child:
                          //  Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          SizedBox(
                        width: stockInWidth * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            data == null
                                ? const Text("")
                                : Row(
                                    children: [
                                      Text(
                                        "${data![context.watch<StockInwrdController>().selectIndex2].itemcode}",
                                        style: theme.textTheme.bodyLarge,
                                      ),
                                      Text(
                                        " - ${data![context.watch<StockInwrdController>().selectIndex2].dscription}",
                                        style: theme.textTheme.bodyLarge,
                                      ),
                                    ],
                                  ),
                            data == null
                                ? const Text("")
                                : Row(
                                    children: [
                                      Container(
                                        width: stockInWidth * 0.5,
                                        child: Wrap(
                                            spacing: 10.0,
                                            runSpacing: 10.0,
                                            children: listContainersBatch(
                                              context,
                                              theme,
                                              data![context
                                                  .watch<StockInwrdController>()
                                                  .selectIndex2],
                                            )),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: stockInWidth * 0.15,
                                        child: data == null
                                            ? const Text("")
                                            : Text(
                                                "${data![context.watch<StockInwrdController>().selectIndex2].qty}",
                                                style:
                                                    theme.textTheme.bodyLarge,
                                              ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: stockInWidth * 0.15,
                                        child: data == null
                                            ? const Text("")
                                            : Text(
                                                "${data![context.watch<StockInwrdController>().selectIndex2].trans_Qty}",
                                                style:
                                                    theme.textTheme.bodyLarge,
                                              ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: stockInWidth * 0.15,
                                        child: data == null
                                            ? const Text("")
                                            : Text(
                                                "${data![context.watch<StockInwrdController>().selectIndex2].Scanned_Qty}",
                                                style:
                                                    theme.textTheme.bodyLarge,
                                              ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                      // ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: stockInheight * 0.008,
        ),
      ],
    );
  }

  forSuspend(BuildContext context, ThemeData theme) {
    return Get.defaultDialog(
        title: "Alert",
        middleText: "You about to suspended all information will be unsaved",
        backgroundColor: Colors.white,
        titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
        middleTextStyle: theme.textTheme.bodyLarge,
        radius: 0,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    context.read<StockInwrdController>().suspendedbutton(
                        index, context, theme, data, datatotal![index]);
                  },
                  child: Container(
                    width: Screens.width(context) * 0.1,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(
                          color: theme.primaryColor,
                        )),
                    height: Screens.bodyheight(context) * 0.05,
                    child: Text("Yes",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        )),
                  )),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: Screens.width(context) * 0.1,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: theme.primaryColor,
                        border: Border.all(
                          color: theme.primaryColor,
                        )),
                    height: Screens.bodyheight(context) * 0.05,
                    child: Text("No",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        )),
                  )),
            ],
          ),
        ]);
  }

  List<Widget> listContainersBatch(
      BuildContext context, ThemeData theme, StockInwardDetails data) {
    return List.generate(
      data.StOutSerialbatchList!.length,
      (ind) {
        return Container(
          padding: EdgeInsets.all(Screens.width(context) * 0.002),
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(3)),
          child: Text(
              "${data.StOutSerialbatchList![ind].serialbatch} / ${data.StOutSerialbatchList![ind].qty} "),
        );
      },
    );
  }
}
