import 'package:flutter/material.dart';
import 'package:posproject/Pages/Expenses/MobScreen/AppBar/ExpAppBarMS.dart';
import 'package:posproject/Pages/Expenses/MobScreen/MobScreen.dart';
import 'package:posproject/Pages/Expenses/widgets/TabappbarExpense.dart';
import 'package:provider/provider.dart';

import '../../Constant/Screen.dart';
import '../../Controller/ExpenseController/ExpenseController.dart';
import '../../Widgets/Drawer.dart';
import '../../Widgets/MobileDrawer.dart';
import 'TabScreen/TabExpenseScreen.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({
    super.key,
  });

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ExpenseController>().clearData();
      context.read<ExpenseController>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        return Scaffold(
          drawer: naviDrawerMob(context),
          body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
              children: [
                appbarMSExpense("Expense ", theme, context,
                    context.read<ExpenseController>()),
                const MobScreen(),
              ],
            )),
          ),
        );
      } else //if (constraints.maxWidth <= 1300)
      {
        return WillPopScope(
          onWillPop: context.read<ExpenseController>().onbackpress,
          child: Scaffold(
            backgroundColor: Colors.grey[300],
            resizeToAvoidBottomInset: true,
            drawer: naviDrawer(),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  appbarTabExpense(
                    "Expenses ",
                    theme,
                    context,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: Screens.padingHeight(context) * 0.02,
                        left: Screens.width(context) * 0.02,
                        right: Screens.width(context) * 0.02,
                        bottom: Screens.padingHeight(context) * 0.02),
                    child: const TabExpenseScreen(),
                  ),
                ]),
              ),
            ),
          ),
        );
      }
    });
  }
}
