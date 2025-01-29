import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Controller/StockOutwardController/StockOutwardController.dart';
import '../../../Models/DataModel/StockOutwardModel/StockOutwardListModel.dart';

class StockOutDraftbill extends StatelessWidget {
  StockOutDraftbill(
      {super.key,
      required this.theme,
      required this.searchHeight,
      required this.searchWidth,
      required this.stockOut});

  final ThemeData theme;
  double searchHeight;
  double searchWidth;
  List<StockOutwardList> stockOut;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: searchWidth * 1,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: searchHeight,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: ListView.builder(
                    itemCount: stockOut.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          context
                              .read<StockOutwardController>()
                              .mapvalue(stockOut, index);
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
                                color: Colors.grey.withOpacity(0.04),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.white)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "Request From ${stockOut[index].reqfromWhs}",
                                    style: theme.textTheme.bodyMedium),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('# ${stockOut[index].documentno}',
                                        style: theme.textTheme.bodyMedium),
                                    Text(
                                        context
                                            .read<StockOutwardController>()
                                            .config
                                            .alignDate(stockOut[index]
                                                .reqtransdate
                                                .toString()),
                                        style: theme.textTheme.bodyMedium),
                                  ],
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
