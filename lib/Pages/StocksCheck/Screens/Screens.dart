import 'package:flutter/material.dart';
import 'package:posproject/Pages/StocksCheck/Widget/AppBar.dart';
import 'package:provider/provider.dart';

import '../../../Controller/StockCheckController/StockCheckController.dart';
import '../../../Widgets/Drawer.dart';
import '../../../Widgets/MobileDrawer.dart';
import '../../Sales Screen/Screens/MobileScreenSales/AppBar/AppBarMS.dart';
import 'MobStockScreen/Screens/MobScreen.dart';
import 'TabStockScreen/TabStockSreen.dart';

class StockCheckMainScreens extends StatefulWidget {
  const StockCheckMainScreens({
    super.key,
  });

  @override
  State<StockCheckMainScreens> createState() => _StockCheckMainScreensState();
}

class _StockCheckMainScreensState extends State<StockCheckMainScreens> {
  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        context.read<StockCheckController>().clearDataAll();
        context.read<StockCheckController>().init();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        return Scaffold(
            appBar: appbarMS("Stock Check ", theme, context),
            drawer: naviDrawerMob(context),
            backgroundColor: Colors.grey[200],
            body: ChangeNotifierProvider<StockCheckController>(
                create: (context) => StockCheckController(),
                builder: (context, child) {
                  return Consumer<StockCheckController>(
                      builder: (BuildContext context, stkCtrl, Widget? child) {
                    return SafeArea(
                      child: StockCheckScreens(
                        stkCtrl: stkCtrl,
                        // scaffoldKey: scaffoldKey,
                      ),
                    );
                  });
                }));
      } else {
        //300
        // return ChangeNotifierProvider<StockCheckController>(
        //     create: (context) => StockCheckController(),
        //     builder: (context, child) {
        //       return Consumer<StockCheckController>(
        //           builder: (BuildContext context, prdSCD, Widget? child) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            drawer: naviDrawer(),
            appBar: appbar("Stock Check ", theme, context),
            body: const SafeArea(
              child: TabStockCheckScreen(),
            ));
        //   });
        // });
      }
    });
  }
}
