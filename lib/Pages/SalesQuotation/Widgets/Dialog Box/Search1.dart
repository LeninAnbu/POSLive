// import 'dart:developer';

// import 'package:flutter/material.dart';

// import '../../../../Constant/Configuration.dart';
// import '../../../../Constant/Screen.dart';
// import '../../../../Models/QueryUrlModel/TestTableModel.dart';
// import '../../../../Service/QueryURL/TestTableApi.dart';
// import '../../../../Widgets/Drawer.dart';

// class TRAInvoicesUserSpecific extends StatefulWidget {
//   TRAInvoicesUserSpecific({Key? key}) : super(key: key);

//   @override
//   State<TRAInvoicesUserSpecific> createState() =>
//       _TRAInvoicesUserSpecificState();
// }

// class _TRAInvoicesUserSpecificState extends State<TRAInvoicesUserSpecific> {
//   @override
//   void initState() {
//     super.initState();

//     callTestApi();
//   }

//   List<TestModelData> tablerColumn = [];

//   bool loadingscrn = false;

//   callTestApi() async {
//     await CreateTableApi.getGlobalData().then((value) {
//       loadingscrn = false;
//       if (value.statusCode! >= 200 && value.statusCode! <= 210) {
//         tablerColumn = value.openOutwardData!;
//         log('openOutwardDataopenOutwardData::${tablerColumn.length}');
//       } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {}
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     Configure config = Configure();
//     List<DataColumn> _generateColumns(List<TestModelData> valuesx) {
//       // log('valuesxvaluesxvaluesxvaluesx::${valuesx.length}');
//       List<DataColumn> columns = [];
//       var data = valuesx.map((e) => e.toMap()).toList();
//       log('yyyyyyyyyyyyyyyykey::${data.first.keys.length}');

//       data.first.keys.forEach((key) {
//         columns.add(DataColumn(
//           label: Container(
//               alignment: Alignment.center,
//               child: Text(
//                 key,
//                 textAlign: TextAlign.center,
//               )),
//         ));
//       });

//       return columns;
//     }

//     List<DataRow> _generateRows(List<TestModelData> data) {
//       List<DataRow> rows = [];
// // {\"DocNum\":3030681,\"DocDate\":\"2024-11-01T00:00:00\",\"CardCode\":\"D5225\",\"CardName\":\"BISIXITEN JUSTINE MASSAWE\",
// //\"Tin Number\":\"116581469\",\"Total Before Tax\":191884.000000,\"Tax\":34539.120000,\"DocTotal\":226423.120000,
// //\"U_rctCde\":\"B06A9F139305\",\"U_Zno\":\"7/20241101\",\"U_VfdIn\":\"139305\",\"U_NAME\":\"ARUSHA DEPOT\",
// //\"canceled\":\"N\",\"Name\":\"Arusha\"},

//       data.forEach((item) {
//         List<DataCell> cells = [];
//         cells.add(DataCell(Text(item.DocNum.toString())));
//         cells.add(DataCell(Text(config.alignDate(item.DocDate.toString()))));
//         cells.add(DataCell(Container(
//             alignment: Alignment.center,
//             child: Text(item.CardCode.toString()))));
//         cells.add(DataCell(Container(
//             width: Screens.width(context) * 0.2,
//             child: Text(item.CardName.toString()))));
//         cells.add(DataCell(Container(
//             alignment: Alignment.centerRight,
//             child: Text(item.TinNumber.toString().replaceAll('.0', '')))));
//         cells.add(DataCell(Container(
//             alignment: Alignment.centerRight,
//             child: Text(item.TotalBeforeTax.toString()))));
//         cells.add(DataCell(Container(
//             alignment: Alignment.centerRight,
//             child: Text(item.Tax.toString()))));
//         cells.add(DataCell(Container(
//             alignment: Alignment.centerRight,
//             child: Text(item.DocTotal.toString()))));
//         cells.add(DataCell(Text(item.U_rctCde.toString())));
//         cells.add(DataCell(Text(item.U_Zno.toString())));
//         cells.add(DataCell(Text(item.U_VfdIn.toString())));
//         cells.add(DataCell(Text(item.U_NAME.toString())));
//         cells.add(DataCell(Container(
//             alignment: Alignment.center,
//             child: Text(item.canceled.toString()))));
//         cells.add(DataCell(Text(item.Name.toString())));

//         rows.add(DataRow(cells: cells));
//       });
//       return rows;
//     }

//     return Scaffold(
//       drawer: naviDrawer(),
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         elevation: 0,
//         title: Text('TRA invoices user specific-1'),
//       ),
//       body: SingleChildScrollView(
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             Container(
//               padding: EdgeInsets.all(5),
//               width: Screens.width(context) * 1.1,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius:
//                       BorderRadius.circular(Screens.bodyheight(context) * 0.01),
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.grey[400]!,
//                         // blurRadius: 2.0,
//                         spreadRadius: 1.0,
//                         offset: const Offset(2, 0))
//                   ]),
//               child: SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   scrollDirection: Axis.horizontal,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       DataTable(
//                         headingRowHeight: Screens.padingHeight(context) * 0.05,
//                         dataRowHeight: Screens.padingHeight(context) * 0.045,
//                         columnSpacing: 8.0,
//                         border: TableBorder.symmetric(
//                             inside: BorderSide(
//                                 color: theme.primaryColor.withOpacity(0.1))),
//                         columns: _generateColumns(tablerColumn),
//                         rows: _generateRows(tablerColumn),
//                         headingTextStyle: theme.textTheme.bodyMedium!.copyWith(
//                             color: theme.primaryColor,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
