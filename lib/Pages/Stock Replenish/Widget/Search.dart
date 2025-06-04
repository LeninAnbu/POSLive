import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Controller/StockReplenish/StockReplenishController.dart';

class Search_Widget_Replenish extends StatelessWidget {
  Search_Widget_Replenish(
      {super.key, required this.searchHeight, required this.searchWidth});

  double searchHeight;
  double searchWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: searchHeight,
      width: searchWidth,
      padding: EdgeInsets.only(
          top: searchHeight * 0.01,
          left: searchHeight * 0.01,
          right: searchHeight * 0.01,
          bottom: searchHeight * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              alignment: Alignment.center,
              width: searchWidth * 1,
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 240, 235, 235)),
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey.withOpacity(0.01),
              ),
              child: TextFormField(
                style: theme.textTheme.bodyMedium,
                onChanged: (v) {
                  context
                      .read<StockReplenishController>()
                      .filterListSearched(v);
                },
                cursorColor: Colors.grey,
                onEditingComplete: () {},
                decoration: InputDecoration(
                  filled: false,
                  hintText: 'Search Here..',
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                ),
              )),
          SizedBox(
            height: searchHeight * 0.01,
          ),
          Container(
            padding: EdgeInsets.only(
              top: searchHeight * 0.01,
              left: searchHeight * 0.01,
              right: searchHeight * 0.01,
              bottom: searchHeight * 0.01,
            ),
            decoration: BoxDecoration(
              color: theme.primaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    alignment: Alignment.center,
                    width: searchWidth * 0.1,
                    child: Text(
                      "S.No",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    )),
                Container(
                    alignment: Alignment.center,
                    width: searchWidth * 0.3,
                    child: Text(
                      "Item Code",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    )),
                Container(
                    alignment: Alignment.center,
                    width: searchWidth * 0.4,
                    child: Text(
                      "Item Name",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    )),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                      alignment: Alignment.center,
                      width: searchWidth * 0.15,
                      child: Text(
                        "Qty",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
          Expanded(
              child: context.watch<StockReplenishController>().outOfstockBool ==
                          true &&
                      context
                          .watch<StockReplenishController>()
                          .filteroutOfstockList
                          .isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : context.watch<StockReplenishController>().outOfstockBool ==
                              false &&
                          context
                              .watch<StockReplenishController>()
                              .filteroutOfstockList
                              .isEmpty
                      ? const Center(child: Text("Does Not Have data..!!"))
                      : ListView.builder(
                          itemCount: context
                              .watch<StockReplenishController>()
                              .filteroutOfstockList
                              .length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.only(
                                    top: searchHeight * 0.01,
                                    left: searchHeight * 0.01,
                                    right: searchHeight * 0.01,
                                    bottom: searchHeight * 0.02,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey.withOpacity(0.04),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          alignment: Alignment.center,
                                          width: searchWidth * 0.07,
                                          child: Text(
                                            "${index + 1}",
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          )),
                                      Container(
                                          alignment: Alignment.center,
                                          width: searchWidth * 0.3,
                                          child: Text(
                                            "${context.watch<StockReplenishController>().filteroutOfstockList[index].itemCode}",
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          )),
                                      Container(
                                          alignment: Alignment.center,
                                          width: searchWidth * 0.4,
                                          child: Text(
                                            "${context.watch<StockReplenishController>().filteroutOfstockList[index].itemname}",
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          )),
                                      Container(
                                          alignment: Alignment.center,
                                          width: searchWidth * 0.12,
                                          child: Text(
                                            "${context.watch<StockReplenishController>().filteroutOfstockList[index].qty}",
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })),
        ],
      ),
    );
  }
}
