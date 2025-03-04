import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:provider/provider.dart';

import '../../../Constant/Configuration.dart';
import '../../../Controller/ReconciliationController/RecoController.dart';
import '../../SalesQuotation/Widgets/ItemLists.dart';

class RecoTabScreens extends StatefulWidget {
  const RecoTabScreens({super.key});

  @override
  State<RecoTabScreens> createState() => _RecoTabScreensState();
}

class _RecoTabScreensState extends State<RecoTabScreens> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ReconciliationCtrl>().init();
    });
  }

  Configure config = Configure();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            width: Screens.width(context),
            height: Screens.padingHeight(context) * 0.88,
            padding: EdgeInsets.only(
                top: Screens.padingHeight(context) * 0.01,
                right: Screens.width(context) * 0.01,
                left: Screens.width(context) * 0.01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Card Code'),
                                SizedBox(
                                  width: Screens.width(context) * 0.02,
                                ),
                                Container(
                                  width: Screens.width(context) * 0.15,
                                  height: Screens.padingHeight(context) * 0.055,
                                  child: TextFormField(
                                    onTap: () {
                                      context
                                              .read<ReconciliationCtrl>()
                                              .mycontroller[0]
                                              .text =
                                          context
                                              .read<ReconciliationCtrl>()
                                              .mycontroller[0]
                                              .text;
                                      context
                                          .read<ReconciliationCtrl>()
                                          .mycontroller[0]
                                          .selection = TextSelection(
                                        baseOffset: 0,
                                        extentOffset: context
                                            .read<ReconciliationCtrl>()
                                            .mycontroller[0]
                                            .text
                                            .length,
                                      );
                                      setState(() {
                                        context
                                            .read<ReconciliationCtrl>()
                                            .showListVal = true;
                                      });
                                    },
                                    onChanged: (val) {
                                      context
                                          .read<ReconciliationCtrl>()
                                          .custCodeError = '';
                                      setState(() {
                                        context
                                            .read<ReconciliationCtrl>()
                                            .filterListOnList(val.trim());
                                      });
                                    },
                                    onEditingComplete: () {
                                      context
                                          .read<ReconciliationCtrl>()
                                          .showListVal = false;
                                      context
                                          .read<ReconciliationCtrl>()
                                          .custCodeError = '';
                                      context
                                          .read<ReconciliationCtrl>()
                                          .disableKeyBoard(context);
                                    },
                                    controller: context
                                        .read<ReconciliationCtrl>()
                                        .mycontroller[0],
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 15),
                                        hintText: "Select card code",
                                        hintStyle: theme.textTheme.bodyMedium!
                                            .copyWith(color: Colors.grey[600]),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                        ),
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                context
                                                        .read<ReconciliationCtrl>()
                                                        .showListVal =
                                                    !context
                                                        .read<
                                                            ReconciliationCtrl>()
                                                        .showListVal;
                                              });
                                            },
                                            icon: Icon(Icons.arrow_drop_down))),
                                  ),
                                ),
                                SizedBox(
                                  width: Screens.width(context) * 0.02,
                                ),
                                context
                                        .watch<ReconciliationCtrl>()
                                        .cardName
                                        .isNotEmpty
                                    ? Container(
                                        width: Screens.width(context) * 0.15,
                                        child: Text(context
                                            .watch<ReconciliationCtrl>()
                                            .cardName))
                                    : Container()
                              ],
                            ),
                            context
                                    .watch<ReconciliationCtrl>()
                                    .custCodeError
                                    .isNotEmpty
                                ? Container(
                                    padding: EdgeInsets.only(
                                        left: Screens.width(context) * 0.1),
                                    child: Text(
                                      '${context.watch<ReconciliationCtrl>().custCodeError}',
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(color: Colors.red),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.02,
                      ),
                      Container(
                        // color: Colors.red,
                        width: Screens.width(context) * 0.26,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Reconciliation Date'),
                            Container(
                              height: Screens.padingHeight(context) * 0.05,
                              width: Screens.width(context) * 0.13,
                              child: TextFormField(
                                readOnly: true,
                                onTap: () {
                                  setState(() {
                                    context
                                        .read<ReconciliationCtrl>()
                                        .getDate(context);
                                  });
                                },
                                keyboardType: TextInputType.number,
                                onChanged: (val) {},
                                onEditingComplete: () {
                                  context
                                      .read<ReconciliationCtrl>()
                                      .disableKeyBoard(context);
                                },
                                controller: context
                                    .watch<ReconciliationCtrl>()
                                    .mycontroller[1],
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          context
                                              .read<ReconciliationCtrl>()
                                              .getDate(context);
                                        });
                                      },
                                      icon: Icon(
                                        Icons.calendar_month,
                                        color: theme.primaryColor,
                                      )),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  hintText: "",
                                  hintStyle: theme.textTheme.bodyMedium!
                                      .copyWith(color: Colors.grey[600]),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.02,
                      ),
                      Container(
                          height: Screens.padingHeight(context) * 0.055,
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (context
                                      .read<ReconciliationCtrl>()
                                      .mycontroller[0]
                                      .text
                                      .isNotEmpty) {
                                    //loadingscrn
                                    context
                                        .read<ReconciliationCtrl>()
                                        .disableKeyBoard(context);
                                    context
                                        .read<ReconciliationCtrl>()
                                        .totalRecoAmt = null;
                                    context
                                        .read<ReconciliationCtrl>()
                                        .showListVal = false;
                                    context
                                        .read<ReconciliationCtrl>()
                                        .noDataMsg = '';
                                    context
                                        .read<ReconciliationCtrl>()
                                        .recoListItemData = [];
                                    context
                                        .read<ReconciliationCtrl>()
                                        .getCardName();
                                    context
                                        .read<ReconciliationCtrl>()
                                        .callRecoListApi();
                                  } else {
                                    context
                                        .read<ReconciliationCtrl>()
                                        .custCodeError = 'Select card code';
                                  }
                                });
                              },
                              child: Text('  Search  ')))
                    ],
                  ),
                ),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.01,
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  color: theme.primaryColor,
                  width: Screens.width(context),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          alignment: Alignment.center,
                          width: Screens.width(context) * 0.05,
                          child: Text(
                            '  Select ',
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          )),
                      SizedBox(
                        width: Screens.width(context) * 0.01,
                      ),
                      // Container(
                      //     // color: Colors.red,
                      //     alignment: Alignment.center,
                      //     width: Screens.width(context) * 0.05,
                      //     child: Text(
                      //       'Origin',
                      //       style: theme.textTheme.bodyMedium
                      //           ?.copyWith(color: Colors.white),
                      //     )),
                      // SizedBox(
                      //   width: Screens.width(context) * 0.005,
                      // ),
                      Container(
                          // color: Colors.red,
                          alignment: Alignment.center,
                          width: Screens.width(context) * 0.06,
                          child: Text(
                            'Origin No',
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          )),
                      SizedBox(
                        width: Screens.width(context) * 0.01,
                      ),
                      Container(
                          alignment: Alignment.center,
                          width: Screens.width(context) * 0.08,
                          child: Text(
                            'Doc Date',
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          )),
                      SizedBox(
                        width: Screens.width(context) * 0.01,
                      ),
                      Container(
                          alignment: Alignment.center,
                          width: Screens.width(context) * 0.06,
                          child: Text(
                            'Ref.1',
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          )),
                      SizedBox(
                        width: Screens.width(context) * 0.01,
                      ),
                      Container(
                          alignment: Alignment.center,
                          width: Screens.width(context) * 0.06,
                          child: Text(
                            'Ref.2',
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          )),
                      SizedBox(
                        width: Screens.width(context) * 0.01,
                      ),
                      Container(
                          alignment: Alignment.center,
                          width: Screens.width(context) * 0.1,
                          child: Text(
                            'Amount',
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          )),
                      SizedBox(
                        width: Screens.width(context) * 0.01,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: Screens.width(context) * 0.1,
                        child: Text(
                          'Balance Due',
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.01,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: Screens.width(context) * 0.15,
                        child: Text(
                          'Amount to Reconcil',
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.01,
                      ),

                      Container(
                        alignment: Alignment.center,
                        width: Screens.width(context) * 0.2,
                        child: Text(
                          'Cust./Vendor Ref. No.',
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                context.watch<ReconciliationCtrl>().recoListItemData.isEmpty &&
                        context.watch<ReconciliationCtrl>().noDataMsg.isEmpty &&
                        context.watch<ReconciliationCtrl>().loadingscrn == true
                    ? Container(
                        height: Screens.padingHeight(context) * 0.5,
                        child: Center(child: CircularProgressIndicator()))
                    : context
                                .watch<ReconciliationCtrl>()
                                .recoListItemData
                                .isEmpty &&
                            context
                                .watch<ReconciliationCtrl>()
                                .noDataMsg
                                .isNotEmpty &&
                            context.watch<ReconciliationCtrl>().loadingscrn ==
                                false
                        ? Container(
                            height: Screens.padingHeight(context) * 0.5,
                            child: Center(
                              child: Text(context
                                  .watch<ReconciliationCtrl>()
                                  .noDataMsg
                                  .toString()),
                            ))
                        : context
                                    .watch<ReconciliationCtrl>()
                                    .recoListItemData
                                    .isNotEmpty &&
                                context
                                    .watch<ReconciliationCtrl>()
                                    .noDataMsg
                                    .isEmpty &&
                                context
                                        .watch<ReconciliationCtrl>()
                                        .loadingscrn ==
                                    false
                            ? Container(
                                height: Screens.padingHeight(context) * 0.623,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: context
                                        .watch<ReconciliationCtrl>()
                                        .recoListItemData
                                        .length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                          margin: EdgeInsets.all(2),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: context
                                                          .watch<
                                                              ReconciliationCtrl>()
                                                          .recoListItemData[
                                                              index]
                                                          .listclr ==
                                                      true
                                                  ? Colors.blue
                                                      .withOpacity(0.35)
                                                  : Colors.grey
                                                      .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: CheckboxListTile(
                                              activeColor: theme.primaryColor,
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              onChanged: (val) {
                                                context
                                                    .read<ReconciliationCtrl>()
                                                    .itemDeSelect(index);
                                              },
                                              value: context
                                                  .read<ReconciliationCtrl>()
                                                  .recoListItemData[index]
                                                  .listclr,
                                              title: Container(
                                                width: Screens.width(context),
                                                child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      // Container(
                                                      //     // color: Colors.red,
                                                      //     alignment: Alignment.center,
                                                      //     height: Screens.padingHeight(
                                                      //             context) *
                                                      //         0.02,
                                                      //     width: Screens.width(context) *
                                                      //         0.05),
                                                      // SizedBox(
                                                      //   width:
                                                      //       Screens.width(context) * 0.01,
                                                      // ),
                                                      Container(
                                                        // height: Screens.padingHeight(
                                                        //         context) *
                                                        //     0.02,
                                                        // color: Colors.red,
                                                        alignment:
                                                            Alignment.center,
                                                        width: Screens.width(
                                                                context) *
                                                            0.06,

                                                        child: Text(
                                                            '${context.watch<ReconciliationCtrl>().recoListItemData[index].ref1}'),
                                                      ),
                                                      SizedBox(
                                                        width: Screens.width(
                                                                context) *
                                                            0.005,
                                                      ),
                                                      Container(
                                                        // color: Colors.red,
                                                        alignment:
                                                            Alignment.center,
                                                        width: Screens.width(
                                                                context) *
                                                            0.08,
                                                        child: Text(
                                                            '${config.alignDateT(context.read<ReconciliationCtrl>().recoListItemData[index].refDate)}'),
                                                      ),
                                                      SizedBox(
                                                        width: Screens.width(
                                                                context) *
                                                            0.005,
                                                      ),
                                                      Container(
                                                        // color: Colors.red,
                                                        alignment:
                                                            Alignment.center,
                                                        width: Screens.width(
                                                                context) *
                                                            0.08,
                                                        child: Text(
                                                            '${context.watch<ReconciliationCtrl>().recoListItemData[index].ref1}'),
                                                      ),
                                                      SizedBox(
                                                        width: Screens.width(
                                                                context) *
                                                            0.01,
                                                      ),
                                                      Container(
                                                        // color: Colors.red,
                                                        alignment:
                                                            Alignment.center,
                                                        width: Screens.width(
                                                                context) *
                                                            0.07,
                                                        child: Text(
                                                            '${context.watch<ReconciliationCtrl>().recoListItemData[index].ref2}'),
                                                      ),
                                                      SizedBox(
                                                        width: Screens.width(
                                                                context) *
                                                            0.005,
                                                      ),
                                                      Container(
                                                        // color: Colors.red,
                                                        alignment: Alignment
                                                            .centerRight,
                                                        width: Screens.width(
                                                                context) *
                                                            0.1,
                                                        child: Text(
                                                            '${context.watch<ReconciliationCtrl>().recoListItemData[index].amount}'),
                                                      ),
                                                      SizedBox(
                                                        width: Screens.width(
                                                                context) *
                                                            0.005,
                                                      ),
                                                      Container(
                                                        // color: Colors.red,
                                                        alignment: Alignment
                                                            .centerRight,
                                                        width: Screens.width(
                                                                context) *
                                                            0.1,
                                                        child: Text(
                                                            '${context.watch<ReconciliationCtrl>().recoListItemData[index].balance}'),
                                                      ),
                                                      SizedBox(
                                                        width: Screens.width(
                                                                context) *
                                                            0.01,
                                                      ),
                                                      Container(
                                                        // color: Colors.red,
                                                        alignment: Alignment
                                                            .centerRight,
                                                        height: Screens
                                                                .padingHeight(
                                                                    context) *
                                                            0.06,
                                                        width: Screens.width(
                                                                context) *
                                                            0.15,
                                                        child: TextFormField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          textAlign:
                                                              TextAlign.right,
                                                          inputFormatters: [
                                                            DecimalInputFormatter()
                                                          ],
                                                          onChanged: (v) {
                                                            setState(() {
                                                              // context
                                                              //     .read<
                                                              //         ReconciliationCtrl>()
                                                              //     .doubleDotMethodPayTerms(
                                                              //         index, v);
                                                            });
                                                          },
                                                          onTap: () {
                                                            context
                                                                    .read<
                                                                        ReconciliationCtrl>()
                                                                    .recoAmtcontroller[
                                                                        index]
                                                                    .text =
                                                                context
                                                                    .read<
                                                                        ReconciliationCtrl>()
                                                                    .recoAmtcontroller[
                                                                        index]
                                                                    .text;
                                                            context
                                                                    .read<
                                                                        ReconciliationCtrl>()
                                                                    .recoAmtcontroller[
                                                                        index]
                                                                    .selection =
                                                                TextSelection(
                                                              baseOffset: 0,
                                                              extentOffset: context
                                                                  .read<
                                                                      ReconciliationCtrl>()
                                                                  .recoAmtcontroller[
                                                                      index]
                                                                  .text
                                                                  .length,
                                                            );
                                                          },
                                                          onEditingComplete:
                                                              () {
                                                            context
                                                                .read<
                                                                    ReconciliationCtrl>()
                                                                .changeCalculaterList(
                                                                    index,
                                                                    context,
                                                                    theme);
                                                            context
                                                                .read<
                                                                    ReconciliationCtrl>()
                                                                .disableKeyBoard(
                                                                    context);
                                                          },
                                                          controller: context
                                                              .watch<
                                                                  ReconciliationCtrl>()
                                                              .recoAmtcontroller[index],
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        15),
                                                            hintText: "",
                                                            hintStyle: theme
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                    color: Colors
                                                                            .grey[
                                                                        600]),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .grey),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .grey),
                                                            ),
                                                          ),
                                                        ),
                                                        // child: Text(
                                                        //     '${context.watch<ReconciliationCtrl>().recoListItemData[index].reconcileAmount}'),
                                                      ),
                                                      SizedBox(
                                                        width: Screens.width(
                                                                context) *
                                                            0.01,
                                                      ),
                                                      Container(
                                                        // color: Colors.red,
                                                        width: Screens.width(
                                                                context) *
                                                            0.21,
                                                        child: Text(context
                                                                .watch<
                                                                    ReconciliationCtrl>()
                                                                .recoListItemData[
                                                                    index]
                                                                .memo ??
                                                            ''),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          ));
                                    }),
                              )
                            : Container(),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.015,
                ),
                context.watch<ReconciliationCtrl>().recoListItemData.isNotEmpty
                    ? Container(
                        padding: EdgeInsets.only(
                            left: Screens.padingHeight(context) * 0.45),
                        width: Screens.width(context),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('TZS  '),
                            SizedBox(
                              width: Screens.width(context) * 0.02,
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              height: Screens.padingHeight(context) * 0.05,
                              padding: EdgeInsets.all(5),
                              width: Screens.width(context) * 0.15,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(color: Colors.grey.shade300)),
                              child: Text(context
                                          .watch<ReconciliationCtrl>()
                                          .totalRecoAmt !=
                                      null
                                  ? '${context.watch<ReconciliationCtrl>().totalRecoAmt!.toStringAsFixed(6)}'
                                  : ''),
                            )
                          ],
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.01,
                ),
                context.watch<ReconciliationCtrl>().recoListItemData.isNotEmpty
                    ? Container(
                        alignment: Alignment.centerRight,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                width: Screens.width(context) * 0.1,
                                child: ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<ReconciliationCtrl>()
                                          .clearBtn();
                                    },
                                    child: Text('Clear'))),
                            SizedBox(
                              width: Screens.width(context) * 0.06,
                            ),
                            Container(
                                width: Screens.width(context) * 0.1,
                                child: ElevatedButton(
                                    onPressed: context
                                                .read<ReconciliationCtrl>()
                                                .onDisablebutton ==
                                            true
                                        ? null
                                        : () async {
                                            List<String> addData = [];

                                            for (var i = 0;
                                                i <
                                                    context
                                                        .read<
                                                            ReconciliationCtrl>()
                                                        .recoListItemData
                                                        .length;
                                                i++) {
                                              if (context
                                                      .read<
                                                          ReconciliationCtrl>()
                                                      .recoListItemData[i]
                                                      .listclr ==
                                                  true) {
                                                addData.add(i.toString());
                                              }
                                            }
                                            if (addData.isNotEmpty) {
                                              if (context
                                                      .read<
                                                          ReconciliationCtrl>()
                                                      .totalRecoAmt ==
                                                  0) {
                                                await context
                                                    .read<ReconciliationCtrl>()
                                                    .callpostRecoList(context);
                                              }
                                            } else {
                                              Get.defaultDialog(
                                                  title: 'Alert',
                                                  titleStyle: TextStyle(
                                                      color: Colors.red),
                                                  middleText:
                                                      'Kindly select reconciliation list',
                                                  actions: [
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        child: Text('Close'))
                                                  ]);
                                            }
                                          },
                                    child: Text('Save')))
                          ],
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          Positioned(
            top: Screens.padingHeight(context) * 0.085,
            left: Screens.width(context) * 0.03,
            child: Visibility(
                visible: context.read<ReconciliationCtrl>().showListVal,
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.grey.shade300,
                    alignment: Alignment.centerRight,
                    height: Screens.padingHeight(context) * 0.8,
                    width: Screens.width(context) * 0.25,
                    child: ListView.builder(
                        itemCount: context
                            .watch<ReconciliationCtrl>()
                            .filterListBoxData
                            .length,
                        itemBuilder: (context, i) {
                          return Card(
                            child: InkWell(
                              onTap: () {
                                setState(
                                  () {
                                    context
                                            .read<ReconciliationCtrl>()
                                            .mycontroller[0]
                                            .text =
                                        context
                                            .read<ReconciliationCtrl>()
                                            .filterListBoxData[i]
                                            .cardCode
                                            .toString();
                                    context
                                            .read<ReconciliationCtrl>()
                                            .cardCode =
                                        context
                                            .read<ReconciliationCtrl>()
                                            .filterListBoxData[i]
                                            .cardCode
                                            .toString();
                                    context
                                            .read<ReconciliationCtrl>()
                                            .cardName =
                                        context
                                            .read<ReconciliationCtrl>()
                                            .filterListBoxData[i]
                                            .cardName
                                            .toString();
                                    context
                                        .read<ReconciliationCtrl>()
                                        .showListVal = false;
                                    context
                                        .read<ReconciliationCtrl>()
                                        .disableKeyBoard(context);
                                  },
                                );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(10),
                                child: Text(
                                    '${context.watch<ReconciliationCtrl>().filterListBoxData[i].cardCode.toString()}'),
                              ),
                            ),
                          );
                        }),
                  ),
                )),
          ),
          Visibility(
            visible: context.watch<ReconciliationCtrl>().onDisablebutton,
            child: Container(
              width: Screens.width(context),
              height: Screens.bodyheight(context),
              color: Colors.white60,
              child: Center(
                child: SpinKitFadingCircle(
                  size: Screens.bodyheight(context) * 0.08,
                  color: theme.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
