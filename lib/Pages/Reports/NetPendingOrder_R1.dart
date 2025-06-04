import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../Constant/Configuration.dart';
import '../../../../Constant/Screen.dart';
import '../../Models/NewReportsModel/NetpendingModel.dart';
import '../../Service/NewReportsApi/NetPendingOrderApi.dart';
import '../../../../Widgets/Drawer.dart';
import 'package:intl/intl.dart';

class NetPendingOrder extends StatefulWidget {
  NetPendingOrder({super.key});

  @override
  State<NetPendingOrder> createState() => _NetPendingOrderState();
}

class _NetPendingOrderState extends State<NetPendingOrder> {
  @override
  void initState() {
    super.initState();
    setState(() {
      tablerColumn = [];
      loadingscrn = false;
      fromDate = '';
      toDate = '';
      branch = '';
    });
  }

  List<NetPendingOrderModelData> tablerColumn = [];
  bool loadingscrn = false;
  String fromDate = '';
  String toDate = '';
  String branch = '';

  List<TextEditingController> mycontroller =
      List.generate(150, (i) => TextEditingController());
  List<GlobalKey<FormState>> formkey =
      List.generate(100, (i) => GlobalKey<FormState>());
  getDate2(BuildContext context, datetype) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (datetype == "From") {
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate!);
      mycontroller[0].text = datetype!;

