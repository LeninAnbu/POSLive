import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Controller/SalesOrderController/SalesOrderController.dart';
import '../../../Widgets/Drawer.dart';
import '../../../Widgets/MobileDrawer.dart';
import '../Widgets/SOBar.dart';
import 'MobileScreenSales/SalesMS.dart';
import 'TabScreen/BillingTabScreen.dart';

class SalesOrderScreens extends StatefulWidget {
  const SalesOrderScreens({
    super.key,
  });

  @override
  State<SalesOrderScreens> createState() => SalesOrderScreensState();
}

class SalesOrderScreensState extends State<SalesOrderScreens> {
  SOCon? cachedProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Safely obtain the provider and cache it for later use
    cachedProvider = Provider.of<SOCon>(context, listen: false);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SOCon>().init(context, Theme.of(context));
      context.read<SOCon>().requestLocationPermission(context);
      // context.read<SOCon>().getLocation(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        return Scaffold(
          drawer: naviDrawerMob(context),
          body: ChangeNotifierProvider<SOCon>(
              create: (context) => SOCon(), //SOCon
              builder: (context, child) {
                return Consumer<SOCon>(
                    builder: (BuildContext context, prdSCD, Widget? child) {
                  return SafeArea(
                    child: SOSalesMobile(
                      prdCD: prdSCD,
                      // scaffoldKey: scaffoldKey,
                    ),
                  );
                });
              }),
        );
      } else
      //  if (constraints.maxWidth <= 1300)
      {
        //300
        return WillPopScope(
          onWillPop: context.read<SOCon>().onbackpress,
          child: Scaffold(
              // resizeToAvoidBottomInset: false,
              drawer: naviDrawer(),
              body:
                  // ChangeNotifierProvider<SOCon>(
                  //     create: (context) => SOCon(),
                  //     builder: (context, child) {
                  //       return Consumer<SOCon>(
                  //           builder: (BuildContext context, prdSCD, Widget? child) {
                  SafeArea(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(children: <Widget>[
                    soAppbar("Sales Order", theme, context),
                    SObillingTabScreen(
                      theme: theme,
                    ),
                  ]),
                ),
              )),
        );
        //     }
        //   );
        //  }),
        // );
      }
      // else{
      //    return Scaffold(
      //      body: ChangeNotifierProvider<SOCon>(
      //         create: (context) => SOCon(),
      //         builder: (context, child) {
      //           return Consumer<SOCon>(
      //               builder: (BuildContext context, prdSCD, Widget? child) {
      //          return SafeArea(
      //            child: SOPosScreen(
      //                     theme: theme,
      //                     prdSCD: prdSCD,
      //                   ),
      //          );
      //         }
      //       );
      //      }),
      //   );

      // }
    });
  }
}
