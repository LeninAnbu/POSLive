import 'package:flutter/material.dart';
import '../../../../../Controller/StockOutwardController/StockOutwardController.dart';
import '../../../../../Widgets/ContentContainer.dart';
import 'package:posproject/Widgets/AlertBox.dart';

class StockOut_ListWidget extends StatelessWidget {
  StockOut_ListWidget({
    super.key,
    required this.theme,
    required this.stOutCon,
    required this.sOutHeigh,
    required this.sOutWidth,
  });
  double sOutHeigh;
  double sOutWidth;

  final ThemeData theme;
  StockOutwardController stOutCon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(sOutHeigh * 0.012),
      child: Container(
        alignment: Alignment.center,
        height: sOutHeigh,
        width: sOutWidth,
        padding: EdgeInsets.all(
          sOutHeigh * 0.008,
        ),
        decoration: const BoxDecoration(
          // borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          // border: Border.all(color: theme.primaryColor.withOpacity(0.3))
        ),
        child: SizedBox(
          width: sOutWidth,
          height: sOutHeigh,
          child: stOutCon.StockOutward.isEmpty &&
                  stOutCon.dbDataTrue == true &&
                  stOutCon.savedraftBill.isEmpty
              ? Center(
                  child: Text(
                    "No data found",
                    style: theme.textTheme.bodyMedium!
                        .copyWith(color: Colors.black),
                  ),
                )
              // : stOutCon.StockOutward.isEmpty &&
              //         stOutCon.savedraftBill.isNotEmpty
              //     ? Center(
              //         child: Text(
              //           "Data Save as Draft Bill..!!",
              //           style: theme.textTheme.bodyMedium!
              //               .copyWith(color: Colors.black),
              //         ),
              //       )
              : stOutCon.StockOutward.isEmpty && stOutCon.dbDataTrue == false
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(), // new

                      itemCount: stOutCon.StockOutward.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(sOutHeigh * 0.005),
                          child: InkWell(
                            onTap: () {
                              if (stOutCon
                                  .StockOutward[index].data.isNotEmpty) {
                                stOutCon.Selectindex(index);
                                stOutCon.passINDEX(index);
                                stOutCon.passList(
                                    stOutCon.StockOutward[index].data);
                              } else if (stOutCon
                                  .StockOutward[index].data.isEmpty) {
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
                                                    'This Item Saved in DraftBill..!!',
                                                theme: theme,
                                              )),
                                              buttonName: null));
                                    });
                              }
                            },
                            child: Container(
                                width: sOutHeigh * 0.95,
                                // height: sOutHeigh * 0.3,
                                padding: EdgeInsets.all(
                                  sOutHeigh * 0.01,
                                ),
                                decoration: BoxDecoration(
                                    color: (stOutCon.totalqty(index) !=
                                                stOutCon
                                                    .totalscannedqty(index) &&
                                            stOutCon.totalValdationqty(index) !=
                                                0)
                                        ?
                                        // Colors.red
                                        const Color(0xFFfcedee)
                                        // Color(0xFFebfaef)
                                        : (stOutCon.totalqty(index) ==
                                                    stOutCon.totalscannedqty(
                                                        index) &&
                                                stOutCon.totalValdationqty(
                                                        index) !=
                                                    0)
                                            ?
                                            // Colors.green
                                            const Color(0xFFebfaef)
                                            : (stOutCon.totalqty(index) ==
                                                        stOutCon
                                                            .totalscannedqty(
                                                                index) &&
                                                    stOutCon.totalValdationqty(
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
                                      color: (stOutCon.totalqty(index) !=
                                                  stOutCon
                                                      .totalscannedqty(index) &&
                                              stOutCon.totalValdationqty(
                                                      index) !=
                                                  0)
                                          ?
                                          // Colors.red
                                          Colors.red.withOpacity(0.3)
                                          // Color(0xFFebfaef)
                                          : (stOutCon.totalqty(index) ==
                                                      stOutCon.totalscannedqty(
                                                          index) &&
                                                  stOutCon.totalValdationqty(
                                                          index) !=
                                                      0)
                                              ?
                                              // Colors.green
                                              Colors.green.withOpacity(0.3)
                                              : (stOutCon.totalqty(index) ==
                                                          stOutCon
                                                              .totalscannedqty(
                                                                  index) &&
                                                      stOutCon.totalValdationqty(
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
                                          width: sOutWidth,
                                          // color: Colors.amber,
                                          padding:
                                              EdgeInsets.all(sOutHeigh * 0.006),
                                          decoration: BoxDecoration(
                                              // color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Text(
                                            "Request From ${stOutCon.StockOutward[index].reqfromWhs}",
                                            // "${stOutCon.getScanneditemData[index].ItemName}",
                                            style: theme.textTheme.bodyMedium!
                                                .copyWith(
                                                    // fontSize: 12,
                                                    // color: Colors.grey,
                                                    // fontWeight: FontWeight.bold
                                                    ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: sOutHeigh * 0.002,
                                        ),
                                        SizedBox(
                                          width: sOutWidth,
                                          child: IntrinsicHeight(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(
                                                      sOutHeigh * 0.005),

                                                  // width: sOutWidth * 0.3,
                                                  decoration: BoxDecoration(
                                                      // color: Colors.grey[600],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  // color: Colors.blue,
                                                  child: Text(
                                                    stOutCon.StockOutward[index]
                                                                .docstatus ==
                                                            '3'
                                                        ? "# Stock Against "
                                                        : "# Stock Order ",
                                                    // "${stOutCon.getScanneditemData[index].SerialBatch}",
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
                                                  // width: sOutWidth * 0.6,
                                                  decoration:
                                                      const BoxDecoration(
                                                          // color: Colors.amber,
                                                          ),
                                                  child: Text(
                                                    "${stOutCon.StockOutward[index].reqtransdate}",
                                                    // "${stOutCon.getScanneditemData[index].ItemCode}",
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
