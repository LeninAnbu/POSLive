import 'package:flutter/material.dart';
import 'package:posproject/Pages/StockInward/Screens/MobileScreen/Screens/StockInward.dart';
import 'package:posproject/Pages/StockInward/Screens/TabScreen/StockInTab.dart';
import 'package:posproject/Pages/StockInward/Widgets/M_StIn_Appbar.dart';
import 'package:posproject/Pages/StockInward/Widgets/STinward_Appbar.dart';
import 'package:posproject/Widgets/MobileDrawer.dart';
import 'package:provider/provider.dart';
import '../../../../Controller/StockInwardController/StockInwardContler.dart';
import '../../../Widgets/Drawer.dart';
import '../Widgets/Tap_stockInItemDeatils.dart';

class StockInwardScreens extends StatefulWidget {
  const StockInwardScreens({
    super.key,
  });

  @override
  State<StockInwardScreens> createState() => _StockInwardScreensState();
}

class _StockInwardScreensState extends State<StockInwardScreens> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        context.read<StockInwrdController>().init();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        //     return ChangeNotifierProvider<StockInwrdController>(
        //         create: (context) => StockInwrdController(),
        //         builder: (context, child) {
        //           return Consumer<StockInwrdController>(
        //               builder: (BuildContext context, stinCon, Widget? child) {

        return WillPopScope(
            onWillPop: (() {
              context.watch<StockInwrdController>().page.previousPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.linear,
                  );
              return Future.value(false);
            }),
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: stInAppbar("Stock Inward", theme, context,
                    context.watch<StockInwrdController>()),
                drawer: naviDrawerMob(context),
                backgroundColor: Colors.grey[200],
                body: SafeArea(
                  child: StockInward(
                      theme: theme,
                      stInCon: context.watch<StockInwrdController>()),
                )));
        // });
        // });
      } else {
        return WillPopScope(
          onWillPop: context.read<StockInwrdController>().onbackpress3,
          child: Scaffold(
              drawer: naviDrawer(),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    context.watch<StockInwrdController>().isselect == false
                        ? SingleChildScrollView(
                            child: Column(children: [
                              inwardAppbar("Stock Inwards", theme, context),
                              StockInTab(theme: theme),
                            ]),
                          )
                        : Container(),
                    context.watch<StockInwrdController>().isselect == true
                        ? SingleChildScrollView(
                            child: Column(children: [
                              inwardAppbar("Stock Inward", theme, context),
                              StockInTabPageviewerSecond(theme: theme),
                            ]),
                          )
                        : Container()
                  ],
                ),
              )),
        );
      }
    });
  }
}
