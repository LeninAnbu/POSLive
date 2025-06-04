import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../Constant/Configuration.dart';
import '../../../../../Constant/Screen.dart';
import '../../../../../Controller/SalesRegisterController/SalesRegisterCon.dart';

class TabStockReg extends StatefulWidget {
  const TabStockReg({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  State<TabStockReg> createState() => _TabStockRegState();
}

class _TabStockRegState extends State<TabStockReg> {
  Configure config = Configure();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Screens.width(context),
      height: Screens.bodyheight(context) * 0.95,
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                alignment: Alignment.center,
                height: Screens.padingHeight(context) * 0.08,
                width: Screens.width(context) * 0.55,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Form(
                      key: context.read<StRegCon>().formkey[0],
                      child: Row(children: [
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.08,
                              height: Screens.padingHeight(context) * 0.06,
                              child: const Text("From Date"),
                            ),
                            Container(
                              height: Screens.padingHeight(context) * 0.3,
                              width: Screens.width(context) * 0.13,
                              decoration: const BoxDecoration(),
                              child: TextFormField(
                                controller: context
                                    .read<StRegCon>()
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
                                      .read<StRegCon>()
                                      .getDate2(context, 'From');
                                },
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 5.0),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    hintText: "",
                                    hintStyle: widget.theme.textTheme.bodyLarge!
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
                                    .read<StRegCon>()
                                    .searchcontroller[3],
                                onTap: () {
                                  context
                                      .read<StRegCon>()
                                      .getDate2(context, 'To');
                                },
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 5.0),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    hintText: "",
                                    hintStyle: widget.theme.textTheme.bodyLarge!
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
                                    .read<StRegCon>()
                                    .formkey[0]
                                    .currentState!
                                    .validate()) {
                                  context.read<StRegCon>().calSsearchBtn();
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
            context.watch<StRegCon>().getfiltersalesReg.isNotEmpty
                ? Column(
                    children: [
                      Container(
                        width: Screens.width(context),
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
                            context.read<StRegCon>().filterListSearched(val);
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(8),
                            hintText: "Inventories",
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
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),
                      createTable(widget.theme, context)
                    ],
                  )
                : Container()
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
          "Items",
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
          "Branch",
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Terminal",
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    ]));

    for (int i = 0;
        i < context.watch<StRegCon>().getfiltersalesReg.length;
        ++i) {
      rows.add(TableRow(children: [
        InkWell(
          onTap: () {
            log(context
                .watch<StRegCon>()
                .getfiltersalesReg[i]
                .docno!
                .toString());
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: InkWell(
              onTap: () {
                log(context
                    .watch<StRegCon>()
                    .getfiltersalesReg[i]
                    .docno!
                    .toString());
              },
              child: Text(
                '${context.watch<StRegCon>().getfiltersalesReg[i].docno}',
                textAlign: TextAlign.left,
                style: theme.textTheme.bodyLarge?.copyWith(),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${context.watch<StRegCon>().getfiltersalesReg[i].cardcode}\n${context.watch<StRegCon>().getfiltersalesReg[i].cardname}',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${context.watch<StRegCon>().getfiltersalesReg[i].itemcode}\n${context.watch<StRegCon>().getfiltersalesReg[i].itemname}',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            config.alignDate(
                context.watch<StRegCon>().getfiltersalesReg[i].date.toString()),
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${context.watch<StRegCon>().getfiltersalesReg[i].branch}',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${context.watch<StRegCon>().getfiltersalesReg[i].terminal}',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(),
          ),
        ),
      ]));
    }
    return Table(columnWidths: const {
      0: FlexColumnWidth(0.3),
      1: FlexColumnWidth(0.7),
      2: FlexColumnWidth(0.7),
      3: FlexColumnWidth(0.4),
      4: FlexColumnWidth(0.4),
      5: FlexColumnWidth(0.4),
    }, children: rows);
  }
}
