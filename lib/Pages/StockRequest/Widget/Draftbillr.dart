import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:posproject/Controller/StockRequestController/StockRequestController.dart';
import 'package:posproject/Models/DataModel/StockReqModel/orderModel.dart';
import 'package:provider/provider.dart';

class StockReqDraftbill extends StatelessWidget {
  StockReqDraftbill(
      {super.key,
      required this.theme,
      required this.searchHeight,
      required this.searchWidth,
      required this.stockReq});

  final ThemeData theme;
  double searchHeight;
  double searchWidth;
  List<Orderdetails> stockReq;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: searchWidth * 1,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(" Pending Inwards",
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ),
              Container(
                height: searchHeight,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: ListView.builder(
                    itemCount: stockReq.length,
                    itemBuilder: (context, index) {
                      log("StockReq.length::${stockReq.length}");
                      return InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          context
                              .read<StockReqController>()
                              .mapData(stockReq, index, context, theme);
                        },
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.only(
                                top: searchHeight * 0.01,
                                left: searchHeight * 0.01,
                                right: searchHeight * 0.01,
                                bottom: searchHeight * 0.01),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                border: Border.all(color: Colors.white)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("${stockReq[index].whsAdd!.whsName}",
                                        style: theme.textTheme.bodyMedium),
                                    Row(
                                      children: [
                                        Text(
                                            "${stockReq[index].whsAdd!.whsCode}  |  ",
                                            style: theme.textTheme.bodyMedium),
                                        Text(
                                            '${stockReq[index].whsAdd!.whsCity}',
                                            style: theme.textTheme.bodyMedium)
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  context
                                      .watch<StockReqController>()
                                      .config
                                      .aligntimeDate(stockReq[index]
                                          .whsAdd!
                                          .createdateTime
                                          .toString()),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ));
  }
}
