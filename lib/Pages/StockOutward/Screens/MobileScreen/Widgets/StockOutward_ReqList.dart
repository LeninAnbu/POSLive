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
          color: Colors.white,
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
                                padding: EdgeInsets.all(
                                  sOutHeigh * 0.01,
                                ),
                                decoration: BoxDecoration(
                                    color: (stOutCon.totalqty(index) !=
                                                stOutCon
                                                    .totalscannedqty(index) &&
                                            stOutCon.totalValdationqty(index) !=
                                                0)
                                        ? const Color(0xFFfcedee)
                                        : (stOutCon.totalqty(index) ==
                                                    stOutCon.totalscannedqty(
                                                        index) &&
                                                stOutCon.totalValdationqty(
                                                        index) !=
                                                    0)
                                            ? const Color(0xFFebfaef)
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
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                    border: Border.all(
                                      color: (stOutCon.totalqty(index) !=
                                                  stOutCon
                                                      .totalscannedqty(index) &&
                                              stOutCon.totalValdationqty(
                                                      index) !=
                                                  0)
                                          ? Colors.red.withOpacity(0.3)
                                          : (stOutCon.totalqty(index) ==
                                                      stOutCon.totalscannedqty(
                                                          index) &&
                                                  stOutCon.totalValdationqty(
                                                          index) !=
                                                      0)
                                              ? Colors.green.withOpacity(0.3)
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
                                          padding:
                                              EdgeInsets.all(sOutHeigh * 0.006),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Text(
                                            "Request From ${stOutCon.StockOutward[index].reqfromWhs}",
                                            style: theme.textTheme.bodyMedium!
                                                .copyWith(),
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
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  child: Text(
                                                    stOutCon.StockOutward[index]
                                                                .docstatus ==
                                                            '3'
                                                        ? "# Stock Against "
                                                        : "# Stock Order ",
                                                    style: theme
                                                        .textTheme.bodyMedium!
                                                        .copyWith(),
                                                  ),
                                                ),
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(),
                                                  child: Text(
                                                    "${stOutCon.StockOutward[index].reqtransdate}",
                                                    style: theme
                                                        .textTheme.bodyMedium!
                                                        .copyWith(),
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
