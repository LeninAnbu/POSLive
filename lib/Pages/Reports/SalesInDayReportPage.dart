import 'package:flutter/material.dart';
import 'package:posproject/Controller/ReportsController.dart';
import 'package:provider/provider.dart';
import '../../../../Constant/Screen.dart';

class SalesInDayReport extends StatefulWidget {
  SalesInDayReport({super.key});

  @override
  State<SalesInDayReport> createState() => _SalesInDayReportState();
}

class _SalesInDayReportState extends State<SalesInDayReport> {
  @override
  List<DataColumn> _generateColumns(List<dynamic> data) {
    List<DataColumn> columns = [];
    for (var i = 0; i < data.length; i++) {
      columns.add(DataColumn(
        label: Text(data[i]),
      ));
    }
    return columns;
  }

  List<DataRow> _generateRows(List<dynamic> keysList) {
    List<DataRow> rows = [];
    keysList.forEach((item) {
      List<DataCell> cells = [];
      item.keys.forEach((key) {
        cells.add(DataCell(Text(item[key].toString())));
      });
      rows.add(DataRow(cells: cells));
    });
    return rows;
  }

  // List<DataColumn> _generateColumns(List<SalesInDayData> valuesx) {
  //   List<DataColumn> columns = [];
  //   var data = valuesx.map((e) => e.toMap()).toList();
  //   log('yyyyyyyyyyyyyyyykey::${data.first.keys.length}');

  //   data.first.keys.forEach((key) {
  //     columns.add(DataColumn(
  //       label: Container(
  //           alignment: Alignment.center,
  //           child: Text(
  //             key,
  //             textAlign: TextAlign.center,
  //           )),
  //     ));
  //   });

  //   return columns;
  // }

  // List<DataRow> _generateRows(List<SalesInDayData> data) {
  //   List<DataRow> rows = [];

  //   data.forEach((item) {
  //     List<DataCell> cells = [];
  //     cells.add(DataCell(Container(
  //         alignment: Alignment.center, child: Text(item.docNum.toString()))));
  //     cells.add(DataCell(Container(
  //         alignment: Alignment.center,
  //         child: Text(item.DocStatus.toString()))));
  //     cells.add(DataCell(Container(
  //         alignment: Alignment.center,
  //         child: Text(config.alignDateT(item.taxDate.toString())))));
  //     cells.add(DataCell(Container(
  //         alignment: Alignment.center,
  //         child: Text(item.CustomerCode.toString()))));
  //     cells.add(DataCell(Container(
  //         alignment: Alignment.centerLeft,
  //         child: Text(item.cardName.toString()))));
  //     cells.add(DataCell(Container(
  //         alignment: Alignment.centerLeft,
  //         child: Text(item.NumAtCard.toString()))));
  //     cells.add(DataCell(Container(
  //         alignment: Alignment.centerRight,
  //         child: Text(item.DISC.toString()))));
  //     cells.add(DataCell(Container(
  //         alignment: Alignment.centerRight,
  //         child: Text(config.splitValues(item.VatSum.toStringAsFixed(2))))));
  //     cells.add(DataCell(Container(
  //         alignment: Alignment.centerRight,
  //         child: Text(config.splitValues(item.DocTotal.toString())))));
  //     cells.add(DataCell(Container(
  //         alignment: Alignment.center, child: Text(item.Comments.toString()))));
  //     cells.add(DataCell(Container(
  //         alignment: Alignment.centerRight,
  //         child: Text(item.ReceiptNum.toString()))));
  //     cells.add(DataCell(Container(
  //         alignment: Alignment.center, child: Text(item.SlpName.toString()))));
  //     cells.add(DataCell(Container(
  //         alignment: Alignment.centerRight,
  //         child: Text(item.DocTime.toString()))));
  //     cells.add(DataCell(Container(
  //         alignment: Alignment.center, child: Text(item.memo.toString()))));
  //     cells.add(DataCell(Container(
  //         alignment: Alignment.center, child: Text(item.IsIns.toString()))));
  //     cells.add(DataCell(Container(
  //         alignment: Alignment.centerRight,
  //         child: Text(item.branch.toString()))));

  //     rows.add(DataRow(cells: cells));
  //   });
  //   return rows;
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.all(5),
      width: Screens.width(context) * 0.79,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Screens.bodyheight(context) * 0.01),
      ),
      child: context.watch<ReportController>().keysList.isEmpty
          ? Container(
              height: Screens.padingHeight(context),
              child: Center(
                  child: CircularProgressIndicator(
                color: theme.primaryColor,
              )),
            )
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DataTable(
                    headingRowHeight: Screens.padingHeight(context) * 0.05,
                    dataRowHeight: Screens.padingHeight(context) * 0.045,
                    columnSpacing: 8.0,
                    border: TableBorder.symmetric(
                        inside: BorderSide(
                            color: theme.primaryColor.withOpacity(0.1))),
                    columns: _generateColumns(
                        context.watch<ReportController>().keysList),
                    rows: _generateRows(
                        context.watch<ReportController>().valuesddd),
                    headingTextStyle: theme.textTheme.bodyMedium!.copyWith(
                        color: theme.primaryColor, fontWeight: FontWeight.bold),
                  ),
                ],
              )),
    ));
  }
}
