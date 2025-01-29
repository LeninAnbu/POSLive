import 'package:flutter/material.dart';
import 'package:posproject/Pages/Sales%20Screen/Screens/MobileScreenSales/WidgetsMob/PaymentWidegt.dart';
import '../../../../Constant/Screen.dart';
import '../../../../Controller/SalesInvoice/SalesInvoiceController.dart';
import 'AppBar/AppBarMS.dart';
import 'WidgetsMob/AmountSelectionWidget.dart';
import 'WidgetsMob/AmtCalWidget.dart';
import 'WidgetsMob/BottomBtnMob.dart';
import 'WidgetsMob/CustomerWidgetMob.dart';
import 'WidgetsMob/ItemSearchWidget.dart';

class SalesMobile extends StatelessWidget {
  SalesMobile({
    super.key,
    required this.prdCD,
  });
  PosController prdCD;
  //final GlobalKey<ScaffoldState> scaffoldKey;required this.scaffoldKey
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: Screens.bodyheight(context),
      width: Screens.width(context),
      color: Colors.grey[200],
      child: SingleChildScrollView(
        child: Column(children: [
          appbarMS("Sales ", theme, context, posController: prdCD),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: Screens.width(context) * 0.02,
                vertical: Screens.bodyheight(context) * 0.01),
            child: Column(
              children: [
                CustomerWidgetMobile(
                  theme: theme,
                  prdSI: prdCD,
                ),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.02,
                ),
                ItemSearchWidget(theme: theme, prdCD: prdCD),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.02,
                ),
                AmountSelectionWidget(theme: theme, prdCD: prdCD),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.02,
                ),
                PaymentDetailsMob(prdCD: prdCD, theme: theme),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.02,
                ),
                AmtCalCulationWidget(theme: theme, prdCD: prdCD),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.02,
                ),
                BottomButtonMob(prdCD: prdCD, theme: theme)
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
