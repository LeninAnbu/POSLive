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
  // PosController posController = PosController();
  final theme = Theme.of(context);
  return Drawer(
    child: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // shrinkWrap: true,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  // borderRadius: BorderRadius.circular(6),
                  shape: BoxShape.circle),
              child: Text(
                "POS",
                style: theme.textTheme.titleLarge!
                    .copyWith(color: theme.primaryColor, shadows: [
                  Shadow(
                      // bottomLeft
                      offset: const Offset(-1.5, -1.5),
                      color: Colors.grey[200]!),
                  const Shadow(
                      // bottomRight
                      offset: Offset(1.5, -1.5),
                      color: Colors.white),
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
                  // color: drawercolor.Dcolor,
                ),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.pushNamed(context, '/DashBoardScreen');
                  // Navigator.pop(context);

                  //  Get.toNamed(ConstantRoutes.Login);
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
                // color: drawercolor.Dcolor,
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
                // style: GoogleFonts.poppins(
                //     color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/NavIcons/easypost.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                  // color: drawercolor.Dcolor,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SalesReturnScreens(),
                      ));

                  // Navigator.pop(context);
                  // Get.toNamed(ConstantRoutes.NewReminder);
                },
                title: const Text(
                  "Sales Return",
                  // style: GoogleFonts.poppins(
                  //     color: Colors.black, fontWeight: FontWeight.w500),
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
                  // color: drawercolor.Dcolor,
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
                  // color: drawercolor.Dcolor,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StockReqScreens()));
                  // Navigator.pop(context);
                  //  Get.toNamed(ConstantRoutes.Login);
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
                  // color: drawercolor.Dcolor,
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => StockInwardScreens()));
                  // Navigator.pop(context);

                  //  Get.toNamed(ConstantRoutes.Login);
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
                  // color: drawercolor.Dcolor,
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => StockOutwardScreens()));
                  //  Navigator.pop(context);
                  //  Get.toNamed(ConstantRoutes.Login);
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
                  // color: drawercolor.Dcolor,
                ),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StockMainScreens(
                                theme: theme,
                              )));
                  //  Navigator.pop(context);
                  // paymentReceiptScreens(theme: theme),
                  //  Get.toNamed(ConstantRoutes.Login);
                },
                title: const Text(
                  "Stocks",
                ),
              ),
            ),
            // StockMainScreens
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/Drawer/just-in-time.png',
                  fit: BoxFit.fill,

                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                  // color: drawercolor.Dcolor,
                ),
                onTap: () {
                  //  Get.toNamed(ConstantRoutes.Login);
                },
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
                  //  Get.toNamed(ConstantRoutes.Login);
                  //  Navigator.pop(context);
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
                  //  Get.toNamed(ConstantRoutes.Login);
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
                onTap: () {
                  //  Get.toNamed(ConstantRoutes.Login);
                },
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
                onTap: () {
                  //  Get.toNamed(ConstantRoutes.Login);
                },
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
                onTap: () {
                  //  Get.toNamed(ConstantRoutes.Login);
                },
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
                onTap: () {
                  //  Get.toNamed(ConstantRoutes.Login);
                },
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
                onTap: () {
                  //  Get.toNamed(ConstantRoutes.Login);
                },
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
