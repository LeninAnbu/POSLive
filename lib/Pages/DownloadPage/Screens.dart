import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Controller/DownLoadController/DownloadController.dart';
import 'Widgets/DownloadPage.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({
    super.key,
  });

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DownLoadController>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        return const Scaffold(
            // drawer: naviDrawerMob(context),
            body:
                // ChangeNotifierProvider<DownLoadController>(
                //     create: (context) => DownLoadController(),
                //     builder: (context, child) {
                //       return Consumer<DownLoadController>(
                //           builder: (BuildContext context, ExpenseCon, Widget? child) {
                SafeArea(child: DownloadPage()));
        //   });
        // }),
      } else {
        return Scaffold(
            backgroundColor: Colors.grey[300],
            resizeToAvoidBottomInset: false,
            // drawer: naviDrawer(),
            body:
                // ChangeNotifierProvider<DownLoadController>(
                //     create: (context) => DownLoadController(),
                //     builder: (context, child) {
                //     return Consumer<DownLoadController>(
                //     builder: (BuildContext context, ExpenseCon, Widget? child) {
                const SafeArea(child: DownloadPage())
            //   });
            // }),
            );
      }
    });
  }
}
