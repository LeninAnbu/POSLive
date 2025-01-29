import 'package:flutter/material.dart';

import '../../../../../Constant/Screen.dart';
import '../../../../../Controller/StockReplenish/StockReplenishController.dart';

class StockReplenishScreens extends StatelessWidget {
  StockReplenishScreens({super.key, required this.stkCtrl});
  StockReplenishController stkCtrl;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              padding: EdgeInsets.only(
                  top: Screens.bodyheight(context) * 0.01,
                  bottom: Screens.bodyheight(context) * 0.01,
                  left: Screens.width(context) * 0.01,
                  right: Screens.width(context) * 0.01),
              width: Screens.width(context) * 0.95,
              height: Screens.bodyheight(context) * 0.93,
              child: SingleChildScrollView(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        width: Screens.width(context),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 240, 235, 235)),
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.grey.withOpacity(0.01),
                        ),
                        child: TextFormField(
                          style: theme.textTheme.bodyMedium,
                          onChanged: (v) {
                            stkCtrl.filterListSearched(v);
                          },
                          cursorColor: Colors.grey,
                          // controller: stkCtrl.mycontroller[99],
                          onEditingComplete: () {},
                          decoration: InputDecoration(
                            filled: false,
                            hintText: 'Search Here..',
                            hintStyle: theme.textTheme.bodyMedium?.copyWith(
                                //  color: Colors.grey
                                //   fontWeight: FontWeight.normal
                                ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            // suffixIcon: IconButton(
                            //   icon: Icon(
                            //     Icons.search,
                            //     // size: searchHeight * 0.05,
                            //     color: Colors.grey,
                            //   ),
                            //   onPressed: () async {},
                            //   color: theme.primaryColor,
                            // ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 10,
                            ),
                          ),
                        )),
                    SizedBox(
                      // color: Colors.amber,
                      width: Screens.width(context) * 0.92,
                      height: Screens.bodyheight(context) * 0.82,
                      child: stkCtrl.outOfstockBool == true &&
                              stkCtrl.filteroutOfstockList.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : stkCtrl.outOfstockBool == false &&
                                  stkCtrl.filteroutOfstockList.isEmpty
                              ? const Center(
                                  child: Text("Does Not Have data..!!"))
                              : ListView.builder(
                                  itemCount:
                                      stkCtrl.filteroutOfstockList.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {},
                                      child: Card(
                                        child: Container(
                                          padding: EdgeInsets.all(
                                              Screens.bodyheight(context) *
                                                  0.008),
                                          child: Column(
                                            children: [
                                              IntrinsicHeight(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        // color: Colors.red,
                                                        alignment:
                                                            Alignment.topLeft,
                                                        width: Screens.width(
                                                                context) *
                                                            0.7,
                                                        child: Text(
                                                          "${stkCtrl.filteroutOfstockList[index].itemname}",
                                                          style: theme.textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                                  color: Colors
                                                                      .black),
                                                        )),
                                                    Container(
                                                        // color: Colors.red,
                                                        alignment:
                                                            Alignment.topRight,
                                                        width: Screens.width(
                                                                context) *
                                                            0.15,
                                                        child: Text(
                                                          "${stkCtrl.filteroutOfstockList[index].qty}",
                                                          style: theme.textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                                  color: Colors
                                                                      .black),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              // IntrinsicHeight(
                                              //   child: Row(
                                              //     // mainAxisAlignment:
                                              //     //     MainAxisAlignment.spaceBetween,
                                              //     children: [
                                              //       Container(
                                              //           // color: Colors.red,
                                              //           alignment: Alignment.bottomLeft,
                                              //           // width: Screens.width(context) * 0.42,
                                              //           child: Text(
                                              //             "${stkCtrl.filterStockSnapList[index].itemCode}",
                                              //             style: theme.textTheme.bodyText2
                                              //                 ?.copyWith(
                                              //                     color: Colors.grey),
                                              //           )),
                                              //       Container(
                                              //           // color: Colors.red,
                                              //           alignment: Alignment.bottomRight,
                                              //           // width: Screens.width(context) * 0.42,
                                              //           child: Text(
                                              //             " | ${stkCtrl.filterStockSnapList[index].serialbatch}",
                                              //             style: theme.textTheme.bodyText2
                                              //                 ?.copyWith(
                                              //                     color: Colors.grey),
                                              //           )),
                                              //     ],
                                              //   ),
                                              // )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    //
  }
}
