import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:posproject/Controller/DepositController/DepositsReportCtrl.dart';
import 'package:provider/provider.dart';
import '../../../../../Constant/Configuration.dart';
import '../../../../../Constant/Screen.dart';

class DepositsReportsPages extends StatefulWidget {
  const DepositsReportsPages({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  State<DepositsReportsPages> createState() => _DepositsReportsPagesState();
}

class _DepositsReportsPagesState extends State<DepositsReportsPages> {
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                alignment: Alignment.center,
                height: Screens.padingHeight(context) * 0.08,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: Screens.width(context) * 0.4,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 240, 235, 235)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: TextFormField(
                        style: widget.theme.textTheme.bodyLarge!
                            .copyWith(color: Colors.black),
                        keyboardType: TextInputType.text,
                        onChanged: (val) {
                          context
                              .read<DepositReportCtrlrs>()
                              .filterListSearched(val);
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(8),
                          hintText: "Search ",
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
                      key: context.read<DepositReportCtrlrs>().formkey[0],
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: Screens.width(context) * 0.085,
                                  height: Screens.padingHeight(context) * 0.06,
                                  child: const Text("From Date"),
                                ),
                                Container(
                                  height: Screens.padingHeight(context) * 0.3,
                                  width: Screens.width(context) * 0.13,
                                  decoration: const BoxDecoration(),
                                  child: TextFormField(
                                    controller: context
                                        .read<DepositReportCtrlrs>()
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
                                      context
                                          .read<DepositReportCtrlrs>()
                                          .getDate2(context, 'From');
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
                                  height: Screens.padingHeight(context) * 0.3,
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
                                        .read<DepositReportCtrlrs>()
                                        .searchcontroller[3],
                                    onTap: () {
                                      context
                                          .read<DepositReportCtrlrs>()
                                          .getDate2(context, 'To');
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
                              width: Screens.width(context) * 0.03,
                            ),
                            Container(
                              alignment: Alignment.topCenter,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (context
                                        .read<DepositReportCtrlrs>()
                                        .formkey[0]
                                        .currentState!
                                        .validate()) {
                                      context
                                          .read<DepositReportCtrlrs>()
                                          .callDepositsReportApi();
                                    }
                                  });
                                },
                                child: Container(
                                  height: Screens.padingHeight(context) * 0.065,
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
                            ),
                          ]),
                    ),
                  ],
                )),
            Column(
              children: [
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                context.watch<DepositReportCtrlrs>().isloading == true
                    ? Container(
                        height: Screens.bodyheight(context) * 0.08,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: widget.theme.primaryColor,
                          ),
                        ),
                      )
                    : context
                                .watch<DepositReportCtrlrs>()
                                .filterReportData
                                .isEmpty &&
                            context.watch<DepositReportCtrlrs>().isloading ==
                                false
                        ? Container(
                            alignment: Alignment.center,
                            height: Screens.padingHeight(context) * 0.8,
                            child: Text('No data found'),
                          )
                        : createTable(widget.theme, context)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget createTable(
    ThemeData theme,
    BuildContext context,
  ) {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Container(
        color: theme.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Deposit No",
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Deposit Date",
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Debit Account Name",
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Debit Amount",
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Credit Account Name",
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Credit Amount",
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Payment Mode",
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    ]));

    for (int i = 0;
        i < context.watch<DepositReportCtrlrs>().filterReportData.length;
        ++i) {
      rows.add(TableRow(children: [
        InkWell(
          onTap: () {
            log(context
                .watch<DepositReportCtrlrs>()
                .filterReportData[i]
                .deposNum!
                .toString());
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Text(
              '${context.watch<DepositReportCtrlrs>().filterReportData[i].deposNum}',
              textAlign: TextAlign.left,
              style: theme.textTheme.bodyLarge?.copyWith(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${config.alignDate(context.watch<DepositReportCtrlrs>().filterReportData[i].deposDate)}',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${context.watch<DepositReportCtrlrs>().filterReportData[i].debitActName}',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            '${config.splitValues(context.watch<DepositReportCtrlrs>().filterReportData[i].debitAmt.toString())}',
            textAlign: TextAlign.end,
            style: theme.textTheme.bodyLarge?.copyWith(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${context.watch<DepositReportCtrlrs>().filterReportData[i].creditActName}',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${config.splitValues(context.watch<DepositReportCtrlrs>().filterReportData[i].creditAmount.toString())}',
            textAlign: TextAlign.end,
            style: theme.textTheme.bodyLarge?.copyWith(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            context
                .watch<DepositReportCtrlrs>()
                .filterReportData[i]
                .paymentMode
                .toString(),
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(),
          ),
        ),
      ]));
    }
    return Table(columnWidths: const {
      0: FlexColumnWidth(0.3),
      1: FlexColumnWidth(0.35),
      2: FlexColumnWidth(0.8),
      3: FlexColumnWidth(0.6),
      4: FlexColumnWidth(0.5),
      5: FlexColumnWidth(0.4),
      6: FlexColumnWidth(0.5),
    }, children: rows);
  }
}
