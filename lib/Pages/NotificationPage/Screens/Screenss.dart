import 'package:flutter/material.dart';
import 'package:posproject/Controller/SalesInvoice/SalesInvoiceController.dart';
import 'package:provider/provider.dart';
import '../../Sales Screen/Widgets/AppBar/AppBar.dart';
import '../../../Widgets/Drawer.dart';
import '../../../Widgets/MobileDrawer.dart';
import '../Widgets/Notificationpages.dart';

class NotificationMainScreens extends StatefulWidget {
  const NotificationMainScreens({
    super.key,
  });

  @override
  State<NotificationMainScreens> createState() =>
      _NotificationMainScreensState();
}

class _NotificationMainScreensState extends State<NotificationMainScreens> {
  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<PosController>().init(context, Theme.of(context));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        return Scaffold(
            drawer: naviDrawerMob(context), body: SafeArea(child: Container()));
      } else {
        return WillPopScope(
          onWillPop: context.read<PosController>().onbackpress,
          child: Scaffold(
              drawer: naviDrawer(),
              body: SafeArea(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(children: <Widget>[
                    appbar("Notification ", theme, context),
                    TabNotification(),
                  ]),
                ),
              )),
        );
      }
    });
  }
}
