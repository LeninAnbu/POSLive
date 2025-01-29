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
        // textAlign: TextAlign.center,
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
    // Container(
    //   alignment: Alignment.center,

    //   color: theme.primaryColor,
    //   padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
    //   child: Text(
    //     "Difference",
    //     style: theme.textTheme.bodyLarge
    //         ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
    //     textAlign: TextAlign.center,
    //   ),
    // ),
  ]));
  rows.add(TableRow(children: [
    Container(
      height: 50,
      // color: Colors.blue,
      alignment: Alignment.centerLeft,
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text("Cash"),
      ),
    ),
    Container(
      //  color:Colors.amber,
      //   height:40,
      //  padding: EdgeInsets.only(left: 50),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(),
        child: TextField(
          textAlign: TextAlign.center,
          controller: context.watch<DepositsController>().mycontroller[7],
          readOnly: true,
          decoration: const InputDecoration(
            // contentPadding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
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
      // color: Colors.red,
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

          //   style: TextStyle(color: Colors.amber),
        ),
      ),
    ),
    // Container(
    //   // color: Colors.amber,
    //   alignment: Alignment.center,
    //   child: Padding(
    //     padding: EdgeInsets.symmetric(),
    //     child: TextField(
    //       textAlign: TextAlign.center,
    //       controller: context.watch<DepositsController>().mycontroller[9],
    //       readOnly: true,
    //       decoration: InputDecoration(
    //         border: InputBorder.none,
    //         focusedBorder: InputBorder.none,
    //         enabledBorder: InputBorder.none,
    //         errorBorder: InputBorder.none,
    //         disabledBorder: InputBorder.none,
    //       ),

    //       //   style: TextStyle(color: Colors.amber),
    //     ),
    //   ),
    // ),
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
      // color: Colors.blue,
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

          //   style: TextStyle(color: Colors.amber),
        ),
      ),
    ),
    Container(
      // color: Colors.blueGrey,
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

          //   style: TextStyle(color: Colors.amber),
        ),
      ),
    ),
    // Container(
    //   alignment: Alignment.center,
    //   child: Padding(
    //     padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
    //     child: TextField(
    //       textAlign: TextAlign.center,

    //       controller: context.watch<DepositsController>().mycontroller[12],
    //       readOnly: true,
    //       decoration: InputDecoration(
    //         border: InputBorder.none,
    //         focusedBorder: InputBorder.none,
    //         enabledBorder: InputBorder.none,
    //         errorBorder: InputBorder.none,
    //         disabledBorder: InputBorder.none,
    //       ),

    //       //   style: TextStyle(color: Colors.amber),
    //     ),
    //   ),
    // ),
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

          //   style: TextStyle(color: Colors.amber),
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

          //   style: TextStyle(color: Colors.amber),
        ),
      ),
    ),
    // Container(
    //   // color: Colors.amber,
    //   alignment: Alignment.center,
    //   child: Padding(
    //     padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
    //     child: TextField(
    //       controller: context.watch<DepositsController>().mycontroller[15],
    //       readOnly: true,
    //         textAlign: TextAlign.center,
    //       decoration: InputDecoration(
    //         border: InputBorder.none,
    //         focusedBorder: InputBorder.none,
    //         enabledBorder: InputBorder.none,
    //         errorBorder: InputBorder.none,
    //         disabledBorder: InputBorder.none,
    //       ),

    //       //   style: TextStyle(color: Colors.amber),
    //     ),
    //   ),
    // ),
  ]));
  // rows.add(TableRow(children: [
  //   Container(
  //     height: 50,
  //     alignment: Alignment.centerLeft,
  //     child: Padding(
  //       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
  //       child: Text("Coupon"),
  //     ),
  //   ),
  //   Container(
  //     alignment: Alignment.center,
  //     child: Padding(
  //       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
  //       child: TextField(
  //         controller: settleCon.mycontroller[16],
  //         readOnly: true,
  //         decoration: InputDecoration(
  //           border: InputBorder.none,
  //           focusedBorder: InputBorder.none,
  //           enabledBorder: InputBorder.none,
  //           errorBorder: InputBorder.none,
  //           disabledBorder: InputBorder.none,
  //         ),

  //         //   style: TextStyle(color: Colors.amber),
  //       ),
  //     ),
  //   ),
  //   Container(
  //     alignment: Alignment.center,
  //     child: Padding(
  //       padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
  //       child: TextField(
  //         controller: settleCon.mycontroller[17],
  //         readOnly: true,
  //         decoration: InputDecoration(
  //           border: InputBorder.none,
  //           focusedBorder: InputBorder.none,
  //           enabledBorder: InputBorder.none,
  //           errorBorder: InputBorder.none,
  //           disabledBorder: InputBorder.none,
  //         ),

  //         //   style: TextStyle(color: Colors.amber),
  //       ),
  //     ),
  //   ),
  //   Container(
  //     alignment: Alignment.center,
  //     child: Padding(
  //       padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
  //       child: TextField(
  //         controller: settleCon.mycontroller[18],
  //         readOnly: true,
  //         decoration: InputDecoration(
  //           border: InputBorder.none,
  //           focusedBorder: InputBorder.none,
  //           enabledBorder: InputBorder.none,
  //           errorBorder: InputBorder.none,
  //           disabledBorder: InputBorder.none,
  //         ),

  //         //   style: TextStyle(color: Colors.amber),
  //       ),
  //     ),
  //   ),
  // ]));
  // rows.add(TableRow(children: [
  //   Container(
  //     height: 50,
  //     alignment: Alignment.centerLeft,
  //     child: Padding(
  //       padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
  //       child: Text("Wallet"),
  //     ),
  //   ),
  //   Container(
  //     alignment: Alignment.center,
  //     child: Padding(
  //       padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
  //       child: TextField(
  //         controller: settleCon.mycontroller[19],
  //         readOnly: true,
  //         decoration: InputDecoration(
  //           border: InputBorder.none,
  //           focusedBorder: InputBorder.none,
  //           enabledBorder: InputBorder.none,
  //           errorBorder: InputBorder.none,
  //           disabledBorder: InputBorder.none,
  //         ),

  //         //   style: TextStyle(color: Colors.amber),
  //       ),
  //     ),
  //   ),
  //   Container(
  //     alignment: Alignment.center,
  //     child: Padding(
  //       padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
  //       child: TextField(
  //         controller: settleCon.mycontroller[20],
  //         readOnly: true,
  //         decoration: InputDecoration(
  //           border: InputBorder.none,
  //           focusedBorder: InputBorder.none,
  //           enabledBorder: InputBorder.none,
  //           errorBorder: InputBorder.none,
  //           disabledBorder: InputBorder.none,
  //         ),

  //         //   style: TextStyle(color: Colors.amber),
  //       ),
  //     ),
  //   ),
  //   Container(
  //     alignment: Alignment.center,
  //     child: Padding(
  //       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
  //       child: TextField(
  //         controller: settleCon.mycontroller[21],
  //         readOnly: true,
  //         decoration: InputDecoration(
  //           border: InputBorder.none,
  //           focusedBorder: InputBorder.none,
  //           enabledBorder: InputBorder.none,
  //           errorBorder: InputBorder.none,
  //           disabledBorder: InputBorder.none,
  //         ),

  //         //   style: TextStyle(color: Colors.amber),
  //       ),
  //     ),
  //   ),
  // ]));

  return Table(columnWidths: const {
    0: FlexColumnWidth(1.1), //tp
    1: FlexColumnWidth(1.3), //seg
    2: FlexColumnWidth(1.3), //tar
    3: FlexColumnWidth(1.3), //ach
    // 4: FlexColumnWidth(1.1), //ach%
  }, children: rows);
}
