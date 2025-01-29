import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Controller/StockInwardController/StockInwardContler.dart';

import '../../../../../Constant/Screen.dart';
import '../../../../../Models/DataModel/StockInwardModel/StockInwardListModel.dart';

class StockIn_DetailsWidget extends StatelessWidget {
  StockIn_DetailsWidget({
    super.key,
    required this.theme,
    required this.stInCon,
    required this.index,
    required this.sinHeigh,
    required this.sinWidth,
    required this.data,
    required this.datatotal,
  });
  double sinHeigh;
  double sinWidth;
  int index;
  final ThemeData theme;
  StockInwrdController stInCon;
  List<StockInwardDetails>? data;
  List<StockInwardList>? datatotal;

  @override
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(
          right: sinHeigh * 0.012,
          left: sinHeigh * 0.012,
          top: sinHeigh * 0.012),
      child: Column(
        children: [
          Container(
            width: sinWidth,
            padding: EdgeInsets.all(
              sinHeigh * 0.01,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: sinHeigh * 0.3,
                  // color: Colors.amber,
                  child: Text("Request From ${datatotal![index].reqtoWhs}"),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  // width: sinHeigh * 0.2,
                  // color: Colors.amber,
                  child: Text("${datatotal![index].reqtransdate}"),
                )
              ],
            ),
          ),
          SizedBox(
            height: sinHeigh * 0.01,
          ),
          Container(
            height: sinHeigh * 0.79,
            width: sinWidth,
            // padding: EdgeInsets.all(
            //   sinHeigh * 0.008,
            // ),

            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(), // new

                      itemCount: data!.length,
                      itemBuilder: (context, i) {
                        return data!.isEmpty
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : InkWell(
                                onTap: () {
                                  //   List<String> sample=["as","as","fds"
                                  // ];
                                  //   stInCon.test2![0].addAll(sample);
                                  // print(stInCon.test2);
                                  stInCon.valPass(data![i].Scanned_Qty!);
                                  stInCon.stInController[0].text = "";
                                  stInCon.scannigVal = data![i].Scanned_Qty!;
                                  stInCon.passindexBachPage(index, i, data![i]);
                                  // stInCon.getBatchData(index, i);

                                  stInCon.page.animateToPage(
                                      ++stInCon.pageIndex,
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.linearToEaseOut);
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(sinHeigh * 0.002),
                                  child: Container(
                                      // width: sinWidth * 0.95,
                                      // height: sinHeigh * 0.3,
                                      // padding: EdgeInsets.all(
                                      //   sinHeigh * 0.008,
                                      // ),
                                      decoration: BoxDecoration(
                                        color: data![i].Scanned_Qty != 0 &&
                                                data![i].qty !=
                                                    data![i].Scanned_Qty!
                                            ? const Color(0xFFfcedee)
                                            : data![i].Scanned_Qty != 0 &&
                                                    data![i].qty ==
                                                        data![i].Scanned_Qty!
                                                ? const Color(0xFFebfaef)
                                                : data![i].Scanned_Qty == 0 &&
                                                        data![i].qty !=
                                                            data![i]
                                                                .Scanned_Qty!
                                                    ? Colors.white
                                                    : Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 3,
                                            blurRadius: 7,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        border: Border.all(
                                          color: data![i].Scanned_Qty != 0 &&
                                                  data![i].qty !=
                                                      data![i].Scanned_Qty!
                                              ? Colors.red.withOpacity(0.3)
                                              : data![i].Scanned_Qty != 0 &&
                                                      data![i].qty ==
                                                          data![i].Scanned_Qty!
                                                  ? Colors.green
                                                      .withOpacity(0.3)
                                                  : data![i].Scanned_Qty == 0 &&
                                                          data![i].qty !=
                                                              data![i]
                                                                  .Scanned_Qty!
                                                      ? Colors.white
                                                      : Colors.white,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                              // crossAxisAlignment:
                                              //     CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  // crossAxisAlignment:
                                                  //     CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: sinWidth * 0.48,
                                                      // color: Colors.amber,
                                                      // padding: EdgeInsets.all(
                                                      //     sinHeigh * 0.006),
                                                      decoration: BoxDecoration(
                                                          // color: Colors.amber,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4)),
                                                      child: Text(
                                                        "${data![i].itemcode}",
                                                        // "${stInCon.getScanneditemData[index].ItemName}",
                                                        style: theme.textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                          // fontSize: 12,
                                                          color: Colors.black,
                                                          // fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: sinHeigh * 0.008,
                                                    ),
                                                    Container(
                                                      // padding: EdgeInsets.all(
                                                      //     sinHeigh * 0.001),
                                                      width: sinWidth * 0.5,

                                                      // width: sinWidth * 0.3,
                                                      decoration: BoxDecoration(
                                                          // color: Colors.grey[600],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4)),
                                                      // color: Colors.blue,
                                                      child: Text(
                                                        " ${data![i].serialBatch}",
                                                        // "${stInCon.getScanneditemData[index].SerialBatch}",
                                                        style: theme.textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                          // fontSize: 12,
                                                          color: Colors.black,
                                                          // fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                //
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      width: sinWidth * 0.37,
                                                      // color: Colors.blue,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                width:
                                                                    sinWidth *
                                                                        0.17,
                                                                padding: EdgeInsets
                                                                    .all(sinHeigh *
                                                                        0.006),
                                                                decoration:
                                                                    BoxDecoration(
                                                                        // color: Colors.amber,
                                                                        borderRadius:
                                                                            BorderRadius.circular(4)),
                                                                child: Text(
                                                                  "Req.Qty",
                                                                  // "${stInCon.getScanneditemData[index].ItemName}",
                                                                  style: theme
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .copyWith(
                                                                    // fontSize: 12,
                                                                    color: Colors
                                                                        .black,
                                                                    // fontWeight: FontWeight.bold
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .all(sinHeigh *
                                                                        0.005),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                width:
                                                                    sinWidth *
                                                                        0.15,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        // color: Colors.grey[600],
                                                                        borderRadius:
                                                                            BorderRadius.circular(4)),
                                                                // color: Colors.blue,
                                                                child: Text(
                                                                  "${data![i].qty}",
                                                                  // "${stInCon.getScanneditemData[index].SerialBatch}",
                                                                  style: theme
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .copyWith(
                                                                    // fontSize: 12,
                                                                    color: Colors
                                                                        .black,
                                                                    // fontWeight: FontWeight.bold
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            // crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                width:
                                                                    sinWidth *
                                                                        0.15,
                                                                padding: EdgeInsets
                                                                    .all(sinHeigh *
                                                                        0.006),
                                                                decoration:
                                                                    BoxDecoration(
                                                                        // color: Colors.amber,
                                                                        borderRadius:
                                                                            BorderRadius.circular(4)),
                                                                child: Text(
                                                                  "Tra.Qty",
                                                                  // "${stInCon.getScanneditemData[index].ItemName}",
                                                                  style: theme
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .copyWith(
                                                                    // fontSize: 12,
                                                                    color: Colors
                                                                        .black,
                                                                    // fontWeight: FontWeight.bold
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .all(sinHeigh *
                                                                        0.005),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                width:
                                                                    sinWidth *
                                                                        0.15,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        // color: Colors.grey[600],
                                                                        borderRadius:
                                                                            BorderRadius.circular(4)),
                                                                // color: Colors.blue,
                                                                child: Text(
                                                                  "${data![i].trans_Qty}",
                                                                  // "${stInCon.getScanneditemData[index].SerialBatch}",
                                                                  style: theme
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .copyWith(
                                                                    // fontSize: 12,
                                                                    color: Colors
                                                                        .black,
                                                                    // fontWeight: FontWeight.bold
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Container(
                                                          // width: sinWidth * 0.21,
                                                          // padding: EdgeInsets.all(sinHeigh * 0.006),
                                                          decoration:
                                                              BoxDecoration(
                                                                  // color: Colors.amber,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4)),
                                                          child: Text(
                                                            "Scanned Qty - ",
                                                            style: theme
                                                                .textTheme
                                                                .bodySmall!
                                                                .copyWith(
                                                              // fontSize: 12,
                                                              color:
                                                                  Colors.grey,
                                                              // fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          // width: sinWidth * 0.08,
                                                          decoration:
                                                              BoxDecoration(
                                                                  // color: Colors.grey[600],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4)),
                                                          child: Text(
                                                            "${data![i].Scanned_Qty}",
                                                            style: theme
                                                                .textTheme
                                                                .bodySmall!
                                                                .copyWith(
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ]),
                                        ],
                                      )),
                                ),
                              );
                      }),
                ],
              ),
            ),
          ),
          SizedBox(
            height: sinHeigh * 0.01,
          ),
          Container(
            padding: EdgeInsets.all(sinHeigh * 0.005),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            // width: Screens.width(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: Screens.width(context) * 0.3,
                  child: ElevatedButton(
                    onPressed: () {
                      forSuspend(context, theme);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(
                          color: theme.primaryColor,
                          width: Screens.width(context) * 0.001),
                    ),
                    child: Text(
                      "Suspended",
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: theme.primaryColor),
                    ),
                  ),
                ),
                SizedBox(
                  width: Screens.width(context) * 0.3,
                  child: ElevatedButton(
                    onPressed: () {
                      stInCon.holdbutton(
                          index, context, theme, data, datatotal![index]);
                      stInCon.page.animateToPage(--stInCon.pageIndex,
                          duration: const Duration(milliseconds: 1400),
                          curve: Curves.linearToEaseOut);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(
                          color: theme.primaryColor,
                          width: Screens.width(context) * 0.001),
                    ),
                    child: Text(
                      "Hold",
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: theme.primaryColor),
                    ),
                  ),
                ),
                SizedBox(
                  width: Screens.width(context) * 0.3,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        side: BorderSide(
                            color: theme.primaryColor,
                            width: Screens.width(context) * 0.001),
                      ),
                      onPressed: stInCon.onClickDisable == false
                          ? () async {
                              stInCon.submitbutton(index, context, theme, data,
                                  datatotal![index]);
                              stInCon.page.animateToPage(--stInCon.pageIndex,
                                  duration: const Duration(milliseconds: 1400),
                                  curve: Curves.linearToEaseOut);
                              stInCon.myFuture(context, theme, data);
                              // await new Future.delayed(new Duration(seconds: 2));
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => DashBoardScreen()));
                            }
                          : null,
                      child: Text("Submit",
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: Colors.white))),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // forSuspend(BuildContext context) {
  //   return Container(
  //       child: Column(
  //     children: [
  //       Container(
  //           // color: Colors.amber,
  //           padding: EdgeInsets.all(Screens.bodyheight(context) * 0.02),
  //           child: Center(
  //               child: Text(
  //             "You about to suspended all information will be unsaved",
  //             textAlign: TextAlign.center,
  //           ))),
  //       Padding(
  //         padding: EdgeInsets.all(Screens.bodyheight(context) * 0.008),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             GestureDetector(
  //                 onTap: () {
  //                   stInCon.page.animateToPage(--stInCon.pageIndex,
  //                       duration: Duration(milliseconds: 400),
  //                       curve: Curves.linearToEaseOut);
  //                   Navigator.pop(context);
  //                 },
  //                 child: Container(
  //                   width: Screens.width(context) * 0.22,
  //                   alignment: Alignment.center,
  //                   decoration: BoxDecoration(
  //                       color: theme.primaryColor,
  //                       borderRadius: BorderRadius.circular(3),
  //                       border: Border.all(
  //                         color: theme.primaryColor,
  //                       )),
  //                   height: Screens.bodyheight(context) * 0.05,
  //                   child: Text("Yes",
  //                       style: theme.textTheme.bodyText2?.copyWith(
  //                         color: Colors.white,
  //                       )),
  //                 )),
  //             GestureDetector(
  //                 onTap: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Container(
  //                   width: Screens.width(context) * 0.22,
  //                   alignment: Alignment.center,
  //                   decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(3),
  //                       color: theme.primaryColor,
  //                       border: Border.all(
  //                         color: theme.primaryColor,
  //                       )),
  //                   height: Screens.bodyheight(context) * 0.05,
  //                   child: Text("No",
  //                       style: theme.textTheme.bodyText2?.copyWith(
  //                         color: Colors.white,
  //                       )),
  //                 )),
  //           ],
  //         ),
  //       ),
  //     ],
  //   ));
  // }

  forSuspend(BuildContext context, ThemeData theme) {
    return Get.defaultDialog(
        title: "Alert",
        middleText: "You about to suspended all information will be unsaved",
        backgroundColor: Colors.white,
        titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
        middleTextStyle: theme.textTheme.bodyLarge,
        radius: 0,
        // onCancel: (){},
        // onConfirm: (){},
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    stInCon.suspendedbutton(
                        index, context, theme, data, datatotal![index]);

                    stInCon.page.animateToPage(--stInCon.pageIndex,
                        duration: const Duration(milliseconds: 1400),
                        curve: Curves.linearToEaseOut);

                    Navigator.pop(context);
                  },
                  child: Container(
                    width: Screens.width(context) * 0.22,
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
                    width: Screens.width(context) * 0.22,
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
