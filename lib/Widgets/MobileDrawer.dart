import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Constant/SharedPreference.dart';
import 'package:posproject/Pages/LoginScreen/LoginScreen.dart';
import 'package:posproject/Pages/Sales%20Screen/Screens/Screens.dart';
import 'package:posproject/Pages/SalesReturn/Screens.dart';
import 'package:posproject/Pages/Settlement/Screens/SettlementScreen.dart';
import '../Constant/ConstantRoutes.dart';
import '../Pages/Expenses/ExpenseScreen.dart';
import '../Pages/PaymentReceipt/Screens/Screens.dart';
import '../Pages/StockRequest/Screens/Screens.dart';
import '../Pages/Stockslist/Screens/Screens.dart';

Drawer naviDrawerMob(BuildContext context) {
  final theme = Theme.of(context);
  return Drawer(
    child: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Screens.bodyheight(context) * 0.04,
            ),
            Container(
              alignment: Alignment.center,
              height: Screens.bodyheight(context) * 0.12,
              width: Screens.width(context) * 0.32,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: theme.primaryColor,
                      width: Screens.width(context) * 0.01),
                  shape: BoxShape.circle),
              child: Text(
                "POS",
                style: theme.textTheme.titleLarge!
                    .copyWith(color: theme.primaryColor, shadows: [
                  Shadow(
                      offset: const Offset(-1.5, -1.5),
                      color: Colors.grey[200]!),
                  const Shadow(offset: Offset(1.5, -1.5), color: Colors.white),
                ]),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/NavIcons/salepost.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                ),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.pushNamed(context, '/DashBoardScreen');
                },
                title: const Text(
                  "DashBoard",
                ),
              ),
            ),
            ListTile(
              leading: Image.asset(
                'assets/NavIcons/Neworder.png',
                fit: BoxFit.fill,
                height: Screens.bodyheight(context) * 0.05,
                width: Screens.width(context) * 0.08,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PosMainScreens()));
              },
              title: const Text(
                "Sales",
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/NavIcons/easypost.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SalesReturnScreens(),
                      ));
                },
                title: const Text(
                  "Sales Return",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/NavIcons/checkcard.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PaymentReceiptScreens()));
                },
                title: const Text(
                  "Payment Receipt",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/NavIcons/changepost.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StockReqScreens()));
                },
                title: const Text(
                  "Stock Request",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/NavIcons/salepost.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
                title: const Text(
                  "Stock Inward",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/NavIcons/addItem.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
                title: const Text(
                  "Stock Outward",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/NavIcons/checkcard.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                ),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StockMainScreens(
                                theme: theme,
                              )));
                },
                title: const Text(
                  "Stocks",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/Drawer/just-in-time.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                ),
                onTap: () {},
                title: const Text(
                  "Refunds",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/NavIcons/tax.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ExpenseScreen()));
                },
                title: const Text(
                  "Expenses",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/NavIcons/promotion.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DepositScreen()));
                },
                title: const Text(
                  "Settlements",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/NavIcons/salesperson.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                ),
                onTap: () {
                  Get.toNamed(ConstantRoutes.stockCheck);
                },
                title: const Text(
                  "Stock Check",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/NavIcons/salesperson.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                ),
                onTap: () {},
                title: const Text(
                  "Customers",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/NavIcons/salesperson.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                ),
                onTap: () {},
                title: const Text(
                  "Cash Statement",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/NavIcons/salesperson.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                ),
                onTap: () {},
                title: const Text(
                  "Pending Order",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/NavIcons/salesperson.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                ),
                onTap: () {},
                title: const Text(
                  "Stock Register",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/NavIcons/salesperson.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                ),
                onTap: () {},
                title: const Text(
                  "Return Register",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/NavIcons/more.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                ),
                onTap: () {
                  Get.toNamed(ConstantRoutes.stockReplenish);
                },
                title: const Text(
                  "Stock Replenish",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/NavIcons/more.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                ),
                onTap: () async {
                  SharedPref.clearDeviceID();
                  SharedPref.clearHost();
                  SharedPref.clearLoggedIN();
                  SharedPref.clearSiteCode();
                  SharedPref.clearUserSP();
                  SharedPref.clrLicenseSP();
                  SharedPref.clrUserIdSP();
                  SharedPref.clrBranchSSP();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => false);
                },
                title: const Text(
                  "LogOut",
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
