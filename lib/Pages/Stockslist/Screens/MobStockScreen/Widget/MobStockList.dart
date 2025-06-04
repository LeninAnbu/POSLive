import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Constant/padings.dart';
import 'package:posproject/Pages/Stockslist/Screens/MobStockScreen/Widget/MobViewAll.dart';
import 'package:posproject/Pages/Stockslist/Screens/MobStockScreen/Widget/StockSearchList.dart';
import 'package:posproject/Pages/Stockslist/Screens/Screens.dart';

import '../../../../../Controller/StockListsController/StockListsController.dart';

class MobStockList extends StatefulWidget {
  MobStockList({super.key, required this.stkCtrl});

  StockController stkCtrl;
  @override
  State<MobStockList> createState() => _MobStockListState();
}

class _MobStockListState extends State<MobStockList> {
  int? color = 0;

  Paddings paddings = Paddings();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: paddings.padding2(context),
      child: Column(
        children: [
          Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Container(
                decoration: BoxDecoration(
                    border:
                        Border.all(color: theme.primaryColor.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(8)),
                width: Screens.width(context),
                padding: EdgeInsets.symmetric(
                    horizontal: Screens.width(context) * 0.015,
                    vertical: Screens.bodyheight(context) * 0.005),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Brand",
                        style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isselectedBrand(color!);
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.27,
                              height: Screens.bodyheight(context) * 0.06,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: color == 1
                                      ? theme.primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: theme.primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('CROMPTON',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: 10,
                                    color: color == 1
                                        ? Colors.white
                                        : theme.primaryColor,
                                  )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {});
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.27,
                              height: Screens.bodyheight(context) * 0.06,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: color == 1
                                      ? theme.primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: theme.primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('ORIENT',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: 10,
                                    color: color == 1
                                        ? Colors.white
                                        : theme.primaryColor,
                                  )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.27,
                              height: Screens.bodyheight(context) * 0.06,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: color == 1
                                      ? theme.primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: theme.primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('ULTRA',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: 10,
                                    color: color == 1
                                        ? Colors.white
                                        : theme.primaryColor,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.27,
                              height: Screens.bodyheight(context) * 0.06,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: color == 1
                                      ? theme.primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: theme.primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('SAMSUNG',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: 10,
                                    color: color == 1
                                        ? Colors.white
                                        : theme.primaryColor,
                                  )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.27,
                              height: Screens.bodyheight(context) * 0.06,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: color == 1
                                      ? theme.primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: theme.primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('SONY',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: 10,
                                    color: color == 1
                                        ? Colors.white
                                        : theme.primaryColor,
                                  )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.27,
                              height: Screens.bodyheight(context) * 0.06,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: color == 1
                                      ? theme.primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: theme.primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('LAKSHMI-CUD',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: 10,
                                    color: color == 1
                                        ? Colors.white
                                        : theme.primaryColor,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.27,
                              height: Screens.bodyheight(context) * 0.06,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: color == 1
                                      ? theme.primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: theme.primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('BUTTERFLY',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: 10,
                                    color: color == 1
                                        ? Colors.white
                                        : theme.primaryColor,
                                  )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.27,
                              height: Screens.bodyheight(context) * 0.06,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: color == 1
                                      ? theme.primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: theme.primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('MHV',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: 10,
                                    color: color == 1
                                        ? Colors.white
                                        : theme.primaryColor,
                                  )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.27,
                              height: Screens.bodyheight(context) * 0.06,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: color == 1
                                      ? theme.primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: theme.primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('O GENERAL',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: 10,
                                    color: color == 1
                                        ? Colors.white
                                        : theme.primaryColor,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.centerRight,
                          width: Screens.width(context),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const StockListViewDetails(),
                                  ));
                            },
                            child: Text(
                              "View All",
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(fontSize: 16, color: Colors.grey),
                            ),
                          ),
                        ),
                      )
                    ])),
          ),
          Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Container(
                decoration: BoxDecoration(
                    border:
                        Border.all(color: theme.primaryColor.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(8)),
                width: Screens.width(context),
                padding: EdgeInsets.symmetric(
                    horizontal: Screens.width(context) * 0.015,
                    vertical: Screens.bodyheight(context) * 0.005),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Product",
                        style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {});
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.27,
                              height: Screens.bodyheight(context) * 0.06,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: color == 1
                                      ? theme.primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: theme.primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('FAN',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: 10,
                                    color: color == 1
                                        ? Colors.white
                                        : theme.primaryColor,
                                  )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {});
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.27,
                              height: Screens.bodyheight(context) * 0.06,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: color == 1
                                      ? theme.primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: theme.primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('GRINDER',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: 10,
                                    color: color == 1
                                        ? Colors.white
                                        : theme.primaryColor,
                                  )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.27,
                              height: Screens.bodyheight(context) * 0.06,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: color == 1
                                      ? theme.primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: theme.primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('MOBILE',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: 10,
                                    color: color == 1
                                        ? Colors.white
                                        : theme.primaryColor,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.27,
                              height: Screens.bodyheight(context) * 0.06,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: color == 1
                                      ? theme.primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: theme.primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('ACCESSORIES',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: 10,
                                    color: color == 1
                                        ? Colors.white
                                        : theme.primaryColor,
                                  )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.27,
                              height: Screens.bodyheight(context) * 0.06,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: color == 1
                                      ? theme.primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: theme.primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('BURO-STEEL',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: 10,
                                    color: color == 1
                                        ? Colors.white
                                        : theme.primaryColor,
                                  )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.27,
                              height: Screens.bodyheight(context) * 0.06,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: color == 1
                                      ? theme.primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: theme.primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('SS ITEMS',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: 10,
                                    color: color == 1
                                        ? Colors.white
                                        : theme.primaryColor,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.27,
                              height: Screens.bodyheight(context) * 0.06,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: color == 1
                                      ? theme.primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: theme.primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('DUMMY',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: 10,
                                    color: color == 1
                                        ? Colors.white
                                        : theme.primaryColor,
                                  )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.27,
                              height: Screens.bodyheight(context) * 0.06,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: color == 1
                                      ? theme.primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: theme.primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('DRESSING TABLE',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: 10,
                                    color: color == 1
                                        ? Colors.white
                                        : theme.primaryColor,
                                  )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.27,
                              height: Screens.bodyheight(context) * 0.06,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: color == 1
                                      ? theme.primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: theme.primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('REF',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: 10,
                                    color: color == 1
                                        ? Colors.white
                                        : theme.primaryColor,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.centerRight,
                          width: Screens.width(context),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const StockListViewDetails(),
                                  ));
                            },
                            child: Text(
                              "View All",
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(fontSize: 16, color: Colors.grey),
                            ),
                          ),
                        ),
                      )
                    ])),
          ),
          Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Container(
                decoration: BoxDecoration(
                    border:
                        Border.all(color: theme.primaryColor.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(8)),
                width: Screens.width(context),
                padding: EdgeInsets.symmetric(
                    horizontal: Screens.width(context) * 0.015,
                    vertical: Screens.bodyheight(context) * 0.005),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Segment",
                        style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {});
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.27,
                              height: Screens.bodyheight(context) * 0.06,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: color == 1
                                      ? theme.primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: theme.primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('FAN',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: 10,
                                    color: color == 1
                                        ? Colors.white
                                        : theme.primaryColor,
                                  )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {});
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.27,
                              height: Screens.bodyheight(context) * 0.06,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: color == 1
                                      ? theme.primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: theme.primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('GRINDER',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: 10,
                                    color: color == 1
                                        ? Colors.white
                                        : theme.primaryColor,
                                  )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.27,
                              height: Screens.bodyheight(context) * 0.06,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: color == 1
                                      ? theme.primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: theme.primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('MOBILE',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: 10,
                                    color: color == 1
                                        ? Colors.white
                                        : theme.primaryColor,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.27,
                              height: Screens.bodyheight(context) * 0.06,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: color == 1
                                      ? theme.primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: theme.primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('ACCESSORIES',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: 10,
                                    color: color == 1
                                        ? Colors.white
                                        : theme.primaryColor,
                                  )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.27,
                              height: Screens.bodyheight(context) * 0.06,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: color == 1
                                      ? theme.primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: theme.primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('BURO-STEEL',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: 10,
                                    color: color == 1
                                        ? Colors.white
                                        : theme.primaryColor,
                                  )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.27,
                              height: Screens.bodyheight(context) * 0.06,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: color == 1
                                      ? theme.primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: theme.primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('SS ITEMS',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: 10,
                                    color: color == 1
                                        ? Colors.white
                                        : theme.primaryColor,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.27,
                              height: Screens.bodyheight(context) * 0.06,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: color == 1
                                      ? theme.primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: theme.primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('DUMMY',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: 10,
                                    color: color == 1
                                        ? Colors.white
                                        : theme.primaryColor,
                                  )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.27,
                              height: Screens.bodyheight(context) * 0.06,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: color == 1
                                      ? theme.primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: theme.primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('DRESSING TABLE',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: 10,
                                    color: color == 1
                                        ? Colors.white
                                        : theme.primaryColor,
                                  )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.27,
                              height: Screens.bodyheight(context) * 0.06,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: color == 1
                                      ? theme.primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: theme.primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('REF',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: 10,
                                    color: color == 1
                                        ? Colors.white
                                        : theme.primaryColor,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.centerRight,
                          width: Screens.width(context),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const StockListViewDetails(),
                                  ));
                            },
                            child: Text(
                              "View All",
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(fontSize: 16, color: Colors.grey),
                            ),
                          ),
                        ),
                      )
                    ])),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Screens.width(context) * 0.2,
                height: Screens.bodyheight(context) * 0.065,
                child: ElevatedButton(
                    onPressed: () {
                      widget.stkCtrl.showSearchDialogBox(context);
                    },
                    onLongPress: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Icon(Icons.search) //const Text('Search')
                    ),
              ),
              SizedBox(
                width: Screens.width(context) * 0.5,
                height: Screens.bodyheight(context) * 0.065,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => StockSearchList())));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Search')),
              ),
              SizedBox(
                width: Screens.width(context) * 0.2,
                height: Screens.bodyheight(context) * 0.065,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => StockMainScreens(
                                    theme: theme,
                                  ))));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child:
                        const Icon(Icons.filter_alt_off) //const Text('Clear')
                    ),
              ),
            ],
          )
        ],
      ),
    );
  }

  isselectedBrand(int i) {
    if (i == 0) {
      i = 1;
    } else {
      i = 0;
    }
  }
}
