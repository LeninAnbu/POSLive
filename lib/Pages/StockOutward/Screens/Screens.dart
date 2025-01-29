import 'package:flutter/material.dart';
import 'package:posproject/Pages/StockOutward/Screens/TabScreen/StockOutTab.dart';
import 'package:posproject/Pages/StockOutward/Widgets/M_StOut_Appbar.dart';
import 'package:provider/provider.dart';
import '../../../Controller/StockOutwardController/StockOutwardController.dart';
import '../../../Widgets/Drawer.dart';
import '../../../Widgets/MobileDrawer.dart';
import '../Widgets/SToutward_Appbar.dart';
import '../Widgets/Tap_stockOutItemDeatils.dart';
import 'MobileScreen/Screens/StockOutward.dart';

class StockOutwardScreens extends StatefulWidget {
  const StockOutwardScreens({
    super.key,
  });

  @override
  State<StockOutwardScreens> createState() => _StockOutwardScreensState();
}

class _StockOutwardScreensState extends State<StockOutwardScreens> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        context.read<StockOutwardController>().clearDataAll();
        context.read<StockOutwardController>().selectedcust = null;

        context.read<StockOutwardController>().init(context);

        context.read<StockOutwardController>().adddlistner();
      });
    });
  }

  @override
  void dispose() {
    // context.read<StockOutwardController>().pageController.dispose();
    // context.read<StockOutwardController>().disposmethod();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        return ChangeNotifierProvider<StockOutwardController>(
            create: (context) => StockOutwardController(),
            builder: (context, child) {
              return Consumer<StockOutwardController>(
                  builder: (BuildContext context, stOutCon, Widget? child) {
                return Scaffold(
                    resizeToAvoidBottomInset: false,
                    appBar:
                        stOutAppbar("Stock Outward", theme, context, stOutCon),
                    drawer: naviDrawerMob(context),
                    // drawer: M_naviDrawer(),
                    backgroundColor: Colors.grey[200],
                    body: SafeArea(
                      child: StockOutward(theme: theme, soutCon: stOutCon),
                    ));
              });
            });
      } else {
        return WillPopScope(
          onWillPop: context.read<StockOutwardController>().onbackpress3,
          child: Scaffold(
              drawer: naviDrawer(),
              body:
                  // ChangeNotifierProvider<StockOutwardController>(
                  //     create: (context) => StockOutwardController(),
                  //     builder: (context, child) {
                  //       return Consumer<StockOutwardController>(
                  //           builder: (BuildContext context, prdSCD, Widget? child) {
                  //         return LayoutBuilder(builder: (context, constraints) {
                  //           return
                  SingleChildScrollView(
                child: Column(
                  // scrollDirection: Axis.horizontal,
                  // pageSnapping: true,
                  // controller: context.read<StockOutwardController>().pageController,
                  // physics: new NeverScrollableScrollPhysics(),
                  // onPageChanged: (index) {
                  //   log("index: $index");
                  //   setState(() {
                  //     context.read<StockOutwardController>().currentPage = index;
                  //   });
                  //   // print(context.read<StockOutwardController>().currentPage);
                  // },
                  children: [
                    context.watch<StockOutwardController>().isselect == false
                        ? SingleChildScrollView(
                            child: Column(children: [
                              outwardAppbar(
                                "Stock Outward",
                                theme,
                                context,
                              ),
                              StockOutTab(
                                theme: theme,
                              ),
                            ]),
                          )
                        : Container(),
                    context.watch<StockOutwardController>().isselect == true
                        ? Column(children: [
                            outwardAppbar(
                              "Stock Outward",
                              theme,
                              context,
                            ),
                            StockOutTabPageviewerSecond(
                              theme: theme,
                            ),
                          ])
                        : Container(),
                  ],
                  // ),
                  // });
                  //   });
                  // }
                ),
              )),
        );
      }
      // else {
      //   return Scaffold(
      //       body: ChangeNotifierProvider<StockOutwardController>(
      //           create: (context) => StockOutwardController(),
      //           builder: (context, child) {
      //             return Consumer<StockOutwardController>(
      //                 builder: (BuildContext context, prdSCD, Widget? child) {
      //               return LayoutBuilder(builder: (context, constraints) {
      //                 return SafeArea(
      //                   child: StockOutPos(
      //                     theme: theme,
      //                     StOut_Con: prdSCD,
      //                   ),
      //                 );
      //               });
      //             });
      //           }));
      // }
    });
  }
}
