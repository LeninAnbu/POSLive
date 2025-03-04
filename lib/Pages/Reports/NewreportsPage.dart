import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Controller/ReportsController.dart';
import 'package:posproject/Pages/Reports/ShowReportDetails.dart';
import 'package:provider/provider.dart';
import '../../Widgets/Drawer.dart';

class NewChangesReport extends StatefulWidget {
  const NewChangesReport({super.key});

  @override
  State<NewChangesReport> createState() => _NewChangesReportState();
}

class _NewChangesReportState extends State<NewChangesReport> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ReportController>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: context.read<ReportController>().onbackpress,
      child: Scaffold(
        drawer: naviDrawer(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text('Reports'),
          actions: [
            context.read<ReportController>().valuesddd.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      context.read<ReportController>().saveAllExcel(
                            context,
                            theme,
                            context.read<ReportController>().valuesddd,
                            context.read<ReportController>().keysList,
                          );
                    },
                    icon: Icon(
                      Icons.document_scanner,
                      color: Colors.white,
                    ))
                : Container(),
            // IconButton(
            //   onPressed: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => CollectionReceiptPdf()));
            //   },
            //   icon: Icon(Icons.picture_as_pdf),
            // )
          ],
        ),
        body: Container(
            padding: EdgeInsets.only(top: Screens.padingHeight(context) * 0.02),
            child: context.watch<ReportController>().reportsList.isNotEmpty
                ? Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: Screens.padingHeight(context),
                        color: Colors.grey[100],
                        width: Screens.width(context) * 0.2,
                        child: ListView.builder(
                            itemCount: context
                                .watch<ReportController>()
                                .reportsList
                                .length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: context
                                            .watch<ReportController>()
                                            .reportsList[index]
                                            .reportclr ==
                                        true
                                    ? theme.primaryColor.withOpacity(0.1)
                                    : Colors.white,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      context
                                          .read<ReportController>()
                                          .showListVal = false;
                                      context
                                          .read<ReportController>()
                                          .noDataMsg = '';

                                      context
                                              .read<ReportController>()
                                              .frmController =
                                          List.generate(150,
                                              (i) => TextEditingController());
                                      context
                                          .read<ReportController>()
                                          .onTapReportList(
                                              index, context, theme);
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Text(context
                                            .read<ReportController>()
                                            .reportsList[index]
                                            .name),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      // context.watch<ReportController>().valuesddd.isNotEmpty &&
                      //         context.watch<ReportController>().loadingscrn ==
                      //             false
                      //     ?
                      Container(
                        child:
                            // SalesInDayReport()
                            ShowReportDet(),
                      )
                    ],
                  )
                : Center(
                    child: Container(
                      child: Text('No data found'),
                    ),
                  )),
      ),
    );
  }
}
