import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../../../Constant/Screen.dart';
import '../../../../Controller/ExpenseController/ExpenseController.dart';

class ExpApprovals extends StatefulWidget {
  ExpApprovals({
    super.key,
    required this.theme,
    required this.searchHeight,
    required this.searchWidth,
  });

  final ThemeData theme;
  double searchHeight;
  double searchWidth;

  @override
  State<ExpApprovals> createState() => SearhBoxState();
}

class SearhBoxState extends State<ExpApprovals> {
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
                //  height:searchHeight*0.9 ,
                child: SingleChildScrollView(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Form(
                            key: context
                                .watch<ExpenseController>()
                                .approvalformkey,
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
                                      height: widget.searchHeight * 0.07,
                                      width: widget.searchWidth * 0.15,
                                      decoration: const BoxDecoration(
                                          // //color: Colors.amber,
                                          //   borderRadius: BorderRadius.circular(4),
                                          //  border: Border.all(),
                                          ),
                                      child:
                                          // Center(child: Text("2023-03-03"))
                                          TextFormField(
                                        controller: context
                                            .read<ExpenseController>()
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
                                              .read<ExpenseController>()
                                              .getAprvlDate2(context, 'From');
                                        },
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 5.0,
                                                    horizontal: 5.0),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            //   labelText: "Date",
                                            hintText: "",
                                            hintStyle: widget
                                                .theme.textTheme.bodyLarge!
                                                .copyWith(color: Colors.black),
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
                                      // color: Colors.blue,
                                      width: widget.searchWidth * 0.08,
                                      child: const Text("To Date"),
                                    ),
                                    Container(
                                      height: widget.searchHeight * 0.07,
                                      width: widget.searchWidth * 0.15,
                                      decoration: const BoxDecoration(
                                          // //color: Colors.amber,
                                          //   borderRadius: BorderRadius.circular(4),
                                          //  border: Border.all(),
                                          ),
                                      child:
                                          // Center(child: Text("2023-03-03"))
                                          TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Required";
                                          }
                                          null;
                                          return null;
                                        },
                                        readOnly: true,
                                        controller: context
                                            .read<ExpenseController>()
                                            .mycontroller[103],
                                        onTap: () {
                                          context
                                              .read<ExpenseController>()
                                              .getAprvlDate2(context, 'To');
                                        },
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 5.0,
                                                    horizontal: 5.0),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            //   labelText: "Date",
                                            hintText: "",
                                            hintStyle: widget
                                                .theme.textTheme.bodyLarge!
                                                .copyWith(color: Colors.black),
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
                                    .read<ExpenseController>()
                                    .approvalformkey
                                    .currentState!
                                    .validate()) {
                                  if (context
                                          .read<ExpenseController>()
                                          .groupValueSelected ==
                                      0) {
                                    //   context
                                    //       .read<ExpenseController>()
                                    //       .callAprvllDataDatewise(
                                    //           (context
                                    //               .read<ExpenseController>()
                                    //               .config
                                    //               .alignDate2(context
                                    //                   .read<ExpenseController>()
                                    //                   .mycontroller[102]
                                    //                   .text
                                    //                   .toString())),
                                    //           context
                                    //               .read<ExpenseController>()
                                    //               .config
                                    //               .alignDate2(context
                                    //                   .read<ExpenseController>()
                                    //                   .mycontroller[103]
                                    //                   .text
                                    //                   .toString()));
                                    // } else if (context
                                    //         .read<ExpenseController>()
                                    //         .groupValueSelected ==
                                    //     1) {
                                    context
                                        .read<ExpenseController>()
                                        .callPendingApprovalapi(context);
                                  } else if (context
                                          .read<ExpenseController>()
                                          .groupValueSelected ==
                                      1) {
                                    context
                                        .read<ExpenseController>()
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
                                  borderRadius: BorderRadius.circular(5)),
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

                                decoration: const BoxDecoration(
                                    // //color: Colors.amber,
                                    //   borderRadius: BorderRadius.circular(4),
                                    //  border: Border.all(),
                                    ),

                                child: TextFormField(
                                  // keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      if (context
                                              .read<ExpenseController>()
                                              .groupValueSelected ==
                                          0) {
                                        context
                                            .read<ExpenseController>()
                                            .filterAprvlBoxList(value.trim());
                                      } else if (context
                                              .read<ExpenseController>()
                                              .groupValueSelected ==
                                          1) {
                                        context
                                            .read<ExpenseController>()
                                            .filterPendingAprvlBoxList(
                                                (value.trim()));
                                      } else if (context
                                              .read<ExpenseController>()
                                              .groupValueSelected ==
                                          2) {
                                        context
                                            .read<ExpenseController>()
                                            .filterRejectedBoxList(
                                                (value.trim()));
                                      }
                                    });
                                  },

                                  // readOnly: true,
                                  //  controller: settleCon.mycontroller[1],
                                  decoration: InputDecoration(
                                      hintText: "Search...",
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10.0),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      //   labelText: "Date",
                                      hintStyle: widget
                                          .theme.textTheme.bodyLarge!
                                          .copyWith(color: Colors.black)),
                                ),
                                //Center(child: Text("2000"))
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: widget.searchHeight * 0.01,
                      ),
                      Container(
                        height: Screens.padingHeight(context) * 0.05,
                        child: CupertinoSlidingSegmentedControl<int>(
                          backgroundColor: Colors.grey,
                          padding: const EdgeInsets.all(0),
                          thumbColor: widget.theme.primaryColor,
                          groupValue: context
                              .read<ExpenseController>()
                              .groupValueSelected,
                          children: {
                            // 0: Container(
                            //   alignment: Alignment.center,
                            //   width: Screens.width(context) * 0.1,
                            //   padding: const EdgeInsets.symmetric(
                            //       vertical: 7, horizontal: 5),
                            //   // height: Screens.padingHeight(context) * 0.05,
                            //   child: Text(
                            //     'Approved',
                            //     style: widget.theme.textTheme.bodyLarge
                            //         ?.copyWith(
                            //             fontWeight: FontWeight.w500,
                            //             color: Colors.white),
                            //   ),
                            // ),
                            0: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.1,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 5),
                              // height: Screens.padingHeight(context) * 0.05,
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
                              // height: Screens.padingHeight(context) * 0.05,
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
                                  .read<ExpenseController>()
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
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.06,
                              //color: Colors.amber,
                              child: Text(
                                "DocNo",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            // Container(
                            //   alignment: Alignment.centerLeft,
                            //   width: widget.searchWidth * 0.09,
                            //   //color: Colors.amber,
                            //   child: Text(
                            //     "Customer Code",
                            //     style: widget.theme.textTheme.bodyLarge!
                            //         .copyWith(color: Colors.white),
                            //   ),
                            // ),
                            // Container(
                            //   alignment: Alignment.center,
                            //   width: widget.searchWidth * 0.18,
                            //   //color: Colors.amber,
                            //   child: Text(
                            //     "Customer Name",
                            //     style: widget.theme.textTheme.bodyLarge!
                            //         .copyWith(color: Colors.white),
                            //   ),
                            // ),
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.1,
                              //color: Colors.amber,
                              child: Text(
                                "Draft Docentry",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.07,
                              //color: Colors.amber,
                              child: Text(
                                "Doc Date",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.12,
                              //color: Colors.amber,
                              child: Text(
                                "Doc Total",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.1,
                              // color: Colors.amber,
                              child: Text(
                                "UserName",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // context.watch<ExpenseController>().groupValueSelected == 0
                      //     ? Container(
                      //         height: widget.searchHeight * 0.87,
                      //         // color: Colors.green,
                      //         decoration: BoxDecoration(
                      //             color: Colors.white,
                      //             borderRadius: BorderRadius.circular(5)),
                      //         child: context
                      //                 .watch<ExpenseController>()
                      //                 .filterAprvlData
                      //                 .isEmpty
                      //             ? const Center(
                      //                 child: Text("No Data Here..!!"),
                      //               )
                      //             : ListView.builder(
                      //                 itemCount: context
                      //                     .read<ExpenseController>()
                      //                     .filterAprvlData
                      //                     .length,
                      //                 itemBuilder: (context, index) {
                      //                   return InkWell(
                      //                     onTap: () async {
                      //                       context
                      //                           .read<ExpenseController>()
                      //                           .isApprove = true;
                      //                       context
                      //                           .read<ExpenseController>()
                      //                           .clickAprList = true;
                      //                       await context
                      //                           .read<ExpenseController>()
                      //                           .sapLoginApi(context);
                      //                       await context
                      //                           .read<ExpenseController>()
                      //                           .mapApprovalData(
                      //                             int.parse(context
                      //                                 .read<ExpenseController>()
                      //                                 .filterAprvlData[index]
                      //                                 .docEntry
                      //                                 .toString()),
                      //                             context
                      //                                 .read<ExpenseController>()
                      //                                 .filterAprvlData[index]
                      //                                 .U_DeviceTransID
                      //                                 .toString(),
                      //                           );
                      //                       // await context
                      //                       //     .read<ExpenseController>()
                      //                       //     .getdraftDocEntry(
                      //                       //         context,
                      //                       //         widget.theme,
                      //                       // context
                      //                       //     .read<
                      //                       //         ExpenseController>()
                      //                       //     .filterAprvlData[index]
                      //                       //     .docEntry
                      //                       //             .toString());
                      //                       Navigator.pop(context);
                      //                     },
                      //                     child: Container(
                      //                       padding: EdgeInsets.only(
                      //                           top: widget.searchHeight * 0.03,
                      //                           left:
                      //                               widget.searchHeight * 0.02,
                      //                           right:
                      //                               widget.searchHeight * 0.02,
                      //                           bottom:
                      //                               widget.searchHeight * 0.03),
                      //                       decoration: BoxDecoration(
                      //                           color: Colors.grey
                      //                               .withOpacity(0.05),
                      //                           borderRadius:
                      //                               BorderRadius.circular(5),
                      //                           border: Border.all(
                      //                               color: Colors.grey[300]!)),
                      //                       child: Row(
                      //                         mainAxisAlignment:
                      //                             MainAxisAlignment
                      //                                 .spaceBetween,
                      //                         children: [
                      //                           Container(
                      //                             alignment: Alignment.center,
                      //                             width:
                      //                                 widget.searchWidth * 0.08,
                      //                             // color: Colors.amber,
                      //                             child: Text(
                      //                               "${context.watch<ExpenseController>().filterAprvlData[index].docNum}",
                      //                               style: widget.theme
                      //                                   .textTheme.bodyMedium!
                      //                                   .copyWith(
                      //                                       color:
                      //                                           Colors.black),
                      //                             ),
                      //                           ),
                      //                           // Container(
                      //                           //   alignment: Alignment.center,
                      //                           //   width:
                      //                           //       widget.searchWidth * 0.1,
                      //                           //   // color: Colors.amber,
                      //                           //   child: Text(
                      //                           //     "${context.watch<ExpenseController>().filterAprvlData[index].cardCode}",
                      //                           //     style: widget.theme
                      //                           //         .textTheme.bodyLarge!
                      //                           //         .copyWith(
                      //                           //             color:
                      //                           //                 Colors.black),
                      //                           //   ),
                      //                           // ),
                      //                           // Container(
                      //                           //   alignment: Alignment.center,
                      //                           //   width:
                      //                           //       widget.searchWidth * 0.18,
                      //                           //   //color: Colors.amber,
                      //                           //   child: Text(
                      //                           //     "${context.watch<ExpenseController>().filterAprvlData[index].cardName}",
                      //                           //     style: widget.theme
                      //                           //         .textTheme.bodyLarge!
                      //                           //         .copyWith(
                      //                           //             color:
                      //                           //                 Colors.black),
                      //                           //   ),
                      //                           // ),
                      //                           Container(
                      //                             alignment: Alignment.center,
                      //                             width:
                      //                                 widget.searchWidth * 0.1,
                      //                             // color: Colors.amber,
                      //                             child: Text(
                      //                               "${context.watch<ExpenseController>().filterAprvlData[index].docEntry}",
                      //                               style: widget.theme
                      //                                   .textTheme.bodyLarge!
                      //                                   .copyWith(
                      //                                       color:
                      //                                           Colors.black),
                      //                             ),
                      //                           ),
                      //                           Container(
                      //                             alignment: Alignment.center,
                      //                             width:
                      //                                 widget.searchWidth * 0.07,
                      //                             //color: Colors.amber,
                      //                             child: Text(
                      //                               context
                      //                                   .watch<
                      //                                       ExpenseController>()
                      //                                   .config
                      //                                   .alignDate(context
                      //                                       .read<
                      //                                           ExpenseController>()
                      //                                       .filterAprvlData[
                      //                                           index]
                      //                                       .docDate!),
                      //                               style: widget.theme
                      //                                   .textTheme.bodyLarge!
                      //                                   .copyWith(
                      //                                       color:
                      //                                           Colors.black),
                      //                             ),
                      //                           ),
                      //                           Container(
                      //                             alignment:
                      //                                 Alignment.centerRight,
                      //                             width:
                      //                                 widget.searchWidth * 0.11,
                      //                             // color: Colors.amber,
                      //                             child: Text(
                      //                               "${config.splitValues(context.watch<ExpenseController>().filterAprvlData[index].docTotal!.toStringAsFixed(2))}",
                      //                               style: widget.theme
                      //                                   .textTheme.bodyLarge!
                      //                                   .copyWith(
                      //                                       color:
                      //                                           Colors.black),
                      //                             ),
                      //                           ),
                      //                           Container(
                      //                             alignment: Alignment.center,
                      //                             width:
                      //                                 widget.searchWidth * 0.09,
                      //                             //color: Colors.amber,
                      //                             child: Text(
                      //                               "${context.watch<ExpenseController>().filterAprvlData[index].fromUser}",
                      //                               style: widget.theme
                      //                                   .textTheme.bodyLarge!
                      //                                   .copyWith(
                      //                                       color:
                      //                                           Colors.black),
                      //                             ),
                      //                           ),
                      //                           // Container(
                      //                           //   alignment: Alignment.center,
                      //                           //   width: widget.searchWidth * 0.1,
                      //                           //   //color: Colors.amber,
                      //                           //   child: Text(
                      //                           //     "${context.watch<ExpenseController>().filterAprvlData[index].terminal}",
                      //                           //     style: widget.theme.textTheme.bodyLarge!.copyWith(color: Colors.black),
                      //                           //   ),
                      //                           // ),

                      //                           // Container(
                      //                           //   alignment: Alignment.center,
                      //                           //   width: widget.searchWidth * 0.14,
                      //                           //   //color: Colors.amber,
                      //                           //   child: Text(
                      //                           //     "${context.watch<ExpenseController>().filterAprvlData[index].qStatus}",
                      //                           //     style: widget.theme.textTheme.bodyLarge!.copyWith(color: Colors.black),
                      //                           //   ),
                      //                           // ),

                      //                           // Container(
                      //                           //   padding: EdgeInsets.only(right: widget.searchWidth * 0.01),
                      //                           //   alignment: Alignment.centerRight,
                      //                           //   width: widget.searchWidth * 0.12,
                      //                           //   //color: Colors.amber,
                      //                           //   child: Text(
                      //                           //     "${context.watch<ExpenseController>().config.splitValues(context.watch<ExpenseController>().filterAprvlData[index].doctotal.toString())}",
                      //                           //     style: widget.theme.textTheme.bodyLarge!.copyWith(color: Colors.black),
                      //                           //   ),
                      //                           // ),
                      //                           // Container(
                      //                           //   alignment: Alignment.center,
                      //                           //   width: widget.searchWidth * 0.1,
                      //                           //   //color: Colors.amber,
                      //                           //   child: Text(
                      //                           //     "${widget.SalesCon.filterAprvlData[index].type}",
                      //                           //     style: widget
                      //                           //         .theme.textTheme.bodyMedium!
                      //                           //         .copyWith(color: Colors.black),
                      //                           //   ),
                      //                           // ),
                      //                         ],
                      //                       ),
                      //                     ),
                      //                   );
                      //                 }),
                      //       )
                      //     :
                      context.watch<ExpenseController>().groupValueSelected == 0
                          ? Container(
                              height: widget.searchHeight * 0.87,
                              // color: Colors.green,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: context
                                      .watch<ExpenseController>()
                                      .filterPendingApprovalData
                                      .isEmpty
                                  ? const Center(
                                      child: Text("No Data Here..!!"),
                                    )
                                  : ListView.builder(
                                      itemCount: context
                                          .watch<ExpenseController>()
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
                                                alignment:
                                                    Alignment.centerRight,
                                                width:
                                                    widget.searchWidth * 0.08,
                                                //color: Colors.amber,
                                                child: Text(
                                                  "${context.watch<ExpenseController>().filterPendingApprovalData[index].docNum}",
                                                  style: widget.theme.textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          color: Colors.black),
                                                ),
                                              ),
                                              // Container(
                                              //   alignment: Alignment.center,
                                              //   width: widget.searchWidth *
                                              //       0.1,
                                              // //color: Colors.amber,
                                              //   child: Text(
                                              //     "${context.watch<ExpenseController>().filterPendingApprovalData[index].cardCode}",
                                              //     style: widget.theme
                                              //         .textTheme.bodyLarge!
                                              //         .copyWith(
                                              //             color:
                                              //                 Colors.black),
                                              //   ),
                                              // ),
                                              // Container(
                                              //   alignment: Alignment.center,
                                              //   width: widget.searchWidth *
                                              //       0.18,
                                              //   //color: Colors.amber,
                                              //   child: Text(
                                              //     "${context.watch<ExpenseController>().filterPendingApprovalData[index].cardName}",
                                              //     style: widget.theme
                                              //         .textTheme.bodyLarge!
                                              //         .copyWith(
                                              //             color:
                                              //                 Colors.black),
                                              //   ),
                                              // ),
                                              Container(
                                                alignment: Alignment.center,
                                                width:
                                                    widget.searchWidth * 0.13,
                                                //color: Colors.amber,
                                                child: Text(
                                                  "${context.watch<ExpenseController>().filterPendingApprovalData[index].draftEntry}",
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
                                                //color: Colors.amber,
                                                child: Text(
                                                  context
                                                      .watch<
                                                          ExpenseController>()
                                                      .config
                                                      .alignDate(context
                                                          .read<
                                                              ExpenseController>()
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
                                                  "${context.watch<ExpenseController>().filterPendingApprovalData[index].DocTotal ?? 0}",
                                                  style: widget.theme.textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                          color: Colors.black),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                width: widget.searchWidth * 0.1,
                                                //color: Colors.amber,
                                                child: Text(
                                                  "${context.watch<ExpenseController>().filterPendingApprovalData[index].fromUser}",
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
                                      .watch<ExpenseController>()
                                      .groupValueSelected ==
                                  1
                              ? Container(
                                  height: widget.searchHeight * 0.87,
                                  // color: Colors.green,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: context
                                          .watch<ExpenseController>()
                                          .filterRejectedData
                                          .isEmpty
                                      ? const Center(
                                          child: Text("No Data Here..!!"),
                                        )
                                      : ListView.builder(
                                          itemCount: context
                                              .watch<ExpenseController>()
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
                                                          Alignment.centerRight,
                                                      width:
                                                          widget.searchWidth *
                                                              0.08,
                                                      //color: Colors.amber,
                                                      child: Text(
                                                        "${context.watch<ExpenseController>().filterRejectedData[index].docNum}",
                                                        style: widget
                                                            .theme
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                    ),
                                                    // Container(
                                                    //   alignment:
                                                    //       Alignment.center,
                                                    //   width: widget
                                                    //           .searchWidth *
                                                    //       0.1,
                                                    //   // color: Colors.amber,
                                                    //   child: Text(
                                                    //     "${context.watch<ExpenseController>().filterRejectedData[index].cardCode}",
                                                    //     style: widget
                                                    //         .theme
                                                    //         .textTheme
                                                    //         .bodyLarge!
                                                    //         .copyWith(
                                                    //             color: Colors
                                                    //                 .black),
                                                    //   ),
                                                    // ),
                                                    // Container(
                                                    //   alignment:
                                                    //       Alignment.center,
                                                    //   width: widget
                                                    //           .searchWidth *
                                                    //       0.2,
                                                    //   //color: Colors.amber,
                                                    //   child: Text(
                                                    //     "${context.watch<ExpenseController>().filterRejectedData[index].cardName}",
                                                    //     style: widget
                                                    //         .theme
                                                    //         .textTheme
                                                    //         .bodyLarge!
                                                    //         .copyWith(
                                                    //             color: Colors
                                                    //                 .black),
                                                    //   ),
                                                    // ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width:
                                                          widget.searchWidth *
                                                              0.13,
                                                      //color: Colors.amber,
                                                      child: Text(
                                                        "${context.watch<ExpenseController>().filterRejectedData[index].draftEntry}",
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
                                                      //color: Colors.amber,
                                                      child: Text(
                                                        context
                                                            .watch<
                                                                ExpenseController>()
                                                            .config
                                                            .alignDate(context
                                                                .read<
                                                                    ExpenseController>()
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
                                                      //color: Colors.amber,
                                                      child: Text(
                                                        "${context.watch<ExpenseController>().filterRejectedData[index].DocTotal ?? 0}",
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
                                                      //color: Colors.amber,
                                                      child: Text(
                                                        "${context.watch<ExpenseController>().filterRejectedData[index].fromUser}",
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
              visible: context.watch<ExpenseController>().clickAprList,
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
