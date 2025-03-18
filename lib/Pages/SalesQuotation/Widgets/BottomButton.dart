import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import 'package:provider/provider.dart';
import '../../../Controller/SalesQuotationController/SalesQuotationController.dart';
import '../../../Widgets/ContentContainer.dart';

class SQBottomButtons extends StatefulWidget {
  SQBottomButtons(
      {super.key,
      required this.theme,
      required this.btnWidth,
      required this.btnheight});

  final ThemeData theme;
  double btnheight;
  double btnWidth;

  @override
  State<SQBottomButtons> createState() => SQBottomButtonsState();
}

class SQBottomButtonsState extends State<SQBottomButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: Screens.width(context) * 0.01),
      height: widget.btnheight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(widget.btnheight * 0.01),
                child: Text(
                  context.read<SalesQuotationCon>().getpaymentWay.isNotEmpty
                      ? "Payment Method"
                      : '',
                  textAlign: TextAlign.start,
                  style: widget.theme.textTheme.bodyLarge?.copyWith(
                    color: widget.theme.primaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: widget.btnheight * 0.6,
                child: context
                        .read<SalesQuotationCon>()
                        .getpaymentWay2
                        .isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: context
                            .watch<SalesQuotationCon>()
                            .getpaymentWay2
                            .length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Card(
                              elevation: 2,
                              child: Container(
                                  padding: EdgeInsets.only(
                                    right: widget.btnheight * 0.03,
                                    left: widget.btnheight * 0.03,
                                    bottom: widget.btnheight * 0.03,
                                    top: widget.btnheight * 0.03,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: widget.btnWidth * 0.25,
                                        child: Text(
                                          '${context.watch<SalesQuotationCon>().getpaymentWay2[index].type}',
                                          style: widget
                                              .theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        width: widget.btnWidth * 0.28,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '${context.watch<SalesQuotationCon>().getpaymentWay2[index].reference}',
                                          style: widget
                                              .theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          context
                                              .read<SalesQuotationCon>()
                                              .config
                                              .splitValues(context
                                                  .read<SalesQuotationCon>()
                                                  .getpaymentWay2[index]
                                                  .amt!
                                                  .toStringAsFixed(2)),
                                          style: widget
                                              .theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black),
                                        ),
                                      ),
                                      context
                                              .read<SalesQuotationCon>()
                                              .getpaymentWay2
                                              .isNotEmpty
                                          ? Container(
                                              width: widget.btnWidth * 0.05,
                                            )
                                          : InkWell(
                                              onTap: () {},
                                              child: SizedBox(
                                                width: widget.btnWidth * 0.05,
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            )
                                    ],
                                  )),
                            ),
                          );
                        })
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: context
                            .watch<SalesQuotationCon>()
                            .getpaymentWay
                            .length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Card(
                              elevation: 2,
                              child: Container(
                                  padding: EdgeInsets.only(
                                    right: widget.btnheight * 0.03,
                                    left: widget.btnheight * 0.03,
                                    bottom: widget.btnheight * 0.03,
                                    top: widget.btnheight * 0.03,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: widget.btnWidth * 0.25,
                                        child: Text(
                                          '${context.read<SalesQuotationCon>().getpaymentWay[index].type}',
                                          style: widget
                                              .theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        width: widget.btnWidth * 0.28,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '${context.read<SalesQuotationCon>().getpaymentWay[index].reference}',
                                          style: widget
                                              .theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          context
                                              .read<SalesQuotationCon>()
                                              .config
                                              .splitValues(context
                                                  .read<SalesQuotationCon>()
                                                  .getpaymentWay[index]
                                                  .amt!
                                                  .toStringAsFixed(2)),
                                          style: widget
                                              .theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {});
                                        },
                                        child: SizedBox(
                                          width: widget.btnWidth * 0.05,
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          );
                        }),
              ),
            ],
          ),
          context.watch<SalesQuotationCon>().editqty == true
              ? Center(
                  child: SizedBox(
                    width: widget.btnWidth * 0.18,
                    height: widget.btnheight * 0.2,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.theme.primaryColor,
                        ),
                        onPressed: context
                                    .read<SalesQuotationCon>()
                                    .onDisablebutton ==
                                true
                            ? null
                            : () {
                                context
                                    .read<SalesQuotationCon>()
                                    .validateAndCallApi(context, widget.theme);
                                // context
                                //     .read<SalesQuotationCon>()
                                //     .validateUpdate(context, widget.theme);

                                context
                                    .read<SalesQuotationCon>()
                                    .disableKeyBoard(context);
                              },
                        child: Text(
                          "Update",
                          style: widget.theme.textTheme.bodyMedium!
                              .copyWith(color: Colors.white),
                        )),
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(
                    widget.btnheight * 0.01,
                  ),
                  child: context.read<SalesQuotationCon>().selectedcust2 != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                padding: EdgeInsets.all(
                                  widget.btnheight * 0.01,
                                ),
                                child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        // context
                                        //     .read<SalesQuotationCon>()
                                        //     .onDisablebutton = true;

                                        context
                                            .read<SalesQuotationCon>()
                                            .clickacancelbtn(
                                                context, widget.theme);
                                      });
                                    },
                                    child: Container(
                                        width: widget.btnWidth * 0.2,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: widget.theme.primaryColor
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: widget.theme.primaryColor,
                                            )),
                                        height: widget.btnheight * 0.15,
                                        child:
                                            // context
                                            //             .watch<SalesQuotationCon>()
                                            //             .cancelbtn ==
                                            //         false
                                            //     ?
                                            Text("Cancel",
                                                textAlign: TextAlign.center,
                                                style: widget
                                                    .theme.textTheme.bodySmall
                                                    ?.copyWith(
                                                  color: Colors.black,
                                                ))
                                        // : CircularProgressIndicator(
                                        // color: widget.theme.primaryColor),
                                        ))),
                            Container(
                                padding: EdgeInsets.all(
                                  widget.btnheight * 0.01,
                                ),
                                child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        context
                                            .read<SalesQuotationCon>()
                                            .clickaEditBtn(
                                                context, widget.theme);
                                      });
                                    },
                                    child: Container(
                                      width: widget.btnWidth * 0.2,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: widget.theme.primaryColor
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: widget.theme.primaryColor,
                                          )),
                                      height: widget.btnheight * 0.15,
                                      child: Text("Edit",
                                          textAlign: TextAlign.center,
                                          style: widget
                                              .theme.textTheme.bodySmall
                                              ?.copyWith(
                                            color: Colors.black,
                                          )),
                                    ))),
                            Container(
                                padding: EdgeInsets.all(
                                  widget.btnheight * 0.01,
                                ),
                                child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        context
                                            .read<SalesQuotationCon>()
                                            .callClearBtn();
                                      });
                                    },
                                    child: Container(
                                      width: widget.btnWidth * 0.2,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: widget.theme.primaryColor,
                                        ),
                                        color: widget.theme.primaryColor
                                            .withOpacity(0.1),
                                        // color: Colors.grey[400],
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      height: widget.btnheight * 0.15,
                                      child: Text("Clear",
                                          textAlign: TextAlign.center,
                                          style: widget
                                              .theme.textTheme.bodySmall
                                              ?.copyWith(
                                            color: Colors.black,
                                          )),
                                    ))),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: widget.btnheight * 0.2,
                              width: widget.btnWidth * 0.2,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: BorderSide(
                                        color: widget.theme.primaryColor,
                                      )),
                                  onPressed: context
                                              .read<SalesQuotationCon>()
                                              .onDisablebutton ==
                                          true
                                      ? null
                                      : () {
                                          context
                                                  .read<SalesQuotationCon>()
                                                  .onDisablebutton ==
                                              true;
                                          if (context
                                                      .read<SalesQuotationCon>()
                                                      .getselectedcust ==
                                                  null &&
                                              context
                                                  .read<SalesQuotationCon>()
                                                  .getScanneditemData
                                                  .isEmpty) {
                                            showDialog(
                                                context: context,
                                                barrierDismissible: true,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      content: AlertBox(
                                                        payMent: 'Alert',
                                                        errormsg: true,
                                                        widget: Center(
                                                            child:
                                                                ContentContainer(
                                                          content:
                                                              'Choose the Customer or Product',
                                                          theme: widget.theme,
                                                        )),
                                                        buttonName: null,
                                                      ));
                                                }).then((value) {
                                              context
                                                      .read<SalesQuotationCon>()
                                                      .onDisablebutton ==
                                                  false;
                                            });
                                          } else {
                                            showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      content: forSuspend(
                                                          context,
                                                          widget.theme));
                                                }).then((value) {
                                              context
                                                      .read<SalesQuotationCon>()
                                                      .onDisablebutton ==
                                                  false;
                                            });
                                          }
                                          context
                                              .read<SalesQuotationCon>()
                                              .disableKeyBoard(context);
                                          context
                                                  .read<SalesQuotationCon>()
                                                  .onDisablebutton ==
                                              false;
                                        },
                                  child: Text(
                                    "Clear All",
                                    style: widget.theme.textTheme.bodyMedium!
                                        .copyWith(
                                            color: widget.theme.primaryColor),
                                  )),
                            ),
                            SizedBox(
                              height: widget.btnheight * 0.2,
                              width: widget.btnWidth * 0.2,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: BorderSide(
                                        color: widget.theme.primaryColor,
                                      )),
                                  onPressed: context
                                              .read<SalesQuotationCon>()
                                              .onDisablebutton ==
                                          true
                                      ? null
                                      : () {
                                          context
                                              .read<SalesQuotationCon>()
                                              .onHoldClicked(
                                                  context, widget.theme);
                                          context
                                              .read<SalesQuotationCon>()
                                              .disableKeyBoard(context);
                                        },
                                  child: Text(
                                    "Hold",
                                    style: widget.theme.textTheme.bodyMedium!
                                        .copyWith(
                                            color: widget.theme.primaryColor),
                                  )),
                            ),
                            SizedBox(
                              width: widget.btnWidth * 0.2,
                              height: widget.btnheight * 0.2,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: widget.theme.primaryColor,
                                  ),
                                  onPressed: context
                                              .read<SalesQuotationCon>()
                                              .onDisablebutton ==
                                          true
                                      ? null
                                      : () {
                                          context
                                              .read<SalesQuotationCon>()
                                              .changecheckout(
                                                  context, widget.theme);

                                          context
                                              .read<SalesQuotationCon>()
                                              .disableKeyBoard(context);
                                        },
                                  child: Text(
                                    "Save",
                                    style: widget.theme.textTheme.bodyMedium!
                                        .copyWith(color: Colors.white),
                                  )),
                            ),
                          ],
                        ),
                ),
        ],
      ),
    );
  }

  forSuspend(BuildContext context, ThemeData theme) {
    return Container(
        width: widget.btnWidth * 0.7,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: widget.btnheight * 0.15,
              color: theme.primaryColor,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: widget.btnWidth * 0.1),
                    alignment: Alignment.center,
                    width: widget.btnWidth * 0.6,
                    child: Text(
                      'Clear All',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        Get.back();
                      });
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: widget.btnheight * 0.02,
            ),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: widget.btnWidth * 0.02,
                    vertical: widget.btnheight * 0.005),
                // height: widget.btnheight * 0.2,
                child: const Center(
                    child: Text(
                        "You about to suspended all information will be unsaved  "))),
            SizedBox(
              height: widget.btnheight * 0.02,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: widget.btnWidth * 0.02,
                  vertical: widget.btnheight * 0.005),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: Screens.width(context) * 0.1,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          context
                              .read<SalesQuotationCon>()
                              .clearSuspendedData(context, theme);
                        },
                        child: const Text("Yes")),
                  ),
                  SizedBox(
                    width: Screens.width(context) * 0.1,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("No")),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
