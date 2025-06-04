import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Controller/SalesInvoice/SalesInvoiceController.dart';
import 'package:posproject/Widgets/AlertBox.dart';

import '../../../Controller/SalesReturnController/SalesReturnController.dart';

class CustomerListt extends StatefulWidget {
  CustomerListt(
      {super.key,
      required this.theme,
      required this.custHeight,
      required this.custWidth});

  final ThemeData theme;

  double custHeight;
  double custWidth;

  @override
  State<CustomerListt> createState() => _CustomerListtState();
}

class _CustomerListtState extends State<CustomerListt> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(
          top: widget.custHeight * 0.01,
          bottom: widget.custHeight * 0.02,
          left: widget.custHeight * 0.01,
          right: widget.custHeight * 0.01),
      width: widget.custWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          context.watch<SalesReturnController>().scanneditemData2.isNotEmpty
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: widget.custWidth * 0.44,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 240, 235, 235)),
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.001),
                      ),
                      child: TextFormField(
                        controller: context
                            .read<SalesReturnController>()
                            .srmycontroller[2],
                        onChanged: (v) {},
                        readOnly: true,
                        onEditingComplete: () {},
                        onTap: () {
                          context
                              .read<SalesReturnController>()
                              .srmycontroller[2]
                              .text = '';
                          context
                              .read<SalesReturnController>()
                              .refresCufstList();
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    contentPadding: const EdgeInsets.all(0),
                                    content: AlertBox(
                                      payMent: 'Select Customer',
                                      widget: forSearchBtn(context),
                                      buttonName: '',
                                    ));
                              });
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              context
                                  .read<SalesReturnController>()
                                  .srmycontroller[2]
                                  .text = '';
                              context
                                  .read<SalesReturnController>()
                                  .refresCufstList();
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        contentPadding: const EdgeInsets.all(0),
                                        content: AlertBox(
                                          payMent: 'Select Customer',
                                          widget: forSearchBtn(context),
                                          buttonName: '',
                                        ));
                                  });
                            },
                            color: theme.primaryColor,
                          ),
                          hintText: 'Customers',
                          hintStyle: theme.textTheme.bodyLarge?.copyWith(),
                          filled: false,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: widget.custWidth * 0.43,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 240, 235, 235)),
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.001),
                      ),
                      child: TextFormField(
                        controller: context
                            .read<SalesReturnController>()
                            .srmycontroller[1],
                        onChanged: (v) {},
                        onEditingComplete: () {
                          setState(() {
                            context
                                .read<SalesReturnController>()
                                .callGetSalesRetApi(
                                    context,
                                    context
                                        .read<SalesReturnController>()
                                        .srmycontroller[1]
                                        .text
                                        .trim());
                          });

                          context
                              .read<SalesReturnController>()
                              .disableKeyBoard(context);
                        },
                        decoration: InputDecoration(
                          hintText: 'Invoice Number',
                          hintStyle: theme.textTheme.bodyLarge?.copyWith(),
                          filled: false,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          SizedBox(
            height: widget.custHeight * 0.02,
          ),
          context.read<SalesReturnController>().scanneditemData2.isNotEmpty
              ? Container(
                  color: Colors.grey[300],
                  padding: EdgeInsets.symmetric(
                      vertical: widget.custHeight * 0.02,
                      horizontal: widget.custWidth * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: widget.custWidth,
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: widget.custWidth * 0.8,
                                child: Text(
                                  context
                                              .watch<SalesReturnController>()
                                              .getselectedcust2 !=
                                          null
                                      ? context
                                          .watch<SalesReturnController>()
                                          .getselectedcust2!
                                          .name
                                          .toString()
                                      : "",
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: widget.custHeight * 0.01,
                      ),
                      SizedBox(
                        width: widget.custWidth,
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
                                                .watch<SalesReturnController>()
                                                .getselectedcust2 !=
                                            null
                                        ? " ${context.watch<SalesReturnController>().getselectedcust2!.phNo}  |  "
                                        : '',
                                    style: theme.textTheme.bodyLarge
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
                                                .watch<SalesReturnController>()
                                                .getselectedcust2 !=
                                            null
                                        ? " ${context.watch<SalesReturnController>().getselectedcust2!.email}"
                                        : '',
                                    style: theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: widget.custHeight * 0.01,
                      ),
                      SizedBox(
                        width: widget.custWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: widget.custWidth * 0.465,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Gst",
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black54)),
                                  Container(
                                    padding: EdgeInsets.only(
                                      right: widget.custWidth * 0.02,
                                    ),
                                    child: Text(
                                        context
                                                    .watch<
                                                        SalesReturnController>()
                                                    .getselectedcust2 !=
                                                null
                                            ? "${context.watch<SalesReturnController>().getselectedcust2!.tarNo}"
                                            : '',
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              width: widget.custWidth * 0.465,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Balance",
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black54)),
                                  Text(
                                      context
                                                  .watch<
                                                      SalesReturnController>()
                                                  .getselectedcust2 !=
                                              null
                                          ? "${context.watch<SalesReturnController>().getselectedcust2!.accBalance}"
                                          : '',
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black54)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: widget.custHeight * 0.01,
                      ),
                      SizedBox(
                        width: widget.custWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: widget.custWidth * 0.465,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Code#",
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black54)),
                                  Container(
                                    padding: EdgeInsets.only(
                                      right: widget.custWidth * 0.02,
                                    ),
                                    child: Text(
                                        context
                                                    .watch<
                                                        SalesReturnController>()
                                                    .getselectedcust2 !=
                                                null
                                            ? "${context.watch<SalesReturnController>().getselectedcust2!.cardCode}"
                                            : '',
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              width: widget.custWidth * 0.465,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Point",
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black54)),
                                  Text(
                                      context
                                                  .watch<
                                                      SalesReturnController>()
                                                  .getselectedcust2 !=
                                              null
                                          ? "${context.watch<SalesReturnController>().getselectedcust2!.point}"
                                          : '',
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black54)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: widget.custHeight * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: SizedBox(
                              width: widget.custWidth * 0.465,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: widget.custWidth * 0.465,
                                    padding: EdgeInsets.only(
                                        right: widget.custWidth * 0.02),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Billing Address",
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ),
                                  context
                                                  .watch<
                                                      SalesReturnController>()
                                                  .getselectedcust2 !=
                                              null &&
                                          context
                                              .watch<SalesReturnController>()
                                              .getselectedcust2!
                                              .address!
                                              .isNotEmpty
                                      ? Text(
                                          "${context.watch<SalesReturnController>().getselectedcust2!.address![0].address1 != null ? context.watch<SalesReturnController>().getselectedcust2!.address![0].address1.toString() : ''}${context.watch<SalesReturnController>().getselectedcust2!.address![0].address2 != null ? context.watch<SalesReturnController>().getselectedcust2!.address![0].address2.toString() : ""}${context.watch<SalesReturnController>().getselectedcust2!.address![0].address3 != null ? context.watch<SalesReturnController>().getselectedcust2!.address![0].address3.toString() : ""}",
                                          maxLines: 1,
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black54),
                                        )
                                      : Text(''),
                                  context
                                                  .watch<
                                                      SalesReturnController>()
                                                  .getselectedcust2 !=
                                              null &&
                                          (context
                                                      .watch<
                                                          SalesReturnController>()
                                                      .getselectedcust2!
                                                      .address !=
                                                  null ||
                                              context
                                                  .watch<
                                                      SalesReturnController>()
                                                  .getselectedcust2!
                                                  .address!
                                                  .isNotEmpty)
                                      ? Text(
                                          context
                                                      .watch<
                                                          SalesReturnController>()
                                                      .getselectedcust2!
                                                      .address!
                                                      .isNotEmpty &&
                                                  context
                                                      .watch<
                                                          SalesReturnController>()
                                                      .getselectedcust2!
                                                      .address![0]
                                                      .billCity
                                                      .isNotEmpty
                                              ? context
                                                  .watch<
                                                      SalesReturnController>()
                                                  .getselectedcust2!
                                                  .address![0]
                                                  .billCity
                                                  .toString()
                                              : '',
                                          maxLines: 1,
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black54),
                                        )
                                      : Text(''),
                                  context
                                                  .watch<
                                                      SalesReturnController>()
                                                  .getselectedcust2 !=
                                              null &&
                                          context
                                                  .watch<
                                                      SalesReturnController>()
                                                  .getselectedcust2!
                                                  .address!
                                                  .length >
                                              0
                                      ? Text(
                                          context
                                              .watch<SalesReturnController>()
                                              .getselectedcust2!
                                              .address![0]
                                              .billPincode
                                              .toString(),
                                          maxLines: 1,
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black54),
                                        )
                                      : Text(''),
                                  context
                                                  .watch<
                                                      SalesReturnController>()
                                                  .getselectedcust2 !=
                                              null &&
                                          context
                                              .watch<SalesReturnController>()
                                              .getselectedcust2!
                                              .address!
                                              .isNotEmpty
                                      ? Text(
                                          context
                                              .watch<SalesReturnController>()
                                              .getselectedcust2!
                                              .address![0]
                                              .billstate
                                              .toString(),
                                          maxLines: 1,
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black54),
                                        )
                                      : Text(''),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: SizedBox(
                              width: widget.custWidth * 0.465,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: widget.custWidth * 0.465,
                                    padding: EdgeInsets.only(
                                        right: widget.custWidth * 0.02),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Shipping Address",
                                          maxLines: 2,
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ),
                                  context
                                                  .watch<
                                                      SalesReturnController>()
                                                  .getselectedcust2 !=
                                              null &&
                                          context
                                              .watch<SalesReturnController>()
                                              .getselectedcust2!
                                              .address!
                                              .isNotEmpty
                                      ? Text(
                                          "${context.watch<SalesReturnController>().getselectedcust2!.address![0].address1 != null ? context.watch<SalesReturnController>().getselectedcust2!.address![0].address1.toString() : ''}${context.watch<SalesReturnController>().getselectedcust2!.address![0].address2 != null ? context.watch<SalesReturnController>().getselectedcust2!.address![0].address2.toString() : ""}${context.watch<SalesReturnController>().getselectedcust2!.address![0].address3 != null ? context.watch<SalesReturnController>().getselectedcust2!.address![0].address3.toString() : ""}",
                                          maxLines: 1,
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black54),
                                        )
                                      : Text(''),
                                  context
                                                  .watch<
                                                      SalesReturnController>()
                                                  .getselectedcust2 !=
                                              null &&
                                          context
                                              .watch<SalesReturnController>()
                                              .getselectedcust2!
                                              .address!
                                              .isNotEmpty
                                      ? Text(
                                          context
                                              .watch<SalesReturnController>()
                                              .getselectedcust2!
                                              .address![0]
                                              .billCity
                                              .toString(),
                                          maxLines: 1,
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black54),
                                        )
                                      : Text(''),
                                  context
                                                  .watch<
                                                      SalesReturnController>()
                                                  .getselectedcust2 !=
                                              null &&
                                          context
                                              .watch<SalesReturnController>()
                                              .getselectedcust2!
                                              .address!
                                              .isNotEmpty
                                      ? Text(
                                          context
                                              .watch<SalesReturnController>()
                                              .getselectedcust2!
                                              .address![0]
                                              .billPincode
                                              .toString(),
                                          maxLines: 1,
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black54),
                                        )
                                      : Text(''),
                                  context
                                                  .watch<
                                                      SalesReturnController>()
                                                  .getselectedcust2 !=
                                              null &&
                                          context
                                              .watch<SalesReturnController>()
                                              .getselectedcust2!
                                              .address!
                                              .isNotEmpty
                                      ? Text(
                                          context
                                              .watch<SalesReturnController>()
                                              .getselectedcust2!
                                              .address![0]
                                              .billstate
                                              .toString(),
                                          maxLines: 1,
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black54),
                                        )
                                      : Text(''),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : context.read<SalesReturnController>().getselectedcust == null
                  ? Container(
                      padding: EdgeInsets.symmetric(
                          vertical: widget.custHeight * 0.02,
                          horizontal: widget.custWidth * 0.02),
                      child: const Text(""))
                  : Container(
                      color: Colors.grey[50],
                      padding: EdgeInsets.symmetric(
                          vertical: widget.custHeight * 0.02,
                          horizontal: widget.custWidth * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: widget.custWidth,
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: widget.custWidth * 0.8,
                                    child: Text(
                                      context
                                          .watch<SalesReturnController>()
                                          .getselectedcust!
                                          .name
                                          .toString(),
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(
                                              color: Colors.black,
                                              fontSize: 20),
                                    ),
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: widget.custHeight * 0.01,
                          ),
                          SizedBox(
                            width: widget.custWidth,
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.phone,
                                      color: Colors.black54,
                                    ),
                                    Text(
                                        " ${context.watch<SalesReturnController>().getselectedcust!.phNo}  |  ",
                                        style: theme.textTheme.bodyLarge
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
                                                            SalesReturnController>()
                                                        .getselectedcust!
                                                        .email ==
                                                    null ||
                                                context
                                                        .watch<
                                                            SalesReturnController>()
                                                        .getselectedcust!
                                                        .email ==
                                                    'null' ||
                                                context
                                                    .watch<
                                                        SalesReturnController>()
                                                    .getselectedcust!
                                                    .email!
                                                    .isEmpty
                                            ? ""
                                            : " ${context.watch<SalesReturnController>().getselectedcust!.email.toString()}",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: widget.custHeight * 0.01,
                          ),
                          SizedBox(
                            width: widget.custWidth,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: widget.custWidth * 0.465,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Gst",
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(
                                                  color: Colors.black54)),
                                      Container(
                                        padding: EdgeInsets.only(
                                          right: widget.custWidth * 0.02,
                                        ),
                                        child: Text(
                                            context
                                                            .watch<
                                                                SalesReturnController>()
                                                            .getselectedcust!
                                                            .tarNo ==
                                                        null ||
                                                    context
                                                            .watch<
                                                                SalesReturnController>()
                                                            .getselectedcust!
                                                            .tarNo ==
                                                        'null' ||
                                                    context
                                                        .watch<
                                                            SalesReturnController>()
                                                        .getselectedcust!
                                                        .tarNo!
                                                        .isEmpty
                                                ? ""
                                                : "${context.watch<SalesReturnController>().getselectedcust!.tarNo}",
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    color: Colors.black54)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: widget.custWidth * 0.465,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Balance",
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(
                                                  color: Colors.black54)),
                                      Text(
                                          "${context.watch<SalesReturnController>().config.slpitCurrency2(context.watch<SalesReturnController>().getselectedcust!.accBalance!.toStringAsFixed(2))}",
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(
                                                  color: Colors.black54)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: widget.custHeight * 0.01,
                          ),
                          SizedBox(
                            width: widget.custWidth,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: widget.custWidth * 0.465,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Code#",
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(
                                                  color: Colors.black54)),
                                      Container(
                                        padding: EdgeInsets.only(
                                          right: widget.custWidth * 0.02,
                                        ),
                                        child: Text(
                                            "${context.watch<SalesReturnController>().getselectedcust!.cardCode}",
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    color: Colors.black54)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: widget.custWidth * 0.465,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Point",
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(
                                                  color: Colors.black54)),
                                      Text(
                                          "${context.watch<SalesReturnController>().getselectedcust!.point}",
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(
                                                  color: Colors.black54)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: widget.custHeight * 0.01,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: widget.custWidth * 0.465,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: widget.custWidth * 0.465,
                                      padding: EdgeInsets.only(
                                          right: widget.custWidth * 0.02),
                                      child: Text(
                                        "Billing Address",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      ),
                                    ),
                                    context
                                            .watch<SalesReturnController>()
                                            .getselectedcust!
                                            .address!
                                            .isNotEmpty
                                        ? Text(
                                            "${context.watch<SalesReturnController>().getselectedcust!.address![0].address1 == null || context.watch<SalesReturnController>().getselectedcust!.address![0].address1!.isEmpty ? '' : context.watch<SalesReturnController>().getselectedcust!.address![0].address1.toString()}"
                                            "${context.watch<SalesReturnController>().getselectedcust!.address![0].address2 == null || context.watch<SalesReturnController>().getselectedcust!.address![0].address2!.isEmpty ? '' : context.watch<SalesReturnController>().getselectedcust!.address![0].address2.toString()}"
                                            "${context.watch<SalesReturnController>().getselectedcust!.address![0].address3 == null || context.watch<SalesReturnController>().getselectedcust!.address![0].address3!.isEmpty ? '' : context.watch<SalesReturnController>().getselectedcust!.address![0].address3.toString()}",
                                            maxLines: 1,
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    color: Colors.black54),
                                          )
                                        : Text(''),
                                    context
                                                    .watch<
                                                        SalesReturnController>()
                                                    .getselectedcust2 ==
                                                null ||
                                            context
                                                    .watch<
                                                        SalesReturnController>()
                                                    .getselectedcust2!
                                                    .address ==
                                                null ||
                                            context
                                                .watch<SalesReturnController>()
                                                .getselectedcust2!
                                                .address!
                                                .isEmpty
                                        ? Container()
                                        : Text(
                                            context
                                                .watch<SalesReturnController>()
                                                .getselectedcust!
                                                .address![0]
                                                .billCity
                                                .toString(),
                                            maxLines: 1,
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    color: Colors.black54),
                                          ),
                                    context
                                                    .watch<
                                                        SalesReturnController>()
                                                    .getselectedcust2 ==
                                                null ||
                                            context
                                                    .watch<
                                                        SalesReturnController>()
                                                    .getselectedcust2!
                                                    .address ==
                                                null ||
                                            context
                                                .watch<SalesReturnController>()
                                                .getselectedcust2!
                                                .address!
                                                .isEmpty
                                        ? Container()
                                        : Text(
                                            context
                                                .watch<SalesReturnController>()
                                                .getselectedcust!
                                                .address![0]
                                                .billPincode
                                                .toString(),
                                            maxLines: 1,
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    color: Colors.black54),
                                          ),
                                    context
                                                    .watch<
                                                        SalesReturnController>()
                                                    .getselectedcust2 ==
                                                null ||
                                            context
                                                    .watch<
                                                        SalesReturnController>()
                                                    .getselectedcust2!
                                                    .address ==
                                                null ||
                                            context
                                                .watch<SalesReturnController>()
                                                .getselectedcust2!
                                                .address!
                                                .isEmpty
                                        ? Container()
                                        : Text(
                                            context
                                                .watch<SalesReturnController>()
                                                .getselectedcust!
                                                .address![0]
                                                .billstate
                                                .toString(),
                                            maxLines: 1,
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    color: Colors.black54),
                                          ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: widget.custWidth * 0.465,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: widget.custWidth * 0.465,
                                      padding: EdgeInsets.only(
                                          right: widget.custWidth * 0.02),
                                      child: Text(
                                        "Shipping Address",
                                        maxLines: 2,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      ),
                                    ),
                                    context
                                                    .watch<
                                                        SalesReturnController>()
                                                    .getselectedcust55 !=
                                                null &&
                                            context
                                                .watch<SalesReturnController>()
                                                .getselectedcust55!
                                                .address!
                                                .isNotEmpty
                                        ? Text(
                                            "${context.watch<SalesReturnController>().getselectedcust55!.address![0].address1 != null ? context.watch<SalesReturnController>().getselectedcust55!.address![0].address1.toString() : ''}"
                                            "${context.watch<SalesReturnController>().getselectedcust55!.address![0].address2 != null ? context.watch<SalesReturnController>().getselectedcust55!.address![0].address2.toString() : ""}"
                                            "${context.watch<SalesReturnController>().getselectedcust55!.address![0].address3 != null ? context.watch<SalesReturnController>().getselectedcust55!.address![0].address3.toString() : ""}",
                                            maxLines: 1,
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    color: Colors.black54),
                                          )
                                        : Container(),
                                    context
                                                    .watch<
                                                        SalesReturnController>()
                                                    .getselectedcust55 !=
                                                null &&
                                            context
                                                .watch<SalesReturnController>()
                                                .getselectedcust55!
                                                .address!
                                                .isNotEmpty
                                        ? Text(
                                            context
                                                .watch<SalesReturnController>()
                                                .getselectedcust55!
                                                .address![0]
                                                .billCity
                                                .toString(),
                                            maxLines: 1,
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    color: Colors.black54),
                                          )
                                        : Container(),
                                    context
                                                    .watch<
                                                        SalesReturnController>()
                                                    .getselectedcust55 !=
                                                null &&
                                            context
                                                .watch<SalesReturnController>()
                                                .getselectedcust55!
                                                .address!
                                                .isNotEmpty
                                        ? Text(
                                            context
                                                .watch<SalesReturnController>()
                                                .getselectedcust55!
                                                .address![0]
                                                .billPincode
                                                .toString(),
                                            maxLines: 1,
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    color: Colors.black54),
                                          )
                                        : Container(),
                                    context
                                                    .watch<
                                                        SalesReturnController>()
                                                    .getselectedcust55 !=
                                                null &&
                                            context
                                                .watch<SalesReturnController>()
                                                .getselectedcust55!
                                                .address!
                                                .isNotEmpty
                                        ? Text(
                                            context
                                                .watch<SalesReturnController>()
                                                .getselectedcust55!
                                                .address![0]
                                                .billstate
                                                .toString(),
                                            maxLines: 1,
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    color: Colors.black54),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
        ],
      ),
    );
  }

  forSearchBtn(BuildContext context) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.only(
            top: widget.custHeight * 0.05,
            left: widget.custHeight * 0.05,
            right: widget.custHeight * 0.05,
            bottom: widget.custHeight * 0.05),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: widget.custWidth * 1.1,
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 240, 235, 235)),
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey.withOpacity(0.01),
              ),
              child: TextFormField(
                textCapitalization: TextCapitalization.sentences,
                controller:
                    context.read<SalesReturnController>().searchcontroller,
                cursorColor: Colors.grey,
                autofocus: true,
                onChanged: (v) {
                  st(() {
                    context.read<SalesReturnController>().filterList(v);
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search customer..!!',
                  hintStyle:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.grey),
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
            SizedBox(height: widget.custHeight * 0.05),
            SizedBox(
                height: widget.custHeight * 2,
                width: widget.custWidth * 1.1,
                child: ListView.builder(
                    itemCount: context
                        .read<SalesReturnController>()
                        .getfiltercustList
                        .length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          padding: EdgeInsets.only(
                              top: widget.custHeight * 0.01,
                              left: widget.custHeight * 0.01,
                              right: widget.custHeight * 0.01,
                              bottom: widget.custHeight * 0.03),
                          child: StatefulBuilder(builder: (context, st) {
                            return ListTile(
                              onTap: () async {
                                context
                                    .read<SalesReturnController>()
                                    .custSelected(
                                        context
                                            .read<SalesReturnController>()
                                            .getfiltercustList[index],
                                        context,
                                        theme);
                                log('message1');
                                await context
                                    .read<SalesReturnController>()
                                    .callGetSalesRetCardCodeApi(
                                        context,
                                        context
                                            .read<SalesReturnController>()
                                            .getfiltercustList[index]
                                            .cardCode
                                            .toString());
                                log('message2');

                                Get.back();
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
                                          .watch<SalesReturnController>()
                                          .getfiltercustList[index]
                                          .cardCode!),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: widget.custWidth * 0.7,
                                        child: Text(
                                          context
                                              .watch<SalesReturnController>()
                                              .getfiltercustList[index]
                                              .name!,
                                          maxLines: 2,
                                        ),
                                      ),
                                      Text(context
                                          .watch<SalesReturnController>()
                                          .getfiltercustList[index]
                                          .phNo!),
                                    ],
                                  )
                                ],
                              ),
                            );
                          }),
                        ),
                      );
                    })),
            SizedBox(height: widget.custHeight * 0.09),
          ],
        ),
      );
    });
  }
}

