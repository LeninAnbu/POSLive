import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:posproject/Pages/StockOutward/Widgets/OutwardItem.dart';
import 'package:posproject/Pages/StockOutward/Widgets/StockOutreqlist.dart';
import 'package:provider/provider.dart';
import '../../../../Constant/Screen.dart';
import '../../../../Controller/StockOutwardController/StockOutwardController.dart';
import '../../../../Widgets/AlertBox.dart';

class StockOutTab extends StatefulWidget {
  const StockOutTab({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  State<StockOutTab> createState() => _StockOutTabState();
}

class _StockOutTabState extends State<StockOutTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
              color: Colors.grey.withOpacity(0.05),
              padding: EdgeInsets.only(
                top: Screens.bodyheight(context) * 0.02,
                left: Screens.bodyheight(context) * 0.01,
                right: Screens.bodyheight(context) * 0.01,
                bottom: Screens.bodyheight(context) * 0.01,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StockOutReqList(
                    theme: widget.theme,
                    searchHeight: Screens.bodyheight(context) * 0.87,
                    searchWidth: Screens.width(context) * 0.5,
                  ),
                  SizedBox(
                      width: Screens.width(context) * 0.48,
                      child: Column(
                        children: [
                          context
                                      .watch<StockOutwardController>()
                                      .selectedcust2 !=
                                  null
                              ? Container()
                              : Container(
                                  height: Screens.padingHeight(context) * 0.07,
                                  width: Screens.width(context) * 1,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 240, 235, 235)),
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colors.grey.withOpacity(0.001),
                                  ),
                                  child: TextFormField(
                                    onChanged: (v) {},
                                    readOnly: true,
                                    onTap: () {
                                      context
                                          .read<StockOutwardController>()
                                          .searchcontroller
                                          .text = '';
                                      context
                                          .read<StockOutwardController>()
                                          .refresCufstList();

                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                contentPadding:
                                                    const EdgeInsets.all(0),
                                                content: AlertBox(
                                                  payMent: 'Select Customer',
                                                  widget:
                                                      forSearchCustBtn(context),
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
                                      hintStyle: widget
                                          .theme.textTheme.bodyLarge
                                          ?.copyWith(),
                                      filled: false,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 15,
                                        horizontal: 10,
                                      ),
                                    ),
                                  ),
                                ),
                          context
                                      .read<StockOutwardController>()
                                      .selectedcust2 !=
                                  null
                              ? Container(
                                  padding: EdgeInsets.all(5),
                                  color: Colors.grey[300],
                                  width: Screens.width(context) * 0.49,
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
                                              width:
                                                  Screens.width(context) * 0.39,
                                              child: Text(
                                                context
                                                            .watch<
                                                                StockOutwardController>()
                                                            .selectedcust2 !=
                                                        null
                                                    ? context
                                                        .watch<
                                                            StockOutwardController>()
                                                        .selectedcust2!
                                                        .name!
                                                    : '',
                                                style: widget
                                                    .theme.textTheme.titleMedium
                                                    ?.copyWith(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
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
                                                                        StockOutwardController>()
                                                                    .selectedcust2 !=
                                                                null &&
                                                            context
                                                                .read<
                                                                    StockOutwardController>()
                                                                .selectedcust2!
                                                                .phNo!
                                                                .isNotEmpty
                                                        ? "${context.watch<StockOutwardController>().selectedcust2!.phNo}  |  "
                                                        : '',
                                                    style: widget.theme
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
                                                                        StockOutwardController>()
                                                                    .selectedcust2 !=
                                                                null &&
                                                            context
                                                                .watch<
                                                                    StockOutwardController>()
                                                                .selectedcust2!
                                                                .email!
                                                                .isNotEmpty
                                                        ? " ${context.watch<StockOutwardController>().selectedcust2!.email}"
                                                        : "",
                                                    style: widget.theme
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
                                        height: Screens.padingHeight(context) *
                                            0.02,
                                      ),
                                      SizedBox(
                                        width: Screens.width(context) * 0.465,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Card Code",
                                                style: widget
                                                    .theme.textTheme.bodyLarge
                                                    ?.copyWith(
                                                        color: Colors.black54)),
                                            Container(
                                              padding: EdgeInsets.only(
                                                right: Screens.padingHeight(
                                                        context) *
                                                    0.02,
                                              ),
                                              child: Text(
                                                  "${context.watch<StockOutwardController>().selectedcust2!.cardCode}",
                                                  style: widget
                                                      .theme.textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color:
                                                              Colors.black54)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        width: Screens.width(context) * 0.465,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Balance",
                                                style: widget
                                                    .theme.textTheme.bodyLarge
                                                    ?.copyWith(
                                                        color: Colors.black54)),
                                            Text(
                                                context
                                                                .watch<
                                                                    StockOutwardController>()
                                                                .selectedcust2 !=
                                                            null &&
                                                        (context
                                                                    .watch<
                                                                        StockOutwardController>()
                                                                    .selectedcust2!
                                                                    .accBalance !=
                                                                null ||
                                                            context
                                                                    .watch<
                                                                        StockOutwardController>()
                                                                    .selectedcust2!
                                                                    .accBalance !=
                                                                0)
                                                    ? context
                                                        .watch<
                                                            StockOutwardController>()
                                                        .config
                                                        .splitValues(context
                                                            .watch<
                                                                StockOutwardController>()
                                                            .selectedcust2!
                                                            .accBalance
                                                            .toString())
                                                    : '0.00',
                                                style: widget
                                                    .theme.textTheme.bodyLarge
                                                    ?.copyWith(
                                                        color: Colors.black54)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : context
                                          .read<StockOutwardController>()
                                          .selectedcust !=
                                      null
                                  ? Container(
                                      padding: EdgeInsets.all(5),
                                      color: Colors.grey[50],
                                      width: Screens.width(context) * 0.49,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width:
                                                      Screens.width(context) *
                                                          0.39,
                                                  child: Text(
                                                    context
                                                                .watch<
                                                                    StockOutwardController>()
                                                                .selectedcust !=
                                                            null
                                                        ? context
                                                            .watch<
                                                                StockOutwardController>()
                                                            .selectedcust!
                                                            .name!
                                                        : '',
                                                    style: widget.theme
                                                        .textTheme.titleMedium
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
                                                              .read<
                                                                  StockOutwardController>()
                                                              .selectedcust = null;
                                                        });
                                                      },
                                                      icon: Icon(Icons.close)),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
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
                                                                            StockOutwardController>()
                                                                        .selectedcust !=
                                                                    null &&
                                                                context
                                                                    .read<
                                                                        StockOutwardController>()
                                                                    .selectedcust!
                                                                    .phNo!
                                                                    .isNotEmpty
                                                            ? "${context.watch<StockOutwardController>().selectedcust!.phNo}  |  "
                                                            : '',
                                                        style: widget.theme
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
                                                                            StockOutwardController>()
                                                                        .selectedcust !=
                                                                    null &&
                                                                context
                                                                    .watch<
                                                                        StockOutwardController>()
                                                                    .selectedcust!
                                                                    .email!
                                                                    .isNotEmpty
                                                            ? " ${context.watch<StockOutwardController>().selectedcust!.email}"
                                                            : "",
                                                        style: widget.theme
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
                                            height:
                                                Screens.padingHeight(context) *
                                                    0.02,
                                          ),
                                          SizedBox(
                                            width:
                                                Screens.width(context) * 0.465,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Card Code",
                                                    style: widget.theme
                                                        .textTheme.bodyLarge
                                                        ?.copyWith(
                                                            color: Colors
                                                                .black54)),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    right: Screens.padingHeight(
                                                            context) *
                                                        0.02,
                                                  ),
                                                  child: Text(
                                                      "${context.watch<StockOutwardController>().selectedcust!.cardCode}",
                                                      style: widget.theme
                                                          .textTheme.bodyLarge
                                                          ?.copyWith(
                                                              color: Colors
                                                                  .black54)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            width:
                                                Screens.width(context) * 0.465,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Balance",
                                                    style: widget.theme
                                                        .textTheme.bodyLarge
                                                        ?.copyWith(
                                                            color: Colors
                                                                .black54)),
                                                Text(
                                                    context
                                                                    .watch<
                                                                        StockOutwardController>()
                                                                    .selectedcust !=
                                                                null &&
                                                            (context
                                                                        .watch<
                                                                            StockOutwardController>()
                                                                        .selectedcust!
                                                                        .accBalance !=
                                                                    null ||
                                                                context
                                                                        .watch<
                                                                            StockOutwardController>()
                                                                        .selectedcust!
                                                                        .accBalance !=
                                                                    0)
                                                        ? context
                                                            .watch<
                                                                StockOutwardController>()
                                                            .config
                                                            .splitValues(context
                                                                .watch<
                                                                    StockOutwardController>()
                                                                .selectedcust!
                                                                .accBalance
                                                                .toString())
                                                        : '0.00',
                                                    style: widget.theme
                                                        .textTheme.bodyLarge
                                                        ?.copyWith(
                                                            color: Colors
                                                                .black54)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                          SizedBox(
                            height: Screens.padingHeight(context) * 0.01,
                          ),
                          stockOutward(
                              widget.theme,
                              Screens.width(context) * 0.4,
                              Screens.bodyheight(context) * 0.61,
                              context
                                  .watch<StockOutwardController>()
                                  .get_i_value,
                              context.watch<StockOutwardController>().passdata,
                              context
                                  .watch<StockOutwardController>()
                                  .StockOutward,
                              context),
                        ],
                      )),
                ],
              )),
          Visibility(
            visible: context.watch<StockOutwardController>().OnclickDisable!,
            child: Container(
              width: Screens.width(context),
              height: Screens.bodyheight(context) * 0.95,
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
                    context.read<StockOutwardController>().searchcontroller,
                cursorColor: Colors.grey,
                autofocus: true,
                onChanged: (v) {
                  st(() {
                    context.read<StockOutwardController>().filterCustList(v);
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
                        .read<StockOutwardController>()
                        .getfiltercustList
                        .length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          padding: EdgeInsets.only(
                              top: Screens.padingHeight(context) * 0.01,
                              bottom: Screens.padingHeight(context) * 0.01),
                          child: StatefulBuilder(builder: (context, st) {
                            return ListTile(
                              onTap: () async {
                                Get.back();
                                context
                                    .read<StockOutwardController>()
                                    .custSelected(
                                        context
                                            .read<StockOutwardController>()
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
                                          .watch<StockOutwardController>()
                                          .getfiltercustList[index]
                                          .cardCode!),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: Screens.width(context) * 0.32,
                                        child: Text(
                                          context
                                              .watch<StockOutwardController>()
                                              .getfiltercustList[index]
                                              .name!,
                                          maxLines: 2,
                                        ),
                                      ),
                                      Container(
                                        width: Screens.width(context) * 0.1,
                                        child: Text(context
                                            .watch<StockOutwardController>()
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
}
