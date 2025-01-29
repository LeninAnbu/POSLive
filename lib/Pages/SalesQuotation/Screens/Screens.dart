import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Controller/SalesQuotationController/SalesQuotationController.dart';
import '../../../Widgets/Drawer.dart';
import '../Widgets/SQAppBar.dart';
import 'TabScreen/SQTabScreen.dart';

class SalesQuotationScreens extends StatefulWidget {
  const SalesQuotationScreens({
    super.key,
  });

  @override
  State<SalesQuotationScreens> createState() => SalesQuotationScreensState();
}

class SalesQuotationScreensState extends State<SalesQuotationScreens> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SalesQuotationCon>().init(context, Theme.of(context));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      // if (constraints.maxWidth <= 800) {
      //   return Scaffold(
      //      drawer: naviDrawerMob(context),
      //      body:
      //      ChangeNotifierProvider<SOCon>(
      //         create: (context) => SOCon(),//SOCon
      //         builder: (context, child) {
      //           return Consumer<SOCon>(
      //               builder: (BuildContext context, prdSCD, Widget? child) {
      //         return   SafeArea(
      //             child: SOSalesMobile(prdCD: prdSCD,
      //                    // scaffoldKey: scaffoldKey,
      //                   ),
      //           );
      //         }
      //       );
      //      }),
      //   );
      // } else

      //  if (constraints.maxWidth <= 1300) {
      return WillPopScope(
        onWillPop: context.read<SalesQuotationCon>().onbackpress,
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
                  sqAppbar("Sales Quotation", theme, context),
                  SQuotationbillingTabScreen(
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
      // }
      // else{
      //    return Scaffold(
      //      body: ChangeNotifierProvider<SalesQuotationCon>(
      //         create: (context) => SalesQuotationCon(),
      //         builder: (context, child) {
      //           return Consumer<SalesQuotationCon>(
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
