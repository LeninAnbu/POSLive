import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../Constant/Configuration.dart';
import '../../../../../Constant/Screen.dart';
import '../../../../../Controller/CashStatementController/CashSatementCont.dart';

class TabCashSattement extends StatefulWidget {
  const TabCashSattement({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  State<TabCashSattement> createState() => _TabCashSattementState();
}

class _TabCashSattementState extends State<TabCashSattement> {
  Configure config = Configure();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Screens.width(context),
      height: Screens.bodyheight(context) * 0.95,
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Screens.padingHeight(context) * 0.08,
              width: Screens.width(context),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Screens.width(context) * 0.45,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 240, 235, 235)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: TextField(
                        style: widget.theme.textTheme.bodyLarge!
                            .copyWith(color: Colors.black),
                        keyboardType: TextInputType.text,
                        onChanged: (val) {
                          context.read<CashStateCon>().filterListSearched(val);
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(8),
                          hintText: "Search here..!!",
                          hintStyle:
                              widget.theme.textTheme.bodyMedium!.copyWith(),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.search,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Form(
                        key: context.read<CashStateCon>().formkey[0],
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: Screens.width(context) * 0.08,
                                  height: Screens.padingHeight(context) * 0.06,
                                  child: const Text("From Date"),
                                ),
                                Container(
                                  width: Screens.width(context) * 0.13,
                                  decoration: const BoxDecoration(),
                                  child: TextFormField(
                                    controller: context
                                        .read<CashStateCon>()
                                        .searchcontroller[2],
                                    readOnly: true,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Required";
                                      }
                                      null;
                                      return null;
                                    },
                                    onTap: () {
                                      setState(() {
                                        context.read<CashStateCon>().getDate2(
                                              context,
                                              'From',
                                            );
                                      });
                                    },
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 5.0, horizontal: 5.0),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        hintText: "",
                                        hintStyle: widget
                                            .theme.textTheme.bodyLarge!
                                            .copyWith(color: Colors.black),
                                        suffixIcon:
                                            const Icon(Icons.calendar_today)),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: Screens.width(context) * 0.08,
                                  height: Screens.padingHeight(context) * 0.06,
                                  child: const Text("To Date"),
                                ),
                                Container(
                                  width: Screens.width(context) * 0.13,
                                  decoration: const BoxDecoration(),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Required";
                                      }
                                      null;
                                      return null;
                                    },
                                    readOnly: true,
                                    controller: context
                                        .read<CashStateCon>()
                                        .searchcontroller[3],
                                    onTap: () {
                                      setState(() {
                                        context
                                            .read<CashStateCon>()
                                            .getDate2(context, 'To');
                                      });
                                    },
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 5.0, horizontal: 5.0),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        hintText: "",
                                        hintStyle: widget
                                            .theme.textTheme.bodyLarge!
                                            .copyWith(color: Colors.black),
                                        suffixIcon:
                                            const Icon(Icons.calendar_today)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: Screens.width(context) * 0.01,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  context.read<CashStateCon>().searchBtn();
                                });
                              },
                              child: Container(
                                height: Screens.padingHeight(context) * 0.06,
                                width: Screens.width(context) * 0.075,
                                decoration: BoxDecoration(
                                    color: widget.theme.primaryColor,
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ]),
            ),
            SizedBox(
              height: Screens.bodyheight(context) * 0.01,
            ),
            context.watch<CashStateCon>().isLoading == true &&
                    context.watch<CashStateCon>().filtersalesReg.isEmpty
                ? Container(
                    height: Screens.padingHeight(context) * 0.5,
                    child: const Center(child: CircularProgressIndicator()))
                : context.watch<CashStateCon>().isLoading == false &&
                        context.watch<CashStateCon>().filtersalesReg.isEmpty &&
                        context.watch<CashStateCon>().expMsg.isNotEmpty
                    ? SizedBox(
                        height: Screens.padingHeight(context) * 0.5,
                        child: Center(
                            child: Text(
                                "${context.watch<CashStateCon>().expMsg}")))
                    : createTable(widget.theme, context)
          ],
        ),
      ),
    );
  }

  Widget createTable(ThemeData theme, BuildContext context) {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Container(
        color: theme.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Document No",
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Customer",
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Rc Amount",
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Expense",
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Date",
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "DocType",
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Branch-Terminal",
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    ]));
    for (int i = 0;
        i < context.watch<CashStateCon>().getfiltersalesReg.length;
        ++i) {
      rows.add(TableRow(children: [
        InkWell(
          onTap: () {
            log(context.read<CashStateCon>().getfiltersalesReg[i].docno!);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Text(
              '${context.watch<CashStateCon>().getfiltersalesReg[i].docno}',
              textAlign: TextAlign.left,
              style: theme.textTheme.bodyLarge?.copyWith(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${context.watch<CashStateCon>().getfiltersalesReg[i].cardcode}\n${context.watch<CashStateCon>().getfiltersalesReg[i].cardname}',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            config.splitValues(
                '${context.watch<CashStateCon>().getfiltersalesReg[i].amount}'),
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            config.splitValues(
                '${context.watch<CashStateCon>().getfiltersalesReg[i].expense}'),
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            config.alignDate(
                '${context.watch<CashStateCon>().getfiltersalesReg[i].date}'),
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${context.watch<CashStateCon>().getfiltersalesReg[i].doctype}',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${context.watch<CashStateCon>().getfiltersalesReg[i].branch}\n${context.watch<CashStateCon>().getfiltersalesReg[i].terminal}',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(),
          ),
        ),
      ]));
    }
    return Table(columnWidths: const {
      0: FlexColumnWidth(0.5),
      1: FlexColumnWidth(0.8),
      2: FlexColumnWidth(0.5),
      3: FlexColumnWidth(0.4),
      4: FlexColumnWidth(0.35),
      5: FlexColumnWidth(0.4),
      6: FlexColumnWidth(0.4),
    }, children: rows);
  }
}
