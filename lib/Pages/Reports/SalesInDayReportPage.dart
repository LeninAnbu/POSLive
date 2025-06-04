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
