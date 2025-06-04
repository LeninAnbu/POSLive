import 'package:flutter/material.dart';
import 'package:posproject/Pages/SalesReturn/SalesReturnScreens/PosScreen/PosScreen.dart';
import 'package:posproject/Pages/SalesReturn/SalesReturnScreens/TabScreen/TabScreen.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/Drawer.dart';
import '../../Controller/SalesReturnController/SalesReturnController.dart';
import '../../Widgets/MobileDrawer.dart';
import 'SalesReturnScreens/MobileScreen/SalesReturnMS.dart';
import 'Widget/SalesReturnAppbar.dart';

class SalesReturnScreens extends StatefulWidget {
  const SalesReturnScreens({
    super.key,
  });

  @override
  State<SalesReturnScreens> createState() => _SalesReturnScreensState();
}

class _SalesReturnScreensState extends State<SalesReturnScreens> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SalesReturnController>().init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        return Scaffold(
          drawer: naviDrawerMob(context),
          body: ChangeNotifierProvider<SalesReturnController>(
              create: (context) => SalesReturnController(),
              builder: (context, child) {
                return Consumer<SalesReturnController>(
                    builder: (BuildContext context, prdSCD, Widget? child) {
                  return SafeArea(
                      child: SalesReturnMobile(
                    salesReturnController: prdSCD,
                  ));
                });
              }),
        );
      } else if (constraints.maxWidth <= 1300) {
        return WillPopScope(
          onWillPop: context.read<SalesReturnController>().onbackpress,
          child: Scaffold(
              // resizeToAvoidBottomInset: false,
              drawer: naviDrawer(),
              body: SingleChildScrollView(
                child: SafeArea(
                    child: Column(children: [
                  salesReturnappbar(
                    "Sales Return",
                    theme,
                    context,
                  ),
                  SalesReturnTabScreen(
                    theme: theme,
                  ),
                ])),
              )),
        );
      } else {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: ChangeNotifierProvider<SalesReturnController>(
              create: (context) => SalesReturnController(),
              builder: (context, child) {
                return Consumer<SalesReturnController>(
                    builder: (BuildContext context, prdSCD, Widget? child) {
                  return SafeArea(
                    child: SalesReturnPosScreen(
                      theme: theme,
                      prdSR: prdSCD,
                    ),
                  );
                });
              }),
        );
      }
    });
  }
}