class TopCustomer extends StatelessWidget {
  TopCustomer({
    super.key,
    required this.ind,
    required this.posC,
    required this.theme,
  });
  PosController posC;
  ThemeData theme;
  int ind;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        posC.custSelected(posC.custList[ind], context, theme);
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: theme.primaryColor,
            border: Border.all(color: theme.primaryColor, width: 1),
            borderRadius: BorderRadius.circular(5)),
        child: Text(posC.custList[ind].name!,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: Colors.white,
            )),
      ),
    );
  }
}

Widget updateType(BuildContext context, PosController pos) {
  final theme = Theme.of(context);
  return SizedBox(
    width: Screens.width(context) * 0.8,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.center,
          height: Screens.padingHeight(context) * 0.05,
          decoration: BoxDecoration(
            color: theme.primaryColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: Screens.width(context) * 0.4,
                alignment: Alignment.center,
                child: Text(
                  "Confrim update",
                  textAlign: TextAlign.center,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.white),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    size: Screens.padingHeight(context) * 0.025,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: Screens.bodyheight(context) * 0.02,
        ),
        Container(
          width: Screens.width(context) * 0.8,
          padding: EdgeInsets.symmetric(
            vertical: Screens.padingHeight(context) * 0.01,
            horizontal: Screens.width(context) * 0.01,
          ),
          child: Column(
            children: [
              const Text(
                  "Do you want to update this customer for this sale or update to server..!!"),
              SizedBox(
                height: Screens.bodyheight(context) * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: Screens.width(context) * 0.3,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);

                          Navigator.pop(context);
                        },
                        child: const Text("Update to server")),
                  ),
                  SizedBox(
                      width: Screens.width(context) * 0.3,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);

                            Navigator.pop(context);
                          },
                          child: const Text("This sale"))),
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}

