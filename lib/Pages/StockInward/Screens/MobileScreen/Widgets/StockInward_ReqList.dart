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
          color: Colors.white,
        ),
        child: SizedBox(
          width: SIN_Width,
          height: SIN_Heigh,
          child: stInCon.stockInward.isEmpty
              ? Center(
                  child: Text(
                    "No data From Stock Outward..!!",
                    style: theme.textTheme.bodyMedium!
                        .copyWith(color: Colors.black),
                  ),
                )
              : stInCon.stockInward.isEmpty
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
                            },
                            child: Container(
                                width: SIN_Heigh * 0.95,
                                padding: EdgeInsets.all(
                                  SIN_Heigh * 0.01,
                                ),
                                decoration: BoxDecoration(
                                    color: (stInCon.totalqty(index) !=
                                                stInCon
                                                    .totalscannedqty(index) &&
                                            stInCon.totalValdationqty(index) !=
                                                0)
                                        ? const Color(0xFFfcedee)
                                        : (stInCon.totalqty(index) ==
                                                    stInCon.totalscannedqty(
                                                        index) &&
                                                stInCon.totalValdationqty(
                                                        index) !=
                                                    0)
                                            ? const Color(0xFFebfaef)
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
                                          ? Colors.red.withOpacity(0.3)
                                          : (stInCon.totalqty(index) ==
                                                      stInCon.totalscannedqty(
                                                          index) &&
                                                  stInCon.totalValdationqty(
                                                          index) !=
                                                      0)
                                              ? Colors.green.withOpacity(0.3)
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
                                          padding:
                                              EdgeInsets.all(SIN_Heigh * 0.006),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Text(
                                            "Inventory Transfer From ${stInCon.stockInward[index].reqtoWhs}",
                                            style: theme.textTheme.bodyMedium!
                                                .copyWith(
                                              color: Colors.black,
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
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  child: Text(
                                                    "# ${stInCon.stockInward[index].reqtransdate}",
                                                    style: theme
                                                        .textTheme.bodyMedium!
                                                        .copyWith(),
                                                  ),
                                                ),
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(),
                                                  child: Text(
                                                    "${stInCon.stockInward[index].branch}",
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
