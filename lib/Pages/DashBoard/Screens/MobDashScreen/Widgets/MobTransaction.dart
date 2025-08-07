import 'package:flutter/material.dart';

import '../../../../../Controller/DashBoardController/DashboardController.dart';

class MobTransaction extends StatelessWidget {
  MobTransaction(
      {super.key,
      required this.theme,
      required this.dbWidth,
      required this.dbHeight,
      required this.prdDBC});
  double dbHeight;
  double dbWidth;
  DashBoardController prdDBC;
  ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: dbWidth * 0.015,
        right: dbWidth * 0.015,
        top: dbHeight * 0.02,
        bottom: dbHeight * 0.01,
      ),
      color: Colors.grey.withOpacity(0.1),
      width: dbWidth,
      height: dbHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: dbHeight * 0.015,
              right: dbHeight * 0.01,
            ),
            child: Text(
              'Transaction Sync',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(fontSize: 19, fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 6,
              itemBuilder: (context, index) {
                return Card(
                    child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(
                    dbHeight * 0.01,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Invoice # 12345645",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(fontSize: 16),
                          ),
                          Text(
                            "12-02-2022  |  10:57",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(fontSize: 16),
                          )
                        ],
                      ),
                      SizedBox(
                        height: dbHeight * 0.005,
                      ),
                      Text(
                        "Unilet / Extended Warranty / 1 Year /Directcool >12000 1Yr",
                        style:
                            theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                ));
              }),
          SizedBox(
            height: dbHeight * 0.015,
          ),
        ],
      ),
    );
  }
}
