import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:provider/provider.dart';
import '../../../Controller/PaymentReceiptController/PayReceiptController.dart';
import '../../../Widgets/AlertBox.dart';

class PayCustomerDetails extends StatefulWidget {
  PayCustomerDetails(
      {super.key,
      required this.theme,
      required this.custHeight,
      required this.custWidth});

  final ThemeData theme;
  double custHeight;
  double custWidth;

  @override
  State<PayCustomerDetails> createState() => _PayCustomerDetailsState();
}

class _PayCustomerDetailsState extends State<PayCustomerDetails> {
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
          bottom: widget.custHeight * 0.01,
          left: widget.custWidth * 0.01,
          right: widget.custWidth * 0.01),
      width: widget.custWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          context.read<PayreceiptController>().selectedcust2 != null
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: widget.custWidth * 0.5,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 240, 235, 235)),
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.001),
                      ),
                      child: TextFormField(
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[81],
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (v) {},
                        onEditingComplete: () {
                          setState(() {
                            context
                                .read<PayreceiptController>()
                                .custcodeScan(context, theme);
                          });
                        },
                        onTap: () {
                          setState(
                            () {
                              context
                                  .read<PayreceiptController>()
                                  .refreshfiltercust();
                            },
                          );
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                context
                                    .read<PayreceiptController>()
                                    .refreshfiltercust();
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          content: AlertBox(
                                            payMent: 'Select Customer',
                                            widget: forSearchBtn(context),
                                            buttonName: "",
                                          ));
                                    });
                              },
                              color: Colors.grey,
                              icon: const Icon(Icons.search)),
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
                    context.read<PayreceiptController>().selectedcust2 != null
                        ? Container()
                        : Container(
                            height: Screens.padingHeight(context) * 0.06,
                            width: widget.custWidth * 0.4,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 240, 235, 235)),
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.001),
                            ),
                            child: TextFormField(
                              readOnly: true,
                              controller: context
                                  .read<PayreceiptController>()
                                  .postingDatecontroller,
                              textCapitalization: TextCapitalization.sentences,
                              onChanged: (v) {},
                              onEditingComplete: () {
                                setState(() {
                                  context
                                      .read<PayreceiptController>()
                                      .custcodeScan(context, theme);
                                });
                              },
                              onTap: () {
                                setState(
                                  () {
                                    context
                                        .read<PayreceiptController>()
                                        .postingDate(context);
                                  },
                                );
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {});
                                      context
                                          .read<PayreceiptController>()
                                          .postingDate(context);
                                    },
                                    color: Colors.grey,
                                    icon: const Icon(Icons.calendar_month)),
                                hintStyle:
                                    theme.textTheme.bodyLarge?.copyWith(),
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
                    SizedBox(
                      height: widget.custHeight * 0.02,
                    ),
                  ],
                ),
          SizedBox(
            height: widget.custHeight * 0.02,
          ),
          context.watch<PayreceiptController>().getselectedcust2 != null
              ? Container(
                  color:
                      context.watch<PayreceiptController>().getselectedcust2 !=
                              null
                          ? Colors.grey[300]
                          : Colors.grey[50],
                  padding: EdgeInsets.symmetric(
                      vertical: widget.custHeight * 0.02,
                      horizontal: widget.custWidth * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
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
                                      .watch<PayreceiptController>()
                                      .getselectedcust2!
                                      .name
                                      .toString(),
                                  maxLines: 1,
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
                                            .watch<PayreceiptController>()
                                            .getselectedcust2!
                                            .phNo!
                                            .isNotEmpty
                                        ? " ${context.watch<PayreceiptController>().getselectedcust2!.phNo}  |  "
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
                                            .watch<PayreceiptController>()
                                            .getselectedcust2!
                                            .email!
                                            .isNotEmpty
                                        ? " ${context.watch<PayreceiptController>().getselectedcust2!.email}"
                                        : "",
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
                                  Text("GST",
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black54)),
                                  Container(
                                    padding: EdgeInsets.only(
                                      right: widget.custWidth * 0.02,
                                    ),
                                    child: Text(
                                        context
                                                .watch<PayreceiptController>()
                                                .getselectedcust2!
                                                .tarNo!
                                                .isNotEmpty
                                            ? "${context.watch<PayreceiptController>().getselectedcust2!.tarNo}"
                                            : "",
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
                                                  .watch<PayreceiptController>()
                                                  .getselectedcust2!
                                                  .accBalance! !=
                                              0
                                          ? context
                                              .watch<PayreceiptController>()
                                              .config
                                              .splitValues(context
                                                  .watch<PayreceiptController>()
                                                  .getselectedcust2!
                                                  .accBalance
                                                  .toString())
                                          : '0.00',
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
                                        "${context.watch<PayreceiptController>().getselectedcust2!.cardCode}",
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
                                  Text("Points",
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black54)),
                                  Text(
                                      context
                                              .watch<PayreceiptController>()
                                              .getselectedcust2!
                                              .point!
                                              .isNotEmpty
                                          ? "${context.watch<PayreceiptController>().getselectedcust2!.point}"
                                          : "",
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
                          SizedBox(
                            width: widget.custWidth * 0.465,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: widget.custWidth * 0.465,
                                  padding: EdgeInsets.only(
                                      right: widget.custWidth * 0.02),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                        PayreceiptController>()
                                                    .getselectedcust2 ==
                                                null &&
                                            context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .getselectedcust2!
                                                    .address ==
                                                null ||
                                        context
                                            .watch<PayreceiptController>()
                                            .getselectedcust2!
                                            .address!
                                            .isEmpty
                                    ? Container()
                                    : Text(
                                        "${context.watch<PayreceiptController>().getselectedcust2!.address![0].address1 == null || context.watch<PayreceiptController>().getselectedcust2!.address![0].address1!.isEmpty ? "" : context.watch<PayreceiptController>().getselectedcust2!.address![0].address1.toString()},"
                                        "${context.watch<PayreceiptController>().getselectedcust2!.address![0].address2 == null || context.watch<PayreceiptController>().getselectedcust2!.address![0].address2!.isEmpty ? "" : context.watch<PayreceiptController>().getselectedcust2!.address![0].address2.toString()},"
                                        " ${context.watch<PayreceiptController>().getselectedcust2!.address![0].address3 == null || context.watch<PayreceiptController>().getselectedcust2!.address![0].address3!.isEmpty ? "" : context.watch<PayreceiptController>().getselectedcust2!.address![0].address3.toString()}",
                                        maxLines: 1,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      ),
                                context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .getselectedcust2 ==
                                                null &&
                                            context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .getselectedcust2!
                                                    .address ==
                                                null ||
                                        context
                                            .watch<PayreceiptController>()
                                            .getselectedcust2!
                                            .address!
                                            .isEmpty
                                    ? Container()
                                    : Text(
                                        context
                                                .watch<PayreceiptController>()
                                                .getselectedcust2!
                                                .address![0]
                                                .billCity
                                                .isNotEmpty
                                            ? context
                                                .watch<PayreceiptController>()
                                                .getselectedcust2!
                                                .address![0]
                                                .billCity
                                                .toString()
                                            : "",
                                        maxLines: 1,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      ),
                                context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .getselectedcust2 ==
                                                null &&
                                            context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .getselectedcust2!
                                                    .address ==
                                                null ||
                                        context
                                            .watch<PayreceiptController>()
                                            .getselectedcust2!
                                            .address!
                                            .isEmpty
                                    ? Container()
                                    : Text(
                                        context
                                                .watch<PayreceiptController>()
                                                .getselectedcust2!
                                                .address![0]
                                                .billPincode
                                                .isNotEmpty
                                            ? context
                                                .watch<PayreceiptController>()
                                                .getselectedcust2!
                                                .address![0]
                                                .billPincode
                                                .toString()
                                            : '',
                                        maxLines: 1,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      ),
                                context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .getselectedcust2 ==
                                                null &&
                                            context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .getselectedcust2!
                                                    .address ==
                                                null ||
                                        context
                                            .watch<PayreceiptController>()
                                            .getselectedcust2!
                                            .address!
                                            .isEmpty
                                    ? Container()
                                    : Text(
                                        context
                                                .watch<PayreceiptController>()
                                                .getselectedcust2!
                                                .address![0]
                                                .billstate
                                                .isNotEmpty
                                            ? context
                                                .watch<PayreceiptController>()
                                                .getselectedcust2!
                                                .address![0]
                                                .billstate
                                                .toString()
                                            : '',
                                        maxLines: 1,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
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
                                                .watch<PayreceiptController>()
                                                .getselectedcust25 ==
                                            null ||
                                        context
                                            .watch<PayreceiptController>()
                                            .getselectedcust25!
                                            .address!
                                            .isEmpty
                                    ? Container()
                                    : Text(
                                        "${context.watch<PayreceiptController>().getselectedcust25!.address![0].address1!.isNotEmpty ? context.watch<PayreceiptController>().getselectedcust25!.address![0].address1.toString() : ""},"
                                        "${context.watch<PayreceiptController>().getselectedcust25!.address![0].address2!.isNotEmpty ? context.watch<PayreceiptController>().getselectedcust25!.address![0].address2.toString() : ""},"
                                        "${context.watch<PayreceiptController>().getselectedcust25!.address![0].address3!.isNotEmpty ? context.watch<PayreceiptController>().getselectedcust25!.address![0].address3.toString() : ""}",
                                        maxLines: 1,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      ),
                                context
                                                .watch<PayreceiptController>()
                                                .getselectedcust25 ==
                                            null ||
                                        context
                                            .watch<PayreceiptController>()
                                            .getselectedcust25!
                                            .address!
                                            .isEmpty
                                    ? Container()
                                    : Text(
                                        context
                                                .read<PayreceiptController>()
                                                .getselectedcust25!
                                                .address![0]
                                                .billCity
                                                .isNotEmpty
                                            ? context
                                                .watch<PayreceiptController>()
                                                .getselectedcust25!
                                                .address![0]
                                                .billCity
                                                .toString()
                                            : '',
                                        maxLines: 1,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      ),
                                context
                                                .read<PayreceiptController>()
                                                .getselectedcust25 ==
                                            null ||
                                        context
                                            .read<PayreceiptController>()
                                            .getselectedcust25!
                                            .address!
                                            .isEmpty
                                    ? Container()
                                    : Text(
                                        context
                                                .read<PayreceiptController>()
                                                .getselectedcust25!
                                                .address![0]
                                                .billPincode
                                                .isNotEmpty
                                            ? context
                                                .watch<PayreceiptController>()
                                                .getselectedcust25!
                                                .address![0]
                                                .billPincode
                                                .toString()
                                            : '',
                                        maxLines: 1,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      ),
                                context
                                                .read<PayreceiptController>()
                                                .getselectedcust25 ==
                                            null ||
                                        context
                                            .read<PayreceiptController>()
                                            .getselectedcust25!
                                            .address!
                                            .isEmpty
                                    ? Container()
                                    : Text(
                                        context
                                                .read<PayreceiptController>()
                                                .getselectedcust25!
                                                .address![0]
                                                .billstate
                                                .isNotEmpty
                                            ? context
                                                .watch<PayreceiptController>()
                                                .getselectedcust25!
                                                .address![0]
                                                .billstate
                                                .toString()
                                            : '',
                                        maxLines: 1,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : context.watch<PayreceiptController>().getselectedcust == null
                  ? Container(
                      height: widget.custHeight * 1.14,
                      padding: EdgeInsets.symmetric(
                          vertical: widget.custHeight * 0.02,
                          horizontal: widget.custWidth * 0.02),
                      child: SingleChildScrollView(
                        child: Wrap(
                            spacing: 10.0,
                            runSpacing: 10.0,
                            children: listContainersProduct(
                              context,
                              theme,
                            )),
                      ),
                    )
                  : Container(
                      color: Colors.grey[50],
                      padding: EdgeInsets.symmetric(
                          vertical: widget.custHeight * 0.02,
                          horizontal: widget.custWidth * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
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
                                                  .watch<PayreceiptController>()
                                                  .getselectedcust!
                                                  .name ==
                                              null
                                          ? ""
                                          : context
                                              .watch<PayreceiptController>()
                                              .getselectedcust!
                                              .name
                                              .toString(),
                                      maxLines: 1,
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(
                                              color: Colors.black,
                                              fontSize: 20),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        context
                                            .read<PayreceiptController>()
                                            .clearpayData();
                                      },
                                      child: Container(
                                        width: widget.custWidth * 0.06,
                                        alignment: Alignment.center,
                                        child: const Icon(Icons.close_sharp),
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
                                        context
                                                .watch<PayreceiptController>()
                                                .getselectedcust!
                                                .phNo!
                                                .isNotEmpty
                                            ? " ${context.watch<PayreceiptController>().getselectedcust!.phNo}  |  "
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
                                                        .read<
                                                            PayreceiptController>()
                                                        .getselectedcust!
                                                        .email ==
                                                    null ||
                                                context
                                                        .read<
                                                            PayreceiptController>()
                                                        .getselectedcust!
                                                        .email ==
                                                    'null' ||
                                                context
                                                    .read<
                                                        PayreceiptController>()
                                                    .getselectedcust!
                                                    .email!
                                                    .isEmpty
                                            ? ""
                                            : " ${context.watch<PayreceiptController>().getselectedcust!.email}",
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
                                      Text("GST",
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(
                                                  color: Colors.black54)),
                                      Container(
                                        padding: EdgeInsets.only(
                                          right: widget.custWidth * 0.02,
                                        ),
                                        child: Text(
                                            context
                                                            .read<
                                                                PayreceiptController>()
                                                            .getselectedcust!
                                                            .tarNo ==
                                                        null ||
                                                    context
                                                            .read<
                                                                PayreceiptController>()
                                                            .getselectedcust!
                                                            .tarNo ==
                                                        'null' ||
                                                    context
                                                        .read<
                                                            PayreceiptController>()
                                                        .getselectedcust!
                                                        .tarNo!
                                                        .isEmpty
                                                ? ""
                                                : "${context.watch<PayreceiptController>().getselectedcust!.tarNo}",
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
                                                              PayreceiptController>()
                                                          .getselectedcust!
                                                          .accBalance !=
                                                      null ||
                                                  context
                                                          .watch<
                                                              PayreceiptController>()
                                                          .getselectedcust!
                                                          .accBalance !=
                                                      0
                                              ? context
                                                  .watch<PayreceiptController>()
                                                  .config
                                                  .slpitCurrency2(context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust!
                                                      .accBalance!
                                                      .toStringAsFixed(2))
                                              : '0.00',
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
                                            "${context.watch<PayreceiptController>().getselectedcust!.cardCode}",
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
                                      Text("Points",
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(
                                                  color: Colors.black54)),
                                      Text(
                                          context
                                                  .watch<PayreceiptController>()
                                                  .getselectedcust!
                                                  .point!
                                                  .isNotEmpty
                                              ? "${context.watch<PayreceiptController>().getselectedcust!.point}"
                                              : "",
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () async {},
                                child: SizedBox(
                                  width: widget.custWidth * 0.465,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                      ),
                                      context
                                                      .read<
                                                          PayreceiptController>()
                                                      .getselectedcust ==
                                                  null ||
                                              context
                                                  .read<PayreceiptController>()
                                                  .getselectedcust!
                                                  .address!
                                                  .isEmpty ||
                                              context
                                                      .read<
                                                          PayreceiptController>()
                                                      .getselectedcust!
                                                      .address ==
                                                  null
                                          ? Container()
                                          : Text(
                                              " ${context.watch<PayreceiptController>().getselectedcust!.address![context.watch<PayreceiptController>().getselectedBillAdress!].address1 == null || context.watch<PayreceiptController>().getselectedcust!.address![context.watch<PayreceiptController>().getselectedBillAdress!].address1!.isEmpty ? "" : context.watch<PayreceiptController>().getselectedcust!.address![context.watch<PayreceiptController>().getselectedBillAdress!].address1.toString()},"
                                              "${context.watch<PayreceiptController>().getselectedcust!.address![context.watch<PayreceiptController>().getselectedBillAdress!].address2 == null || context.watch<PayreceiptController>().getselectedcust!.address![context.watch<PayreceiptController>().getselectedBillAdress!].address2!.isEmpty ? "" : context.watch<PayreceiptController>().getselectedcust!.address![context.watch<PayreceiptController>().getselectedBillAdress!].address2.toString()},"
                                              " ${context.watch<PayreceiptController>().getselectedcust!.address![context.watch<PayreceiptController>().getselectedBillAdress!].address3 == null || context.watch<PayreceiptController>().getselectedcust!.address![context.watch<PayreceiptController>().getselectedBillAdress!].address3!.isEmpty ? "" : context.watch<PayreceiptController>().getselectedcust!.address![context.watch<PayreceiptController>().getselectedBillAdress!].address3.toString()}",
                                              maxLines: 1,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            ),
                                      context
                                                          .watch<
                                                              PayreceiptController>()
                                                          .getselectedcust !=
                                                      null &&
                                                  context
                                                          .watch<
                                                              PayreceiptController>()
                                                          .getselectedcust!
                                                          .address ==
                                                      null ||
                                              context
                                                  .watch<PayreceiptController>()
                                                  .getselectedcust!
                                                  .address!
                                                  .isEmpty
                                          ? Container()
                                          : Text(
                                              context
                                                          .watch<
                                                              PayreceiptController>()
                                                          .getselectedcust!
                                                          .address![context
                                                              .watch<
                                                                  PayreceiptController>()
                                                              .getselectedBillAdress!]
                                                          .billCity
                                                          .isNotEmpty ||
                                                      context
                                                              .watch<
                                                                  PayreceiptController>()
                                                              .getselectedcust!
                                                              .address![context
                                                                  .watch<
                                                                      PayreceiptController>()
                                                                  .getselectedBillAdress!]
                                                              .billCity !=
                                                          null
                                                  ? context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust!
                                                      .address![context
                                                          .watch<
                                                              PayreceiptController>()
                                                          .getselectedBillAdress!]
                                                      .billCity
                                                      .toString()
                                                  : "",
                                              maxLines: 1,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            ),
                                      context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust ==
                                                  null ||
                                              context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust!
                                                      .address ==
                                                  null ||
                                              context
                                                  .watch<PayreceiptController>()
                                                  .getselectedcust!
                                                  .address!
                                                  .isEmpty
                                          ? Container()
                                          : Text(
                                              context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust!
                                                      .address![context
                                                          .watch<
                                                              PayreceiptController>()
                                                          .getselectedBillAdress!]
                                                      .billPincode
                                                      .isNotEmpty
                                                  ? context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust!
                                                      .address![context
                                                          .watch<
                                                              PayreceiptController>()
                                                          .getselectedBillAdress!]
                                                      .billPincode
                                                      .toString()
                                                  : '',
                                              maxLines: 1,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            ),
                                      context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust!
                                                      .address ==
                                                  null ||
                                              context
                                                  .watch<PayreceiptController>()
                                                  .getselectedcust!
                                                  .address!
                                                  .isEmpty
                                          ? Container()
                                          : Text(
                                              context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust!
                                                      .address![context
                                                          .watch<
                                                              PayreceiptController>()
                                                          .getselectedBillAdress!]
                                                      .billstate
                                                      .isNotEmpty
                                                  ? context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust!
                                                      .address![context
                                                          .watch<
                                                              PayreceiptController>()
                                                          .getselectedBillAdress!]
                                                      .billstate
                                                      .toString()
                                                  : '',
                                              maxLines: 1,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: SizedBox(
                                  width: widget.custWidth * 0.465,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: widget.custWidth * 0.465,
                                        padding: EdgeInsets.only(
                                            right: widget.custWidth * 0.02),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Shipping Address",
                                              maxLines: 2,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                      ),
                                      context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust55 ==
                                                  null ||
                                              context
                                                  .watch<PayreceiptController>()
                                                  .getselectedcust55!
                                                  .address!
                                                  .isEmpty ||
                                              context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust55!
                                                      .address ==
                                                  null
                                          ? Container()
                                          : Text(
                                              " ${context.watch<PayreceiptController>().getselectedcust55!.address == null || context.watch<PayreceiptController>().getselectedcust55!.address![context.watch<PayreceiptController>().getselectedShipAdress!].address1!.isEmpty ? "" : context.watch<PayreceiptController>().getselectedcust55!.address![context.watch<PayreceiptController>().getselectedShipAdress!].address1.toString()},"
                                              "${context.watch<PayreceiptController>().getselectedcust55!.address == null || context.watch<PayreceiptController>().getselectedcust55!.address![context.watch<PayreceiptController>().getselectedShipAdress!].address2!.isEmpty ? "" : context.watch<PayreceiptController>().getselectedcust55!.address![context.watch<PayreceiptController>().getselectedShipAdress!].address2.toString()},"
                                              " ${context.watch<PayreceiptController>().getselectedcust55!.address == null || context.watch<PayreceiptController>().getselectedcust55!.address![context.watch<PayreceiptController>().getselectedShipAdress!].address3!.isEmpty ? "" : context.watch<PayreceiptController>().getselectedcust55!.address![context.watch<PayreceiptController>().getselectedShipAdress!].address3.toString()}",
                                              maxLines: 1,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            ),
                                      context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust55 ==
                                                  null ||
                                              context
                                                  .watch<PayreceiptController>()
                                                  .getselectedcust55!
                                                  .address!
                                                  .isEmpty ||
                                              context
                                                  .watch<PayreceiptController>()
                                                  .getselectedcust55!
                                                  .address!
                                                  .isEmpty
                                          ? Container()
                                          : Text(
                                              context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust55!
                                                      .address![context
                                                          .watch<
                                                              PayreceiptController>()
                                                          .getselectedShipAdress!]
                                                      .billCity
                                                      .isNotEmpty
                                                  ? context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust55!
                                                      .address![context
                                                          .watch<
                                                              PayreceiptController>()
                                                          .getselectedShipAdress!]
                                                      .billCity
                                                      .toString()
                                                  : '',
                                              maxLines: 1,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            ),
                                      context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust55 ==
                                                  null ||
                                              context
                                                  .watch<PayreceiptController>()
                                                  .getselectedcust55!
                                                  .address!
                                                  .isEmpty
                                          ? Container()
                                          : Text(
                                              context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust55!
                                                      .address![context
                                                          .watch<
                                                              PayreceiptController>()
                                                          .getselectedShipAdress!]
                                                      .billPincode
                                                      .isNotEmpty
                                                  ? context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust55!
                                                      .address![context
                                                          .watch<
                                                              PayreceiptController>()
                                                          .getselectedShipAdress!]
                                                      .billPincode
                                                      .toString()
                                                  : '',
                                              maxLines: 1,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            ),
                                      context
                                                      .read<
                                                          PayreceiptController>()
                                                      .getselectedcust55 !=
                                                  null &&
                                              context
                                                  .read<PayreceiptController>()
                                                  .getselectedcust55!
                                                  .address!
                                                  .isNotEmpty
                                          ? Text(
                                              context
                                                      .read<
                                                          PayreceiptController>()
                                                      .getselectedcust55!
                                                      .address![context
                                                          .read<
                                                              PayreceiptController>()
                                                          .getselectedShipAdress!]
                                                      .billstate
                                                      .isNotEmpty
                                                  ? context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust55!
                                                      .address![context
                                                          .watch<
                                                              PayreceiptController>()
                                                          .getselectedShipAdress!]
                                                      .billstate
                                                      .toString()
                                                  : '',
                                              maxLines: 1,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            )
                                          : Container(),
                                    ],
                                  ),
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
                    context.read<PayreceiptController>().mycontroller[2],
                cursorColor: Colors.grey,
                autofocus: true,
                onChanged: (v) {
                  st(() {
                    context.read<PayreceiptController>().filtercustomerList(v);
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
                        .read<PayreceiptController>()
                        .getfiltercustList1
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
                              onTap: () {
                                Navigator.pop(context);
                                context
                                    .read<PayreceiptController>()
                                    .custSelected(
                                        context
                                            .read<PayreceiptController>()
                                            .getfiltercustList1[index],
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
                                          .watch<PayreceiptController>()
                                          .getfiltercustList1[index]
                                          .cardCode!),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: widget.custWidth * 0.7,
                                        child: Text(
                                          context
                                              .watch<PayreceiptController>()
                                              .getfiltercustList1[index]
                                              .name!,
                                          maxLines: 2,
                                        ),
                                      ),
                                      Text(context
                                          .watch<PayreceiptController>()
                                          .getfiltercustList1[index]
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

  forAddNewBtn(BuildContext context) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: widget.custHeight * 0.1,
                left: widget.custHeight * 0.1,
                right: widget.custHeight * 0.1,
                bottom: widget.custHeight * 0.02),
            width: widget.custWidth * 1.1,
            height: widget.custHeight * 2.5,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    key: context.read<PayreceiptController>().formkey[6],
                    child: Column(
                      children: [
                        SizedBox(
                          height: widget.custHeight * 0.03,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 20.0),
                          child: DropdownButtonFormField<String>(
                              validator: (value) => value == null
                                  ? context
                                      .read<PayreceiptController>()
                                      .textError = 'Select a series'
                                  : null,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              icon: const Icon(Icons.arrow_drop_down),
                              value: context
                                  .read<PayreceiptController>()
                                  .custseriesNo,
                              items: context
                                  .read<PayreceiptController>()
                                  .seriesData
                                  .map((e) {
                                return DropdownMenuItem(
                                    value: "${e.Series}",
                                    child: Text(e.SeriesName.toString()));
                              }).toList(),
                              hint: const Text(
                                "Select series",
                              ),
                              onChanged: (value) {
                                st(
                                  () {
                                    context
                                        .read<PayreceiptController>()
                                        .custseriesNo = value!;

                                    context
                                        .read<PayreceiptController>()
                                        .custCodeReadOnly();
                                  },
                                );
                              }),
                        ),
                        SizedBox(
                          height: widget.custHeight * 0.03,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            readOnly: context
                                .watch<PayreceiptController>()
                                .seriesValuebool,
                            textCapitalization: TextCapitalization.sentences,
                            controller: context
                                .read<PayreceiptController>()
                                .mycontroller[3],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.black),
                            onChanged: (v) {},
                            decoration: InputDecoration(
                              labelText: 'Customer Code',
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
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: widget.custHeight * 0.03,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: context
                                .read<PayreceiptController>()
                                .mycontroller[4],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.black),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                context.read<PayreceiptController>().textError =
                                    "Please Enter the Mobile Number";

                                return "Please Enter the Mobile Number";
                              } else if (value.length < 10) {
                                context.read<PayreceiptController>().textError =
                                    "Please Enter the 10 Digit Mobile Number";

                                return "Please Enter the 10 Digit Mobile Number";
                              } else {
                                return null;
                              }
                            },
                            maxLength: 10,
                            decoration: InputDecoration(
                              counterText: '',
                              labelText: 'Mobile Number',
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
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: widget.custHeight * 0.03,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            controller: context
                                .read<PayreceiptController>()
                                .mycontroller[5],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.black),
                            onChanged: (v) {},
                            decoration: InputDecoration(
                              labelText: "Gst",
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
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: widget.custHeight * 0.09,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            controller: context
                                .read<PayreceiptController>()
                                .mycontroller[6],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.black),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                context.read<PayreceiptController>().textError =
                                    "Please Enter the Name";

                                return "Please Enter the Name";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Name",
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
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: widget.custHeight * 0.03,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 10.0),
                          child: DropdownButtonFormField<String>(
                              validator: (value) => value == null
                                  ? context
                                      .read<PayreceiptController>()
                                      .textError = 'Selecta  Group'
                                  : null,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              icon: const Icon(Icons.arrow_drop_down),
                              value: context
                                  .read<PayreceiptController>()
                                  .codeValue,
                              items: context
                                  .watch<PayreceiptController>()
                                  .groupcData
                                  .map((e) {
                                return DropdownMenuItem(
                                    value: "${e.GroupCode}",
                                    child: Text(e.GroupName.toString()));
                              }).toList(),
                              hint: Text("Select Group",
                                  style: theme.textTheme.bodyLarge
                                      ?.copyWith(color: Colors.black54)),
                              onChanged: (String? value) {
                                st(() {
                                  context
                                      .read<PayreceiptController>()
                                      .codeValue = value!;
                                });
                              }),
                        ),
                        SizedBox(
                          height: widget.custHeight * 0.02,
                        ),
                        AddressWidget(
                          theme: theme,
                          custHeight: widget.custHeight,
                          custWidth: widget.custWidth,
                        ),
                        SizedBox(
                          height: widget.custHeight * 0.03,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            controller: context
                                .read<PayreceiptController>()
                                .mycontroller[46],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.black),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                context.read<PayreceiptController>().textError =
                                    "Please Enter the Tin";

                                return "Please Enter the Tin";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Tin",
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
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: widget.custHeight * 0.03,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            controller: context
                                .read<PayreceiptController>()
                                .mycontroller[47],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.black),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                context.read<PayreceiptController>().textError =
                                    "Please Enter the Vat";

                                return "Please Enter the Vat";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Vat",
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
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: widget.custHeight * 0.02,
                        ),
                        SizedBox(
                          width: widget.custWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: widget.custWidth * 0.35,
                                    child: const Text("Select Tin File"),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          st(() {
                                            context
                                                .read<PayreceiptController>()
                                                .selectattachment();
                                            context
                                                .read<PayreceiptController>()
                                                .fileValidation = false;
                                          });
                                        },
                                        child: Container(
                                            padding: EdgeInsets.only(
                                              top: widget.custHeight * 0.01,
                                              left: widget.custWidth * 0.02,
                                              right: widget.custWidth * 0.01,
                                              bottom: widget.custHeight * 0.01,
                                            ),
                                            color: Colors.white,
                                            width: widget.custWidth * 0.2,
                                            child: const Icon(Icons.photo)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              context
                                      .watch<PayreceiptController>()
                                      .tinfileError
                                      .isEmpty
                                  ? Container()
                                  : Text(
                                      context
                                          .watch<PayreceiptController>()
                                          .tinfileError,
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.red)),
                            ],
                          ),
                        ),
                        context.watch<PayreceiptController>().tinFiles == null
                            ? const SizedBox()
                            : ListView.builder(
                                itemCount: 1,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int i) {
                                  if (context
                                      .read<PayreceiptController>()
                                      .tinFiles!
                                      .path
                                      .split('/')
                                      .last
                                      .contains("png")) {
                                    return Column(children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                decoration:
                                                    const BoxDecoration(),
                                                width: widget.custWidth * 0.1,
                                                height:
                                                    widget.custHeight * 0.13,
                                                child: Center(
                                                    child: Image.asset(
                                                        "assets/img.jpg"))),
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration:
                                                    const BoxDecoration(),
                                                width: widget.custWidth * 0.6,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  context
                                                      .read<
                                                          PayreceiptController>()
                                                      .tinFiles!
                                                      .path
                                                      .split('/')
                                                      .last,
                                                )),
                                            Container(
                                                alignment: Alignment.center,
                                                child: IconButton(
                                                    onPressed: () {
                                                      st(() {
                                                        context
                                                            .read<
                                                                PayreceiptController>()
                                                            .tinFiles = null;
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.cancel_rounded,
                                                      color: Colors.grey,
                                                    )))
                                          ])
                                    ]);
                                  } else if (context
                                      .read<PayreceiptController>()
                                      .tinFiles!
                                      .path
                                      .split('/')
                                      .last
                                      .contains("jp")) {
                                    return Column(children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                decoration:
                                                    const BoxDecoration(),
                                                width: widget.custWidth * 0.1,
                                                height:
                                                    widget.custHeight * 0.13,
                                                child: Center(
                                                    child: Image.asset(
                                                        "assets/img.jpg"))),
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration:
                                                    const BoxDecoration(),
                                                width: widget.custWidth * 0.6,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  context
                                                      .read<
                                                          PayreceiptController>()
                                                      .tinFiles!
                                                      .path
                                                      .split('/')
                                                      .last,
                                                )),
                                            Container(
                                                alignment: Alignment.center,
                                                child: IconButton(
                                                    onPressed: () {
                                                      st(() {
                                                        context
                                                            .read<
                                                                PayreceiptController>()
                                                            .tinFiles = null;
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.cancel_rounded,
                                                      color: Colors.grey,
                                                    )))
                                          ])
                                    ]);
                                  } else if (context
                                      .read<PayreceiptController>()
                                      .tinFiles!
                                      .path
                                      .split('/')
                                      .last
                                      .contains("pdf")) {
                                    return Column(children: [
                                      SizedBox(
                                        height: widget.custHeight * 0.01,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(),
                                              width: widget.custWidth * 0.1,
                                              height: widget.custHeight * 0.13,
                                              child: Center(
                                                  child: Image.asset(
                                                      "assets/PDFimg.png")),
                                            ),
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration:
                                                    const BoxDecoration(),
                                                width: widget.custWidth * 0.6,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  context
                                                      .read<
                                                          PayreceiptController>()
                                                      .tinFiles!
                                                      .path
                                                      .split('/')
                                                      .last,
                                                )),
                                            Container(
                                                alignment: Alignment.center,
                                                child: IconButton(
                                                    onPressed: () {
                                                      st(() {
                                                        context
                                                            .read<
                                                                PayreceiptController>()
                                                            .tinFiles = null;
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.cancel_rounded,
                                                      color: Colors.grey,
                                                    )))
                                          ])
                                    ]);
                                  } else if (context
                                      .read<PayreceiptController>()
                                      .tinFiles!
                                      .path
                                      .split('/')
                                      .last
                                      .contains("xlsx")) {
                                    return Column(children: [
                                      SizedBox(
                                        height: widget.custHeight * 0.01,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                decoration:
                                                    const BoxDecoration(),
                                                width: widget.custWidth * 0.1,
                                                height:
                                                    widget.custHeight * 0.13,
                                                child: Center(
                                                    child: Image.asset(
                                                        "assets/xls.png"))),
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration:
                                                    const BoxDecoration(),
                                                width: widget.custWidth * 0.6,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  context
                                                      .read<
                                                          PayreceiptController>()
                                                      .tinFiles!
                                                      .path
                                                      .split('/')
                                                      .last,
                                                )),
                                            Container(
                                                alignment: Alignment.center,
                                                child: IconButton(
                                                    onPressed: () {
                                                      st(() {
                                                        context
                                                            .read<
                                                                PayreceiptController>()
                                                            .tinFiles = null;
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.cancel_rounded,
                                                      color: Colors.grey,
                                                    )))
                                          ])
                                    ]);
                                  }
                                  return Column(children: [
                                    SizedBox(
                                      height: widget.custHeight * 0.01,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              decoration: const BoxDecoration(),
                                              width: widget.custWidth * 0.09,
                                              height: widget.custHeight * 0.06,
                                              child: Center(
                                                  child: Image.asset(
                                                      "assets/txt.png"))),
                                          Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: const BoxDecoration(),
                                              width: widget.custWidth * 0.6,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                context
                                                    .read<
                                                        PayreceiptController>()
                                                    .tinFiles!
                                                    .path
                                                    .split('/')
                                                    .last,
                                              )),
                                          Container(
                                              alignment: Alignment.center,
                                              child: IconButton(
                                                  onPressed: () {
                                                    st(() {
                                                      context
                                                          .read<
                                                              PayreceiptController>()
                                                          .tinFiles = null;
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.cancel_rounded,
                                                    color: Colors.grey,
                                                  )))
                                        ])
                                  ]);
                                }),
                        SizedBox(
                          height: widget.custHeight * 0.02,
                        ),
                        SizedBox(
                          width: widget.custWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: widget.custWidth * 0.3,
                                    child: const Text("Select Vat File"),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          st(() {
                                            context
                                                .read<PayreceiptController>()
                                                .selectVatattachment();
                                            context
                                                .read<PayreceiptController>()
                                                .fileValidation = false;
                                          });
                                        },
                                        child: Container(
                                            padding: EdgeInsets.only(
                                              top: widget.custHeight * 0.01,
                                              left: widget.custWidth * 0.02,
                                              right: widget.custWidth * 0.01,
                                              bottom: widget.custHeight * 0.01,
                                            ),
                                            color: Colors.white,
                                            width: widget.custWidth * 0.2,
                                            child: const Icon(Icons.photo)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              context
                                      .watch<PayreceiptController>()
                                      .vatfileError
                                      .isEmpty
                                  ? Container()
                                  : Text(
                                      context
                                          .watch<PayreceiptController>()
                                          .vatfileError,
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.red)),
                            ],
                          ),
                        ),
                        context.watch<PayreceiptController>().vatFiles == null
                            ? const SizedBox()
                            : ListView.builder(
                                itemCount: 1,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int i) {
                                  if (context
                                      .read<PayreceiptController>()
                                      .vatFiles!
                                      .path
                                      .split('/')
                                      .last
                                      .contains("png")) {
                                    return Column(children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                decoration:
                                                    const BoxDecoration(),
                                                width: widget.custWidth * 0.1,
                                                height:
                                                    widget.custHeight * 0.13,
                                                child: Center(
                                                    child: Image.asset(
                                                        "assets/img.jpg"))),
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration:
                                                    const BoxDecoration(),
                                                width: widget.custWidth * 0.6,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  context
                                                      .read<
                                                          PayreceiptController>()
                                                      .vatFiles!
                                                      .path
                                                      .split('/')
                                                      .last,
                                                )),
                                            Container(
                                                alignment: Alignment.center,
                                                child: IconButton(
                                                    onPressed: () {
                                                      st(() {
                                                        context
                                                            .read<
                                                                PayreceiptController>()
                                                            .vatFiles = null;
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.cancel_rounded,
                                                      color: Colors.grey,
                                                    )))
                                          ])
                                    ]);
                                  } else if (context
                                      .read<PayreceiptController>()
                                      .vatFiles!
                                      .path
                                      .split('/')
                                      .last
                                      .contains("jp")) {
                                    return Column(children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                decoration:
                                                    const BoxDecoration(),
                                                width: widget.custWidth * 0.1,
                                                height:
                                                    widget.custHeight * 0.13,
                                                child: Center(
                                                    child: Image.asset(
                                                        "assets/img.jpg"))),
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration:
                                                    const BoxDecoration(),
                                                width: widget.custWidth * 0.6,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  context
                                                      .read<
                                                          PayreceiptController>()
                                                      .vatFiles!
                                                      .path
                                                      .split('/')
                                                      .last,
                                                )),
                                            Container(
                                                alignment: Alignment.center,
                                                child: IconButton(
                                                    onPressed: () {
                                                      st(() {
                                                        context
                                                            .read<
                                                                PayreceiptController>()
                                                            .vatFiles = null;
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.cancel_rounded,
                                                      color: Colors.grey,
                                                    )))
                                          ])
                                    ]);
                                  } else if (context
                                      .read<PayreceiptController>()
                                      .vatFiles!
                                      .path
                                      .split('/')
                                      .last
                                      .contains("pdf")) {
                                    return Column(children: [
                                      SizedBox(
                                        height: widget.custHeight * 0.01,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(),
                                              width: widget.custWidth * 0.1,
                                              height: widget.custHeight * 0.13,
                                              child: Center(
                                                  child: Image.asset(
                                                      "assets/PDFimg.png")),
                                            ),
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration:
                                                    const BoxDecoration(),
                                                width: widget.custWidth * 0.6,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  context
                                                      .read<
                                                          PayreceiptController>()
                                                      .vatFiles!
                                                      .path
                                                      .split('/')
                                                      .last,
                                                )),
                                            Container(
                                                alignment: Alignment.center,
                                                child: IconButton(
                                                    onPressed: () {
                                                      st(() {
                                                        context
                                                            .read<
                                                                PayreceiptController>()
                                                            .vatFiles = null;
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.cancel_rounded,
                                                      color: Colors.grey,
                                                    )))
                                          ])
                                    ]);
                                  } else if (context
                                      .read<PayreceiptController>()
                                      .vatFiles!
                                      .path
                                      .split('/')
                                      .last
                                      .contains("xlsx")) {
                                    return Column(children: [
                                      SizedBox(
                                        height: widget.custHeight * 0.01,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                decoration:
                                                    const BoxDecoration(),
                                                width: widget.custWidth * 0.1,
                                                height:
                                                    widget.custHeight * 0.13,
                                                child: Center(
                                                    child: Image.asset(
                                                        "assets/xls.png"))),
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration:
                                                    const BoxDecoration(),
                                                width: widget.custWidth * 0.6,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  context
                                                      .read<
                                                          PayreceiptController>()
                                                      .vatFiles!
                                                      .path
                                                      .split('/')
                                                      .last,
                                                )),
                                            Container(
                                                alignment: Alignment.center,
                                                child: IconButton(
                                                    onPressed: () {
                                                      st(() {
                                                        context
                                                            .read<
                                                                PayreceiptController>()
                                                            .vatFiles = null;
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.cancel_rounded,
                                                      color: Colors.grey,
                                                    )))
                                          ])
                                    ]);
                                  }
                                  return Column(children: [
                                    SizedBox(
                                      height: widget.custHeight * 0.01,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              decoration: const BoxDecoration(),
                                              width: widget.custWidth * 0.09,
                                              height: widget.custHeight * 0.06,
                                              child: Center(
                                                  child: Image.asset(
                                                      "assets/txt.png"))),
                                          Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: const BoxDecoration(),
                                              width: widget.custWidth * 0.6,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                context
                                                    .read<
                                                        PayreceiptController>()
                                                    .vatFiles!
                                                    .path
                                                    .split('/')
                                                    .last,
                                              )),
                                          Container(
                                              alignment: Alignment.center,
                                              child: IconButton(
                                                  onPressed: () {
                                                    st(() {
                                                      context
                                                          .read<
                                                              PayreceiptController>()
                                                          .vatFiles = null;
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.cancel_rounded,
                                                    color: Colors.grey,
                                                  )))
                                        ])
                                  ]);
                                }),
                        SizedBox(
                          height: widget.custHeight * 0.02,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 10.0),
                          child: DropdownButtonFormField<String>(
                              validator: (value) => value == null
                                  ? context
                                      .read<PayreceiptController>()
                                      .textError = 'Select a Territory'
                                  : null,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              icon: const Icon(Icons.arrow_drop_down),
                              value: context
                                  .read<PayreceiptController>()
                                  .teriteriValue,
                              items: context
                                  .watch<PayreceiptController>()
                                  .teriteritData
                                  .map((e) {
                                return DropdownMenuItem(
                                    value: "${e.teriID}",
                                    child: Text(e.descript.toString()));
                              }).toList(),
                              hint: Text("Select Territory",
                                  style: theme.textTheme.bodyLarge
                                      ?.copyWith(color: Colors.black54)),
                              onChanged: (String? value) {
                                st(() {
                                  context
                                      .read<PayreceiptController>()
                                      .teriteriValue = value!;
                                });
                              }),
                        ),
                        SizedBox(
                          height: widget.custHeight * 0.02,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            readOnly: true,
                            controller: context
                                .read<PayreceiptController>()
                                .mycontroller[48],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.black),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                context.read<PayreceiptController>().textError =
                                    "Please Enter the Sales Person Code";
                                return "Please Enter the Sales Person Code";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Sales Person Code",
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
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: widget.custHeight * 0.02,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            controller: context
                                .read<PayreceiptController>()
                                .mycontroller[51],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.black),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                context.read<PayreceiptController>().textError =
                                    "Please Enter the Contact Person";
                                return "Please Enter the Contact Person";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Contact Person",
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
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: widget.custHeight * 0.02,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller: context
                                .read<PayreceiptController>()
                                .mycontroller[21],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.black),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value)) {
                                  context
                                          .read<PayreceiptController>()
                                          .textError =
                                      "Please Enter the Valid Email";

                                  return "Please Enter the Valid Email";
                                }
                              } else {
                                return null;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Email",
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
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: widget.custHeight * 0.02,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 10.0),
                          child: DropdownButtonFormField<String>(
                              validator: (value) => value == null
                                  ? context
                                      .read<PayreceiptController>()
                                      .textError = 'Payment a Terms'
                                  : null,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              icon: const Icon(Icons.arrow_drop_down),
                              isExpanded: true,
                              value: context
                                  .watch<PayreceiptController>()
                                  .paygrpValue,
                              items: context
                                  .watch<PayreceiptController>()
                                  .paygroupData!
                                  .map((e) {
                                return DropdownMenuItem(
                                    value: "${e.GroupNum}",
                                    child: Text(e.PymntGroup.toString()));
                              }).toList(),
                              hint: Text("Payment Terms",
                                  style: theme.textTheme.bodyLarge
                                      ?.copyWith(color: Colors.black54)),
                              onChanged: (String? value) {
                                setState(() {
                                  context
                                      .read<PayreceiptController>()
                                      .paygrpValue = value!;
                                });
                              }),
                        ),
                        SizedBox(
                          height: widget.custHeight * 0.02,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: context
                                .read<PayreceiptController>()
                                .mycontroller[49],
                            validator: (value) {
                              if (value!.isEmpty) {
                                context.read<PayreceiptController>().textError =
                                    "Please Enter the Credit Limit";

                                return "Please Enter the Credit Limit";
                              } else {
                                return null;
                              }
                            },
                            onTap: () {
                              context
                                      .read<PayreceiptController>()
                                      .mycontroller[49]
                                      .text =
                                  context
                                      .read<PayreceiptController>()
                                      .mycontroller[49]
                                      .text
                                      .replaceAll(',', '');
                            },
                            onEditingComplete: () {
                              context
                                      .read<PayreceiptController>()
                                      .mycontroller[49]
                                      .text =
                                  context
                                      .read<PayreceiptController>()
                                      .config
                                      .splitValues(context
                                          .read<PayreceiptController>()
                                          .mycontroller[49]
                                          .text);
                              context
                                  .read<PayreceiptController>()
                                  .disableKeyBoard(context);
                            },
                            decoration: const InputDecoration(
                                hintText: 'Credit Limit',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0.2, horizontal: 10),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        SizedBox(
                          height: widget.custHeight * 0.02,
                        ),
                        TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          onTap: () {
                            context
                                    .read<PayreceiptController>()
                                    .mycontroller[49]
                                    .text =
                                context
                                    .read<PayreceiptController>()
                                    .config
                                    .splitValues(context
                                        .read<PayreceiptController>()
                                        .mycontroller[49]
                                        .text);
                          },
                          controller: context
                              .read<PayreceiptController>()
                              .mycontroller[50],
                          maxLines: 4,
                          decoration: const InputDecoration(
                              hintText: 'Remarks',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0.2, horizontal: 10),
                              border: OutlineInputBorder()),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: widget.custHeight * 0.02,
          ),
          SizedBox(
            height: widget.custHeight * 0.2,
            width: widget.custWidth * 1.1,
            child: ElevatedButton(
                onPressed:
                    context.read<PayreceiptController>().loadingBtn == false
                        ? () {
                            setState(() {
                              context
                                  .read<PayreceiptController>()
                                  .createnewchagescustaddres(context, theme, 6);
                            });
                          }
                        : null,
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                    backgroundColor: theme.primaryColor),
                child: context.read<PayreceiptController>().loadingBtn == false
                    ? const Text(
                        "Save",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    : SizedBox(
                        width: widget.custWidth * 0.05,
                        height: widget.custHeight * 0.15,
                        child: const CircularProgressIndicator(),
                      )),
          )
        ],
      );
    });
  }

  forEditBtn(BuildContext context) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.only(
            top: widget.custHeight * 0.1,
            left: widget.custHeight * 0.1,
            right: widget.custHeight * 0.1,
            bottom: widget.custHeight * 0.02),
        width: widget.custWidth * 1.1,
        height: widget.custHeight * 2.5,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: context.read<PayreceiptController>().formkey[6],
                child: Column(
                  children: [
                    SizedBox(
                      height: widget.custHeight * 0.03,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[4],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the Mobile Number";
                            return "Please Enter the Mobile Number";
                          } else if (value.length < 10) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the 10 Digit Mobile Number";

                            return "Please Enter the 10 Digit Mobile Number";
                          } else {
                            return null;
                          }
                        },
                        maxLength: 10,
                        decoration: InputDecoration(
                          counterText: '',
                          labelText: 'Mobile Number',
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
                      height: widget.custHeight * 0.03,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[5],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        decoration: InputDecoration(
                          labelText: "Gst",
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
                      height: widget.custHeight * 0.09,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[6],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the Name";

                            return "Please Enter the Name";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Name",
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
                      height: widget.custHeight * 0.02,
                    ),
                    AddressWidget(
                      theme: theme,
                      custHeight: widget.custHeight,
                      custWidth: widget.custWidth,
                    ),
                    SizedBox(
                      height: widget.custHeight * 0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[21],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              context.read<PayreceiptController>().textError =
                                  "Please Enter the Valid Email";
                              return "Please Enter the Valid Email";
                            }
                          } else {
                            return null;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Email",
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
              ),
            ],
          ),
        ),
      );
    });
  }

  List<Widget> listContainersProduct(
    BuildContext context,
    ThemeData theme,
  ) {
    return List.generate(
      context.read<PayreceiptController>().custList2.length,
      (ind) {
        return TopCustomer(ind: ind, theme: theme);
      },
    );
  }
}

