import 'package:flutter/material.dart';
import 'package:posproject/Pages/Customer/Widget/AppBar.dart';
import 'package:provider/provider.dart';

import '../../../Controller/CustomerController/CustomerController.dart';
import '../../../Widgets/Drawer.dart';

import 'TabCustomerScreen/TabStockSreen.dart';

class CustomerMainScreens extends StatefulWidget {
  const CustomerMainScreens({
    super.key,
    // required this.custCon,
  });
// CustomerController custCon;
  @override
  State<CustomerMainScreens> createState() => _CustomerMainScreensState();
}

class _CustomerMainScreensState extends State<CustomerMainScreens> {
  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CustomerController>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      // if (constraints.maxWidth <= 800) {
      //   return ChangeNotifierProvider<CustomerController>(
      //       create: (context) => CustomerController(),
      //       builder: (context, child) {
      //         return Consumer<CustomerController>(
      //             builder: (BuildContext context, stkCtrl, Widget? child) {
      //           return WillPopScope(
      //             onWillPop:stkCtrl.onbackpress,
      //             child: Scaffold(
      //               appBar: appbarMS("Customer ", theme, context),
      //               drawer: naviDrawerMob(context),
      //               body: SafeArea(
      //                 child: SingleChildScrollView(
      //                   child: Container(
      //                     child: Column(
      //                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       children: [
      //                         MobCustomerScreens(
      //                           stkCtrl: stkCtrl,

      //                           // scaffoldKey: scaffoldKey,
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           );
      //         });
      //       });
      // } else {
      //300
      return
          // ChangeNotifierProvider<CustomerController>(
          //     create: (context) => CustomerController(),
          //     builder: (context, child) {
          //       return Consumer<CustomerController>(
          //           builder: (BuildContext context, stkCtrl, Widget? child) {
          //         return
          WillPopScope(
        onWillPop: context.read<CustomerController>().onbackpress,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            drawer: naviDrawer(),
            appBar: appbar(
              "Customer ",
              theme,
              context,
            ),
            body: const SafeArea(
              child: TabCustomerScreen(),
            )),
      );
      //   });
      // });
      // }
    });
  }
}