billAddress(BuildContext context, PosController pos) async {
  final theme = Theme.of(context);
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: AlertBox(
              payMent: 'Address',
              widget: Container(
                padding: EdgeInsets.symmetric(
                  vertical: Screens.padingHeight(context) * 0.01,
                  horizontal: Screens.width(context) * 0.01,
                ),
                child: Column(
                  children: [
                    Container(
                      height: Screens.padingHeight(context) * 0.3,
                      width: Screens.width(context) * 0.45,
                      padding: EdgeInsets.symmetric(
                        vertical: Screens.padingHeight(context) * 0.01,
                        horizontal: Screens.width(context) * 0.01,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: pos.selectedcust!.address!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              pos.changeBillAddress(index);
                              Navigator.pop(context);
                            },
                            child: Card(
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical:
                                          Screens.padingHeight(context) * 0.01,
                                      horizontal: Screens.width(context) * 0.01,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${pos.selectedcust!.address![index].address1}${pos.selectedcust!.address![index].address2}${pos.selectedcust!.address![index].address3}"),
                                        Text(pos.selectedcust!.address![index]
                                            .billCity),
                                        Text(pos.selectedcust!.address![index]
                                            .billPincode),
                                        Text(pos.selectedcust!.address![index]
                                            .billstate)
                                      ],
                                    ))),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              buttonName: "Create Address",
              callback: () {
                Navigator.pop(context);
                createAddress(context, theme, pos);
              },
            ));
      });
}

