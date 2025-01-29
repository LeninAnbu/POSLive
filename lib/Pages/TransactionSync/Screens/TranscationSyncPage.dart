import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Controller/TransacationSyncController/TransactionSyncController.dart';
import 'package:posproject/Pages/TransactionSync/Widgets/SyncDataList.dart';
import 'package:posproject/Widgets/Drawer.dart';
import 'package:provider/provider.dart';

class TransactionSyncScreen extends StatefulWidget {
  const TransactionSyncScreen({
    super.key,
  });

  @override
  State<TransactionSyncScreen> createState() => _TransactionSyncScreenState();
}

class _TransactionSyncScreenState extends State<TransactionSyncScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        // context.read<TransactionSyncController>().clearDataAll();
        context.read<TransactionSyncController>().init();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: naviDrawer(),
      appBar: AppBar(
        title: const Text("Transcation Sync"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  context.read<TransactionSyncController>().loadingbtn = true;
                  context.read<TransactionSyncController>().refreshQueue22();
                });
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Container(
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
        height: Screens.bodyheight(context) * 0.995,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SyncdataListPage(
                  //
                  searchHeight: Screens.bodyheight(context),
                  searchWidth: Screens.width(context))
            ],
          ),
        ),
      ),
    );
  }
}
