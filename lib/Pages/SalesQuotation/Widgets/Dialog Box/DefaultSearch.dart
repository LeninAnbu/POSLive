import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:posproject/Constant/AppConstant.dart';
import 'package:posproject/Constant/UserValues.dart';
import 'package:provider/provider.dart';
import '../../../../Constant/Screen.dart';
import '../../../../Controller/SalesQuotationController/SalesQuotationController.dart';

class SearhBoxSQ extends StatefulWidget {
  SearhBoxSQ({
    super.key,
    required this.theme,
    required this.searchHeight,
    required this.searchWidth,
  });

  final ThemeData theme;
  double searchHeight;
  double searchWidth;

  @override
  State<SearhBoxSQ> createState() => SearhBoxState();
}

class SearhBoxState extends State<SearhBoxSQ> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AlertDialog(
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            content: SizedBox(
                width: widget.searchWidth * 2,
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        width: widget.searchWidth,
                        padding: EdgeInsets.all(widget.searchHeight * 0.01),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Form(
                                  key: context
                                      .read<SalesQuotationCon>()
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
                                            height: widget.searchHeight * 0.07,
                                            width: widget.searchWidth * 0.15,
                                            decoration: const BoxDecoration(),
                                            child: TextFormField(
                                              controller: context
                                                  .read<SalesQuotationCon>()
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
                                                    .read<SalesQuotationCon>()
                                                    .getDate2(context, 'From');
                                              },
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          vertical: 5.0,
                                                          horizontal: 5.0),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  hintText: "",
                                                  hintStyle: widget.theme
                                                      .textTheme.bodyLarge!
                                                      .copyWith(
                                                          color: Colors.black),
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
                                            height: widget.searchHeight * 0.07,
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
                                                  .read<SalesQuotationCon>()
                                                  .mycontroller[101],
                                              onTap: () {
                                                context
                                                    .read<SalesQuotationCon>()
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
                                                          BorderRadius.circular(
                                                              4)),
                                                  hintText: "",
                                                  hintStyle: widget.theme
                                                      .textTheme.bodyLarge!
                                                      .copyWith(
                                                          color: Colors.black),
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
                                          .read<SalesQuotationCon>()
                                          .formkey[0]
                                          .currentState!
                                          .validate()) {
                                        context
                                            .read<SalesQuotationCon>()
                                            .callSearchHeaderApi();
                                      }
                                    });
                                  },
                                  child: Container(
                                    height: widget.searchHeight * 0.07,
                                    width: widget.searchWidth * 0.08,
                                    decoration: BoxDecoration(
                                        color: widget.theme.primaryColor,
                                        borderRadius: BorderRadius.circular(5)),
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
                                                .read<SalesQuotationCon>()
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
                                                .copyWith(color: Colors.black)),
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
                      padding: EdgeInsets.only(
                        right: widget.searchWidth * 0.01,
                        left: widget.searchWidth * 0.01,
                      ),
                      decoration: BoxDecoration(
                          color: widget.theme.primaryColor,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.white)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            width: widget.searchWidth * 0.1,
                            child: Text(
                              "Doc No",
                              style: widget.theme.textTheme.bodyLarge!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: widget.searchWidth * 0.08,
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
                          Container(
                            alignment: Alignment.center,
                            width: widget.searchWidth * 0.12,
                            child: Text(
                              "Status",
                              style: widget.theme.textTheme.bodyLarge!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: widget.searchWidth * 0.1,
                            child: Text(
                              "Customer Code",
                              style: widget.theme.textTheme.bodyMedium!
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
                            width: widget.searchWidth * 0.12,
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
                      height: widget.searchHeight * 0.87,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: context
                              .watch<SalesQuotationCon>()
                              .filtersearchData
                              .isEmpty
                          ? const Center(
                              child: Text("No Data Here ..!!"),
                            )
                          : ListView.builder(
                              itemCount: context
                                  .read<SalesQuotationCon>()
                                  .filtersearchData
                                  .length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: context
                                              .read<SalesQuotationCon>()
                                              .searchmapbool ==
                                          true
                                      ? null
                                      : () async {
                                          await context
                                              .read<SalesQuotationCon>()
                                              .getQuotApi(
                                                  context
                                                      .read<SalesQuotationCon>()
                                                      .filtersearchData[index]
                                                      .docEntry
                                                      .toString(),
                                                  context,
                                                  widget.theme);
                                          await context
                                              .read<SalesQuotationCon>()
                                              .getQuotDetails(
                                                context
                                                    .read<SalesQuotationCon>()
                                                    .filtersearchData[index]
                                                    .docEntry
                                                    .toString(),
                                                context,
                                              );
                                          await context
                                              .read<SalesQuotationCon>()
                                              .soCustAddressApi(
                                                context
                                                    .read<SalesQuotationCon>()
                                                    .filtersearchData[index]
                                                    .docEntry
                                                    .toString(),
                                              );
                                          // context
                                          //     .read<SalesQuotationCon>()
                                          //     .fixDataMethod(
                                          // context
                                          //     .read<SalesQuotationCon>()
                                          //     .filtersearchData[index]
                                          //     .docEntry,
                                          //         context,
                                          //         widget.theme);
                                          Get.back();
                                          // Navigator.pop(context);
                                        },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top: widget.searchHeight * 0.02,
                                        right: widget.searchHeight * 0.01,
                                        bottom: widget.searchHeight * 0.02),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.05),
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.grey[300]!)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          width: widget.searchWidth * 0.1,
                                          child: Text(
                                            context
                                                .watch<SalesQuotationCon>()
                                                .filtersearchData[index]
                                                .docNum
                                                .toString(),
                                            style: widget
                                                .theme.textTheme.bodyLarge!
                                                .copyWith(color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: widget.searchWidth * 0.08,
                                          child: Text(
                                            context
                                                .watch<SalesQuotationCon>()
                                                .config
                                                .alignDate(context
                                                    .read<SalesQuotationCon>()
                                                    .filtersearchData[index]
                                                    .docDate),
                                            style: widget
                                                .theme.textTheme.bodyLarge!
                                                .copyWith(color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: widget.searchWidth * 0.08,
                                          child: Text(
                                            "${UserValues.username}",
                                            style: widget
                                                .theme.textTheme.bodyLarge!
                                                .copyWith(color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: widget.searchWidth * 0.1,
                                          child: Text(
                                            "${AppConstant.terminal}",
                                            style: widget
                                                .theme.textTheme.bodyLarge!
                                                .copyWith(color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: widget.searchWidth * 0.14,
                                          child: Text(
                                            context
                                                .watch<SalesQuotationCon>()
                                                .filtersearchData[index]
                                                .docStatus
                                                .toString(),
                                            style: widget
                                                .theme.textTheme.bodyLarge!
                                                .copyWith(color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          // color: Colors.red,
                                          alignment: Alignment.center,
                                          width: widget.searchWidth * 0.1,
                                          child: Text(
                                            "${context.watch<SalesQuotationCon>().filtersearchData[index].cardCode}",
                                            style: widget
                                                .theme.textTheme.bodyLarge!
                                                .copyWith(color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          // color: Colors.red,
                                          alignment: Alignment.center,
                                          width: widget.searchWidth * 0.15,
                                          child: Text(
                                            context
                                                .watch<SalesQuotationCon>()
                                                .filtersearchData[index]
                                                .cardName,
                                            style: widget
                                                .theme.textTheme.bodyLarge!
                                                .copyWith(color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: widget.searchWidth * 0.12,
                                          child: Text(
                                            context
                                                .watch<SalesQuotationCon>()
                                                .config
                                                .splitValues(context
                                                    .watch<SalesQuotationCon>()
                                                    .filtersearchData[index]
                                                    .docTotal
                                                    .toString()),
                                            style: widget
                                                .theme.textTheme.bodyLarge!
                                                .copyWith(color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                    )
                  ],
                ))),
        // context.read<SalesQuotationCon>().loadSearch == true
        //     ? Container(
        //         height: Screens.bodyheight(context) * 0.85,
        //         child: Center(child: CircularProgressIndicator()))
        //     : Container(),
        Visibility(
          visible: context.watch<SalesQuotationCon>().loadSearch,
          child: Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.85,
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
