import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Controller/StockOutwardController/StockOutwardController.dart';

class StockOutReqList extends StatefulWidget {
  StockOutReqList(
      {super.key,
      required this.theme,
      required this.searchHeight,
      required this.searchWidth});

  final ThemeData theme;
  double searchHeight;
  double searchWidth;

  @override
  State<StockOutReqList> createState() => _StockOutReqListState();
}

class _StockOutReqListState extends State<StockOutReqList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          top: widget.searchHeight * 0.02,
          left: widget.searchHeight * 0.01,
          right: widget.searchHeight * 0.01,
          bottom: widget.searchHeight * 0.01,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        width: widget.searchWidth * 1,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<StockOutwardController>().deletereq();
                    },
                    child: Text(" Pending Request",
                        style: widget.theme.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                  ),
                  IconButton(
                      onPressed: () {
                        context.read<StockOutwardController>().StockOutward =
                            [];
                        context.read<StockOutwardController>().openReqLineList =
                            [];

                        context.read<StockOutwardController>().init(context);
                      },
                      icon: const Icon(Icons.refresh))
                ],
              ),
            ),
            SizedBox(
              height: widget.searchHeight * 0.01,
            ),
            SizedBox(
              height: widget.searchHeight,
              child: context
                      .read<StockOutwardController>()
                      .StockOutward2
                      .isNotEmpty
                  ? ListView.builder(
                      itemCount: context
                          .watch<StockOutwardController>()
                          .StockOutward2
                          .length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Card(
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: widget.searchHeight * 0.01,
                                  left: widget.searchHeight * 0.01,
                                  right: widget.searchHeight * 0.01,
                                  bottom: widget.searchHeight * 0.01),
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.white,
                                  )),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "Request From ${context.watch<StockOutwardController>().StockOutward2[index].reqfromWhs}",
                                          style:
                                              widget.theme.textTheme.bodyLarge),
                                      Text(
                                          "Doc Num ${context.watch<StockOutwardController>().StockOutward2[index].documentno}",
                                          style:
                                              widget.theme.textTheme.bodyLarge),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Text(
                                      //     context
                                      //                 .watch<
                                      //                     StockOutwardController>()
                                      //                 .StockOutward2[index]
                                      //                 .docstatus ==
                                      //             '3'
                                      //         ? "# Against Stock  "
                                      //         : "# Against Order ",
                                      //     style:
                                      //         widget.theme.textTheme.bodyLarge),
                                      Text(
                                          context
                                              .read<StockOutwardController>()
                                              .config
                                              .alignDate(context
                                                  .read<
                                                      StockOutwardController>()
                                                  .StockOutward2[index]
                                                  .reqtransdate
                                                  .toString()),
                                          style:
                                              widget.theme.textTheme.bodyLarge)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                  : context
                              .read<StockOutwardController>()
                              .StockOutward
                              .isEmpty &&
                          context.read<StockOutwardController>().dbDataTrue ==
                              true &&
                          context
                              .read<StockOutwardController>()
                              .savedraftBill
                              .isEmpty
                      ? Center(
                          child: Text(
                            "No data found",
                            style: widget.theme.textTheme.bodyMedium!
                                .copyWith(color: Colors.black),
                          ),
                        )
                      : context
                                  .read<StockOutwardController>()
                                  .StockOutward
                                  .isEmpty &&
                              context
                                  .read<StockOutwardController>()
                                  .savedraftBill
                                  .isNotEmpty
                          ? Center(
                              child: Text(
                                "Data Save as Draft Bill..!!",
                                style: widget.theme.textTheme.bodyMedium!
                                    .copyWith(color: Colors.black),
                              ),
                            )
                          : context
                                      .read<StockOutwardController>()
                                      .openSalesReq
                                      .isEmpty &&
                                  context
                                          .read<StockOutwardController>()
                                          .dbDataTrue ==
                                      false
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: widget.theme.primaryColor,
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: context
                                      .read<StockOutwardController>()
                                      .openSalesReq
                                      .length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () async {
                                        setState(() {
                                          context
                                              .read<StockOutwardController>()
                                              .addIndex = [];
                                          context
                                              .read<StockOutwardController>()
                                              .i_value = index;

                                          context
                                              .read<StockOutwardController>()
                                              .serialbatchList = [];
                                          context
                                              .read<StockOutwardController>()
                                              .noMsgText = '';

                                          context
                                              .read<StockOutwardController>()
                                              .filterSerialbatchList = [];
                                          context
                                              .read<StockOutwardController>()
                                              .selectIndex = index;
                                          context
                                                  .read<StockOutwardController>()
                                                  .qtymycontroller =
                                              List.generate(
                                                  100,
                                                  (ij) =>
                                                      TextEditingController());
                                          context
                                              .read<StockOutwardController>()
                                              .callOpenReqLineAPi(
                                                  context,
                                                  widget.theme,
                                                  context
                                                      .read<
                                                          StockOutwardController>()
                                                      .openSalesReq[index]
                                                      .docEntry
                                                      .toString(),
                                                  context
                                                      .read<
                                                          StockOutwardController>()
                                                      .openSalesReq[index]
                                                      .cardCode);

                                          context
                                              .read<StockOutwardController>()
                                              .selectAll = true;
                                        });
                                      },
                                      child: Card(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: widget.searchHeight * 0.01,
                                              left: widget.searchHeight * 0.01,
                                              right: widget.searchHeight * 0.01,
                                              bottom:
                                                  widget.searchHeight * 0.01),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.white,
                                            border: Border.all(
                                                color: context
                                                            .read<
                                                                StockOutwardController>()
                                                            .selectIndex ==
                                                        index
                                                    ? Colors.green
                                                    : Colors.white),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      "Request From ${context.watch<StockOutwardController>().openSalesReq[index].uwhsCode}  ",
                                                      style: widget.theme
                                                          .textTheme.bodyLarge),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      "# ${context.watch<StockOutwardController>().openSalesReq[index].docNum.toString()}",
                                                      style: widget.theme
                                                          .textTheme.bodyLarge),
                                                  Text(
                                                      context
                                                          .read<
                                                              StockOutwardController>()
                                                          .config
                                                          .alignDate(context
                                                              .watch<
                                                                  StockOutwardController>()
                                                              .openSalesReq[
                                                                  index]
                                                              .docDate
                                                              .toString()),
                                                      style: widget.theme
                                                          .textTheme.bodyLarge)
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
        ));
  }
}
