import 'package:flutter/material.dart';
import '../../../../../Constant/Screen.dart';
import '../../../../../Controller/StockOutwardController/StockOutwardController.dart';
import '../../../../../Models/DataModel/StockOutwardModel/StockOutwardListModel.dart';

class MyWidget extends StatefulWidget {
  MyWidget(
      {super.key,
      required this.stInCon,
      required this.datalist,
      required this.ind,
      required this.index});
  StockOutwardController stInCon;
  StockOutwardDetails? datalist;
  int? ind;
  int? index;
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double stoutHeight = Screens.bodyheight(context) * 0.5;
    double stoutWidth = Screens.width(context);

    return Container(
      padding: EdgeInsets.only(
          top: stoutHeight * 0.01,
          left: stoutHeight * 0.01,
          right: stoutHeight * 0.01,
          bottom: stoutHeight * 0.008),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(), // new
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: stoutWidth,
              padding: EdgeInsets.all(
                stoutHeight * 0.01,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: stoutHeight * 0.6,
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
              height: stoutHeight * 0.015,
            ),
            Container(
                height: stoutHeight * 1.58,
                width: stoutWidth * 1.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: stoutHeight * 0.015,
                    ),
                    Container(
                      width: stoutWidth * 0.95,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 190, 183, 183)),
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        controller: widget.stInCon.StOutController[0],
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
                    SizedBox(height: stoutHeight * 0.001),
                    widget.datalist!.serialbatchList == null
                        ? Center(
                            child: Text("Scan Item.."),
                          )
                        : widget.stInCon.OnScanDisable == true
                            ? Center(
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
                                          EdgeInsets.all(stoutHeight * 0.005),
                                      child: Container(
                                        width: stoutHeight * 0.95,
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
                                                offset: Offset(0,
                                                    3), // changes position of shadow
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
                                                    Container(
                                                        alignment: Alignment
                                                            .center,
                                                        width: Screens.width(
                                                                context) *
                                                            0.15,
                                                        height:
                                                            Screens.bodyheight(
                                                                    context) *
                                                                0.035,
                                                        decoration:
                                                            BoxDecoration(
                                                                color:
                                                                    Colors.blue,
                                                                shape: BoxShape
                                                                    .circle),
                                                        child: IconButton(
                                                            color: Colors.white,
                                                            padding:
                                                                EdgeInsets.zero,
                                                            iconSize: 12,
                                                            onPressed: () {
                                                              widget.stInCon
                                                                  .scanqtyRemove(
                                                                      widget
                                                                          .index!,
                                                                      widget
                                                                          .ind!,
                                                                      i);
                                                            },
                                                            icon: Icon(
                                                                Icons.remove))),
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
              height: stoutHeight * 0.02,
            ),
            Padding(
              padding: EdgeInsets.all(stoutHeight * 0.006),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
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
