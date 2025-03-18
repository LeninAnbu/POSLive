import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import 'package:provider/provider.dart';

import '../../../Controller/SalesQuotationController/SalesQuotationController.dart';

class SQCustomerDetails extends StatefulWidget {
  SQCustomerDetails(
      {super.key,
      required this.theme,
      required this.custHeight,
      required this.custWidth});

  final ThemeData theme;
  double custHeight;
  double custWidth;

  @override
  State<SQCustomerDetails> createState() => _SQCustomerDetailsState();
}

class _SQCustomerDetailsState extends State<SQCustomerDetails> {
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
        mainAxisSize: MainAxisSize.min,
        children: [
          context.read<SalesQuotationCon>().getselectedcust2 != null
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: widget.custWidth * 0.55,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 240, 235, 235)),
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.001),
                      ),
                      child: TextFormField(
                        onChanged: (v) {},
                        readOnly: true,
                        onTap: context.read<SalesQuotationCon>().editqty == true
                            ? null
                            : () {
                                context
                                    .read<SalesQuotationCon>()
                                    .clearTextField();
                                context
                                    .read<SalesQuotationCon>()
                                    .refresCufstList();
                                setState(() {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                            builder: (context, st) {
                                          return AlertDialog(
                                              contentPadding:
                                                  const EdgeInsets.all(0),
                                              content: AlertBox(
                                                payMent: 'Select Customer',
                                                widget: forSearchBtn(context),
                                                buttonName: '',
                                                // callback: () {
                                                //   Navigator.pop(context);

                                                //   showDialog(
                                                //       context: context,
                                                //       barrierDismissible: false,
                                                //       builder: (BuildContext context) {
                                                //         return AlertDialog(
                                                //             contentPadding:
                                                //                 const EdgeInsets.all(0),
                                                //             content: AlertBox(
                                                //               payMent: 'New Customer',
                                                //               widget:
                                                //                   forAddNewBtn(context),
                                                //               buttonName: null,
                                                //             ));
                                                //       });
                                                // },
                                              ));
                                        });
                                      });
                                });
                              },
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
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
                    context.read<SalesQuotationCon>().selectedcust2 != null
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
                                  .read<SalesQuotationCon>()
                                  .postingDatecontroller,
                              textCapitalization: TextCapitalization.sentences,
                              onChanged: (v) {},
                              onEditingComplete: () {},
                              onTap: () {
                                setState(
                                  () {
                                    context
                                        .read<SalesQuotationCon>()
                                        .postingDate(context);
                                  },
                                );
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {});
                                      context
                                          .read<SalesQuotationCon>()
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
          context.read<SalesQuotationCon>().getselectedcust2 != null
              ? Container(
                  color:
                      context.read<SalesQuotationCon>().getselectedcust2 != null
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: widget.custWidth * 0.55,
                                        height: widget.custHeight * 0.16,
                                        child: context
                                                        .read<
                                                            SalesQuotationCon>()
                                                        .getselectedcust2 !=
                                                    null &&
                                                context
                                                        .read<
                                                            SalesQuotationCon>()
                                                        .getselectedcust2!
                                                        .paymentGroup !=
                                                    null &&
                                                context
                                                        .read<
                                                            SalesQuotationCon>()
                                                        .getselectedcust2!
                                                        .U_CashCust ==
                                                    'YES'
                                            ? TextFormField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return '';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                onEditingComplete: () {
                                                  context
                                                          .read<SalesQuotationCon>()
                                                          .getselectedcust2!
                                                          .name =
                                                      context
                                                          .read<
                                                              SalesQuotationCon>()
                                                          .custNameController
                                                          .text;
                                                  context
                                                      .read<SalesQuotationCon>()
                                                      .disableKeyBoard(context);
                                                },
                                                controller: context
                                                    .read<SalesQuotationCon>()
                                                    .custNameController,
                                                decoration: InputDecoration(
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.red),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.red),
                                                  ),
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
                                                  hintText: 'Name',
                                                  hintStyle: widget.theme
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                          color: Colors.grey),
                                                  filled: false,
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    // vertical: 10,
                                                    horizontal: 10,
                                                  ),
                                                ),
                                              )
                                            : Text(
                                                context
                                                    .watch<SalesQuotationCon>()
                                                    .getselectedcust2!
                                                    .name
                                                    .toString(),
                                                maxLines: 1,
                                                style: theme.textTheme.bodyLarge
                                                    ?.copyWith(
                                                        color: Colors.black,
                                                        fontSize: 20),
                                              ),
                                      ),
                                      SizedBox(
                                        width: Screens.width(context) * 0.01,
                                      ),
                                      SizedBox(
                                          height: widget.custHeight * 0.16,
                                          width: widget.custWidth * 0.3,
                                          child: context
                                                          .read<
                                                              SalesQuotationCon>()
                                                          .getselectedcust2 !=
                                                      null &&
                                                  context
                                                          .read<
                                                              SalesQuotationCon>()
                                                          .getselectedcust2!
                                                          .paymentGroup !=
                                                      null &&
                                                  context
                                                          .read<
                                                              SalesQuotationCon>()
                                                          .getselectedcust2!
                                                          .U_CashCust ==
                                                      'YES'
                                              ? TextFormField(
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return '';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  onEditingComplete: () {
                                                    // context
                                                    //         .read<PosController>()
                                                    //         .selectedcust!
                                                    //         .name =
                                                    //     context
                                                    //         .read<
                                                    //             PosController>()
                                                    //         .custNameController
                                                    //         .text;
                                                    context
                                                        .read<
                                                            SalesQuotationCon>()
                                                        .disableKeyBoard(
                                                            context);
                                                  },
                                                  controller: context
                                                      .read<SalesQuotationCon>()
                                                      .tinNoController,
                                                  decoration: InputDecoration(
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.red),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.red),
                                                    ),
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
                                                    hintText: 'Tin no',
                                                    hintStyle: widget.theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            color: Colors.grey),
                                                    filled: false,
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                      // vertical: 10,
                                                      horizontal: 10,
                                                    ),
                                                  ),
                                                )
                                              : Container())
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          Screens.padingHeight(context) * 0.01),
                                  SizedBox(
                                      height: widget.custHeight * 0.16,
                                      width: widget.custWidth * 0.3,
                                      child: context
                                                      .read<SalesQuotationCon>()
                                                      .getselectedcust2 !=
                                                  null &&
                                              context
                                                      .read<SalesQuotationCon>()
                                                      .getselectedcust2!
                                                      .paymentGroup !=
                                                  null &&
                                              context
                                                      .read<SalesQuotationCon>()
                                                      .getselectedcust2!
                                                      .U_CashCust ==
                                                  'YES'
                                          ? TextFormField(
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return '';
                                                } else {
                                                  return null;
                                                }
                                              },
                                              onEditingComplete: () {
                                                // context
                                                //         .read<PosController>()
                                                //         .selectedcust!
                                                //         .name =
                                                //     context
                                                //         .read<
                                                //             PosController>()
                                                //         .custNameController
                                                //         .text;
                                                context
                                                    .read<SalesQuotationCon>()
                                                    .disableKeyBoard(context);
                                              },
                                              controller: context
                                                  .read<SalesQuotationCon>()
                                                  .vatNoController,
                                              decoration: InputDecoration(
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  borderSide: const BorderSide(
                                                      color: Colors.red),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  borderSide: const BorderSide(
                                                      color: Colors.red),
                                                ),
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
                                                hintText: 'VAT no',
                                                hintStyle: widget
                                                    .theme.textTheme.bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.grey),
                                                filled: false,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                  // vertical: 10,
                                                  horizontal: 10,
                                                ),
                                              ),
                                            )
                                          : Container())
                                ],
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
                                            .watch<SalesQuotationCon>()
                                            .getselectedcust2!
                                            .phNo!
                                            .isNotEmpty
                                        ? " ${context.watch<SalesQuotationCon>().getselectedcust2!.phNo}  |  "
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
                                            .watch<SalesQuotationCon>()
                                            .getselectedcust2!
                                            .email!
                                            .isNotEmpty
                                        ? " ${context.watch<SalesQuotationCon>().getselectedcust2!.email}"
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
                              width: widget.custWidth * 0.46,
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
                                                .watch<SalesQuotationCon>()
                                                .getselectedcust2!
                                                .tarNo!
                                                .isNotEmpty
                                            ? "${context.watch<SalesQuotationCon>().getselectedcust2!.tarNo}"
                                            : "",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              width: widget.custWidth * 0.46,
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
                                                          SalesQuotationCon>()
                                                      .getselectedcust2!
                                                      .accBalance! ==
                                                  0 ||
                                              context
                                                      .watch<
                                                          SalesQuotationCon>()
                                                      .getselectedcust2!
                                                      .accBalance ==
                                                  null
                                          ? '0.00'
                                          : context
                                              .watch<SalesQuotationCon>()
                                              .config
                                              .splitValues(context
                                                  .watch<SalesQuotationCon>()
                                                  .getselectedcust2!
                                                  .accBalance
                                                  .toString()),
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
                                        "${context.watch<SalesQuotationCon>().getselectedcust2!.cardCode}",
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
                                              .watch<SalesQuotationCon>()
                                              .getselectedcust2!
                                              .point!
                                              .isNotEmpty
                                          ? "${context.watch<SalesQuotationCon>().getselectedcust2!.point}"
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
                                        SizedBox(
                                            width: widget.custWidth * 0.04,
                                            child: const Icon(
                                              Icons.arrow_drop_down,
                                              size: 30,
                                            ))
                                      ],
                                    ),
                                  ),
                                  context
                                                  .watch<SalesQuotationCon>()
                                                  .getselectedcust2 ==
                                              null ||
                                          context
                                                  .watch<SalesQuotationCon>()
                                                  .getselectedcust2!
                                                  .address ==
                                              null ||
                                          context
                                              .watch<SalesQuotationCon>()
                                              .getselectedcust2!
                                              .address!
                                              .isEmpty
                                      ? Container()
                                      : Text(
                                          "${context.watch<SalesQuotationCon>().getselectedcust2!.address![0].address1!.isEmpty ? "" : context.watch<SalesQuotationCon>().getselectedcust2!.address![0].address1.toString()},"
                                          "${context.watch<SalesQuotationCon>().getselectedcust2!.address![0].address2!.isEmpty ? "" : context.watch<SalesQuotationCon>().getselectedcust2!.address![0].address2.toString()},"
                                          "${context.watch<SalesQuotationCon>().getselectedcust2!.address![0].address3!.isEmpty ? "" : context.watch<SalesQuotationCon>().getselectedcust2!.address![0].address3.toString()}",
                                          maxLines: 1,
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black54),
                                        ),
                                  context
                                                  .watch<SalesQuotationCon>()
                                                  .getselectedcust2 ==
                                              null ||
                                          context
                                              .watch<SalesQuotationCon>()
                                              .getselectedcust2!
                                              .address!
                                              .isEmpty ||
                                          context
                                                  .watch<SalesQuotationCon>()
                                                  .getselectedcust2!
                                                  .address ==
                                              null
                                      ? Container()
                                      : Text(
                                          context
                                                  .watch<SalesQuotationCon>()
                                                  .getselectedcust2!
                                                  .address![0]
                                                  .billCity
                                                  .isNotEmpty
                                              ? context
                                                  .watch<SalesQuotationCon>()
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
                                                  .watch<SalesQuotationCon>()
                                                  .getselectedcust2 ==
                                              null ||
                                          context
                                              .watch<SalesQuotationCon>()
                                              .getselectedcust2!
                                              .address!
                                              .isEmpty ||
                                          context
                                                  .watch<SalesQuotationCon>()
                                                  .getselectedcust2!
                                                  .address ==
                                              null
                                      ? Container()
                                      : Text(
                                          context
                                                  .watch<SalesQuotationCon>()
                                                  .getselectedcust2!
                                                  .address![0]
                                                  .billPincode
                                                  .isNotEmpty
                                              ? context
                                                  .watch<SalesQuotationCon>()
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
                                                  .watch<SalesQuotationCon>()
                                                  .getselectedcust2 ==
                                              null ||
                                          context
                                              .watch<SalesQuotationCon>()
                                              .getselectedcust2!
                                              .address!
                                              .isEmpty ||
                                          context
                                                  .watch<SalesQuotationCon>()
                                                  .getselectedcust2!
                                                  .address ==
                                              null
                                      ? Container()
                                      : Text(
                                          context
                                                  .watch<SalesQuotationCon>()
                                                  .getselectedcust2!
                                                  .address![0]
                                                  .billstate
                                                  .isNotEmpty
                                              ? context
                                                  .watch<SalesQuotationCon>()
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
                                        SizedBox(
                                            width: widget.custWidth * 0.04,
                                            child: const Icon(
                                              Icons.arrow_drop_down,
                                              size: 30,
                                            ))
                                      ],
                                    ),
                                  ),
                                  context
                                                  .watch<SalesQuotationCon>()
                                                  .getselectedcust25 ==
                                              null ||
                                          context
                                              .watch<SalesQuotationCon>()
                                              .getselectedcust25!
                                              .address!
                                              .isEmpty ||
                                          context
                                                  .watch<SalesQuotationCon>()
                                                  .getselectedcust25!
                                                  .address ==
                                              null
                                      ? Container()
                                      : Text(
                                          " ${context.watch<SalesQuotationCon>().getselectedcust25!.address![0].address1!.isNotEmpty || context.watch<SalesQuotationCon>().getselectedcust25!.address![0].address1 != null ? context.watch<SalesQuotationCon>().getselectedcust25!.address![0].address1.toString() : ""},"
                                          "${context.watch<SalesQuotationCon>().getselectedcust25!.address![0].address2!.isNotEmpty || context.watch<SalesQuotationCon>().getselectedcust25!.address![0].address2 != null ? context.watch<SalesQuotationCon>().getselectedcust25!.address![0].address2.toString() : ""},"
                                          "${context.watch<SalesQuotationCon>().getselectedcust25!.address![0].address3!.isNotEmpty || context.watch<SalesQuotationCon>().getselectedcust25!.address![0].address3 != null ? context.watch<SalesQuotationCon>().getselectedcust25!.address![0].address3.toString() : ""}",
                                          maxLines: 1,
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black54),
                                        ),
                                  context
                                                  .watch<SalesQuotationCon>()
                                                  .getselectedcust25 ==
                                              null ||
                                          context
                                              .watch<SalesQuotationCon>()
                                              .getselectedcust25!
                                              .address!
                                              .isEmpty ||
                                          context
                                                  .watch<SalesQuotationCon>()
                                                  .getselectedcust25!
                                                  .address ==
                                              null
                                      ? Container()
                                      : context
                                              .watch<SalesQuotationCon>()
                                              .getselectedcust25!
                                              .address!
                                              .isNotEmpty
                                          ? Text(
                                              context
                                                      .watch<
                                                          SalesQuotationCon>()
                                                      .getselectedcust25!
                                                      .address![0]
                                                      .billCity
                                                      .isNotEmpty
                                                  ? context
                                                      .watch<
                                                          SalesQuotationCon>()
                                                      .getselectedcust25!
                                                      .address![0]
                                                      .billCity
                                                      .toString()
                                                  : '',
                                              maxLines: 1,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            )
                                          : Container(),
                                  context
                                                  .watch<SalesQuotationCon>()
                                                  .getselectedcust25 ==
                                              null ||
                                          context
                                              .watch<SalesQuotationCon>()
                                              .getselectedcust25!
                                              .address!
                                              .isEmpty ||
                                          context
                                                  .watch<SalesQuotationCon>()
                                                  .getselectedcust25!
                                                  .address ==
                                              null
                                      ? Container()
                                      : Text(
                                          context
                                                  .watch<SalesQuotationCon>()
                                                  .getselectedcust25!
                                                  .address![0]
                                                  .billPincode
                                                  .isNotEmpty
                                              ? context
                                                  .watch<SalesQuotationCon>()
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
                                                  .watch<SalesQuotationCon>()
                                                  .getselectedcust25 ==
                                              null ||
                                          context
                                              .watch<SalesQuotationCon>()
                                              .getselectedcust25!
                                              .address!
                                              .isEmpty ||
                                          context
                                                  .watch<SalesQuotationCon>()
                                                  .getselectedcust25!
                                                  .address ==
                                              null
                                      ? Container()
                                      : Text(
                                          context
                                                  .watch<SalesQuotationCon>()
                                                  .getselectedcust25!
                                                  .address![0]
                                                  .billstate
                                                  .isNotEmpty
                                              ? context
                                                  .watch<SalesQuotationCon>()
                                                  .getselectedcust25!
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
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : context.watch<SalesQuotationCon>().getselectedcust == null
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
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height: widget.custHeight * 0.16,
                                            width: widget.custWidth * 0.55,
                                            child: context
                                                            .read<
                                                                SalesQuotationCon>()
                                                            .selectedcust !=
                                                        null &&
                                                    context
                                                            .read<
                                                                SalesQuotationCon>()
                                                            .selectedcust!
                                                            .paymentGroup !=
                                                        null &&
                                                    context
                                                            .read<
                                                                SalesQuotationCon>()
                                                            .selectedcust!
                                                            .U_CashCust ==
                                                        'YES'
                                                ? TextFormField(
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return '';
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    onEditingComplete: () {
                                                      context
                                                              .read<
                                                                  SalesQuotationCon>()
                                                              .selectedcust!
                                                              .name =
                                                          context
                                                              .read<
                                                                  SalesQuotationCon>()
                                                              .custNameController
                                                              .text;
                                                      context
                                                          .read<
                                                              SalesQuotationCon>()
                                                          .disableKeyBoard(
                                                              context);
                                                    },
                                                    controller: context
                                                        .read<
                                                            SalesQuotationCon>()
                                                        .custNameController,
                                                    decoration: InputDecoration(
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    Colors.red),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    Colors.red),
                                                      ),
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
                                                      hintText: 'Name',
                                                      // labelText: 'Name',
                                                      hintStyle: widget.theme
                                                          .textTheme.bodyMedium
                                                          ?.copyWith(
                                                              color:
                                                                  Colors.grey),
                                                      filled: false,
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                        // vertical: 10,
                                                        horizontal: 10,
                                                      ),
                                                    ),
                                                  )
                                                : Text(
                                                    context
                                                                .watch<
                                                                    SalesQuotationCon>()
                                                                .getselectedcust!
                                                                .name ==
                                                            null
                                                        ? ""
                                                        : context
                                                            .watch<
                                                                SalesQuotationCon>()
                                                            .getselectedcust!
                                                            .name
                                                            .toString(),
                                                    maxLines: 1,
                                                    style: theme
                                                        .textTheme.bodyLarge
                                                        ?.copyWith(
                                                            color: Colors.black,
                                                            fontSize: 20),
                                                  ),
                                          ),
                                          SizedBox(
                                            width:
                                                Screens.width(context) * 0.01,
                                          ),
                                          SizedBox(
                                              height: widget.custHeight * 0.16,
                                              width: widget.custWidth * 0.3,
                                              child: context
                                                              .read<
                                                                  SalesQuotationCon>()
                                                              .selectedcust !=
                                                          null &&
                                                      context
                                                              .read<
                                                                  SalesQuotationCon>()
                                                              .selectedcust!
                                                              .paymentGroup !=
                                                          null &&
                                                      context
                                                              .read<
                                                                  SalesQuotationCon>()
                                                              .selectedcust!
                                                              .U_CashCust ==
                                                          'YES'
                                                  ? TextFormField(
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return '';
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                      onEditingComplete: () {
                                                        // context
                                                        //         .read<PosController>()
                                                        //         .selectedcust!
                                                        //         .name =
                                                        //     context
                                                        //         .read<
                                                        //             PosController>()
                                                        //         .custNameController
                                                        //         .text;
                                                        context
                                                            .read<
                                                                SalesQuotationCon>()
                                                            .disableKeyBoard(
                                                                context);
                                                      },
                                                      controller: context
                                                          .read<
                                                              SalesQuotationCon>()
                                                          .tinNoController,
                                                      decoration:
                                                          InputDecoration(
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .red),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .red),
                                                        ),
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
                                                        hintText: 'Tin no',
                                                        // labelText: 'Tin no',
                                                        hintStyle: widget
                                                            .theme
                                                            .textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .grey),
                                                        filled: false,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          // vertical: 10,
                                                          horizontal: 10,
                                                        ),
                                                      ),
                                                    )
                                                  : Container())
                                        ],
                                      ),
                                      SizedBox(
                                          height:
                                              Screens.padingHeight(context) *
                                                  0.01),
                                      SizedBox(
                                          height: widget.custHeight * 0.16,
                                          width: widget.custWidth * 0.3,
                                          child: context
                                                          .read<
                                                              SalesQuotationCon>()
                                                          .selectedcust !=
                                                      null &&
                                                  context
                                                          .read<
                                                              SalesQuotationCon>()
                                                          .selectedcust!
                                                          .paymentGroup !=
                                                      null &&
                                                  context
                                                          .read<
                                                              SalesQuotationCon>()
                                                          .selectedcust!
                                                          .U_CashCust ==
                                                      'YES'
                                              ? TextFormField(
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return '';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  onEditingComplete: () {
                                                    // context
                                                    //         .read<PosController>()
                                                    //         .selectedcust!
                                                    //         .name =
                                                    //     context
                                                    //         .read<
                                                    //             PosController>()
                                                    //         .custNameController
                                                    //         .text;
                                                    context
                                                        .read<
                                                            SalesQuotationCon>()
                                                        .disableKeyBoard(
                                                            context);
                                                  },
                                                  controller: context
                                                      .read<SalesQuotationCon>()
                                                      .vatNoController,
                                                  decoration: InputDecoration(
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.red),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.red),
                                                    ),
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
                                                    hintText: 'VAT no',
                                                    // labelText: 'VAT no',
                                                    hintStyle: widget.theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            color: Colors.grey),
                                                    filled: false,
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                      // vertical: 10,
                                                      horizontal: 10,
                                                    ),
                                                  ),
                                                )
                                              : Container())
                                    ],
                                  ),
                                  InkWell(
                                      onTap: () {
                                        if (context
                                                .read<SalesQuotationCon>()
                                                .editqty ==
                                            true) {
                                          context
                                              .read<SalesQuotationCon>()
                                              .scanneditemData = [];
                                          context
                                              .read<SalesQuotationCon>()
                                              .totalPayment = null;
                                          context
                                              .read<SalesQuotationCon>()
                                              .editqty = false;
                                          context
                                              .read<SalesQuotationCon>()
                                              .clearData(context, theme);
                                        } else {
                                          context
                                              .read<SalesQuotationCon>()
                                              .clearData(context, theme);
                                        }
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
                                                .watch<SalesQuotationCon>()
                                                .getselectedcust!
                                                .phNo!
                                                .isNotEmpty
                                            ? " ${context.watch<SalesQuotationCon>().getselectedcust!.phNo}  |  "
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
                                                        .watch<
                                                            SalesQuotationCon>()
                                                        .getselectedcust!
                                                        .email ==
                                                    null ||
                                                context
                                                        .watch<
                                                            SalesQuotationCon>()
                                                        .getselectedcust!
                                                        .email ==
                                                    'null' ||
                                                context
                                                    .watch<SalesQuotationCon>()
                                                    .getselectedcust!
                                                    .email!
                                                    .isEmpty
                                            ? ""
                                            : " ${context.watch<SalesQuotationCon>().getselectedcust!.email}",
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
                                                                SalesQuotationCon>()
                                                            .getselectedcust!
                                                            .tarNo ==
                                                        null ||
                                                    context
                                                            .read<
                                                                SalesQuotationCon>()
                                                            .getselectedcust!
                                                            .tarNo ==
                                                        'null' ||
                                                    context
                                                        .read<
                                                            SalesQuotationCon>()
                                                        .getselectedcust!
                                                        .tarNo!
                                                        .isEmpty
                                                ? ""
                                                : "${context.watch<SalesQuotationCon>().getselectedcust!.tarNo}",
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
                                                              SalesQuotationCon>()
                                                          .getselectedcust!
                                                          .accBalance ==
                                                      null ||
                                                  context
                                                          .watch<
                                                              SalesQuotationCon>()
                                                          .getselectedcust!
                                                          .accBalance ==
                                                      0
                                              ? '0.00'
                                              : context
                                                  .watch<SalesQuotationCon>()
                                                  .config
                                                  .splitValues(context
                                                      .watch<
                                                          SalesQuotationCon>()
                                                      .getselectedcust!
                                                      .accBalance!
                                                      .toStringAsFixed(2)),
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
                                            "${context.watch<SalesQuotationCon>().getselectedcust!.cardCode}",
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
                                                  .watch<SalesQuotationCon>()
                                                  .getselectedcust!
                                                  .point!
                                                  .isNotEmpty
                                              ? "${context.watch<SalesQuotationCon>().getselectedcust!.point}"
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
                            children: [
                              InkWell(
                                onTap: () async {
                                  // context
                                  //     .read<SalesQuotationCon>()
                                  //     .clearTextField();
                                  // await billAddress(context);
                                  // await context
                                  //     .read<SalesQuotationCon>()
                                  //     .billaddresslist();
                                  // await context
                                  //     .read<SalesQuotationCon>()
                                  //     .disableKeyBoard(context);
                                },
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
                                            // SizedBox(
                                            //     width: widget.custWidth * 0.04,
                                            //     child: const Icon(
                                            //       Icons.arrow_drop_down,
                                            //       size: 30,
                                            //     ))
                                          ],
                                        ),
                                      ),
                                      context
                                                          .watch<
                                                              SalesQuotationCon>()
                                                          .getselectedcust ==
                                                      null &&
                                                  context
                                                          .watch<
                                                              SalesQuotationCon>()
                                                          .getselectedcust!
                                                          .address ==
                                                      null ||
                                              context
                                                  .watch<SalesQuotationCon>()
                                                  .getselectedcust!
                                                  .address!
                                                  .isEmpty
                                          ? Container()
                                          : Text(
                                              " ${context.watch<SalesQuotationCon>().getselectedcust!.address![context.watch<SalesQuotationCon>().getselectedBillAdress!].address1!.isEmpty ? "" : context.watch<SalesQuotationCon>().getselectedcust!.address![context.watch<SalesQuotationCon>().getselectedBillAdress!].address1.toString()},"
                                              "${context.watch<SalesQuotationCon>().getselectedcust!.address![context.watch<SalesQuotationCon>().getselectedBillAdress!].address2!.isEmpty ? "" : context.watch<SalesQuotationCon>().getselectedcust!.address![context.watch<SalesQuotationCon>().getselectedBillAdress!].address2.toString()},"
                                              " ${context.watch<SalesQuotationCon>().getselectedcust!.address![context.watch<SalesQuotationCon>().getselectedBillAdress!].address3!.isEmpty ? "" : context.watch<SalesQuotationCon>().getselectedcust!.address![context.watch<SalesQuotationCon>().getselectedBillAdress!].address3.toString()}",
                                              maxLines: 1,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            ),
                                      context
                                                      .read<SalesQuotationCon>()
                                                      .getselectedcust !=
                                                  null &&
                                              context
                                                  .watch<SalesQuotationCon>()
                                                  .getselectedcust!
                                                  .address!
                                                  .isNotEmpty
                                          ? Text(
                                              context
                                                      .watch<
                                                          SalesQuotationCon>()
                                                      .getselectedcust!
                                                      .address![context
                                                          .watch<
                                                              SalesQuotationCon>()
                                                          .getselectedBillAdress!]
                                                      .billCity
                                                      .isNotEmpty
                                                  ? context
                                                      .watch<
                                                          SalesQuotationCon>()
                                                      .getselectedcust!
                                                      .address![context
                                                          .watch<
                                                              SalesQuotationCon>()
                                                          .getselectedBillAdress!]
                                                      .billCity
                                                      .toString()
                                                  : "",
                                              maxLines: 1,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            )
                                          : Container(),
                                      context
                                                      .read<SalesQuotationCon>()
                                                      .getselectedcust !=
                                                  null &&
                                              context
                                                  .watch<SalesQuotationCon>()
                                                  .getselectedcust!
                                                  .address!
                                                  .isNotEmpty
                                          ? Text(
                                              context
                                                      .watch<
                                                          SalesQuotationCon>()
                                                      .getselectedcust!
                                                      .address![context
                                                          .watch<
                                                              SalesQuotationCon>()
                                                          .getselectedBillAdress!]
                                                      .billPincode
                                                      .isNotEmpty
                                                  ? context
                                                      .watch<
                                                          SalesQuotationCon>()
                                                      .getselectedcust!
                                                      .address![context
                                                          .watch<
                                                              SalesQuotationCon>()
                                                          .getselectedBillAdress!]
                                                      .billPincode
                                                      .toString()
                                                  : '',
                                              maxLines: 1,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            )
                                          : Container(),
                                      context
                                                      .watch<
                                                          SalesQuotationCon>()
                                                      .getselectedcust!
                                                      .address ==
                                                  null ||
                                              context
                                                  .watch<SalesQuotationCon>()
                                                  .getselectedcust!
                                                  .address!
                                                  .isEmpty
                                          ? Container()
                                          : Text(
                                              context
                                                      .watch<
                                                          SalesQuotationCon>()
                                                      .getselectedcust!
                                                      .address![context
                                                          .watch<
                                                              SalesQuotationCon>()
                                                          .getselectedBillAdress!]
                                                      .billstate
                                                      .isNotEmpty
                                                  ? context
                                                      .watch<
                                                          SalesQuotationCon>()
                                                      .getselectedcust!
                                                      .address![context
                                                          .watch<
                                                              SalesQuotationCon>()
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
                                onTap: () async {
                                  // context
                                  //     .read<SalesQuotationCon>()
                                  //     .clearTextField();
                                  // sipaddress(context);
                                  // await context
                                  //     .read<SalesQuotationCon>()
                                  //     .shippinfaddresslist();
                                  // context
                                  //     .read<SalesQuotationCon>()
                                  //     .disableKeyBoard(context);
                                },
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
                                            // SizedBox(
                                            //     width: widget.custWidth * 0.04,
                                            //     child: const Icon(
                                            //       Icons.arrow_drop_down,
                                            //       size: 30,
                                            //     ))
                                          ],
                                        ),
                                      ),
                                      context
                                                      .read<SalesQuotationCon>()
                                                      .getselectedcust55 !=
                                                  null &&
                                              context
                                                  .read<SalesQuotationCon>()
                                                  .getselectedcust55!
                                                  .address!
                                                  .isNotEmpty
                                          ? Text(
                                              " ${context.read<SalesQuotationCon>().getselectedcust55!.address != null || context.read<SalesQuotationCon>().getselectedcust55!.address![context.read<SalesQuotationCon>().getselectedShipAdress!].address1!.isNotEmpty ? context.watch<SalesQuotationCon>().getselectedcust55!.address![context.read<SalesQuotationCon>().getselectedShipAdress!].address1.toString() : ""},"
                                              "${context.read<SalesQuotationCon>().getselectedcust55!.address != null || context.read<SalesQuotationCon>().getselectedcust55!.address![context.read<SalesQuotationCon>().getselectedShipAdress!].address2!.isNotEmpty ? context.watch<SalesQuotationCon>().getselectedcust55!.address![context.read<SalesQuotationCon>().getselectedShipAdress!].address2.toString() : ""},"
                                              " ${context.read<SalesQuotationCon>().getselectedcust55!.address != null || context.read<SalesQuotationCon>().getselectedcust55!.address![context.read<SalesQuotationCon>().getselectedShipAdress!].address3!.isNotEmpty ? context.watch<SalesQuotationCon>().getselectedcust55!.address![context.read<SalesQuotationCon>().getselectedShipAdress!].address3.toString() : ""},",
                                              maxLines: 1,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            )
                                          : Container(),
                                      context
                                                      .read<SalesQuotationCon>()
                                                      .getselectedcust55 !=
                                                  null &&
                                              context
                                                  .read<SalesQuotationCon>()
                                                  .getselectedcust55!
                                                  .address!
                                                  .isNotEmpty
                                          ? Text(
                                              context
                                                      .read<SalesQuotationCon>()
                                                      .getselectedcust55!
                                                      .address![context
                                                          .read<
                                                              SalesQuotationCon>()
                                                          .getselectedShipAdress!]
                                                      .billCity
                                                      .isNotEmpty
                                                  ? context
                                                      .watch<
                                                          SalesQuotationCon>()
                                                      .getselectedcust55!
                                                      .address![context
                                                          .read<
                                                              SalesQuotationCon>()
                                                          .getselectedShipAdress!]
                                                      .billCity
                                                      .toString()
                                                  : '',
                                              maxLines: 1,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            )
                                          : Container(),
                                      context
                                                      .read<SalesQuotationCon>()
                                                      .getselectedcust55 !=
                                                  null &&
                                              context
                                                  .read<SalesQuotationCon>()
                                                  .getselectedcust55!
                                                  .address!
                                                  .isNotEmpty
                                          ? Text(
                                              context
                                                      .read<SalesQuotationCon>()
                                                      .getselectedcust55!
                                                      .address![context
                                                          .read<
                                                              SalesQuotationCon>()
                                                          .getselectedShipAdress!]
                                                      .billPincode
                                                      .isNotEmpty
                                                  ? context
                                                      .watch<
                                                          SalesQuotationCon>()
                                                      .getselectedcust55!
                                                      .address![context
                                                          .read<
                                                              SalesQuotationCon>()
                                                          .getselectedShipAdress!]
                                                      .billPincode
                                                      .toString()
                                                  : '',
                                              maxLines: 1,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            )
                                          : Container(),
                                      context
                                                      .read<SalesQuotationCon>()
                                                      .getselectedcust55 !=
                                                  null &&
                                              context
                                                  .read<SalesQuotationCon>()
                                                  .getselectedcust55!
                                                  .address!
                                                  .isNotEmpty
                                          ? Text(
                                              context
                                                      .read<SalesQuotationCon>()
                                                      .getselectedcust55!
                                                      .address![context
                                                          .read<
                                                              SalesQuotationCon>()
                                                          .getselectedShipAdress!]
                                                      .billstate
                                                      .isNotEmpty
                                                  ? context
                                                      .watch<
                                                          SalesQuotationCon>()
                                                      .getselectedcust55!
                                                      .address![context
                                                          .watch<
                                                              SalesQuotationCon>()
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
                controller: context.read<SalesQuotationCon>().searchcontroller,
                cursorColor: Colors.grey,
                autofocus: true,
                onChanged: (v) {
                  st(() {
                    context.read<SalesQuotationCon>().filterList(v);
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
                        .watch<SalesQuotationCon>()
                        .getfiltercustList
                        .length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          padding: EdgeInsets.only(
                              top: widget.custHeight * 0.01,
                              left: widget.custWidth * 0.005,
                              right: widget.custWidth * 0.005,
                              bottom: widget.custHeight * 0.03),
                          child: StatefulBuilder(builder: (context, st) {
                            return ListTile(
                              onTap: () {
                                Navigator.pop(context);

                                context.read<SalesQuotationCon>().custSelected(
                                    context
                                        .read<SalesQuotationCon>()
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
                                          .watch<SalesQuotationCon>()
                                          .getfiltercustList[index]
                                          .cardCode!),
                                      // Text(context
                                      //     .watch<SalesQuotationCon>()
                                      //     .config
                                      //     .splitValues(context
                                      //         .watch<SalesQuotationCon>()
                                      //         .getfiltercustList[index]
                                      //         .accBalance!
                                      //         .toString())),
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
                                              .watch<SalesQuotationCon>()
                                              .getfiltercustList[index]
                                              .name!,
                                          maxLines: 2,
                                        ),
                                      ),
                                      Text(context
                                          .watch<SalesQuotationCon>()
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
                bottom: widget.custHeight * 0.01),
            width: widget.custWidth * 1.1,
            height: widget.custHeight * 2.6,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    key: context.read<SalesQuotationCon>().formkey[6],
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
                                vertical: 2.0, horizontal: 10.0),
                            child: DropdownButtonFormField<String>(
                              validator: (value) => value == null
                                  ? context
                                      .read<SalesQuotationCon>()
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
                                  .read<SalesQuotationCon>()
                                  .custseriesNo,
                              items: context
                                  .watch<SalesQuotationCon>()
                                  .seriesData
                                  .map((e) {
                                return DropdownMenuItem(
                                    value: "${e.Series}",
                                    child: Text(e.SeriesName.toString()));
                              }).toList(),
                              hint: const Text(
                                "Select Series",
                              ),
                              onChanged: (value) {
                                st(() {
                                  context
                                      .read<SalesQuotationCon>()
                                      .custseriesNo = value!;

                                  context
                                      .read<SalesQuotationCon>()
                                      .custCodeReadOnly();
                                });
                              },
                            )),
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
                                .watch<SalesQuotationCon>()
                                .seriesValuebool,
                            textCapitalization: TextCapitalization.sentences,
                            controller: context
                                .read<SalesQuotationCon>()
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
                                .read<SalesQuotationCon>()
                                .mycontroller[4],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.black),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                context.read<SalesQuotationCon>().textError =
                                    "Please Enter the Mobile Number";
                                return "Please Enter the Mobile Number";
                              } else if (value.length < 10) {
                                context.read<SalesQuotationCon>().textError =
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
                                .read<SalesQuotationCon>()
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
                                .read<SalesQuotationCon>()
                                .mycontroller[6],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.black),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                context.read<SalesQuotationCon>().textError =
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
                                      .read<SalesQuotationCon>()
                                      .textError = 'Select a Group'
                                  : null,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              icon: const Icon(Icons.arrow_drop_down),
                              value:
                                  context.read<SalesQuotationCon>().codeValue,
                              items: context
                                  .watch<SalesQuotationCon>()
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
                                  context.read<SalesQuotationCon>().codeValue =
                                      value!;
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
                                .read<SalesQuotationCon>()
                                .mycontroller[22],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.black),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                context.read<SalesQuotationCon>().textError =
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
                                .read<SalesQuotationCon>()
                                .mycontroller[23],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.black),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                context.read<SalesQuotationCon>().textError =
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
                                  InkWell(
                                    onTap: () {
                                      st(() {
                                        context
                                            .read<SalesQuotationCon>()
                                            .selectattachment();
                                        context
                                            .read<SalesQuotationCon>()
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
                              context
                                      .watch<SalesQuotationCon>()
                                      .tinfileError
                                      .isEmpty
                                  ? Container()
                                  : Text(
                                      context
                                          .watch<SalesQuotationCon>()
                                          .tinfileError,
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.red)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: widget.custHeight * 0.01,
                        ),
                        context.watch<SalesQuotationCon>().tinFiles == null
                            ? const SizedBox()
                            : ListView.builder(
                                itemCount: 1,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int i) {
                                  if (context
                                      .read<SalesQuotationCon>()
                                      .tinFiles!
                                      .path
                                      .split('/')
                                      .last
                                      .contains("png")) {
                                    return Column(children: [
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
                                                width: widget.custWidth * 0.8,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  context
                                                      .watch<
                                                          SalesQuotationCon>()
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
                                                                SalesQuotationCon>()
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
                                      .read<SalesQuotationCon>()
                                      .tinFiles!
                                      .path
                                      .split('/')
                                      .last
                                      .contains("jp")) {
                                    return Column(children: [
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
                                                    const EdgeInsets.all(3),
                                                decoration:
                                                    const BoxDecoration(),
                                                width: widget.custWidth * 0.8,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  context
                                                      .watch<
                                                          SalesQuotationCon>()
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
                                                                SalesQuotationCon>()
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
                                      .read<SalesQuotationCon>()
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
                                            SizedBox(
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
                                                width: widget.custWidth * 0.8,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  context
                                                      .watch<
                                                          SalesQuotationCon>()
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
                                                                SalesQuotationCon>()
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
                                      .read<SalesQuotationCon>()
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
                                                      .watch<
                                                          SalesQuotationCon>()
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
                                                                SalesQuotationCon>()
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
                                              width: widget.custWidth * 0.1,
                                              height: widget.custHeight * 0.13,
                                              child: Center(
                                                  child: Image.asset(
                                                      "assets/txt.png"))),
                                          Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: const BoxDecoration(),
                                              width: widget.custWidth * 0.8,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                context
                                                    .watch<SalesQuotationCon>()
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
                                                              SalesQuotationCon>()
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
                          height: widget.custHeight * 0.03,
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
                                    child: const Text("Select Vat File"),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      st(() {
                                        context
                                            .read<SalesQuotationCon>()
                                            .selectVatattachment();
                                        context
                                            .read<SalesQuotationCon>()
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
                              context
                                      .watch<SalesQuotationCon>()
                                      .vatfileError
                                      .isEmpty
                                  ? Container()
                                  : Text(
                                      context
                                          .watch<SalesQuotationCon>()
                                          .vatfileError,
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.red)),
                            ],
                          ),
                        ),
                        context.watch<SalesQuotationCon>().vatFiles == null
                            ? const SizedBox()
                            : ListView.builder(
                                itemCount: 1,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int i) {
                                  if (context
                                      .read<SalesQuotationCon>()
                                      .vatFiles!
                                      .path
                                      .split('/')
                                      .last
                                      .contains("png")) {
                                    return Column(children: [
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
                                                      .watch<
                                                          SalesQuotationCon>()
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
                                                                SalesQuotationCon>()
                                                            .clearVatFile();
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.cancel_rounded,
                                                      color: Colors.grey,
                                                    )))
                                          ])
                                    ]);
                                  } else if (context
                                      .read<SalesQuotationCon>()
                                      .vatFiles!
                                      .path
                                      .split('/')
                                      .last
                                      .contains("jp")) {
                                    return Column(children: [
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
                                                    const EdgeInsets.all(5),
                                                decoration:
                                                    const BoxDecoration(),
                                                width: widget.custWidth * 0.8,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  context
                                                      .watch<
                                                          SalesQuotationCon>()
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
                                                                SalesQuotationCon>()
                                                            .clearVatFile();
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.cancel_rounded,
                                                      color: Colors.grey,
                                                    )))
                                          ])
                                    ]);
                                  } else if (context
                                      .read<SalesQuotationCon>()
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
                                                      .watch<
                                                          SalesQuotationCon>()
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
                                                                SalesQuotationCon>()
                                                            .clearVatFile();
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.cancel_rounded,
                                                      color: Colors.grey,
                                                    )))
                                          ])
                                    ]);
                                  } else if (context
                                      .read<SalesQuotationCon>()
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                      .watch<
                                                          SalesQuotationCon>()
                                                      .vatFiles!
                                                      .path
                                                      .split('/')
                                                      .last,
                                                )),
                                            GestureDetector(
                                              onTap: () {
                                                st(() {
                                                  context
                                                      .read<SalesQuotationCon>()
                                                      .clearVatFile();
                                                });
                                              },
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  child: const Icon(
                                                    Icons.cancel_rounded,
                                                    color: Colors.grey,
                                                  )),
                                            )
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
                                              width: widget.custWidth * 0.1,
                                              height: widget.custHeight * 0.13,
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
                                                    .read<SalesQuotationCon>()
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
                                                              SalesQuotationCon>()
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
                                      .read<SalesQuotationCon>()
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
                                  .read<SalesQuotationCon>()
                                  .teriteriValue,
                              items: context
                                  .watch<SalesQuotationCon>()
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
                                      .read<SalesQuotationCon>()
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
                                .read<SalesQuotationCon>()
                                .mycontroller[24],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.black),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                context.read<SalesQuotationCon>().textError =
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
                                .read<SalesQuotationCon>()
                                .mycontroller[25],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.black),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                context.read<SalesQuotationCon>().textError =
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
                                .read<SalesQuotationCon>()
                                .mycontroller[21],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.black),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value)) {
                                  context.read<SalesQuotationCon>().textError =
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
                                      .read<SalesQuotationCon>()
                                      .textError = 'Select a Peyment Term'
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
                                  .watch<SalesQuotationCon>()
                                  .paygrpValue,
                              items: context
                                  .watch<SalesQuotationCon>()
                                  .paygroupData!
                                  .map((e) {
                                return DropdownMenuItem(
                                    value: "${e.GroupNum}",
                                    child: Text(e.PymntGroup.toString()));
                              }).toList(),
                              hint: Text("Payment terms",
                                  style: theme.textTheme.bodyLarge
                                      ?.copyWith(color: Colors.black54)),
                              onChanged: (String? value) {
                                st(() {
                                  context
                                      .read<SalesQuotationCon>()
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
                                .read<SalesQuotationCon>()
                                .mycontroller[26],
                            onTap: () {
                              context
                                      .read<SalesQuotationCon>()
                                      .mycontroller[26]
                                      .text =
                                  context
                                      .read<SalesQuotationCon>()
                                      .mycontroller[26]
                                      .text
                                      .replaceAll(',', '');
                            },
                            onEditingComplete: () {
                              context
                                      .read<SalesQuotationCon>()
                                      .mycontroller[26]
                                      .text =
                                  context
                                      .read<SalesQuotationCon>()
                                      .config
                                      .splitValues(context
                                          .read<SalesQuotationCon>()
                                          .mycontroller[26]
                                          .text);
                              context
                                  .read<SalesQuotationCon>()
                                  .disableKeyBoard(context);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                context.read<SalesQuotationCon>().textError =
                                    "Please Enter the Credit Limit";
                                return "Please Enter the Credit Limit";
                              } else {
                                return null;
                              }
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
                          onTap: () {},
                          controller: context
                              .read<SalesQuotationCon>()
                              .mycontroller[27],
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
            height: widget.custHeight * 0.18,
            width: widget.custWidth * 1.1,
            child: ElevatedButton(
                onPressed: context.read<SalesQuotationCon>().loadingBtn == false
                    ? () {
                        st(() {
                          context
                              .read<SalesQuotationCon>()
                              .createnewchangescustaddres(context, theme, 6);
                        });
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                    backgroundColor: theme.primaryColor),
                child: context.read<SalesQuotationCon>().loadingBtn == false
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
                key: context.read<SalesQuotationCon>().formkey[6],
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
                        controller:
                            context.read<SalesQuotationCon>().mycontroller[4],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<SalesQuotationCon>().textError =
                                "Please Enter the Mobile Number";
                            return "Please Enter the Mobile Number";
                          } else if (value.length < 10) {
                            context.read<SalesQuotationCon>().textError =
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
                        controller:
                            context.read<SalesQuotationCon>().mycontroller[5],
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
                        controller:
                            context.read<SalesQuotationCon>().mycontroller[6],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<SalesQuotationCon>().textError =
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
                        controller:
                            context.read<SalesQuotationCon>().mycontroller[21],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              context.read<SalesQuotationCon>().textError =
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
      context.read<SalesQuotationCon>().custList2.length,
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
        context.read<SalesQuotationCon>().custSelected(
            context.read<SalesQuotationCon>().custList2[ind], context, theme);
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: theme.primaryColor,
            border: Border.all(color: theme.primaryColor, width: 1),
            borderRadius: BorderRadius.circular(5)),
        child: Text(context.watch<SalesQuotationCon>().custList2[ind].name!,
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
                              .read<SalesQuotationCon>()
                              .updateCustomer(context, theme, i, ij);
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
                                .read<SalesQuotationCon>()
                                .updateCustomer(context, theme, i, ij);
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
                            .watch<SalesQuotationCon>()
                            .billadrrssItemlist
                            .length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              context
                                  .read<SalesQuotationCon>()
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
                                            "${context.watch<SalesQuotationCon>().billadrrssItemlist[index].address1 ?? ''},"
                                            "${context.watch<SalesQuotationCon>().billadrrssItemlist[index].address2 ?? ''},"
                                            "${context.watch<SalesQuotationCon>().billadrrssItemlist[index].address3 ?? ''}"),
                                        Text(context
                                            .watch<SalesQuotationCon>()
                                            .billadrrssItemlist[index]
                                            .billCity),
                                        Text(context
                                            .watch<SalesQuotationCon>()
                                            .billadrrssItemlist[index]
                                            .billPincode),
                                        Text(context
                                            .watch<SalesQuotationCon>()
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
                context.read<SalesQuotationCon>().clearTextField();
                context.read<SalesQuotationCon>().checkboxx = false;

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
                      .watch<SalesQuotationCon>()
                      .shipadrrssItemlist
                      .length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        context
                            .read<SalesQuotationCon>()
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
                                      "${context.watch<SalesQuotationCon>().shipadrrssItemlist[index].address1 ?? ''},"
                                      "${context.watch<SalesQuotationCon>().shipadrrssItemlist[index].address2 ?? ''},"
                                      "${context.watch<SalesQuotationCon>().shipadrrssItemlist[index].address3 ?? ''}"),
                                  Text(context
                                          .read<SalesQuotationCon>()
                                          .shipadrrssItemlist[index]
                                          .billCity
                                          .isNotEmpty
                                      ? context
                                          .watch<SalesQuotationCon>()
                                          .shipadrrssItemlist[index]
                                          .billCity
                                      : ''),
                                  Text(context
                                              .read<SalesQuotationCon>()
                                              .shipadrrssItemlist[index]
                                              .billPincode !=
                                          null
                                      ? context
                                          .watch<SalesQuotationCon>()
                                          .shipadrrssItemlist[index]
                                          .billPincode
                                      : ""),
                                  Text(context
                                      .watch<SalesQuotationCon>()
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
                context.read<SalesQuotationCon>().checkboxx = false;
                context.read<SalesQuotationCon>().clearTextField();
                createShippAddress(context, theme);
              },
            ));
      });
}

