import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Constant/Screen.dart';
import '../../../Controller/StockInwardController/StockInwardContler.dart';

class OpenInwardListPage extends StatefulWidget {
  const OpenInwardListPage({super.key});

  @override
  State<OpenInwardListPage> createState() => _OpenInwardListPageState();
}

class _OpenInwardListPageState extends State<OpenInwardListPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: Screens.padingHeight(context) * 0.9,
      width: Screens.width(context) * 0.5,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Pending Inwards',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        context.read<StockInwrdController>().init();
                      });
                    },
                    icon: const Icon(Icons.refresh))
              ],
            ),
            context.watch<StockInwrdController>().stockInward2.isNotEmpty
                ? SizedBox(
                    height: Screens.padingHeight(context) * 0.9,
                    child: ListView.builder(
                        itemCount: context
                            .watch<StockInwrdController>()
                            .stockInward2
                            .length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: Screens.padingHeight(context) * 0.01,
                                    left: Screens.width(context) * 0.01,
                                    right: Screens.width(context) * 0.01,
                                    bottom:
                                        Screens.padingHeight(context) * 0.01),
                                decoration:
                                    BoxDecoration(color: Colors.grey[300]),
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
                                            "Inventory Transfer From ${context.watch<StockInwrdController>().stockInward2[index].reqtoWhs}",
                                            style: theme.textTheme.bodyLarge),
                                        Text(
                                            "Doc Num  ${context.watch<StockInwrdController>().stockInward2[index].documentno}",
                                            style: theme.textTheme.bodyLarge),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "# ${context.watch<StockInwrdController>().config.alignDate(context.watch<StockInwrdController>().stockInward2[index].reqtransdate.toString())}",
                                            style: theme.textTheme.bodyLarge),
                                        Text(
                                            '${context.watch<StockInwrdController>().stockInward2[index].branch}',
                                            style: theme.textTheme.bodyLarge)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                : context.watch<StockInwrdController>().stockInward.isEmpty &&
                        context.watch<StockInwrdController>().loadingscrn ==
                            false &&
                        context
                            .watch<StockInwrdController>()
                            .savedraftBill
                            .isEmpty
                    ? Container(
                        height: Screens.padingHeight(context) * 0.9,
                        child: Center(
                          child: Text(
                            "No data found",
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      )
                    : context.watch<StockInwrdController>().loadingscrn ==
                                true &&
                            context
                                .watch<StockInwrdController>()
                                .stockInward
                                .isEmpty
                        ? Container(
                            height: Screens.padingHeight(context) * 0.9,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : context
                                .watch<StockInwrdController>()
                                .stockInward
                                .isNotEmpty
                            ? SizedBox(
                                height: Screens.padingHeight(context) * 0.9,
                                child: ListView.builder(
                                    itemCount: context
                                        .watch<StockInwrdController>()
                                        .stockInward
                                        .length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                          onTap: () async {
                                            context
                                                .read<StockInwrdController>()
                                                .passdata = [];
                                            context
                                                    .read<StockInwrdController>()
                                                    .sapStockReqdocnum =
                                                context
                                                    .read<
                                                        StockInwrdController>()
                                                    .stockInward[index]
                                                    .documentno
                                                    .toString();
                                            context
                                                    .read<StockInwrdController>()
                                                    .sapStockReqdocentry =
                                                context
                                                    .read<
                                                        StockInwrdController>()
                                                    .stockInward[index]
                                                    .docentry
                                                    .toString();
                                            await context
                                                .read<StockInwrdController>()
                                                .callInwardLineApi(
                                                    context
                                                        .read<
                                                            StockInwrdController>()
                                                        .stockInward[index]
                                                        .docentry
                                                        .toString(),
                                                    context
                                                        .read<
                                                            StockInwrdController>()
                                                        .stockInward[index]
                                                        .cardCode
                                                        .toString());
                                            log('context.read<StockInwrdController>().passdata!.length::${context.read<StockInwrdController>().passdata!.length}');

                                            await context
                                                .read<StockInwrdController>()
                                                .passData(
                                                    theme, context, index);
                                            await context
                                                .read<StockInwrdController>()
                                                .selecetAllItems(
                                                    context, theme);
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: context.watch<StockInwrdController>().selectIndex ==
                                                              index
                                                          ? Colors.green
                                                          : Colors.white)),
                                              padding: EdgeInsets.only(
                                                  top: Screens.padingHeight(context) *
                                                      0.01,
                                                  left: Screens.padingHeight(context) *
                                                      0.01,
                                                  right:
                                                      Screens.padingHeight(context) *
                                                          0.01,
                                                  bottom:
                                                      Screens.padingHeight(context) *
                                                          0.01),
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
                                                            "Inventory Transfer From ${context.watch<StockInwrdController>().stockInward[index].reqfromWhs}",
                                                            style: theme
                                                                .textTheme
                                                                .bodyLarge),
                                                        Text(
                                                            "OutWard  Num: ${context.watch<StockInwrdController>().stockInward[index].documentno}",
                                                            style: theme
                                                                .textTheme
                                                                .bodyLarge),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            "# ${context.watch<StockInwrdController>().config.alignDate(context.watch<StockInwrdController>().stockInward[index].reqtransdate.toString())}",
                                                            style: theme
                                                                .textTheme
                                                                .bodyLarge),
                                                        Text(
                                                            'Req Num: ${context.watch<StockInwrdController>().stockInward[index].reqdocumentno ?? ''}',
                                                            style: theme
                                                                .textTheme
                                                                .bodyLarge)
                                                      ],
                                                    )
                                                  ])));
                                    }),
                              )
                            : Container()
          ],
        ),
      ),
    );
  }
}
