import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Controller/StockOutwardController/StockOutwardController.dart';
import '../../../Models/DataModel/StockOutwardModel/StockOutwardListModel.dart';
import '../../../Widgets/AlertBox.dart';
import '../../../Widgets/ContentContainer.dart';
import '../Widget/SearchSerialbatch.dart';

class StockOutscanPage extends StatefulWidget {
  StockOutscanPage(
      {super.key,
      required this.theme,
      required this.index,
      required this.searchHeight,
      required this.searchWidth,
      required this.datalist});

  final ThemeData theme;
  int? index;

  StockOutwardDetails? datalist;
  double searchHeight;
  double searchWidth;

  @override
  State<StockOutscanPage> createState() => _StockOutscanPageState();
}

class _StockOutscanPageState extends State<StockOutscanPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          top: widget.searchHeight * 0.01,
          left: widget.searchWidth * 0.01,
          right: widget.searchWidth * 0.01,
          bottom: widget.searchHeight * 0.01,
        ),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        width: widget.searchWidth * 1.5,
        child: SingleChildScrollView(
          controller: context.read<StockOutwardController>().scrollController,
          child: Column(
            children: [
              SizedBox(
                width: widget.searchWidth * 0.9,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: widget.searchHeight * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.3,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 207, 201, 201)),
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.grey.withOpacity(0.01),
                              ),
                              child: TextFormField(
                                style: widget.theme.textTheme.bodyMedium,
                                cursorColor: Colors.grey,
                                controller: context
                                    .read<StockOutwardController>()
                                    .searchcon,
                                onEditingComplete: context
                                            .read<StockOutwardController>()
                                            .OnScanDisable ==
                                        true
                                    ? null
                                    : () {
                                        if (context
                                            .read<StockOutwardController>()
                                            .searchcon
                                            .text
                                            .isNotEmpty) {
                                          context
                                              .read<StockOutwardController>()
                                              .getAllList(context
                                                  .read<
                                                      StockOutwardController>()
                                                  .searchcon
                                                  .text
                                                  .trim())
                                              .then((value) {
                                            if (value.length == 1) {
                                              context
                                                  .read<
                                                      StockOutwardController>()
                                                  .scanmethod(
                                                      widget.index!,
                                                      context
                                                          .read<
                                                              StockOutwardController>()
                                                          .searchcon
                                                          .text
                                                          .toString(),
                                                      context
                                                          .read<
                                                              StockOutwardController>()
                                                          .batch_i!,
                                                      value[0]
                                                          .itemcode
                                                          .toString());
                                              context
                                                  .read<
                                                      StockOutwardController>()
                                                  .OnScanDisable = false;
                                            } else if (1 < value.length) {
                                              showDialog<dynamic>(
                                                  context: context,
                                                  builder: (_) {
                                                    return SearchSearialBatch(
                                                      index: context
                                                          .read<
                                                              StockOutwardController>()
                                                          .get_i_value,
                                                      list_i: context
                                                          .read<
                                                              StockOutwardController>()
                                                          .batch_i!,
                                                    );
                                                  }).then((value) {
                                                context
                                                    .read<
                                                        StockOutwardController>()
                                                    .OnScanDisable = false;
                                              });
                                            } else {
                                              showDialog<dynamic>(
                                                  context: context,
                                                  builder: (_) {
                                                    return SearchSearialBatch(
                                                      index: context
                                                          .read<
                                                              StockOutwardController>()
                                                          .get_i_value,
                                                      list_i: context
                                                          .read<
                                                              StockOutwardController>()
                                                          .batch_i!,
                                                    );
                                                  });
                                              context
                                                  .read<
                                                      StockOutwardController>()
                                                  .OnScanDisable = false;
                                            }
                                          });
                                        } else {
                                          context
                                                  .read<StockOutwardController>()
                                                  .msg =
                                              "Please Enter SerialBatch..!!";
                                        }

                                        context
                                            .read<StockOutwardController>()
                                            .disableKeyBoard(context);
                                      },
                                onChanged: (v) {
                                  if (v.isNotEmpty) {
                                    context.read<StockOutwardController>().msg =
                                        "";
                                  }
                                },
                                decoration: InputDecoration(
                                  filled: false,
                                  hintText: 'Scan Here..',
                                  hintStyle: widget.theme.textTheme.bodyMedium
                                      ?.copyWith(),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 10,
                                  ),
                                ),
                              )),
                          Container(
                            width: widget.searchWidth * 0.15,
                            child: ElevatedButton(
                                onPressed: context
                                            .read<StockOutwardController>()
                                            .batchselectbtndisable ==
                                        true
                                    ? null
                                    : () async {
                                        context
                                            .read<StockOutwardController>()
                                            .batchselectbtndisable = true;

                                        if (context
                                            .read<StockOutwardController>()
                                            .selectAll) {
                                          context
                                              .read<StockOutwardController>()
                                              .callFetchFromPdaAllApi(
                                                  widget.index!,
                                                  context
                                                      .read<
                                                          StockOutwardController>()
                                                      .searchcon
                                                      .text
                                                      .toString(),
                                                  widget.theme,
                                                  context);
                                        } else if (context
                                                .read<StockOutwardController>()
                                                .selectItemIndex !=
                                            null) {
                                          await context
                                              .read<StockOutwardController>()
                                              .callFetchFromItemApi(
                                                  widget.index!,
                                                  context
                                                      .read<
                                                          StockOutwardController>()
                                                      .searchcon
                                                      .text
                                                      .toString(),
                                                  widget.theme,
                                                  context
                                                      .read<
                                                          StockOutwardController>()
                                                      .selectItemIndex!,
                                                  context);
                                        } else {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                    contentPadding:
                                                        const EdgeInsets.all(0),
                                                    content: AlertBox(
                                                      payMent: 'Alert',
                                                      errormsg: true,
                                                      widget: Center(
                                                          child:
                                                              ContentContainer(
                                                        content:
                                                            'Select Item List',
                                                        theme: widget.theme,
                                                      )),
                                                      buttonName: null,
                                                    ));
                                              });
                                        }
                                      },
                                child: Text('Fetch Batch From PDA')),
                          ),
                          ElevatedButton(
                              onPressed: context
                                          .read<StockOutwardController>()
                                          .autoselectbtndisable ==
                                      true
                                  ? null
                                  : () {
                                      if (context
                                              .read<StockOutwardController>()
                                              .selectAll ==
                                          true) {
                                        context
                                            .read<StockOutwardController>()
                                            .autoselectbtndisable = true;
                                        context
                                            .read<StockOutwardController>()
                                            .autoscanmethodAll(
                                              widget.index!,
                                              context
                                                  .read<
                                                      StockOutwardController>()
                                                  .searchcon
                                                  .text
                                                  .toString(),
                                            );
                                      } else if (context
                                              .read<StockOutwardController>()
                                              .selectItemIndex !=
                                          null) {
                                        context
                                            .read<StockOutwardController>()
                                            .autoscanmethodAll(
                                              widget.index!,
                                              context
                                                  .read<
                                                      StockOutwardController>()
                                                  .searchcon
                                                  .text
                                                  .toString(),
                                            );
                                      } else {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  contentPadding:
                                                      const EdgeInsets.all(0),
                                                  content: AlertBox(
                                                    payMent: 'Alert',
                                                    errormsg: true,
                                                    widget: Center(
                                                        child: ContentContainer(
                                                      content:
                                                          'Select Item List',
                                                      theme: widget.theme,
                                                    )),
                                                    buttonName: null,
                                                  ));
                                            });
                                      }
                                    },
                              child: Text('Auto Select')),
                          ElevatedButton(
                              onPressed: context
                                          .read<StockOutwardController>()
                                          .manualselectbtndisable ==
                                      true
                                  ? null
                                  : () {
                                      context
                                          .read<StockOutwardController>()
                                          .newadditemlistcount();
                                      if (context
                                              .read<StockOutwardController>()
                                              .addIndex
                                              .length ==
                                          1) {
                                        for (var i = 0;
                                            i <
                                                context
                                                    .read<
                                                        StockOutwardController>()
                                                    .passdata!
                                                    .length;
                                            i++) {
                                          if (context
                                                  .read<
                                                      StockOutwardController>()
                                                  .passdata![i]
                                                  .listClr ==
                                              true) {
                                            context
                                                .read<StockOutwardController>()
                                                .selectItemIndex = i;
                                          }
                                        }
                                        context
                                            .read<StockOutwardController>()
                                            .manualscanmethod(
                                                widget.index!,
                                                context
                                                    .read<
                                                        StockOutwardController>()
                                                    .searchcon
                                                    .text
                                                    .toString(),
                                                context
                                                    .read<
                                                        StockOutwardController>()
                                                    .selectItemIndex!,
                                                widget.theme,
                                                context);
                                      } else if (context
                                                  .read<
                                                      StockOutwardController>()
                                                  .addIndex
                                                  .length >
                                              1 ||
                                          context
                                                  .read<
                                                      StockOutwardController>()
                                                  .selectAll ==
                                              true) {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  contentPadding:
                                                      const EdgeInsets.all(0),
                                                  content: AlertBox(
                                                    payMent: 'Alert',
                                                    errormsg: true,
                                                    widget: Center(
                                                        child: ContentContainer(
                                                      content:
                                                          'Kindy select only one item',
                                                      theme: widget.theme,
                                                    )),
                                                    buttonName: null,
                                                  ));
                                            });
                                      } else {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  contentPadding:
                                                      const EdgeInsets.all(0),
                                                  content: AlertBox(
                                                    payMent: 'Alert',
                                                    errormsg: true,
                                                    widget: Center(
                                                        child: ContentContainer(
                                                      content:
                                                          'Kindky Select Item List',
                                                      theme: widget.theme,
                                                    )),
                                                    buttonName: null,
                                                  ));
                                            });
                                      }
                                      // if (context
                                      //         .read<StockOutwardController>()
                                      //         .selectAll !=
                                      //     true) {
                                      //   if (context
                                      //           .read<StockOutwardController>()
                                      //           .selectItemIndex !=
                                      //       null) {
                                      //     context
                                      //         .read<StockOutwardController>()
                                      //         .manualselectbtndisable = true;

                                      //     context
                                      //         .read<StockOutwardController>()
                                      //         .manualscanmethod(
                                      // widget.index!,
                                      // context
                                      //     .read<
                                      //         StockOutwardController>()
                                      //     .searchcon
                                      //     .text
                                      //     .toString(),
                                      // context
                                      //     .read<
                                      //         StockOutwardController>()
                                      //     .selectItemIndex!,
                                      // widget.theme,
                                      //             context);
                                      //   } else {
                                      //     showDialog(
                                      //         context: context,
                                      //         barrierDismissible: true,
                                      //         builder: (BuildContext context) {
                                      //           return AlertDialog(
                                      //               contentPadding:
                                      //                   const EdgeInsets.all(0),
                                      //               content: AlertBox(
                                      //                 payMent: 'Alert',
                                      //                 errormsg: true,
                                      //                 widget: Center(
                                      //                     child:
                                      //                         ContentContainer(
                                      //                   content:
                                      //                       'Select Item List',
                                      //                   theme: widget.theme,
                                      //                 )),
                                      //                 buttonName: null,
                                      //               ));
                                      //         });
                                      //   }
                                      // } else {
                                      //   showDialog(
                                      //       context: context,
                                      //       barrierDismissible: true,
                                      //       builder: (BuildContext context) {
                                      //         return AlertDialog(
                                      //             contentPadding:
                                      //                 const EdgeInsets.all(0),
                                      //             content: AlertBox(
                                      //               payMent: 'Alert',
                                      //               errormsg: true,
                                      //               widget: Center(
                                      //                   child: ContentContainer(
                                      //                 content:
                                      //                     'Kindly deselect the all items',
                                      //                 theme: widget.theme,
                                      //               )),
                                      //               buttonName: null,
                                      //             ));
                                      //       });
                                      // }
                                    },
                              child: Text('Manual Select')),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "  ${context.watch<StockOutwardController>().msg}",
                            style: widget.theme.textTheme.bodySmall!
                                .copyWith(color: Colors.red),
                          ),
                        ],
                      ),
                      SizedBox(height: widget.searchHeight * 0.008),
                      SizedBox(
                        height: widget.searchHeight * 0.01,
                      ),
                      context
                              .watch<StockOutwardController>()
                              .noMsgText
                              .isNotEmpty
                          ? Padding(
                              padding: EdgeInsets.only(
                                left: widget.searchWidth * 0.05,
                              ),
                              child: Text(
                                context
                                    .watch<StockOutwardController>()
                                    .noMsgText,
                                style: widget.theme.textTheme.bodyMedium
                                    ?.copyWith(color: Colors.red),
                              ),
                            )
                          : Container(),
                      SizedBox(
                        width: widget.searchWidth * 1.18,
                        height: widget.searchHeight * 0.908,
                        child: context
                                .read<StockOutwardController>()
                                .filterSerialbatchList!
                                .isEmpty
                            ? Container()
                            : ListView.builder(
                                itemCount: context
                                    .read<StockOutwardController>()
                                    .filterSerialbatchList!
                                    .length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, i) {
                                  return Card(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        top: widget.searchHeight * 0.01,
                                        left: widget.searchHeight * 0.01,
                                        right: widget.searchHeight * 0.01,
                                        bottom: widget.searchHeight * 0.01,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.grey.withOpacity(0.04),
                                        border: Border.all(color: Colors.white),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width:
                                                      widget.searchWidth * 0.2,
                                                  child: Text(
                                                    "${context.read<StockOutwardController>().filterSerialbatchList![i].itemcode}",
                                                    style: widget.theme
                                                        .textTheme.bodyLarge,
                                                  ),
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  width:
                                                      widget.searchWidth * 0.2,
                                                  child: Text(
                                                    "${context.read<StockOutwardController>().filterSerialbatchList![i].serialbatch}",
                                                    style: widget.theme
                                                        .textTheme.bodyLarge,
                                                  ),
                                                ),
                                              ]),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: widget.searchWidth * 0.2,
                                                child: Text(
                                                  "Scanned Qty : ${context.read<StockOutwardController>().filterSerialbatchList![i].qty}",
                                                  style: widget.theme.textTheme
                                                      .bodyLarge,
                                                ),
                                              ),
                                              // Container(
                                              //     width:
                                              //         widget.searchWidth * 0.1,
                                              //     height: widget.searchHeight *
                                              //         0.07,
                                              //     alignment: Alignment.center,
                                              //     padding: EdgeInsets.symmetric(
                                              //         horizontal:
                                              //             widget.searchWidth *
                                              //                 0.005),
                                              //     child: TextFormField(
                                              //       textAlign: TextAlign.right,
                                              //       onTap: () {
                                              //         context
                                              //                 .read<
                                              //                     StockOutwardController>()
                                              //                 .qtymycontroller[i]
                                              //                 .text =
                                              //             context
                                              //                 .read<
                                              //                     StockOutwardController>()
                                              //                 .qtymycontroller[
                                              //                     i]
                                              //                 .text;
                                              //         context
                                              //             .read<
                                              //                 StockOutwardController>()
                                              //             .qtymycontroller[i]
                                              //             .selection = TextSelection(
                                              //           baseOffset: 0,
                                              //           extentOffset: context
                                              //               .read<
                                              //                   StockOutwardController>()
                                              //               .qtymycontroller[i]
                                              //               .text
                                              //               .length,
                                              //         );
                                              //       },
                                              //       style: widget.theme
                                              //           .textTheme.bodyMedium
                                              //           ?.copyWith(
                                              //               color:
                                              //                   Colors.black),
                                              //       onChanged: (v) {},
                                              //       cursorColor: Colors.grey,
                                              //       textDirection:
                                              //           TextDirection.ltr,
                                              //       keyboardType:
                                              //           TextInputType.number,
                                              //       inputFormatters: [
                                              //         FilteringTextInputFormatter
                                              //             .digitsOnly
                                              //       ],
                                              //       onEditingComplete: () {
                                              //         setState(() {
                                              //           context.read<StockOutwardController>().stkOutEditQty(
                                              //               context
                                              //                   .read<
                                              //                       StockOutwardController>()
                                              //                   .get_i_value,
                                              //               context
                                              //                   .read<
                                              //                       StockOutwardController>()
                                              //                   .StockOutward[context
                                              //                       .read<
                                              //                           StockOutwardController>()
                                              //                       .get_i_value]
                                              //                   .data[context
                                              //                       .read<
                                              //                           StockOutwardController>()
                                              //                       .batch_i!]
                                              //                   .serialbatchList![
                                              //                       i]
                                              //                   .serialbatch!,
                                              //               context
                                              //                   .read<
                                              //                       StockOutwardController>()
                                              //                   .batch_i!,
                                              //               context
                                              //                   .read<
                                              //                       StockOutwardController>()
                                              //                   .StockOutward[context
                                              //                       .read<
                                              //                           StockOutwardController>()
                                              //                       .get_i_value]
                                              //                   .data[context
                                              //                       .read<
                                              //                           StockOutwardController>()
                                              //                       .batch_i!]
                                              //                   .itemcode!,
                                              //               i);
                                              //         });

                                              //         context
                                              //             .read<
                                              //                 StockOutwardController>()
                                              //             .disableKeyBoard(
                                              //                 context);
                                              //       },
                                              //       controller: context
                                              //           .read<
                                              //               StockOutwardController>()
                                              //           .qtymycontroller[i],
                                              //       decoration: InputDecoration(
                                              //         filled: false,
                                              //         enabledBorder:
                                              //             OutlineInputBorder(
                                              //           borderRadius:
                                              //               BorderRadius
                                              //                   .circular(5),
                                              //           borderSide:
                                              //               const BorderSide(
                                              //                   color: Colors
                                              //                       .grey),
                                              //         ),
                                              //         focusedBorder:
                                              //             OutlineInputBorder(
                                              //           borderRadius:
                                              //               BorderRadius
                                              //                   .circular(5),
                                              //           borderSide:
                                              //               const BorderSide(
                                              //                   color: Colors
                                              //                       .grey),
                                              //         ),
                                              //         contentPadding:
                                              //             const EdgeInsets
                                              //                 .symmetric(
                                              //           vertical: 0,
                                              //           horizontal: 5,
                                              //         ),
                                              //       ),
                                              //     )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                      ),
                      SizedBox(
                        height: widget.searchHeight * 0.05,
                      ),
                      SizedBox(
                          width: widget.searchWidth,
                          child: ElevatedButton(
                              onPressed: () {
                                // context
                                //     .read<StockOutwardController>()
                                //     .stoutLineRefersh(
                                //         context
                                //             .read<StockOutwardController>()
                                //             .get_i_value,
                                //         context
                                //             .read<StockOutwardController>()
                                //             // .StockOutward[context
                                //             //     .read<StockOutwardController>()
                                //             //     .get_i_value]
                                //             // .data[context
                                //             //     .read<StockOutwardController>()
                                //             //     .batch_i!]
                                //             .filterSerialbatchList);
                                // context.read<StockOutwardController>().passData(
                                //     widget.theme, context, widget.index!);

                                context
                                    .read<StockOutwardController>()
                                    .isselectmethod();
                                log('StockOutward[index]3333:::${context.read<StockOutwardController>().StockOutward[context.read<StockOutwardController>().get_i_value].data.length}');
                              },
                              child: const Text("Save and Back"))),
                      SizedBox(
                        height: widget.searchHeight * 0.01,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
