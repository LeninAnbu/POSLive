import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:posproject/Constant/AppConstant.dart';
import 'package:posproject/Constant/UserValues.dart';
import 'package:provider/provider.dart';

import '../../../../Constant/Screen.dart';
import '../../../../Controller/SalesOrderController/SalesOrderController.dart';

class SearhBoxSO extends StatefulWidget {
  SearhBoxSO({
    super.key,
    required this.theme,
    required this.searchHeight,
    required this.searchWidth,
  });

  final ThemeData theme;
  double searchHeight;
  double searchWidth;

  @override
  State<SearhBoxSO> createState() => SearhBoxState();
}

class SearhBoxState extends State<SearhBoxSO> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AlertDialog(
            insetPadding: const EdgeInsets.all(10),
            contentPadding: const EdgeInsets.all(0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            content: SizedBox(
                width: widget.searchWidth * 2,
                //  height:searchHeight*0.9 ,
                child: SingleChildScrollView(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          width: widget.searchWidth,
                          padding: EdgeInsets.all(widget.searchHeight * 0.01),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Form(
                                    key: context.read<SOCon>().formkey[0],
                                    child: Row(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              // color: Colors.blue,
                                              width: widget.searchWidth * 0.08,
                                              child: const Text("From Date"),
                                            ),
                                            Container(
                                              height:
                                                  widget.searchHeight * 0.07,
                                              width: widget.searchWidth * 0.15,
                                              decoration: const BoxDecoration(
                                                  // //color: Colors.amber,
                                                  //   borderRadius: BorderRadius.circular(4),
                                                  //  border: Border.all(),
                                                  ),
                                              child:
                                                  // Center(child: Text("2023-03-03"))
                                                  TextFormField(
                                                controller: context
                                                    .read<SOCon>()
                                                    .mycontroller[100],
                                                readOnly: true,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Required";
                                                  }
                                                  null;
                                                  return null;
                                                },
                                                onTap: () {
                                                  context
                                                      .read<SOCon>()
                                                      .getDate2(
                                                          context, 'From');
                                                },
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            vertical: 5.0,
                                                            horizontal: 5.0),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                    //   labelText: "Date",
                                                    hintText: "",
                                                    hintStyle: widget.theme
                                                        .textTheme.bodyLarge!
                                                        .copyWith(
                                                            color:
                                                                Colors.black),
                                                    suffixIcon: const Icon(
                                                        Icons.calendar_today)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              // color: Colors.blue,
                                              width: widget.searchWidth * 0.08,
                                              child: const Text("To Date"),
                                            ),
                                            Container(
                                              height:
                                                  widget.searchHeight * 0.07,
                                              width: widget.searchWidth * 0.15,
                                              decoration: const BoxDecoration(
                                                  // //color: Colors.amber,
                                                  //   borderRadius: BorderRadius.circular(4),
                                                  //  border: Border.all(),
                                                  ),
                                              child:
                                                  // Center(child: Text("2023-03-03"))
                                                  TextFormField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Required";
                                                  }
                                                  null;
                                                  return null;
                                                },
                                                readOnly: true,
                                                controller: context
                                                    .read<SOCon>()
                                                    .mycontroller[101],
                                                onTap: () {
                                                  context
                                                      .read<SOCon>()
                                                      .getDate2(context, 'To');
                                                },
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            vertical: 5.0,
                                                            horizontal: 5.0),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                    //   labelText: "Date",
                                                    hintText: "",
                                                    hintStyle: widget.theme
                                                        .textTheme.bodyLarge!
                                                        .copyWith(
                                                            color:
                                                                Colors.black),
                                                    suffixIcon: const Icon(
                                                        Icons.calendar_today)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (context
                                            .read<SOCon>()
                                            .formkey[0]
                                            .currentState!
                                            .validate()) {
                                          // StOut_Con.tappage.animateToPage(
                                          //     ++StOut_Con.tappageIndex,
                                          //     duration: Duration(milliseconds: 400),
                                          //     curve: Curves.linearToEaseOut);
                                          context
                                              .read<SOCon>()
                                              .callSearchHeaderApi();
                                        }
                                      });
                                    },
                                    child: Container(
                                      height: widget.searchHeight * 0.07,
                                      width: widget.searchWidth * 0.08,
                                      decoration: BoxDecoration(
                                          color: widget.theme.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: const Icon(
                                        Icons.search,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: widget.searchHeight * 0.07,
                                        width: widget.searchWidth * 0.3,

                                        decoration: const BoxDecoration(
                                            // //color: Colors.amber,
                                            //   borderRadius: BorderRadius.circular(4),
                                            //  border: Border.all(),
                                            ),

                                        child: TextFormField(
                                          // keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            setState(() {
                                              context
                                                  .read<SOCon>()
                                                  .filterSearchBoxList(
                                                      value.trim());
                                            });
                                          },

                                          // readOnly: true,
                                          //  controller: settleCon.mycontroller[1],
                                          decoration: InputDecoration(
                                              hintText: "Search...",
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 10.0),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              //   labelText: "Date",
                                              hintStyle: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: Colors.black)),
                                        ),
                                        //Center(child: Text("2000"))
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: widget.searchHeight * 0.01,
                              ),
                            ],
                          )),
                      Container(
                        padding: EdgeInsets.only(
                            right: widget.searchWidth * 0.01,
                            left: widget.searchWidth * 0.01),
                        decoration: BoxDecoration(
                            color: widget.theme.primaryColor,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.white)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: widget.searchWidth * 0.1,
                              //color: Colors.amber,
                              child: Text(
                                "Doc No",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.08,
                              //color: Colors.amber,
                              child: Text(
                                "Doc Date",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.08,
                              //color: Colors.amber,
                              child: Text(
                                "UserName",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.1,
                              //color: Colors.amber,
                              child: Text(
                                "Terminal",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),

                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.12,
                              //color: Colors.amber,
                              child: Text(
                                "Status",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.1,
                              child: Text(
                                "Customer Code",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.15,
                              //color: Colors.amber,
                              child: Text(
                                "Customer Name",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              width: widget.searchWidth * 0.12,
                              //color: Colors.amber,
                              child: Text(
                                "Doc Total ",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            // Container(
                            //   alignment: Alignment.center,
                            //   width: widget.searchWidth * 0.1,
                            //   //color: Colors.amber,
                            //   child: Text(
                            //     "Type",
                            //     style: widget.theme.textTheme.bodyMedium!
                            //         .copyWith(color: Colors.white),
                            //   ),
                            // ),
                          ],
                        ),
                      ),

                      Container(
                        height: widget.searchHeight * 0.87,
                        // color: Colors.green,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: context.watch<SOCon>().filtersearchData.isEmpty
                            ? const Center(
                                child: Text("No Data Here..!!"),
                              )
                            : ListView.builder(
                                itemCount: context
                                    .read<SOCon>()
                                    .filtersearchData
                                    .length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () async {
                                      context.read<SOCon>().clickAprList = true;
                                      context.read<SOCon>().setstate1();

                                      await context.read<SOCon>().getOrderApi(
                                          context
                                              .read<SOCon>()
                                              .filtersearchData[index]
                                              .docEntry
                                              .toString(),
                                          context
                                              .read<SOCon>()
                                              .filtersearchData[index]
                                              .docStatus
                                              .toString(),
                                          context,
                                          widget.theme);

                                      // await context
                                      //     .read<SOCon>()
                                      //     .soCustAddressApi(
                                      //       context
                                      //           .read<SOCon>()
                                      //           .filtersearchData[index]
                                      //           .docEntry
                                      //           .toString(),
                                      //     );

                                      // await context
                                      //     .read<SOCon>()
                                      //     .getOrderDetails(
                                      //         context
                                      //             .read<SOCon>()
                                      //             .filtersearchData[index]
                                      //             .docEntry
                                      //             .toString(),
                                      //         context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: widget.searchHeight * 0.03,
                                          // left: widget.searchHeight * 0.02,
                                          // right: widget.searchHeight * 0.02,
                                          bottom: widget.searchHeight * 0.03),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.05),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.grey[300]!)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            width: widget.searchWidth * 0.1,
                                            // color: Colors.amber,
                                            child: Text(
                                              context
                                                  .watch<SOCon>()
                                                  .filtersearchData[index]
                                                  .docNum
                                                  .toString(),
                                              style: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: widget.searchWidth * 0.08,
                                            //color: Colors.amber,
                                            child: Text(
                                              context
                                                  .watch<SOCon>()
                                                  .config
                                                  .alignDate(context
                                                      .read<SOCon>()
                                                      .filtersearchData[index]
                                                      .docDate),
                                              style: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: widget.searchWidth * 0.08,
                                            //color: Colors.amber,
                                            child: Text(
                                              "${UserValues.username}",
                                              style: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: widget.searchWidth * 0.1,
                                            //color: Colors.amber,
                                            child: Text(
                                              "${AppConstant.terminal}",
                                              style: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ),

                                          Container(
                                            alignment: Alignment.center,
                                            width: widget.searchWidth * 0.12,
                                            //color: Colors.amber,
                                            child: Text(
                                              context
                                                  .watch<SOCon>()
                                                  .filtersearchData[index]
                                                  .docStatus
                                                  .toString(),
                                              style: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: widget.searchWidth * 0.1,
                                            // color: Colors.amber,
                                            child: Text(
                                              "${context.watch<SOCon>().filtersearchData[index].cardCode}",
                                              style: widget
                                                  .theme.textTheme.bodyMedium!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: widget.searchWidth * 0.16,
                                            // color: Colors.amber,
                                            child: Text(
                                              context
                                                  .watch<SOCon>()
                                                  .filtersearchData[index]
                                                  .cardName,
                                              style: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                right:
                                                    widget.searchWidth * 0.01),
                                            alignment: Alignment.centerRight,
                                            width: widget.searchWidth * 0.1,
                                            //color: Colors.amber,
                                            child: Text(
                                              context
                                                  .watch<SOCon>()
                                                  .config
                                                  .splitValues(context
                                                      .watch<SOCon>()
                                                      .filtersearchData[index]
                                                      .docTotal
                                                      .toString()),
                                              style: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ),
                                          // Container(
                                          //   alignment: Alignment.center,
                                          //   width: widget.searchWidth * 0.1,
                                          //   //color: Colors.amber,
                                          //   child: Text(
                                          //     "${widget.SalesCon.filtersearchData[index].type}",
                                          //     style: widget
                                          //         .theme.textTheme.bodyMedium!
                                          //         .copyWith(color: Colors.black),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                      )

                      // Container(),
                    ],
                  ),
                ))),
        Visibility(
          visible: context.watch<SOCon>().clickAprList,
          child: Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.88,
            color: Colors.white60,
            child: Center(
              child: SpinKitFadingCircle(
                size: Screens.bodyheight(context) * 0.08,
                color: widget.theme.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
