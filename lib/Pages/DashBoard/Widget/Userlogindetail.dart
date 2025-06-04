import 'package:flutter/material.dart';
import 'package:posproject/Constant/AppConstant.dart';
import 'package:provider/provider.dart';

import '../../../Constant/UserValues.dart';
import '../../../Controller/DashBoardController/DashboardController.dart';

class UserLoginDetail extends StatelessWidget {
  UserLoginDetail({
    super.key,
    required this.theme,
    required this.userWidth,
    required this.userheight,
  });
  double userheight;
  double userWidth;
  ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: userheight,
        width: userWidth,
        padding: EdgeInsets.all(userheight * 0.008),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: userWidth * 0.56,
                  child: Row(
                    children: [
                      Container(
                          width: userWidth * 0.16,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "User Name  ",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(fontSize: 16),
                          )),
                      Container(
                          width: userWidth * 0.4,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '  ${UserValues.username}',
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(fontSize: 16),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  width: userWidth * 0.4,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          width: userWidth * 0.135,
                          child: Text(
                            "Logged In ",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(fontSize: 16),
                          )),
                      Container(
                          width: userWidth * 0.2,
                          alignment: Alignment.centerRight,
                          child: Text(
                            context
                                .watch<DashBoardController>()
                                .config
                                .alignDate(context
                                    .watch<DashBoardController>()
                                    .config
                                    .currentDate()),
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(fontSize: 16),
                          )),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: userWidth * 0.56,
                  child: Row(
                    children: [
                      Container(
                          width: userWidth * 0.16,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Branch  ",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(fontSize: 16),
                          )),
                      Container(
                          width: userWidth * 0.4,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppConstant.branch,
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(fontSize: 16),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  width: userWidth * 0.4,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          width: userWidth * 0.135,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Terminal",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(fontSize: 16),
                          )),
                      Container(
                          width: userWidth * 0.2,
                          alignment: Alignment.centerRight,
                          child: Text(
                            AppConstant.terminal,
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(fontSize: 16),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
