// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables

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
      // if (constraints.maxWidth <= 800) {
      //   return Scaffold(
      //      drawer: naviDrawerMob(context),
      //      body: ChangeNotifierProvider<CashStateCon>(
      //         create: (context) => CashStateCon(),//SOCon
      //         builder: (context, child) {
      //           return Consumer<CashStateCon>(
      //               builder: (BuildContext context, stRegCon, Widget? child) {
      //           return SafeArea(
      //             child: Container(),
      //           );
      //         }
      //       );
      //      }),
      //   );
      // }

      // else {//300
      return Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: naviDrawer(),
        body:
            // ChangeNotifierProvider<CashStateCon>(
            //   create: (context) => CashStateCon(),
            //   builder: (context, child) {
            //     return Consumer<CashStateCon>(
            //         builder: (BuildContext context, stRegCon, Widget? child) {
            //     return
            SafeArea(
          child: Column(children: <Widget>[
            appbarDefault('Cash Statement', theme, context),
            TabCashSattement(
              theme: theme,
            )
          ]),
        ),
        //     }
        //   );
        //  }),
      );
      // }
    });
  }
}
