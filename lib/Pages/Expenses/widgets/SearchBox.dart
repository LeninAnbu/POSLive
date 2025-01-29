import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Constant/UserValues.dart';
import 'package:posproject/main.dart';
import 'package:provider/provider.dart';

import '../../../Controller/ExpenseController/ExpenseController.dart';

class ExpenseSearhBox extends StatefulWidget {
  ExpenseSearhBox({
    super.key,
    required this.theme,
    required this.searchHeight,
    required this.searchWidth,
    // required this.ExpCon
  });

  final ThemeData theme;
  double searchHeight;
  double searchWidth;
  // ExpenseController ExpCon;

  @override
  State<ExpenseSearhBox> createState() => _stConSearhBoxState();
}

class _stConSearhBoxState extends State<ExpenseSearhBox> {
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
                                    key: context
                                        .watch<ExpenseController>()
                                        .formkey[1],
                                    child: Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          // color: Colors.blue,
                                          width: widget.searchWidth * 0.08,
                                          child: const Text("From Date"),
                                        ),
                                        Container(
                                          height: widget.searchHeight * 0.07,
                                          width: widget.searchWidth * 0.15,
                                          decoration: const BoxDecoration(
                                              // color: Colors.amber,
                                              //   borderRadius: BorderRadius.circular(4),
                                              //  border: Border.all(),
                                              ),
                                          child:
                                              // Center(child: Text("2023-03-03"))
                                              TextFormField(
                                            controller: context
                                                .watch<ExpenseController>()
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
                                                  .read<ExpenseController>()
                                                  .getDate2(context, 'From');
                                            },
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.0,
                                                        horizontal: 5.0),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                //   labelText: "Date",
                                                hintText: "",
                                                hintStyle: widget
                                                    .theme.textTheme.bodyLarge!
                                                    .copyWith(
                                                        color: Colors.black),
                                                suffixIcon: const Icon(
                                                    Icons.calendar_today)),
                                          ),
                                        ),
                                      ],
                                    ),
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
                                        height: widget.searchHeight * 0.07,
                                        width: widget.searchWidth * 0.15,
                                        decoration: const BoxDecoration(
                                            // color: Colors.amber,
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
                                              .watch<ExpenseController>()
                                              .mycontroller[101],
                                          onTap: () {
                                            context
                                                .read<ExpenseController>()
                                                .getDate2(context, 'To');
                                          },
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5.0,
                                                      horizontal: 5.0),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              //   labelText: "Date",
                                              hintText: "",
                                              hintStyle: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: Colors.black),
                                              suffixIcon: const Icon(
                                                  Icons.calendar_today)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (context
                                            .read<ExpenseController>()
                                            .formkey[1]
                                            .currentState!
                                            .validate()) {
                                          context
                                              .read<ExpenseController>()
                                              .callSearchHeader();
                                          // StOut_Con.tappage.animateToPage(
                                          //     ++StOut_Con.tappageIndex,
                                          //     duration: Duration(milliseconds: 400),
                                          //     curve: Curves.linearToEaseOut);
                                          // context
                                          //     .read<ExpenseController>()
                                          //     .getSalesDataDatewise(
                                          //         context
                                          //             .read<ExpenseController>()
                                          //             .mycontroller[100]
                                          //             .text
                                          //             .toString(),
                                          //         context
                                          //             .read<ExpenseController>()
                                          //             .mycontroller[101]
                                          //             .text
                                          //             .toString());
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
                                            // color: Colors.amber,
                                            //   borderRadius: BorderRadius.circular(4),
                                            //  border: Border.all(),
                                            ),

                                        child: TextFormField(
                                          // keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            setState(() {
                                              context
                                                  .read<ExpenseController>()
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
                        decoration: BoxDecoration(
                            color: widget.theme.primaryColor,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.white)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.08,
                              // color: Colors.amber,
                              child: Text(
                                "Doc No",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,

                              width: widget.searchWidth * 0.1,
                              // color: Colors.amber,
                              child: Text(
                                "Doc Date",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,

                              width: widget.searchWidth * 0.08,
                              // color: Colors.amber,
                              child: Text(
                                "UserName",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            // Container(
                            //   alignment: Alignment.center,

                            //   width: widget.searchWidth * 0.1,
                            //   // color: Colors.amber,
                            //   child: Text(
                            //     "Terminal",
                            //     style: widget.theme.textTheme.bodyLarge!
                            //         .copyWith(color: Colors.white),
                            //   ),
                            // ),
                            // Container(
                            //   alignment: Alignment.center,

                            //   width: widget.searchWidth * 0.08,
                            //   // color: Colors.amber,
                            //   child: Text(
                            //     "SAP DocNo",
                            //     style: widget.theme.textTheme.bodyMedium!
                            //         .copyWith(color: Colors.white),
                            //   ),
                            // ),
                            Container(
                              alignment: Alignment.center,

                              width: widget.searchWidth * 0.08,
                              // color: Colors.amber,
                              child: Text(
                                "Status",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            // Container(
                            //   alignment: Alignment.center,

                            //   width: widget.searchWidth * 0.15,
                            //   // color: Colors.amber,
                            //   child: Text(
                            //     "Customer Name",
                            //     style: widget.theme.textTheme.bodyMedium!
                            //         .copyWith(color: Colors.white),
                            //   ),
                            // ),
                            Container(
                              padding: EdgeInsets.only(
                                  right: Screens.width(context) * 0.01),
                              alignment: Alignment.centerRight,
                              width: widget.searchWidth * 0.15,
                              // color: Colors.amber,
                              child: Text(
                                "Doc Total ",
                                style: widget.theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            // Container(
                            //   alignment: Alignment.center,
                            //   width: widget.searchWidth * 0.1,
                            //   // color: Colors.amber,
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
                        height: widget.searchHeight,
                        // color: Colors.green,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: context
                                .watch<ExpenseController>()
                                .filtersearchData
                                .isEmpty
                            ? const Center(
                                child: Text("No Data Here..!!"),
                              )
                            : ListView.builder(
                                itemCount: context
                                    .read<ExpenseController>()
                                    .filtersearchData
                                    .length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        context
                                            .read<ExpenseController>()
                                            .searchLoad = true;
                                        context
                                            .read<ExpenseController>()
                                            .callGetExpDetailsApi(
                                                context
                                                    .read<ExpenseController>()
                                                    .filtersearchData[index]
                                                    .docEntry
                                                    .toString(),
                                                context);
                                        // context
                                        //     .read<ExpenseController>()
                                        // .fixDataMethod(context
                                        //     .read<ExpenseController>()
                                        //     .filtersearchData[index]
                                        //     .docentry);
                                      });
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

                                            width: widget.searchWidth * 0.08,
                                            // color: Colors.amber,
                                            child: Text(
                                              "${context.watch<ExpenseController>().filtersearchData[index].docNum}",
                                              style: widget
                                                  .theme.textTheme.bodyMedium!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,

                                            width: widget.searchWidth * 0.1,
                                            // color: Colors.amber,
                                            child: Text(
                                              context
                                                  .watch<ExpenseController>()
                                                  .config
                                                  .alignDate(context
                                                      .watch<
                                                          ExpenseController>()
                                                      .filtersearchData[index]
                                                      .docDate
                                                      .toString()),
                                              style: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,

                                            width: widget.searchWidth * 0.08,
                                            // color: Colors.amber,
                                            child: Text(
                                              "${UserValues.username}",
                                              style: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ),
                                          // Container(
                                          //   alignment: Alignment.center,

                                          //   width: widget.searchWidth * 0.1,
                                          //   // color: Colors.amber,
                                          //   child: Text(
                                          //     "${context.watch<ExpenseController>().filtersearchData[index].terminal}",
                                          //     style: widget
                                          //         .theme.textTheme.bodyLarge!
                                          //         .copyWith(color: Colors.black),
                                          //   ),
                                          // ),

                                          Container(
                                            alignment: Alignment.center,

                                            width: widget.searchWidth * 0.08,
                                            // color: Colors.amber,
                                            child: Text(
                                              context
                                                  .watch<ExpenseController>()
                                                  .filtersearchData[index]
                                                  .status,
                                              style: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ),
                                          // Container(
                                          //   alignment: Alignment.center,

                                          //   width: widget.searchWidth * 0.15,
                                          //   // color: Colors.amber,
                                          //   child: Text(
                                          //     "${widget.ExpCon.filtersearchData[index].customeraName}",
                                          //     style: widget
                                          //         .theme.textTheme.bodyMedium!
                                          //         .copyWith(color: Colors.black),
                                          //   ),
                                          // ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                right: Screens.width(context) *
                                                    0.01),
                                            alignment: Alignment.centerRight,
                                            width: widget.searchWidth * 0.15,
                                            // color: Colors.amber,
                                            child: Text(
                                              "${config.splitValues(context.watch<ExpenseController>().filtersearchData[index].cashSum.toStringAsFixed(2))}",
                                              style: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ),
                                          // Container(
                                          //   alignment: Alignment.center,
                                          //   width: widget.searchWidth * 0.1,
                                          //   // color: Colors.amber,
                                          //   child: Text(
                                          //     "Type",
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
          visible: context.watch<ExpenseController>().searchLoad,
          child: Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.9,
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