      fromDate = config.alignDate2(datetype);
    } else if (datetype == "To") {
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate!);
      mycontroller[1].text = datetype!;
      toDate = config.alignDate2(datetype);
    } else {}
  }

  callTestApi() async {
    loadingscrn = true;
    tablerColumn = [];
    await NetpendingorderApi.getGlobalData(
      fromDate,
      toDate,
    ).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        setState(() {
          tablerColumn = value.openOutwardData!;
        });
        loadingscrn = false;

        log('openOutwardDataopenOutwardData::${tablerColumn.length}');
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        loadingscrn = false;
      }
    });
  }

  Configure config = Configure();
  List<DataColumn> _generateColumns(List<NetPendingOrderModelData> valuesx) {
    List<DataColumn> columns = [];
    var data = valuesx.map((e) => e.toMap()).toList();
    log('yyyyyyyyyyyyyyyykey::${data.first.keys.length}');

    data.first.keys.forEach((key) {
      columns.add(DataColumn(
        label: Container(
            alignment: Alignment.center,
            child: Text(
              key,
              textAlign: TextAlign.center,
            )),
      ));
    });

    return columns;
  }

  List<DataRow> _generateRows(List<NetPendingOrderModelData> data) {
    List<DataRow> rows = [];

    data.forEach((item) {
      List<DataCell> cells = [];
      cells.add(DataCell(Text(item.slpName.toString())));
      cells.add(DataCell(Container(
          alignment: Alignment.center,
          child: Text(item.salesOrderNo.toString()))));
      cells.add(DataCell(Container(
          alignment: Alignment.center,
          child: Text(item.salesOrderDate.toString()))));

      cells.add(DataCell(Container(
          alignment: Alignment.center,
          child: Text(item.soElapsedDays.toString()))));
      cells.add(DataCell(Container(child: Text(item.notes.toString()))));
      cells.add(DataCell(Container(
          alignment: Alignment.centerRight,
          child: Text(item.cardName.toString().replaceAll('.0', '')))));
      cells.add(DataCell(Container(
          alignment: Alignment.centerRight,
          child: Text(item.itemCode.toString()))));
      cells.add(DataCell(Container(
          alignment: Alignment.center,
          child: Text(item.description.toString()))));
      cells.add(DataCell(Container(
          alignment: Alignment.centerRight,
          child: Text(item.subGroup.toString()))));

      cells.add(DataCell(Container(
          alignment: Alignment.centerRight,
          child: Text(item.salesOrderQty.toString()))));
      cells.add(DataCell(Container(
          alignment: Alignment.centerRight,
          child: Text(item.deliveredQty.toString()))));
      cells.add(DataCell(Container(
          alignment: Alignment.centerRight,
          child: Text(item.balanceQty.toString()))));
      cells.add(DataCell(Container(
          alignment: Alignment.centerRight,
          child: Text(item.onHand.toString()))));
      cells.add(DataCell(Container(
          alignment: Alignment.center, child: Text(item.volume.toString()))));
      cells.add(DataCell(Container(
          alignment: Alignment.centerRight,
          child: Text(item.sellingPrice.toString()))));
      cells.add(DataCell(Container(
          alignment: Alignment.centerRight,
          child: Text(item.openAmount.toString()))));
      cells.add(DataCell(Container(
          alignment: Alignment.centerRight,
          child: Text(item.discountAmount.toString()))));
      cells.add(DataCell(Container(
          alignment: Alignment.centerRight,
          child: Text(item.afterDiscPercent.toString()))));
      cells.add(DataCell(Container(
          alignment: Alignment.centerRight,
          child: Text(item.taxAmount.toString()))));
      cells.add(DataCell(Text(item.netAmount.toString())));
      rows.add(DataRow(cells: cells));
    });
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      drawer: naviDrawer(),
      appBar: AppBar(
        elevation: 0,
        title: Text('NetPendingOrder_R1'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(
                  top: Screens.padingHeight(context) * 0.02,
                  bottom: Screens.padingHeight(context) * 0.02,
                ),
                alignment: Alignment.center,
                height: Screens.padingHeight(context) * 0.1,
                width: Screens.width(context) * 0.55,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Form(
                      key: formkey[0],
                      child: Row(children: [
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.08,
                              height: Screens.padingHeight(context) * 0.07,
                              child: const Text("From Date"),
                            ),
                            Container(
                              height: Screens.padingHeight(context) * 0.3,
                              width: Screens.width(context) * 0.13,
                              decoration: const BoxDecoration(),
                              child: TextFormField(
                                controller: mycontroller[0],
                                readOnly: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Required";
                                  }
                                  null;
                                  return null;
                                },
                                onTap: () {
                                  getDate2(context, 'From');
                                },
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 5.0),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    hintText: "",
                                    hintStyle: theme.textTheme.bodyLarge!
                                        .copyWith(color: Colors.black),
                                    suffixIcon:
                                        const Icon(Icons.calendar_today)),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.08,
                              height: Screens.padingHeight(context) * 0.07,
                              child: const Text("To Date"),
                            ),
                            Container(
                              height: Screens.padingHeight(context) * 0.3,
                              width: Screens.width(context) * 0.13,
                              decoration: const BoxDecoration(),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Required";
                                  }
                                  null;
                                  return null;
                                },
                                readOnly: true,
                                controller: mycontroller[1],
                                onTap: () {
                                  getDate2(context, 'To');
                                },
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 5.0),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    hintText: "",
                                    hintStyle: theme.textTheme.bodyLarge!
                                        .copyWith(color: Colors.black),
                                    suffixIcon:
                                        const Icon(Icons.calendar_today)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.03,
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (formkey[0].currentState!.validate()) {
                                  callTestApi();
                                }
                              });
                            },
                            child: Container(
                              height: Screens.padingHeight(context) * 0.065,
                              width: Screens.width(context) * 0.075,
                              decoration: BoxDecoration(
                                  color: theme.primaryColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ],
                )),
            Container(
              padding: EdgeInsets.all(5),
              width: Screens.width(context) * 1.1,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(Screens.bodyheight(context) * 0.01),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[400]!,
                        spreadRadius: 1.0,
                        offset: const Offset(2, 0))
                  ]),
              child: tablerColumn.isEmpty && loadingscrn == true
                  ? Container(
                      height: Screens.padingHeight(context),
                      child: Center(
                          child: CircularProgressIndicator(
                        color: theme.primaryColor,
                      )),
                    )
                  : tablerColumn.isEmpty && loadingscrn == false
                      ? Container()
                      : SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DataTable(
                                headingRowHeight:
                                    Screens.padingHeight(context) * 0.05,
                                dataRowHeight:
                                    Screens.padingHeight(context) * 0.045,
                                columnSpacing: 8.0,
                                border: TableBorder.symmetric(
                                    inside: BorderSide(
                                        color: theme.primaryColor
                                            .withOpacity(0.1))),
                                columns: _generateColumns(tablerColumn),
                                rows: _generateRows(tablerColumn),
                                headingTextStyle: theme.textTheme.bodyMedium!
                                    .copyWith(
                                        color: theme.primaryColor,
                                        fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
            ),
          ],
        ),
      ),
    );
  }
}
