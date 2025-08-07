import 'package:flutter/material.dart';
import 'package:posproject/Controller/PaymentReceiptController/ReportsCtrl.dart';
import 'package:posproject/Pages/CashStatement/CashStatement/widgets/AppBar.dart';
import 'package:provider/provider.dart';
import '../../../../Controller/SalesRegisterController/SalesRegisterCon.dart';
import '../../../../Widgets/Drawer.dart';
import '../../../../Widgets/MobileDrawer.dart';
import 'Widgets/IncomingReportpage.dart';

class IncomingReportsScreens extends StatefulWidget {
  const IncomingReportsScreens({
    super.key,
  });

  @override
  State<IncomingReportsScreens> createState() => SalesRegisterState();
}

class SalesRegisterState extends State<IncomingReportsScreens> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<IncomingReportCtrl>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        return Scaffold(
          drawer: naviDrawerMob(context),
          body: ChangeNotifierProvider<StRegCon>(
              create: (context) => StRegCon(), //SOCon
              builder: (context, child) {
                return Consumer<StRegCon>(
                    builder: (BuildContext context, stRegCon, Widget? child) {
                  return SafeArea(
                    child: Container(),
                  );
                });
              }),
        );
      } else {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: naviDrawer(),
          body: SafeArea(
            child: Column(children: <Widget>[
              appbarDefault('Incoming Payment Report', theme, context),
              IncomingReportsPage(theme: theme)
            ]),
          ),
        );
      }
    });
  }
}
