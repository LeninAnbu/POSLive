import 'package:flutter/material.dart';
import 'package:posproject/Pages/StockInward/Screens/MobileScreen/Widgets/StockInward_ReqList.dart';
import 'package:posproject/Pages/StockInward/Screens/MobileScreen/Widgets/StockInward_Scanpage.dart';
import '../../../../../Constant/Screen.dart';

import '../../../../../Controller/StockInwardController/StockInwardContler.dart';
import '../Widgets/StockInward_Details.dart';

class StockInward extends StatelessWidget {
  StockInward({super.key, required this.theme, required this.stInCon});

  final ThemeData theme;
  StockInwrdController stInCon;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PageView(
      scrollDirection: Axis.horizontal,
      pageSnapping: false,
      controller: stInCon.page,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (index) {
        stInCon.pageIndexvalue(index);
      },
      children: [
        StockIn_ListWidget(
            theme: theme,
            stInCon: stInCon,
            SIN_Heigh: Screens.bodyheight(context),
            SIN_Width: Screens.width(context)),
        StockIn_DetailsWidget(
          theme: theme,
          stInCon: stInCon,
          sinHeigh: Screens.bodyheight(context),
          sinWidth: Screens.width(context),
          index: stInCon.get_i_value,
          data: stInCon.passdata,
          datatotal: stInCon.stockInward,
        ),
        MyWidget(
            stInCon: stInCon,
            datalist: stInCon.batch_datalist,
            ind: stInCon.batch_i!,
            index: stInCon.get_i_value)
      ],
    );
  }
}
