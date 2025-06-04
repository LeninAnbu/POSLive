import 'package:flutter/material.dart';
import 'package:posproject/Controller/SalesInvoice/SalesInvoiceController.dart';
import 'package:posproject/Pages/Sales%20Screen/Screens/TabScreen/BillingTabScreen.dart';

import 'package:provider/provider.dart';
import '../Widgets/AppBar/AppBar.dart';
import '../../../Widgets/Drawer.dart';
import '../../../Widgets/MobileDrawer.dart';
import 'MobileScreenSales/SalesMS.dart';

class PosMainScreens extends StatefulWidget {
  const PosMainScreens({
    super.key,
  });

  @override
  State<PosMainScreens> createState() => _PosMainScreensState();
}

class _PosMainScreensState extends State<PosMainScreens> {
  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<PosController>().init(context, Theme.of(context));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        return Scaffold(
            drawer: naviDrawerMob(context),
            body: SafeArea(
              child: SalesMobile(prdCD: context.read<PosController>()),
            ));
      } else {
        return WillPopScope(
          onWillPop: context.read<PosController>().onbackpress,
          child: Scaffold(
              drawer: naviDrawer(),
              body: SafeArea(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(children: <Widget>[
                    appbar("Sales ", theme, context),
                    SalesInvoiceTabScreen(
                      theme: theme,
                    ),
                  ]),
                ),
              )),
        );
      }
    });
  }
}
