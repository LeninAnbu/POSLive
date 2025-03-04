import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:posproject/Pages/Customer/Widget/Search.dart';
import 'package:posproject/Pages/Customer/Widget/detailsPage.dart';
import 'package:provider/provider.dart';

import '../../../../Constant/Screen.dart';
import '../../../../Controller/CustomerController/CustomerController.dart';

class TabCustomerScreen extends StatefulWidget {
  const TabCustomerScreen({
    super.key,
  });

  @override
  State<TabCustomerScreen> createState() => _TabCustomerScreenState();
}

class _TabCustomerScreenState extends State<TabCustomerScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(children: [
      Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.withOpacity(0.05),
          ),
          padding: EdgeInsets.only(
              top: Screens.bodyheight(context) * 0.01,
              bottom: Screens.bodyheight(context) * 0.01,
              left: Screens.width(context) * 0.01,
              right: Screens.width(context) * 0.01),
          width: Screens.width(context),
          height: Screens.bodyheight(context) * 0.95,
          child:
              // PageView(
              //   scrollDirection: Axis.vertical,
              //   pageSnapping: true,
              //   controller: context.read<CustomerController>().tappage,
              //   //  physics: new NeverScrollableScrollPhysics(),
              // children: [
              SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Search_Widget(
                    searchHeight: Screens.bodyheight(context),
                    searchWidth: Screens.width(context)),
              ],
            ),
          ),
          // context.read<CustomerController>().cusList1 != null
          //     ? CustomerdetailPage(
          //         searchHeight: Screens.bodyheight(context),
          //         searchWidth: Screens.width(context),
          //         // custMaslist:context.read<CustomerController>().cusList1,
          //       )
          //     : Container()
          // ],
        ),
      ),
      Visibility(
        visible: context.watch<CustomerController>().isScreenLoad,
        child: Container(
          width: Screens.width(context),
          height: Screens.bodyheight(context) * 0.95,
          color: Colors.white60,
          child: Center(
            child: SpinKitFadingCircle(
              size: Screens.bodyheight(context) * 0.08,
              color: theme.primaryColor,
            ),
          ),
        ),
      ),
    ]);
  }
}
