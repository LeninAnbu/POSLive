// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import '../../../../../Controller/DashBoardController/DashboardController.dart';

class MobAnnouncement extends StatelessWidget {
  MobAnnouncement(
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
      color: Colors.grey.withOpacity(0.1),
      padding: EdgeInsets.only(
        left: dbWidth * 0.015,
        right: dbWidth * 0.015,
        top: dbHeight * 0.01,
        bottom: dbHeight * 0.01,
      ),
      width: dbWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: dbWidth * 0.015,
              right: dbWidth * 0.015,
            ),
            child: Text(
              "Announcement",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 8,
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
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(
                    dbHeight * 0.01,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Unilet / Extended Warranty / 1 Year /Directcool >12000 1Yr",
                        style:
                            theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
                      ),
                      SizedBox(
                        height: dbHeight * 0.005,
                      ),
                      Text(
                        'DC-ABV12K-1YR',
                        style:
                            theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                ));
              }),
        ],
      ),
    );
  }
}
