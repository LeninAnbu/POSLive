import 'package:flutter/material.dart';
import 'package:posproject/Pages/StockOutward/Screens/MobileScreen/Widgets/StockOutward_ReqList.dart';
import 'package:posproject/Pages/StockOutward/Screens/MobileScreen/Widgets/StockOutward_Scanpage.dart';
import '../../../../../Constant/Screen.dart';
import '../../../../../Controller/StockOutwardController/StockOutwardController.dart';
import '../Widgets/StockOutward_Details.dart';

class StockOutward extends StatelessWidget {
  StockOutward({super.key, required this.theme, required this.soutCon});

  final ThemeData theme;
  StockOutwardController soutCon;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PageView(
      scrollDirection: Axis.horizontal,
      pageSnapping: false,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (index) {
        soutCon.PageIndexvalue(index);
      },
      children: [
        StockOut_ListWidget(
            theme: theme,
            stOutCon: soutCon,
            sOutHeigh: Screens.bodyheight(context),
            sOutWidth: Screens.width(context)),
        StockOut_DetailsWidget(
          theme: theme,
          stOutCon: soutCon,
          sOutHeigh: Screens.bodyheight(context),
          sOutWidth: Screens.width(context),
          index: soutCon.get_i_value,
          data: soutCon.passdata,
          datatotal: soutCon.StockOutward,
        ),
        MyWidget(
            stInCon: soutCon,
            datalist: soutCon.batch_datalist,
            ind: soutCon.batch_i!,
            index: soutCon.get_i_value)
      ],
    );
  }
}
