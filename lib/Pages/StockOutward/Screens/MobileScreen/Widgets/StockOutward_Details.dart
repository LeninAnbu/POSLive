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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: sOutWidth,
          padding: EdgeInsets.all(
            sOutHeigh * 0.01,
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
                width: sOutHeigh * 0.3,
                child: Text("Request From ${datatotal![index].reqfromWhs}"),
              ),
              Container(
                alignment: Alignment.centerRight,
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
                                        Row(children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: sOutWidth * 0.48,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: Text(
                                                  "${data![i].itemcode}",
                                                  style: theme
                                                      .textTheme.bodyMedium!
                                                      .copyWith(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: sOutHeigh * 0.008,
                                              ),
                                              Container(
                                                width: sOutWidth * 0.5,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: Text(
                                                  "${data![i].serialBatch}",
                                                  style: theme
                                                      .textTheme.bodyMedium!
                                                      .copyWith(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              SizedBox(
                                                width: sOutWidth * 0.37,
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
                                                              Alignment.center,
                                                          width:
                                                              sOutWidth * 0.17,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  sOutHeigh *
                                                                      0.006),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4)),
                                                          child: Text(
                                                            "Req.Qty",
                                                            style: theme
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  sOutHeigh *
                                                                      0.005),
                                                          alignment:
                                                              Alignment.center,
                                                          width:
                                                              sOutWidth * 0.15,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4)),
                                                          child: Text(
                                                            "${data![i].qty}",
                                                            style: theme
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width:
                                                              sOutWidth * 0.15,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  sOutHeigh *
                                                                      0.006),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4)),
                                                          child: Text(
                                                            "Tra.Qty",
                                                            style: theme
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  sOutHeigh *
                                                                      0.005),
                                                          alignment:
                                                              Alignment.center,
                                                          width:
                                                              sOutWidth * 0.15,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4)),
                                                          child: Text(
                                                            "${data![i].trans_Qty}",
                                                            style: theme
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                    child: Text(
                                                      "Scanned Qty - ",
                                                      style: theme
                                                          .textTheme.bodySmall!
                                                          .copyWith(
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                    child: Text(
                                                      "${data![i].Scanned_Qty}",
                                                      style: theme
                                                          .textTheme.bodySmall!
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

                              stOutCon.myFuture(context, theme, data);
                            }
                          : null,
                      child: Text("Submittt",
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
                    stOutCon.suspendedbutton(
                        index, context, theme, data, datatotal![index]);

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