class TopCustomer extends StatelessWidget {
  TopCustomer({
    super.key,
    required this.ind,
    required this.theme,
  });
  ThemeData theme;
  int ind;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<PayreceiptController>().custSelected(
            context.read<PayreceiptController>().custList2[ind],
            context,
            theme);
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: theme.primaryColor,
            border: Border.all(color: theme.primaryColor, width: 1),
            borderRadius: BorderRadius.circular(5)),
        child: Text(context.watch<PayreceiptController>().custList2[ind].name!,
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

Widget updateType(BuildContext context, int i, int ij) {
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
                          context
                              .read<PayreceiptController>()
                              .updateCustomer(context, i, ij);
                          Navigator.pop(context);
                        },
                        child: const Text("Update to server")),
                  ),
                  SizedBox(
                      width: Screens.width(context) * 0.3,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            context
                                .read<PayreceiptController>()
                                .updateCustomer(context, i, ij);
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

billAddress(BuildContext context) async {
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
                        itemCount: context
                            .watch<PayreceiptController>()
                            .billadrrssItemlist
                            .length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              context
                                  .read<PayreceiptController>()
                                  .changeBillAddress(index);
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
                                            "${context.watch<PayreceiptController>().billadrrssItemlist[index].address1 ?? ''},"
                                            "${context.watch<PayreceiptController>().billadrrssItemlist[index].address2 ?? ''},"
                                            "${context.watch<PayreceiptController>().billadrrssItemlist[index].address3 ?? ''}"),
                                        Text(context
                                            .watch<PayreceiptController>()
                                            .billadrrssItemlist[index]
                                            .billCity),
                                        Text(context
                                            .watch<PayreceiptController>()
                                            .billadrrssItemlist[index]
                                            .billPincode),
                                        Text(context
                                            .watch<PayreceiptController>()
                                            .billadrrssItemlist[index]
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
                context.read<PayreceiptController>().clearTextField();
                context.read<PayreceiptController>().checkboxx = false;

                createBillAddress(context, theme);
              },
            ));
      });
}

