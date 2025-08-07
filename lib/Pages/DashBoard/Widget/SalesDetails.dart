import 'package:flutter/material.dart';
import 'package:posproject/Controller/DashBoardController/DashboardController.dart';
import 'package:posproject/main.dart';

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
          borderRadius: BorderRadius.circular(5), color: Colors.white),
      padding: EdgeInsets.only(
        top: salesheight * 0.01,
        left: salesheight * 0.05,
        right: salesheight * 0.05,
        bottom: salesheight * 0.01,
      ),
      width: salesWidth * 1,
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
            children: [
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
