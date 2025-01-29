import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Controller/ReconciliationController/RecoController.dart';
import '../../../Widgets/Drawer.dart';
import 'TabScree.dart';

class ReconciliationScreens extends StatefulWidget {
  const ReconciliationScreens({super.key});

  @override
  State<ReconciliationScreens> createState() => _ReconciliationScreensState();
}

class _ReconciliationScreensState extends State<ReconciliationScreens> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Size size = MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        return ChangeNotifierProvider<ReconciliationCtrl>(
            create: (context) => ReconciliationCtrl(),
            builder: (context, child) {
              return Consumer<ReconciliationCtrl>(
                  builder: (BuildContext context, penOrdCon, Widget? child) {
                return
                    // WillPopScope(
                    //   onWillPop: () async => await logCon.onWillPop(context),
                    //   child:
                    Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: SafeArea(child: Container()),
                );
              });
            });
      } else if (constraints.maxWidth <= 1300) {
        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text('Internal Reconciliation'),
              centerTitle: true,
              backgroundColor: theme.primaryColor,
            ),
            resizeToAvoidBottomInset: true,
            drawer: naviDrawer(),
            body: SafeArea(
                // child:
                // SingleChildScrollView(
                // scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
              child:
                  //  Stack(
                  //   children: [
                  RecoTabScreens(),
              // Visibility(
              //   visible:
              //       context.watch<ReconciliationCtrl>().onDisablebutton,
              //   child: Container(
              //     width: Screens.width(context),
              //     height: Screens.bodyheight(context),
              //     color: Colors.white60,
              //     child: Center(
              //       child: SpinKitFadingCircle(
              //         size: Screens.bodyheight(context) * 0.08,
              //         color: theme.primaryColor,
              //       ),
              //     ),
              //   ),
              // ),
              //   ],
              // ),
            )));

        // );
      } else {
        return ChangeNotifierProvider<ReconciliationCtrl>(
            create: (context) => ReconciliationCtrl(),
            builder: (context, child) {
              return Consumer<ReconciliationCtrl>(
                  builder: (BuildContext context, penOrdCon, Widget? child) {
                return Scaffold(body: SafeArea(child: Container()));
                // );
              });
            });
      }
    });
    // );
  }
}
