import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posproject/Constant/Screen.dart';

import '../Constant/ConstantRoutes.dart';

import '../Pages/Reports/NewreportsPage.dart';

import '../Pages/Stockslist/Screens/Screens.dart';

class naviDrawer extends StatefulWidget {
  naviDrawer({super.key});

  @override
  State<naviDrawer> createState() => _naviDrawerState();
}

class _naviDrawerState extends State<naviDrawer> {
  List<String> reports = [
    'TRA Invoices user specific-1',
    'Sales & Volume Sales report',
    'NetPendingOrder_R1',
    'CONSOLIDATED SALES IN DAY_R1',
    'DAILY COLLECTION REPORT_R1'
  ];

  bool viewList = false;
  toggleViewList() {
    setState(() {
      viewList = !viewList;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    const Shadow(
                        offset: Offset(1.5, -1.5), color: Colors.white),
                  ]),
                ),
              ),
              Builder(
                builder: (context) => ListTile(
                  leading: Image.asset(
                    'assets/Drawer/dashboard.png',
                    fit: BoxFit.fill,
                    height: Screens.bodyheight(context) * 0.035,
                    width: Screens.width(context) * 0.02,
                  ),
                  onTap: () {
                    Navigator.pop(context);

                    Get.toNamed(ConstantRoutes.dashboard);
                  },
                  title: const Text(
                    "Dashboard",
                  ),
                ),
              ),
              Builder(builder: (context) {
                return ListTile(
                  leading: Image.asset(
                    'assets/Drawer/salesorder.png',
                    fit: BoxFit.fill,
                    height: Screens.bodyheight(context) * 0.038,
                    width: Screens.width(context) * 0.024,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(ConstantRoutes.salesQuotation);
                  },
                  title: const Text(
                    "Sales Quotation",
                  ),
                );
              }),
              Builder(builder: (context) {
                return ListTile(
                  leading: Image.asset(
                    'assets/Drawer/quotation.png',
                    fit: BoxFit.fill,
                    height: Screens.bodyheight(context) * 0.038,
                    width: Screens.width(context) * 0.024,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(ConstantRoutes.salesOrder);
                  },
                  title: const Text(
                    "Sales Order",
                  ),
                );
              }),
              Builder(builder: (context) {
                return ListTile(
                  leading: Image.asset(
                    'assets/Drawer/sales.png',
                    fit: BoxFit.fill,
                    height: Screens.bodyheight(context) * 0.038,
                    width: Screens.width(context) * 0.024,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(ConstantRoutes.sales);
                  },
                  title: const Text(
                    "Sales",
                  ),
                );
              }),
              Builder(
                builder: (context) => ListTile(
                  leading: Image.asset(
                    'assets/Drawer/exchange.png',
                    fit: BoxFit.fill,
                    height: Screens.bodyheight(context) * 0.038,
                    width: Screens.width(context) * 0.024,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(ConstantRoutes.salesReturn);
                  },
                  title: const Text(
                    "Sales Return",
                  ),
                ),
              ),
              Builder(
                builder: (context) => ListTile(
                  leading: Image.asset(
                    'assets/Drawer/bill.png',
                    fit: BoxFit.fill,
                    height: Screens.bodyheight(context) * 0.038,
                    width: Screens.width(context) * 0.024,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(ConstantRoutes.paymentReciept);
                  },
                  title: const Text(
                    "Payment Receipt",
                  ),
                ),
              ),
              Builder(
                builder: (context) => ListTile(
                  leading: Image.asset(
                    'assets/Drawer/demand.png',
                    fit: BoxFit.fill,
                    height: Screens.bodyheight(context) * 0.045,
                    width: Screens.width(context) * 0.026,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(ConstantRoutes.stockRequest);
                  },
                  title: const Text(
                    "Inventory Transfer Request",
                  ),
                ),
              ),
              Builder(
                builder: (context) => ListTile(
                  leading: Image.asset(
                    'assets/Drawer/just-in-time.png',
                    fit: BoxFit.fill,
                    height: Screens.bodyheight(context) * 0.038,
                    width: Screens.width(context) * 0.024,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(ConstantRoutes.stockOutward);
                  },
                  title: const Text(
                    "Stock Outward",
                  ),
                ),
              ),
              Builder(
                builder: (context) => ListTile(
                  leading: Image.asset(
                    'assets/Drawer/receive.png',
                    fit: BoxFit.fill,
                    height: Screens.bodyheight(context) * 0.038,
                    width: Screens.width(context) * 0.024,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(ConstantRoutes.stockInward);
                  },
                  title: const Text(
                    "Stock Inward",
                  ),
                ),
              ),
              Builder(
                builder: (context) => ListTile(
                  leading: Image.asset(
                    'assets/Drawer/stocklist.png',
                    fit: BoxFit.fill,
                    height: Screens.bodyheight(context) * 0.038,
                    width: Screens.width(context) * 0.022,
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
                    "Stock Lists",
                  ),
                ),
              ),
              Builder(
                builder: (context) => ListTile(
                  leading: Image.asset(
                    'assets/Drawer/refund.png',
                    fit: BoxFit.fill,
                    height: Screens.bodyheight(context) * 0.03,
                    width: Screens.width(context) * 0.02,
                  ),
                  onTap: () {
                    Navigator.pop(context);

                    Get.toNamed(ConstantRoutes.refunds);
                  },
                  title: const Text(
                    "Refunds",
                  ),
                ),
              ),
              Builder(
                builder: (context) => ListTile(
                  leading: Image.asset(
                    'assets/Drawer/expense.png',
                    fit: BoxFit.fill,
                    height: Screens.bodyheight(context) * 0.038,
                    width: Screens.width(context) * 0.02,
                  ),
                  onTap: () {
                    Navigator.pop(context);

                    Get.toNamed(ConstantRoutes.expence);
                  },
                  title: const Text(
                    "Expenses",
                  ),
                ),
              ),
              Builder(
                builder: (context) => ListTile(
                  leading: Image.asset(
                    'assets/Drawer/reconcil.png',
                    fit: BoxFit.fill,
                    height: Screens.bodyheight(context) * 0.038,
                    width: Screens.width(context) * 0.02,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(ConstantRoutes.reconciliation);
                  },
                  title: const Text(
                    "Reconciliation",
                  ),
                ),
              ),
              Builder(
                builder: (context) => ListTile(
                  leading: Image.asset(
                    'assets/Drawer/handshake.png',
                    fit: BoxFit.fill,
                    height: Screens.bodyheight(context) * 0.042,
                    width: Screens.width(context) * 0.02,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(ConstantRoutes.deposits);
                  },
                  title: const Text(
                    "Deposits",
                  ),
                ),
              ),
              Builder(
                builder: (context) => ListTile(
                  leading: Image.asset(
                    'assets/Drawer/reports.png',
                    fit: BoxFit.fill,
                    height: Screens.bodyheight(context) * 0.042,
                    width: Screens.width(context) * 0.02,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewChangesReport()));
                  },
                  title: const Text(
                    "Reports",
                  ),
                ),
              ),
              // Builder(
              //   builder: (context) => ListTile(
              //     leading: Image.asset(
              //       'assets/Drawer/stockcheck.png',
              //       fit: BoxFit.fill,
              //       height: Screens.bodyheight(context) * 0.038,
              //       width: Screens.width(context) * 0.024,
              //     ),
              //     onTap: () {
              //       Navigator.pop(context);

              //       Get.toNamed(ConstantRoutes.stockCheck);
              //     },
              //     title: const Text(
              //       "Stock Check",
              //     ),
              //   ),
              // ),
              Builder(
                builder: (context) => ListTile(
                  leading: Image.asset(
                    'assets/Drawer/customers.png',
                    fit: BoxFit.fill,
                    height: Screens.bodyheight(context) * 0.038,
                    width: Screens.width(context) * 0.022,
                  ),
                  onTap: () {
                    Get.toNamed(ConstantRoutes.customer);
                  },
                  title: const Text(
                    "Customers",
                  ),
                ),
              ),
              Builder(
                builder: (context) => ListTile(
                  leading: Image.asset(
                    'assets/Drawer/cashstatement.png',
                    fit: BoxFit.fill,
                    height: Screens.bodyheight(context) * 0.038,
                    width: Screens.width(context) * 0.022,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(ConstantRoutes.cashStatement);
                  },
                  title: const Text(
                    "Cash Statement",
                  ),
                ),
              ),
              Builder(
                builder: (context) => ListTile(
                  leading: Image.asset(
                    'assets/Drawer/pendingorder.png',
                    fit: BoxFit.fill,
                    height: Screens.bodyheight(context) * 0.038,
                    width: Screens.width(context) * 0.022,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(ConstantRoutes.pendingOrders);
                  },
                  title: const Text(
                    "Pending Order",
                  ),
                ),
              ),
              Builder(
                builder: (context) => ListTile(
                  leading: Image.asset(
                    'assets/Drawer/stockregister.png',
                    fit: BoxFit.fill,
                    height: Screens.bodyheight(context) * 0.038,
                    width: Screens.width(context) * 0.024,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(ConstantRoutes.stockRegister);
                  },
                  title: const Text(
                    "Sales Register",
                  ),
                ),
              ),
              Builder(
                builder: (context) => ListTile(
                  leading: Image.asset(
                    'assets/Drawer/returnregister.png',
                    fit: BoxFit.fill,
                    height: Screens.bodyheight(context) * 0.038,
                    width: Screens.width(context) * 0.023,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(ConstantRoutes.retrurnRegister);
                  },
                  title: const Text(
                    "Return Register",
                  ),
                ),
              ),
              Builder(
                builder: (context) => ListTile(
                  leading: Image.asset(
                    'assets/Drawer/stockreplenish.png',
                    fit: BoxFit.fill,
                    height: Screens.bodyheight(context) * 0.038,
                    width: Screens.width(context) * 0.024,
                  ),
                  onTap: () {
                    Navigator.pop(context);

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
                    'assets/Drawer/incomingReport.png',
                    fit: BoxFit.fill,
                    height: Screens.bodyheight(context) * 0.04,
                    width: Screens.width(context) * 0.024,
                  ),
                  onTap: () {
                    Navigator.pop(context);

                    Get.toNamed(ConstantRoutes.incomingReport);
                  },
                  title: const Text(
                    "Incoming Payment Report",
                  ),
                ),
              ),
              Builder(
                builder: (context) => ListTile(
                  leading: Image.asset(
                    'assets/Drawer/depositreport.jpeg',
                    fit: BoxFit.fill,
                    height: Screens.bodyheight(context) * 0.04,
                    width: Screens.width(context) * 0.024,
                  ),
                  onTap: () {
                    Navigator.pop(context);

                    Get.toNamed(ConstantRoutes.deposiReport);
                  },
                  title: const Text(
                    "Deposit Report",
                  ),
                ),
              ),
              Builder(
                builder: (context) => ListTile(
                  leading: Image.asset(
                    'assets/Drawer/gear.png',
                    fit: BoxFit.fill,
                    height: Screens.bodyheight(context) * 0.038,
                    width: Screens.width(context) * 0.024,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(ConstantRoutes.apiSettings);
                  },
                  title: const Text(
                    "Settings",
                  ),
                ),
              ),
              Builder(
                builder: (context) => ListTile(
                  leading: Image.asset(
                    'assets/Drawer/power-button.png',
                    fit: BoxFit.fill,
                    height: Screens.bodyheight(context) * 0.038,
                    width: Screens.width(context) * 0.024,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(ConstantRoutes.logout);
                  },
                  title: const Text(
                    "Logout",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
