import 'package:flutter/material.dart';

import '../../../../Constant/Screen.dart';
import '../../../../Controller/DepositController/DepositsController.dart';
import '../../../Sales Screen/Widgets/QuickOptions.dart';
import '../../Widgets/firstScreen.dart';

class PosSettleScreen extends StatelessWidget {
  PosSettleScreen({super.key, required this.settleCon});

  String? chosenValue;

  DepositsController settleCon;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            height: Screens.padingHeight(context) * 0.95,
            width: Screens.width(context) * 0.90,
            child: SettleFirstscreen(
              custHeight: Screens.padingHeight(context) * 0.70,
              custWidth: Screens.width(context) * 0.90,
            )),
        const SingleChildScrollView(child: QuickOptions()),
      ],
    );
  }
}
