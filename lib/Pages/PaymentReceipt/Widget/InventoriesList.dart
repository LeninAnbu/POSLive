import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Controller/PaymentReceiptController/PayReceiptController.dart';
import '../../SalesQuotation/Widgets/ItemLists.dart';

class Inventories extends StatefulWidget {
  Inventories(
      {super.key,
      required this.theme,
      required this.searchHeight,
      required this.searchWidth});

  final ThemeData theme;
  double searchHeight;
  double searchWidth;
  @override
  State<Inventories> createState() => _InventoriesState();
}

class _InventoriesState extends State<Inventories> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        height: widget.searchHeight * 1.06,
        width: widget.searchWidth,
        padding: EdgeInsets.only(
            top: widget.searchHeight * 0.01,
            left: widget.searchHeight * 0.01,
            right: widget.searchHeight * 0.01,
            bottom: widget.searchHeight * 0.01),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                alignment: Alignment.center,
                width: widget.searchWidth * 1,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 240, 235, 235)),
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.01),
                ),
                child: TextFormField(
                  style: theme.textTheme.bodyLarge,
                  cursorColor: Colors.grey,
                  onChanged: (v) {
                    context.read<PayreceiptController>().filterInvoiceList(v);
                  },
                  controller: context
                      .read<PayreceiptController>()
                      .invMySearchcontroller[0],
                  onEditingComplete: () {
                    context
                        .read<PayreceiptController>()
                        .invoiceScan(context, theme);
                  },
                  decoration: InputDecoration(
                    filled: false,
                    hintText: 'Invoice Information',
                    hintStyle: theme.textTheme.bodyLarge?.copyWith(),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 10,
                    ),
                  ),
                )),
            SizedBox(
              height: widget.searchHeight * 0.01,
            ),
            context.read<PayreceiptController>().getScanneditemData2.isNotEmpty
                ? SizedBox(
                    height: widget.searchHeight * 0.75,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: context
                            .watch<PayreceiptController>()
                            .getScanneditemData2
                            .length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Container(
                                padding: EdgeInsets.only(
                                  top: widget.searchHeight * 0.01,
                                  left: widget.searchHeight * 0.01,
                                  right: widget.searchHeight * 0.01,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey[300]),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                  "${context.watch<PayreceiptController>().getScanneditemData2[index].doctype} - ${context.watch<PayreceiptController>().getScanneditemData2[index].docNum}")
                                            ],
                                          ),
                                          Text(context
                                              .read<PayreceiptController>()
                                              .config
                                              .alignDate(context
                                                  .read<PayreceiptController>()
                                                  .getScanneditemData2[index]
                                                  .date
                                                  .toString()))
                                        ],
                                      ),
                                      Container(
                                          width: widget.searchWidth * 0.15,
                                          height: widget.searchHeight * 0.08,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  widget.searchWidth * 0.005),
                                          child: TextFormField(
                                            readOnly: true,
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                            onChanged: (v) {},
                                            cursorColor: Colors.grey,
                                            textDirection: TextDirection.ltr,
                                            keyboardType: TextInputType.number,
                                            onEditingComplete: () {
                                              context
                                                  .read<PayreceiptController>()
                                                  .totalpaidamt(context, theme);
                                              context
                                                  .read<PayreceiptController>()
                                                  .disableKeyBoard(context);
                                            },
                                            controller: context
                                                .read<PayreceiptController>()
                                                .mycontroller2[index],
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
                                          ))
                                    ])),
                          );
                        }),
                  )
                : context
                        .watch<PayreceiptController>()
                        .getScanneditemData
                        .isEmpty
                    ? Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: widget.theme.primaryColor,
                                side: BorderSide(
                                  color: widget.theme.primaryColor,
                                )),
                            onPressed: context
                                        .read<PayreceiptController>()
                                        .advancests ==
                                    true
                                ? null
                                : () {
                                    context
                                        .read<PayreceiptController>()
                                        .advancests = true;

                                    setState(() {
                                      context
                                          .read<PayreceiptController>()
                                          .aaaadvance(
                                              "Advance", context, theme);
                                      context
                                          .read<PayreceiptController>()
                                          .disableKeyBoard(context);
                                    });
                                  },
                            child: Text(
                              "Advance",
                              style: widget.theme.textTheme.bodyMedium!
                                  .copyWith(color: Colors.white),
                            )),
                      )
                    : SizedBox(
                        height: widget.searchHeight * 0.75,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: context
                                .watch<PayreceiptController>()
                                .getScanneditemData
                                .length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    top: widget.searchHeight * 0.01,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: context
                                                      .read<
                                                          PayreceiptController>()
                                                      .getScanneditemData[index]
                                                      .checkbx ==
                                                  1 &&
                                              context
                                                      .read<
                                                          PayreceiptController>()
                                                      .getScanneditemData[index]
                                                      .checkClr ==
                                                  true
                                          ? Colors.blue.withOpacity(0.35)
                                          : Colors.grey.withOpacity(0.2)),
                                  child: CheckboxListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      onChanged: (val) {
                                        context
                                            .read<PayreceiptController>()
                                            .advancests = false;

                                        context
                                            .read<PayreceiptController>()
                                            .itemDeSelect(index);
                                      },
                                      value: context
                                          .read<PayreceiptController>()
                                          .getScanneditemData[index]
                                          .checkClr,
                                      title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                        "${context.watch<PayreceiptController>().getScanneditemData[index].doctype} - ${context.watch<PayreceiptController>().getScanneditemData[index].docNum}")
                                                  ],
                                                ),
                                                Text(context
                                                    .read<
                                                        PayreceiptController>()
                                                    .config
                                                    .alignDate(context
                                                        .read<
                                                            PayreceiptController>()
                                                        .getScanneditemData[
                                                            index]
                                                        .date
                                                        .toString()))
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                const Text("Invoice Amt"),
                                                Text(
                                                  context
                                                      .read<
                                                          PayreceiptController>()
                                                      .config
                                                      .splitValues22(context
                                                          .read<
                                                              PayreceiptController>()
                                                          .getScanneditemData[
                                                              index]
                                                          .amount!
                                                          .toString()),
                                                  style: theme
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                ),
                                              ],
                                            ),
                                            Container(
                                                width:
                                                    widget.searchWidth * 0.19,
                                                height:
                                                    widget.searchHeight * 0.08,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        widget.searchWidth *
                                                            0.000),
                                                child: TextFormField(
                                                  readOnly: context
                                                              .watch<
                                                                  PayreceiptController>()
                                                              .getScanneditemData[
                                                                  index]
                                                              .checkClr ==
                                                          true
                                                      ? false
                                                      : true,
                                                  onTap: () {
                                                    context
                                                            .read<
                                                                PayreceiptController>()
                                                            .invMycontroller[index]
                                                            .text =
                                                        context
                                                            .read<
                                                                PayreceiptController>()
                                                            .invMycontroller[
                                                                index]
                                                            .text;
                                                    context
                                                        .read<
                                                            PayreceiptController>()
                                                        .invMycontroller[index]
                                                        .selection = TextSelection(
                                                      baseOffset: 0,
                                                      extentOffset: context
                                                          .read<
                                                              PayreceiptController>()
                                                          .invMycontroller[
                                                              index]
                                                          .text
                                                          .length,
                                                    );
                                                  },
                                                  style: theme
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                          color: Colors.black),
                                                  onChanged: (v) {
                                                    context
                                                        .read<
                                                            PayreceiptController>()
                                                        .doubleDotMethod(
                                                            index, v);
                                                  },
                                                  cursorColor: Colors.grey,
                                                  textAlign: TextAlign.right,
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onEditingComplete: () {
                                                    context
                                                        .read<
                                                            PayreceiptController>()
                                                        .totalpaidamt(
                                                            context, theme);
                                                  },
                                                  controller: context
                                                      .read<
                                                          PayreceiptController>()
                                                      .invMycontroller[index],
                                                  inputFormatters: [
                                                    DecimalInputFormatter()
                                                  ],
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
                                                ))
                                          ])),
                                ),
                              );
                            }),
                      ),
            SizedBox(
              height: widget.searchHeight * 0.04,
            ),
            context.read<PayreceiptController>().scanneditemData2.isNotEmpty
                ? Container()
                : context.read<PayreceiptController>().scanneditemData.isEmpty
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            SizedBox(
                              width: widget.searchWidth * 0.45,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        context
                                            .read<PayreceiptController>()
                                            .selectall();
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: theme.primaryColor),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.grey.withOpacity(0.05),
                                      ),
                                      height: widget.searchHeight * 0.06,
                                      width: widget.searchWidth * 0.2,
                                      child: Text(
                                        "Select All",
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                                color: theme.primaryColor),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        context
                                            .read<PayreceiptController>()
                                            .totalduepay = 0;

                                        context
                                            .read<PayreceiptController>()
                                            .deSelectall();
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: theme.primaryColor),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.grey.withOpacity(0.05),
                                      ),
                                      height: widget.searchHeight * 0.06,
                                      width: widget.searchWidth * 0.2,
                                      child: Text(
                                        "Deselect All",
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                                color: theme.primaryColor),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: widget.searchHeight * 0.09,
                              width: widget.searchWidth * 0.25,
                              padding: const EdgeInsets.all(6),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: widget.theme.primaryColor,
                                    side: BorderSide(
                                      color: widget.theme.primaryColor,
                                    )),
                                onPressed: context
                                            .read<PayreceiptController>()
                                            .getpaymentWay
                                            .length <
                                        1
                                    ? null
                                    : () {
                                        setState(() {
                                          context
                                              .read<PayreceiptController>()
                                              .callFifoItems();
                                        });
                                      },
                                child: Text(
                                  "Add sequence",
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                            Container(
                              height: widget.searchHeight * 0.09,
                              width: widget.searchWidth * 0.2,
                              padding: const EdgeInsets.all(6),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: widget.theme.primaryColor,
                                    side: BorderSide(
                                      color: widget.theme.primaryColor,
                                    )),
                                onPressed: context
                                            .read<PayreceiptController>()
                                            .advancests ==
                                        true
                                    ? null
                                    : () {
                                        setState(() {
                                          context
                                              .read<PayreceiptController>()
                                              .advancests = true;
                                          context
                                              .read<PayreceiptController>()
                                              .deSelectalladv(
                                                  "Advance", context, theme);
                                        });
                                      },
                                child: Text(
                                  "Advance",
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ])
          ],
        ));
  }
}