sipaddress(BuildContext context) async {
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
                height: Screens.padingHeight(context) * 0.3,
                width: Screens.width(context) * 0.45,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: context
                      .watch<PayreceiptController>()
                      .shipadrrssItemlist
                      .length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        context
                            .read<PayreceiptController>()
                            .changeShipAddress(index);
                        Navigator.pop(context);
                      },
                      child: Card(
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: Screens.padingHeight(context) * 0.01,
                                horizontal: Screens.width(context) * 0.01,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${context.watch<PayreceiptController>().shipadrrssItemlist[index].address1 ?? ''}${context.watch<PayreceiptController>().shipadrrssItemlist[index].address2 ?? ''}${context.watch<PayreceiptController>().shipadrrssItemlist[index].address3 ?? ''}"),
                                  Text(context
                                          .watch<PayreceiptController>()
                                          .shipadrrssItemlist[index]
                                          .billCity
                                          .isNotEmpty
                                      ? context
                                          .watch<PayreceiptController>()
                                          .shipadrrssItemlist[index]
                                          .billCity
                                      : ''),
                                  Text(context
                                              .read<PayreceiptController>()
                                              .shipadrrssItemlist[index]
                                              .billPincode !=
                                          null
                                      ? context
                                          .watch<PayreceiptController>()
                                          .shipadrrssItemlist[index]
                                          .billPincode
                                      : ""),
                                  Text(context
                                      .watch<PayreceiptController>()
                                      .shipadrrssItemlist[index]
                                      .billstate)
                                ],
                              ))),
                    );
                  },
                ),
              ),
              buttonName: "Create Address",
              callback: () {
                Navigator.pop(context);
                context.read<PayreceiptController>().clearTextField();
                context.read<PayreceiptController>().checkboxx = false;
                createShippAddress(context, theme);
              },
            ));
      });
}

