import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Constant/Screen.dart';
import '../../../Controller/PendingOrderController/PendingOrderController.dart';
import '../../../Widgets/Drawer.dart';
import '../Widgets/PendingOrderList.dart';
import 'Mobilescreen/MobileScreen.dart';

class PendingOrderScreens extends StatefulWidget {
  //PendingOrderController
  const PendingOrderScreens({super.key});

  @override
  State<PendingOrderScreens> createState() => _PendingOrderScreensState();
}

class _PendingOrderScreensState extends State<PendingOrderScreens> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<PendingOrderController>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Size size = MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        return ChangeNotifierProvider<PendingOrderController>(
            create: (context) => PendingOrderController(),
            builder: (context, child) {
              return Consumer<PendingOrderController>(
                  builder: (BuildContext context, penOrdCon, Widget? child) {
                return
                    // WillPopScope(
                    //   onWillPop: () async => await logCon.onWillPop(context),
                    //   child:
                    const Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: SafeArea(child: PenOrdMobileScreen()),
                );
              });
            });
      } else if (constraints.maxWidth <= 1300) {
        // return ChangeNotifierProvider<PendingOrderController>(
        //     create: (context) => PendingOrderController(),
        //     builder: (context, child) {
        //       return Consumer<PendingOrderController>(
        //           builder: (BuildContext context, penOrdCon, Widget? child) {
        // WillPopScope(
        //   onWillPop: () async => await logCon.onWillPop(context),
        //   child:
        return Scaffold(
            appBar: AppBar(
              title: const Text('Pending Orders'),
              centerTitle: true,
              backgroundColor: theme.primaryColor,
            ),
            resizeToAvoidBottomInset: true,
            drawer: naviDrawer(),
            body: SafeArea(
                child: PendingorderTab(
              theme: theme,
              btnheight: Screens.bodyheight(context) * 0.28,
              btnWidth: Screens.width(context) * 0.48,
            )));
        // }  )
        // );
        // });
        // }
        // );
      } else {
        return ChangeNotifierProvider<PendingOrderController>(
            create: (context) => PendingOrderController(),
            builder: (context, child) {
              return Consumer<PendingOrderController>(
                  builder: (BuildContext context, penOrdCon, Widget? child) {
                return
                    //  WillPopScope(
                    // onWillPop: () async => await logCon.onWillPop(context),
                    // child:
                    Scaffold(
                        body: SafeArea(
                            child: PendingorderTab(
                  theme: theme,
                  btnheight: Screens.bodyheight(context),
                  btnWidth: Screens.width(context) * 0.48,
                )
                            //  PosLoginScreen(
                            //           logCon: logCon,
                            //         )
                            ));
                // );
              });
            });
      }
    });
    // );
  }
}
