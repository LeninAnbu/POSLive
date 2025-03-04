import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:posproject/Constant/AppConstant.dart';
import 'package:posproject/Constant/UserValues.dart';
import 'package:provider/provider.dart';

import '../../../Constant/Screen.dart';
import '../../../Controller/PaymentReceiptController/PayReceiptController.dart';

class PaymentRecieptSearhBox extends StatefulWidget {
  PaymentRecieptSearhBox({
    super.key,
    required this.theme,
    required this.searchHeight,
    required this.searchWidth,
  });

  final ThemeData theme;
  double searchHeight;
  double searchWidth;

  @override
  State<PaymentRecieptSearhBox> createState() => _PaymentRecieptSearhBoxState();
}

class _PaymentRecieptSearhBoxState extends State<PaymentRecieptSearhBox> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AlertDialog(
            insetPadding: const EdgeInsets.all(10),
            contentPadding: const EdgeInsets.all(0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            content: SizedBox(
                width: widget.searchWidth * 2,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          width: widget.searchWidth,
                          padding: EdgeInsets.all(widget.searchHeight * 0.01),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Form(
                                    key: context
                                        .read<PayreceiptController>()
                                        .formkey[0],
                                    child: Row(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              width: widget.searchWidth * 0.08,
                                              child: const Text("From Date"),
                                            ),
                                            Container(
                                              height:
                                                  widget.searchHeight * 0.07,
                                              width: widget.searchWidth * 0.15,
                                              decoration: const BoxDecoration(),
                                              child: TextFormField(
                                                controller: context
                                                    .read<
                                                        PayreceiptController>()
                                                    .mycontroller[100],
                                                readOnly: true,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Required";
                                                  }
                                                  null;
                                                  return null;
                                                },
                                                onTap: () {
                                                  context
                                                      .read<
                                                          PayreceiptController>()
                                                      .getDate2(
                                                          context, 'From');
                                                },
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            vertical: 5.0,
                                                            horizontal: 5.0),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                    hintText: "",
                                                    hintStyle: widget.theme
                                                        .textTheme.bodyLarge!
                                                        .copyWith(
                                                            color:
                                                                Colors.black),
                                                    suffixIcon: const Icon(
                                                        Icons.calendar_today)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              width: widget.searchWidth * 0.08,
                                              child: const Text("To Date"),
                                            ),
                                            Container(
                                              height:
                                                  widget.searchHeight * 0.07,
                                              width: widget.searchWidth * 0.15,
                                              decoration: const BoxDecoration(),
                                              child: TextFormField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Required";
                                                  }
                                                  null;
                                                  return null;
                                                },
                                                readOnly: true,
                                                controller: context
                                                    .read<
                                                        PayreceiptController>()
                                                    .mycontroller[101],
                                                onTap: () {
                                                  context
                                                      .read<
                                                          PayreceiptController>()
                                                      .getDate2(context, 'To');
                                                },
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            vertical: 5.0,
                                                            horizontal: 5.0),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                    hintText: "",
                                                    hintStyle: widget.theme
                                                        .textTheme.bodyLarge!
                                                        .copyWith(
                                                            color:
                                                                Colors.black),
                                                    suffixIcon: const Icon(
                                                        Icons.calendar_today)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (context
                                            .read<PayreceiptController>()
                                            .formkey[0]
                                            .currentState!
                                            .validate()) {
                                          context
                                              .read<PayreceiptController>()
                                              .callSearchHeaderApi();
                                          // context
                                          //     .read<PayreceiptController>()
                                          //     .getSalesDataDatewise(
                                          //         context
                                          //             .read<PayreceiptController>()
                                          //             .mycontroller[100]
                                          //             .text
                                          //             .toString(),
                                          //         context
                                          //             .read<PayreceiptController>()
                                          //             .mycontroller[101]
                                          //             .text
                                          //             .toString());
                                        }
                                      });
                                    },
                                    child: Container(
                                      height: widget.searchHeight * 0.07,
                                      width: widget.searchWidth * 0.08,
                                      decoration: BoxDecoration(
                                          color: widget.theme.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: const Icon(
                                        Icons.search,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: widget.searchHeight * 0.07,
                                        width: widget.searchWidth * 0.3,
                                        decoration: const BoxDecoration(),
                                        child: TextFormField(
                                          onChanged: (value) {
                                            setState(() {
                                              context
                                                  .read<PayreceiptController>()
                                                  .filterSearchBoxList(
                                                      value.trim());
                                            });
                                          },
                                          decoration: InputDecoration(
                                              hintText: "Search...",
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 10.0),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              hintStyle: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: Colors.black)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: widget.searchHeight * 0.01,
                              ),
                            ],
                          )),
                      Container(
                        decoration: BoxDecoration(
                            color: widget.theme.primaryColor,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.white)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.08,
                              child: Text(
                                "Doc No",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.1,
                              child: Text(
                                "Doc Date",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.08,
                              child: Text(
                                "UserName",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.1,
                              child: Text(
                                "Terminal",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            // Container(
                            //   alignment: Alignment.center,
                            //   width: widget.searchWidth * 0.08,
                            //   child: Text(
                            //     "SAP DocNo",
                            //     style: widget.theme.textTheme.bodyMedium!
                            //         .copyWith(color: Colors.white),
                            //   ),
                            // ),
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.1,
                              child: Text(
                                "Customer Code",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.15,
                              child: Text(
                                "Customer Name",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  right: Screens.width(context) * 0.02,
                                  left: Screens.width(context) * 0.03),
                              alignment: Alignment.centerRight,
                              width: widget.searchWidth * 0.15,
                              child: Text(
                                "Doc Total ",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: widget.searchHeight,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: context
                                .watch<PayreceiptController>()
                                .filtersearchData
                                .isEmpty
                            ? const Center(
                                child: Text("No Data Here..!!"),
                              )
                            : ListView.builder(
                                itemCount: context
                                    .watch<PayreceiptController>()
                                    .filtersearchData
                                    .length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () async {
                                      context
                                          .read<PayreceiptController>()
                                          .loadSearch = true;
                                      context
                                          .read<PayreceiptController>()
                                          .setstate1();

                                      await context
                                          .read<PayreceiptController>()
                                          .getReceiptApi(
                                              context
                                                  .read<PayreceiptController>()
                                                  .filtersearchData[index]
                                                  .docEntry
                                                  .toString(),
                                              context,
                                              widget.theme);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: widget.searchHeight * 0.03,
                                          left: widget.searchHeight * 0.01,
                                          bottom: widget.searchHeight * 0.03),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.05),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.grey[300]!)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            width: widget.searchWidth * 0.08,
                                            child: Text(
                                              context
                                                  .read<PayreceiptController>()
                                                  .filtersearchData[index]
                                                  .docNum
                                                  .toString(),
                                              style: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: widget.searchWidth * 0.1,
                                            child: Text(
                                              context
                                                  .read<PayreceiptController>()
                                                  .config
                                                  .alignDate(context
                                                      .read<
                                                          PayreceiptController>()
                                                      .filtersearchData[index]
                                                      .docDate),
                                              style: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: widget.searchWidth * 0.08,
                                            child: Text(
                                              "${UserValues.username}",
                                              style: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: widget.searchWidth * 0.1,
                                            child: Text(
                                              "${AppConstant.terminal}",
                                              style: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ),
                                          // Container(
                                          //   alignment: Alignment.center,
                                          //   width: widget.searchWidth * 0.08,
                                          //   child: Text(
                                          //     context
                                          //         .watch<PayreceiptController>()
                                          //         .filtersearchData[index]
                                          //         .docStatus!,
                                          //     style: widget
                                          //         .theme.textTheme.bodyLarge!
                                          //         .copyWith(
                                          //             color: Colors.black),
                                          //   ),
                                          // ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: widget.searchWidth * 0.08,
                                            child: Text(
                                              "${context.watch<PayreceiptController>().filtersearchData[index].cardCode}",
                                              style: widget
                                                  .theme.textTheme.bodyMedium!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: widget.searchWidth * 0.15,
                                            child: Text(
                                              context
                                                  .watch<PayreceiptController>()
                                                  .filtersearchData[index]
                                                  .cardName,
                                              style: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                right: Screens.width(context) *
                                                    0.013),
                                            alignment: Alignment.centerRight,
                                            width: widget.searchWidth * 0.15,
                                            child: Text(
                                              context
                                                  .watch<PayreceiptController>()
                                                  .config
                                                  .splitValues(context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .filtersearchData[index]
                                                      .docTotal
                                                      .toString()),
                                              style: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                      )
                    ],
                  ),
                ))),
        Visibility(
          visible: context.watch<PayreceiptController>().loadSearch,
          child: Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.88,
            color: Colors.white60,
            child: Center(
              child: SpinKitFadingCircle(
                size: Screens.bodyheight(context) * 0.08,
                color: widget.theme.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
