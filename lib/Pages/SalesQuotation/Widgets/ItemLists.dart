import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:provider/provider.dart';
import '../../../Controller/SalesQuotationController/SalesQuotationController.dart';
import 'Dialog Box/SearchProduct.dart';

class SQuotationSearchWidget extends StatefulWidget {
  SQuotationSearchWidget(
      {super.key,
      required this.theme,
      required this.searchHeight,
      required this.searchWidth});

  final ThemeData theme;

  double searchHeight;
  double searchWidth;

  @override
  State<SQuotationSearchWidget> createState() => _SQuotationSearchWidgetState();
}

class _SQuotationSearchWidgetState extends State<SQuotationSearchWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: widget.searchHeight,
      width: widget.searchWidth,
      padding: EdgeInsets.only(
          top: widget.searchHeight * 0.01, bottom: widget.searchHeight * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          context.read<SalesQuotationCon>().scanneditemData2.isNotEmpty
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
                    readOnly: context.watch<SalesQuotationCon>().editqty,
                    autofocus: true,
                    style: theme.textTheme.bodyMedium,
                    cursorColor: Colors.grey,
                    controller: context.read<SalesQuotationCon>().searchcon,
                    onChanged: (v) async {
                      if (context
                              .read<SalesQuotationCon>()
                              .searchcon
                              .text
                              .isNotEmpty &&
                          v.isNotEmpty) {
                        context.read<SalesQuotationCon>().visibleItemList =
                            true;

                        await context.read<SalesQuotationCon>().getAllListItem(
                            context
                                .read<SalesQuotationCon>()
                                .searchcon
                                .text
                                .trim());
                        context
                            .read<SalesQuotationCon>()
                            .filterListItemSearched(v.trim());
                      } else {
                        setState(() {
                          context.read<SalesQuotationCon>().searchcon.text = '';
                          context.read<SalesQuotationCon>().visibleItemList =
                              false;
                          context
                              .read<SalesQuotationCon>()
                              .getfilterSearchedData = [];
                          context.read<SalesQuotationCon>().getSearchedData =
                              [];
                        });
                      }
                      log('context.read<SalesQuotationCon>().searchcon.text::${context.read<SalesQuotationCon>().searchcon.text}');
                    },
                    onEditingComplete: () async {
                      context
                          .read<SalesQuotationCon>()
                          .disableKeyBoard(context);
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
                              .read<SalesQuotationCon>()
                              .getAllList(context
                                  .read<SalesQuotationCon>()
                                  .searchcon
                                  .text
                                  .trim())
                              .then((value) {
                            showDialog<dynamic>(
                                context: context,
                                builder: (_) {
                                  return const SearchItemsSQ();
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
              visible: context.read<SalesQuotationCon>().visibleItemList,
              child: Expanded(
                child: ListView.builder(
                    itemCount: context
                        .read<SalesQuotationCon>()
                        .getfilterSearchedData
                        .length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          context.read<SalesQuotationCon>().visibleItemList =
                              false;
                          context
                              .read<SalesQuotationCon>()
                              .onselectVisibleItem(context, theme, index);
                        },
                        child: Card(
                          child: Container(
                              width: Screens.bodyheight(context) * 0.8,
                              padding: EdgeInsets.only(
                                left: Screens.width(context) * 0.01,
                                right: Screens.width(context) * 0.01,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                              ),
                              child: IntrinsicHeight(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${context.watch<SalesQuotationCon>().getfilterSearchedData[index].itemcode}"),
                                    Text(
                                        "${context.watch<SalesQuotationCon>().getfilterSearchedData[index].itemnameshort}"),
                                  ],
                                ),
                              )),
                        ),
                      );
                    }),
              )),
          Expanded(
              child: context
                      .watch<SalesQuotationCon>()
                      .getScanneditemData2
                      .isNotEmpty
                  ? ListView.builder(
                      itemCount: context
                          .watch<SalesQuotationCon>()
                          .getScanneditemData2
                          .length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.all(2),
                          child: Container(
                              padding: EdgeInsets.only(
                                top: widget.searchHeight * 0.01,
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
                                            child: Text(
                                              context
                                                  .watch<SalesQuotationCon>()
                                                  .getScanneditemData2[index]
                                                  .itemCode
                                                  .toString(),
                                              maxLines: 2,
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.black),
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              width: widget.searchWidth * 0.15,
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
                                                onTap: () {},
                                                onEditingComplete: () {},
                                                controller: context
                                                    .read<SalesQuotationCon>()
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
                                            width: widget.searchWidth * 0.19,
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              context
                                                  .watch<SalesQuotationCon>()
                                                  .config
                                                  .splitValues(
                                                      "${context.watch<SalesQuotationCon>().getScanneditemData2[index].sellPrice}"),
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                              width: widget.searchWidth * 0.09,
                                              height:
                                                  widget.searchHeight * 0.07,
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  '${context.watch<SalesQuotationCon>().getScanneditemData2[index].discountper}')),
                                          Container(
                                              width: widget.searchWidth * 0.19,
                                              height:
                                                  widget.searchHeight * 0.07,
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  '${context.read<SalesQuotationCon>().getScanneditemData2[index].priceAftDiscVal}')),
                                          Container(
                                              width: widget.searchWidth * 0.19,
                                              height:
                                                  widget.searchHeight * 0.07,
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  '${context.read<SalesQuotationCon>().getScanneditemData2[index].taxable}')),
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
                                        "${context.watch<SalesQuotationCon>().getScanneditemData2[index].itemName}",
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(),
                                      ),
                                    ),
                                    Container(
                                      width: widget.searchWidth * 0.17,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                          context
                                                      .watch<
                                                          SalesQuotationCon>()
                                                      .getScanneditemData2[
                                                          index]
                                                      .taxRate ==
                                                  null
                                              ? '00'
                                              : 'Tax :  ${context.read<SalesQuotationCon>().getScanneditemData2[index].taxRate} %',
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(color: Colors.black)),
                                    ),
                                  ],
                                )
                              ])),
                        );
                      })
                  : context.watch<SalesQuotationCon>().visibleItemList == false
                      ? ListView.builder(
                          itemCount: context
                              .watch<SalesQuotationCon>()
                              .getScanneditemData
                              .length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: EdgeInsets.all(2),
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                    padding: EdgeInsets.only(
                                      top: widget.searchHeight * 0.01,
                                      bottom: widget.searchHeight * 0.01,
                                      left: widget.searchHeight * 0.01,
                                      right: widget.searchHeight * 0.005,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey.withOpacity(0.04),
                                    ),
                                    child: Column(children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              " ${context.watch<SalesQuotationCon>().getScanneditemData[index].itemCode}",
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(),
                                            ),
                                          ),
                                          Container(
                                            width: widget.searchWidth * 0.76,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                    width: widget.searchWidth *
                                                        0.15,
                                                    height:
                                                        widget.searchHeight *
                                                            0.07,
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal:
                                                            widget.searchWidth *
                                                                0.005),
                                                    child: TextFormField(
                                                      textAlign:
                                                          TextAlign.right,
                                                      onChanged: (val) {
                                                        context
                                                            .read<
                                                                SalesQuotationCon>()
                                                            .doubleDotMethod(
                                                                index,
                                                                val,
                                                                'Qty');
                                                      },
                                                      onTap: () {
                                                        context
                                                                .read<
                                                                    SalesQuotationCon>()
                                                                .qtymycontroller[
                                                                    index]
                                                                .text =
                                                            context
                                                                .read<
                                                                    SalesQuotationCon>()
                                                                .qtymycontroller[
                                                                    index]
                                                                .text;
                                                        context
                                                                .read<
                                                                    SalesQuotationCon>()
                                                                .qtymycontroller[
                                                                    index]
                                                                .selection =
                                                            TextSelection(
                                                          baseOffset: 0,
                                                          extentOffset: context
                                                              .read<
                                                                  SalesQuotationCon>()
                                                              .qtymycontroller[
                                                                  index]
                                                              .text
                                                              .length,
                                                        );
                                                      },
                                                      style: theme
                                                          .textTheme.bodyMedium
                                                          ?.copyWith(
                                                              color:
                                                                  Colors.black),
                                                      cursorColor: Colors.grey,
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        DecimalInputFormatter()
                                                      ],
                                                      onEditingComplete: () {
                                                        context
                                                            .read<
                                                                SalesQuotationCon>()
                                                            .qtyEdited(index,
                                                                context, theme);
                                                        context
                                                            .read<
                                                                SalesQuotationCon>()
                                                            .disableKeyBoard(
                                                                context);
                                                      },
                                                      controller: context
                                                          .read<
                                                              SalesQuotationCon>()
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
                                                context
                                                            .watch<
                                                                SalesQuotationCon>()
                                                            .userTypes ==
                                                        'corporate'
                                                    ? Container(
                                                        width:
                                                            widget.searchWidth *
                                                                0.15,
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
                                                          onChanged: (val) {
                                                            context
                                                                .read<
                                                                    SalesQuotationCon>()
                                                                .doubleDotMethod(
                                                                    index,
                                                                    val,
                                                                    'Price');
                                                          },
                                                          onTap: () {
                                                            context
                                                                    .read<
                                                                        SalesQuotationCon>()
                                                                    .pricemycontroller[
                                                                        index]
                                                                    .text =
                                                                context
                                                                    .read<
                                                                        SalesQuotationCon>()
                                                                    .pricemycontroller[
                                                                        index]
                                                                    .text;
                                                            context
                                                                    .read<
                                                                        SalesQuotationCon>()
                                                                    .pricemycontroller[
                                                                        index]
                                                                    .selection =
                                                                TextSelection(
                                                              baseOffset: 0,
                                                              extentOffset: context
                                                                  .read<
                                                                      SalesQuotationCon>()
                                                                  .pricemycontroller[
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
                                                          inputFormatters: [
                                                            DecimalInputFormatter()
                                                          ],
                                                          onEditingComplete:
                                                              () {
                                                            context
                                                                .read<
                                                                    SalesQuotationCon>()
                                                                .priceChanged(
                                                                    index,
                                                                    context,
                                                                    theme);
                                                            context
                                                                .read<
                                                                    SalesQuotationCon>()
                                                                .disableKeyBoard(
                                                                    context);
                                                          },
                                                          controller: context
                                                              .read<
                                                                  SalesQuotationCon>()
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
                                                        ))
                                                    : Container(
                                                        width:
                                                            widget.searchWidth *
                                                                0.17,
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Text(
                                                          context
                                                              .watch<
                                                                  SalesQuotationCon>()
                                                              .config
                                                              .splitValues(
                                                                  "${context.watch<SalesQuotationCon>().getScanneditemData[index].sellPrice}"),
                                                          style: theme.textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                context.watch<SalesQuotationCon>().userTypes ==
                                                            'corporate' ||
                                                        context
                                                                .watch<
                                                                    SalesQuotationCon>()
                                                                .userTypes ==
                                                            'retail'
                                                    ? Container(
                                                        width:
                                                            widget
                                                                    .searchWidth *
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
                                                          onChanged: (val) {
                                                            context
                                                                .read<
                                                                    SalesQuotationCon>()
                                                                .doubleDotMethod(
                                                                    index,
                                                                    val,
                                                                    'Discount');
                                                          },
                                                          onTap: () {
                                                            context
                                                                    .read<
                                                                        SalesQuotationCon>()
                                                                    .discountcontroller[
                                                                        index]
                                                                    .text =
                                                                context
                                                                    .read<
                                                                        SalesQuotationCon>()
                                                                    .discountcontroller[
                                                                        index]
                                                                    .text;
                                                            context
                                                                    .read<
                                                                        SalesQuotationCon>()
                                                                    .discountcontroller[
                                                                        index]
                                                                    .selection =
                                                                TextSelection(
                                                              baseOffset: 0,
                                                              extentOffset: context
                                                                  .read<
                                                                      SalesQuotationCon>()
                                                                  .discountcontroller[
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
                                                          inputFormatters: [
                                                            DecimalInputFormatter()
                                                          ],
                                                          onEditingComplete:
                                                              () {
                                                            context
                                                                .read<
                                                                    SalesQuotationCon>()
                                                                .discountChanged(
                                                                    index,
                                                                    context,
                                                                    theme);
                                                            context
                                                                .read<
                                                                    SalesQuotationCon>()
                                                                .disableKeyBoard(
                                                                    context);
                                                          },
                                                          controller: context
                                                              .read<
                                                                  SalesQuotationCon>()
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
                                                        ))
                                                    : Container(
                                                        width:
                                                            widget.searchWidth *
                                                                0.08,
                                                        height:
                                                            widget.searchHeight *
                                                                0.07,
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child:
                                                            Text('${context.watch<SalesQuotationCon>().scanneditemData[index].discountper!.toStringAsFixed(2)}')),
                                                Container(
                                                  width:
                                                      widget.searchWidth * 0.15,
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    context
                                                                .watch<
                                                                    SalesQuotationCon>()
                                                                .getScanneditemData[
                                                                    index]
                                                                .priceAftDiscVal !=
                                                            null
                                                        ? context
                                                            .watch<
                                                                SalesQuotationCon>()
                                                            .config
                                                            .splitValues(
                                                                "${context.watch<SalesQuotationCon>().getScanneditemData[index].priceAftDiscVal}")
                                                        : '0.0',
                                                    style: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            color:
                                                                Colors.black),
                                                  ),
                                                ),
                                                Container(
                                                  width:
                                                      widget.searchWidth * 0.16,
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                      context
                                                                  .watch<
                                                                      SalesQuotationCon>()
                                                                  .getScanneditemData[
                                                                      index]
                                                                  .taxable ==
                                                              null
                                                          ? '00'
                                                          : ' ${context.watch<SalesQuotationCon>().config.splitValues(context.watch<SalesQuotationCon>().getScanneditemData[index].taxable!.toStringAsFixed(2))}',
                                                      style: theme
                                                          .textTheme.bodyMedium
                                                          ?.copyWith(
                                                              color: Colors
                                                                  .black)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: widget.searchHeight * 0.01,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          context
                                                      .watch<
                                                          SalesQuotationCon>()
                                                      .userTypes
                                                      .toLowerCase() ==
                                                  'corporate'
                                              ? Container(
                                                  width:
                                                      widget.searchWidth * 0.5,
                                                  height: widget.searchHeight *
                                                      0.07,
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          widget.searchWidth *
                                                              0.005),
                                                  child: TextFormField(
                                                    onChanged: (val) {
                                                      context
                                                          .read<
                                                              SalesQuotationCon>()
                                                          .itemnameChanged(
                                                              index,
                                                              context,
                                                              theme);
                                                    },
                                                    onTap: () {
                                                      context
                                                              .read<
                                                                  SalesQuotationCon>()
                                                              .itemNameController[
                                                                  index]
                                                              .text =
                                                          context
                                                              .read<
                                                                  SalesQuotationCon>()
                                                              .itemNameController[
                                                                  index]
                                                              .text;
                                                      context
                                                          .read<
                                                              SalesQuotationCon>()
                                                          .itemNameController[
                                                              index]
                                                          .selection = TextSelection(
                                                        baseOffset: 0,
                                                        extentOffset: context
                                                            .read<
                                                                SalesQuotationCon>()
                                                            .itemNameController[
                                                                index]
                                                            .text
                                                            .length,
                                                      );
                                                    },
                                                    style: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            color:
                                                                Colors.black),
                                                    cursorColor: Colors.grey,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    onEditingComplete: () {
                                                      context
                                                          .read<
                                                              SalesQuotationCon>()
                                                          .itemnameChanged(
                                                              index,
                                                              context,
                                                              theme);
                                                      context
                                                          .read<
                                                              SalesQuotationCon>()
                                                          .disableKeyBoard(
                                                              context);
                                                    },
                                                    controller: context
                                                        .read<
                                                            SalesQuotationCon>()
                                                        .itemNameController[index],
                                                    decoration: InputDecoration(
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
                                                  ))
                                              : Container(
                                                  width:
                                                      widget.searchWidth * 0.5,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    context
                                                            .watch<
                                                                SalesQuotationCon>()
                                                            .getScanneditemData[
                                                                index]
                                                            .itemName ??
                                                        '',
                                                    maxLines: 2,
                                                    style: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            color:
                                                                Colors.black),
                                                  )),
                                          SizedBox(
                                            width:
                                                Screens.width(context) * 0.005,
                                          ),
                                          Container(
                                            width: widget.searchWidth * 0.14,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                context
                                                            .read<
                                                                SalesQuotationCon>()
                                                            .getScanneditemData[
                                                                index]
                                                            .taxRate ==
                                                        null
                                                    ? 'Tax :00'
                                                    : 'Tax :${context.watch<SalesQuotationCon>().getScanneditemData[index].taxRate!.toStringAsFixed(2)}%',
                                                style: theme
                                                    .textTheme.bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.black)),
                                          ),
                                          Container(
                                            // color: Colors.red,
                                            width: widget.searchWidth * 0.155,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                context
                                                            .watch<
                                                                SalesQuotationCon>()
                                                            .getScanneditemData[
                                                                index]
                                                            .inStockQty ==
                                                        null
                                                    ? 'IS : 00'
                                                    : 'IS : ${context.read<SalesQuotationCon>().getScanneditemData[index].inStockQty}',
                                                style: theme
                                                    .textTheme.bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.black)),
                                          ),
                                        ],
                                      )
                                    ])),
                              ),
                            );
                          })
                      : Container()),
        ],
      ),
    );
  }
}

class DecimalInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    if (text.contains('.') && text.indexOf('.') != text.lastIndexOf('.')) {
      return oldValue;
    }

    return newValue;
  }
}