createBillAddress(BuildContext context, ThemeData theme) async {
  final theme = Theme.of(context);
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
        height: Screens.padingHeight(context) * 0.45,
        padding: EdgeInsets.symmetric(
          horizontal: Screens.width(context) * 0.005,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BillAddressWidget(
                theme: theme,
                custHeight: Screens.padingHeight(context) * 0.37,
                custWidth: Screens.width(context) * 0.7,
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: Screens.padingHeight(context) * 0.052,
        width: Screens.width(context) * 0.499,
        child: ElevatedButton(
            onPressed: context.watch<SalesQuotationCon>().addLoadingBtn == true
                ? null
                : () {
                    context
                        .read<SalesQuotationCon>()
                        .insertnewbiladdresscreation(context, theme);
                  },
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(),
                backgroundColor: theme.primaryColor),
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white, fontSize: 18),
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
        height: Screens.padingHeight(context) * 0.45,
        padding: EdgeInsets.symmetric(
          horizontal: Screens.width(context) * 0.005,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ShipAddressWidget(
                theme: theme,
                custHeight: Screens.padingHeight(context) * 0.35,
                custWidth: Screens.width(context) * 0.7,
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: Screens.padingHeight(context) * 0.056,
        width: Screens.width(context) * 0.5,
        child: ElevatedButton(
            onPressed: context.watch<SalesQuotationCon>().addLoadingBtn == true
                ? null
                : () {
                    context
                        .read<SalesQuotationCon>()
                        .insertnewshipaddresscreation(context, theme);
                  },
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(),
                backgroundColor: theme.primaryColor),
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white, fontSize: 18),
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
            key: context.read<SalesQuotationCon>().formkeyAd,
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
                        context.read<SalesQuotationCon>().mycontroller[7],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        context.read<SalesQuotationCon>().textError =
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
                        context.read<SalesQuotationCon>().mycontroller[8],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        context.read<SalesQuotationCon>().textError =
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
                        context.read<SalesQuotationCon>().mycontroller[9],
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        context.read<SalesQuotationCon>().textError =
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
                        controller:
                            context.read<SalesQuotationCon>().mycontroller[10],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<SalesQuotationCon>().textError =
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
                        controller:
                            context.read<SalesQuotationCon>().mycontroller[11],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<SalesQuotationCon>().textError =
                                "Please Enter the Pincode";
                            return "Please Enter the Pincode";
                          } else if (value.length < 6) {
                            context.read<SalesQuotationCon>().textError =
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
                        controller:
                            context.read<SalesQuotationCon>().mycontroller[12],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<SalesQuotationCon>().textError =
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
                        controller:
                            context.read<SalesQuotationCon>().mycontroller[13],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<SalesQuotationCon>().textError =
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
                        value: context.watch<SalesQuotationCon>().checkboxx,
                        onChanged: (val) {
                          st(() {
                            context.read<SalesQuotationCon>().checkboxx = val!;
                            context.read<SalesQuotationCon>().billToShip(val);
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
                        controller:
                            context.read<SalesQuotationCon>().mycontroller[14],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<SalesQuotationCon>().textError =
                                "Please Enter the Ship_Address1";
                            return "Please Enter the Ship_Address1";
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
                        controller:
                            context.read<SalesQuotationCon>().mycontroller[15],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<SalesQuotationCon>().textError =
                                "Please Enter the Ship_Address2";
                            return "Please Enter the Ship_Address2";
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
                        controller:
                            context.read<SalesQuotationCon>().mycontroller[16],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<SalesQuotationCon>().textError =
                                "Please Enter the Ship_Address3";
                            return "Please Enter the Ship_Address3";
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
                        controller:
                            context.read<SalesQuotationCon>().mycontroller[17],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<SalesQuotationCon>().textError =
                                "Please Enter the Ship_City Name";
                            return "Please Enter the Ship_City Name";
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
                        controller:
                            context.read<SalesQuotationCon>().mycontroller[18],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<SalesQuotationCon>().textError =
                                "Please Enter the Ship_PinCode";
                            return "Please Enter the Ship_PinCode";
                          } else if (value.length < 6) {
                            context.read<SalesQuotationCon>().textError =
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
                        textCapitalization: TextCapitalization.sentences,
                        controller:
                            context.read<SalesQuotationCon>().mycontroller[19],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<SalesQuotationCon>().textError =
                                "Please Enter the Ship_State";
                            return "Please Enter the Ship_State";
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
                        controller:
                            context.read<SalesQuotationCon>().mycontroller[20],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<SalesQuotationCon>().textError =
                                "Please Enter the Ship_Country";
                            return "Please Enter the Ship_Country";
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
            key: context.read<SalesQuotationCon>().formkeyAd,
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
                        context.read<SalesQuotationCon>().mycontroller[7],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        context.read<SalesQuotationCon>().textError =
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
                        context.read<SalesQuotationCon>().mycontroller[8],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        context.read<SalesQuotationCon>().textError =
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
                        context.read<SalesQuotationCon>().mycontroller[9],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        context.read<SalesQuotationCon>().textError =
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
                        controller:
                            context.read<SalesQuotationCon>().mycontroller[10],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<SalesQuotationCon>().textError =
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
                        controller:
                            context.read<SalesQuotationCon>().mycontroller[11],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<SalesQuotationCon>().textError =
                                "Please Enter the Pincode";

                            return "Please Enter the Pincode";
                          } else if (value.length < 6) {
                            context.read<SalesQuotationCon>().textError =
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
                        controller:
                            context.read<SalesQuotationCon>().mycontroller[12],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<SalesQuotationCon>().textError =
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
                        controller:
                            context.read<SalesQuotationCon>().mycontroller[13],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<SalesQuotationCon>().textError =
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
                        value: context.watch<SalesQuotationCon>().checkboxx,
                        onChanged: (val) {
                          st(() {
                            context.read<SalesQuotationCon>().checkboxx = val!;
                            context.read<SalesQuotationCon>().billToShip(val);
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
            key: context.read<SalesQuotationCon>().formkeyShipAd,
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
                        controller:
                            context.read<SalesQuotationCon>().mycontroller[14],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<SalesQuotationCon>().textError =
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
                        controller:
                            context.read<SalesQuotationCon>().mycontroller[15],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<SalesQuotationCon>().textError =
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
                        controller:
                            context.read<SalesQuotationCon>().mycontroller[16],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<SalesQuotationCon>().textError =
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
                        controller:
                            context.read<SalesQuotationCon>().mycontroller[17],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<SalesQuotationCon>().textError =
                                "Please Enter the Ship_City";
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
                        controller:
                            context.read<SalesQuotationCon>().mycontroller[18],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<SalesQuotationCon>().textError =
                                "Please Enter the Ship_PinCode";
                            return "Please Enter the Pincode";
                          } else if (value.length < 6) {
                            context.read<SalesQuotationCon>().textError =
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
                        controller:
                            context.read<SalesQuotationCon>().mycontroller[19],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<SalesQuotationCon>().textError =
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
                        controller:
                            context.read<SalesQuotationCon>().mycontroller[20],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<SalesQuotationCon>().textError =
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
                        value: context.read<SalesQuotationCon>().checkboxx,
                        activeColor: Colors.green,
                        onChanged: (newValue) {
                          st(() {
                            context.read<SalesQuotationCon>().checkboxx =
                                newValue!;
                            context
                                .read<SalesQuotationCon>()
                                .shipToBill(newValue);
                          });
                          const Text('Remember me');
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
