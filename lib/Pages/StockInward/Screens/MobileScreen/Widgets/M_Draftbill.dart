import 'package:flutter/material.dart';
import 'package:posproject/Models/DataModel/StockInwardModel/StockInwardListModel.dart';

import '../../../../../Controller/StockInwardController/StockInwardContler.dart';

class M_StockInDraftbill extends StatelessWidget {
  M_StockInDraftbill(
      {super.key,
      required this.theme,
      required this.prdsrch,
      required this.searchHeight,
      required this.searchWidth,
      required this.stockIn});

  final ThemeData theme;
  StockInwrdController prdsrch;
  double searchHeight;
  double searchWidth;
  List<StockInwardList> stockIn;
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
                    itemCount: stockIn.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          prdsrch.mapvalue(stockIn, index);
                          Navigator.pop(context);
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
                                Text(
                                    "Inventory Transfer From ${stockIn[index].reqtoWhs}",
                                    style: theme.textTheme.bodyMedium),
                                Row(
                                  children: [
                                    Text(
                                        "# ${stockIn[index].reqtransdate}  |  ",
                                        style: theme.textTheme.bodyMedium),
                                    Text('${stockIn[index].branch}',
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