sipaddress(BuildContext context, PosController pos) async {
  final theme = Theme.of(context);
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: AlertBox(
              payMent: 'Address',
              widget: SizedBox(
                height: Screens.padingHeight(context) * 0.3,
                width: Screens.width(context) * 0.25,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: pos.selectedcust!.address!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        pos.changeShipAddress(index);
                        Navigator.pop(context);
                      },
                      child: Card(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${pos.selectedcust!.address![index].address1}${pos.selectedcust!.address![index].address2}${pos.selectedcust!.address![index].address3}"),
                          Text(pos.selectedcust!.address![index].billCity),
                          Text(pos.selectedcust!.address![index].billPincode),
                          Text(pos.selectedcust!.address![index].billstate)
                        ],
                      )),
                    );
                  },
                ),
              ),
              buttonName: "Create Address",
              callback: () {
                Navigator.pop(context);
                createAddress(context, theme, pos);
              },
            ));
      });
}

createAddress(BuildContext context, ThemeData theme, PosController pos) async {
  final theme = Theme.of(context);
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: AlertBox(
              payMent: 'Create Address',
              widget: createAddressMethod(theme, context, pos),
              buttonName: "Save",
              callback: () {},
            ));
      });
}

Container createAddressMethod(
    ThemeData theme, BuildContext context, PosController pos) {
  return Container(
    width: Screens.width(context) * 0.7,
    height: Screens.padingHeight(context) * 0.4,
    padding: EdgeInsets.symmetric(
      horizontal: Screens.width(context) * 0.02,
      vertical: Screens.padingHeight(context) * 0.02,
    ),
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AddressWidget(
            theme: theme,
            posController: pos,
            custHeight: Screens.width(context) * 0.4,
            custWidth: Screens.width(context) * 0.7,
          ),
        ],
      ),
    ),
  );
}

