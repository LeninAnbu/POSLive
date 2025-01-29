import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Pages/DashBoard/Screens/DashBoardScreen.dart';
import 'package:posproject/Pages/Expenses/ExpenseScreen.dart';
import 'package:posproject/Pages/PaymentReceipt/Screens/Screens.dart';
import 'package:posproject/Pages/SalesReturn/Screens.dart';
import 'package:posproject/Pages/Settlement/Screens/SettlementScreen.dart';
import 'package:posproject/Pages/StockInward/Screens/Screens.dart';
import 'package:posproject/Pages/StockRequest/Screens/Screens.dart';

import '../../StockOutward/Screens/Screens.dart';

class QuickOptions extends StatelessWidget {
  const QuickOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(
          top: Screens.padingHeight(context) * 0.01,
          left: Screens.padingHeight(context) * 0.01,
          right: Screens.padingHeight(context) * 0.01,
          bottom: Screens.padingHeight(context) * 0.01),
      width: Screens.width(context) * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                height: Screens.padingHeight(context) * 0.04,
                child: Text('Quick Options',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DashBoardScreen()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: theme.primaryColor,
                        )),
                    height: Screens.padingHeight(context) * 0.06,
                    child: Text("DashBoard",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.primaryColor,
                        )),
                  )),
              SizedBox(
                height: Screens.padingHeight(context) * 0.01,
              ),
              GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: theme.primaryColor,
                        )),
                    height: Screens.padingHeight(context) * 0.06,
                    child: Text("Sales",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.primaryColor,
                        )),
                  )),
              SizedBox(
                height: Screens.padingHeight(context) * 0.01,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SalesReturnScreens()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: theme.primaryColor,
                        )),
                    height: Screens.padingHeight(context) * 0.06,
                    child: Text("Sales Returns",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.primaryColor,
                        )),
                  )),
              SizedBox(height: Screens.padingHeight(context) * 0.01),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StockReqScreens()));
                },
                child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: theme.primaryColor,
                        )),
                    height: Screens.padingHeight(context) * 0.06,
                    child: Text("Inventory Transfer Request",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.primaryColor,
                        ))),
              ),
              SizedBox(
                height: Screens.padingHeight(context) * 0.01,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StockInwardScreens()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: theme.primaryColor,
                        )),
                    height: Screens.padingHeight(context) * 0.06,
                    child: Text("Stock Inward ",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.primaryColor,
                        )),
                  )),
              SizedBox(
                height: Screens.padingHeight(context) * 0.01,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StockOutwardScreens()));
                },
                child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: theme.primaryColor,
                        )),
                    height: Screens.padingHeight(context) * 0.06,
                    child: Text("Stock Outward",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.primaryColor,
                        ))),
              ),
              SizedBox(
                height: Screens.padingHeight(context) * 0.01,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const PaymentReceiptScreens()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: theme.primaryColor,
                        )),
                    height: Screens.padingHeight(context) * 0.06,
                    child: Text("Payment Receipt",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.primaryColor,
                        )),
                  )),
              SizedBox(
                height: Screens.padingHeight(context) * 0.01,
              ),
              GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: theme.primaryColor,
                        )),
                    height: Screens.padingHeight(context) * 0.06,
                    child: Text("Refunds",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.primaryColor,
                        )),
                  )),
              SizedBox(
                height: Screens.padingHeight(context) * 0.01,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ExpenseScreen()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: theme.primaryColor,
                        )),
                    height: Screens.padingHeight(context) * 0.06,
                    child: Text("Expenses",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.primaryColor,
                        )),
                  )),
              SizedBox(
                height: Screens.padingHeight(context) * 0.01,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DepositScreen()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: theme.primaryColor,
                        )),
                    height: Screens.padingHeight(context) * 0.06,
                    child: Text("Settlement",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.primaryColor,
                        )),
                  )),
              SizedBox(
                height: Screens.padingHeight(context) * 0.01,
              ),
              GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: theme.primaryColor,
                        )),
                    height: Screens.padingHeight(context) * 0.06,
                    child: Text("Stock Check",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.primaryColor,
                        )),
                  )),
              SizedBox(
                height: Screens.padingHeight(context) * 0.01,
              ),
              GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: theme.primaryColor,
                        )),
                    height: Screens.padingHeight(context) * 0.06,
                    child: Text("Customers",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.primaryColor,
                        )),
                  )),
              SizedBox(
                height: Screens.padingHeight(context) * 0.01,
              ),
              GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: theme.primaryColor,
                        )),
                    height: Screens.padingHeight(context) * 0.06,
                    child: Text("Cash Statement",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.primaryColor,
                        )),
                  )),
              SizedBox(
                height: Screens.padingHeight(context) * 0.01,
              ),
              GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: theme.primaryColor,
                        )),
                    height: Screens.padingHeight(context) * 0.06,
                    child: Text("Pending Orders",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.primaryColor,
                        )),
                  )),
              SizedBox(
                height: Screens.padingHeight(context) * 0.01,
              ),
              GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: theme.primaryColor,
                        )),
                    height: Screens.padingHeight(context) * 0.06,
                    child: Text("Sales Register",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.primaryColor,
                        )),
                  )),
              SizedBox(
                height: Screens.padingHeight(context) * 0.01,
              ),
              GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: theme.primaryColor,
                        )),
                    height: Screens.padingHeight(context) * 0.06,
                    child: Text("Return Register",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.primaryColor,
                        )),
                  )),
              SizedBox(
                height: Screens.padingHeight(context) * 0.01,
              ),
              GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: theme.primaryColor,
                        )),
                    height: Screens.padingHeight(context) * 0.06,
                    child: Text("Stock Replenish",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.primaryColor,
                        )),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
