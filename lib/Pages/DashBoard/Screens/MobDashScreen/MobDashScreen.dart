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
        children: [
          AppBar(
            title: const Text("Dashboard"),
            centerTitle: true,
          ),
        ],
      ),
    );
  }
}
