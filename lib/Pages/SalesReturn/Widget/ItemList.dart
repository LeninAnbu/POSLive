import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:posproject/main.dart';
import 'package:provider/provider.dart';
import '../../../Controller/SalesReturnController/SalesReturnController.dart';

class SalesReturnItem extends StatefulWidget {
  SalesReturnItem(
      {super.key,
      required this.theme,
      required this.searchHeight,
      required this.searchWidth});

  final ThemeData theme;

  double searchHeight;
  double searchWidth;

  @override
  State<SalesReturnItem> createState() => _SalesReturnItemState();
}

class _SalesReturnItemState extends State<SalesReturnItem> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: widget.searchHeight,
      width: widget.searchWidth,
      padding: EdgeInsets.only(
          top: widget.searchHeight * 0.05,
          left: widget.searchHeight * 0.01,
          right: widget.searchHeight * 0.01,
          bottom: widget.searchHeight * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: widget.searchHeight * 0.01,
              left: widget.searchHeight * 0.01,
              right: widget.searchHeight * 0.02,
              bottom: widget.searchHeight * 0.01,
            ),
            decoration: BoxDecoration(
              color: theme.primaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<SalesReturnController>().viewSalesRet();
                  },
                  child: Container(
                      padding: EdgeInsets.only(
                        left: widget.searchHeight * 0.01,
                      ),
                      alignment: Alignment.centerLeft,
                      width: widget.searchWidth * 0.3,
                      child: Text(
                        "Product Information",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.white),
                      )),
                ),
                SizedBox(
                  width: widget.searchWidth * 0.65,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          alignment: Alignment.center,
                          width: widget.searchWidth * 0.1,
                          child: Text(
                            "Qty",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          )),
                      Container(
                          alignment: Alignment.center,
                          width: widget.searchWidth * 0.13,
                          child: Text(
                            "Discount %",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          )),
                      Container(
                          alignment: Alignment.center,
                          width: widget.searchWidth * 0.13,
                          child: Text(
                            "Tax %",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          )),
                      Container(
                          alignment: Alignment.centerRight,
                          width: widget.searchWidth * 0.15,
                          child: Text(
                            "Price",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          context.watch<SalesReturnController>().getScanneditemData2.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                      itemCount: context
                          .watch<SalesReturnController>()
                          .getScanneditemData2
                          .length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Container(
                              padding: EdgeInsets.only(
                                top: widget.searchHeight * 0.01,
                                left: widget.searchHeight * 0.01,
                                right: widget.searchHeight * 0.01,
                                bottom: widget.searchHeight * 0.02,
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
                                            width: widget.searchWidth * 0.37,
                                            alignment: Alignment.centerLeft,
                                            child: TextButton(
                                                onPressed: () {},
                                                child: Text(
                                                  "${context.watch<SalesReturnController>().getScanneditemData2[index].itemName}",
                                                  maxLines: 2,
                                                  style: theme
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                          color: Colors.black),
                                                ))),
                                      ],
                                    ),
                                    Container(
                                        width: widget.searchWidth * 0.15,
                                        height: widget.searchHeight * 0.07,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                widget.searchWidth * 0.005),
                                        child: TextFormField(
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(color: Colors.black),
                                          onChanged: (v) {},
                                          cursorColor: Colors.grey,
                                          textDirection: TextDirection.rtl,
                                          keyboardType: TextInputType.number,
                                          readOnly: true,
                                          onEditingComplete: () {},
                                          controller: context
                                              .watch<SalesReturnController>()
                                              .qtymycontroller2[index],
                                          decoration: InputDecoration(
                                            filled: false,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              borderSide: const BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              borderSide: const BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              vertical: 0,
                                              horizontal: 5,
                                            ),
                                          ),
                                        )),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      width: widget.searchWidth * 0.08,
                                      alignment: Alignment.center,
                                      child: Text(
                                        context
                                            .watch<SalesReturnController>()
                                            .getScanneditemData2[index]
                                            .discountper
                                            .toString(),
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                      width: widget.searchWidth * 0.16,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                          context
                                                      .watch<
                                                          SalesReturnController>()
                                                      .getScanneditemData2[
                                                          index]
                                                      .taxRate !=
                                                  null
                                              ? context
                                                  .watch<
                                                      SalesReturnController>()
                                                  .getScanneditemData2[index]
                                                  .taxRate!
                                                  .toStringAsFixed(2)
                                              : '0',
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(color: Colors.black)),
                                    ),
                                    Container(
                                      width: widget.searchWidth * 0.16,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "${config.splitValues(context.watch<SalesReturnController>().getScanneditemData2[index].sellPrice!.toStringAsFixed(2))}",
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(color: Colors.black),
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
                                          "${context.watch<SalesReturnController>().getScanneditemData2[index].serialBatch}",
                                          textAlign: TextAlign.start,
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(),
                                        )),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "  |  ${context.watch<SalesReturnController>().getScanneditemData2[index].itemCode}",
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(),
                                      ),
                                    ),
                                  ],
                                )
                              ])),
                        );
                      }))
              : context.watch<SalesReturnController>().isloading == true &&
                      context
                          .watch<SalesReturnController>()
                          .getScanneditemData
                          .isEmpty
                  ? SizedBox(
                      height: widget.searchHeight * 0.8,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: theme.primaryColor,
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                          itemCount: context
                              .watch<SalesReturnController>()
                              .getScanneditemData
                              .length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Container(
                                  padding: EdgeInsets.only(
                                    top: widget.searchHeight * 0.01,
                                    left: widget.searchHeight * 0.01,
                                    right: widget.searchHeight * 0.01,
                                    bottom: widget.searchHeight * 0.02,
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
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width: widget.searchWidth * 0.2,
                                                alignment: Alignment.centerLeft,
                                                child: TextButton(
                                                    onPressed: () {},
                                                    child: Text(
                                                      context
                                                          .watch<
                                                              SalesReturnController>()
                                                          .getScanneditemData[
                                                              index]
                                                          .itemCode
                                                          .toString(),
                                                      maxLines: 2,
                                                      style: theme
                                                          .textTheme.bodyMedium
                                                          ?.copyWith(
                                                              color:
                                                                  Colors.black),
                                                    ))),
                                          ],
                                        ),
                                        Container(
                                            width: widget.searchWidth * 0.15,
                                            height: widget.searchHeight * 0.07,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    widget.searchWidth * 0.005),
                                            child: TextFormField(
                                              onTap: () {
                                                context
                                                        .read<
                                                            SalesReturnController>()
                                                        .qtymycontroller[index]
                                                        .text =
                                                    context
                                                        .read<
                                                            SalesReturnController>()
                                                        .qtymycontroller[index]
                                                        .text;
                                                context
                                                    .read<
                                                        SalesReturnController>()
                                                    .qtymycontroller[index]
                                                    .selection = TextSelection(
                                                  baseOffset: 0,
                                                  extentOffset: context
                                                      .read<
                                                          SalesReturnController>()
                                                      .qtymycontroller[index]
                                                      .text
                                                      .length,
                                                );
                                              },
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.black),
                                              cursorColor: Colors.grey,
                                              textDirection: TextDirection.rtl,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                // FilteringTextInputFormatter
                                                //     .digitsOnly
                                              ],
                                              onEditingComplete: () {
                                                setState(() {
                                                  log('lllll');
                                                  context
                                                      .read<
                                                          SalesReturnController>()
                                                      .itemIncrement11(index,
                                                          context, theme);
                                                });

                                                context
                                                    .read<
                                                        SalesReturnController>()
                                                    .disableKeyBoard(context);
                                              },
                                              controller: context
                                                  .read<SalesReturnController>()
                                                  .qtymycontroller[index],
                                              decoration: InputDecoration(
                                                filled: false,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 0,
                                                  horizontal: 5,
                                                ),
                                              ),
                                            )),
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          width: widget.searchWidth * 0.08,
                                          alignment: Alignment.center,
                                          child: Text(
                                            context
                                                .watch<SalesReturnController>()
                                                .getScanneditemData[index]
                                                .discountper
                                                .toString(),
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          width: widget.searchWidth * 0.1,
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                              context
                                                  .watch<
                                                      SalesReturnController>()
                                                  .getScanneditemData[index]
                                                  .taxRate
                                                  .toString(),
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.black)),
                                        ),
                                        Container(
                                          width: widget.searchWidth * 0.16,
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "${config.splitValues(context.watch<SalesReturnController>().getScanneditemData[index].sellPrice!.toStringAsFixed(2))}",
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
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
                                              context
                                                  .watch<
                                                      SalesReturnController>()
                                                  .getScanneditemData[index]
                                                  .serialBatch
                                                  .toString(),
                                              textAlign: TextAlign.start,
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(),
                                            )),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "  |  ${context.watch<SalesReturnController>().getScanneditemData[index].itemName}",
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(),
                                          ),
                                        ),
                                      ],
                                    )
                                  ])),
                            );
                          })),
        ],
      ),
    );
  }
}
