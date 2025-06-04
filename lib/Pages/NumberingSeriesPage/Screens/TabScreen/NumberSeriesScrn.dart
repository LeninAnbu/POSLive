import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../Controller/NumberingSeriesCtrl/NumberingSeriesCtrler.dart';

class NumberingSeriesPage extends StatefulWidget {
  NumberingSeriesPage(
      {super.key,
      required this.theme,
      required this.searchHeight,
      required this.searchWidth});

  final ThemeData theme;

  double searchHeight;
  double searchWidth;
  @override
  State<NumberingSeriesPage> createState() => _NumberingSeriesPageState();
}

class _NumberingSeriesPageState extends State<NumberingSeriesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: widget.searchHeight,
      child: Column(
        children: [
          Container(
            color: widget.theme.primaryColor,
            padding: EdgeInsets.only(
                top: widget.searchHeight * 0.01,
                bottom: widget.searchHeight * 0.01,
                right: widget.searchWidth * 0.02,
                left: widget.searchWidth * 0.02),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: widget.searchWidth * 0.35,
                  child: Text(
                    'Doc Id',
                    style: widget.theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: widget.searchWidth * 0.15,
                  alignment: Alignment.center,
                  child: Text(
                    'First No',
                    style: widget.theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: widget.searchWidth * 0.2,
                  alignment: Alignment.center,
                  child: Text(
                    'Next No',
                    style: widget.theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: widget.searchWidth * 0.25,
                  alignment: Alignment.center,
                  child: Text(
                    'last No',
                    style: widget.theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: widget.searchWidth * 0.65,
                  alignment: Alignment.center,
                  child: Text(
                    'Prefix',
                    style: widget.theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: widget.searchWidth * 0.3,
                  alignment: Alignment.center,
                  child: Text(
                    'Terminal',
                    style: widget.theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: widget.searchWidth * 0.3,
                  alignment: Alignment.center,
                  child: Text(
                    'Warehouse',
                    style: widget.theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: widget.searchWidth * 0.33,
                  alignment: Alignment.center,
                  child: Text(
                    'From Date',
                    style: widget.theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: widget.searchWidth * 0.33,
                  alignment: Alignment.centerRight,
                  child: Text(
                    'To Date',
                    style: widget.theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: widget.searchHeight * 0.945,
            color: Colors.grey[100],
            width: widget.searchWidth * 4,
            child: ListView.builder(
                itemCount:
                    context.watch<NumberSeriesCtrl>().numberSerisList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      padding: EdgeInsets.only(
                          top: widget.searchHeight * 0.02,
                          bottom: widget.searchHeight * 0.01,
                          right: widget.searchWidth * 0.02,
                          left: widget.searchWidth * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: widget.searchWidth * 0.35,
                            child: Text(context
                                .watch<NumberSeriesCtrl>()
                                .numberSerisList[index]
                                .docName
                                .toString()),
                          ),
                          Container(
                              width: widget.searchWidth * 0.15,
                              height: widget.searchHeight * 0.05,
                              alignment: Alignment.center,
                              child: TextFormField(
                                style: const TextStyle(fontSize: 15),
                                textAlign: TextAlign.end,
                                controller: context
                                    .read<NumberSeriesCtrl>()
                                    .frstnocontroller[index],
                                onTap: () {
                                  context
                                          .read<NumberSeriesCtrl>()
                                          .frstnocontroller[index]
                                          .text =
                                      context
                                          .read<NumberSeriesCtrl>()
                                          .frstnocontroller[index]
                                          .text;

                                  context
                                      .read<NumberSeriesCtrl>()
                                      .frstnocontroller[index]
                                      .selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset: context
                                        .read<NumberSeriesCtrl>()
                                        .frstnocontroller[index]
                                        .text
                                        .length,
                                  );
                                },
                                onEditingComplete: () {
                                  setState(() {
                                    context
                                        .read<NumberSeriesCtrl>()
                                        .updateFirstnoTable(index);
                                  });
                                  context
                                      .read<NumberSeriesCtrl>()
                                      .disableKeyBoard(context);
                                },
                                decoration: InputDecoration(
                                  filled: false,
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 10,
                                  ),
                                ),
                              )),
                          Container(
                              width: widget.searchWidth * 0.18,
                              height: widget.searchHeight * 0.05,
                              alignment: Alignment.centerRight,
                              child: TextFormField(
                                style: const TextStyle(fontSize: 15),
                                textAlign: TextAlign.end,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                controller: context
                                    .read<NumberSeriesCtrl>()
                                    .nxtnocontroller[index],
                                onTap: () {
                                  context
                                          .read<NumberSeriesCtrl>()
                                          .nxtnocontroller[index]
                                          .text =
                                      context
                                          .read<NumberSeriesCtrl>()
                                          .nxtnocontroller[index]
                                          .text;

                                  context
                                      .read<NumberSeriesCtrl>()
                                      .nxtnocontroller[index]
                                      .selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset: context
                                        .read<NumberSeriesCtrl>()
                                        .nxtnocontroller[index]
                                        .text
                                        .length,
                                  );
                                },
                                onEditingComplete: () {
                                  setState(() {
                                    context
                                        .read<NumberSeriesCtrl>()
                                        .updateNxtnoTable(index);
                                  });
                                  context
                                      .read<NumberSeriesCtrl>()
                                      .disableKeyBoard(context);
                                },
                                decoration: InputDecoration(
                                  filled: false,
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 10,
                                  ),
                                ),
                              )),
                          Container(
                              width: widget.searchWidth * 0.25,
                              alignment: Alignment.centerRight,
                              height: widget.searchHeight * 0.05,
                              child: TextFormField(
                                style: const TextStyle(fontSize: 15),
                                textAlign: TextAlign.end,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                controller: context
                                    .read<NumberSeriesCtrl>()
                                    .lstnocontroller[index],
                                onTap: () {
                                  context
                                          .read<NumberSeriesCtrl>()
                                          .lstnocontroller[index]
                                          .text =
                                      context
                                          .read<NumberSeriesCtrl>()
                                          .lstnocontroller[index]
                                          .text;

                                  context
                                      .read<NumberSeriesCtrl>()
                                      .lstnocontroller[index]
                                      .selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset: context
                                        .read<NumberSeriesCtrl>()
                                        .lstnocontroller[index]
                                        .text
                                        .length,
                                  );
                                },
                                onEditingComplete: () {
                                  setState(() {
                                    context
                                        .read<NumberSeriesCtrl>()
                                        .updateLastnoTable(index);
                                  });
                                  context
                                      .read<NumberSeriesCtrl>()
                                      .disableKeyBoard(context);
                                },
                                decoration: InputDecoration(
                                  filled: false,
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 10,
                                  ),
                                ),
                              )),
                          Container(
                              width: widget.searchWidth * 0.65,
                              alignment: Alignment.centerRight,
                              height: widget.searchHeight * 0.05,
                              child: TextFormField(
                                style: const TextStyle(fontSize: 15),
                                textAlign: TextAlign.end,
                                controller: context
                                    .read<NumberSeriesCtrl>()
                                    .prfixcontroller[index],
                                onTap: () {},
                                onEditingComplete: () {
                                  setState(() {
                                    context
                                        .read<NumberSeriesCtrl>()
                                        .updatePrfixnoTable(index);
                                  });
                                  context
                                      .read<NumberSeriesCtrl>()
                                      .disableKeyBoard(context);
                                },
                                decoration: InputDecoration(
                                  filled: false,
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 10,
                                  ),
                                ),
                              )),
                          Container(
                            width: widget.searchWidth * 0.3,
                            alignment: Alignment.center,
                            height: widget.searchHeight * 0.05,
                            child: Text(
                              context
                                  .watch<NumberSeriesCtrl>()
                                  .numberSerisList[index]
                                  .terminal
                                  .toString(),
                              style: widget.theme.textTheme.bodyMedium
                                  ?.copyWith(fontSize: 15),
                            ),
                          ),
                          Container(
                            width: widget.searchWidth * 0.3,
                            alignment: Alignment.center,
                            height: widget.searchHeight * 0.05,
                            child: Text(
                              context
                                  .watch<NumberSeriesCtrl>()
                                  .numberSerisList[index]
                                  .wareHouse
                                  .toString(),
                              style: widget.theme.textTheme.bodyMedium
                                  ?.copyWith(fontSize: 15),
                            ),
                          ),
                          Container(
                              width: widget.searchWidth * 0.33,
                              alignment: Alignment.center,
                              height: widget.searchHeight * 0.05,
                              child: TextFormField(
                                style: const TextStyle(fontSize: 15),
                                textAlign: TextAlign.end,
                                controller: context
                                    .read<NumberSeriesCtrl>()
                                    .frmdatecontroller[index],
                                onTap: () {
                                  context
                                          .read<NumberSeriesCtrl>()
                                          .frmdatecontroller[index]
                                          .text =
                                      context
                                          .read<NumberSeriesCtrl>()
                                          .frmdatecontroller[index]
                                          .text;

                                  context
                                      .read<NumberSeriesCtrl>()
                                      .frmdatecontroller[index]
                                      .selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset: context
                                        .read<NumberSeriesCtrl>()
                                        .frmdatecontroller[index]
                                        .text
                                        .length,
                                  );
                                },
                                onEditingComplete: () {
                                  setState(() {
                                    context
                                        .read<NumberSeriesCtrl>()
                                        .updateFrmDateTable(index);
                                  });
                                  context
                                      .read<NumberSeriesCtrl>()
                                      .disableKeyBoard(context);
                                },
                                decoration: InputDecoration(
                                  filled: false,
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 10,
                                  ),
                                ),
                              )),
                          Container(
                              width: widget.searchWidth * 0.33,
                              alignment: Alignment.centerRight,
                              height: widget.searchHeight * 0.05,
                              child: TextFormField(
                                style: const TextStyle(fontSize: 15),
                                textAlign: TextAlign.end,
                                controller: context
                                    .read<NumberSeriesCtrl>()
                                    .todatecontroller[index],
                                onTap: () {
                                  context
                                          .read<NumberSeriesCtrl>()
                                          .todatecontroller[index]
                                          .text =
                                      context
                                          .read<NumberSeriesCtrl>()
                                          .todatecontroller[index]
                                          .text;

                                  context
                                      .read<NumberSeriesCtrl>()
                                      .todatecontroller[index]
                                      .selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset: context
                                        .read<NumberSeriesCtrl>()
                                        .todatecontroller[index]
                                        .text
                                        .length,
                                  );
                                },
                                onEditingComplete: () {
                                  setState(() {
                                    context
                                        .read<NumberSeriesCtrl>()
                                        .updatetoDateTable(index);
                                  });
                                  context
                                      .read<NumberSeriesCtrl>()
                                      .disableKeyBoard(context);
                                },
                                decoration: InputDecoration(
                                  filled: false,
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 10,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
