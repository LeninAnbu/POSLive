import 'package:flutter/material.dart';
import 'package:posproject/Models/DataModel/StockInwardModel/StockInwardListModel.dart';
import 'package:provider/provider.dart';

import '../../../../../Controller/StockInwardController/StockInwardContler.dart';

class StockInDraftbill extends StatelessWidget {
  StockInDraftbill(
      {super.key,
      required this.theme,
      required this.searchHeight,
      required this.searchWidth,
      required this.stockIn});

  final ThemeData theme;
  double searchHeight;
  double searchWidth;
  List<StockInwardList> stockIn;
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
                    itemCount: stockIn.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          context
                              .read<StockInwrdController>()
                              .mapvalue(stockIn, index);
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
                                    "Inventory Transfer From ${stockIn[index].reqfromWhs}",
                                    style: theme.textTheme.bodyMedium),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "# ${context.read<StockInwrdController>().config.alignDate(stockIn[index].reqtransdate.toString())}",
                                        style: theme.textTheme.bodyMedium),
                                    Text('${stockIn[index].documentno}',
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
            ],
          ),
        ));
  }
}
