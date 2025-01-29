import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../Controller/StockInwardController/StockInwardContler.dart';
import '../../../Models/DataModel/StockInwardModel/StockInwardListModel.dart';

class StockInscanPage extends StatefulWidget {
  StockInscanPage(
      {super.key,
      required this.theme,
      required this.ind,
      required this.index,
      required this.searchHeight,
      required this.searchWidth,
      required this.datalist});

  final ThemeData theme;
  int? index;
  int? ind;
  StockInwardDetails? datalist;
  double searchHeight;
  double searchWidth;

  @override
  State<StockInscanPage> createState() => _StockInscanPageState();
}

class _StockInscanPageState extends State<StockInscanPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          top: widget.searchHeight * 0.02,
          left: widget.searchWidth * 0.01,
          right: widget.searchWidth * 0.01,
          bottom: widget.searchHeight * 0.01,
        ),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        width: widget.searchWidth * 1,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: widget.searchWidth * 0.9,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: widget.searchHeight * 0.01,
                      ),
                      Container(
                          alignment: Alignment.center,
                          width: widget.searchWidth * 1.18,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 207, 201, 201)),
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            style: widget.theme.textTheme.bodyMedium,
                            cursorColor: Colors.grey,
                            controller: context
                                .read<StockInwrdController>()
                                .stInController[0],
                            onEditingComplete: () {
                              setState(() {
                                context.read<StockInwrdController>().scanmethod(
                                    widget.index!,
                                    widget.datalist!,
                                    widget.ind!);
                              });
                              context
                                  .read<StockInwrdController>()
                                  .disableKeyBoard(context);
                            },
                            onChanged: (v) {
                              if (v.isNotEmpty) {
                                context.read<StockInwrdController>().msg = "";
                              }
                            },
                            decoration: InputDecoration(
                              filled: false,
                              hintText: 'Scan Here..',
                              hintStyle:
                                  widget.theme.textTheme.bodyMedium?.copyWith(),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 10,
                              ),
                            ),
                          )),
                      Row(
                        children: [
                          Text(
                            "  ${context.watch<StockInwrdController>().msg}",
                            style: widget.theme.textTheme.bodySmall!
                                .copyWith(color: Colors.red),
                          ),
                        ],
                      ),
                      SizedBox(height: widget.searchHeight * 0.008),
                      SizedBox(
                        width: widget.searchWidth * 1.18,
                        height: widget.searchHeight * 0.908,
                        child: context
                                .read<StockInwrdController>()
                                .stockInward
                                .isEmpty
                            ? Container()
                            : context
                                        .read<StockInwrdController>()
                                        .stockInward[context
                                            .read<StockInwrdController>()
                                            .get_i_value]
                                        .data![context
                                            .read<StockInwrdController>()
                                            .batch_i!]
                                        .serialbatchList ==
                                    null
                                ? const Center(
                                    child: Text("Scan Item.."),
                                  )
                                : ListView.builder(
                                    itemCount: context
                                        .read<StockInwrdController>()
                                        .stockInward[context
                                            .watch<StockInwrdController>()
                                            .get_i_value]
                                        .data![context
                                            .read<StockInwrdController>()
                                            .batch_i!]
                                        .serialbatchList!
                                        .length,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, i) {
                                      return Card(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            top: widget.searchHeight * 0.01,
                                            left: widget.searchHeight * 0.01,
                                            right: widget.searchHeight * 0.01,
                                            bottom: widget.searchHeight * 0.01,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.grey.withOpacity(0.04),
                                            border:
                                                Border.all(color: Colors.white),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          widget.searchWidth *
                                                              0.2,
                                                      child: Text(
                                                        "${context.read<StockInwrdController>().stockInward[context.watch<StockInwrdController>().get_i_value].data![context.read<StockInwrdController>().batch_i!].serialbatchList![i].itemcode}",
                                                        style: widget
                                                            .theme
                                                            .textTheme
                                                            .bodyLarge,
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      width:
                                                          widget.searchWidth *
                                                              0.2,
                                                      child: Text(
                                                        "${context.read<StockInwrdController>().stockInward[context.watch<StockInwrdController>().get_i_value].data![context.read<StockInwrdController>().batch_i!].serialbatchList![i].serialbatch}",
                                                        style: widget
                                                            .theme
                                                            .textTheme
                                                            .bodyLarge,
                                                      ),
                                                    ),
                                                  ]),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    width: widget.searchWidth *
                                                        0.2,
                                                    child: Text(
                                                      "Scanned Qty : ${context.read<StockInwrdController>().stockInward[context.watch<StockInwrdController>().get_i_value].data![context.read<StockInwrdController>().batch_i!].serialbatchList![i].qty}",
                                                      style: widget.theme
                                                          .textTheme.bodyLarge,
                                                    ),
                                                  ),
                                                  Container(
                                                      width:
                                                          widget.searchWidth *
                                                              0.1,
                                                      height:
                                                          widget.searchHeight *
                                                              0.07,
                                                      alignment:
                                                          Alignment.center,
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: widget
                                                                  .searchWidth *
                                                              0.005),
                                                      child: TextFormField(
                                                        textAlign:
                                                            TextAlign.right,
                                                        onTap: () {
                                                          context
                                                                  .read<
                                                                      StockInwrdController>()
                                                                  .sinqtycontroller[
                                                                      i]
                                                                  .text =
                                                              context
                                                                  .read<
                                                                      StockInwrdController>()
                                                                  .sinqtycontroller[
                                                                      i]
                                                                  .text;
                                                          context
                                                                  .read<
                                                                      StockInwrdController>()
                                                                  .sinqtycontroller[
                                                                      i]
                                                                  .selection =
                                                              TextSelection(
                                                            baseOffset: 0,
                                                            extentOffset: context
                                                                .read<
                                                                    StockInwrdController>()
                                                                .sinqtycontroller[
                                                                    i]
                                                                .text
                                                                .length,
                                                          );
                                                        },
                                                        style: widget
                                                            .theme
                                                            .textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .black),
                                                        onChanged: (v) {},
                                                        cursorColor:
                                                            Colors.grey,
                                                        textDirection:
                                                            TextDirection.ltr,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        // inputFormatters: [
                                                        //   FilteringTextInputFormatter
                                                        //       .digitsOnly
                                                        // ],
                                                        onEditingComplete: () {
                                                          setState(() {
                                                            context.read<StockInwrdController>().stkInEditQty(
                                                                context
                                                                    .read<
                                                                        StockInwrdController>()
                                                                    .get_i_value,
                                                                context
                                                                    .read<
                                                                        StockInwrdController>()
                                                                    .stockInward[context
                                                                        .read<
                                                                            StockInwrdController>()
                                                                        .get_i_value]
                                                                    .data![context
                                                                        .read<
                                                                            StockInwrdController>()
                                                                        .batch_i!]
                                                                    .serialbatchList![
                                                                        i]
                                                                    .serialbatch!,
                                                                context
                                                                    .read<
                                                                        StockInwrdController>()
                                                                    .batch_i!,
                                                                context
                                                                    .read<
                                                                        StockInwrdController>()
                                                                    .stockInward[context
                                                                        .read<
                                                                            StockInwrdController>()
                                                                        .get_i_value]
                                                                    .data![context
                                                                        .read<
                                                                            StockInwrdController>()
                                                                        .batch_i!]
                                                                    .itemcode!,
                                                                i);
                                                          });
                                                          context
                                                              .read<
                                                                  StockInwrdController>()
                                                              .disableKeyBoard(
                                                                  context);
                                                        },
                                                        controller: context
                                                            .read<
                                                                StockInwrdController>()
                                                            .sinqtycontroller[i],
                                                        decoration:
                                                            InputDecoration(
                                                          filled: false,
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical: 0,
                                                            horizontal: 5,
                                                          ),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                      ),
                      SizedBox(
                        height: widget.searchHeight * 0.05,
                      ),
                      SizedBox(
                          width: widget.searchWidth,
                          child: ElevatedButton(
                              onPressed: () {
                                // context
                                //     .read<StockInwrdController>()
                                //     .stInLineRefersh(
                                //         widget.index!,
                                //         widget.ind!,
                                //         context
                                //             .read<StockInwrdController>()
                                //             .stockInward[widget.index!]
                                //             .data![widget.ind!]
                                //             .serialbatchList);
                                // context.read<StockInwrdController>().passData(
                                //     widget.theme, context, widget.index!);
                                context
                                    .read<StockInwrdController>()
                                    .isselectmethod();
                              },
                              child: const Text("Save and Back"))),
                      SizedBox(
                        height: widget.searchHeight * 0.01,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
