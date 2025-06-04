import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Controller/SalesRegisterController/SalesRegisterCon.dart';
import '../../../../Widgets/Drawer.dart';
import '../../../../Widgets/MobileDrawer.dart';
import '../widgets/AppBar.dart';
import 'TabScreen/TabScreenStockReg.dart';

class SalesRegisterScreens extends StatefulWidget {
  const SalesRegisterScreens({
    super.key,
  });

  @override
  State<SalesRegisterScreens> createState() => SalesRegisterState();
}

class SalesRegisterState extends State<SalesRegisterScreens> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<StRegCon>().init();
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
              appbarDefault('Sales Register', theme, context),
              TabStockReg(theme: theme)
            ]),
          ),
        );
      }
    });
  }
}
