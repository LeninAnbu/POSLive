import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:posproject/Pages/SalesOrder/Widgets/Dialog%20Box/SearchProduct.dart';
import 'package:provider/provider.dart';
import '../../../Constant/Screen.dart';
import '../../../Controller/SalesOrderController/SalesOrderController.dart';
import '../../SalesQuotation/Widgets/ItemLists.dart';

class SOSearchWidget extends StatefulWidget {
  SOSearchWidget(
      {super.key,
      required this.theme,
      required this.searchHeight,
      required this.searchWidth});

  final ThemeData theme;

  double searchHeight;
  double searchWidth;

  @override
  State<SOSearchWidget> createState() => _SOSearchWidgetState();
}

class _SOSearchWidgetState extends State<SOSearchWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Container(
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
            context.watch<SOCon>().scanneditemData2.isNotEmpty ||
                    context.watch<SOCon>().cpyfrmsq == true
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
                      readOnly: context.watch<SOCon>().editqty,
                      autofocus: true,
                      focusNode: context.watch<SOCon>().focusnode[0],
                      style: theme.textTheme.bodyMedium,
                      cursorColor: Colors.grey,
                      controller: context.watch<SOCon>().searchcon,
                      onChanged: (v) async {
                        if (context.read<SOCon>().searchcon.text.isNotEmpty &&
                            v.isNotEmpty) {
                          context.read<SOCon>().visibleItemList = true;

                          await context.read<SOCon>().getAllListItem(
                              context.read<SOCon>().searchcon.text.trim());
                          context
                              .read<SOCon>()
                              .filterListItemSearched(v.trim());
                        } else {
                          setState(() {
                            context.read<SOCon>().searchcon.text = '';
                            context.read<SOCon>().visibleItemList = false;
                            context.read<SOCon>().getfilterSearchedData = [];
                            context.read<SOCon>().getSearchedData = [];
                          });
                        }
                        log('context.read<SOCon>().searchcon.text::${context.read<SOCon>().searchcon.text}');
                      },
                      onEditingComplete: () async {
                        // await context.read<SOCon>().getAllList(
                        //     context.read<SOCon>().searchcon.text.trim());

                        // if (context.read<SOCon>().getSearchedData.isEmpty) {
                        //   showDialog(
                        //       context: context,
                        //       barrierDismissible: true,
                        //       builder: (BuildContext context) {
                        //         return AlertDialog(
                        //             contentPadding: const EdgeInsets.all(0),
                        //             content: AlertBox(
                        //               payMent: 'Alert',
                        //               errormsg: true,
                        //               widget: Center(
                        //                   child: ContentContainer(
                        //                 content: 'Wrong Itemcode scanned..!!',
                        //                 theme: theme,
                        //               )),
                        //               buttonName: null,
                        //             ));
                        //       });
                        // } else if (context
                        //         .read<SOCon>()
                        //         .getSearchedData
                        //         .length ==
                        //     1) {
                        // context
                        //     .read<SOCon>()
                        //     .singleitemsearch(context, theme, 0);
                        // } else {
                        //   showDialog<dynamic>(
                        //       context: context,
                        //       builder: (_) {
                        //         return const SearchItemsSO();
                        //       });
                        // }

                        context.read<SOCon>().disableKeyBoard(context);
                      },
                      decoration: InputDecoration(
                        filled: false,
                        hintText: 'Inventories',
                        hintStyle: theme.textTheme.bodyMedium?.copyWith(),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        suffixIcon: IconButton(
                          onPressed: () {
                            context
                                .read<SOCon>()
                                .getAllList(
                                    context.read<SOCon>().searchcon.text.trim())
                                .then((value) {
                              showDialog<dynamic>(
                                  context: context,
                                  builder: (_) {
                                    return const SearchItemsSO();
                                  });
                            });
                          },
                          icon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          color: theme.primaryColor,
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
                left: widget.searchWidth * 0.01,
                // right: widget.searchWidth * 0.01,
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
                          left: widget.searchWidth * 0.01,
                        ),
                        alignment: Alignment.centerLeft,
                        width: widget.searchWidth * 0.25,
                        child: Text(
                          "Product Information",
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.white),
                        )),
                  ),
                  Container(
                    width: widget.searchWidth * 0.72,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            width: widget.searchWidth * 0.07,
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
            Visibility(
                visible: context.read<SOCon>().visibleItemList,
                child: Container(
                  height: widget.searchHeight * 0.6,
                  child: ListView.builder(
                      itemCount:
                          context.read<SOCon>().getfilterSearchedData.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            context.read<SOCon>().visibleItemList = false;
                            context
                                .read<SOCon>()
                                .onselectVisibleItem(context, theme, index);
                          },
                          child: Card(
                            child: Container(
                                width: Screens.bodyheight(context) * 0.8,
                                padding: EdgeInsets.only(
                                  // top: Screens.bodyheight(context) * 0.01,
                                  left: Screens.width(context) * 0.01,
                                  right: Screens.width(context) * 0.01,
                                  // bottom: Screens.bodyheight(context) * 0.005,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                ),
                                child: IntrinsicHeight(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${context.watch<SOCon>().getfilterSearchedData[index].itemcode}"),
                                      Text(
                                          "${context.watch<SOCon>().getfilterSearchedData[index].itemnameshort}"),
                                    ],
                                  ),
                                )),
                          ),
                        );
                      }),
                )),
            Expanded(
              child: context.read<SOCon>().getScanneditemData2.isNotEmpty
                  ? ListView.builder(
                      itemCount:
                          context.read<SOCon>().getScanneditemData2.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.all(2),
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
                                                  context
                                                      .watch<SOCon>()
                                                      .getScanneditemData2[
                                                          index]
                                                      .itemCode
                                                      .toString(),
                                                  maxLines: 2,
                                                  style: theme
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                          color: Colors.black),
                                                ))),
                                      ],
                                    ),
                                    Container(
                                      width: widget.searchWidth * 0.77,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              width: widget.searchWidth * 0.12,
                                              height:
                                                  widget.searchHeight * 0.07,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      widget.searchWidth *
                                                          0.005),
                                              child: TextFormField(
                                                readOnly: true,
                                                textAlign: TextAlign.right,
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
                                                    .read<SOCon>()
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
                                                            color: Colors.grey),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
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
                                            width: widget.searchWidth * 0.17,
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              context
                                                  .watch<SOCon>()
                                                  .config
                                                  .splitValues(
                                                      "${context.watch<SOCon>().getScanneditemData2[index].sellPrice}"),
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                              width: widget.searchWidth * 0.09,
                                              height:
                                                  widget.searchHeight * 0.07,
                                              alignment: Alignment.center,
                                              child: Text(
                                                  '${context.watch<SOCon>().getScanneditemData2[index].discountper}')),
                                          Container(
                                              width: widget.searchWidth * 0.15,
                                              height:
                                                  widget.searchHeight * 0.07,
                                              alignment: Alignment.center,
                                              child: Text(context
                                                          .watch<SOCon>()
                                                          .getScanneditemData2[
                                                              index]
                                                          .priceAftDiscVal !=
                                                      null
                                                  ? '${context.watch<SOCon>().config.splitValues(context.watch<SOCon>().getScanneditemData2[index].priceAftDiscVal!.toStringAsFixed(2))}'
                                                  : '0.0')),
                                          Container(
                                              width: widget.searchWidth * 0.15,
                                              height:
                                                  widget.searchHeight * 0.07,
                                              alignment: Alignment.center,
                                              child: Text(context
                                                          .watch<SOCon>()
                                                          .getScanneditemData2[
                                                              index]
                                                          .taxable !=
                                                      null
                                                  ? '${context.watch<SOCon>().config.splitValues(context.watch<SOCon>().getScanneditemData2[index].taxable!.toStringAsFixed(2))}'
                                                  : '0.00')),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      width: widget.searchWidth * 0.7,
                                      child: Text(
                                        "${context.watch<SOCon>().getScanneditemData2[index].itemName}",
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(),
                                      ),
                                    ),
                                    SizedBox(
                                      width: widget.searchWidth * 0.01,
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Tax : ${context.watch<SOCon>().getScanneditemData2[index].taxRate ?? 0} %",
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(),
                                      ),
                                    ),
                                  ],
                                )
                              ])),
                        );
                      })
                  : context.watch<SOCon>().visibleItemList == false
                      ? Container(
                          child: ListView.builder(
                              itemCount: context
                                  .watch<SOCon>()
                                  .getScanneditemData
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.grey.withOpacity(0.04),
                                        ),
                                        child: Column(children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                      width:
                                                          widget.searchWidth *
                                                              0.18,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: TextButton(
                                                          onPressed: () {},
                                                          child: Text(
                                                            context
                                                                    .read<
                                                                        SOCon>()
                                                                    .getScanneditemData[
                                                                        index]
                                                                    .itemCode ??
                                                                '',
                                                            maxLines: 2,
                                                            style: theme
                                                                .textTheme
                                                                .bodyMedium
                                                                ?.copyWith(
                                                                    color: Colors
                                                                        .black),
                                                          ))),
                                                ],
                                              ),
                                              Container(
                                                width:
                                                    widget.searchWidth * 0.785,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        width:
                                                            widget.searchWidth *
                                                                0.12,
                                                        height: widget
                                                                .searchHeight *
                                                            0.07,
                                                        alignment:
                                                            Alignment.center,
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal: widget
                                                                    .searchWidth *
                                                                0.005),
                                                        child: TextFormField(
                                                          textAlign:
                                                              TextAlign.right,
                                                          onTap: () {
                                                            context
                                                                    .read<SOCon>()
                                                                    .qtymycontroller[
                                                                        index]
                                                                    .text =
                                                                context
                                                                    .read<
                                                                        SOCon>()
                                                                    .qtymycontroller[
                                                                        index]
                                                                    .text;
                                                            context
                                                                    .read<SOCon>()
                                                                    .qtymycontroller[
                                                                        index]
                                                                    .selection =
                                                                TextSelection(
                                                              baseOffset: 0,
                                                              extentOffset: context
                                                                  .read<SOCon>()
                                                                  .qtymycontroller[
                                                                      index]
                                                                  .text
                                                                  .length,
                                                            );
                                                          },
                                                          style: theme.textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                                  color: Colors
                                                                      .black),
                                                          cursorColor:
                                                              Colors.grey,
                                                          textDirection:
                                                              TextDirection.ltr,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          onChanged: (val) {
                                                            context
                                                                .read<SOCon>()
                                                                .doubleDotMethod(
                                                                    index,
                                                                    val,
                                                                    'Qty');
                                                          },
                                                          inputFormatters: [
                                                            DecimalInputFormatter()
                                                          ],
                                                          // inputFormatters: [
                                                          //   context.watch<SOCon>().getScanneditemData[index].uPackSize ==
                                                          //               null ||
                                                          //           context
                                                          //                   .watch<
                                                          //                       SOCon>()
                                                          //                   .getScanneditemData[
                                                          //                       index]
                                                          //                   .uPackSize ==
                                                          //               0.000
                                                          //       ? FilteringTextInputFormatter
                                                          //           .allow(RegExp(
                                                          //               dotAll:
                                                          //                   true,
                                                          //               r'^\d*\.?\d{0,9}$'))
                                                          //       : FilteringTextInputFormatter
                                                          //           .digitsOnly
                                                          // ],
                                                          onEditingComplete:
                                                              () {
                                                            if (context
                                                                    .read<
                                                                        SOCon>()
                                                                    .cpyfrmsq ==
                                                                true) {
                                                              context
                                                                  .read<SOCon>()
                                                                  .sqQtyEdited(
                                                                      index,
                                                                      context,
                                                                      theme);
                                                            } else {
                                                              context
                                                                  .read<SOCon>()
                                                                  .qtyEdited(
                                                                      index,
                                                                      context,
                                                                      theme);
                                                            }
                                                            context
                                                                .read<SOCon>()
                                                                .disableKeyBoard(
                                                                    context);
                                                          },
                                                          controller: context
                                                                  .watch<SOCon>()
                                                                  .qtymycontroller[
                                                              index],
                                                          decoration:
                                                              InputDecoration(
                                                            filled: false,
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
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
                                                                          5),
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
                                                    context
                                                                .watch<SOCon>()
                                                                .userTypes ==
                                                            'corporate'
                                                        ? Container(
                                                            width: widget
                                                                    .searchWidth *
                                                                0.15,
                                                            height: widget
                                                                    .searchHeight *
                                                                0.07,
                                                            alignment: Alignment
                                                                .center,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        widget.searchWidth *
                                                                            0.005),
                                                            child:
                                                                TextFormField(
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              onChanged: (val) {
                                                                context
                                                                    .read<
                                                                        SOCon>()
                                                                    .doubleDotMethod(
                                                                        index,
                                                                        val,
                                                                        'Price');
                                                              },
                                                              onTap: () {
                                                                context
                                                                        .read<
                                                                            SOCon>()
                                                                        .pricemycontroller[
                                                                            index]
                                                                        .text =
                                                                    context
                                                                        .read<
                                                                            SOCon>()
                                                                        .pricemycontroller[
                                                                            index]
                                                                        .text;
                                                                context
                                                                    .read<
                                                                        SOCon>()
                                                                    .pricemycontroller[
                                                                        index]
                                                                    .selection = TextSelection(
                                                                  baseOffset: 0,
                                                                  extentOffset: context
                                                                      .read<
                                                                          SOCon>()
                                                                      .pricemycontroller[
                                                                          index]
                                                                      .text
                                                                      .length,
                                                                );
                                                              },
                                                              style: theme
                                                                  .textTheme
                                                                  .bodyMedium
                                                                  ?.copyWith(
                                                                      color: Colors
                                                                          .black),
                                                              cursorColor:
                                                                  Colors.grey,
                                                              textDirection:
                                                                  TextDirection
                                                                      .ltr,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              inputFormatters: [
                                                                DecimalInputFormatter()
                                                              ],
                                                              onEditingComplete:
                                                                  () {
                                                                context
                                                                    .read<
                                                                        SOCon>()
                                                                    .priceChanged(
                                                                        index,
                                                                        context,
                                                                        theme);
                                                                context
                                                                    .read<
                                                                        SOCon>()
                                                                    .disableKeyBoard(
                                                                        context);
                                                              },
                                                              controller: context
                                                                  .read<SOCon>()
                                                                  .pricemycontroller[index],
                                                              decoration:
                                                                  InputDecoration(
                                                                filled: false,
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  borderSide:
                                                                      const BorderSide(
                                                                          color:
                                                                              Colors.grey),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
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
                                                            ))
                                                        : Container(
                                                            width: widget
                                                                    .searchWidth *
                                                                0.19,
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Text(
                                                              context
                                                                  .read<SOCon>()
                                                                  .config
                                                                  .splitValues(
                                                                      "${context.watch<SOCon>().getScanneditemData[index].sellPrice}"),
                                                              style: theme
                                                                  .textTheme
                                                                  .bodyMedium
                                                                  ?.copyWith(
                                                                      color: Colors
                                                                          .black),
                                                            ),
                                                          ),
                                                    context
                                                                .watch<SOCon>()
                                                                .userTypes ==
                                                            'corporate'
                                                        ? Container(
                                                            width: widget.searchWidth *
                                                                0.15,
                                                            height: widget
                                                                    .searchHeight *
                                                                0.07,
                                                            alignment: Alignment
                                                                .center,
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal:
                                                                    widget.searchWidth *
                                                                        0.005),
                                                            child:
                                                                TextFormField(
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              onChanged: (val) {
                                                                context
                                                                    .read<
                                                                        SOCon>()
                                                                    .doubleDotMethod(
                                                                        index,
                                                                        val,
                                                                        'Discount');
                                                              },
                                                              onTap: () {
                                                                context
                                                                        .read<
                                                                            SOCon>()
                                                                        .discountcontroller[
                                                                            index]
                                                                        .text =
                                                                    context
                                                                        .read<
                                                                            SOCon>()
                                                                        .discountcontroller[
                                                                            index]
                                                                        .text;
                                                                context
                                                                    .read<
                                                                        SOCon>()
                                                                    .discountcontroller[
                                                                        index]
                                                                    .selection = TextSelection(
                                                                  baseOffset: 0,
                                                                  extentOffset: context
                                                                      .read<
                                                                          SOCon>()
                                                                      .discountcontroller[
                                                                          index]
                                                                      .text
                                                                      .length,
                                                                );
                                                              },
                                                              style: theme
                                                                  .textTheme
                                                                  .bodyMedium
                                                                  ?.copyWith(
                                                                      color: Colors
                                                                          .black),
                                                              cursorColor:
                                                                  Colors.grey,
                                                              textDirection:
                                                                  TextDirection
                                                                      .ltr,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              inputFormatters: [
                                                                DecimalInputFormatter()
                                                              ],
                                                              onEditingComplete:
                                                                  () {
                                                                context
                                                                    .read<
                                                                        SOCon>()
                                                                    .discountChanged(
                                                                        index,
                                                                        context,
                                                                        theme);
                                                                context
                                                                    .read<
                                                                        SOCon>()
                                                                    .disableKeyBoard(
                                                                        context);
                                                              },
                                                              controller: context
                                                                  .read<SOCon>()
                                                                  .discountcontroller[index],
                                                              decoration:
                                                                  InputDecoration(
                                                                filled: false,
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  borderSide:
                                                                      const BorderSide(
                                                                          color:
                                                                              Colors.grey),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
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
                                                            ))
                                                        : Container(
                                                            width: widget
                                                                    .searchWidth *
                                                                0.08,
                                                            height: widget
                                                                    .searchHeight *
                                                                0.07,
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Text(
                                                                "${context.watch<SOCon>().getScanneditemData[index].discountper!.toStringAsFixed(2)}")),
                                                    Container(
                                                        width:
                                                            widget.searchWidth *
                                                                0.17,
                                                        height: widget
                                                                .searchHeight *
                                                            0.07,
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Text(context
                                                            .read<SOCon>()
                                                            .config
                                                            .splitValues(
                                                                "${context.watch<SOCon>().getScanneditemData[index].priceAftDiscVal}"))),
                                                    Container(
                                                      width:
                                                          widget.searchWidth *
                                                              0.19,
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        context
                                                            .read<SOCon>()
                                                            .config
                                                            .splitValues(
                                                                "${context.watch<SOCon>().getScanneditemData[index].taxable}"),
                                                        style: theme.textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width:
                                                    widget.searchWidth * 0.65,
                                                child: Text(
                                                  " ${context.watch<SOCon>().getScanneditemData[index].itemName}",
                                                  style: theme
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(),
                                                ),
                                              ),
                                              Container(
                                                width:
                                                    widget.searchWidth * 0.14,
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                    context
                                                                .read<SOCon>()
                                                                .getScanneditemData[
                                                                    index]
                                                                .taxRate ==
                                                            null
                                                        ? '00'
                                                        : 'Tax : ${context.watch<SOCon>().getScanneditemData[index].taxRate!.toStringAsFixed(2)} %',
                                                    style: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            color:
                                                                Colors.black)),
                                              ),
                                            ],
                                          )
                                        ])),
                                  ),
                                );
                              }),
                        )
                      : Container(),
            )
          ],
        ),
      ),
    );
  }
}