class AddressWidget extends StatelessWidget {
  const AddressWidget(
      {super.key,
      required this.theme,
      required this.posController,
      required this.custHeight,
      required this.custWidth});

  final ThemeData theme;
  final double custHeight;
  final double custWidth;

  final PosController posController;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, st) {
      return Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.grey.withOpacity(0.01),
            ),
            child: TextFormField(
              controller: posController.mycontroller[4],
              cursorColor: Colors.grey,
              style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
              onChanged: (v) {},
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please Enter the Address1";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                labelText: "Bill Address1",
                filled: false,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
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
          SizedBox(
            height: custHeight * 0.02,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.grey.withOpacity(0.01),
            ),
            child: TextFormField(
              controller: posController.mycontroller[5],
              cursorColor: Colors.grey,
              style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
              onChanged: (v) {},
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please Enter the Address2";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                labelText: "Bill Address2",
                filled: false,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
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
          SizedBox(
            height: custHeight * 0.02,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.grey.withOpacity(0.01),
            ),
            child: TextFormField(
              controller: posController.mycontroller[6],
              cursorColor: Colors.grey,
              style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
              onChanged: (v) {},
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please Enter the Address3";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                labelText: "Bill Address3",
                filled: false,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
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
          SizedBox(
            height: custHeight * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: custWidth * 0.45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.01),
                ),
                child: TextFormField(
                  controller: posController.mycontroller[29],
                  cursorColor: Colors.grey,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                  onChanged: (v) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter the City Name";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "City",
                    filled: false,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
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
              Container(
                width: custWidth * 0.45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.01),
                ),
                child: TextFormField(
                  controller: posController.mycontroller[30],
                  cursorColor: Colors.grey,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                  onChanged: (v) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter the Pincode";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Pincode",
                    filled: false,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
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
            ],
          ),
          SizedBox(
            height: custHeight * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: custWidth * 0.45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.01),
                ),
                child: TextFormField(
                  controller: posController.mycontroller[31],
                  cursorColor: Colors.grey,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                  onChanged: (v) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter the State";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "State",
                    filled: false,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
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
              Container(
                width: custWidth * 0.45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.01),
                ),
                child: TextFormField(
                  readOnly: true,
                  controller: posController.mycontroller[32],
                  cursorColor: Colors.grey,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                  onChanged: (v) {},
                  decoration: InputDecoration(
                    hintText: "Ind",
                    filled: false,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
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
            ],
          ),
          SizedBox(
            height: custHeight * 0.02,
          ),
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                height: custHeight * 0.1,
                child: const Text("Copy As Ship Address"),
              ),
              SizedBox(
                width: custWidth * 0.2,
              ),
              Checkbox(
                  side: const BorderSide(color: Colors.grey),
                  activeColor: Colors.green,
                  value: posController.checkboxx,
                  onChanged: (val) {
                    st(() {
                      posController.checkboxx = val!;
                      posController.billToShip(val);
                    });
                  }),
            ],
          ),
          SizedBox(
            height: custHeight * 0.02,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.01),
                ),
                child: TextFormField(
                  autofocus: true,
                  controller: posController.mycontroller[7],
                  cursorColor: Colors.grey,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                  onChanged: (v) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter the Ship Address1";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Ship Address1',
                    filled: false,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
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
              SizedBox(
                height: custHeight * 0.02,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.01),
                ),
                child: TextFormField(
                  autofocus: true,
                  controller: posController.mycontroller[8],
                  cursorColor: Colors.grey,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                  onChanged: (v) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter the Ship Address2";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Ship Address2',
                    filled: false,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
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
              SizedBox(
                height: custHeight * 0.02,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 240, 235, 235)),
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.01),
                ),
                child: TextFormField(
                  autofocus: true,
                  controller: posController.mycontroller[9],
                  cursorColor: Colors.grey,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                  onChanged: (v) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter the Ship Address3";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Ship Address3",
                    filled: false,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
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
            ],
          ),
          SizedBox(
            height: custHeight * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: custWidth * 0.45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.01),
                ),
                child: TextFormField(
                  controller: posController.mycontroller[33],
                  cursorColor: Colors.grey,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                  onChanged: (v) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter the City Name";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "City",
                    filled: false,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
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
              Container(
                width: custWidth * 0.45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.01),
                ),
                child: TextFormField(
                  controller: posController.mycontroller[34],
                  cursorColor: Colors.grey,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                  onChanged: (v) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter the Pincode";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Pincode",
                    filled: false,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
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
            ],
          ),
          SizedBox(
            height: custHeight * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: custWidth * 0.45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.01),
                ),
                child: TextFormField(
                  controller: posController.mycontroller[35],
                  cursorColor: Colors.grey,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                  onChanged: (v) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter the State";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "State",
                    filled: false,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
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
              Container(
                width: custWidth * 0.45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.01),
                ),
                child: TextFormField(
                  readOnly: true,
                  controller: posController.mycontroller[36],
                  cursorColor: Colors.grey,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                  onChanged: (v) {},
                  decoration: InputDecoration(
                    hintText: "Ind",
                    filled: false,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
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
            ],
          ),
        ],
      );
    });
  }
}
