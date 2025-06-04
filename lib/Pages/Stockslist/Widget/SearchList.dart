import 'package:flutter/material.dart';
import 'package:posproject/Constant/padings.dart';
import 'package:posproject/Controller/StockListsController/StockListsController.dart';
import 'package:provider/provider.dart';

class SearchStockList extends StatelessWidget {
  SearchStockList(
      {super.key,
      required this.stkCtrl,
      required this.stkHeight,
      required this.stkWidth});

  double stkHeight;
  double stkWidth;
  StockController stkCtrl;
  Paddings paddings = Paddings();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        padding: EdgeInsets.only(
            top: stkHeight * 0.01,
            bottom: stkHeight * 0.01,
            left: stkWidth * 0.01,
            right: stkWidth * 0.01),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        height: stkHeight,
        width: stkWidth,
        child: Column(
          children: [
            SizedBox(
              height: stkHeight * 0.02,
            ),
            Container(
              width: stkWidth * 0.98,
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.08), //Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                autocorrect: false,
                onChanged: (v) {
                  context.read<StockController>().filterList(v);
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
              height: stkHeight * 0.005,
            ),
            Expanded(
              child: context.read<StockController>().listshow == false &&
                      context
                          .read<StockController>()
                          .getlistPriceAvail
                          .isNotEmpty
                  ? Container()
                  : ListView.builder(
                      itemCount: context
                          .watch<StockController>()
                          .getlistPriceAvail
                          .length,
                      itemBuilder: (BuildContext context, int i) {
                        return InkWell(
                          onTap: () {},
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
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              width: stkWidth,
                              padding: EdgeInsets.symmetric(
                                  vertical: stkHeight * 0.01,
                                  horizontal: stkWidth * 0.02),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: stkWidth * 0.4,
                                        child: Text(
                                            "Item code: ${context.watch<StockController>().getlistPriceAvail[i].itemcode}",
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    color: theme.primaryColor)),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: stkWidth * 0.05),
                                    child: Divider(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: stkWidth * 0.4,
                                    child: Text("Product",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.grey)),
                                  ),
                                  SizedBox(
                                    height: stkHeight * 0.01,
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: stkWidth,
                                        child: Text(
                                            " ${context.watch<StockController>().getlistPriceAvail[i].itemnameshort}",
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith()),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: stkHeight * 0.01,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "Sellprice: ${context.watch<StockController>().getlistPriceAvail[i].sellprice}",
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(
                                                  color: theme.primaryColor),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "Max Discount: ${context.watch<StockController>().getlistPriceAvail[i].maxdiscount}",
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
            )
          ],
        ));
  }
}
