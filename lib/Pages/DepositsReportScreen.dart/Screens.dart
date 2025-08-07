import 'package:flutter/material.dart';
import 'package:posproject/Controller/DepositController/DepositsReportCtrl.dart';
import 'package:posproject/Pages/CashStatement/CashStatement/widgets/AppBar.dart';
import 'package:provider/provider.dart';
import '../../../../Controller/SalesRegisterController/SalesRegisterCon.dart';
import '../../../../Widgets/Drawer.dart';
import '../../../../Widgets/MobileDrawer.dart';
import 'Widgets.dart/DepositsReportsPage.dart';

class DepositReportsScreens extends StatefulWidget {
  const DepositReportsScreens({
    super.key,
  });

  @override
  State<DepositReportsScreens> createState() => SalesRegisterState();
}

class SalesRegisterState extends State<DepositReportsScreens> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DepositReportCtrlrs>().init();
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
              appbarDefault('Deposits Report', theme, context),
              DepositsReportsPages(theme: theme)
            ]),
          ),
        );
      }
    });
  }
}
