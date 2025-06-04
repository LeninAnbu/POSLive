import 'package:flutter/material.dart';
import 'package:posproject/Controller/ReportsController.dart';
import 'package:provider/provider.dart';

import '../../Constant/Screen.dart';

class ShowReportDet extends StatefulWidget {
  const ShowReportDet({super.key});

  @override
  State<ShowReportDet> createState() => _ShowReportDetState();
}

class _ShowReportDetState extends State<ShowReportDet> {
  final ScrollController _headerScrollController = ScrollController();
  final ScrollController _dataScrollController = ScrollController();

  bool _isHeaderScrolling = false;
  bool _isDataScrolling = false;

  void initState() {
    super.initState();
    _headerScrollController.addListener(() {
      if (_isHeaderScrolling) return;
      _isDataScrolling = true;
      _dataScrollController.jumpTo(_headerScrollController.position.pixels);
      _isDataScrolling = false;
    });

    _dataScrollController.addListener(() {
      if (_isDataScrolling) return;
      _isHeaderScrolling = true;
      _headerScrollController.jumpTo(_dataScrollController.position.pixels);
      _isHeaderScrolling = false;
    });
  }

  @override
  void dispose() {
    _headerScrollController.dispose();
    _dataScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Screens.width(context) * 0.79,
      child: context.watch<ReportController>().valuesddd.isEmpty &&
              context.watch<ReportController>().noDataMsg.isEmpty &&
              context.watch<ReportController>().loadingscrn == true
          ? Container(child: Center(child: CircularProgressIndicator()))
          : context.watch<ReportController>().valuesddd.isEmpty &&
                  context.watch<ReportController>().noDataMsg.isNotEmpty
              ? Container(
                  child: Center(
                      child: Text(context.watch<ReportController>().noDataMsg)))
              : Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: Screens.padingHeight(context) * 0.04,
                              width: Screens.width(context) * 0.79,
                              child: ListView.builder(
                                controller: _headerScrollController,
                                scrollDirection: Axis.horizontal,
                                itemCount: context
                                    .watch<ReportController>()
                                    .keysList
                                    .length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 0.0),
                                    child: Container(
                                      color: Colors.blue,
                                      alignment: Alignment.center,
                                      width: Screens.width(context) * 0.1,
                                      child: Text(
                                        context
                                            .watch<ReportController>()
                                            .keysList[index],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SingleChildScrollView(
                              controller: _dataScrollController,
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: context
                                      .watch<ReportController>()
                                      .valuesddd
                                      .map((dataMap) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                        color: Colors.blue,
                                        width: 0.25,
                                      ))),
                                      child: Row(
                                        children: context
                                            .watch<ReportController>()
                                            .keysList
                                            .map((key) {
                                          return Padding(
                                            padding: EdgeInsets.all(0.0),
                                            child: Container(
                                              alignment: Alignment.center,
                                              width:
                                                  Screens.width(context) * 0.1,
                                              child: Text(
                                                dataMap
                                                        .getFieldValue(key)
                                                        ?.toString() ??
                                                    '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
    );
  }
}
