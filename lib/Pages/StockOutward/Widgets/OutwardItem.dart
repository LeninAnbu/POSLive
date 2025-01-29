import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../Constant/Screen.dart';
import '../../../Controller/StockOutwardController/StockOutwardController.dart';
import '../../../Models/DataModel/StockOutwardModel/StockOutwardListModel.dart';

stockOutward(
    ThemeData theme,
    double stockInWidth,
    double stockInheight,
    int index,
    List<StockOutwardDetails>? data,
    List<StockOutwardList>? datatotal,
    BuildContext context) {
  log('indexindex::${index.toString()}');
  final theme = Theme.of(context);
  return StatefulBuilder(builder: (context, st) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: stockInheight * 0.01,
            left: stockInheight * 0.01,
            right: stockInheight * 0.01,
            bottom: stockInheight * 0.01,
          ),
          decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5))),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            InkWell(
              onTap: () {
                context.read<StockOutwardController>().deleteoutdata();
              },
              child: SizedBox(
                  width: stockInWidth * 0.5,
                  child: Text(
                    'Item Name',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: Colors.white),
                  )),
            ),
            Container(
                alignment: Alignment.center,
                width: stockInWidth * 0.15,
                child: Text(
                  'Requested Quantity',
                  style:
                      theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
                )),
            Container(
                alignment: Alignment.center,
                width: stockInWidth * 0.15,
                child: Text(
                  'Transfered Quantity',
                  style:
                      theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
                )),
            Container(
                alignment: Alignment.center,
                width: stockInWidth * 0.15,
                child: Text(
                  'Scanned Quantity',
                  style:
                      theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
                ))
          ]),
        ),
        Container(
          height: stockInheight * 0.77,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: context.read<StockOutwardController>().StockOutward2.isNotEmpty
              ? ListView.builder(
                  itemCount: context
                      .watch<StockOutwardController>()
                      .StockOutward2[0]
                      .data
                      .length,
                  itemBuilder: (context, i) {
                    return Card(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.only(
                            top: stockInheight * 0.008,
                            left: stockInheight * 0.01,
                            right: stockInheight * 0.01,
                            bottom: stockInheight * 0.01,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: Screens.width(context) * 0.001,
                              color: Colors.white,
                            ),
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: stockInWidth * 0.5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${context.watch<StockOutwardController>().StockOutward2[0].data[i].itemcode}",
                                          style: theme.textTheme.bodyLarge,
                                        ),
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              " ${context.watch<StockOutwardController>().StockOutward2[0].data[i].serialBatch}",
                                              style: theme.textTheme.bodyLarge,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: stockInWidth * 0.15,
                                    child: Text(
                                      "${context.watch<StockOutwardController>().StockOutward2[0].data[i].qty}",
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: stockInWidth * 0.15,
                                    child: Text(
                                      "${context.watch<StockOutwardController>().StockOutward2[0].data[i].trans_Qty}",
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: stockInWidth * 0.15,
                                    child: context
                                                .watch<StockOutwardController>()
                                                .StockOutward2[0]
                                                .data[i]
                                                .Scanned_Qty !=
                                            null
                                        ? Text(
                                            "${context.watch<StockOutwardController>().StockOutward2[0].data[i].Scanned_Qty}",
                                            style: theme.textTheme.bodyLarge,
                                          )
                                        : Container(),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    );
                  })
              : ListView.builder(
                  itemCount: data!.length,
                  controller:
                      context.read<StockOutwardController>().scrollController,
                  itemBuilder: (context, i) {
                    return data.isEmpty
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Card(
                            child: InkWell(
                              onTap: () {
                                context
                                    .read<StockOutwardController>()
                                    .noMsgText = '';
                                log(' StockOutward[index].dataxx:::${context.read<StockOutwardController>().StockOutward[index].data.length}');
                                context
                                    .read<StockOutwardController>()
                                    .itemCode = data[i].itemcode.toString();
                                context
                                    .read<StockOutwardController>()
                                    .valPass(data[i].Scanned_Qty!);

                                context
                                    .read<StockOutwardController>()
                                    .StOutController[0]
                                    .text = "";
                                context
                                    .read<StockOutwardController>()
                                    .ScannigVal = data[i].Scanned_Qty!;
                                context
                                    .read<StockOutwardController>()
                                    .Selectindex2(i);
                                context
                                    .read<StockOutwardController>()
                                    .passindexBachPage(index, i, data[i]);
                                context
                                    .read<StockOutwardController>()
                                    .isselectmethod();
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                  top: stockInheight * 0.008,
                                  left: stockInheight * 0.01,
                                  right: stockInheight * 0.01,
                                  bottom: stockInheight * 0.01,
                                ),
                                decoration: BoxDecoration(
                                  color: data[i].Scanned_Qty != 0 &&
                                          data[i].qty !=
                                              (data[i].Scanned_Qty! +
                                                  data[i].trans_Qty!)
                                      ? const Color(0xFFfcedee)
                                      : data[i].Scanned_Qty != 0 &&
                                              data[i].qty ==
                                                  (data[i].Scanned_Qty! +
                                                      data[i].trans_Qty!)
                                          ? const Color(0xFFebfaef)
                                          : data[i].Scanned_Qty == 0 &&
                                                  data[i].qty !=
                                                      data[i].Scanned_Qty!
                                              ? Colors.grey.withOpacity(0.04)
                                              : Colors.grey.withOpacity(0.04),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    width: Screens.width(context) * 0.001,
                                    color: data[i].Scanned_Qty != 0 &&
                                            data[i].qty !=
                                                (data[i].Scanned_Qty! +
                                                    data[i].trans_Qty!)
                                        ? Colors.red.withOpacity(0.3)
                                        : data[i].Scanned_Qty != 0 &&
                                                data[i].qty ==
                                                    (data[i].Scanned_Qty! +
                                                        data[i].trans_Qty!)
                                            ? Colors.green.withOpacity(0.3)
                                            : data[i].Scanned_Qty == 0 &&
                                                    data[i].qty !=
                                                        (data[i].Scanned_Qty! +
                                                            data[i].trans_Qty!)
                                                ? Colors.white
                                                : Colors.white,
                                  ),
                                ),
                                child: IntrinsicHeight(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: stockInWidth * 0.5,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${data[i].itemcode}",
                                                style:
                                                    theme.textTheme.bodyLarge,
                                              ),
                                              Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    " ",
                                                    style: theme
                                                        .textTheme.bodyLarge,
                                                  ))
                                            ],
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: stockInWidth * 0.15,
                                          child: Text(
                                            "${data[i].qty}",
                                            style: theme.textTheme.bodyLarge,
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: stockInWidth * 0.15,
                                          child: Text(
                                            "${data[i].trans_Qty}",
                                            style: theme.textTheme.bodyLarge,
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: stockInWidth * 0.15,
                                          child: Text(
                                            "${data[i].Scanned_Qty}",
                                            style: theme.textTheme.bodyLarge,
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                            ),
                          );
                  }),
        ),
        SizedBox(
          height: stockInheight * 0.008,
        ),
        Container(
          padding: EdgeInsets.only(
            top: stockInheight * 0.01,
            left: stockInheight * 0.01,
            right: stockInheight * 0.01,
            bottom: stockInheight * 0.01,
          ),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5))),
          child:
              context.watch<StockOutwardController>().StockOutward2.isNotEmpty
                  ? Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: TextFormField(
                        controller: context
                            .read<StockOutwardController>()
                            .StOutController2[50],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyMedium?.copyWith(),
                        onChanged: (v) {},
                        readOnly: true,
                        decoration: InputDecoration(
                          filled: false,
                          labelText: "Remarks",
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: TextFormField(
                        controller: context
                            .read<StockOutwardController>()
                            .StOutController[50],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyMedium?.copyWith(),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ' Please Enter the Remark';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Remarks",
                          filled: false,
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
        ),
        Container(
          padding: EdgeInsets.only(
            top: stockInheight * 0.01,
            left: stockInheight * 0.01,
            right: stockInheight * 0.01,
            bottom: stockInheight * 0.01,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          height: stockInheight * 0.095,
          child: context
                  .watch<StockOutwardController>()
                  .StockOutward2
                  .isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // GestureDetector(
                    //     onTap: () {
                    //       st(() {
                    //         context.read<StockOutwardController>().cancelbtn =
                    //             true;
                    //         context
                    //             .read<StockOutwardController>()
                    //             .clickcancelbtn(context, theme);
                    //       });
                    //     },
                    //     child: Container(
                    //       alignment: Alignment.center,
                    //       decoration: BoxDecoration(
                    //         color: Colors.grey[400],
                    //         borderRadius: BorderRadius.circular(5),
                    //       ),
                    //       height: stockInheight * 0.9,
                    //       width: stockInWidth * 0.25,
                    //       child: context
                    //                   .watch<StockOutwardController>()
                    //                   .cancelbtn ==
                    //               false
                    //           ? Text("Cancel",
                    //               textAlign: TextAlign.center,
                    //               style: theme.textTheme.bodySmall?.copyWith(
                    //                 color: Colors.black,
                    //               ))
                    //           : CircularProgressIndicator(
                    //               color: theme.primaryColor),
                    //     )),
                    GestureDetector(
                        onTap: () {
                          st(() {
                            context.read<StockOutwardController>().cancelbtn =
                                false;
                            context
                                .read<StockOutwardController>()
                                .StockOutward
                                .clear();
                            context
                                .read<StockOutwardController>()
                                .StockOutward2
                                .clear();
                            context
                                .read<StockOutwardController>()
                                .selectedcust2 = null;
                            context
                                .read<StockOutwardController>()
                                .getStockReqData();
                            context
                                .read<StockOutwardController>()
                                .StOutController2[50]
                                .text = "";
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: stockInheight * 0.9,
                          width: stockInWidth * 0.25,
                          child: Text("Clear",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.black,
                              )),
                        )),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: stockInheight * 0.9,
                      width: stockInWidth * 0.25,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                color: theme.primaryColor,
                              )),
                          onPressed: context
                                      .read<StockOutwardController>()
                                      .OnclickDisable ==
                                  true
                              ? null
                              : () {
                                  context
                                      .read<StockOutwardController>()
                                      .OnclickDisable = true;
                                  if (datatotal!.isEmpty &&
                                      context
                                              .read<StockOutwardController>()
                                              .selectedcust ==
                                          null) {
                                    st(
                                      () {
                                        Get.defaultDialog(
                                                title: "Alert",
                                                middleText: 'No Data Found..!!',
                                                backgroundColor: Colors.white,
                                                titleStyle: theme
                                                    .textTheme.bodyLarge!
                                                    .copyWith(
                                                        color: Colors.red),
                                                middleTextStyle:
                                                    theme.textTheme.bodyLarge,
                                                actions: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      TextButton(
                                                        child:
                                                            const Text("Close"),
                                                        onPressed: () =>
                                                            Get.back(),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                                radius: 5)
                                            .then((value) {
                                          context
                                              .read<StockOutwardController>()
                                              .OnclickDisable = false;
                                        });
                                      },
                                    );
                                  } else {
                                    st(
                                      () {
                                        forSuspend(context, theme, index, data!,
                                            datatotal);
                                      },
                                    );
                                  }

                                  context
                                      .read<StockOutwardController>()
                                      .disableKeyBoard(context);
                                  context
                                      .read<StockOutwardController>()
                                      .OnclickDisable = false;
                                },
                          child: Text(
                            "Clear All",
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: theme.primaryColor),
                          )),
                    ),
                    SizedBox(
                      height: stockInheight * 0.9,
                      width: stockInWidth * 0.25,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                color: theme.primaryColor,
                              )),
                          onPressed: context
                                      .read<StockOutwardController>()
                                      .OnclickDisable ==
                                  true
                              ? null
                              : () {
                                  if (datatotal!.isEmpty &&
                                      context
                                              .read<StockOutwardController>()
                                              .selectedcust ==
                                          null) {
                                    context
                                        .read<StockOutwardController>()
                                        .OnclickDisable = true;
                                    Get.defaultDialog(
                                            title: "Alert",
                                            middleText: 'No Data Found..!!',
                                            backgroundColor: Colors.white,
                                            titleStyle: theme
                                                .textTheme.bodyLarge!
                                                .copyWith(color: Colors.red),
                                            middleTextStyle:
                                                theme.textTheme.bodyLarge,
                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                    child: const Text("Close"),
                                                    onPressed: () => Get.back(),
                                                  ),
                                                ],
                                              ),
                                            ],
                                            radius: 5)
                                        .then((value) {
                                      context
                                          .read<StockOutwardController>()
                                          .OnclickDisable = false;
                                    });
                                  } else if (data!.isEmpty) {
                                    context
                                        .read<StockOutwardController>()
                                        .OnclickDisable = true;
                                    Get.defaultDialog(
                                            title: "Alert",
                                            middleText:
                                                'Please Choose Item..!!',
                                            backgroundColor: Colors.white,
                                            titleStyle: theme
                                                .textTheme.bodyLarge!
                                                .copyWith(color: Colors.red),
                                            middleTextStyle:
                                                theme.textTheme.bodyLarge,
                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                    child: const Text("Close"),
                                                    onPressed: () => Get.back(),
                                                  ),
                                                ],
                                              ),
                                            ],
                                            radius: 5)
                                        .then((value) {
                                      context
                                          .read<StockOutwardController>()
                                          .OnclickDisable = false;
                                    });
                                  } else {
                                    context
                                        .read<StockOutwardController>()
                                        .OnclickDisable = true;

                                    context
                                        .read<StockOutwardController>()
                                        .holdbutton(index, context, theme, data,
                                            datatotal[index]);
                                  }
                                  context
                                      .read<StockOutwardController>()
                                      .disableKeyBoard(context);
                                },
                          child: Text(
                            "Hold",
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: theme.primaryColor),
                          )),
                    ),
                    SizedBox(
                      height: stockInheight * 0.9,
                      width: stockInWidth * 0.25,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                          ),
                          onPressed: context
                                      .read<StockOutwardController>()
                                      .OnclickDisable ==
                                  false
                              ? () {
                                  context
                                      .read<StockOutwardController>()
                                      .OnclickDisable = true;
                                  if (datatotal!.isEmpty) {
                                    Get.defaultDialog(
                                            title: "Alert",
                                            middleText: 'No Data Found..!!',
                                            backgroundColor: Colors.white,
                                            titleStyle: theme
                                                .textTheme.bodyLarge!
                                                .copyWith(color: Colors.red),
                                            middleTextStyle:
                                                theme.textTheme.bodyLarge,
                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                    child: const Text("Close"),
                                                    onPressed: () => Get.back(),
                                                  ),
                                                ],
                                              ),
                                            ],
                                            radius: 5)
                                        .then((value) {
                                      context
                                          .read<StockOutwardController>()
                                          .OnclickDisable = false;
                                    });
                                  } else if (data!.isEmpty) {
                                    Get.defaultDialog(
                                            title: "Alert",
                                            middleText:
                                                'Please Choose Item..!!',
                                            backgroundColor: Colors.white,
                                            titleStyle: theme
                                                .textTheme.bodyLarge!
                                                .copyWith(color: Colors.red),
                                            middleTextStyle:
                                                theme.textTheme.bodyLarge,
                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                    child: const Text("Close"),
                                                    onPressed: () => Get.back(),
                                                  ),
                                                ],
                                              ),
                                            ],
                                            radius: 5)
                                        .then((value) {
                                      context
                                          .read<StockOutwardController>()
                                          .OnclickDisable = false;
                                    });
                                  } else {
                                    log('StockOutward[index]2222:::${context.read<StockOutwardController>().StockOutward[index].data.length}');

                                    context
                                        .read<StockOutwardController>()
                                        .submitbutton(index, context, theme,
                                            data, datatotal[index]);
                                    context
                                        .read<StockOutwardController>()
                                        .myFuture(context, theme, data);
                                  }
                                  context
                                      .read<StockOutwardController>()
                                      .disableKeyBoard(context);
                                }
                              : null,
                          child: Text(
                            "Submit",
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: Colors.white),
                          )),
                    ),
                  ],
                ),
        )
      ],
    );
  });
}

forSuspend(
  BuildContext context,
  ThemeData theme,
  int index,
  List<StockOutwardDetails>? data,
  List<StockOutwardList>? datatotal,
) {
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
                  context.read<StockOutwardController>().selectedcust = null;
                  context.read<StockOutwardController>().selectedcust2 = null;

                  if (datatotal!.isNotEmpty) {
                    context.read<StockOutwardController>().suspendedbutton(
                        index, context, theme, data, datatotal[index]);
                  }
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
