import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:posproject/Controller/SalesInvoice/SalesInvoiceController.dart';
import 'package:posproject/Controller/StockRequestController/StockRequestController.dart';
import 'package:posproject/Widgets/AlertBox.dart';

class StockReqCustomer extends StatefulWidget {
  StockReqCustomer(
      {super.key,
      required this.theme,
      required this.custHeight,
      required this.custWidth});

  final ThemeData theme;
  double custHeight;
  double custWidth;

  @override
  State<StockReqCustomer> createState() => _StockReqCustomerState();
}

class _StockReqCustomerState extends State<StockReqCustomer> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.only(
          top: widget.custHeight * 0.01,
          bottom: widget.custHeight * 0.01,
          left: widget.custHeight * 0.01,
          right: widget.custHeight * 0.01),
      width: widget.custWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          context.watch<StockReqController>().getScanneditemData2.isEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: widget.custWidth * 0.45,
                      height: widget.custHeight * 0.15,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 240, 235, 235)),
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.001),
                      ),
                      child: TextFormField(
                        controller:
                            context.read<StockReqController>().mycontroller[1],
                        onChanged: (v) {},
                        readOnly: true,
                        onTap: () {
                          setState(() {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      contentPadding: const EdgeInsets.all(0),
                                      content: AlertBox(
                                        payMent: 'Select WareHouse',
                                        widget: forSearchBtn(
                                          context,
                                        ),
                                        buttonName: null,
                                      ));
                                }).then((value) {
                              setState(() {});
                            });
                          });
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        contentPadding: const EdgeInsets.all(0),
                                        content: AlertBox(
                                          payMent: 'Select WareHouse',
                                          widget: forSearchBtn(
                                            context,
                                          ),
                                          buttonName: null,
                                        ));
                                  });
                            },
                            color: theme.primaryColor,
                          ),
                          hintText: 'Locations',
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
                      height: widget.custHeight * 0.15,
                      width: widget.custWidth * 0.45,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 240, 235, 235)),
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.001),
                      ),
                      child: TextFormField(
                        controller:
                            context.read<StockReqController>().mycontroller[1],
                        onChanged: (v) {},
                        readOnly: true,
                        onTap: () {
                          context.read<StockReqController>().refresCufstList();

                          setState(() {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      contentPadding: const EdgeInsets.all(0),
                                      content: AlertBox(
                                        payMent: 'Select Customers',
                                        widget: forSearchCustBtn(
                                          context,
                                        ),
                                        buttonName: null,
                                      ));
                                }).then((value) {
                              setState(() {});
                            });
                          });
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        contentPadding: const EdgeInsets.all(0),
                                        content: AlertBox(
                                          payMent: 'Select Customers',
                                          widget: forSearchCustBtn(
                                            context,
                                          ),
                                          buttonName: null,
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
                  ],
                )
              : Container(),
          SizedBox(
            height: widget.custHeight * 0.01,
          ),
          context.watch<StockReqController>().getWhssSlectedList2 != null
              ? Container(
                  color: Colors.grey[300],
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: widget.custWidth * 0.47,
                        padding: EdgeInsets.symmetric(
                            vertical: widget.custHeight * 0.01,
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
                                      width: widget.custWidth * 0.43,
                                      child: Text(
                                        "${context.watch<StockReqController>().getWhssSlectedList2!.companyName ?? ''}",
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                          color: Colors.black,
                                        ),
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
                                          "${context.watch<StockReqController>().getWhssSlectedList2!.whsPhoNo ?? ''}  |  ",
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.grey)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.mail_outline,
                                        color: Colors.black54,
                                      ),
                                      Text(
                                          "${context.watch<StockReqController>().getWhssSlectedList2!.whsmailID}",
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.grey)),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: widget.custWidth * 0.43,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: widget.custWidth * 0.2,
                                          child: Text("GST#",
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.grey)),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                            right: widget.custWidth * 0.02,
                                          ),
                                          child: Text(
                                              "${context.watch<StockReqController>().getWhssSlectedList2!.whsGst ?? ''}",
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.grey)),
                                        ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: widget.custWidth * 0.43,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: widget.custWidth * 0.2,
                                          child: Text("Code#",
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.grey)),
                                        ),
                                        Text(
                                            context
                                                    .watch<StockReqController>()
                                                    .getWhssSlectedList2!
                                                    .whsCode ??
                                                '',
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: widget.custWidth * 0.01,
                                ),
                                SizedBox(
                                  width: widget.custWidth * 0.43,
                                  child: Text(
                                      "${context.watch<StockReqController>().getWhssSlectedList2!.whsAddress}",
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.grey)),
                                ),
                                SizedBox(
                                  width: widget.custWidth * 0.43,
                                  child: Text(
                                      "${context.watch<StockReqController>().getWhssSlectedList2!.whsCity}",
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.grey)),
                                ),
                                SizedBox(
                                  width: widget.custWidth * 0.43,
                                  child: Text(
                                      "${context.watch<StockReqController>().getWhssSlectedList2!.pinCode}",
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.grey)),
                                ),
                                SizedBox(
                                  width: widget.custWidth * 0.43,
                                  child: Text(
                                      "${context.watch<StockReqController>().getWhssSlectedList2!.whsState}",
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.grey)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      context.watch<StockReqController>().selectedcust2 != null
                          ? Container(
                              padding: EdgeInsets.all(5),
                              width: widget.custWidth * 0.49,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Container(
                                      width: widget.custWidth * 0.39,
                                      child: Text(
                                        context
                                                        .watch<
                                                            StockReqController>()
                                                        .selectedcust2 !=
                                                    null &&
                                                context
                                                        .watch<
                                                            StockReqController>()
                                                        .selectedcust2!
                                                        .name !=
                                                    null
                                            ? context
                                                .watch<StockReqController>()
                                                .selectedcust2!
                                                .name!
                                            : '',
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: widget.custHeight * 0.02,
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
                                                                .watch<
                                                                    StockReqController>()
                                                                .selectedcust2 !=
                                                            null &&
                                                        (context
                                                                    .watch<
                                                                        StockReqController>()
                                                                    .selectedcust2!
                                                                    .phNo !=
                                                                null ||
                                                            context
                                                                .read<
                                                                    StockReqController>()
                                                                .selectedcust2!
                                                                .phNo!
                                                                .isNotEmpty)
                                                    ? "${context.watch<StockReqController>().selectedcust2!.phNo}  |  "
                                                    : '',
                                                style: theme.textTheme.bodyLarge
                                                    ?.copyWith(
                                                        color: Colors.black54)),
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
                                                                    StockReqController>()
                                                                .selectedcust2 !=
                                                            null &&
                                                        context
                                                            .watch<
                                                                StockReqController>()
                                                            .selectedcust2!
                                                            .email!
                                                            .isNotEmpty
                                                    ? " ${context.watch<StockReqController>().selectedcust2!.email}"
                                                    : "",
                                                style: theme.textTheme.bodyLarge
                                                    ?.copyWith(
                                                        color: Colors.black54)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: widget.custHeight * 0.02,
                                  ),
                                  SizedBox(
                                    width: widget.custWidth * 0.465,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Card Code",
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    color: Colors.black54)),
                                        Container(
                                          padding: EdgeInsets.only(
                                            right: widget.custWidth * 0.02,
                                          ),
                                          child: Text(
                                              "${context.watch<StockReqController>().selectedcust2!.cardCode}",
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
                                            context
                                                            .watch<
                                                                StockReqController>()
                                                            .selectedcust2!
                                                            .accBalance !=
                                                        null ||
                                                    context
                                                            .watch<
                                                                StockReqController>()
                                                            .selectedcust2!
                                                            .accBalance !=
                                                        0
                                                ? context
                                                    .watch<StockReqController>()
                                                    .config
                                                    .splitValues(context
                                                        .watch<
                                                            StockReqController>()
                                                        .selectedcust2!
                                                        .accBalance
                                                        .toString())
                                                : '0.00',
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    color: Colors.black54)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                )
              : context.watch<StockReqController>().get_whssSlectedList ==
                          null &&
                      context.watch<StockReqController>().selectedcust == null
                  ? Container()
                  : Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          context
                                      .watch<StockReqController>()
                                      .get_whssSlectedList !=
                                  null
                              ? Container(
                                  width: widget.custWidth * 0.49,
                                  color: Colors.grey[50],
                                  padding: EdgeInsets.symmetric(
                                      vertical: widget.custHeight * 0.01,
                                      horizontal: widget.custWidth * 0.01),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: widget.custWidth,
                                          alignment: Alignment.centerRight,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: widget.custWidth * 0.4,
                                                child: context
                                                            .watch<
                                                                StockReqController>()
                                                            .get_whssSlectedList!
                                                            .companyName!
                                                            .isNotEmpty ||
                                                        context
                                                                .watch<
                                                                    StockReqController>()
                                                                .get_whssSlectedList!
                                                                .companyName !=
                                                            null
                                                    ? Text(
                                                        "${context.watch<StockReqController>().get_whssSlectedList!.companyName}",
                                                        style: theme.textTheme
                                                            .titleMedium
                                                            ?.copyWith(
                                                          color: Colors.black,
                                                        ),
                                                      )
                                                    : Text(''),
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    context
                                                        .read<
                                                            StockReqController>()
                                                        .clearData();
                                                  },
                                                  child: Container(
                                                    width:
                                                        widget.custWidth * 0.06,
                                                    alignment: Alignment.center,
                                                    child: const Icon(
                                                        Icons.close_sharp),
                                                  )),
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
                                                    "${context.watch<StockReqController>().get_whssSlectedList!.whsPhoNo}  |  ",
                                                    style: theme
                                                        .textTheme.bodyLarge
                                                        ?.copyWith(
                                                            color:
                                                                Colors.grey)),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.mail_outline,
                                                  color: Colors.black54,
                                                ),
                                                Text(
                                                    "${context.watch<StockReqController>().get_whssSlectedList!.whsmailID}",
                                                    style: theme
                                                        .textTheme.bodyLarge
                                                        ?.copyWith(
                                                            color:
                                                                Colors.grey)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: widget.custHeight * 0.01,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Container(
                                                  width:
                                                      widget.custWidth * 0.08,
                                                  child: Text("GST#",
                                                      style: theme
                                                          .textTheme.bodyLarge
                                                          ?.copyWith(
                                                              color:
                                                                  Colors.grey)),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    right:
                                                        widget.custWidth * 0.11,
                                                  ),
                                                  child: context
                                                              .watch<
                                                                  StockReqController>()
                                                              .get_whssSlectedList!
                                                              .whsGst!
                                                              .isNotEmpty ||
                                                          context
                                                                  .watch<
                                                                      StockReqController>()
                                                                  .get_whssSlectedList!
                                                                  .whsGst !=
                                                              null
                                                      ? Text(
                                                          "${context.watch<StockReqController>().get_whssSlectedList!.whsGst}",
                                                          style: theme.textTheme
                                                              .bodyLarge
                                                              ?.copyWith(
                                                                  color: Colors
                                                                      .grey))
                                                      : Text(''),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: widget.custWidth * 0.21,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width:
                                                      widget.custWidth * 0.08,
                                                  child: Text("Code#",
                                                      style: theme
                                                          .textTheme.bodyLarge
                                                          ?.copyWith(
                                                              color:
                                                                  Colors.grey)),
                                                ),
                                                Text(
                                                    "${context.watch<StockReqController>().get_whssSlectedList!.whsCode}",
                                                    style: theme
                                                        .textTheme.bodyLarge
                                                        ?.copyWith(
                                                            color:
                                                                Colors.grey)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: widget.custWidth * 0.01,
                                          ),
                                          SizedBox(
                                            width: widget.custWidth * 0.9,
                                            child: context
                                                            .watch<
                                                                StockReqController>()
                                                            .get_whssSlectedList!
                                                            .whsAddress !=
                                                        null ||
                                                    context
                                                            .watch<
                                                                StockReqController>()
                                                            .get_whssSlectedList!
                                                            .companyName !=
                                                        null
                                                ? Text(
                                                    "${context.watch<StockReqController>().get_whssSlectedList!.whsAddress}",
                                                    style: theme
                                                        .textTheme.bodyLarge
                                                        ?.copyWith(
                                                            color: Colors.grey))
                                                : Text(''),
                                          ),
                                          SizedBox(
                                            width: widget.custWidth * 0.9,
                                            child: Text(
                                                "${context.watch<StockReqController>().get_whssSlectedList!.whsCity ?? ''}",
                                                style: theme.textTheme.bodyLarge
                                                    ?.copyWith(
                                                        color: Colors.grey)),
                                          ),
                                          SizedBox(
                                            width: widget.custWidth * 0.9,
                                            child: Text(
                                                "${context.watch<StockReqController>().get_whssSlectedList!.pinCode}",
                                                style: theme.textTheme.bodyLarge
                                                    ?.copyWith(
                                                        color: Colors.grey)),
                                          ),
                                          SizedBox(
                                            width: widget.custWidth * 0.9,
                                            child: Text(
                                                "${context.watch<StockReqController>().get_whssSlectedList!.whsState}",
                                                style: theme.textTheme.bodyLarge
                                                    ?.copyWith(
                                                        color: Colors.grey)),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              : Container(),
                          context.watch<StockReqController>().selectedcust !=
                                  null
                              ? Container(
                                  color: Colors.grey[50],
                                  width: widget.custWidth * 0.49,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: widget.custWidth * 0.39,
                                              child: Text(
                                                context
                                                            .watch<
                                                                StockReqController>()
                                                            .selectedcust !=
                                                        null
                                                    ? context
                                                        .watch<
                                                            StockReqController>()
                                                        .selectedcust!
                                                        .name!
                                                    : '',
                                                style: theme
                                                    .textTheme.titleMedium
                                                    ?.copyWith(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: widget.custHeight * 0.1,
                                              alignment: Alignment.center,
                                              child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              StockReqController>()
                                                          .selectedcust = null;
                                                    });
                                                  },
                                                  icon: Icon(Icons.close)),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: widget.custHeight * 0.02,
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
                                                                    .watch<
                                                                        StockReqController>()
                                                                    .selectedcust !=
                                                                null &&
                                                            context
                                                                .read<
                                                                    StockReqController>()
                                                                .selectedcust!
                                                                .phNo!
                                                                .isNotEmpty
                                                        ? "${context.watch<StockReqController>().selectedcust!.phNo}  |  "
                                                        : '',
                                                    style: theme
                                                        .textTheme.bodyLarge
                                                        ?.copyWith(
                                                            color: Colors
                                                                .black54)),
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
                                                                        StockReqController>()
                                                                    .selectedcust !=
                                                                null &&
                                                            context
                                                                .watch<
                                                                    StockReqController>()
                                                                .selectedcust!
                                                                .email!
                                                                .isNotEmpty
                                                        ? " ${context.watch<StockReqController>().selectedcust!.email}"
                                                        : "",
                                                    style: theme
                                                        .textTheme.bodyLarge
                                                        ?.copyWith(
                                                            color: Colors
                                                                .black54)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: widget.custHeight * 0.02,
                                      ),
                                      SizedBox(
                                        width: widget.custWidth * 0.465,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Card Code",
                                                style: theme.textTheme.bodyLarge
                                                    ?.copyWith(
                                                        color: Colors.black54)),
                                            Container(
                                              padding: EdgeInsets.only(
                                                right: widget.custWidth * 0.02,
                                              ),
                                              child: Text(
                                                  "${context.watch<StockReqController>().selectedcust!.cardCode}",
                                                  style: theme
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color:
                                                              Colors.black54)),
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
                                                context
                                                                .watch<
                                                                    StockReqController>()
                                                                .selectedcust!
                                                                .accBalance !=
                                                            null ||
                                                        context
                                                                .watch<
                                                                    StockReqController>()
                                                                .selectedcust!
                                                                .accBalance !=
                                                            0
                                                    ? context
                                                        .watch<
                                                            StockReqController>()
                                                        .config
                                                        .splitValues(context
                                                            .watch<
                                                                StockReqController>()
                                                            .selectedcust!
                                                            .accBalance
                                                            .toString())
                                                    : '0.00',
                                                style: theme.textTheme.bodyLarge
                                                    ?.copyWith(
                                                        color: Colors.black54)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
          SizedBox(
            height: widget.custHeight * 0.02,
          ),
          context.watch<StockReqController>().fromAddressList2 != null
              ? Container(
                  padding: EdgeInsets.only(
                      top: widget.custHeight * 0.01,
                      bottom: widget.custHeight * 0.01,
                      left: widget.custHeight * 0.04,
                      right: widget.custHeight * 0.01),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Delivery Address",
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(color: Colors.black54),
                            ),
                          ],
                        ),
                        Text(
                          "${context.watch<StockReqController>().fromAddressList2!.companyName}",
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: Colors.grey),
                        ),
                        Text(
                          "${context.watch<StockReqController>().fromAddressList2!.whsAddress}",
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: Colors.grey),
                        ),
                        Text(
                          "${context.watch<StockReqController>().fromAddressList2!.whsCity}",
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: Colors.grey),
                        ),
                        Text(
                          "${context.watch<StockReqController>().fromAddressList2!.pinCode}",
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                )
              : context.watch<StockReqController>().fromAddressList == null
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(
                          top: widget.custHeight * 0.01,
                          bottom: widget.custHeight * 0.01,
                          left: widget.custHeight * 0.04,
                          right: widget.custHeight * 0.01),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Delivery Address",
                                  style: theme.textTheme.bodyLarge
                                      ?.copyWith(color: Colors.black),
                                ),
                              ],
                            ),
                            Text(
                              "${context.watch<StockReqController>().fromAddressList!.companyName}",
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(color: Colors.grey),
                            ),
                            Text(
                              "${context.watch<StockReqController>().fromAddressList!.whsAddress}",
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(color: Colors.grey),
                            ),
                            Text(
                              "${context.watch<StockReqController>().fromAddressList!.whsCity}",
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(color: Colors.grey),
                            ),
                            Text(
                              "${context.watch<StockReqController>().fromAddressList!.pinCode}",
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
        ],
      ),
    );
  }

  forSearchBtn(
    BuildContext context,
  ) {
    return StatefulBuilder(builder: (context, st) {
      return StatefulBuilder(builder: (context, st) {
        final theme = Theme.of(context);
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
                  border: Border.all(
                      color: const Color.fromARGB(255, 240, 235, 235)),
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.01),
                ),
                child: TextFormField(
                  controller:
                      context.read<StockReqController>().mycontroller[2],
                  cursorColor: Colors.grey,
                  onChanged: (v) {
                    st(() {
                      context.read<StockReqController>().filterList(v);
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search Warehouse..!!',
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
                  height: widget.custHeight * 1.45,
                  width: widget.custWidth * 1.1,
                  child: ListView.builder(
                      itemCount: context
                          .watch<StockReqController>()
                          .filsterwhsList
                          .length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.04),
                                borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.only(
                                top: widget.custHeight * 0.01,
                                left: widget.custHeight * 0.01,
                                right: widget.custHeight * 0.01,
                                bottom: widget.custHeight * 0.03),
                            child: ListTile(
                              onTap: () {
                                context.read<StockReqController>().whsSelected(
                                    context
                                        .read<StockReqController>()
                                        .filsterwhsList[index],
                                    context);
                                Navigator.pop(context);
                              },
                              title: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        context
                                            .watch<StockReqController>()
                                            .filsterwhsList[index]
                                            .whsCode!,
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(color: Colors.black),
                                      ),
                                      Text(
                                          context
                                              .watch<StockReqController>()
                                              .filsterwhsList[index]
                                              .whsPhoNo!,
                                          style: theme.textTheme.bodyMedium!
                                              .copyWith(color: Colors.black)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          context
                                              .watch<StockReqController>()
                                              .filsterwhsList[index]
                                              .whsName!,
                                          style: theme.textTheme.bodyMedium!
                                              .copyWith(color: Colors.black)),
                                      Text(
                                          context
                                              .watch<StockReqController>()
                                              .filsterwhsList[index]
                                              .whsmailID!,
                                          style: theme.textTheme.bodyMedium!
                                              .copyWith(color: Colors.black)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
            ],
          ),
        );
      });
    });
  }

  forSearchCustBtn(BuildContext context) {
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
                controller: context.read<StockReqController>().searchcontroller,
                cursorColor: Colors.grey,
                autofocus: true,
                onChanged: (v) {
                  st(() {
                    context.read<StockReqController>().filterCustList(v);
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search Customer..!!',
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
                        .read<StockReqController>()
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
                                setState(() {
                                  Get.back();
                                  context
                                      .read<StockReqController>()
                                      .custSelected(
                                          context
                                              .read<StockReqController>()
                                              .getfiltercustList[index],
                                          context,
                                          theme);
                                });
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
                                          .watch<StockReqController>()
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
                                              .watch<StockReqController>()
                                              .getfiltercustList[index]
                                              .name!,
                                          maxLines: 2,
                                        ),
                                      ),
                                      Text(context
                                          .watch<StockReqController>()
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

  List<Widget> listContainersProduct(
      BuildContext context, ThemeData theme, PosController posC) {
    return List.generate(
      posC.custList.length >= 10 ? 10 : posC.custList.length,
      (ind) {
        return TopCustomer(ind: ind, posC: posC, theme: theme);
      },
    );
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
