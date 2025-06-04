// import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:posproject/Controller/DashBoardController/DashboardController.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

class MobsalesDetails extends StatelessWidget {
  MobsalesDetails(
      {super.key,
      required this.theme,
      required this.salesWidth,
      required this.salesheight,
      required this.prdDBC});
  double salesheight;
  double salesWidth;
  DashBoardController prdDBC;
  ThemeData theme;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: salesWidth,
      color: Colors.grey.withOpacity(0.1),
      padding: EdgeInsets.only(
        top: salesheight * 0.03,
        left: salesheight * 0.01,
        right: salesheight * 0.01,
        bottom: salesheight * 0.01,
      ),
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
                  height: salesheight * 0.14,
                  width: salesWidth * 0.45,
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
                          height: salesheight * 0.09,
                          alignment: Alignment.center,
                          child: Text(
                            "2/2000",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(fontSize: 16),
                          )),
                      Container(
                          height: salesheight * 0.035,
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
                  height: salesheight * 0.14,
                  width: salesWidth * 0.45,
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
                          height: salesheight * 0.09,
                          alignment: Alignment.center,
                          child: Text(
                            "2000",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(fontSize: 16),
                          )),
                      Container(
                          height: salesheight * 0.035,
                          decoration: BoxDecoration(
                            color: theme.primaryColor,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Cash Balance",
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
            height: salesheight * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                elevation: 5,
                child: Container(
                  height: salesheight * 0.14,
                  width: salesWidth * 0.45,
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
                          height: salesheight * 0.09,
                          alignment: Alignment.center,
                          child: Text(
                            "1/15000",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(fontSize: 16),
                          )),
                      Container(
                          alignment: Alignment.center,
                          height: salesheight * 0.035,
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
              Card(
                elevation: 5,
                child: Container(
                  height: salesheight * 0.14,
                  width: salesWidth * 0.45,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: theme.primaryColor),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: salesheight * 0.09,
                          alignment: Alignment.center,
                          child: Text(
                            "20/4000",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(fontSize: 16),
                          )),
                      Container(
                          height: salesheight * 0.035,
                          decoration: BoxDecoration(
                            color: theme.primaryColor,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Coupons",
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
            height: salesheight * 0.02,
          ),
        ],
      ),
    );
  }
}
