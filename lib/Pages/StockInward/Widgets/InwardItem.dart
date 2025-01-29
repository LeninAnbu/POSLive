import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:provider/provider.dart';

import '../../../../../Controller/StockInwardController/StockInwardContler.dart';
import '../../../Models/DataModel/StockInwardModel/StockInwardListModel.dart';
import '../../../Widgets/AlertBox.dart';

class StockInward extends StatefulWidget {
  StockInward(
      {super.key,
      required this.theme,
      required this.stockInWidth,
      required this.stockInheight,
      required this.index,
      required this.datatotal});
  ThemeData theme;
  double stockInheight;
  double stockInWidth;
  int index;

  List<StockInwardList>? datatotal;

  @override
  State<StockInward> createState() => _StockInwardState();
}

class _StockInwardState extends State<StockInward> {
  @override
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          context.read<StockInwrdController>().selectedcust2 != null
              ? Container()
              : Container(
                  height: Screens.padingHeight(context) * 0.07,
                  width: Screens.width(context) * 1,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 240, 235, 235)),
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.001),
                  ),
                  child: TextFormField(
                    onChanged: (v) {},
                    readOnly: true,
                    onTap: () {
                      context
                          .read<StockInwrdController>()
                          .searchcontroller
                          .text = '';
                      context.read<StockInwrdController>().refresCufstList();

                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                contentPadding: const EdgeInsets.all(0),
                                content: AlertBox(
                                  payMent: 'Select Customer',
                                  widget: forSearchCustBtn(context),
                                  buttonName: '',
                                ));
                          });
                    },
                    decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      hintText: 'Customers',
                      hintStyle: widget.theme.textTheme.bodyLarge?.copyWith(),
                      filled: false,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 8,
                      ),
                    ),
                  ),
                ),
          context.read<StockInwrdController>().selectedcust2 != null
              ? Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.grey[300],
                  width: Screens.width(context) * 0.49,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: Screens.width(context) * 0.39,
                              child: Text(
                                context
                                            .watch<StockInwrdController>()
                                            .selectedcust2 !=
                                        null
                                    ? context
                                        .watch<StockInwrdController>()
                                        .selectedcust2!
                                        .name!
                                    : '',
                                style: widget.theme.textTheme.titleMedium
                                    ?.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.phone,
                                  color: Colors.black54,
                                ),
                                Text(
                                    context
                                                    .watch<
                                                        StockInwrdController>()
                                                    .selectedcust2 !=
                                                null &&
                                            context
                                                .read<StockInwrdController>()
                                                .selectedcust2!
                                                .phNo!
                                                .isNotEmpty
                                        ? "${context.watch<StockInwrdController>().selectedcust2!.phNo}  |  "
                                        : '',
                                    style: widget.theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54)),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.mail_outline,
                                  color: Colors.black54,
                                ),
                                Text(
                                    context
                                                    .watch<
                                                        StockInwrdController>()
                                                    .selectedcust2 !=
                                                null &&
                                            context
                                                .watch<StockInwrdController>()
                                                .selectedcust2!
                                                .email!
                                                .isNotEmpty
                                        ? " ${context.watch<StockInwrdController>().selectedcust2!.email}"
                                        : "",
                                    style: widget.theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Screens.padingHeight(context) * 0.01,
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.465,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Card Code",
                                style: widget.theme.textTheme.bodyLarge
                                    ?.copyWith(color: Colors.black54)),
                            Container(
                              padding: EdgeInsets.only(
                                right: Screens.padingHeight(context) * 0.02,
                              ),
                              child: Text(
                                  "${context.watch<StockInwrdController>().selectedcust2!.cardCode}",
                                  style: widget.theme.textTheme.bodyLarge
                                      ?.copyWith(color: Colors.black54)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: Screens.width(context) * 0.465,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Balance",
                                style: widget.theme.textTheme.bodyLarge
                                    ?.copyWith(color: Colors.black54)),
                            Text(
                                context
                                                .watch<StockInwrdController>()
                                                .selectedcust2 !=
                                            null &&
                                        (context
                                                    .watch<
                                                        StockInwrdController>()
                                                    .selectedcust2!
                                                    .accBalance !=
                                                null ||
                                            context
                                                    .watch<
                                                        StockInwrdController>()
                                                    .selectedcust2!
                                                    .accBalance !=
                                                0)
                                    ? context
                                        .watch<StockInwrdController>()
                                        .config
                                        .splitValues(context
                                            .watch<StockInwrdController>()
                                            .selectedcust2!
                                            .accBalance
                                            .toString())
                                    : '0.00',
                                style: widget.theme.textTheme.bodyLarge
                                    ?.copyWith(color: Colors.black54)),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : context.read<StockInwrdController>().selectedcust != null
                  ? Container(
                      padding: EdgeInsets.all(5),
                      color: Colors.grey[50],
                      width: Screens.width(context) * 0.49,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: Screens.width(context) * 0.39,
                                  child: Text(
                                    context
                                                .watch<StockInwrdController>()
                                                .selectedcust !=
                                            null
                                        ? context
                                            .watch<StockInwrdController>()
                                            .selectedcust!
                                            .name!
                                        : '',
                                    style: widget.theme.textTheme.titleMedium
                                        ?.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          context
                                              .read<StockInwrdController>()
                                              .selectedcust = null;
                                        });
                                      },
                                      icon: Icon(Icons.close)),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.phone,
                                      color: Colors.black54,
                                    ),
                                    Text(
                                        context
                                                        .watch<
                                                            StockInwrdController>()
                                                        .selectedcust !=
                                                    null &&
                                                context
                                                    .read<
                                                        StockInwrdController>()
                                                    .selectedcust!
                                                    .phNo!
                                                    .isNotEmpty
                                            ? "${context.watch<StockInwrdController>().selectedcust!.phNo}  |  "
                                            : '',
                                        style: widget.theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.mail_outline,
                                      color: Colors.black54,
                                    ),
                                    Text(
                                        context
                                                        .watch<
                                                            StockInwrdController>()
                                                        .selectedcust !=
                                                    null &&
                                                context
                                                    .watch<
                                                        StockInwrdController>()
                                                    .selectedcust!
                                                    .email!
                                                    .isNotEmpty
                                            ? " ${context.watch<StockInwrdController>().selectedcust!.email}"
                                            : "",
                                        style: widget.theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Screens.padingHeight(context) * 0.01,
                          ),
                          SizedBox(
                            width: Screens.width(context) * 0.465,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Card Code",
                                    style: widget.theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54)),
                                Container(
                                  padding: EdgeInsets.only(
                                    right: Screens.padingHeight(context) * 0.02,
                                  ),
                                  child: Text(
                                      "${context.watch<StockInwrdController>().selectedcust!.cardCode}",
                                      style: widget.theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black54)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            width: Screens.width(context) * 0.465,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Balance",
                                    style: widget.theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54)),
                                Text(
                                    context
                                                    .watch<
                                                        StockInwrdController>()
                                                    .selectedcust !=
                                                null &&
                                            (context
                                                        .watch<
                                                            StockInwrdController>()
                                                        .selectedcust!
                                                        .accBalance !=
                                                    null ||
                                                context
                                                        .watch<
                                                            StockInwrdController>()
                                                        .selectedcust!
                                                        .accBalance !=
                                                    0)
                                        ? context
                                            .watch<StockInwrdController>()
                                            .config
                                            .splitValues(context
                                                .watch<StockInwrdController>()
                                                .selectedcust!
                                                .accBalance
                                                .toString())
                                        : '0.00',
                                    style: widget.theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
          SizedBox(
            height: Screens.padingHeight(context) * 0.005,
          ),
          Container(
            padding: EdgeInsets.only(
              top: widget.stockInheight * 0.0,
              left: widget.stockInheight * 0.01,
              right: widget.stockInheight * 0.01,
              // bottom: widget.stockInheight * 0.01,
            ),
            decoration: BoxDecoration(
                color: widget.theme.primaryColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5))),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: widget.stockInWidth * 0.5,
                      child: GestureDetector(
                        onTap: () {
                          context.read<StockInwrdController>().deletereq();
                        },
                        child: Text(
                          'Item Name',
                          style: widget.theme.textTheme.bodyLarge!
                              .copyWith(color: Colors.white),
                        ),
                      )),
                  Container(
                      alignment: Alignment.center,
                      width: widget.stockInWidth * 0.15,
                      child: Text(
                        'Requested Quantity',
                        style: widget.theme.textTheme.bodyLarge!
                            .copyWith(color: Colors.white),
                      )),
                  Container(
                      alignment: Alignment.center,
                      width: widget.stockInWidth * 0.15,
                      child: Text(
                        'Transfered Quantity',
                        style: widget.theme.textTheme.bodyLarge!
                            .copyWith(color: Colors.white),
                      )),
                  Container(
                      alignment: Alignment.center,
                      width: widget.stockInWidth * 0.15,
                      child: Text(
                        'Scanned Quantity',
                        style: widget.theme.textTheme.bodyLarge!
                            .copyWith(color: Colors.white),
                      ))
                ]),
          ),
          context.watch<StockInwrdController>().passdata!.isNotEmpty
              ? Container(
                  child: Row(
                    children: [
                      Text(' Select All '),
                      Checkbox(
                          value: context.read<StockInwrdController>().selectAll,
                          side: const BorderSide(color: Colors.grey),
                          activeColor: Colors.green,
                          onChanged: (value) {
                            setState(() {
                              context.read<StockInwrdController>().selectAll =
                                  value!;
                              context
                                  .read<StockInwrdController>()
                                  .selecetAllItems(context, widget.theme);

                              log('selectAllselectAllselectAll::${context.read<StockInwrdController>().selectAll}');
                            });
                          }),
                    ],
                  ),
                )
              : Container(),
          Container(
            height: widget.stockInheight * 0.5,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: context.watch<StockInwrdController>().stockInward2.isNotEmpty
                ? ListView.builder(
                    itemCount: context
                        .watch<StockInwrdController>()
                        .stockInward2[0]
                        .data!
                        .length,
                    itemBuilder: (context, i) {
                      return Card(
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.only(
                              // top: widget.stockInheight * 0.008,
                              left: widget.stockInheight * 0.01,
                              right: widget.stockInheight * 0.01,
                              bottom: widget.stockInheight * 0.01,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: widget.stockInWidth * 0.5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${context.watch<StockInwrdController>().stockInward2[0].data![i].itemcode}",
                                            style: widget
                                                .theme.textTheme.bodyLarge,
                                          ),
                                          Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                " ${context.watch<StockInwrdController>().stockInward2[0].data![i].serialBatch}",
                                                style: widget
                                                    .theme.textTheme.bodyLarge,
                                              ))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: widget.stockInWidth * 0.15,
                                      child: Text(
                                        "${context.watch<StockInwrdController>().stockInward2[0].data![i].qty}",
                                        style: widget.theme.textTheme.bodyLarge,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: widget.stockInWidth * 0.15,
                                      child: Text(
                                        "${context.watch<StockInwrdController>().stockInward2[0].data![i].trans_Qty}",
                                        style: widget.theme.textTheme.bodyLarge,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: widget.stockInWidth * 0.15,
                                      child: Text(
                                        "${context.watch<StockInwrdController>().stockInward2[0].data![i].Scanned_Qty ?? ''}",
                                        style: widget.theme.textTheme.bodyLarge,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      );
                    })
                : context.watch<StockInwrdController>().loadingListScrn ==
                            true &&
                        context.watch<StockInwrdController>().passdata!.isEmpty
                    ? Container(
                        height: Screens.padingHeight(context) * 0.907,
                        width: Screens.width(context) * 0.48,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: widget.theme.primaryColor,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: context
                            .watch<StockInwrdController>()
                            .passdata!
                            .length,
                        itemBuilder: (context, i) {
                          return Card(
                            margin: EdgeInsets.all(2),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  context.read<StockInwrdController>().valPass(
                                      context
                                          .read<StockInwrdController>()
                                          .passdata![i]
                                          .Scanned_Qty!);

                                  context
                                          .read<StockInwrdController>()
                                          .scannigVal =
                                      context
                                          .read<StockInwrdController>()
                                          .passdata![i]
                                          .Scanned_Qty!;
                                  context
                                      .read<StockInwrdController>()
                                      .selectindex2(i);

                                  context
                                      .read<StockInwrdController>()
                                      .passindexBachPage(
                                          widget.index,
                                          i,
                                          context
                                              .read<StockInwrdController>()
                                              .passdata![i]);
                                  StockInwardDetails datax = context
                                      .read<StockInwrdController>()
                                      .passdata![i];
                                  for (var im = 0;
                                      im < datax.StOutSerialbatchList!.length;
                                      im++) {
                                    context
                                            .read<StockInwrdController>()
                                            .stInController[0]
                                            .text =
                                        datax.StOutSerialbatchList![im]
                                            .serialbatch!;
                                  }
                                  setState(() {
                                    context.read<StockInwrdController>().msg =
                                        '';
                                    context
                                        .read<StockInwrdController>()
                                        .scanmethod(
                                          context
                                              .read<StockInwrdController>()
                                              .get_i_value,
                                          context
                                              .read<StockInwrdController>()
                                              .batch_datalist,
                                          context
                                              .read<StockInwrdController>()
                                              .batch_i!,
                                        );

                                    if (context
                                            .read<StockInwrdController>()
                                            .stockInward[context
                                                .read<StockInwrdController>()
                                                .get_i_value]
                                            .data![context
                                                .read<StockInwrdController>()
                                                .batch_i!]
                                            .serialbatchList !=
                                        null) {
                                      for (var iss = 0;
                                          iss <
                                              context
                                                  .read<StockInwrdController>()
                                                  .stockInward[context
                                                      .read<
                                                          StockInwrdController>()
                                                      .get_i_value]
                                                  .data![context
                                                      .read<
                                                          StockInwrdController>()
                                                      .batch_i!]
                                                  .serialbatchList!
                                                  .length;
                                          iss++) {
                                        context
                                                .read<StockInwrdController>()
                                                .stockInward[context
                                                    .read<StockInwrdController>()
                                                    .get_i_value]
                                                .data![context
                                                    .read<StockInwrdController>()
                                                    .batch_i!]
                                                .serialbatchList![iss]
                                                .qty =
                                            int.parse(context
                                                .read<StockInwrdController>()
                                                .passdata![i]
                                                .trans_Qty
                                                .toString()
                                                .replaceAll('.0', ''));
                                        context
                                                .read<StockInwrdController>()
                                                .sinqtycontroller[iss]
                                                .text =
                                            context
                                                .read<StockInwrdController>()
                                                .passdata![i]
                                                .trans_Qty
                                                .toString();
                                      }
                                    }
                                  });

                                  for (var im = 0;
                                      im < datax.StOutSerialbatchList!.length;
                                      im++) {
                                    if (context
                                            .read<StockInwrdController>()
                                            .selectAll ==
                                        true) {
                                      context
                                              .read<StockInwrdController>()
                                              .stInController[0]
                                              .text =
                                          datax.StOutSerialbatchList![im]
                                              .serialbatch!;
                                    } else {
                                      context
                                          .read<StockInwrdController>()
                                          .stInController[0]
                                          .text = '';
                                    }
                                  }
                                  context
                                      .read<StockInwrdController>()
                                      .isselectmethod();
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                  // top: widget.stockInheight * 0.008,
                                  left: widget.stockInWidth * 0.01,
                                  right: widget.stockInWidth * 0.01,
                                  bottom: widget.stockInheight * 0.01,
                                ),
                                decoration: BoxDecoration(
                                  color: context
                                                  .watch<StockInwrdController>()
                                                  .passdata![i]
                                                  .Scanned_Qty !=
                                              0 &&
                                          (context
                                                  .watch<StockInwrdController>()
                                                  .passdata![i]
                                                  .Scanned_Qty !=
                                              context
                                                  .watch<StockInwrdController>()
                                                  .passdata![i]
                                                  .trans_Qty)
                                      ? const Color(0xFFfcedee)
                                      : context
                                                      .watch<
                                                          StockInwrdController>()
                                                      .passdata![i]
                                                      .Scanned_Qty ==
                                                  context
                                                      .watch<
                                                          StockInwrdController>()
                                                      .passdata![i]
                                                      .trans_Qty &&
                                              context
                                                      .watch<
                                                          StockInwrdController>()
                                                      .passdata![i]
                                                      .listClr ==
                                                  true
                                          ? const Color(0xFFebfaef)
                                          : context
                                                      .watch<
                                                          StockInwrdController>()
                                                      .getScannigVal ==
                                                  0
                                              ? Colors.grey.withOpacity(0.04)
                                              : Colors.grey.withOpacity(0.04),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      width: Screens.width(context) * 0.001,
                                      color: context
                                                      .watch<
                                                          StockInwrdController>()
                                                      .passdata![i]
                                                      .Scanned_Qty !=
                                                  0 &&
                                              context
                                                      .watch<
                                                          StockInwrdController>()
                                                      .passdata![i]
                                                      .Scanned_Qty !=
                                                  context
                                                      .watch<
                                                          StockInwrdController>()
                                                      .passdata![i]
                                                      .trans_Qty
                                          ? Colors.red.withOpacity(0.4)
                                          : context
                                                          .watch<
                                                              StockInwrdController>()
                                                          .passdata![i]
                                                          .Scanned_Qty ==
                                                      context
                                                          .watch<
                                                              StockInwrdController>()
                                                          .passdata![i]
                                                          .trans_Qty &&
                                                  context
                                                          .watch<
                                                              StockInwrdController>()
                                                          .passdata![i]
                                                          .listClr ==
                                                      true
                                              ? Colors.green.withOpacity(0.4)
                                              : context
                                                          .watch<
                                                              StockInwrdController>()
                                                          .getScannigVal ==
                                                      0
                                                  ? Colors.white
                                                  : Colors.white),
                                ),
                                child: IntrinsicHeight(
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: widget.stockInWidth * 0.5,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${context.watch<StockInwrdController>().passdata![i].itemcode}",
                                                style: widget
                                                    .theme.textTheme.bodyLarge,
                                              ),
                                              Wrap(
                                                  spacing: 10.0,
                                                  runSpacing: 10.0,
                                                  children: listContainersBatch(
                                                    context,
                                                    widget.theme,
                                                    context
                                                        .watch<
                                                            StockInwrdController>()
                                                        .passdata![i],
                                                  ))
                                            ],
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: widget.stockInWidth * 0.15,
                                          child: Text(
                                            "${context.watch<StockInwrdController>().passdata![i].qty}",
                                            style: widget
                                                .theme.textTheme.bodyLarge,
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: widget.stockInWidth * 0.15,
                                          child: Text(
                                            "${context.watch<StockInwrdController>().passdata![i].trans_Qty}",
                                            style: widget
                                                .theme.textTheme.bodyLarge,
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: widget.stockInWidth * 0.15,
                                          child: Text(
                                            "${context.watch<StockInwrdController>().passdata![i].Scanned_Qty}",
                                            style: widget
                                                .theme.textTheme.bodyLarge,
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
            height: widget.stockInheight * 0.008,
          ),
          Container(
            padding: EdgeInsets.only(
              // top: widget.stockInheight * 0.01,
              left: widget.stockInheight * 0.01,
              right: widget.stockInheight * 0.01,
              bottom: widget.stockInheight * 0.01,
            ),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5))),
            child: context.watch<StockInwrdController>().stockInward2.isNotEmpty
                ? Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: TextFormField(
                      controller: context
                          .read<StockInwrdController>()
                          .stInController2[50],
                      cursorColor: Colors.grey,
                      style: widget.theme.textTheme.bodyMedium?.copyWith(),
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
                          .read<StockInwrdController>()
                          .stInController[50],
                      cursorColor: Colors.grey,
                      style: widget.theme.textTheme.bodyMedium?.copyWith(),
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
              top: widget.stockInheight * 0.01,
              left: widget.stockInheight * 0.01,
              right: widget.stockInheight * 0.01,
              bottom: widget.stockInheight * 0.01,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            height: widget.stockInheight * 0.095,
            child: context.watch<StockInwrdController>().stockInward2.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // GestureDetector(
                      //     onTap: () {
                      //       setState(() {
                      //         context
                      //             .read<StockInwrdController>()
                      //             .clickcancelbtn(context, widget.theme);
                      //       });
                      //     },
                      //     child: Container(
                      //       alignment: Alignment.center,
                      //       decoration: BoxDecoration(
                      //         color: Colors.grey[400],
                      //         borderRadius: BorderRadius.circular(5),
                      //       ),
                      //       height: widget.stockInheight * 0.9,
                      //       width: widget.stockInWidth * 0.25,
                      //       child: context
                      //                   .watch<StockInwrdController>()
                      //                   .cancelbtn ==
                      //               false
                      //           ? Text("Cancel",
                      //               textAlign: TextAlign.center,
                      //               style: widget.theme.textTheme.bodySmall
                      //                   ?.copyWith(
                      //                 color: Colors.black,
                      //               ))
                      //           : CircularProgressIndicator(
                      //               color: widget.theme.primaryColor),
                      //     )),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              context
                                  .read<StockInwrdController>()
                                  .stockInward2
                                  .clear();
                              context
                                  .read<StockInwrdController>()
                                  .stInController2[50]
                                  .text = "";

                              context
                                  .read<StockInwrdController>()
                                  .stockInward
                                  .clear();
                              context
                                  .read<StockInwrdController>()
                                  .selectedcust2 = null;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: widget.stockInheight * 0.9,
                            width: widget.stockInWidth * 0.25,
                            child: Text("Clear",
                                style:
                                    widget.theme.textTheme.bodyMedium?.copyWith(
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
                        height: widget.stockInheight * 0.9,
                        width: widget.stockInWidth * 0.25,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                  color: widget.theme.primaryColor,
                                )),
                            onPressed: context
                                        .read<StockInwrdController>()
                                        .onClickDisable ==
                                    true
                                ? null
                                : () {
                                    context
                                        .read<StockInwrdController>()
                                        .stInController[50]
                                        .clear();
                                    context
                                        .read<StockInwrdController>()
                                        .onClickDisable = true;
                                    if (widget.datatotal!.isEmpty &&
                                        context
                                                .read<StockInwrdController>()
                                                .selectedcust ==
                                            null) {
                                      Get.defaultDialog(
                                              title: "Alert",
                                              middleText: 'No Data Found..!!',
                                              backgroundColor: Colors.white,
                                              titleStyle: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(color: Colors.red),
                                              middleTextStyle: widget
                                                  .theme.textTheme.bodyLarge,
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
                                            .read<StockInwrdController>()
                                            .onClickDisable = false;
                                      });
                                    } else {
                                      forSuspend(context, widget.theme);
                                    }
                                    context
                                        .read<StockInwrdController>()
                                        .disableKeyBoard(context);
                                    context
                                        .read<StockInwrdController>()
                                        .onClickDisable = false;
                                  },
                            child: Text(
                              "Clear All",
                              style: widget.theme.textTheme.bodyMedium!
                                  .copyWith(color: widget.theme.primaryColor),
                            )),
                      ),
                      SizedBox(
                        height: widget.stockInheight * 0.9,
                        width: widget.stockInWidth * 0.25,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                  color: widget.theme.primaryColor,
                                )),
                            onPressed: context
                                        .read<StockInwrdController>()
                                        .onClickDisable ==
                                    true
                                ? null
                                : () {
                                    context
                                        .read<StockInwrdController>()
                                        .onClickDisable = true;
                                    if (widget.datatotal!.isEmpty &&
                                        context
                                                .read<StockInwrdController>()
                                                .selectedcust ==
                                            null) {
                                      Get.defaultDialog(
                                              title: "Alert",
                                              middleText: 'No Data Found..!!',
                                              backgroundColor: Colors.white,
                                              titleStyle: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(color: Colors.red),
                                              middleTextStyle: widget
                                                  .theme.textTheme.bodyLarge,
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
                                            .read<StockInwrdController>()
                                            .onClickDisable = false;
                                      });
                                    } else if (context
                                        .read<StockInwrdController>()
                                        .passdata!
                                        .isEmpty) {
                                      Get.defaultDialog(
                                              title: "Alert",
                                              middleText:
                                                  'Please Choose Item..!!',
                                              backgroundColor: Colors.white,
                                              titleStyle: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(color: Colors.red),
                                              middleTextStyle: widget
                                                  .theme.textTheme.bodyLarge,
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
                                            .read<StockInwrdController>()
                                            .onClickDisable = false;
                                      });
                                    } else {
                                      context
                                          .read<StockInwrdController>()
                                          .holdbutton(
                                              widget.index,
                                              context,
                                              widget.theme,
                                              context
                                                  .read<StockInwrdController>()
                                                  .passdata!,
                                              widget.datatotal![widget.index]);
                                    }
                                    context
                                        .read<StockInwrdController>()
                                        .disableKeyBoard(context);
                                    context
                                        .read<StockInwrdController>()
                                        .onClickDisable = false;
                                  },
                            child: Text(
                              "Hold",
                              style: widget.theme.textTheme.bodyMedium!
                                  .copyWith(color: widget.theme.primaryColor),
                            )),
                      ),
                      SizedBox(
                        height: widget.stockInheight * 0.9,
                        width: widget.stockInWidth * 0.25,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: widget.theme.primaryColor),
                            onPressed: context
                                        .read<StockInwrdController>()
                                        .onClickDisable ==
                                    false
                                ? () async {
                                    context
                                        .read<StockInwrdController>()
                                        .onClickDisable = true;
                                    if (widget.datatotal!.isEmpty) {
                                      Get.defaultDialog(
                                              title: "Alert",
                                              middleText: 'No Data Found..!!',
                                              backgroundColor: Colors.white,
                                              titleStyle: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(color: Colors.red),
                                              middleTextStyle: widget
                                                  .theme.textTheme.bodyLarge,
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
                                            .read<StockInwrdController>()
                                            .onClickDisable = false;
                                      });
                                    } else if (context
                                        .read<StockInwrdController>()
                                        .passdata!
                                        .isEmpty) {
                                      Get.defaultDialog(
                                              title: "Alert",
                                              middleText:
                                                  'Please Choose Item..!!',
                                              backgroundColor: Colors.white,
                                              titleStyle: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(color: Colors.red),
                                              middleTextStyle: widget
                                                  .theme.textTheme.bodyLarge,
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
                                            .read<StockInwrdController>()
                                            .onClickDisable = false;
                                      });
                                    } else {
                                      await context
                                          .read<StockInwrdController>()
                                          .submitbutton(
                                              widget.index,
                                              context,
                                              widget.theme,
                                              context
                                                  .read<StockInwrdController>()
                                                  .passdata!,
                                              widget.datatotal![widget.index]);
                                      context
                                          .read<StockInwrdController>()
                                          .myFuture(
                                              context,
                                              widget.theme,
                                              context
                                                  .read<StockInwrdController>()
                                                  .passdata!);
                                    }
                                    context
                                        .read<StockInwrdController>()
                                        .disableKeyBoard(context);
                                  }
                                : null,
                            child: Text(
                              "Submit",
                              style: widget.theme.textTheme.bodyMedium!
                                  .copyWith(color: Colors.white),
                            )),
                      ),
                    ],
                  ),
          )
        ],
      ),
    );
  }

  forSearchCustBtn(BuildContext context) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        width: Screens.width(context) * 0.5,
        padding: EdgeInsets.only(
            top: Screens.padingHeight(context) * 0.02,
            left: Screens.width(context) * 0.01,
            right: Screens.width(context) * 0.01,
            bottom: Screens.padingHeight(context) * 0.02),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: Screens.width(context) * 0.5,
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 240, 235, 235)),
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey.withOpacity(0.01),
              ),
              child: TextFormField(
                textCapitalization: TextCapitalization.sentences,
                controller:
                    context.read<StockInwrdController>().searchcontroller,
                cursorColor: Colors.grey,
                autofocus: true,
                onChanged: (v) {
                  st(() {
                    context.read<StockInwrdController>().filterCustList(v);
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search Customer..!!',
                  hintStyle: widget.theme.textTheme.bodyLarge
                      ?.copyWith(color: Colors.grey),
                  filled: false,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 25,
                  ),
                ),
              ),
            ),
            SizedBox(height: Screens.padingHeight(context) * 0.01),
            SizedBox(
                height: Screens.padingHeight(context) * 0.7,
                width: Screens.width(context) * 1.3,
                child: ListView.builder(
                    itemCount: context
                        .read<StockInwrdController>()
                        .getfiltercustList
                        .length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.all(2),
                        child: Container(
                          padding: EdgeInsets.only(
                              top: Screens.padingHeight(context) * 0.01,
                              // left: Screens.width(context) * 0.01,
                              // right: Screens.width(context) * 0.01,
                              bottom: Screens.padingHeight(context) * 0.01),
                          child: StatefulBuilder(builder: (context, st) {
                            return ListTile(
                              onTap: () async {
                                Get.back();
                                context
                                    .read<StockInwrdController>()
                                    .custSelected(
                                        context
                                            .read<StockInwrdController>()
                                            .getfiltercustList[index],
                                        context,
                                        theme);
                              },
                              title: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(context
                                          .watch<StockInwrdController>()
                                          .getfiltercustList[index]
                                          .cardCode!),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        // color: Colors.red,
                                        width: Screens.width(context) * 0.32,
                                        child: Text(
                                          context
                                              .watch<StockInwrdController>()
                                              .getfiltercustList[index]
                                              .name!,
                                          maxLines: 2,
                                        ),
                                      ),
                                      Container(
                                        width: Screens.width(context) * 0.1,
                                        child: Text(context
                                            .watch<StockInwrdController>()
                                            .getfiltercustList[index]
                                            .phNo!),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          }),
                        ),
                      );
                    })),
            SizedBox(height: Screens.padingHeight(context) * 0.05),
          ],
        ),
      );
    });
  }

  forSuspend(BuildContext context, ThemeData theme) {
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
                    context.read<StockInwrdController>().selectedcust = null;
                    context.read<StockInwrdController>().selectedcust2 = null;

                    context.read<StockInwrdController>().selectIndex = null;

                    if (widget.datatotal!.isNotEmpty) {
                      context.read<StockInwrdController>().suspendedbutton(
                          widget.index,
                          context,
                          theme,
                          context.read<StockInwrdController>().passdata!,
                          widget.datatotal![widget.index]);
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
                    context.read<StockInwrdController>().callPendingInwardApi();

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

  List<Widget> listContainersBatch(
      BuildContext context, ThemeData theme, StockInwardDetails data) {
    return List.generate(
      data.StOutSerialbatchList!.length,
      (ind) {
        log("StOutSerialbatchList.length222::${data.StOutSerialbatchList!.length}");
        return Container(
          padding: EdgeInsets.all(Screens.width(context) * 0.002),
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(3)),
          child: Text(
              "${data.StOutSerialbatchList![ind].serialbatch} / ${data.StOutSerialbatchList![ind].qty} "),
        );
      },
    );
  }
}
