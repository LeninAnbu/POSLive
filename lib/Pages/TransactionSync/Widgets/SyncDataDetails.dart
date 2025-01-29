import 'package:flutter/material.dart';
import 'package:posproject/Constant/Configuration.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Controller/DashBoardController/DashboardController.dart';
import 'package:posproject/Controller/TransacationSyncController/TransactionSyncController.dart';
import 'package:provider/provider.dart';

class SyncDataDetails extends StatefulWidget {
  SyncDataDetails(
      {super.key,
      required this.content,
      required this.theme,
      required this.syncDatadetails});
  String content;
  final ThemeData theme;
  SyncData syncDatadetails;

  @override
  State<SyncDataDetails> createState() => _SyncDataDetailsState();
}

class _SyncDataDetailsState extends State<SyncDataDetails> {
  @override
  Widget build(BuildContext context) {
    Configure config = Configure();
    return Container(
        padding: EdgeInsets.all(Screens.bodyheight(context) * 0.008),
        // height: Screens.padingHeight(context) * 0.09,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: Screens.width(context) * 0.2,
                    // color: Colors.amber,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: Screens.width(context),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Doctype",
                            style: widget.theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          width: Screens.width(context),
                          child: Text(
                            "${widget.syncDatadetails.doctype}",
                            style: widget.theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: Screens.width(context)*0.02,),
                  Container(
                    alignment: Alignment.topRight,
                    width: Screens.width(context) * 0.2,
                    // color: Colors.blueAccent,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: Screens.width(context),
                          alignment: Alignment.topRight,
                          child: Text(
                            "Customer",
                            style: widget.theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          width: Screens.width(context),
                          child: Text(
                            "${widget.syncDatadetails.customername}",
                            textAlign: TextAlign.end,
                            style: widget.theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: Screens.width(context) * 0.2,
                    // color: Colors.amber,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: Screens.width(context),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Sap No",
                            style: widget.theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          width: Screens.width(context),
                          child: Text(
                            "${widget.syncDatadetails.sapNo}",
                            style: widget.theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: Screens.width(context)*0.02,),
                  Container(
                    alignment: Alignment.topRight,
                    width: Screens.width(context) * 0.2,
                    // color: Colors.blueAccent,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: Screens.width(context),
                          alignment: Alignment.topRight,
                          child: Text(
                            "Sap Date",
                            style: widget.theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          width: Screens.width(context),
                          child: Text(
                            config.alignDate(
                                widget.syncDatadetails.sapDate.toString()),
                            // textAlign: TextAlign.end,
                            style: widget.theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: Screens.width(context) * 0.2,
                    // color: Colors.amber,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: Screens.width(context),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Doc No",
                            style: widget.theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          width: Screens.width(context),
                          child: Text(
                            "${widget.syncDatadetails.docNo}",
                            style: widget.theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    width: Screens.width(context) * 0.2,
                    // color: Colors.blueAccent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: Screens.width(context),
                          alignment: Alignment.topRight,
                          child: Text(
                            "Doc Date",
                            style: widget.theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          width: Screens.width(context),
                          child: Text(
                            config.alignDate(
                                widget.syncDatadetails.docdate.toString()),
                            // textAlign: TextAlign.end,
                            style: widget.theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: Screens.width(context) * 0.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Screens.width(context),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Q Status",
                            style: widget.theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          width: Screens.width(context),
                          child: Text(
                            "${widget.syncDatadetails.sapStatus}",
                            style: widget.theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    width: Screens.width(context) * 0.2,
                    // color: Colors.blueAccent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                            alignment: Alignment.topRight,
                            width: Screens.width(context),
                            child: context
                                        .watch<TransactionSyncController>()
                                        .syncbool ==
                                    true
                                ? const CircularProgressIndicator()
                                : IconButton(
                                    onPressed:
                                        widget.syncDatadetails.sapStatus == 'C'
                                            ? null
                                            : () {
                                                setState(() {
                                                  context
                                                      .read<
                                                          TransactionSyncController>()
                                                      .refreshQueue(
                                                          widget
                                                              .syncDatadetails,
                                                          context);
                                                });
                                              },
                                    icon: const Icon(Icons.sync),
                                    color: Colors.blue,
                                  )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
