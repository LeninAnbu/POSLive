import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Controller/DashBoardController/DashboardController.dart';

class Transaction extends StatefulWidget {
  Transaction({
    super.key,
    required this.theme,
    required this.dbWidth,
    required this.dbHeight,
  });
  double dbHeight;
  double dbWidth;

  ThemeData theme;

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: widget.dbHeight * 0.02, top: widget.dbHeight * 0.02),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.white),
      width: widget.dbWidth,
      height: widget.dbHeight * 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Transaction Sync',
            style: widget.theme.textTheme.bodyMedium
                ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: context.watch<DashBoardController>().syncData1.isEmpty &&
                    context.watch<DashBoardController>().syncdataBool == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : context.watch<DashBoardController>().syncData1.isEmpty &&
                        context.watch<DashBoardController>().syncdataBool ==
                            false
                    ? const Center(
                        child: Text("No data..!!"),
                      )
                    : ListView.builder(
                        itemCount: context
                            .watch<DashBoardController>()
                            .syncData1
                            .length,
                        itemBuilder: (context, index) {
                          return Card(
                              margin: EdgeInsets.all(1.5),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: context
                                                  .watch<DashBoardController>()
                                                  .syncData1[index]
                                                  .qStatus !=
                                              'C'
                                          ? Colors.redAccent
                                          : Colors.green),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(
                                  widget.dbHeight * 0.02,
                                ),
                                width: widget.dbWidth * 0.9,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          width: widget.dbWidth * 0.1,
                                          child: Text(
                                            "Doc No",
                                            style: widget
                                                .theme.textTheme.bodyMedium
                                                ?.copyWith(),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          width: widget.dbWidth * 0.24,
                                          child: Text(
                                            "${context.watch<DashBoardController>().syncData1[index].docNo}",
                                            style: widget
                                                .theme.textTheme.bodyMedium
                                                ?.copyWith(),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: widget.dbWidth * 0.32,
                                          child: Text(
                                            "${context.watch<DashBoardController>().syncData1[index].doctype}",
                                            style: widget
                                                .theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.grey),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          width: widget.dbWidth * 0.12,
                                          child: Text(
                                            "Doc Date",
                                            style: widget
                                                .theme.textTheme.bodyMedium
                                                ?.copyWith(),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: widget.dbWidth * 0.15,
                                          child: Text(
                                            context
                                                .read<DashBoardController>()
                                                .config
                                                .alignDate(context
                                                    .watch<
                                                        DashBoardController>()
                                                    .syncData1[index]
                                                    .docdate
                                                    .toString()),
                                            style: widget
                                                .theme.textTheme.bodyMedium
                                                ?.copyWith(),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          width: widget.dbWidth * 0.1,
                                          child: Text(
                                            "SAP No",
                                            style: widget
                                                .theme.textTheme.bodyMedium
                                                ?.copyWith(),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          width: widget.dbWidth * 0.24,
                                          child: Text(
                                            "${context.watch<DashBoardController>().syncData1[index].sapNo}",
                                            style: widget
                                                .theme.textTheme.bodyMedium
                                                ?.copyWith(),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: widget.dbWidth * 0.32,
                                          child: Text(
                                            "${context.watch<DashBoardController>().syncData1[index].customername}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            style: widget
                                                .theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.grey),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          width: widget.dbWidth * 0.12,
                                          child: Text(
                                            "SAP Date",
                                            style: widget
                                                .theme.textTheme.bodyMedium
                                                ?.copyWith(),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: widget.dbWidth * 0.15,
                                          child: Text(
                                            context
                                                .read<DashBoardController>()
                                                .config
                                                .alignDate(context
                                                    .watch<
                                                        DashBoardController>()
                                                    .syncData1[index]
                                                    .sapDate
                                                    .toString()),
                                            style: widget
                                                .theme.textTheme.bodyMedium
                                                ?.copyWith(),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ));
                        }),
          ),
        ],
      ),
    );
  }
}
