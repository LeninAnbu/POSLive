import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/main.dart';
import 'package:provider/provider.dart';
import '../../../Controller/PendingOrderController/PendingOrderController.dart';

class PendingorderTab extends StatefulWidget {
  PendingorderTab({
    super.key,
    required this.theme,
    required this.btnWidth,
    required this.btnheight,
    // required this.posController
  });

  final ThemeData theme;
  double btnheight;
  double btnWidth;

  @override
  State<PendingorderTab> createState() => _PendingorderTabState();
}

class _PendingorderTabState extends State<PendingorderTab> {
  // final PendingOrderController posController;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding:
              EdgeInsets.only(bottom: Screens.padingHeight(context) * 0.03),
          child: Column(
            children: [
              SizedBox(
                height: widget.btnheight * 0.015,
              ),
              SizedBox(
                width: widget.btnWidth * 1.15,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Form(
                          key:
                              context.read<PendingOrderController>().formkey[0],
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    // color: Colors.blue,
                                    width: widget.btnWidth * 0.2,
                                    child: const Text("From Date"),
                                  ),
                                  Container(
                                    width: widget.btnWidth * 0.25,
                                    decoration: const BoxDecoration(),
                                    child: TextFormField(
                                      controller: context
                                          .read<PendingOrderController>()
                                          .searchcontroller[2],
                                      readOnly: true,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Required";
                                        }
                                        null;
                                        return null;
                                      },
                                      onTap: () {
                                        setState(() {
                                          context
                                              .read<PendingOrderController>()
                                              .getDate2(
                                                context,
                                                'From',
                                              );
                                        });
                                      },
                                      decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 5.0,
                                                  horizontal: 5.0),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          hintText: "",
                                          hintStyle: widget
                                              .theme.textTheme.bodyLarge!
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
                                    width: widget.btnWidth * 0.18,
                                    child: const Text("To Date"),
                                  ),
                                  Container(
                                    width: widget.btnWidth * 0.25,
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
                                      controller: context
                                          .read<PendingOrderController>()
                                          .searchcontroller[3],
                                      onTap: () {
                                        setState(() {
                                          context
                                              .read<PendingOrderController>()
                                              .getDate2(context, 'To');
                                        });
                                      },
                                      decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 5.0,
                                                  horizontal: 5.0),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          hintText: "",
                                          hintStyle: widget
                                              .theme.textTheme.bodyLarge!
                                              .copyWith(color: Colors.black),
                                          suffixIcon:
                                              const Icon(Icons.calendar_today)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      SizedBox(
                        width: widget.btnWidth * 0.08,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            context.read<PendingOrderController>().searchBtn();
                          });

