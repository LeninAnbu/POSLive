import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../Constant/Screen.dart';
import '../../../Controller/StockOutwardController/StockOutwardController.dart';
import '../../../Models/DataModel/StockOutwardModel/StockOutwardListModel.dart';
import '../../SalesQuotation/Widgets/ItemLists.dart';

class StockOutwardPageviewerLeft extends StatefulWidget {
  StockOutwardPageviewerLeft(
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
  List<StockOutwardDetails>? data;
  List<StockOutwardList>? datatotal;

  @override
  State<StockOutwardPageviewerLeft> createState() =>
      _StockOutwardPageviewerLeftState();
}

class _StockOutwardPageviewerLeftState
    extends State<StockOutwardPageviewerLeft> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: widget.stockInWidth,
          height: widget.stockInheight * 1.08,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: widget.stockInheight * 0.01,
                  left: widget.stockInWidth * 0.01,
                  right: widget.stockInWidth * 0.01,
                  bottom: widget.stockInheight * 0.01,
                ),
                decoration: BoxDecoration(
                    color: widget.theme.primaryColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5))),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          // color: Colors.red,
                          width: widget.stockInWidth * 0.45,
                          child: Text(
                            'Item Name',
                            style: widget.theme.textTheme.bodyLarge!
                                .copyWith(color: Colors.white),
                          )),
                      Container(
                          // color: Colors.green,
                          width: widget.stockInWidth * 0.1,
                          child: Text(
                            'In Stock',
                            style: widget.theme.textTheme.bodyLarge!
                                .copyWith(color: Colors.white),
                          )),
                      Container(
                          // color: Colors.green,
                          alignment: Alignment.center,
                          width: widget.stockInWidth * 0.14,
                          child: Text(
                            'Requested Quantity',
                            style: widget.theme.textTheme.bodyLarge!
                                .copyWith(color: Colors.white),
                          )),
                      Container(
                          // color: Colors.red,
                          alignment: Alignment.center,
                          width: widget.stockInWidth * 0.14,
                          child: Text(
                            'Transfered Quantity',
                            style: widget.theme.textTheme.bodyLarge!
                                .copyWith(color: Colors.white),
                          )),
                      Container(
                          alignment: Alignment.centerRight,
                          width: widget.stockInWidth * 0.13,
                          child: Text(
                            'Scanned Quantity',
                            style: widget.theme.textTheme.bodyLarge!
                                .copyWith(color: Colors.white),
                          ))
                    ]),
              ),
              widget.data!.isEmpty
                  ? const Text("No data..!!")
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(' Select All '),
                            Checkbox(
                                value: context
                                    .read<StockOutwardController>()
                                    .selectAll,
                                side: const BorderSide(color: Colors.grey),
                                activeColor: Colors.green,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      context
                                          .read<StockOutwardController>()
                                          .selectAll = value!;

                                      context
                                          .read<StockOutwardController>()
                                          .selectAllItem();
                                      log('selectAllselectAllselectAll::${context.read<StockOutwardController>().selectAll}');
                                    },
                                  );
                                }),
                          ],
                        ),
                        Container(
                          // color: Colors.yellow,
                          height: widget.stockInheight * 0.87,
                          child: ListView.builder(
                              itemCount: context
                                  .watch<StockOutwardController>()
                                  .passdata!
                                  .length,
                              itemBuilder: (context, indx) {
                                // log(' context.watch<StockOutwardController>().passdata![indx].dscription::${context.watch<StockOutwardController>().passdata![indx].dscription}');
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      context
                                              .read<StockOutwardController>()
                                              .selectItemIndex ==
                                          null;
                                      context
                                          .read<StockOutwardController>()
                                          .selectAll = false;
                                      context
                                          .read<StockOutwardController>()
                                          .selectItemIndex = indx;

                                      context
                                              .read<StockOutwardController>()
                                              .itemCode =
                                          context
                                              .read<StockOutwardController>()
                                              .passdata![indx]
                                              .itemcode
                                              .toString();
                                      context
                                          .read<StockOutwardController>()
                                          .selectSameItemCode(indx);

                                      log(' context .read<StockOutwardController>() .selectItemIndex ::${context.read<StockOutwardController>().selectItemIndex}');
                                    });
                                  },
                                  child: Card(
                                    child: Container(
                                      // height: stockInheight * 0.11,
                                      width: widget.stockInWidth,
                                      padding: EdgeInsets.only(
                                        top: widget.stockInheight * 0.01,
                                        left: widget.stockInWidth * 0.01,
                                        right: widget.stockInWidth * 0.01,
                                        bottom: widget.stockInheight * 0.01,
                                      ),
                                      decoration: BoxDecoration(
                                          color: context
                                                      .watch<
                                                          StockOutwardController>()
                                                      .passdata![indx]
                                                      .listClr ==
                                                  true
                                              ? const Color(0xFFfcedee)
                                              : Colors.grey.withOpacity(0.04),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.green)),
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: widget.stockInWidth * 0.43,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  context
                                                              .read<
                                                                  StockOutwardController>()
                                                              .passdata ==
                                                          null
                                                      ? const Text("")
                                                      : Container(
                                                          child: Text(
                                                            "${context.read<StockOutwardController>().passdata![indx].itemcode}",
                                                            style: widget
                                                                .theme
                                                                .textTheme
                                                                .bodyLarge,
                                                          ),
                                                        ),
                                                  Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      // color: Colors.red,
                                                      child: context
                                                                  .read<
                                                                      StockOutwardController>()
                                                                  .passdata ==
                                                              null
                                                          ? const Text(" ")
                                                          : Text(
                                                              " ${context.watch<StockOutwardController>().passdata![indx].dscription} ",
                                                              style: widget
                                                                  .theme
                                                                  .textTheme
                                                                  .bodySmall,
                                                              maxLines: 2,
                                                            ))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              width: widget.stockInWidth * 0.1,
                                              child: context
                                                          .read<
                                                              StockOutwardController>()
                                                          .passdata ==
                                                      null
                                                  ? const Text("")
                                                  : Text(
                                                      "${context.read<StockOutwardController>().passdata![indx].stock}",
                                                      style: widget.theme
                                                          .textTheme.bodyLarge,
                                                    ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              width: widget.stockInWidth * 0.12,
                                              child: context
                                                          .read<
                                                              StockOutwardController>()
                                                          .passdata ==
                                                      null
                                                  ? const Text("")
                                                  : Text(
                                                      "${context.read<StockOutwardController>().passdata![indx].qty}",
                                                      style: widget.theme
                                                          .textTheme.bodyLarge,
                                                    ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              width: widget.stockInWidth * 0.14,
                                              child: context
                                                          .read<
                                                              StockOutwardController>()
                                                          .passdata ==
                                                      null
                                                  ? const Text("")
                                                  : Text(
                                                      "${context.read<StockOutwardController>().passdata![indx].trans_Qty}",
                                                      style: widget.theme
                                                          .textTheme.bodyLarge,
                                                    ),
                                            ),
                                            Container(
                                                width:
                                                    widget.stockInWidth * 0.13,
                                                height:
                                                    widget.stockInheight * 0.07,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        widget.stockInWidth *
                                                            0.005),
                                                child: TextFormField(
                                                  textAlign: TextAlign.right,
                                                  onTap: () {
                                                    context
                                                            .read<
                                                                StockOutwardController>()
                                                            .qtymycontroller[indx]
                                                            .text =
                                                        context
                                                            .read<
                                                                StockOutwardController>()
                                                            .qtymycontroller[
                                                                indx]
                                                            .text;
                                                    context
                                                        .read<
                                                            StockOutwardController>()
                                                        .qtymycontroller[indx]
                                                        .selection = TextSelection(
                                                      baseOffset: 0,
                                                      extentOffset: context
                                                          .read<
                                                              StockOutwardController>()
                                                          .qtymycontroller[indx]
                                                          .text
                                                          .length,
                                                    );
                                                  },
                                                  style: widget.theme.textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                          color: Colors.black),
                                                  cursorColor: Colors.grey,
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onChanged: (val) {
                                                    context
                                                        .read<
                                                            StockOutwardController>()
                                                        .doubleDotMethod(
                                                            indx, val);
                                                  },
                                                  inputFormatters: [
                                                    DecimalInputFormatter()
                                                  ],
                                                  // inputFormatters: [
                                                  //   FilteringTextInputFormatter
                                                  //       .digitsOnly
                                                  // ],
                                                  onEditingComplete: () {
                                                    // setState(() {
                                                    // context.read<StockOutwardController>().stkOutEditQty(
                                                    //     context
                                                    //         .read<
                                                    //             StockOutwardController>()
                                                    //         .get_i_value,
                                                    //     context
                                                    //         .read<
                                                    //             StockOutwardController>()
                                                    //         .StockOutward[context
                                                    //             .read<
                                                    //                 StockOutwardController>()
                                                    //             .get_i_value]
                                                    //         .data[context
                                                    //             .read<
                                                    //                 StockOutwardController>()
                                                    //             .batch_i!]
                                                    //         .serialbatchList![
                                                    //             i]
                                                    //         .serialbatch!,
                                                    //     context
                                                    //         .read<
                                                    //             StockOutwardController>()
                                                    //         .batch_i!,
                                                    //     context
                                                    //         .read<
                                                    //             StockOutwardController>()
                                                    //         .StockOutward[context
                                                    //             .read<
                                                    //                 StockOutwardController>()
                                                    //             .get_i_value]
                                                    //         .data[context
                                                    //             .read<
                                                    //                 StockOutwardController>()
                                                    //             .batch_i!]
                                                    //         .itemcode!,
                                                    //     i);
                                                    // });

                                                    context
                                                        .read<
                                                            StockOutwardController>()
                                                        .disableKeyBoard(
                                                            context);
                                                  },
                                                  controller: context
                                                      .read<
                                                          StockOutwardController>()
                                                      .qtymycontroller[indx],
                                                  decoration: InputDecoration(
                                                    filled: false,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.grey),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.grey),
                                                    ),
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                      vertical: 0,
                                                      horizontal: 5,
                                                    ),
                                                  ),
                                                )),
                                            // Container(
                                            //   // color: Colors.green,
                                            //   alignment: Alignment.centerRight,
                                            //   width: widget.stockInWidth * 0.13,
                                            //   child: widget.data == null
                                            //       ? const Text("")
                                            //       : Text(
                                            //           "${widget.data![indx].Scanned_Qty}",
                                            //           style: widget.theme
                                            //               .textTheme.bodyLarge,
                                            //         ),
                                            // ),
                                          ]),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    )
            ],
          ),
        ),
        SizedBox(
          height: widget.stockInheight * 0.008,
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
                    context.read<StockOutwardController>().suspendedbutton(
                        widget.index,
                        context,
                        theme,
                        widget.data,
                        widget.datatotal![widget.index]);
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
}