createBillAddress(BuildContext context, ThemeData theme) async {
  final theme = Theme.of(context);
  context.read<PayreceiptController>().checkboxx = false;
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: AlertBox(
              payMent: 'Create Address',
              widget: createBillAddressMethod(theme, context),
              buttonName: null,
            ));
      });
}

createShippAddress(BuildContext context, ThemeData theme) async {
  final theme = Theme.of(context);

  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: AlertBox(
              payMent: 'Create Address',
              widget: createShipAddressMethod(theme, context),
              buttonName: null,
            ));
      });
}

Container createAddressMethod(ThemeData theme, BuildContext context) {
  context.read<PayreceiptController>().checkboxx = false;
  return Container(
    width: Screens.width(context) * 0.5,
    height: Screens.padingHeight(context) * 0.65,
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
            custHeight: Screens.width(context) * 0.4,
            custWidth: Screens.width(context) * 0.7,
          ),
        ],
      ),
    ),
  );
}

createBillAddressMethod(ThemeData theme, BuildContext context) {
  return Column(
    children: [
      Container(
        width: Screens.width(context) * 0.5,
        height: Screens.padingHeight(context) * 0.51,
        padding: EdgeInsets.symmetric(
          horizontal: Screens.width(context) * 0.02,
          vertical: Screens.padingHeight(context) * 0.02,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BillAddressWidget(
                theme: theme,
                custHeight: Screens.width(context) * 0.4,
                custWidth: Screens.width(context) * 0.7,
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: Screens.padingHeight(context) * 0.055,
        width: Screens.width(context) * 0.499,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                side: BorderSide(
                  color: theme.primaryColor,
                )),
            onPressed:
                context.watch<PayreceiptController>().adondDisablebutton ==
                        false
                    ? () {
                        context
                            .read<PayreceiptController>()
                            .insertnewbilladdresscreation(context, theme);
                      }
                    : null,
            child: Text(
              "Save",
              style: theme.textTheme.bodyMedium!.copyWith(color: Colors.white),
            )),
      ),
    ],
  );
}

