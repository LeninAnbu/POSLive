import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Controller/StockRequestController/StockRequestController.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/ContentContainer.dart';
import '../../../Widgets/AlertBox.dart';
import '../../SalesQuotation/Widgets/ItemLists.dart';
import '../Screens/StockMobile/Widgets/SearchItems.dart';

class RequestItem extends StatefulWidget {
  RequestItem(
      {super.key,
      required this.theme,
      required this.searchHeight,
      required this.searchWidth});

  final ThemeData theme;
  double searchHeight;
  double searchWidth;

  @override
  State<RequestItem> createState() => _RequestItemState();
}

class _RequestItemState extends State<RequestItem> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          context.watch<StockReqController>().getScanneditemData2.isEmpty
              ? Container(
                  alignment: Alignment.center,
                  width: widget.searchWidth * 1,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 240, 235, 235)),
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    focusNode: context.watch<StockReqController>().inven,
                    style: theme.textTheme.bodyMedium,
                    cursorColor: Colors.grey,
                    onChanged: (v) {
                      setState(() {
                        if (v.isNotEmpty &&
                            context
                                .read<StockReqController>()
                                .searchcon
                                .text
                                .isNotEmpty) {
                          context.read<StockReqController>().visibleItemList =
                              true;
                          context.read<StockReqController>().getAllList(context
                              .read<StockReqController>()
                              .searchcon
                              .text
                              .trim());
                        } else {
                          context.read<StockReqController>().visibleItemList =
                              false;
                        }
                      });
                    },
                    controller: context.watch<StockReqController>().searchcon,
                    onEditingComplete: () {
                      context
                          .read<StockReqController>()
                          .disableKeyBoard(context);
                    },
                    decoration: InputDecoration(
                      hintText: 'Inventories',
                      hintStyle: theme.textTheme.bodyLarge?.copyWith(),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            context
                                .read<StockReqController>()
                                .getAllList(context
                                    .read<StockReqController>()
                                    .searchcon
                                    .text
                                    .trim())
                                .then((value) {
                              if (value.length == 1) {
                                context.read<StockReqController>().onseletFst(
                                    context,
                                    theme,
                                    context
                                        .read<StockReqController>()
                                        .getfilterSearchedData[0]);
                              } else {
                                if (context
                                        .read<StockReqController>()
                                        .whssSlectedList ==
                                    null) {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            content: AlertBox(
                                              payMent: 'Alert',
                                              errormsg: true,
                                              widget: Center(
                                                  child: ContentContainer(
                                                content:
                                                    'Choose warehuse address..!!',
                                                theme: theme,
                                              )),
                                              buttonName: null,
                                            ));
                                      });
                                } else {
                                  showDialog<dynamic>(
                                      context: context,
                                      builder: (_) {
                                        return const SearchItems();
                                      });
                                }
                              }
                            });
                          });
                          context
                              .read<StockReqController>()
                              .disableKeyBoard(context);
                        },
                        color: theme.primaryColor,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 10,
                      ),
                    ),
                  ))
              : Container(),
          SizedBox(
            height: widget.searchHeight * 0.01,
          ),
          Container(
            padding: EdgeInsets.only(
              top: widget.searchHeight * 0.02,
              left: widget.searchHeight * 0.01,
              right: widget.searchWidth * 0.02,
              bottom: widget.searchHeight * 0.01,
            ),
            decoration: BoxDecoration(
              color: theme.primaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.only(
                      left: widget.searchHeight * 0.01,
                    ),
                    alignment: Alignment.centerLeft,
                    width: widget.searchWidth * 0.55,
                    child: Text(
                      "Product Information",
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: Colors.white),
                    )),
                Container(
                    alignment: Alignment.center,
                    width: widget.searchWidth * 0.2,
                    child: Text(
                      "Quantity",
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: Colors.white),
                    )),
              ],
            ),
          ),
          Visibility(
              visible: context.watch<StockReqController>().visibleItemList,
              child: Container(
                height: widget.searchHeight * 0.6,
                child: ListView.builder(
                    itemCount: context
                        .read<StockReqController>()
                        .getfilterSearchedData
                        .length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            context
                                .read<StockReqController>()
                                .onselectVisibleItem(
                                    context,
                                    theme,
                                    context
                                        .read<StockReqController>()
                                        .getfilterSearchedData[index]);
                            context.read<StockReqController>().visibleItemList =
                                false;
                          });
                        },
                        child: Card(
                          child: Container(
                              width: Screens.bodyheight(context) * 0.8,
                              padding: EdgeInsets.only(
                                left: Screens.width(context) * 0.01,
                                right: Screens.width(context) * 0.01,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                              ),
                              child: IntrinsicHeight(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${context.watch<StockReqController>().getfilterSearchedData[index].itemcode}"),
                                    Text(
                                        "${context.watch<StockReqController>().getfilterSearchedData[index].itemnameshort}"),
                                  ],
                                ),
                              )),
                        ),
                      );
                    }),
              )),
          Expanded(
              child: context
                          .watch<StockReqController>()
                          .getScanneditemData2
                          .isNotEmpty &&
                      context.read<StockReqController>().visibleItemList ==
                          false
                  ? ListView.builder(
                      itemCount: context
                          .watch<StockReqController>()
                          .getScanneditemData2
                          .length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Container(
                              padding: EdgeInsets.only(
                                top: widget.searchHeight * 0.01,
                                left: widget.searchHeight * 0.01,
                                right: widget.searchHeight * 0.01,
                                bottom: widget.searchHeight * 0.02,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey[300],
                              ),
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            width: widget.searchWidth * 0.7,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "${context.watch<StockReqController>().getScanneditemData2[index].itemName}",
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black),
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      width: widget.searchWidth * 0.2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    widget.searchWidth * 0.005),
                                            child: Text(
                                                "${context.watch<StockReqController>().getScanneditemData2[index].openRetQty}",
                                                style: theme
                                                    .textTheme.bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.black)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: widget.searchHeight * 0.01,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      width: Screens.width(context) * 0.12,
                                      child: Text(
                                        "${context.watch<StockReqController>().getScanneditemData2[index].itemCode}",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(),
                                      ),
                                    ),
                                  ],
                                )
                              ])),
                        );
                      })
                  : (context.watch<StockReqController>().loadShelfReqbool ==
                              true &&
                          context
                              .watch<StockReqController>()
                              .loadShelfReqmsg!
                              .isNotEmpty &&
                          context
                              .watch<StockReqController>()
                              .scanneditemData
                              .isEmpty)
                      ? Center(
                          child: Text(
                              "${context.watch<StockReqController>().loadShelfReqmsg}"),
                        )
                      : (context
                                      .watch<StockReqController>()
                                      .loadLastSoldItemsbool ==
                                  true &&
                              context
                                  .watch<StockReqController>()
                                  .loadLastSoldItemsmsg!
                                  .isNotEmpty &&
                              context
                                  .watch<StockReqController>()
                                  .scanneditemData
                                  .isEmpty)
                          ? Center(
                              child: Text(
                                  "${context.watch<StockReqController>().loadLastSoldItemsmsg}"),
                            )
                          : (context
                                          .watch<StockReqController>()
                                          .loadMiniMaxbool ==
                                      true &&
                                  context
                                      .watch<StockReqController>()
                                      .loadMiniMaxmsg!
                                      .isNotEmpty &&
                                  context
                                      .watch<StockReqController>()
                                      .scanneditemData
                                      .isEmpty)
                              ? Center(
                                  child: Text(
                                      "${context.watch<StockReqController>().loadMiniMaxmsg}"),
                                )
                              : ListView.builder(
                                  itemCount: context
                                      .watch<StockReqController>()
                                      .getScanneditemData
                                      .length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: Container(
                                          padding: EdgeInsets.only(
                                            left: widget.searchHeight * 0.01,
                                            right: widget.searchHeight * 0.01,
                                            bottom: widget.searchHeight * 0.01,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.grey.withOpacity(0.04),
                                          ),
                                          child: Column(children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        width:
                                                            widget.searchWidth *
                                                                0.7,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "${context.watch<StockReqController>().getScanneditemData[index].itemName}",
                                                          style: theme.textTheme
                                                              .bodyLarge
                                                              ?.copyWith(
                                                                  color: Colors
                                                                      .black),
                                                        )),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width:
                                                      widget.searchWidth * 0.2,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Container(
                                                          width: Screens.width(
                                                                  context) *
                                                              0.06,
                                                          height: Screens
                                                                  .padingHeight(
                                                                      context) *
                                                              0.05,
                                                          alignment:
                                                              Alignment.center,
                                                          child: TextFormField(
                                                            autofocus: true,
                                                            style: theme
                                                                .textTheme
                                                                .bodyMedium,
                                                            onChanged:
                                                                ((value) {
                                                              context
                                                                  .read<
                                                                      StockReqController>()
                                                                  .doubleDotMethod(
                                                                      index,
                                                                      value);
                                                            }),
                                                            onTap: () {
                                                              context
                                                                      .read<
                                                                          StockReqController>()
                                                                      .qtyCont[
                                                                          index]
                                                                      .text =
                                                                  context
                                                                      .read<
                                                                          StockReqController>()
                                                                      .qtyCont[
                                                                          index]
                                                                      .text;
                                                              context
                                                                      .read<
                                                                          StockReqController>()
                                                                      .qtyCont[
                                                                          index]
                                                                      .selection =
                                                                  TextSelection(
                                                                baseOffset: 0,
                                                                extentOffset: context
                                                                    .read<
                                                                        StockReqController>()
                                                                    .qtyCont[
                                                                        index]
                                                                    .text
                                                                    .length,
                                                              );
                                                            },
                                                            cursorColor:
                                                                Colors.grey,
                                                            textDirection:
                                                                TextDirection
                                                                    .ltr,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                              DecimalInputFormatter()
                                                            ],
                                                            textAlign:
                                                                TextAlign.right,
                                                            onEditingComplete:
                                                                () {
                                                              context
                                                                  .read<
                                                                      StockReqController>()
                                                                  .editqty(
                                                                      index);
                                                              context
                                                                  .read<
                                                                      StockReqController>()
                                                                  .restartFocus(
                                                                      context);
                                                              context
                                                                  .read<
                                                                      StockReqController>()
                                                                  .disableKeyBoard(
                                                                      context);
                                                            },
                                                            controller: context
                                                                .read<
                                                                    StockReqController>()
                                                                .qtyCont[index],
                                                            decoration:
                                                                InputDecoration(
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                borderSide:
                                                                    const BorderSide(
                                                                        color: Colors
                                                                            .grey),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                borderSide:
                                                                    const BorderSide(
                                                                        color: Colors
                                                                            .grey),
                                                              ),
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                vertical: 5,
                                                                horizontal: 5,
                                                              ),
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height:
                                                  widget.searchHeight * 0.001,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  width:
                                                      Screens.width(context) *
                                                          0.12,
                                                  child: Text(
                                                    "${context.watch<StockReqController>().getScanneditemData[index].itemCode}",
                                                    style: theme
                                                        .textTheme.bodyLarge
                                                        ?.copyWith(),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ])),
                                    );
                                  }))
        ],
      ),
    );
  }
}
