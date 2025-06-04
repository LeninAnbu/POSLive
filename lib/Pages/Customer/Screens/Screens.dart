import 'package:flutter/material.dart';
import 'package:posproject/Pages/Customer/Widget/AppBar.dart';
import 'package:provider/provider.dart';

import '../../../Controller/CustomerController/CustomerController.dart';
import '../../../Widgets/Drawer.dart';

import 'TabCustomerScreen/TabStockSreen.dart';

class CustomerMainScreens extends StatefulWidget {
  const CustomerMainScreens({
    super.key,
  });
// CustomerController custCon;
  @override
  State<CustomerMainScreens> createState() => _CustomerMainScreensState();
}

class _CustomerMainScreensState extends State<CustomerMainScreens> {
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
      return WillPopScope(
        onWillPop: context.read<CustomerController>().onbackpress,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            drawer: naviDrawer(),
            appBar: appbar(
              "Customer ",
              theme,
              context,
            ),
            body: SafeArea(
              child: TabCustomerScreen(),
            )),
      );
    });
  }
}
