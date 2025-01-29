import 'package:flutter/material.dart';
import 'package:posproject/Controller/DashBoardController/DashboardController.dart';
import 'package:posproject/main.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

class SalesDetails extends StatelessWidget {
  SalesDetails({
    super.key,
    required this.theme,
    required this.salesWidth,
    required this.salesheight,
  });
  double salesheight;
  double salesWidth;

  ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.white
          // color: Colors.grey.withOpacity(0.1),
          ),
      padding: EdgeInsets.only(
        top: salesheight * 0.01,
        left: salesheight * 0.05,
        right: salesheight * 0.05,
        bottom: salesheight * 0.01,
      ),
      width: salesWidth * 1,
      // height: salesheight *0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                elevation: 5,
                child: Container(
                  height: salesheight * 0.22,
                  width: salesWidth * 0.4,
                  //  decoration: BoxDecoration(
                  //      color: Colors.blue.withOpacity(0.05),
                  // borderRadius: BorderRadius.circular(5),

                  //               // color: Colors.white,
                  //               boxShadow: [
                  //                 BoxShadow(
                  //                   color: Colors.grey.withOpacity(0.5),
                  //                   spreadRadius: 3,
                  //                   blurRadius: 7,
                  //                   offset: Offset(
                  //                       0, 3), // changes position of shadow
                  //                 ),
                  //               ],
                  //             ),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: theme.primaryColor),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: salesheight * 0.11,
                          alignment: Alignment.center,
                          child: Text(
                            "${context.watch<DashBoardController>().noofSales} / ${config.splitValues(context.watch<DashBoardController>().noofSalesamt.toStringAsFixed(2))}",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(fontSize: 16),
                          )),
                      Container(
                          decoration: BoxDecoration(
                            color: theme.primaryColor,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Total Sales",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white, fontSize: 16),
                          ))
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Container(
                  height: salesheight * 0.22,
                  width: salesWidth * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: theme.primaryColor),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: salesheight * 0.11,
                          alignment: Alignment.center,
                          child: Text(
                            "${context.watch<DashBoardController>().noofSalesOrder} / ${config.splitValues(context.watch<DashBoardController>().noofSalesOrderamt.toStringAsFixed(2))}",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(fontSize: 16),
                          )),
                      Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: theme.primaryColor,
                            // borderRadius: BorderRadius.only(
                            //     bottomLeft: Radius.circular(4),
                            //     bottomRight: Radius.circular(4)),
                          ),
                          child: Text(
                            "Orders",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white, fontSize: 16),
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: salesheight * 0.008,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Container(
              //     height: salesheight * 0.8,
              //     width: salesWidth * 0.63,
              //     child: charts.BarChart(
              //       behaviors: [
              //         charts.ChartTitle(
              //           'Sales',
              //           behaviorPosition: charts.BehaviorPosition.bottom,
              //           titleOutsideJustification:
              //               charts.OutsideJustification.middleDrawArea,
              //         ),
              //       ],
              //       context.read<DashBoardController>().createSampleData(),
              //       animate: true,
              //       barGroupingType: charts.BarGroupingType.grouped,
              //     )),
              SizedBox(
                height: salesheight * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                      elevation: 5,
                      child: Container(
                        height: salesheight * 0.22,
                        width: salesWidth * 0.3,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: theme.primaryColor),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: salesheight * 0.11,
                                alignment: Alignment.center,
                                child: Text(
                                  config.splitValues(context
                                      .watch<DashBoardController>()
                                      .cashbalance
                                      .toStringAsFixed(2)),
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(fontSize: 16),
                                )),
                            Container(
                                decoration: BoxDecoration(
                                  color: theme.primaryColor,
                                  // borderRadius: BorderRadius.only(
                                  //     bottomLeft: Radius.circular(4),
                                  //     bottomRight: Radius.circular(4)),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Cash Balance",
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                      color: Colors.white, fontSize: 16),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: Container(
                        // padding: EdgeInsets.only(bottom:salesheight * 0.05, ),
                        height: salesheight * 0.22,
                        width: salesWidth * 0.3,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: theme.primaryColor),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                height: salesheight * 0.11,
                                alignment: Alignment.center,
                                child: Text(
                                  "${context.watch<DashBoardController>().couponsUsedCount.toString()}/${context.watch<DashBoardController>().couponsCount.toString()}",
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(fontSize: 16),
                                )),
                            Container(
                                decoration: BoxDecoration(
                                  color: theme.primaryColor,
                                  //   borderRadius: BorderRadius.only(
                                  //       bottomLeft: Radius.circular(4),
                                  //       bottomRight: Radius.circular(4)),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Coupons",
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                      color: Colors.white, fontSize: 16),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
