import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../../../Constant/Screen.dart';
import '../../../Controller/SalesReturnController/SalesReturnController.dart';

class ReturnApprovals extends StatefulWidget {
  ReturnApprovals({
    super.key,
    required this.theme,
    required this.searchHeight,
    required this.searchWidth,
  });

  final ThemeData theme;
  double searchHeight;
  double searchWidth;

  @override
  State<ReturnApprovals> createState() => SearhBoxState();
}

class SearhBoxState extends State<ReturnApprovals> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        insetPadding: const EdgeInsets.all(10),
        contentPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        content: Stack(
          children: [
            SizedBox(
                width: widget.searchWidth * 2,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          width: widget.searchWidth,
                          padding: EdgeInsets.all(widget.searchHeight * 0.01),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Form(
                                    key: context
                                        .watch<SalesReturnController>()
                                        .approvalformkey[0],
                                    child: Row(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              width: widget.searchWidth * 0.08,
                                              child: const Text("From Date"),
                                            ),
                                            Container(
                                              height:
                                                  widget.searchHeight * 0.07,
                                              width: widget.searchWidth * 0.15,
                                              decoration: const BoxDecoration(),
                                              child: TextFormField(
                                                controller: context
                                                    .read<
                                                        SalesReturnController>()
                                                    .mycontroller[102],
                                                readOnly: true,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Required";
                                                  }
                                                  null;
                                                  return null;
                                                },
                                                onTap: () {
                                                  context
                                                      .read<
                                                          SalesReturnController>()
                                                      .getAprvlDate2(
                                                          context, 'From');
                                                },
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            vertical: 5.0,
                                                            horizontal: 5.0),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                    hintText: "",
                                                    hintStyle: widget.theme
                                                        .textTheme.bodyLarge!
                                                        .copyWith(
                                                            color:
                                                                Colors.black),
                                                    suffixIcon: const Icon(
                                                        Icons.calendar_today)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: Screens.width(context) * 0.02,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              width: widget.searchWidth * 0.08,
                                              child: const Text("To Date"),
                                            ),
                                            Container(
                                              height:
                                                  widget.searchHeight * 0.07,
                                              width: widget.searchWidth * 0.15,
                                              decoration: const BoxDecoration(),
                                              child: TextFormField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Required";
                                                  }
                                                  null;
                                                  return null;
                                                },
                                                readOnly: true,
                                                controller: context
                                                    .read<
                                                        SalesReturnController>()
                                                    .mycontroller[103],
                                                onTap: () {
                                                  context
                                                      .read<
                                                          SalesReturnController>()
                                                      .getAprvlDate2(
                                                          context, 'To');
                                                },
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            vertical: 5.0,
                                                            horizontal: 5.0),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                    hintText: "",
                                                    hintStyle: widget.theme
                                                        .textTheme.bodyLarge!
                                                        .copyWith(
                                                            color:
                                                                Colors.black),
                                                    suffixIcon: const Icon(
                                                        Icons.calendar_today)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (context
                                            .read<SalesReturnController>()
                                            .approvalformkey[0]
                                            .currentState!
                                            .validate()) {
                                          if (context
                                                  .read<SalesReturnController>()
                                                  .groupValueSelected ==
                                              0) {
                                            context
                                                .read<SalesReturnController>()
                                                .callPendingApprovalapi(
                                                    context);
                                          } else if (context
                                                  .read<SalesReturnController>()
                                                  .groupValueSelected ==
                                              1) {
                                            context
                                                .read<SalesReturnController>()
                                                .callRejectedAPi(context);
                                          }
                                        }
                                      });
                                    },
                                    child: Container(
                                      height: widget.searchHeight * 0.07,
                                      width: widget.searchWidth * 0.08,
                                      decoration: BoxDecoration(
                                          color: widget.theme.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: const Icon(
                                        Icons.search,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: widget.searchHeight * 0.07,
                                        width: widget.searchWidth * 0.25,
                                        decoration: const BoxDecoration(),
                                        child: TextFormField(
                                          onChanged: (value) {
                                            setState(() async {
                                              if (context
                                                      .read<
                                                          SalesReturnController>()
                                                      .groupValueSelected ==
                                                  0) {
                                                context
                                                    .read<
                                                        SalesReturnController>()
                                                    .filterAprvlBoxList(
                                                        value.trim());
                                              } else if (context
                                                      .read<
                                                          SalesReturnController>()
                                                      .groupValueSelected ==
                                                  1) {
                                                context
                                                    .read<
                                                        SalesReturnController>()
                                                    .filterPendingAprvlBoxList(
                                                        (value.trim()));
                                              } else if (context
                                                      .read<
                                                          SalesReturnController>()
                                                      .groupValueSelected ==
                                                  2) {
                                                context
                                                    .read<
                                                        SalesReturnController>()
                                                    .filterRejectedBoxList(
                                                        (value.trim()));
                                              }
                                            });
                                          },
                                          decoration: InputDecoration(
                                              hintText: "Search...",
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 10.0),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              hintStyle: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: Colors.black)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: widget.searchHeight * 0.01,
                              ),
                            ],
                          )),
                      Container(
                        height: Screens.padingHeight(context) * 0.05,
                        child: CupertinoSlidingSegmentedControl<int>(
                          backgroundColor: Colors.grey,
                          padding: const EdgeInsets.all(0),
                          thumbColor: widget.theme.primaryColor,
                          groupValue: context
                              .read<SalesReturnController>()
                              .groupValueSelected,
                          children: {
                            0: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.1,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 5),
                              child: Text(
                                'Pending',
                                style: widget.theme.textTheme.bodyLarge
                                    ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                              ),
                            ),
                            1: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.1,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 5),
                              child: Text(
                                'Rejected',
                                style: widget.theme.textTheme.bodyLarge
                                    ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                              ),
                            ),
                          },
                          onValueChanged: (v) {
                            setState(() {
                              context
                                  .read<SalesReturnController>()
                                  .groupSelectvalue(v!);
                              log('Selete taggle::$v');
                            });
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            right: widget.searchWidth * 0.01,
                            left: widget.searchWidth * 0.01),
                        decoration: BoxDecoration(
                            color: widget.theme.primaryColor,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.white)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: widget.searchWidth * 0.09,
                              child: Text(
                                "Customer Code",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.18,
                              child: Text(
                                "Customer Name",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.12,
                              child: Text(
                                "Draft Docentry",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.08,
                              child: Text(
                                "Doc Date",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.1,
                              child: Text(
                                "Doc Total",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.1,
                              child: Text(
                                "UserName",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      context
                                  .read<SalesReturnController>()
                                  .groupValueSelected ==
                              0
                          ? Container(
                              height: widget.searchHeight * 0.87,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: context
                                      .watch<SalesReturnController>()
                                      .filterPendingApprovalData
                                      .isEmpty
                                  ? const Center(
                                      child: Text("No Data Here..!!"),
                                    )
                                  : ListView.builder(
                                      itemCount: context
                                          .watch<SalesReturnController>()
                                          .filterPendingApprovalData
                                          .length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: EdgeInsets.only(
                                              top: widget.searchHeight * 0.03,
                                              left: widget.searchHeight * 0.02,
                                              right: widget.searchHeight * 0.02,
                                              bottom:
                                                  widget.searchHeight * 0.03),
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.05),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.grey[300]!)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                width: widget.searchWidth * 0.1,
                                                child: Text(
                                                  "${context.watch<SalesReturnController>().filterPendingApprovalData[index].cardCode}",
                                                  style: widget.theme.textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                          color: Colors.black),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width:
                                                    widget.searchWidth * 0.18,
                                                child: Text(
                                                  "${context.watch<SalesReturnController>().filterPendingApprovalData[index].cardName}",
                                                  style: widget.theme.textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                          color: Colors.black),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                width:
                                                    widget.searchWidth * 0.13,
                                                child: Text(
                                                  "${context.watch<SalesReturnController>().filterPendingApprovalData[index].draftEntry}",
                                                  style: widget.theme.textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                          color: Colors.black),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                width:
                                                    widget.searchWidth * 0.08,
                                                child: Text(
                                                  context
                                                      .watch<
                                                          SalesReturnController>()
                                                      .config
                                                      .alignDate(context
                                                          .read<
                                                              SalesReturnController>()
                                                          .filterPendingApprovalData[
                                                              index]
                                                          .docDate!),
                                                  style: widget.theme.textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                          color: Colors.black),
                                                ),
                                              ),
                                              Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                width: widget.searchWidth * 0.1,
                                                child: Text(
                                                  "${context.watch<SalesReturnController>().filterPendingApprovalData[index].DocTotal ?? 0}",
                                                  style: widget.theme.textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                          color: Colors.black),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                width: widget.searchWidth * 0.1,
                                                child: Text(
                                                  "${context.watch<SalesReturnController>().filterPendingApprovalData[index].fromUser}",
                                                  style: widget.theme.textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                          color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                            )
                          : context
                                      .read<SalesReturnController>()
                                      .groupValueSelected ==
                                  1
                              ? Container(
                                  height: widget.searchHeight * 0.87,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: context
                                          .watch<SalesReturnController>()
                                          .filterRejectedData
                                          .isEmpty
                                      ? const Center(
                                          child: Text("No Data Here..!!"),
                                        )
                                      : ListView.builder(
                                          itemCount: context
                                              .watch<SalesReturnController>()
                                              .filterRejectedData
                                              .length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () async {
                                                setState(() {});
                                              },
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    top: widget.searchHeight *
                                                        0.03,
                                                    left: widget.searchHeight *
                                                        0.02,
                                                    right: widget.searchHeight *
                                                        0.02,
                                                    bottom:
                                                        widget.searchHeight *
                                                            0.03),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey
                                                        .withOpacity(0.05),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        color:
                                                            Colors.grey[300]!)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width:
                                                          widget.searchWidth *
                                                              0.1,
                                                      child: Text(
                                                        "${context.watch<SalesReturnController>().filterRejectedData[index].cardCode}",
                                                        style: widget
                                                            .theme
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      width:
                                                          widget.searchWidth *
                                                              0.2,
                                                      child: Text(
                                                        "${context.watch<SalesReturnController>().filterRejectedData[index].cardName}",
                                                        style: widget
                                                            .theme
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width:
                                                          widget.searchWidth *
                                                              0.13,
                                                      child: Text(
                                                        "${context.watch<SalesReturnController>().filterRejectedData[index].draftEntry}",
                                                        style: widget
                                                            .theme
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width:
                                                          widget.searchWidth *
                                                              0.08,
                                                      child: Text(
                                                        context
                                                            .watch<
                                                                SalesReturnController>()
                                                            .config
                                                            .alignDate(context
                                                                .read<
                                                                    SalesReturnController>()
                                                                .filterRejectedData[
                                                                    index]
                                                                .docDate!),
                                                        style: widget
                                                            .theme
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      width:
                                                          widget.searchWidth *
                                                              0.1,
                                                      child: Text(
                                                        "${context.watch<SalesReturnController>().filterRejectedData[index].DocTotal ?? 0}",
                                                        style: widget
                                                            .theme
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width:
                                                          widget.searchWidth *
                                                              0.1,
                                                      child: Text(
                                                        "${context.watch<SalesReturnController>().filterRejectedData[index].fromUser}",
                                                        style: widget
                                                            .theme
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                )
                              : Container()
                    ],
                  ),
                )),
            Visibility(
              visible: context.watch<SalesReturnController>().clickAprList,
              child: Container(
                width: Screens.width(context),
                height: Screens.bodyheight(context) * 0.95,
                color: Colors.white60,
                child: Center(
                  child: SpinKitFadingCircle(
                    size: Screens.bodyheight(context) * 0.08,
                    color: widget.theme.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
