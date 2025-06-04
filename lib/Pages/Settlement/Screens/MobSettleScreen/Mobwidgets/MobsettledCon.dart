import 'package:flutter/material.dart';
import 'package:posproject/Controller/DepositController/DepositsController.dart';
import 'package:provider/provider.dart';

Widget createTable(
  BuildContext context,
) {
//
  List<TableRow> rows = [];
  final theme = Theme.of(context);
  rows.add(TableRow(children: [
    Container(
      alignment: Alignment.centerLeft,
      color: theme.primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Text(
        "Mode",
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    ),
    Container(
      alignment: Alignment.center,
      color: theme.primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
      child: Text(
        "Collection",
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      ),
    ),
    Container(
      alignment: Alignment.center,
      color: theme.primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
      child: Text(
        "Settled",
        style: theme.textTheme.bodyLarge
            ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    ),
  ]));
  rows.add(TableRow(children: [
    Container(
      height: 50,
      alignment: Alignment.centerLeft,
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text("Cash"),
      ),
    ),
    Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(),
        child: TextField(
          textAlign: TextAlign.center,
          controller: context.watch<DepositsController>().mycontroller[7],
          readOnly: true,
          decoration: const InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      ),
    ),
    Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
        child: TextField(
          textAlign: TextAlign.center,
          controller: context.watch<DepositsController>().mycontroller[8],
          readOnly: true,
          decoration: const InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      ),
    ),
  ]));
  rows.add(TableRow(children: [
    Container(
      height: 50,
      alignment: Alignment.centerLeft,
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text("Card"),
      ),
    ),
    Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(),
        child: TextField(
          textAlign: TextAlign.center,
          controller: context.watch<DepositsController>().mycontroller[10],
          readOnly: true,
          decoration: const InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      ),
    ),
    Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
        child: TextField(
          textAlign: TextAlign.center,
          controller: context.watch<DepositsController>().mycontroller[11],
          readOnly: true,
          decoration: const InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      ),
    ),
  ]));
  rows.add(TableRow(children: [
    Container(
      height: 50,
      alignment: Alignment.centerLeft,
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text("Cheque"),
      ),
    ),
    Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: TextField(
          textAlign: TextAlign.center,
          controller: context.watch<DepositsController>().mycontroller[13],
          readOnly: true,
          decoration: const InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      ),
    ),
    Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
        child: TextField(
          textAlign: TextAlign.center,
          controller: context.watch<DepositsController>().mycontroller[14],
          readOnly: true,
          decoration: const InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      ),
    ),
  ]));

  return Table(columnWidths: const {
    0: FlexColumnWidth(1.1), //tp
    1: FlexColumnWidth(1.3), //seg
    2: FlexColumnWidth(1.3), //tar
    3: FlexColumnWidth(1.3), //ach
  }, children: rows);
}
