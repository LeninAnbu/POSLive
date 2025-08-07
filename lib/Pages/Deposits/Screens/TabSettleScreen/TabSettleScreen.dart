import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:posproject/Controller/DepositController/DepositsController.dart';
import 'package:provider/provider.dart';

import '../../../../Constant/Screen.dart';
import '../../Widgets/TabsetledSecondScreen.dart';
import '../../Widgets/firstScreen.dart';

class TabSettleScreen extends StatelessWidget {
  TabSettleScreen({
    super.key,
  });

  String? chosenValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: Screens.width(context),
      height: Screens.bodyheight(context) * 0.95,
      child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: context.read<DepositsController>().tappage,
          children: [
            Column(
              children: [
                SettleFirstscreen(
                  custHeight: Screens.padingHeight(context) * 0.80,
                  custWidth: Screens.width(context) * 0.90,
                ),
              ],
            ),
            TabsetledSecondScreen(
              custHeight: Screens.padingHeight(context) * 0.90,
              custWidth: Screens.width(context) * 0.90,
            )
          ]),
    );
  }
}
