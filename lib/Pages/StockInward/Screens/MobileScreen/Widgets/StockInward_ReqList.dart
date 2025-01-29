import 'package:flutter/material.dart';

import '../../../../../Controller/StockInwardController/StockInwardContler.dart';

class StockIn_ListWidget extends StatelessWidget {
  StockIn_ListWidget({
    super.key,
    required this.theme,
    required this.stInCon,
    required this.SIN_Heigh,
    required this.SIN_Width,
  });
  double SIN_Heigh;
  double SIN_Width;

  final ThemeData theme;
  StockInwrdController stInCon;

  @override
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(SIN_Heigh * 0.012),
      child: Container(
        alignment: Alignment.center,
        height: SIN_Heigh,
        width: SIN_Width,
        padding: EdgeInsets.all(
          SIN_Heigh * 0.008,
        ),
        decoration: const BoxDecoration(
          // borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          // border: Border.all(color: theme.primaryColor.withOpacity(0.3))
        ),
        child: SizedBox(
          width: SIN_Width,
          height: SIN_Heigh,
          child: stInCon.stockInward.isEmpty
              //  && stInCon.dbDataTrue == true
              ? Center(
                  child: Text(
                    "No data From Stock Outward..!!",
                    style: theme.textTheme.bodyMedium!
                        .copyWith(color: Colors.black),
                  ),
                )
              : stInCon.stockInward.isEmpty
                  // && stInCon.dbDataTrue == false
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(), // new

                      itemCount: stInCon.stockInward.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(SIN_Heigh * 0.005),
                          child: InkWell(
                            onTap: () {
                              if (stInCon.stockInward[index].data!.isNotEmpty) {
                                stInCon.selectindex(index);
                                stInCon.passINDEX(index);
                                stInCon
                                    .passList(stInCon.stockInward[index].data!);
                                stInCon.page.animateToPage(++stInCon.pageIndex,
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.linearToEaseOut);
                              }

                              // else if (stInCon
                              //     .stockInward[index].data!.isEmpty) {
                              //   showDialog(
                              //       context: context,
                              //       barrierDismissible: true,
                              //       builder: (BuildContext context) {
                              //         return AlertDialog(
                              //             contentPadding:
                              //                 const EdgeInsets.all(0),
                              //             content: AlertBox(
                              //                 payMent: 'Alert',
                              //                 errormsg: true,
                              //                 widget: Center(
                              //                     child: ContentContainer(
                              //                   content:
                              //                       'This Item Saved in DraftBill..!!',
                              //                   theme: theme,
                              //                 )),
                              //                 buttonName: null));
                              //       });
                              // }
                            },
                            child: Container(
                                width: SIN_Heigh * 0.95,
                                // height: SIN_Heigh * 0.3,
                                padding: EdgeInsets.all(
                                  SIN_Heigh * 0.01,
                                ),
                                decoration: BoxDecoration(
                                    color: (stInCon.totalqty(index) !=
                                                stInCon
                                                    .totalscannedqty(index) &&
                                            stInCon.totalValdationqty(index) !=
                                                0)
                                        ?
                                        // Colors.red
                                        const Color(0xFFfcedee)
                                        // Color(0xFFebfaef)
                                        : (stInCon.totalqty(index) ==
                                                    stInCon.totalscannedqty(
                                                        index) &&
                                                stInCon.totalValdationqty(
                                                        index) !=
                                                    0)
                                            ?
                                            // Colors.green
                                            const Color(0xFFebfaef)
                                            : (stInCon.totalqty(index) ==
                                                        stInCon.totalscannedqty(
                                                            index) &&
                                                    stInCon.totalValdationqty(
                                                            index) ==
                                                        0)
                                                ? Colors.white
                                                : Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    border: Border.all(
                                      color: (stInCon.totalqty(index) !=
                                                  stInCon
                                                      .totalscannedqty(index) &&
                                              stInCon.totalValdationqty(
                                                      index) !=
                                                  0)
                                          ?
                                          // Colors.red
                                          Colors.red.withOpacity(0.3)
                                          // Color(0xFFebfaef)
                                          : (stInCon.totalqty(index) ==
                                                      stInCon.totalscannedqty(
                                                          index) &&
                                                  stInCon.totalValdationqty(
                                                          index) !=
                                                      0)
                                              ?
                                              // Colors.green
                                              Colors.green.withOpacity(0.3)
                                              : (stInCon.totalqty(index) ==
                                                          stInCon
                                                              .totalscannedqty(
                                                                  index) &&
                                                      stInCon.totalValdationqty(
                                                              index) ==
                                                          0)
                                                  ? Colors.white
                                                  : Colors.white,
                                    )),
                                child: IntrinsicHeight(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: SIN_Width,
                                          // color: Colors.amber,
                                          padding:
                                              EdgeInsets.all(SIN_Heigh * 0.006),
                                          decoration: BoxDecoration(
                                              // color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Text(
                                            "Inventory Transfer From ${stInCon.stockInward[index].reqtoWhs}",
                                            // "${stInCon.getScanneditemData[index].ItemName}",
                                            style: theme.textTheme.bodyMedium!
                                                .copyWith(
                                              // fontSize: 12,
                                              color: Colors.black,
                                              // fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: SIN_Heigh * 0.002,
                                        ),
                                        SizedBox(
                                          width: SIN_Width,
                                          child: IntrinsicHeight(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(
                                                      SIN_Heigh * 0.005),

                                                  // width: SIN_Width * 0.3,
                                                  decoration: BoxDecoration(
                                                      // color: Colors.grey[600],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  // color: Colors.blue,
                                                  child: Text(
                                                    "# ${stInCon.stockInward[index].reqtransdate}",
                                                    // "${stInCon.getScanneditemData[index].SerialBatch}",
                                                    style: theme
                                                        .textTheme.bodyMedium!
                                                        .copyWith(
                                                            // color: Colors.green,
                                                            // fontSize: 10,
                                                            // fontWeight:
                                                            //     FontWeight.bold
                                                            ),
                                                  ),
                                                ),
                                                Container(
                                                  // width: SIN_Width * 0.6,
                                                  decoration:
                                                      const BoxDecoration(
                                                          // color: Colors.amber,
                                                          ),
                                                  child: Text(
                                                    "${stInCon.stockInward[index].branch}",
                                                    // "${stInCon.getScanneditemData[index].ItemCode}",
                                                    style: theme
                                                        .textTheme.bodyMedium!
                                                        .copyWith(
                                                            // color: Colors.blueGrey,
                                                            // fontSize: 12,
                                                            // fontWeight:
                                                            //     FontWeight.bold
                                                            ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ]),
                                )),
                          ),
                        );
                      }),
        ),
      ),
    );
  }
}
