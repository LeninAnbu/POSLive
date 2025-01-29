import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Controller/RefundsController/RefundController.dart';

class RefundInventoriesList extends StatefulWidget {
  RefundInventoriesList(
      {super.key,
      required this.theme,
      required this.searchHeight,
      required this.searchWidth});

  final ThemeData theme;
  double searchHeight;
  double searchWidth;
  @override
  State<RefundInventoriesList> createState() => _RefundInventoriesListState();
}

class _RefundInventoriesListState extends State<RefundInventoriesList> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        height: widget.searchHeight,
        width: widget.searchWidth,
        padding: EdgeInsets.only(
            top: widget.searchHeight * 0.01,
            left: widget.searchHeight * 0.01,
            right: widget.searchHeight * 0.01,
            bottom: widget.searchHeight * 0.01),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            context.read<RefundController>().selectedcust2 != null
                ? Container()
                : Container(
                    alignment: Alignment.center,
                    width: widget.searchWidth * 1,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 240, 235, 235)),
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.grey.withOpacity(0.01),
                    ),
                    child: TextFormField(
                      style: theme.textTheme.bodyLarge,
                      cursorColor: Colors.grey,
                      onChanged: (v) {
                        //  context.read<RefundController>().filterInvoiceList(v);
                      },
                      controller:
                          context.read<RefundController>().mycontroller[80],
                      onEditingComplete: () {
                        context.read<RefundController>().invoiceBatchAvail(
                            context
                                .read<RefundController>()
                                .mycontroller[80]
                                .text
                                .toString()
                                .trim()
                                .toUpperCase(),
                            context,
                            theme);
                      },
                      decoration: InputDecoration(
                        filled: false,
                        hintText: 'Return Information',
                        hintStyle: theme.textTheme.bodyLarge?.copyWith(),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        // suffixIcon: IconButton(
                        //   icon: Icon(
                        //     Icons.search,
                        //     // size: searchHeight * 0.05,
                        //     color: Colors.grey,
                        //   ),
                        //   onPressed: () {
                        //     // Navigator.push((context),
                        //     //     MaterialPageRoute(builder: (_) => SettingScreens()));
                        //   },
                        //   color: theme.primaryColor,
                        // ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                      ),
                    )),
            SizedBox(
              height: widget.searchHeight * 0.01,
            ),
            context.read<RefundController>().getScanneditemData2.isNotEmpty
                ? SizedBox(
                    height: widget.searchHeight * 0.75,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: context
                            .watch<RefundController>()
                            .getScanneditemData2
                            .length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Container(
                                padding: EdgeInsets.only(
                                  top: widget.searchHeight * 0.01,
                                  left: widget.searchHeight * 0.01,
                                  right: widget.searchHeight * 0.01,
                                  // bottom: widget.searchHeight * 0.01,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey[300]),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              // Text("Invoice#  "),
                                              Text(
                                                  "${context.watch<RefundController>().getScanneditemData2[index].doctype} - ${context.watch<RefundController>().getScanneditemData2[index].docNum}")
                                            ],
                                          ),
                                          Text(context
                                              .read<RefundController>()
                                              .config
                                              .alignDate(context
                                                  .read<RefundController>()
                                                  .getScanneditemData2[index]
                                                  .date
                                                  .toString()))
                                        ],
                                      ),
                                      // Container(
                                      //   // width: searchWidth * 0.2,
                                      //   child: Column(
                                      //     children: [
                                      //       Container(
                                      //         child: Text("Invoice Amt"),
                                      //       ),
                                      //       Container(
                                      //           child: Text(
                                      //        context.read<RefundController>().config
                                      //             .slpitCurrency2(widget
                                      //                 .prdsrch
                                      //                 .getScanneditemData2[
                                      //                     index]
                                      //                 .amount!
                                      //                 .toStringAsFixed(2)),
                                      //         style: theme.textTheme.bodyText2
                                      //             ?.copyWith(
                                      //                 fontSize: 17,
                                      //                 fontWeight:
                                      //                     FontWeight.bold,
                                      //                 color: Colors.black),
                                      //       )
                                      //           // : Text(
                                      //           //  context.read<RefundController>().config
                                      //           //       .slpitCurrency2(
                                      //           //         context.read<RefundController>(). invAmt
                                      //           //           .toString())
                                      //           //       .toString(),
                                      //           //   style: theme
                                      //           //       .textTheme.bodyText2
                                      //           //       ?.copyWith(
                                      //           //           fontSize: 17,
                                      //           //           color:
                                      //           //               Colors.black),
                                      //           // ),
                                      //           ),
                                      //     ],
                                      //   ),

                                      //   // Text(
                                      //   //     "${prdsrch.getScanneditemData[index].Qty}",
                                      //   // style: theme.textTheme.bodyText2
                                      //   //     ?.copyWith(
                                      //   //         color: Colors.black)),
                                      // ),
                                      Container(
                                          width: widget.searchWidth * 0.15,
                                          height: widget.searchHeight * 0.08,
                                          alignment: Alignment.center,
                                          // width: Screens.width(context) * 0.015,
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  widget.searchWidth * 0.005),
                                          // height: searchHeight *
                                          //     0.025,
                                          child: TextFormField(
                                            readOnly: true,
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                            onChanged: (v) {},
                                            cursorColor: Colors.grey,
                                            textDirection: TextDirection.rtl,
                                            keyboardType: TextInputType.number,
                                            onEditingComplete: () {
                                              //  context.read<RefundController>()
                                              //       .totalpaidamt(context, theme);
                                              // widget.  prdsrch
                                              //       .itemIncrement11(
                                              //           index,
                                              //           context,
                                              //           theme);
                                            },
                                            controller: context
                                                .read<RefundController>()
                                                .mycontroller2[index],
                                            decoration: InputDecoration(
                                              filled: false,
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: const BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: const BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 0,
                                                horizontal: 5,
                                              ),
                                            ),
                                          ))
                                    ])),
                          );
                        }),
                  )
                : context.watch<RefundController>().getScanneditemData.isEmpty
                    ? Container(
                        alignment: Alignment.bottomRight,
                        // child: InkWell(
                        //   onTap: () {
                        //     setState(() {
                        //       //context.read<RefundController>().selectedcust == null
                        //       //     ?
                        //     //  context.read<RefundController>()
                        //     //       .AAAAdvance("Advance", context, theme);
                        //     //  context.read<RefundController>().disableKeyBoard(context);
                        //       // : showDialog(
                        //       //     context: context,
                        //       //     barrierDismissible: true,
                        //       //     builder: (BuildContext context) {
                        //       //       return StatefulBuilder(
                        //       //           builder: (context, st) {
                        //       //         return AlertDialog(
                        //       //             contentPadding: EdgeInsets.all(0),
                        //       //             content: AlertBox(
                        //       //               payMent: 'Alert',
                        //       //               widget: Alertadvane(
                        //       //                   context,context.read<RefundController>()),
                        //       //               buttonName: null,
                        //       //               // callback: () {
                        //       //               //   st(
                        //       //               //     () {
                        //       //               //       payController.addEnteredAmtType(
                        //       //               //           'Cash', context, 1, theme);
                        //       //               //     },
                        //       //               //   );
                        //       //               // },
                        //       //             ));
                        //       //       });
                        //       //     });
                        //     });
                        //   }, //Alertadvane
                        //   child: Container(
                        //     alignment: Alignment.center,
                        //     padding: EdgeInsets.all(widget.searchHeight * 0.01),
                        //     decoration: BoxDecoration(
                        //         border: Border.all(color: theme.primaryColor),
                        //         borderRadius: BorderRadius.circular(5),
                        //         color: theme.primaryColor
                        //         // color: Colors.grey.withOpacity(0.05),
                        //         ),
                        //     height: widget.searchHeight * 0.06,
                        //     width: widget.searchWidth * 0.2,
                        //     child: Text(
                        //       "Advance",
                        //       style: theme.textTheme.bodyText2
                        //           ?.copyWith(color: Colors.white),
                        //     ),
                        //   ),
                        // ),
                      )
                    : SizedBox(
                        height: widget.searchHeight * 0.75,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: context
                                .watch<RefundController>()
                                .getScanneditemData
                                .length,
                            itemBuilder: (context, index) {
                              // print("ScanneditemData.length" +
                              //    context.read<RefundController>().getScanneditemData.length
                              //         .toString());
                              return

                                  // onTap: () {
                                  //   setState(() {
                                  //    context.read<RefundController>().itemDeSelect(index);
                                  //   });
                                  // },

                                  Card(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    top: widget.searchHeight * 0.01,
                                    left: widget.searchHeight * 0.01,
                                    right: widget.searchHeight * 0.01,
                                    // bottom: widget.searchHeight * 0.01,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: context
                                                      .read<RefundController>()
                                                      .getScanneditemData[index]
                                                      .checkbx ==
                                                  1 &&
                                              context
                                                      .read<RefundController>()
                                                      .getScanneditemData[index]
                                                      .checkClr ==
                                                  true
                                          ? Colors.blue.withOpacity(0.35)
                                          : Colors.grey.withOpacity(0.2)),
                                  child: CheckboxListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      onChanged: (val) {
                                        context
                                            .read<RefundController>()
                                            .itemDeSelect(index);
                                      },
                                      value: context
                                          .read<RefundController>()
                                          .getScanneditemData[index]
                                          .checkClr,
                                      title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Checkbox(
                                            //     side:
                                            //         BorderSide(color: Colors.grey),
                                            //     activeColor: Colors.green,
                                            //     value:context.read<RefundController>().selectcust!.payItem![index].checkClr,
                                            //     onChanged: (val) {
                                            //       setState(() {

                                            //          widget. prdsrch.selectcust!.payItem![index].checkClr = val!;
                                            //         //  widget. prdsrch.checkkkcolor();
                                            //          log("color:${widget.prdsrch.selectcust!.payItem![index].checkClr}");
                                            //       });
                                            //     }),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              // mainAxisAlignment:
                                              //     MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    // Text("Invoice#  "),
                                                    Text(
                                                        "${context.watch<RefundController>().getScanneditemData[index].doctype} - ${context.watch<RefundController>().getScanneditemData[index].docNum}")
                                                  ],
                                                ),
                                                Text(context
                                                    .read<RefundController>()
                                                    .config
                                                    .alignDate(context
                                                        .read<
                                                            RefundController>()
                                                        .getScanneditemData[
                                                            index]
                                                        .date
                                                        .toString()))
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                const Text("Return Amt"),
                                                Text(
                                                  context
                                                      .read<RefundController>()
                                                      .config
                                                      .splitValues(context
                                                          .read<
                                                              RefundController>()
                                                          .getScanneditemData[
                                                              index]
                                                          .amount!
                                                          .toStringAsFixed(2)),
                                                  style: theme
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                ),
                                              ],
                                            ),
                                            // Container(
                                            //     width:
                                            //         widget.searchWidth * 0.15,
                                            //     height:
                                            //         widget.searchHeight * 0.08,
                                            //     alignment: Alignment.center,
                                            //     // width: Screens.width(context) * 0.015,
                                            //     padding: EdgeInsets.symmetric(
                                            //         horizontal:
                                            //             widget.searchWidth *
                                            //                 0.005),
                                            //     // height: searchHeight *
                                            //     //     0.025,
                                            //     child: TextFormField(
                                            //       onTap: () {
                                            //         context
                                            //                 .read<
                                            //                     RefundController>()
                                            //                 .mycontroller[index]
                                            //                 .text =
                                            //             context
                                            //                 .read<
                                            //                     RefundController>()
                                            //                 .mycontroller[index]
                                            //                 .text;
                                            //         context
                                            //             .read<
                                            //                 RefundController>()
                                            //             .mycontroller[index]
                                            //             .selection = TextSelection(
                                            //           baseOffset: 0,
                                            //           extentOffset: context
                                            //               .read<
                                            //                   RefundController>()
                                            //               .mycontroller[index]
                                            //               .text
                                            //               .length,
                                            //         );
                                            //       },
                                            //       style: theme
                                            //           .textTheme.bodyText2
                                            //           ?.copyWith(
                                            //               color: Colors.black),
                                            //       onChanged: (v) {},
                                            //       cursorColor: Colors.grey,
                                            //       textDirection:
                                            //           TextDirection.rtl,
                                            //       keyboardType:
                                            //           TextInputType.number,
                                            //       onEditingComplete: () {
                                            //         //  context.read<RefundController>().totalpaidamt(
                                            //         // context, theme);
                                            //         // widget.  prdsrch
                                            //         //       .itemIncrement11(
                                            //         //           index,
                                            //         //           context,
                                            //         //           theme);
                                            //       },
                                            //       controller: context
                                            //           .read<RefundController>()
                                            //           .mycontroller[index],
                                            //       decoration: InputDecoration(
                                            //         filled: false,
                                            //         enabledBorder:
                                            //             OutlineInputBorder(
                                            //           borderRadius:
                                            //               BorderRadius.circular(
                                            //                   5),
                                            //           borderSide: BorderSide(
                                            //               color: Colors.grey),
                                            //         ),
                                            //         focusedBorder:
                                            //             OutlineInputBorder(
                                            //           borderRadius:
                                            //               BorderRadius.circular(
                                            //                   5),
                                            //           borderSide: BorderSide(
                                            //               color: Colors.grey),
                                            //         ),
                                            //         contentPadding:
                                            //             const EdgeInsets
                                            //                 .symmetric(
                                            //           vertical: 0,
                                            //           horizontal: 5,
                                            //         ),
                                            //       ),
                                            //     ))
                                          ])),
                                ),
                              );
                            }),
                      ),
            SizedBox(
              height: widget.searchHeight * 0.04,
            ),
            context.read<RefundController>().scanneditemData2.isNotEmpty
                ? Container()
                : context.read<RefundController>().scanneditemData.isEmpty
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            SizedBox(
                              width: widget.searchWidth * 0.45,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        context
                                            .read<RefundController>()
                                            .selectall();
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(
                                          widget.searchHeight * 0.01),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: theme.primaryColor),
                                        borderRadius: BorderRadius.circular(5),
                                        // color: Colors.red
                                        color: Colors.grey.withOpacity(0.05),
                                      ),
                                      height: widget.searchHeight * 0.06,
                                      width: widget.searchWidth * 0.2,
                                      child: Text(
                                        "Select All",
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                                color: theme.primaryColor),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        context
                                            .read<RefundController>()
                                            .deSelectall();
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(
                                          widget.searchHeight * 0.01),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: theme.primaryColor),
                                        borderRadius: BorderRadius.circular(5),
                                        // color: Colors.red
                                        color: Colors.grey.withOpacity(0.05),
                                      ),
                                      height: widget.searchHeight * 0.06,
                                      width: widget.searchWidth * 0.2,
                                      child: Text(
                                        "Deselect All",
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                                color: theme.primaryColor),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // InkWell(
                            //   onTap: () {
                            //     setState(() {
                            //     //  context.read<RefundController>().deSelectalladv(
                            //     //       "Advance", context, theme);
                            //     });
                            //   },
                            //   child: Container(
                            //     alignment: Alignment.center,
                            //     padding:
                            //         EdgeInsets.all(widget.searchHeight * 0.01),
                            //     decoration: BoxDecoration(
                            //         border:
                            //             Border.all(color: theme.primaryColor),
                            //         borderRadius: BorderRadius.circular(5),
                            //         color: theme.primaryColor
                            //         // color: Colors.grey.withOpacity(0.05),
                            //         ),
                            //     height: widget.searchHeight * 0.06,
                            //     width: widget.searchWidth * 0.2,
                            //     child: Text(
                            //       "Advance",
                            //       style: theme.textTheme.bodyText2
                            //           ?.copyWith(color: Colors.white),
                            //     ),
                            //   ),
                            // ),
                          ])
          ],
        ));
  }

  alertadvane(BuildContext context, RefundController posC) {
    return Container(
        alignment: Alignment.center,
        height: widget.searchHeight * 0.15,
        width: widget.searchWidth * 1,
        child: const Text("Choose any Payment Mode"));
  }
}