createShipAddressMethod(ThemeData theme, BuildContext context) {
  return Column(
    children: [
      Container(
        width: Screens.width(context) * 0.5,
        height: Screens.padingHeight(context) * 0.51,
        padding: EdgeInsets.symmetric(
          horizontal: Screens.width(context) * 0.02,
          vertical: Screens.padingHeight(context) * 0.02,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ShipAddressWidget(
                theme: theme,
                custHeight: Screens.width(context) * 0.4,
                custWidth: Screens.width(context) * 0.7,
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: Screens.padingHeight(context) * 0.055,
        width: Screens.width(context) * 0.499,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                side: BorderSide(
                  color: theme.primaryColor,
                )),
            onPressed:
                context.watch<PayreceiptController>().adondDisablebutton ==
                        false
                    ? () {
                        context
                            .read<PayreceiptController>()
                            .insertnewshipaddresscreation(context, theme);
                      }
                    : null,
            child: Text(
              "Save",
              style: theme.textTheme.bodyMedium!.copyWith(color: Colors.white),
            )),
      ),
    ],
  );
}

class AddressWidget extends StatelessWidget {
  const AddressWidget(
      {super.key,
      required this.theme,
      required this.custHeight,
      required this.custWidth});

  final ThemeData theme;
  final double custHeight;
  final double custWidth;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, st) {
      return Column(
        children: [
          SizedBox(
            height: custHeight * 0.02,
          ),
          Form(
            key: context.read<PayreceiptController>().formkeyAd,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    autofocus: true,
                    textCapitalization: TextCapitalization.sentences,
                    controller:
                        context.read<PayreceiptController>().mycontroller[7],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        context.read<PayreceiptController>().textError =
                            "Please Enter the Address1";

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
                    textCapitalization: TextCapitalization.sentences,
                    controller:
                        context.read<PayreceiptController>().mycontroller[8],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        context.read<PayreceiptController>().textError =
                            "Please Enter the Address2";
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
                    controller:
                        context.read<PayreceiptController>().mycontroller[9],
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        context.read<PayreceiptController>().textError =
                            "Please Enter the Address3";
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
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[10],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the City Name";

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
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[11],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the Pincode";

                            return "Please Enter the Pincode";
                          } else if (value.length < 6) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter 6 Digit Pincode";

                            return "Please Enter 6 Digit Pincode";
                          } else {
                            return null;
                          }
                        },
                        maxLength: 6,
                        decoration: InputDecoration(
                          counterText: '',
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
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[12],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the State";

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
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[13],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the Country";

                            return "Please Enter the Country";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Country",
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
                        value: context.watch<PayreceiptController>().checkboxx,
                        onChanged: (val) {
                          st(() {
                            context.read<PayreceiptController>().checkboxx =
                                val!;
                            context
                                .read<PayreceiptController>()
                                .billToShip(val);
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
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[14],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the Ship_Address1";

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
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[15],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the Ship_Address2";
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
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[16],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the Ship_Address3";
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
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[17],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the Ship_City Name";

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
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[18],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the Ship_PinCode";

                            return "Please Enter the Pincode";
                          } else if (value.length < 6) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter 6 Digit Ship_PinCode";

                            return "Please Enter 6 Digit Pincode";
                          } else {
                            return null;
                          }
                        },
                        maxLength: 6,
                        decoration: InputDecoration(
                          counterText: '',
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
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[19],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the Ship_State";

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
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[20],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the Ship_Country";

                            return "Please Enter the Country";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Country",
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
            ),
          ),
        ],
      );
    });
  }
}

