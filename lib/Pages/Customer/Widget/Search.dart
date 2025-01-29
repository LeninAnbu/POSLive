import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Controller/CustomerController/CustomerController.dart';

class Search_Widget extends StatefulWidget {
  Search_Widget(
      {super.key, required this.searchHeight, required this.searchWidth});

  double searchHeight;
  double searchWidth;

  @override
  State<Search_Widget> createState() => _Search_WidgetState();
}

class _Search_WidgetState extends State<Search_Widget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: widget.searchHeight,
      width: widget.searchWidth,
      padding: EdgeInsets.only(
          top: widget.searchHeight * 0.01,
          left: widget.searchHeight * 0.01,
          right: widget.searchHeight * 0.01,
          bottom: widget.searchHeight * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              alignment: Alignment.center,
              width: widget.searchWidth * 0.8,
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 240, 235, 235)),
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey.withOpacity(0.01),
              ),
              child: TextFormField(
                style: theme.textTheme.bodyMedium,
                onChanged: (v) {
                  context.read<CustomerController>().filterListSearched(v);
                },
                cursorColor: Colors.grey,
                // controller: stChCon.mycontroller[99],
                onEditingComplete: () {},
                decoration: InputDecoration(
                  filled: false,
                  hintText: 'Search Here..',
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(
                      //  color: Colors.grey
                      //   fontWeight: FontWeight.normal
                      ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  // suffixIcon: IconButton(
                  //   icon: Icon(
                  //     Icons.search,
                  //     // size: searchHeight * 0.05,
                  //     color: Colors.grey,
                  //   ),
                  //   onPressed: () async {},
                  //   color: theme.primaryColor,
                  // ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                ),
              )),
          SizedBox(
            height: widget.searchHeight * 0.01,
          ),
          Container(
            padding: EdgeInsets.only(
              top: widget.searchHeight * 0.01,
              left: widget.searchHeight * 0.01,
              right: widget.searchHeight * 0.01,
              bottom: widget.searchHeight * 0.01,
            ),
            decoration: BoxDecoration(
              color: theme.primaryColor,
            ),
            //  height: searchHeight * 0.06,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    //  color: Colors.red,
                    alignment: Alignment.center,
                    width: widget.searchWidth * 0.07,
                    child: Text(
                      "S.No",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    )),
                Container(
                    //  color: Colors.red,
                    alignment: Alignment.center,
                    width: widget.searchWidth * 0.29,
                    child: Text(
                      "Customer Name",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    )),
                Container(
                    // color: Colors.red,
                    alignment: Alignment.center,
                    width: widget.searchWidth * 0.17,
                    child: Text(
                      "Customer Code",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    )),
                Container(
                    // color: Colors.red,
                    alignment: Alignment.center,
                    width: widget.searchWidth * 0.17,
                    child: Text(
                      "Balance",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    )),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                      // color: Colors.red,
                      alignment: Alignment.center,
                      width: widget.searchWidth * 0.08,
                      child: Text(
                        "Points",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.white),
                      )),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                      // color: Colors.red,
                      alignment: Alignment.center,
                      width: widget.searchWidth * 0.14,
                      child: Text(
                        "Email ID",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
          Expanded(
              child: context.watch<CustomerController>().listbool == true &&
                      context
                          .watch<CustomerController>()
                          .filtercustomerList
                          .isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : context.watch<CustomerController>().listbool == false &&
                          context
                              .watch<CustomerController>()
                              .filtercustomerList
                              .isEmpty
                      ? const Center(child: Text("Does Not Have data..!!"))
                      : ListView.builder(
                          itemCount: context
                              .watch<CustomerController>()
                              .filtercustomerList
                              .length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  context.read<CustomerController>().pageplus();

                                  context.read<CustomerController>().listPasss(
                                      context
                                          .read<CustomerController>()
                                          .filtercustomerList[index]);

                                  context
                                      .read<CustomerController>()
                                      .callAddresstReportapi(context
                                          .read<CustomerController>()
                                          .filtercustomerList[index]
                                          .customerCode!);
                                });
                              },
                              child: Card(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    top: widget.searchHeight * 0.01,
                                    left: widget.searchHeight * 0.01,
                                    right: widget.searchHeight * 0.01,
                                    bottom: widget.searchHeight * 0.02,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey.withOpacity(0.04),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          // color: Colors.red,
                                          alignment: Alignment.center,
                                          width: widget.searchWidth * 0.07,
                                          child: Text(
                                            "${index + 1}",
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          )),
                                      Container(
                                          // color: Colors.red,
                                          alignment: Alignment.center,
                                          width: widget.searchWidth * 0.29,
                                          child: Text(
                                            "${context.watch<CustomerController>().filtercustomerList[index].customername}",
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          )),
                                      Container(
                                          // color: Colors.red,
                                          alignment: Alignment.center,
                                          width: widget.searchWidth * 0.17,
                                          child: Text(
                                            "${context.watch<CustomerController>().filtercustomerList[index].customerCode}",
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          )),
                                      Container(
                                          // color: Colors.red,
                                          alignment: Alignment.center,
                                          width: widget.searchWidth * 0.17,
                                          child: Text(
                                            context
                                                .watch<CustomerController>()
                                                .filtercustomerList[index]
                                                .balance!
                                                .toStringAsFixed(2),
                                            // textAlign: TextAlign.left,
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          )),
                                      Container(
                                          // color: Colors.red,
                                          alignment: Alignment.center,
                                          width: widget.searchWidth * 0.08,
                                          child: Text(
                                            "${context.watch<CustomerController>().filtercustomerList[index].points}",
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          )),
                                      Container(
                                          // color: Colors.red,
                                          alignment: Alignment.center,
                                          width: widget.searchWidth * 0.14,
                                          child: Text(
                                            "${context.watch<CustomerController>().filtercustomerList[index].emalid}",
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })),
        ],
      ),
    );
  }
}
