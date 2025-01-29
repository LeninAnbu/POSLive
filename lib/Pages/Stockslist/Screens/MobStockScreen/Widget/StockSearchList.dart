import 'package:flutter/material.dart';
import 'package:posproject/Constant/padings.dart';

import '../../../../../Constant/Screen.dart';
import '../../../../../Widgets/MobileDrawer.dart';
import '../../../../Sales Screen/Screens/MobileScreenSales/AppBar/AppBarMS.dart';

class StockSearchList extends StatelessWidget {
  StockSearchList({super.key});
  Paddings paddings = Paddings();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: appbarMS("Stock List ", theme, context),
      drawer: naviDrawerMob(context),
      body: SafeArea(
        child: Container(
            padding: paddings.padding2(context),
            child: Column(
              children: [
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                Container(
                  height: Screens.bodyheight(context) * 0.06,
                  decoration: BoxDecoration(
                    color:
                        theme.primaryColor.withOpacity(0.1), //Colors.grey[200],
                    borderRadius:
                        BorderRadius.circular(Screens.width(context) * 0.02),
                  ),
                  child: TextField(
                    autocorrect: false,
                    onChanged: (v) {},
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
                  height: Screens.bodyheight(context) * 0.005,
                ),
                Expanded(
                  child:
                      // context
                      //             .watch<StockListController>()
                      //             .getisLoadingListView ==
                      //         true
                      //     ? SkeletonListView(
                      //         itemCount: 10,
                      //         scrollable: true,
                      //       )
                      //     :
                      ListView.builder(
                    itemCount: 10,
                    // context
                    //     .watch<StockListController>()
                    //     .getlistPriceAvail
                    //     .length,
                    itemBuilder: (BuildContext context, int i) {
                      return InkWell(
                        onTap: () {
                          // print(context.read<StockListController>().getlistPriceAvail[i].itemCode);
                          // context
                          // .read<StockListController>()
                          // .callItemMasterPriceUpdateNew(
                          //     context
                          //         .read<StockListController>()
                          //         .getlistPriceAvail[i]
                          //         .itemCode!,
                          //     context
                          //         .read<StockListController>()
                          //         .getlistPriceAvail[i]
                          //         .IMId!,
                          //     i);
                        },
                        child: Card(
                          elevation: 5,
                          child:
                              // context
                              //             .watch<StockListController>()
                              //             .getlistPriceAvail[i]
                              //             .isselected ==
                              //         1
                              //     ?
                              // Container(
                              //     width: Screens.width(context),
                              //     padding: EdgeInsets.symmetric(
                              //         vertical:
                              //             Screens.bodyheight(context) * 0.05,
                              //         horizontal:
                              //             Screens.width(context) * 0.02),
                              //     child: Center(
                              //       child: CircularProgressIndicator(
                              //         strokeWidth: 2,
                              //       ),
                              //     ),
                              //   )
                              // :
                              Container(
                            width: Screens.width(context),
                            padding: EdgeInsets.symmetric(
                                vertical: Screens.bodyheight(context) * 0.01,
                                horizontal: Screens.width(context) * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: Screens.width(context) * 0.4,
                                      child: Text(
                                          "Item code: 24 900RPM HEAVY DUTY EXHAUST FAN",
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(
                                                  color: theme.primaryColor)),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          Screens.width(context) * 0.05),
                                  child: Divider(
                                    color: Colors.grey[400],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: Screens.width(context) * 0.4,
                                  child: Text("Product",
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.grey)),
                                ),
                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.01,
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      //  color: Colors.red,
                                      width: Screens.width(context),
                                      child: Text(
                                          " CROMPTON FAN 900RPM HEAVY DUTY EXHAUST FAN",
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(
                                                  //color: theme.primaryColor
                                                  )),
                                    ),
                                    // "900RPM HEAVY DUTY EXHAUST FAN"
                                  ],
                                ),
                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        // ConstantValues.sapUser=='Manager'?
                                        "Whs:0",
                                        // :'',
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(
                                                color: theme.primaryColor),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "Outlet: 0",
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
                      //)));
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }
}
