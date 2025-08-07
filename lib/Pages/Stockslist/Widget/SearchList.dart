import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Constant/padings.dart';
import 'package:posproject/Controller/StockListsController/StockListsController.dart';
import 'package:provider/provider.dart';

class SearchStockList extends StatefulWidget {
  SearchStockList(
      {super.key,
      required this.stkCtrl,
      required this.stkHeight,
      required this.stkWidth});

  double stkHeight;
  double stkWidth;
  StockController stkCtrl;

  @override
  State<SearchStockList> createState() => _SearchStockListState();
}

class _SearchStockListState extends State<SearchStockList> {
  Paddings paddings = Paddings();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        padding: EdgeInsets.only(
            top: widget.stkHeight * 0.01,
            bottom: widget.stkHeight * 0.01,
            left: widget.stkWidth * 0.01,
            right: widget.stkWidth * 0.01),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        height: widget.stkHeight,
        width: widget.stkWidth,
        child: Column(
          children: [
            SizedBox(
              height: widget.stkHeight * 0.02,
            ),
            Container(
              width: widget.stkWidth * 0.98,
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.08), //Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller:
                    context.read<StockController>().groupmycontroller[1],
                autocorrect: false,
                onChanged: (v) async {
                  if (context
                          .read<StockController>()
                          .groupmycontroller[1]
                          .text
                          .isNotEmpty &&
                      v.isNotEmpty) {
                    log('message11');
                    context.read<StockController>().visibleItemList = true;

                    await context.read<StockController>().getAllListItem(
                        context
                            .read<StockController>()
                            .groupmycontroller[1]
                            .text
                            .trim(),
                        '',
                        '');
                  } else {
                    setState(() {
                      context
                          .read<StockController>()
                          .groupmycontroller[1]
                          .text = '';

                      context.read<StockController>().visibleItemList = false;
                      context.read<StockController>().getfilterSearchedData =
                          [];
                      context.read<StockController>().getSearchedData = [];
                      context.read<StockController>().itemValue = [];
                      context.read<StockController>().filteritemValue = [];
                    });
                  }
                },
                onEditingComplete: () {
                  context.read<StockController>().disableKeyBoard(context);
                },
                decoration: InputDecoration(
                  filled: false,
                  hintText: 'Search Here!!..',
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      FocusScopeNode focus = FocusScope.of(context);
                      if (!focus.hasPrimaryFocus) {
                        focus.unfocus();
                      }
                    }, //
                    color: theme.primaryColor,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 5,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: widget.stkHeight * 0.005,
            ),
            Expanded(
              child: context.read<StockController>().visibilityError.isEmpty &&
                      context.watch<StockController>().itemValue.isEmpty &&
                      context
                          .read<StockController>()
                          .getfilterSearchedData
                          .isEmpty &&
                      context.watch<StockController>().searchBtnLoading == true
                  ? Container(
                      height: Screens.padingHeight(context) * 0.45,
                      child: Center(
                          child: CircularProgressIndicator(
                              color: theme.primaryColor)),
                    )
                  : context
                              .read<StockController>()
                              .visibilityError
                              .isNotEmpty &&
                          context
                              .read<StockController>()
                              .getfilterSearchedData
                              .isEmpty &&
                          context.watch<StockController>().itemValue.isEmpty &&
                          context.watch<StockController>().searchBtnLoading ==
                              false
                      ? Container(
                          height: Screens.padingHeight(context) * 0.45,
                          child: Center(
                            child: Text(
                                '${context.read<StockController>().visibilityError}'),
                          ),
                        )
                      : ListView.builder(
                          itemCount:
                              context.watch<StockController>().itemValue.length,
                          itemBuilder: (BuildContext context, int i) {
                            return InkWell(
                              onTap: () {
                                context.read<StockController>().listDialogue(
                                    context,
                                    context
                                        .read<StockController>()
                                        .itemValue[i],
                                    i);
                              },
                              child: Card(
                                elevation: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  width: widget.stkWidth,
                                  padding: EdgeInsets.symmetric(
                                      vertical: widget.stkHeight * 0.01,
                                      horizontal: widget.stkWidth * 0.02),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: widget.stkWidth * 0.4,
                                            child: Text(
                                                "Item code: ${context.watch<StockController>().itemValue[i].itemCode}",
                                                style: theme.textTheme.bodyLarge
                                                    ?.copyWith(
                                                        color: theme
                                                            .primaryColor)),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: widget.stkWidth * 0.05),
                                        child: Divider(
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width: widget.stkWidth * 0.4,
                                        child: Text("Product",
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(color: Colors.grey)),
                                      ),
                                      SizedBox(
                                        height: widget.stkHeight * 0.01,
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: widget.stkWidth,
                                            child: Text(
                                                " ${context.watch<StockController>().itemValue[i].itemName}",
                                                style: theme.textTheme.bodyLarge
                                                    ?.copyWith()),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: widget.stkHeight * 0.01,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              "Sellprice: ${context.watch<StockController>().itemValue[i].itemPrices![0].price}",
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color:
                                                          theme.primaryColor),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              "Pack Size: ${context.watch<StockController>().itemValue[i].U_Pack_Size}",
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color:
                                                          theme.primaryColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            ),
            Visibility(
                visible: context.read<StockController>().visibleItemList,
                child: Container(
                  height: Screens.bodyheight(context) * 0.8,
                  child: ListView.builder(
                    itemCount: context
                        .watch<StockController>()
                        .getfilterSearchedData
                        .length,
                    itemBuilder: (BuildContext context, int i) {
                      return InkWell(
                        onTap: () {
                          context.read<StockController>().listDialogue22(
                              context,
                              context
                                  .read<StockController>()
                                  .getfilterSearchedData[i],
                              i);
                        },
                        child: Card(
                          elevation: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            width: widget.stkWidth,
                            padding: EdgeInsets.symmetric(
                                vertical: widget.stkHeight * 0.01,
                                horizontal: widget.stkWidth * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: widget.stkWidth * 0.4,
                                      child: Text(
                                          "Item code: ${context.watch<StockController>().getfilterSearchedData[i].itemcode}",
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(
                                                  color: theme.primaryColor)),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: widget.stkWidth * 0.05),
                                  child: Divider(
                                    color: Colors.grey[400],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: widget.stkWidth * 0.4,
                                  child: Text("Product",
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.grey)),
                                ),
                                SizedBox(
                                  height: widget.stkHeight * 0.01,
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      width: widget.stkWidth,
                                      child: Text(
                                          " ${context.watch<StockController>().getfilterSearchedData[i].itemnamelong}",
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith()),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: widget.stkHeight * 0.01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "Sellprice: ${context.watch<StockController>().getfilterSearchedData[i].sellprice}",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(
                                                color: theme.primaryColor),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "Pack Size: ${context.watch<StockController>().getfilterSearchedData[i].uPackSize}",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(
                                                color: theme.primaryColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )),
          ],
        ));
  }
}
