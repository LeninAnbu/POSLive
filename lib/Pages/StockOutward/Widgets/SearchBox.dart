import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:posproject/Constant/AppConstant.dart';
import 'package:posproject/Constant/UserValues.dart';
import 'package:provider/provider.dart';

import '../../../Constant/Screen.dart';
import '../../../Controller/StockOutwardController/StockOutwardController.dart';

class StConSearhBox extends StatefulWidget {
  StConSearhBox({
    super.key,
    required this.theme,
    required this.searchHeight,
    required this.searchWidth,
  });

  final ThemeData theme;
  double searchHeight;
  double searchWidth;

  @override
  State<StConSearhBox> createState() => _StConSearhBoxState();
}

class _StConSearhBoxState extends State<StConSearhBox> {
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
                width: widget.searchWidth * 2.1,
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
                                        .read<StockOutwardController>()
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
                                                        StockOutwardController>()
                                                    .StOutController[100],
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
                                                          StockOutwardController>()
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
                                                        StockOutwardController>()
                                                    .StOutController[101],
                                                onTap: () {
                                                  context
                                                      .read<
                                                          StockOutwardController>()
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
                                            .read<StockOutwardController>()
                                            .formkey[0]
                                            .currentState!
                                            .validate()) {
                                          context
                                              .read<StockOutwardController>()
                                              .callSearchOutApi();
                                          // context
                                          //     .read<StockOutwardController>()
                                          //     .getSalesDataDatewise(
                                          //         context
                                          //             .read<
                                          //                 StockOutwardController>()
                                          //             .StOutController[100]
                                          //             .text
                                          //             .toString(),
                                          //         context
                                          //             .read<
                                          //                 StockOutwardController>()
                                          //             .StOutController[101]
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
                                                  .read<
                                                      StockOutwardController>()
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
                              width: widget.searchWidth * 0.12,
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
                                "Status",
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
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(left: 20, right: 20),
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
                        height: widget.searchHeight * 0.98,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: context
                                .watch<StockOutwardController>()
                                .filtersearchData
                                .isEmpty
                            ? const Center(
                                child: Text("No Data Here..!!"),
                              )
                            : ListView.builder(
                                itemCount: context
                                    .watch<StockOutwardController>()
                                    .filtersearchData
                                    .length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        context
                                            .read<StockOutwardController>()
                                            .searchLoading = true;
                                        context
                                            .read<StockOutwardController>()
                                            .setstatemethod();

                                        context
                                            .read<StockOutwardController>()
                                            .callSearchLine(
                                                context
                                                    .read<
                                                        StockOutwardController>()
                                                    .filtersearchData[index]
                                                    .docEntry
                                                    .toString(),
                                                index);
                                        // context
                                        //     .read<StockOutwardController>()
                                        //     .soCustAddressApi(context
                                        //         .read<StockOutwardController>()
                                        //         .filtersearchData[index]
                                        //         .docEntry
                                        //         .toString());
                                      });

                                      // await context
                                      //     .read<StockOutwardController>()
                                      // .fixDataMethod(context
                                      //     .read<StockOutwardController>()
                                      //     .filtersearchData[index]
                                      //     .docEntry);
                                      // await context
                                      //     .read<StockOutwardController>()
                                      //     .callSerlaySalesQuoAPI(
                                      //         context, widget.theme);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: widget.searchHeight * 0.03,
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
                                            // color: Colors.red,
                                            alignment: Alignment.center,
                                            width: widget.searchWidth * 0.12,
                                            child: Text(
                                              context
                                                  .watch<
                                                      StockOutwardController>()
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
                                            // color: Colors.red,
                                            alignment: Alignment.center,
                                            width: widget.searchWidth * 0.08,
                                            child: Text(
                                              context
                                                  .read<
                                                      StockOutwardController>()
                                                  .config
                                                  .alignDate(context
                                                      .read<
                                                          StockOutwardController>()
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
                                            width: widget.searchWidth * 0.1,
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
                                          //     "${config.alignDateT(context.watch<StockOutwardController>().filtersearchData[index].docDate)}",
                                          //     style: widget
                                          //         .theme.textTheme.bodyMedium!
                                          //         .copyWith(
                                          //             color: Colors.black),
                                          //   ),
                                          // ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: widget.searchWidth * 0.1,
                                            child: Text(
                                              context
                                                  .watch<
                                                      StockOutwardController>()
                                                  .filtersearchData[index]
                                                  .docStatus,
                                              style: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: widget.searchWidth * 0.15,
                                            child: Text(
                                              context
                                                  .watch<
                                                      StockOutwardController>()
                                                  .filtersearchData[index]
                                                  .cardName,
                                              style: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            padding: EdgeInsets.only(right: 15),
                                            width: widget.searchWidth * 0.15,
                                            child: Text(
                                              context
                                                  .watch<
                                                      StockOutwardController>()
                                                  .filtersearchData[index]
                                                  .docTotal
                                                  .toString(),
                                              style: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ),

                                          // Container(
                                          //   padding: EdgeInsets.only(
                                          //     right: widget.searchHeight * 0.02,
                                          //   ),
                                          //   alignment: Alignment.centerRight,
                                          //   width: widget.searchWidth * 0.11,
                                          //   child: Text(
                                          //     "${context.watch<StockOutwardController>().filtersearchData[index].doctotal}",
                                          //     style: widget
                                          //         .theme.textTheme.bodyLarge!
                                          //         .copyWith(color: Colors.black),
                                          //   ),
                                          // ),
                                          // Container(
                                          //   alignment: Alignment.center,
                                          //   width: widget.searchWidth * 0.1,
                                          //   child: Text(
                                          //     "${context.watch<StockOutwardController>().filtersearchData[index].type}",
                                          //     style: widget
                                          //         .theme.textTheme.bodyLarge!
                                          //         .copyWith(color: Colors.black),
                                          //   ),
                                          // ),
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
          visible: context.read<StockOutwardController>().searchLoading,
          child: Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.91,
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