class BillAddressWidget extends StatelessWidget {
  const BillAddressWidget(
      {super.key,
      required this.theme,
      required this.custHeight,
      required this.custWidth});

  final ThemeData theme;
  final double custHeight;
  final double custWidth;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, st) {
      return Column(
        children: [
          SizedBox(
            height: custHeight * 0.02,
          ),
          Form(
            key: context.read<PayreceiptController>().formkeyAd,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    autofocus: true,
                    textCapitalization: TextCapitalization.sentences,
                    controller:
                        context.read<PayreceiptController>().mycontroller[7],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        context.read<PayreceiptController>().textError =
                            "Please Enter the Address1";
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
                    textCapitalization: TextCapitalization.sentences,
                    controller:
                        context.read<PayreceiptController>().mycontroller[8],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        context.read<PayreceiptController>().textError =
                            "Please Enter the Address2";
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
                    textCapitalization: TextCapitalization.sentences,
                    controller:
                        context.read<PayreceiptController>().mycontroller[9],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        context.read<PayreceiptController>().textError =
                            "Please Enter the Address3";
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
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[10],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the City Name";
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
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[11],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the PinCode";
                            return "Please Enter the PinCode";
                          } else if (value.length < 6) {
                            context.read<PayreceiptController>().textError =
                                " Please Enter 6 Digit Pincode";
                            return "Please Enter 6 Digit Pincode";
                          } else {
                            return null;
                          }
                        },
                        maxLength: 6,
                        decoration: InputDecoration(
                          counterText: '',
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
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[12],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the State";
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
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[13],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the Country";
                            return "Please Enter the Country";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Country",
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
                      width: custWidth * 0.1,
                    ),
                    Checkbox(
                        side: const BorderSide(color: Colors.grey),
                        activeColor: Colors.green,
                        value: context.watch<PayreceiptController>().checkboxx,
                        onChanged: (val) {
                          st(() {
                            context.read<PayreceiptController>().checkboxx =
                                val!;
                            context
                                .read<PayreceiptController>()
                                .billToShip(val);
                          });
                        }),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

class ShipAddressWidget extends StatelessWidget {
  const ShipAddressWidget(
      {super.key,
      required this.theme,
      required this.custHeight,
      required this.custWidth});

  final ThemeData theme;
  final double custHeight;
  final double custWidth;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, st) {
      return Column(
        children: [
          SizedBox(
            height: custHeight * 0.02,
          ),
          Form(
            key: context.read<PayreceiptController>().formkeyShipAd,
            child: Column(
              children: [
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
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[14],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the Ship_Address1";

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
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[15],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the Ship_Address2";

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
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[16],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the Ship_Address3";

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
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[17],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the City Name";

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
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[18],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the Pincode";
                            return "Please Enter the Pincode";
                          } else if (value.length < 6) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter 6 Digit Pincode";
                            return "Please Enter 6 Digit Pincode";
                          } else {
                            return null;
                          }
                        },
                        maxLength: 6,
                        decoration: InputDecoration(
                          counterText: '',
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
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[19],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the State";
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
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[20],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the Country";
                            return "Please Enter the Country";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Country",
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
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      height: custHeight * 0.1,
                      child: const Text("Copy As Bill Address"),
                    ),
                    SizedBox(
                      width: custWidth * 0.1,
                    ),
                    Checkbox(
                        side: const BorderSide(color: Colors.grey),
                        activeColor: Colors.green,
                        value: context.watch<PayreceiptController>().checkboxx,
                        onChanged: (val) {
                          st(() {
                            context.read<PayreceiptController>().checkboxx =
                                val!;
                            context
                                .read<PayreceiptController>()
                                .shipToBill(val);
                          });
                        }),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
