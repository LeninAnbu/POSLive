import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Controller/StockListsController/StockListsController.dart';
import '../../../Widgets/Drawer.dart';
import '../../../Widgets/MobileDrawer.dart';
import '../../Sales Screen/Screens/MobileScreenSales/AppBar/AppBarMS.dart';
import 'MobStockScreen/Screens/MobScreen.dart';
import 'PosStockScreen/PosStockMainScreen.dart';
import 'TabStockScreen/TabStockSreen.dart';

class StockMainScreens extends StatefulWidget {
  const StockMainScreens({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  State<StockMainScreens> createState() => _StockMainScreensState();
}

class _StockMainScreensState extends State<StockMainScreens> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        context.read<StockController>().init(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        return Scaffold(
            appBar: appbarMS("Stock Lists ", widget.theme, context),
            drawer: naviDrawerMob(context),
            body: ChangeNotifierProvider<StockController>(
                create: (context) => StockController(),
                builder: (context, child) {
                  return Consumer<StockController>(
                      builder: (BuildContext context, stkCtrl, Widget? child) {
                    return SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StockMobScreens(
                            stkCtrl: stkCtrl,
                          ),
                        ],
                      ),
                    );
                  });
                }));
      } else if (constraints.maxWidth <= 1300) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: naviDrawer(),
          appBar: AppBar(
            title: const Text("Stocks List"),
            actions: const [],
          ),
          body: const SafeArea(
            child: TabStockScreen(),
          ),
        );
      } else {
        return Scaffold(
          body: ChangeNotifierProvider<StockController>(
              create: (context) => StockController(),
              builder: (context, child) {
                return Consumer<StockController>(
                    builder: (BuildContext context, prdSCD, Widget? child) {
                  return SafeArea(
                      child: PosStockMainScreen(
                    stkCtrl: prdSCD,
                  ));
                });
              }),
        );
      }
    });
  }
}
