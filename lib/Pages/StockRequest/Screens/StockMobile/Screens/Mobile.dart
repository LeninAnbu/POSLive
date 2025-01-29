import 'package:flutter/material.dart';
import 'package:posproject/Controller/StockRequestController/StockRequestController.dart';
import 'package:posproject/Pages/StockRequest/Screens/StockMobile/Widgets/Bottombuttons.dart';
import 'package:posproject/Pages/StockRequest/Screens/StockMobile/Widgets/productDetails.dart';
import 'package:posproject/Pages/StockRequest/Screens/StockMobile/Widgets/whsDetails_Widgets.dart';
import '../../../../../Constant/Screen.dart';
import '../Widgets/Loadbtns.dart';
import '../Widgets/PaymentDetailsMob.dart';

class StockReqMob extends StatelessWidget {
  StockReqMob({
    super.key,
    required this.srCon,
  });
  StockReqController srCon;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Screens.width(context) * 0.02,
          vertical: Screens.padingHeight(context) * 0.01),
      color: Colors.grey[200],
      height: Screens.bodyheight(context) * 96,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WhsListDetails(
              theme: theme,
              srCon: srCon,
            ),
            SizedBox(
              height: Screens.bodyheight(context) * 0.01,
            ),
            ProductWidget(
              prdsrch: srCon,
              // ProHeight: Screens.bodyheight(context) * 0.5,
              // ProWidth: Screens.width(context) * 0.95,
            ),
            SizedBox(
              height: Screens.bodyheight(context) * 0.01,
            ),
            MobReqpaymentDeltails(
                proHeight: Screens.bodyheight(context) * 0.1,
                proWidth: Screens.width(context) * 0.95,
                prdsrch: srCon,
                theme: theme),
            SizedBox(
              height: Screens.bodyheight(context) * 0.01,
            ),
            MobLoadBtns(theme: theme),
            SizedBox(
              height: Screens.bodyheight(context) * 0.01,
            ),
            Bottombuttons(
              SR_Con: srCon,
            ),
          ],
        ),
      ),
    );
  }
}
