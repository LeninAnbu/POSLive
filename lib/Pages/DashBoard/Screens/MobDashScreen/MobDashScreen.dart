import 'package:flutter/material.dart';

import '../../../../Controller/DashBoardController/DashboardController.dart';

class MobDashScreen extends StatelessWidget {
  MobDashScreen({super.key, required this.theme, required this.prdDBC});
  DashBoardController prdDBC;
  ThemeData theme;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppBar(
            title: const Text("Dashboard"),
            centerTitle: true,
          ),
          // Container(
          //   child: MobsalesDetails(
          //     prdDBC: prdDBC,
          //     theme: theme,
          //     salesWidth: Screens.width(context),
          //     salesheight: Screens.bodyheight(context)*0.8,
          //     // salesheight: Screens.bodyheight(context) * 0.35,
          //   ),
          // ),
          // Container(
          //   child: MobStockTable(
          //     prdDBC: prdDBC,
          //     theme: theme,
          //     dbHeight: Screens.bodyheight(context)*0.9,
          //     dbWidth: Screens.width(context),
          //   ),
          // ),
          // MobAnnouncement(
          //   prdDBC: prdDBC,
          //   theme: theme,
          //   dbHeight: Screens.bodyheight(context),
          //   dbWidth: Screens.width(context),
          // ),
          // MobTransaction(
          //   prdDBC: prdDBC,
          //   theme: theme,
          //   dbHeight: Screens.bodyheight(context)*0.9,
          //   dbWidth: Screens.width(context),
          // )
        ],
      ),
    );
  }
}
