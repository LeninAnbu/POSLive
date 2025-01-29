import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Constant/Screen.dart';
import '../../../../../Controller/StockOutwardController/StockOutwardController.dart';
import '../../../../../Models/DataModel/StockOutwardModel/StockOutwardListModel.dart';

class StockOut_DetailsWidget extends StatelessWidget {
  StockOut_DetailsWidget({
    super.key,
    required this.theme,
    required this.stOutCon,
    required this.index,
    required this.sOutHeigh,
    required this.sOutWidth,
    required this.data,
    required this.datatotal,
  });
  double sOutHeigh;
  double sOutWidth;
  int index;
  final ThemeData theme;
  StockOutwardController stOutCon;
  List<StockOutwardDetails>? data;
  List<StockOutwardList>? datatotal;

  @override
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: sOutWidth,
          padding: EdgeInsets.all(
            sOutHeigh * 0.01,
          ),
          // height: sOutHeigh * 0.1,
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
                width: sOutHeigh * 0.3,
                // color: Colors.amber,
                child: Text("Request From ${datatotal![index].reqfromWhs}"),
              ),
              Container(
                alignment: Alignment.centerRight,
                // width:sOutHeigh * 0.2,
                // color: Colors.amber,
                child: Text("${datatotal![index].reqtransdate}"),
              )
            ],
          ),
        ),
        SizedBox(
          height: sOutHeigh * 0.015,
        ),
        Container(
          height: sOutHeigh * 0.79,
          width: sOutWidth,
          // padding: EdgeInsets.all(
          //   SIN_Heigh * 0.008,
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
                                log('data!data!data!::${data!.length}');
                                stOutCon.valPass(data![i].Scanned_Qty!);
                                stOutCon.StOutController[0].text = "";
                                stOutCon.ScannigVal = data![i].Scanned_Qty!;
                                stOutCon.passindexBachPage(index, i, data![i]);
                                stOutCon.getBatchData(index, i);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(sOutHeigh * 0.002),
                                child: Container(
                                    width: sOutWidth * 0.95,
                                    // height: sOutHeigh * 0.3,
                                    padding: EdgeInsets.all(
                                      sOutHeigh * 0.008,
                                    ),
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
                                                          data![i].Scanned_Qty!
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
                                                ? Colors.green.withOpacity(0.3)
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
                                                    width: sOutWidth * 0.48,
                                                    // color: Colors.amber,
                                                    // padding: EdgeInsets.all(
                                                    //     sOutHeigh * 0.006),
                                                    decoration: BoxDecoration(
                                                        // color: Colors.amber,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                    child: Text(
                                                      "${data![i].itemcode}",
                                                      // "${stOutCon.getScanneditemData[index].ItemName}",
                                                      style: theme
                                                          .textTheme.bodyMedium!
                                                          .copyWith(
                                                        // fontSize: 12,
                                                        color: Colors.black,
                                                        // fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: sOutHeigh * 0.008,
                                                  ),
                                                  Container(
                                                    // padding: EdgeInsets.all(
                                                    //     sOutHeigh * 0.001),
                                                    width: sOutWidth * 0.5,

                                                    // width: sOutWidth * 0.3,
                                                    decoration: BoxDecoration(
                                                        // color: Colors.grey[600],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                    // color: Colors.blue,
                                                    child: Text(
                                                      "${data![i].serialBatch}",
                                                      // "${stOutCon.getScanneditemData[index].SerialBatch}",
                                                      style: theme
                                                          .textTheme.bodyMedium!
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
                                                    width: sOutWidth * 0.37,
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
                                                              width: sOutWidth *
                                                                  0.17,
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      sOutHeigh *
                                                                          0.006),
                                                              decoration:
                                                                  BoxDecoration(
                                                                      // color: Colors.amber,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4)),
                                                              child: Text(
                                                                "Req.Qty",
                                                                // "${stOutCon.getScanneditemData[index].ItemName}",
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
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      sOutHeigh *
                                                                          0.005),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: sOutWidth *
                                                                  0.15,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      // color: Colors.grey[600],
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4)),
                                                              // color: Colors.blue,
                                                              child: Text(
                                                                "${data![i].qty}",
                                                                // "${stOutCon.getScanneditemData[index].SerialBatch}",
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
                                                              width: sOutWidth *
                                                                  0.15,
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      sOutHeigh *
                                                                          0.006),
                                                              decoration:
                                                                  BoxDecoration(
                                                                      // color: Colors.amber,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4)),
                                                              child: Text(
                                                                "Tra.Qty",
                                                                // "${stOutCon.getScanneditemData[index].ItemName}",
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
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      sOutHeigh *
                                                                          0.005),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: sOutWidth *
                                                                  0.15,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      // color: Colors.grey[600],
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4)),
                                                              // color: Colors.blue,
                                                              child: Text(
                                                                "${data![i].trans_Qty}",
                                                                // "${stOutCon.getScanneditemData[index].SerialBatch}",
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
                                                        // width: sOutWidth * 0.21,
                                                        // padding: EdgeInsets.all(sOutHeigh * 0.006),
                                                        decoration:
                                                            BoxDecoration(
                                                                // color: Colors.amber,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4)),
                                                        child: Text(
                                                          "Scanned Qty - ",
                                                          style: theme.textTheme
                                                              .bodySmall!
                                                              .copyWith(
                                                            // fontSize: 12,
                                                            color: Colors.grey,
                                                            // fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        // padding: EdgeInsets.all(sOutHeigh * 0.005),
                                                        alignment: Alignment
                                                            .centerRight,
                                                        // width: sOutWidth * 0.08,
                                                        decoration:
                                                            BoxDecoration(
                                                                // color: Colors.grey[600],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4)),
                                                        child: Text(
                                                          "${data![i].Scanned_Qty}",
                                                          style: theme.textTheme
                                                              .bodySmall!
                                                              .copyWith(
                                                            color: Colors.grey,
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
                // ElevatedButton(
                //     onPressed: () {
                //       stOutCon.page.animateToPage(--stOutCon.pageIndex,
                //           duration: Duration(milliseconds: 800),
                //           curve: Curves.linearToEaseOut);
                //     },
                //     child: Text("Back"))
              ],
            ),
          ),
        ),
        SizedBox(
          height: sOutHeigh * 0.014,
        ),
        Padding(
          padding: EdgeInsets.all(sOutHeigh * 0.006),
          child: Container(
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
            width: Screens.width(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      stOutCon.holdbutton(
                          index, context, theme, data, datatotal![index]);
                      // stOutCon.page.animateToPage(--stOutCon.pageIndex,
                      //     duration: Duration(milliseconds: 1400),
                      //     curve: Curves.linearToEaseOut);
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
                      onPressed: stOutCon.OnclickDisable == false
                          ? () {
                              log('datadddddddd::${data!.length}');
                              stOutCon.submitbutton(index, context, theme, data,
                                  datatotal![index]);
                              // stOutCon.page.animateToPage(--stOutCon.pageIndex,
                              //     duration: Duration(milliseconds: 1400),
                              //     curve: Curves.linearToEaseOut);

                              stOutCon.myFuture(context, theme, data);
                              // Get.toNamed(ConstantRoutes.dashboard);
                              // stOutCon.page.animateToPage(--stOutCon.pageIndex,
                              //     duration: Duration(milliseconds: 1400),
                              //     curve: Curves.linearToEaseOut);
                            }
                          : null,
                      child: Text("Submit",
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: Colors.white))),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  // forSuspend(BuildContext contextt) {
  //   return Container(
  //       child: Column(
  //     children: [
  //       Container(
  //           // color: Colors.amber,
  //           padding: EdgeInsets.all(Screens.bodyheight(contextt) * 0.02),
  //           child: Center(
  //               child: Text(
  //             "You about to suspended all information will be unsaved",
  //             textAlign: TextAlign.center,
  //           ))),
  //       Padding(
  //         padding: EdgeInsets.all(Screens.bodyheight(contextt) * 0.008),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             GestureDetector(
  //                 onTap: () {

  //                   stOutCon.suspendedbutton(
  //                       index, contextt, theme, data, datatotal![index]);

  //                        stOutCon.page.animateToPage(--stOutCon.pageIndex,
  //                           duration: Duration(milliseconds: 1400),
  //                           curve: Curves.linearToEaseOut);

  //                   Navigator.pop(contextt);
  //                 },
  //                 child: Container(
  //                   width: Screens.width(contextt) * 0.22,
  //                   alignment: Alignment.center,
  //                   decoration: BoxDecoration(
  //                       color: theme.primaryColor,
  //                       borderRadius: BorderRadius.circular(3),
  //                       border: Border.all(
  //                         color: theme.primaryColor,
  //                       )),
  //                   height: Screens.bodyheight(contextt) * 0.05,
  //                   child: Text("Yes",
  //                       style: theme.textTheme.bodyText2?.copyWith(
  //                         color: Colors.white,
  //                       )),
  //                 )),
  //             GestureDetector(
  //                 onTap: () {
  //                   Navigator.pop(contextt);
  //                 },
  //                 child: Container(
  //                   width: Screens.width(contextt) * 0.22,
  //                   alignment: Alignment.center,
  //                   decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(3),
  //                       color: theme.primaryColor,
  //                       border: Border.all(
  //                         color: theme.primaryColor,
  //                       )),
  //                   height: Screens.bodyheight(contextt) * 0.05,
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
                    stOutCon.suspendedbutton(
                        index, context, theme, data, datatotal![index]);

                    // stOutCon.page.animateToPage(--stOutCon.pageIndex,
                    //     duration: Duration(milliseconds: 1400),
                    //     curve: Curves.linearToEaseOut);

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
