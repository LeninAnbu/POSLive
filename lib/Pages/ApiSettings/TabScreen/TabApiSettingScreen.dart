import 'package:flutter/material.dart';
import 'package:posproject/main.dart';
import 'package:provider/provider.dart';

import '../../../Constant/Screen.dart';
import '../../../Controller/ApiSettingsController/ApiSettingsController.dart';
import '../../../Widgets/Drawer.dart';

class TabApiSettingsScreen extends StatefulWidget {
  const TabApiSettingsScreen({
    super.key,
  });

  @override
  State<TabApiSettingsScreen> createState() => TabApiSettingsScreenState();
}

class TabApiSettingsScreenState extends State<TabApiSettingsScreen> {
  static bool? progress = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        context.read<ApiSettingsController>().init();
        receivervb();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: naviDrawer(),
      appBar: AppBar(
        title: const Text("Settings"),
        actions: const [],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(
            top: Screens.padingHeight(context) * 0.03,
            left: Screens.width(context) * 0.02,
            right: Screens.width(context) * 0.02,
            bottom: Screens.padingHeight(context) * 0.03),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: Screens.width(context) * 0.7,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          " Item Master",
                          style: theme.textTheme.titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Container(
                      padding:
                          EdgeInsets.all(Screens.bodyheight(context) * 0.01),
                      height: Screens.bodyheight(context) * 0.09,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Item Master",
                            style: theme.textTheme.titleLarge!.copyWith(),
                          ),
                          Row(
                            children: [
                              context
                                          .watch<ApiSettingsController>()
                                          .progressItemMaster ==
                                      true
                                  ? SizedBox(
                                      width: Screens.width(context) * 0.02,
                                      height:
                                          Screens.bodyheight(context) * 0.04,
                                      child: CircularProgressIndicator())
                                  : IconButton(
                                      iconSize:
                                          Screens.bodyheight(context) * 0.05,
                                      onPressed: () {
                                        setState(() {
                                          context
                                              .read<ApiSettingsController>()
                                              .getItemMasterData(
                                                  context, theme);
                                        });
                                      },
                                      icon: Icon(Icons.sync)),
                              SizedBox(
                                  height: Screens.bodyheight(context),
                                  child: Checkbox(
                                      value: context
                                                  .watch<
                                                      ApiSettingsController>()
                                                  .itemMasterCount ==
                                              0
                                          ? false
                                          : true,
                                      onChanged: (value) {})),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.all(Screens.bodyheight(context) * 0.01),
                      height: Screens.bodyheight(context) * 0.09,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Product Master",
                            style: theme.textTheme.titleLarge!.copyWith(),
                          ),
                          Row(
                            children: [
                              context
                                          .read<ApiSettingsController>()
                                          .progressProductMaster ==
                                      true
                                  ? SizedBox(
                                      width: Screens.width(context) * 0.02,
                                      height:
                                          Screens.bodyheight(context) * 0.04,
                                      child: CircularProgressIndicator())
                                  : IconButton(
                                      iconSize:
                                          Screens.bodyheight(context) * 0.05,
                                      onPressed: () {
                                        setState(() {
                                          context
                                              .read<ApiSettingsController>()
                                              .getProductMasterData(
                                                  context, theme);
                                        });
                                      },
                                      icon: Icon(Icons.sync)),
                              SizedBox(
                                  height: Screens.bodyheight(context),
                                  child: Checkbox(
                                      value: context
                                                  .watch<
                                                      ApiSettingsController>()
                                                  .productMasterCount ==
                                              0
                                          ? false
                                          : true,
                                      onChanged: (value) {})),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.all(Screens.bodyheight(context) * 0.01),
                      height: Screens.bodyheight(context) * 0.09,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Branch Master",
                            style: theme.textTheme.titleLarge!.copyWith(),
                          ),
                          Row(
                            children: [
                              context
                                          .read<ApiSettingsController>()
                                          .progressBranchMaster ==
                                      true
                                  ? SizedBox(
                                      width: Screens.width(context) * 0.02,
                                      height:
                                          Screens.bodyheight(context) * 0.04,
                                      child: CircularProgressIndicator())
                                  : IconButton(
                                      iconSize:
                                          Screens.bodyheight(context) * 0.05,
                                      onPressed: () {
                                        setState(() {
                                          context
                                              .read<ApiSettingsController>()
                                              .getBranchMasterData(
                                                  context, theme);
                                        });
                                      },
                                      icon: Icon(Icons.sync)),
                              SizedBox(
                                  height: Screens.bodyheight(context),
                                  child: Checkbox(
                                      value: context
                                                  .watch<
                                                      ApiSettingsController>()
                                                  .branchMasterCount ==
                                              0
                                          ? false
                                          : true,
                                      onChanged: (value) {})),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.all(Screens.bodyheight(context) * 0.01),
                      height: Screens.bodyheight(context) * 0.09,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Customer Master",
                            style: theme.textTheme.titleLarge!.copyWith(),
                          ),
                          Row(
                            children: [
                              context
                                          .read<ApiSettingsController>()
                                          .progressCustomerMaster ==
                                      true
                                  ? SizedBox(
                                      width: Screens.width(context) * 0.02,
                                      height:
                                          Screens.bodyheight(context) * 0.04,
                                      child: CircularProgressIndicator())
                                  : IconButton(
                                      iconSize:
                                          Screens.bodyheight(context) * 0.05,
                                      onPressed: () {
                                        setState(() {
                                          context
                                              .read<ApiSettingsController>()
                                              .getCustomerMasterData(
                                                  context, theme);
                                        });
                                      },
                                      icon: Icon(Icons.sync)),
                              SizedBox(
                                  height: Screens.bodyheight(context),
                                  child: Checkbox(
                                      value: context
                                                  .watch<
                                                      ApiSettingsController>()
                                                  .customerMasterCount ==
                                              0
                                          ? false
                                          : true,
                                      onChanged: (value) {})),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.all(Screens.bodyheight(context) * 0.01),
                      height: Screens.bodyheight(context) * 0.09,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Customer Address Master",
                            style: theme.textTheme.titleLarge!.copyWith(),
                          ),
                          Row(
                            children: [
                              context
                                          .read<ApiSettingsController>()
                                          .progressCustomerAddressMaster ==
                                      true
                                  ? SizedBox(
                                      width: Screens.width(context) * 0.02,
                                      height:
                                          Screens.bodyheight(context) * 0.04,
                                      child: CircularProgressIndicator())
                                  : IconButton(
                                      iconSize:
                                          Screens.bodyheight(context) * 0.05,
                                      onPressed: () {
                                        setState(() {
                                          context
                                              .read<ApiSettingsController>()
                                              .getCustomerAddressMasterData(
                                                  context, theme);
                                        });
                                      },
                                      icon: Icon(Icons.sync)),
                              SizedBox(
                                  height: Screens.bodyheight(context),
                                  child: Checkbox(
                                      value: context
                                                  .watch<
                                                      ApiSettingsController>()
                                                  .customerAddressMasterCount ==
                                              0
                                          ? false
                                          : true,
                                      onChanged: (value) {})),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
