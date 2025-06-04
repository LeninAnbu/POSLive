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
      return WillPopScope(
        onWillPop: context.read<SalesQuotationCon>().onbackpress,
        child: Scaffold(
            drawer: naviDrawer(),
            body: SafeArea(
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
    });
  }
}
