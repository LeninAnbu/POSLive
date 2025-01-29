import 'package:flutter/material.dart';
import 'package:posproject/Controller/SalesInvoice/SalesInvoiceController.dart';
import 'package:posproject/Pages/Sales%20Screen/Screens/TabScreen/BillingTabScreen.dart';

import 'package:provider/provider.dart';
import '../Widgets/AppBar/AppBar.dart';
import '../../../Widgets/Drawer.dart';
import '../../../Widgets/MobileDrawer.dart';
import 'MobileScreenSales/SalesMS.dart';

class PosMainScreens extends StatefulWidget {
  const PosMainScreens({
    super.key,
  });

  @override
  State<PosMainScreens> createState() => _PosMainScreensState();
}

class _PosMainScreensState extends State<PosMainScreens> {
  @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     // Safe to access context-dependent APIs here

  //     FocusScope.of(context).unfocus(); // Example
  //   });
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<PosController>().init(context, Theme.of(context));
    });
  }

  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        return Scaffold(
            drawer: naviDrawerMob(context),
            body:

                // ChangeNotifierProvider<PosController>(
                //     create: (context) => PosController(),
                //     builder: (context, child) {
                //       return Consumer<PosController>(
                //           builder: (BuildContext context, prdSCD, Widget? child) {

                SafeArea(
              child: SalesMobile(prdCD: context.read<PosController>()
                  // scaffoldKey: scaffoldKey,
                  ),
            ));
      }
      // }),

      else
      // if (constraints.maxWidth <= 1300)
      {
        //300
        return WillPopScope(
          onWillPop: context.read<PosController>().onbackpress,
          child: Scaffold(
              // resizeToAvoidBottomInset: false,
              drawer: naviDrawer(),
              body: SafeArea(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(children: <Widget>[
                    appbar("Sales ", theme, context),
                    SalesInvoiceTabScreen(
                      theme: theme,
                    ),
                  ]),
                ),
              )),
        );
        // });
        // }));
      }
      // else {
      //   return Scaffold(
      //     body: ChangeNotifierProvider<PosController>(
      //         create: (context) => PosController(),
      //         builder: (context, child) {
      //           return Consumer<PosController>(
      //               builder: (BuildContext context, prdSCD, Widget? child) {
      //             return SafeArea(
      //               child: PosScreen(
      //                 theme: theme,
      //                 prdSCD: prdSCD,
      //               ),
      //             );
      //           });
      //         }),
      //   );
      // }
    });
  }
}
