import 'package:flutter/material.dart';
import 'package:posproject/Controller/StockRequestController/StockRequestController.dart';

import '../../../../../Models/DataModel/StockReqModel/orderModel.dart';

class M_StockReqDraftbill extends StatelessWidget {
  M_StockReqDraftbill(
      {super.key,
      required this.theme,
      required this.prdsrch,
      required this.searchHeight,
      required this.searchWidth,
      required this.stockReq});

  final ThemeData theme;
  StockReqController prdsrch;
  double searchHeight;
  double searchWidth;
  List<Orderdetails> stockReq;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: searchWidth * 1,
        //  height:searchHeight*0.9 ,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(" Pending Inwards",
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ),
              Container(
                height: searchHeight,
                // color: Colors.green,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: ListView.builder(
                    itemCount: stockReq.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          prdsrch.mapData(stockReq, index, context, theme);
                          // prdsrch.StockReqward.addAll(StockReq);
                          // StockReq.removeAt(index);
                          // prdsrch.callList();
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
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                border: Border.all(color: Colors.white)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${stockReq[index].whsAdd!.whsAddress}",
                                    style: theme.textTheme.bodyMedium),
                                Row(
                                  children: [
                                    Text(
                                        "# ${stockReq[index].whsAdd!.pinCode}  |  ",
                                        style: theme.textTheme.bodyMedium),
                                    Text('${stockReq[index].whsAdd!.whsGst}',
                                        style: theme.textTheme.bodyMedium)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )

// Container(),
            ],
          ),
        ));
  }
}
