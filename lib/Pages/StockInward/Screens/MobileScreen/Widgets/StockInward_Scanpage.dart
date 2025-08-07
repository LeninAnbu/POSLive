import 'package:flutter/material.dart';
import '../../../../../Constant/Screen.dart';

import '../../../../../Controller/StockInwardController/StockInwardContler.dart';
import '../../../../../Models/DataModel/StockInwardModel/StockInwardListModel.dart';

class MyWidget extends StatefulWidget {
  MyWidget(
      {super.key,
      required this.stInCon,
      required this.datalist,
      required this.ind,
      required this.index});
  StockInwrdController stInCon;
  StockInwardDetails? datalist;
  int? ind;
  int? index;
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double StOut_Height = Screens.bodyheight(context) * 0.5;
    double StOut_Width = Screens.width(context);

    return Container(
      padding: EdgeInsets.only(
          top: StOut_Height * 0.01,
          left: StOut_Height * 0.01,
          right: StOut_Height * 0.01,
          bottom: StOut_Height * 0.008),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(), // new
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: StOut_Width,
              padding: EdgeInsets.all(
                StOut_Height * 0.01,
              ),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: StOut_Height * 0.6,
                    child: Text("Itemcode\n${widget.datalist!.itemcode}"),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text("SerialBatch\n${widget.datalist!.serialBatch}"),
                  )
                ],
              ),
            ),
            SizedBox(
              height: StOut_Height * 0.015,
            ),
            Container(
                height: StOut_Height * 1.58,
                width: StOut_Width * 1.1,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: StOut_Height * 0.015,
                    ),
                    Container(
                      width: StOut_Width * 0.95,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 190, 183, 183)),
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        controller: widget.stInCon.stInController[0],
                        cursorColor: Colors.grey,
                        onChanged: (v) {
                          if (v.isNotEmpty) {
                            setState(() {
                              widget.stInCon.msg = "";
                            });
                          }
                        },
                        onEditingComplete: () {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          hintText: 'Scan here..',
                          hintStyle: theme.textTheme.bodySmall
                              ?.copyWith(color: Colors.grey),
                          filled: false,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "${widget.stInCon.msg}",
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(height: StOut_Height * 0.001),
                    widget.datalist!.serialbatchList == null
                        ? const Center(
                            child: Text("Scan Item.."),
                          )
                        : widget.stInCon.onScanDisable == true
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(), // new

                                itemCount:
                                    widget.datalist!.serialbatchList!.length,
                                itemBuilder: (context, i) {
                                  return Padding(
                                      padding:
                                          EdgeInsets.all(StOut_Height * 0.005),
                                      child: Container(
                                        width: StOut_Height * 0.95,
                                        padding: EdgeInsets.all(
                                            Screens.bodyheight(context) *
                                                0.008),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 3,
                                                blurRadius: 7,
                                                offset: const Offset(0, 3),
                                              ),
                                            ]),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: Screens.width(
                                                              context) *
                                                          0.45,
                                                      child: Text(
                                                        widget
                                                            .datalist!
                                                            .serialbatchList![i]
                                                            .itemcode!,
                                                        style: theme.textTheme
                                                            .bodyMedium,
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      width: Screens.width(
                                                              context) *
                                                          0.4,
                                                      child: Text(
                                                        widget
                                                            .datalist!
                                                            .serialbatchList![i]
                                                            .serialbatch!,
                                                        style: theme.textTheme
                                                            .bodyMedium,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      width: Screens.width(
                                                              context) *
                                                          0.4,
                                                      child: Text(
                                                        "Scaned Qty: ${widget.datalist!.serialbatchList![i].qty}",
                                                        style: theme.textTheme
                                                            .bodyMedium,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ));
                                }),
                  ],
                )),
            SizedBox(
              height: StOut_Height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.all(StOut_Height * 0.006),
              child: Container(
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
                width: Screens.width(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: Screens.width(context) * 0.95,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Save and Back",
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