                          // context.read<SalesQuotationCon>().getSalesDataDatewise(
                          //     context
                          //         .read<SalesQuotationCon>()
                          //         .searchcontroller[100]
                          //         .text
                          //         .toString(),
                          //     context
                          //         .read<SalesQuotationCon>()
                          //         .searchcontroller[101]
                          //         .text
                          //         .toString());
                        },
                        child: Container(
                          height: widget.btnheight * 0.25,
                          width: widget.btnWidth * 0.15,
                          decoration: BoxDecoration(
                              color: widget.theme.primaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ]),
              ),
              SizedBox(
                height: widget.btnheight * 0.07,
              ),

              Container(
                width: widget.btnWidth * 2.05,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.3), //color of shadow
                      spreadRadius: 3, //spread radius
                      blurRadius: 2, // blur radius
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: context
                      .read<PendingOrderController>()
                      .searchcontroller[4],
                  style: widget.theme.textTheme.bodyMedium!
                      .copyWith(color: Colors.black),

                  onChanged: (val) {
                    setState(() {
                      context
                          .read<PendingOrderController>()
                          .filterHeaderListItem(val);
                    });
                  },
                  onEditingComplete: () {},
                  // Only numbers can be entered
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(8),
                    hintText: "Search here..!!",
                    hintStyle: widget.theme.textTheme.bodyMedium!
                        .copyWith(color: const Color(0xFF757575)),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: widget.btnheight * 0.05,
              ),

              Container(
                padding: EdgeInsets.all(widget.btnheight * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(widget.btnheight * 0.06),
                      height: widget.btnWidth * 0.07,
                      color: widget.theme.primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: widget.btnWidth * 0.15,
                            // color: Colors.green,
                            child: Text("S.O Number",
                                style:
                                    widget.theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                )),
                          ),
                          Container(
                            // color: Colors.green,
                            width: widget.btnWidth * 0.4,
                            alignment: Alignment.center,
                            child: Text("Customer Name",
                                style:
                                    widget.theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                )),
                          ),
                          Container(
                            alignment: Alignment.center,
                            // color: Colors.green,
                            width: widget.btnWidth * 0.15,
                            child: Text("Item Code",
                                style:
                                    widget.theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                )),
                          ),
                          Container(
                            // color: Colors.yellow,
                            alignment: Alignment.center,
                            width: widget.btnWidth * 0.5,
                            child: Text("Item Name",
                                style:
                                    widget.theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                )),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: widget.btnWidth * 0.15,
                            child: Text("S.O Qty",
                                style:
                                    widget.theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                )),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: widget.btnWidth * 0.15,
                            child: Text("Bal Qty",
                                style:
                                    widget.theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                )),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: widget.btnWidth * 0.2,
                            // color: Colors.green,
                            child: Text("Date",
                                style:
                                    widget.theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                )),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            width: widget.btnWidth * 0.25,
                            // color: Colors.red,
                            child: Text("Total",
                                style:
                                    widget.theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                )),
                          ),
                        ],
                      ),
                    ),
                    context
                                .watch<PendingOrderController>()
                                .filterHeaderOrderdatas!
                                .isEmpty &&
                            context.watch<PendingOrderController>().isloading ==
                                true
                        ? SizedBox(
                            height: widget.btnheight * 1.5,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: widget.theme.primaryColor,
                              ),
                            ),
                          )
                        : context
                                    .watch<PendingOrderController>()
                                    .filterHeaderOrderdatas!
                                    .isEmpty &&
                                context
                                    .watch<PendingOrderController>()
                                    .expMsg
                                    .isNotEmpty
                            ? Container(
                                height: widget.btnheight * 1.5,
                                alignment: Alignment.center,
                                child: const Text("No Pending Order Here..!!"),
                              )
                            : context
                                        .watch<PendingOrderController>()
                                        .filterHeaderOrderdatas!
                                        .isNotEmpty &&
                                    context
                                            .watch<PendingOrderController>()
                                            .isloading ==
                                        false
                                ? Container(
                                    padding: EdgeInsets.only(
                                        top: widget.btnheight * 0.02,
                                        right: widget.btnWidth * 0.0,
                                        left: widget.btnWidth * 0.0,
                                        bottom: widget.btnheight * 0.18),
                                    height: widget.btnheight * 3.2,
                                    width: double.infinity,
                                    child: ListView.builder(
                                        itemCount: context
                                            .watch<PendingOrderController>()
                                            .filterHeaderOrderdatas!
                                            .length,
                                        itemBuilder: (context, index) {
                                          return Card(
                                              margin: const EdgeInsets.only(
                                                  top: 0.5),
                                              child: ListTile(
                                                contentPadding:
                                                    const EdgeInsets.all(0),
                                                onTap: () {
                                                  //   setState(() {
                                                  //     context
                                                  //         .read<
                                                  //             PendingOrderController>()
                                                  //         .soDetailsData(context
                                                  //             .read<
                                                  //                 PendingOrderController>()
                                                  //             .filterHeaderOrderdatas![index]);

                                                  //     Navigator.push(
                                                  //         context,
                                                  //         MaterialPageRoute(
                                                  //             builder: (context) =>
                                                  //                 PendingListItem(
                                                  //                   theme: widget
                                                  //                       .theme,
                                                  //                   btnWidth: widget
                                                  //                       .btnWidth,
                                                  //                   btnheight: widget
                                                  //                       .btnheight,
                                                  //                 )));
                                                  //   });
                                                },
                                                title: Container(
                                                  padding: EdgeInsets.only(
                                                      left: widget.btnWidth *
                                                          0.01,
                                                      right: widget.btnWidth *
                                                          0.01),
                                                  //   color: Colors.amber,
                                                  width: widget.btnWidth * 0.77,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                          // color: Colors.red,
                                                          width:
                                                              widget.btnWidth *
                                                                  0.17,
                                                          child: Text(
                                                            context
                                                                .watch<
                                                                    PendingOrderController>()
                                                                .filterHeaderOrderdatas![
                                                                    index]
                                                                .docNum
                                                                .toString(),
                                                            style: widget
                                                                .theme
                                                                .textTheme
                                                                .bodyLarge!
                                                                .copyWith(),
                                                          )),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width:
                                                              widget.btnWidth *
                                                                  0.39,
                                                          child: Text(
                                                            context
                                                                .watch<
                                                                    PendingOrderController>()
                                                                .filterHeaderOrderdatas![
                                                                    index]
                                                                .custName
                                                                .toString(),
                                                            style: widget
                                                                .theme
                                                                .textTheme
                                                                .bodyLarge!
                                                                .copyWith(),
                                                          )),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          // color: Colors.red,
                                                          width:
                                                              widget.btnWidth *
                                                                  0.15,
                                                          child: Text(
                                                            context
                                                                .watch<
                                                                    PendingOrderController>()
                                                                .filterHeaderOrderdatas![
                                                                    index]
                                                                .itemCode
                                                                .toString(),
                                                            style: widget
                                                                .theme
                                                                .textTheme
                                                                .bodyLarge!
                                                                .copyWith(),
                                                          )),
                                                      Container(
                                                          width:
                                                              widget.btnWidth *
                                                                  0.49,
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            context
                                                                .watch<
                                                                    PendingOrderController>()
                                                                .filterHeaderOrderdatas![
                                                                    index]
                                                                .itemname
                                                                .toString(),
                                                            style: widget
                                                                .theme
                                                                .textTheme
                                                                .bodyLarge!
                                                                .copyWith(),
                                                          )),
                                                      Container(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          width:
                                                              widget.btnWidth *
                                                                  0.15,
                                                          child: Text(context
                                                              .watch<
                                                                  PendingOrderController>()
                                                              .filterHeaderOrderdatas![
                                                                  index]
                                                              .totalQty!
                                                              .toString())),
                                                      Container(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          width:
                                                              widget.btnWidth *
                                                                  0.15,
                                                          child: Text(context
                                                              .watch<
                                                                  PendingOrderController>()
                                                              .filterHeaderOrderdatas![
                                                                  index]
                                                              .balQty!
                                                              .toString())),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width:
                                                              widget.btnWidth *
                                                                  0.18,
                                                          child: Text(config
                                                              .alignDate((context
                                                                  .watch<
                                                                      PendingOrderController>()
                                                                  .filterHeaderOrderdatas![
                                                                      index]
                                                                  .date!)))),
                                                      Container(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          width:
                                                              widget.btnWidth *
                                                                  0.27,
                                                          child: Text(config
                                                              .splitValues((context
                                                                  .watch<
                                                                      PendingOrderController>()
                                                                  .filterHeaderOrderdatas![
                                                                      index]
                                                                  .total!
                                                                  .toStringAsFixed(
                                                                      2))))),
                                                    ],
                                                  ),
                                                ),
                                              ));
                                        }),
                                  )
                                : Container(),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.05,
                    )
                  ],
                ),
              ),
              //
              SizedBox(
                height: Screens.padingHeight(context) * 0.05,
              )
            ],
          )),
    );
  }
}
