import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Controller/CashStatementController/CashSatementCont.dart';
import '../../../../Widgets/Drawer.dart';
import '../widgets/AppBar.dart';
import 'TabScreen/TabScreencashScreen.dart';

class CashSatementScreens extends StatefulWidget {
  const CashSatementScreens({
    super.key,
  });

  @override
  State<CashSatementScreens> createState() => SalesRegisterState();
}

class SalesRegisterState extends State<CashSatementScreens> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CashStateCon>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: naviDrawer(),
        body: SafeArea(
          child: Column(children: <Widget>[
            appbarDefault('Cash Statement', theme, context),
            TabCashSattement(
              theme: theme,
            )
          ]),
        ),
      );
    });
  }
}
