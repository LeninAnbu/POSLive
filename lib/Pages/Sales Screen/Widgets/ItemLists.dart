import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:posproject/Controller/SalesInvoice/SalesInvoiceController.dart';
import 'package:provider/provider.dart';

import '../../../Widgets/AlertBox.dart';
import '../../../Widgets/ContentContainer.dart';
import '../../SalesQuotation/Widgets/ItemLists.dart';

class SearchWidget extends StatefulWidget {
  SearchWidget(
      {super.key,
      required this.theme,
      required this.searchHeight,
      required this.searchWidth});

  final ThemeData theme;

  double searchHeight;
  double searchWidth;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          context.watch<PosController>().scanneditemData2.isNotEmpty
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
                    autofocus: true,
                    readOnly:
                        context.watch<PosController>().cpyfrmso == 'CopyfromSo'
                            ? true
                            : false,
                    style: theme.textTheme.bodyMedium,
                    onChanged: (v) {
                      if (context
                          .read<PosController>()
                          .mycontroller[99]
                          .text
                          .isNotEmpty) {
                        context.read<PosController>().listVisible = false;
                      }
                    },
                    cursorColor: Colors.grey,
                    controller: context.read<PosController>().mycontroller[99],
                    onEditingComplete: () async {
                      setState(() {
                        context.read<PosController>().checkBatchAvail(
                            context
                                .read<PosController>()
                                .mycontroller[99]
                                .text
                                .toString()
                                .trim()
                                .toUpperCase(),
                            context,
                            theme);
                      });
                    },
                    decoration: InputDecoration(
                      filled: false,
                      hintText: 'Inventories',
                      hintStyle: theme.textTheme.bodyMedium?.copyWith(),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 10,
                      ),
                    ),
                  )),
          SizedBox(
            height: widget.searchHeight * 0.01,
          ),
          Container(
            padding: EdgeInsets.only(
              top: widget.searchHeight * 0.01,
              left: widget.searchHeight * 0.01,
              right: widget.searchHeight * 0.01,
              bottom: widget.searchHeight * 0.01,
            ),
            decoration: BoxDecoration(
              color: theme.primaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                      padding: EdgeInsets.only(
                        left: widget.searchHeight * 0.01,
                      ),
                      alignment: Alignment.centerLeft,
                      width: widget.searchWidth * 0.22,
                      child: Text(
                        "Product Information",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.white),
                      )),
                ),
                Container(
                  width: widget.searchWidth * 0.73,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          alignment: Alignment.center,
                          width: widget.searchWidth * 0.09,
                          child: Text(
                            "Qty",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          )),
                      Container(
                          alignment: Alignment.center,
                          width: widget.searchWidth * 0.18,
                          child: Text(
                            "Price",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          )),
                      Container(
                          alignment: Alignment.center,
                          width: widget.searchWidth * 0.08,
                          child: Text(
                            "Disc %",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          )),
                      Container(
                          alignment: Alignment.center,
                          width: widget.searchWidth * 0.18,
                          child: Text(
                            "PriceAftDisc",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          )),
                      Container(
                          alignment: Alignment.centerRight,
                          width: widget.searchWidth * 0.17,
                          child: Text(
                            "Total  ",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: context
                      .read<PosController>()
                      .getScanneditemData2
                      .isNotEmpty
                  ? ListView.builder(
                      itemCount: context
                          .watch<PosController>()
                          .getScanneditemData2
                          .length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.all(2),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                                padding: EdgeInsets.only(
                                  left: widget.searchHeight * 0.01,
                                  right: widget.searchHeight * 0.01,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey[300],
                                ),
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              width: widget.searchWidth * 0.15,
                                              alignment: Alignment.centerLeft,
                                              child: TextButton(
                                                  onPressed: () {},
                                                  child: Text(
                                                    "${context.watch<PosController>().getScanneditemData2[index].itemCode}",
                                                    maxLines: 2,
                                                    style: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            color:
                                                                Colors.black),
                                                  ))),
                                        ],
                                      ),
                                      SizedBox(
                                        width: widget.searchWidth * 0.75,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width:
                                                    widget.searchWidth * 0.09,
                                                height:
                                                    widget.searchHeight * 0.07,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        widget.searchWidth *
                                                            0.005),
                                                child: TextFormField(
                                                  readOnly: true,
                                                  style: theme
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                          color: Colors.black),
                                                  onChanged: (v) {},
                                                  cursorColor: Colors.grey,
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onEditingComplete: () {},
                                                  controller: context
                                                      .read<PosController>()
                                                      .qtymycontroller2[index],
                                                  decoration: InputDecoration(
                                                    filled: false,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.grey),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.grey),
                                                    ),
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                      vertical: 0,
                                                      horizontal: 5,
                                                    ),
                                                  ),
                                                )),
                                            Container(
                                              width: widget.searchWidth * 0.19,
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                context
                                                    .watch<PosController>()
                                                    .config
                                                    .splitValues(
                                                        "${context.watch<PosController>().getScanneditemData2[index].sellPrice}"),
                                                style: theme
                                                    .textTheme.bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.black),
                                              ),
                                            ),
                                            Container(
                                                width:
                                                    widget.searchWidth * 0.09,
                                                height:
                                                    widget.searchHeight * 0.07,
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                    '${context.watch<PosController>().getScanneditemData2[index].discountper}')),
                                            SizedBox(
                                              width: widget.searchWidth * 0.01,
                                            ),
                                            Container(
                                                width:
                                                    widget.searchWidth * 0.17,
                                                height:
                                                    widget.searchHeight * 0.07,
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(context
                                                            .watch<
                                                                PosController>()
                                                            .getScanneditemData2[
                                                                index]
                                                            .priceAftDiscVal !=
                                                        null
                                                    ? context
                                                        .watch<PosController>()
                                                        .config
                                                        .splitValues(
                                                            '${context.watch<PosController>().getScanneditemData2[index].priceAftDiscVal}')
                                                    : '0.00')),
                                            Container(
                                                width:
                                                    widget.searchWidth * 0.19,
                                                height:
                                                    widget.searchHeight * 0.07,
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(context
                                                            .watch<
                                                                PosController>()
                                                            .getScanneditemData2[
                                                                index]
                                                            .taxable !=
                                                        null
                                                    ? context
                                                        .watch<PosController>()
                                                        .config
                                                        .splitValues(
                                                            '${context.watch<PosController>().getScanneditemData2[index].taxable}')
                                                    : '0.00')),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: widget.searchHeight * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${context.watch<PosController>().getScanneditemData2[index].serialBatch}",
                                            textAlign: TextAlign.start,
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(),
                                          )),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width: widget.searchWidth * 0.55,
                                        child: Text(
                                          "  |  ${context.watch<PosController>().getScanneditemData2[index].itemName}",
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: widget.searchWidth * 0.02,
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        width: widget.searchWidth * 0.15,
                                        child: Text(
                                          "Tax : ${context.watch<PosController>().getScanneditemData2[index].taxRate} %",
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(),
                                        ),
                                      ),
                                    ],
                                  )
                                ])),
                          ),
                        );
                      })
                  : ListView.builder(
                      itemCount: context
                          .watch<PosController>()
                          .getScanneditemData
                          .length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.all(2),
                          child: InkWell(
                            onLongPress: () {
                              context
                                  .read<PosController>()
                                  .autoselectbtndisable = false;
                              context
                                  .read<PosController>()
                                  .manualselectbtndisable = false;
                              context
                                  .read<PosController>()
                                  .batchselectbtndisable = false;
                              context.read<PosController>().noMsgText = '';
                              log('selectionBtnLoading::${context.read<PosController>().selectionBtnLoading}');

                              if (context
                                  .read<PosController>()
                                  .openOrdLineList!
                                  .isNotEmpty) {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          insetPadding: EdgeInsets.all(
                                              widget.searchWidth * 0.01),
                                          contentPadding: EdgeInsets.zero,
                                          content: AlertBox(
                                            payMent: 'Sales Order',
                                            widget: forScanSoOrder(
                                                context, widget.theme),
                                            buttonName: null,
                                          ));
                                    });
                              }
                            },
                            child: Container(
                                padding: EdgeInsets.only(
                                  top: widget.searchHeight * 0.01,
                                  left: widget.searchWidth * 0.01,
                                  right: widget.searchWidth * 0.01,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.withOpacity(0.04),
                                ),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              width: widget.searchWidth * 0.17,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "${context.watch<PosController>().getScanneditemData[index].itemCode}",
                                                maxLines: 2,
                                                style: theme
                                                    .textTheme.bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.black),
                                              )),
                                          Container(
                                            width: widget.searchWidth * 0.77,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                    width: widget.searchWidth *
                                                        0.1,
                                                    height:
                                                        widget.searchHeight *
                                                            0.07,
                                                    alignment:
                                                        Alignment.centerRight,
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal:
                                                            widget.searchWidth *
                                                                0.005),
                                                    child: TextFormField(
                                                      style: theme
                                                          .textTheme.bodyMedium
                                                          ?.copyWith(
                                                              color:
                                                                  Colors.black),
                                                      textAlign:
                                                          TextAlign.right,
                                                      onChanged: (val) {
                                                        context
                                                            .read<
                                                                PosController>()
                                                            .doubleDotMethod(
                                                                index, val);
                                                      },
                                                      inputFormatters: [
                                                        DecimalInputFormatter()
                                                      ],
                                                      onTap: () {
                                                        context
                                                                .read<
                                                                    PosController>()
                                                                .qtymycontroller[
                                                                    index]
                                                                .text =
                                                            context
                                                                .read<
                                                                    PosController>()
                                                                .qtymycontroller[
                                                                    index]
                                                                .text;

                                                        context
                                                                .read<
                                                                    PosController>()
                                                                .qtymycontroller[
                                                                    index]
                                                                .selection =
                                                            TextSelection(
                                                          baseOffset: 0,
                                                          extentOffset: context
                                                              .read<
                                                                  PosController>()
                                                              .qtymycontroller[
                                                                  index]
                                                              .text
                                                              .length,
                                                        );
                                                      },
                                                      cursorColor: Colors.grey,
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      onEditingComplete: () {
                                                        context
                                                            .read<
                                                                PosController>()
                                                            .itemIncrement11(
                                                                index,
                                                                context,
                                                                theme);
                                                      },
                                                      readOnly: context
                                                              .read<
                                                                  PosController>()
                                                              .cpyfrmso
                                                              .isNotEmpty
                                                          ? true
                                                          : false,
                                                      controller: context
                                                          .read<PosController>()
                                                          .qtymycontroller[index],
                                                      decoration:
                                                          InputDecoration(
                                                        filled: false,
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 0,
                                                          horizontal: 5,
                                                        ),
                                                      ),
                                                    )),
                                                Container(
                                                    width: widget.searchWidth *
                                                        0.17,
                                                    height:
                                                        widget.searchHeight *
                                                            0.07,
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(context
                                                        .watch<PosController>()
                                                        .config
                                                        .splitValues(
                                                            '${context.watch<PosController>().getScanneditemData[index].sellPrice}'))),
                                                Container(
                                                    width: widget.searchWidth *
                                                        0.06,
                                                    height:
                                                        widget.searchHeight *
                                                            0.07,
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        '${context.watch<PosController>().getScanneditemData[index].discountper!.toStringAsFixed(2)}')),
                                                Container(
                                                    width: widget.searchWidth *
                                                        0.17,
                                                    height:
                                                        widget.searchHeight *
                                                            0.07,
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(context
                                                                .watch<
                                                                    PosController>()
                                                                .getScanneditemData[
                                                                    index]
                                                                .priceAftDiscVal !=
                                                            null
                                                        ? context
                                                            .watch<
                                                                PosController>()
                                                            .config
                                                            .splitValues(
                                                                '${context.watch<PosController>().getScanneditemData[index].priceAftDiscVal}')
                                                        : '0.00')),
                                                Container(
                                                  width:
                                                      widget.searchWidth * 0.17,
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    context
                                                                .watch<
                                                                    PosController>()
                                                                .getScanneditemData[
                                                                    index]
                                                                .taxable !=
                                                            null
                                                        ? context
                                                            .watch<
                                                                PosController>()
                                                            .config
                                                            .splitValues(
                                                                "${context.watch<PosController>().getScanneditemData[index].taxable}")
                                                        : '0.00',
                                                    style: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            color:
                                                                Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: widget.searchHeight * 0.01,
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            context
                                                    .watch<PosController>()
                                                    .getScanneditemData[index]
                                                    .serialBatch!
                                                    .isNotEmpty
                                                ? Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "${context.watch<PosController>().getScanneditemData[index].serialBatch} | ",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: theme
                                                          .textTheme.bodyMedium
                                                          ?.copyWith(),
                                                    ))
                                                : Container(),
                                            Container(
                                              width: widget.searchWidth * 0.44,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "${context.watch<PosController>().getScanneditemData[index].itemName}",
                                                style: theme
                                                    .textTheme.bodyMedium
                                                    ?.copyWith(),
                                                maxLines: 2,
                                              ),
                                            ),
                                            SizedBox(
                                              width: widget.searchWidth * 0.01,
                                            ),
                                            Container(
                                              // color: Colors.green,
                                              width: widget.searchWidth * 0.14,
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  'Tax : ${context.watch<PosController>().getScanneditemData[index].taxRate ?? 0.00}%',
                                                  style: theme
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                          color: Colors.black)),
                                            ),
                                            SizedBox(
                                              width: widget.searchWidth * 0.01,
                                            ),
                                            Container(
                                              // color: Colors.red,
                                              width: widget.searchWidth * 0.16,
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  'IS : ${context.watch<PosController>().getScanneditemData[index].inStockQty ?? 0}',
                                                  style: theme
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                          color: Colors.black)),
                                            ),
                                          ],
                                        ),
                                      )
                                    ])),
                          ),
                        );
                      })),
        ],
      ),
    );
  }

  forScanSoOrder(BuildContext context, ThemeData theme) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.all(
          widget.searchHeight * 0.01,
        ),
        width: widget.searchWidth * 1.74,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: widget.searchWidth * 0.87,
              color: Colors.grey[100],
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Text(' Select All '),
                        Checkbox(
                            value: context.read<PosController>().selectAll,
                            side: const BorderSide(color: Colors.grey),
                            activeColor: Colors.green,
                            onChanged: (value) {
                              st(
                                () {
                                  context.read<PosController>().selectAll =
                                      value!;
                                  context
                                      .read<PosController>()
                                      .autoselectbtndisable = false;
                                  context
                                      .read<PosController>()
                                      .batchselectbtndisable = false;

                                  context.read<PosController>().selectAllItem();
                                },
                              );
                            }),
                      ],
                    ),
                  ),
                  Container(
                    width: widget.searchWidth * 0.87,
                    padding: EdgeInsets.only(
                      top: widget.searchWidth * 0.01,
                      bottom: widget.searchWidth * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: EdgeInsets.only(
                              left: widget.searchWidth * 0.01,
                            ),
                            alignment: Alignment.center,
                            width: widget.searchWidth * 0.2,
                            child: Text(
                              "Item Code",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            )),
                        Container(
                            alignment: Alignment.center,
                            width: widget.searchWidth * 0.3,
                            child: Text(
                              "Item Name",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            )),
                        Container(
                            alignment: Alignment.center,
                            width: widget.searchWidth * 0.12,
                            child: Text(
                              "In Stock",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            )),
                        Container(
                            alignment: Alignment.center,
                            width: widget.searchWidth * 0.1,
                            child: Text(
                              "S.O Qty",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            )),
                        Container(
                            alignment: Alignment.center,
                            width: widget.searchWidth * 0.1,
                            child: Text(
                              "",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    height: widget.searchHeight * 3.1,
                    width: widget.searchWidth * 0.86,
                    child: ListView.builder(
                        itemCount: context
                            .watch<PosController>()
                            .openOrdLineList!
                            .length,
                        itemBuilder: (context, index) {
                          return Card(
                              margin: EdgeInsets.all(2),
                              color: Colors.grey[200],
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: context
                                                      .watch<PosController>()
                                                      .openOrdLineList![index]
                                                      .invoiceClr ==
                                                  1 &&
                                              context
                                                      .watch<PosController>()
                                                      .openOrdLineList![index]
                                                      .checkBClr ==
                                                  true
                                          ? Colors.blue.withOpacity(0.35)
                                          : Colors.grey.withOpacity(0.2)),
                                  child: CheckboxListTile(
                                      contentPadding: EdgeInsets.zero,
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      onChanged: (val) {
                                        setState(() {
                                          context
                                              .read<PosController>()
                                              .autoselectbtndisable = false;
                                          context
                                              .read<PosController>()
                                              .batchselectbtndisable = false;
                                          context
                                              .read<PosController>()
                                              .manualselectbtndisable = false;
                                          context
                                              .read<PosController>()
                                              .selectAll = false;
                                          context
                                              .read<PosController>()
                                              .selectIndex = index;
                                          context
                                              .read<PosController>()
                                              .noMsgText = '';
                                          context
                                              .read<PosController>()
                                              .selectSameItemCode(context
                                                  .read<PosController>()
                                                  .openOrdLineList![index]
                                                  .itemCode);
                                        });
                                      },
                                      value: context
                                          .watch<PosController>()
                                          .openOrdLineList![index]
                                          .checkBClr,
                                      title: Transform.translate(
                                          offset: const Offset(-20, 0),
                                          child: SizedBox(
                                            height: widget.searchHeight * 0.085,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    width: widget.searchWidth *
                                                        0.14,
                                                    child: Text(
                                                      context
                                                          .watch<
                                                              PosController>()
                                                          .openOrdLineList![
                                                              index]
                                                          .itemCode
                                                          .toString(),
                                                      style: theme
                                                          .textTheme.bodyLarge!
                                                          .copyWith(),
                                                    )),
                                                Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    width: widget.searchWidth *
                                                        0.3,
                                                    child: Text(
                                                      context
                                                          .watch<
                                                              PosController>()
                                                          .openOrdLineList![
                                                              index]
                                                          .description
                                                          .toString(),
                                                      maxLines: 2,
                                                      style: theme
                                                          .textTheme.bodyLarge!
                                                          .copyWith(),
                                                    )),
                                                Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    width: widget.searchWidth *
                                                        0.1,
                                                    child: Text(
                                                      context
                                                          .watch<
                                                              PosController>()
                                                          .openOrdLineList![
                                                              index]
                                                          .stock
                                                          .toString(),
                                                      style: theme
                                                          .textTheme.bodyLarge!
                                                          .copyWith(),
                                                    )),
                                                Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    width: widget.searchWidth *
                                                        0.12,
                                                    child: Text(
                                                      context
                                                          .watch<
                                                              PosController>()
                                                          .openOrdLineList![
                                                              index]
                                                          .openQty
                                                          .toString(),
                                                      style: theme
                                                          .textTheme.bodyLarge!
                                                          .copyWith(),
                                                    )),
                                                SizedBox(
                                                  width:
                                                      widget.searchWidth * 0.01,
                                                ),
                                                Container(
                                                    width: widget.searchWidth *
                                                        0.1,
                                                    height:
                                                        widget.searchHeight *
                                                            0.4,
                                                    alignment: Alignment.center,
                                                    child: TextFormField(
                                                      inputFormatters: [
                                                        DecimalInputFormatter()
                                                      ],
                                                      style: theme
                                                          .textTheme.bodyMedium,
                                                      onTap: () {
                                                        context
                                                                .read<
                                                                    PosController>()
                                                                .soListController[
                                                                    index]
                                                                .text =
                                                            context
                                                                .read<
                                                                    PosController>()
                                                                .soListController[
                                                                    index]
                                                                .text;

                                                        context
                                                                .read<
                                                                    PosController>()
                                                                .soListController[
                                                                    index]
                                                                .selection =
                                                            TextSelection(
                                                                baseOffset: 0,
                                                                extentOffset: context
                                                                    .read<
                                                                        PosController>()
                                                                    .soListController[
                                                                        index]
                                                                    .text
                                                                    .length);
                                                      },
                                                      cursorColor: Colors.grey,
                                                      textAlign:
                                                          TextAlign.right,
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      onEditingComplete: () {
                                                        setState(() {
                                                          context
                                                              .read<
                                                                  PosController>()
                                                              .soOrderListQtychange(
                                                                  index,
                                                                  context,
                                                                  theme);
                                                        });
                                                        context
                                                            .read<
                                                                PosController>()
                                                            .disableKeyBoard(
                                                                context);
                                                      },
                                                      controller: context
                                                          .read<PosController>()
                                                          .soListController[index],
                                                      decoration:
                                                          InputDecoration(
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 5,
                                                          horizontal: 5,
                                                        ),
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          )))));
                        }),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[100],
              height: widget.searchHeight * 3.22,
              width: widget.searchWidth * 0.85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: widget.searchWidth * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.3),
                                spreadRadius: 3,
                                blurRadius: 2,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller:
                                context.read<PosController>().mycontroller[79],
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: Colors.black),
                            onChanged: (val) {},
                            onEditingComplete: () {
                              st(() {
                                context.read<PosController>().textError = '';

                                context.read<PosController>().soInvoiceScan(
                                      context
                                          .read<PosController>()
                                          .mycontroller[79]
                                          .text
                                          .toString()
                                          .trim()
                                          .toUpperCase(),
                                      context,
                                      theme,
                                    );
                              });
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(8),
                              hintText: "Scan Serial Batch",
                              hintStyle: theme.textTheme.bodyMedium!
                                  .copyWith(color: Colors.grey[600]),
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.search,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: widget.searchWidth * 0.01,
                        ),
                        Container(
                          width: widget.searchWidth * 0.18,
                          child: ElevatedButton(
                              onPressed: context
                                          .read<PosController>()
                                          .batchselectbtndisable ==
                                      true
                                  ? null
                                  : () async {
                                      setState(() {
                                        context
                                            .read<PosController>()
                                            .newadditemlistcount();
                                        if (context
                                                .read<PosController>()
                                                .addIndex
                                                .length >=
                                            1) {
                                          context
                                              .read<PosController>()
                                              .soFilterScanItem = [];

                                          context
                                              .read<PosController>()
                                              .batchselectbtndisable = true;

                                          context
                                              .read<PosController>()
                                              .callFetchFromPdaAllApi(
                                                  theme, context);
                                        } else if (context
                                                .read<PosController>()
                                                .selectIndex !=
                                            null) {
                                          context
                                              .read<PosController>()
                                              .callFetchFromPdaItemApi(
                                                  context
                                                      .read<PosController>()
                                                      .selectIndex!,
                                                  theme,
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
                                                        theme: theme,
                                                      )),
                                                      buttonName: null,
                                                    ));
                                              });
                                        }
                                      });
                                    },
                              child: Text('Fetch Batch From PDA')),
                        ),
                        SizedBox(
                          width: widget.searchWidth * 0.01,
                        ),
                        ElevatedButton(
                            onPressed: context
                                        .read<PosController>()
                                        .autoselectbtndisable ==
                                    true
                                ? null
                                : () {
                                    context
                                        .read<PosController>()
                                        .newadditemlistcount();
                                    if (context
                                            .read<PosController>()
                                            .addIndex
                                            .length >=
                                        1) {
                                      context.read<PosController>().soScanItem =
                                          [];
                                      log('selectIndexselectIndex::${context.read<PosController>().selectIndex}');

                                      setState(() {
                                        context
                                            .read<PosController>()
                                            .autoselectbtndisable = true;

                                        context
                                            .read<PosController>()
                                            .newAutoselectAllMethod(
                                              theme,
                                              context,
                                            );
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
                                                    content: 'Select Item List',
                                                    theme: theme,
                                                  )),
                                                  buttonName: null,
                                                ));
                                          });
                                    }
                                  },
                            child: Text('Auto Select')),
                        ElevatedButton(
                            onPressed: context
                                        .read<PosController>()
                                        .manualselectbtndisable ==
                                    true
                                ? null
                                : () {
                                    context
                                        .read<PosController>()
                                        .newadditemlistcount();
                                    if (context
                                            .read<PosController>()
                                            .addIndex
                                            .length ==
                                        1) {
                                      context
                                          .read<PosController>()
                                          .manualselectItemMethod(
                                              context
                                                  .read<PosController>()
                                                  .selectIndex!,
                                              theme,
                                              context);
                                    } else if (context
                                                .read<PosController>()
                                                .addIndex
                                                .length >
                                            1 ||
                                        context
                                                .read<PosController>()
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
                                                    theme: theme,
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
                                                        'Kindly Select Item List',
                                                    theme: theme,
                                                  )),
                                                  buttonName: null,
                                                ));
                                          });
                                    }
                                  },
                            child: Text('Manual Select')),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: widget.searchHeight * 0.01,
                  ),
                  context.watch<PosController>().noMsgText.isNotEmpty &&
                          context.watch<PosController>().selectIndex != null
                      ? Container(
                          child: Text(
                            context.watch<PosController>().noMsgText,
                            style: theme.textTheme.bodySmall
                                ?.copyWith(color: Colors.red),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: widget.searchHeight * 0.02,
                  ),
                  context.watch<PosController>().selectionBtnLoading == true
                      ? Container(
                          height: widget.searchHeight * 2.7,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: theme.primaryColor,
                            ),
                          ),
                        )
                      : context.watch<PosController>().soScanItem.isNotEmpty
                          ? Container(
                              child: Column(
                                children: [
                                  Container(
                                    width: widget.searchWidth * 1.3,
                                    padding: EdgeInsets.only(
                                      top: widget.searchHeight * 0.01,
                                      left: widget.searchWidth * 0.01,
                                      right: widget.searchWidth * 0.01,
                                    ),
                                    decoration: BoxDecoration(
                                      color: theme.primaryColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            padding: EdgeInsets.only(
                                              left: widget.searchWidth * 0.01,
                                            ),
                                            alignment: Alignment.center,
                                            width: widget.searchWidth * 0.3,
                                            child: Text(
                                              "Product Information",
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.white),
                                            )),
                                        Container(
                                            alignment: Alignment.center,
                                            width: widget.searchWidth * 0.13,
                                            child: Text(
                                              "S.O Qty",
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.white),
                                            )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: widget.searchHeight * 0.01,
                                  ),
                                  Container(
                                    height: widget.searchHeight * 1.1,
                                    width: widget.searchWidth * 1.3,
                                    child: ListView.builder(
                                        itemCount: context
                                            .watch<PosController>()
                                            .soFilterScanItem
                                            .length,
                                        itemBuilder: (context, index) {
                                          return Card(
                                            margin: EdgeInsets.all(2),
                                            child: Container(
                                                padding: EdgeInsets.only(
                                                  left: widget.searchHeight *
                                                      0.01,
                                                  right: widget.searchHeight *
                                                      0.01,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.grey
                                                      .withOpacity(0.04),
                                                ),
                                                child: Column(children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                          width: widget
                                                                  .searchWidth *
                                                              0.5,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "${context.watch<PosController>().soFilterScanItem[index].itemName}",
                                                            maxLines: 2,
                                                            style: theme
                                                                .textTheme
                                                                .bodyMedium
                                                                ?.copyWith(
                                                                    color: Colors
                                                                        .black),
                                                          )),
                                                      SizedBox(
                                                          width: widget.searchWidth *
                                                              0.3,
                                                          child: Container(
                                                              width: widget
                                                                      .searchWidth *
                                                                  0.2,
                                                              height: widget
                                                                      .searchHeight *
                                                                  0.09,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          widget.searchWidth *
                                                                              0.005),
                                                              child: Text(
                                                                "${context.watch<PosController>().soFilterScanItem[index].openRetQty}",
                                                              ))),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        widget.searchHeight *
                                                            0.01,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "${context.watch<PosController>().soFilterScanItem[index].serialBatch}",
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: theme
                                                                .textTheme
                                                                .bodyMedium
                                                                ?.copyWith(),
                                                          )),
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "  |  ${context.watch<PosController>().soFilterScanItem[index].itemCode}",
                                                          style: theme.textTheme
                                                              .bodyMedium
                                                              ?.copyWith(),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ])),
                                          );
                                        }),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if (context
                                              .read<PosController>()
                                              .soScanItem
                                              .isNotEmpty) {
                                            context
                                                .read<PosController>()
                                                .mapsodata(
                                                  context,
                                                  widget.theme,
                                                );
                                          } else {
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
                                                              'Scan the Serialbatch',
                                                          theme: widget.theme,
                                                        )),
                                                        buttonName: null,
                                                      ));
                                                });
                                          }
                                        });
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(12),
                                          width: widget.searchWidth * 1,
                                          alignment: Alignment.center,
                                          child: const Text('OK')))
                                ],
                              ),
                            )
                          : Container(),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
