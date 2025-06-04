import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:posproject/Controller/TransacationSyncController/TransactionSyncController.dart';
import 'package:posproject/Pages/TransactionSync/Widgets/SyncDataDetails.dart';
import 'package:posproject/Widgets/AlertBox.dart';

class SyncdataListPage extends StatefulWidget {
  SyncdataListPage(
      {super.key, required this.searchHeight, required this.searchWidth});

  double searchHeight;
  double searchWidth;

  @override
  State<SyncdataListPage> createState() => _SyncdataListPageState();
}

class _SyncdataListPageState extends State<SyncdataListPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: widget.searchHeight,
      width: widget.searchWidth,
      padding: EdgeInsets.only(
          top: widget.searchHeight * 0.01,
          left: widget.searchHeight * 0.01,
          right: widget.searchHeight * 0.01,
          bottom: widget.searchHeight * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              alignment: Alignment.center,
              width: widget.searchWidth * 1,
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 240, 235, 235)),
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey.withOpacity(0.01),
              ),
              child: TextFormField(
                style: theme.textTheme.bodyMedium,
                onChanged: (v) {
                  context
                      .read<TransactionSyncController>()
                      .filterListSearched(v);
                },
                cursorColor: Colors.grey,
                onEditingComplete: () {},
                decoration: InputDecoration(
                  filled: false,
                  hintText: 'Search Here..',
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                ),
              )),
          SizedBox(
            height: widget.searchHeight * 0.01,
          ),
          SizedBox(
            height: widget.searchHeight * 0.89,
            child: context.watch<TransactionSyncController>().loadingbtn == true
                ? Center(
                    child: CircularProgressIndicator(
                    color: theme.primaryColor,
                  ))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: widget.searchHeight * 0.01,
                          left: widget.searchHeight * 0.01,
                          right: widget.searchHeight * 0.01,
                          bottom: widget.searchHeight * 0.01,
                        ),
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                alignment: Alignment.center,
                                width: widget.searchWidth * 0.05,
                                child: Text(
                                  "S.No",
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.white),
                                )),
                            Container(
                                alignment: Alignment.center,
                                width: widget.searchWidth * 0.15,
                                child: Text(
                                  "Doc.No",
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.white),
                                )),
                            Container(
                                alignment: Alignment.center,
                                width: widget.searchWidth * 0.2,
                                child: Text(
                                  "Doc Type",
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.white),
                                )),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                  alignment: Alignment.center,
                                  width: widget.searchWidth * 0.18,
                                  child: Text(
                                    "Customer",
                                    style: theme.textTheme.bodyMedium
                                        ?.copyWith(color: Colors.white),
                                  )),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                  alignment: Alignment.centerRight,
                                  width: widget.searchWidth * 0.12,
                                  child: Text(
                                    "Sap No",
                                    style: theme.textTheme.bodyMedium
                                        ?.copyWith(color: Colors.white),
                                  )),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                  alignment: Alignment.center,
                                  width: widget.searchWidth * 0.1,
                                  child: Text(
                                    "Sap Date",
                                    style: theme.textTheme.bodyMedium
                                        ?.copyWith(color: Colors.white),
                                  )),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                  alignment: Alignment.center,
                                  width: widget.searchWidth * 0.15,
                                  child: Text(
                                    "Status",
                                    style: theme.textTheme.bodyMedium
                                        ?.copyWith(color: Colors.white),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: context
                                          .watch<TransactionSyncController>()
                                          .syncdataBool ==
                                      true &&
                                  context
                                      .watch<TransactionSyncController>()
                                      .filtersyncData1
                                      .isEmpty
                              ? Center(
                                  child: CircularProgressIndicator(
                                  color: theme.primaryColor,
                                ))
                              : context
                                              .watch<
                                                  TransactionSyncController>()
                                              .syncdataBool ==
                                          false &&
                                      context
                                          .watch<TransactionSyncController>()
                                          .filtersyncData1
                                          .isEmpty
                                  ? const Center(
                                      child: Text("Does Not Have data..!!"))
                                  : ListView.builder(
                                      itemCount: context
                                          .watch<TransactionSyncController>()
                                          .filtersyncData1
                                          .length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                context
                                                    .read<
                                                        TransactionSyncController>()
                                                    .syncbool = false;

                                                showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          content: AlertBox(
                                                            payMent: 'Details',
                                                            errormsg: false,
                                                            widget: Center(
                                                                child:
                                                                    SyncDataDetails(
                                                              content: '',
                                                              theme: theme,
                                                              syncDatadetails: context
                                                                  .read<
                                                                      TransactionSyncController>()
                                                                  .filtersyncData1[index],
                                                            )),
                                                            buttonName: null,
                                                          ));
                                                    }).then((value) {});
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                top: widget.searchHeight * 0.01,
                                                left:
                                                    widget.searchHeight * 0.01,
                                                right:
                                                    widget.searchHeight * 0.01,
                                                bottom:
                                                    widget.searchHeight * 0.02,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.grey
                                                    .withOpacity(0.04),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width:
                                                          widget.searchWidth *
                                                              0.05,
                                                      child: Text(
                                                        "${index + 1}",
                                                        style: theme.textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .black),
                                                      )),
                                                  Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width:
                                                          widget.searchWidth *
                                                              0.15,
                                                      child: Text(
                                                        "${context.watch<TransactionSyncController>().filtersyncData1[index].docNo}",
                                                        style: theme.textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .black),
                                                      )),
                                                  Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width:
                                                          widget.searchWidth *
                                                              0.2,
                                                      child: Text(
                                                        "${context.watch<TransactionSyncController>().filtersyncData1[index].doctype}",
                                                        style: theme.textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .black),
                                                      )),
                                                  Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      width:
                                                          widget.searchWidth *
                                                              0.18,
                                                      child: Text(
                                                        "${context.watch<TransactionSyncController>().filtersyncData1[index].customername}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: theme.textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .black),
                                                      )),
                                                  Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      width:
                                                          widget.searchWidth *
                                                              0.1,
                                                      child: Text(
                                                        "${context.watch<TransactionSyncController>().filtersyncData1[index].sapNo}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: theme.textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .black),
                                                      )),
                                                  Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      width:
                                                          widget.searchWidth *
                                                              0.1,
                                                      child: Text(
                                                        "${context.watch<TransactionSyncController>().config.alignDate(context.watch<TransactionSyncController>().filtersyncData1[index].sapDate.toString())}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: theme.textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .black),
                                                      )),
                                                  Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width:
                                                          widget.searchWidth *
                                                              0.15,
                                                      child: Text(
                                                        "${context.watch<TransactionSyncController>().filtersyncData1[index].sapStatus}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: theme.textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .black),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      })),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
