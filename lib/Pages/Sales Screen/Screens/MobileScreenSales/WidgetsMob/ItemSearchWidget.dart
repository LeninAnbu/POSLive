import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:posproject/Controller/SalesInvoice/SalesInvoiceController.dart';
import '../../../../../Constant/Screen.dart';

class ItemSearchWidget extends StatelessWidget {
  const ItemSearchWidget({
    super.key,
    required this.theme,
    required this.prdCD,
  });

  final ThemeData theme;
  final PosController prdCD;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Screens.width(context),
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
      ),
      child: Column(
        children: [
          Container(
              alignment: Alignment.center,
              width: Screens.width(context),
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 240, 235, 235)),
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey.withOpacity(0.01),
              ),
              child: TextFormField(
                autofocus: true,
                style: theme.textTheme.bodyMedium,
                cursorColor: Colors.grey,
                onChanged: (v) {},
                controller: prdCD.mycontroller[99],
                focusNode: prdCD.focusnode[0],
                onEditingComplete: () {
                  prdCD.checkBatchAvail(
                      prdCD.mycontroller[99].text
                          .toString()
                          .trim()
                          .toUpperCase(),
                      context,
                      theme);
                },
                decoration: InputDecoration(
                  filled: false,
                  hintText: 'Inventories',
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    onPressed: () async {
                      log("object");
                      prdCD.source1 = await prdCD.getPathOFDB();
                      prdCD.copyTo = await prdCD.getDirectory();
                    },
                    color: theme.primaryColor,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                ),
              )),
          ListView.builder(
              itemCount: prdCD.getScanneditemData.length,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Card(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                        padding: EdgeInsets.only(
                          top: Screens.padingHeight(context) * 0.01,
                          left: Screens.width(context) * 0.01,
                          right: Screens.width(context) * 0.03,
                          bottom: Screens.padingHeight(context) * 0.02,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: Screens.width(context) * 0.4,
                                      alignment: Alignment.centerLeft,
                                      child: TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "${prdCD.getScanneditemData[index].itemName}",
                                            maxLines: 2,
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          ))),
                                ],
                              ),
                              Container(
                                  width: Screens.width(context) * 0.11,
                                  height: Screens.padingHeight(context) * 0.05,
                                  alignment: Alignment.center,
                                  child: TextFormField(
                                    autofocus: true,
                                    style: theme.textTheme.bodyMedium,
                                    onChanged: (v) {},
                                    cursorColor: Colors.grey,
                                    textDirection: TextDirection.rtl,
                                    keyboardType: TextInputType.number,
                                    onEditingComplete: () {
                                      prdCD.itemIncrement11(
                                          index, context, theme);
                                    },
                                    controller: prdCD.qtymycontroller[index],
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 5,
                                      ),
                                    ),
                                  )),
                              Container(
                                  width: Screens.width(context) * 0.11,
                                  height: Screens.padingHeight(context) * 0.05,
                                  alignment: Alignment.center,
                                  child: TextFormField(
                                    autofocus: true,
                                    style: theme.textTheme.bodyMedium,
                                    onChanged: (v) {},
                                    cursorColor: Colors.grey,
                                    textDirection: TextDirection.rtl,
                                    keyboardType: TextInputType.number,
                                    onEditingComplete: () {
                                      prdCD.calCulateDocVal(context, theme);
                                    },
                                    controller: prdCD.mycontroller[index],
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 5,
                                      ),
                                    ),
                                  )),
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    horizontal: Screens.width(context) * 0.005),
                                child: Text(
                                    prdCD.config.splitValues(
                                        ' ${prdCD.getScanneditemData[index].taxvalue!.toStringAsFixed(2)}'),
                                    style: theme.textTheme.bodyMedium
                                        ?.copyWith(color: Colors.black)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Screens.padingHeight(context) * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "${prdCD.getScanneditemData[index].serialBatch}",
                                          textAlign: TextAlign.start,
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(),
                                        )),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "  |  ",
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "${prdCD.getScanneditemData[index].itemCode}",
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: Screens.width(context) * 0.28,
                                alignment: Alignment.centerRight,
                                child: Text(
                                  prdCD.config.splitValues(
                                      "${prdCD.getScanneditemData[index].sellPrice}"),
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.black),
                                ),
                              ),
                            ],
                          )
                        ])),
                  ),
                );
              })
        ],
      ),
    );
  }

  Widget checkItemcode(BuildContext context, ThemeData theme) {
    final theme = Theme.of(context);
    return SizedBox(
      height: Screens.padingHeight(context) * 0.5,
      width: Screens.width(context) * 0.45, // Change as per your requirement
      child: ListView.builder(
          itemCount: prdCD.itemcodelistitem.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  prdCD.clickItemcode(
                      prdCD.itemcodelistitem[index], context, theme, index);
                  Navigator.pop(context);
                },
                title: Row(
                  children: [
                    Text(
                      prdCD.itemcodelistitem[index].itemCode.toString(),
                    ),
                    Text(
                      " - ${prdCD.itemcodelistitem[index].itemName}",
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
