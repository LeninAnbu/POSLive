import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Controller/SalesReturnController/SalesReturnController.dart';

class SRItemWid extends StatelessWidget {
  const SRItemWid({
    super.key,
    required this.salesReturnController,
    required this.theme,
  });

  final SalesReturnController salesReturnController;
  final ThemeData theme;

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
      padding:
          EdgeInsets.symmetric(vertical: Screens.padingHeight(context) * 0.01),
      child: Column(
        children: [
          salesReturnController.getScanneditemData.isEmpty
              ? Container()
              : ListView.builder(
                  itemCount: salesReturnController.getScanneditemData.length,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                            padding: EdgeInsets.only(
                              top: Screens.bodyheight(context) * 0.01,
                              left: Screens.width(context) * 0.01,
                              right: Screens.width(context) * 0.01,
                              bottom: Screens.bodyheight(context) * 0.01,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200],
                            ),
                            child: Column(children: [
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
                                            "${salesReturnController.getScanneditemData[index].itemName}",
                                            maxLines: 2,
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          ))),
                                  SizedBox(
                                    width: Screens.width(context) * 0.46,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            width:
                                                Screens.width(context) * 0.11,
                                            height:
                                                Screens.padingHeight(context) *
                                                    0.05,
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              autofocus: true,
                                              style: theme.textTheme.bodyMedium,
                                              onChanged: (v) {},
                                              cursorColor: Colors.grey,
                                              textDirection: TextDirection.rtl,
                                              keyboardType:
                                                  TextInputType.number,
                                              onEditingComplete: () {
                                                salesReturnController
                                                    .itemIncrement11(
                                                        index, context, theme);
                                              },
                                              controller: salesReturnController
                                                  .qtymycontroller[index],
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
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
                                            width:
                                                Screens.width(context) * 0.12,
                                            alignment: Alignment.center,
                                            child: Text(
                                              "${salesReturnController.getScanneditemData[index].discountper}",
                                              textAlign: TextAlign.start,
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(),
                                            )),
                                        Container(
                                            width: Screens.width(context) * 0.2,
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              salesReturnController.config
                                                  .splitValues(
                                                      salesReturnController
                                                          .getScanneditemData[
                                                              index]
                                                          .taxvalue!
                                                          .toStringAsFixed(2)),
                                              textAlign: TextAlign.start,
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Screens.padingHeight(context) * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Container(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${salesReturnController.getScanneditemData[index].serialBatch}",
                                              textAlign: TextAlign.start,
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(),
                                            )),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          width: Screens.width(context) * 0.3,
                                          child: Text(
                                            "  |  ${salesReturnController.getScanneditemData[index].itemCode}",
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
                                      salesReturnController.config.splitValues(
                                          "${salesReturnController.getScanneditemData[index].sellPrice}"),
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
}
