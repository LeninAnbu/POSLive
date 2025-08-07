import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';

import '../../../../../Controller/DepositController/DepositsController.dart';
import '../../../../../Widgets/Drawer.dart';

class SettledScecondScreen extends StatefulWidget {
  SettledScecondScreen({super.key, required this.settleCon});

  DepositsController settleCon;

  @override
  State<SettledScecondScreen> createState() => _SettledScecondScreenState();
}

class _SettledScecondScreenState extends State<SettledScecondScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text("Desposits Screen"),
        ),
        drawer: naviDrawer(),
        body: SafeArea(
          child: SizedBox(
            height: Screens.padingHeight(context) * 1,
            width: double.infinity,
            child: Column(
              children: [
                TabBar(isScrollable: true, tabs: [
                  Tab(
                      child: TextButton(
                    onPressed: () {},
                    child: Text("Cash",
                        style: theme.textTheme.bodyLarge!.copyWith()),
                  )),
                  Tab(
                    child: Text("Card",
                        style: theme.textTheme.bodyLarge!.copyWith()),
                  ),
                  Tab(
                    child: Text("Cheque",
                        style: theme.textTheme.bodyLarge!.copyWith()),
                  ),
                ]),
                Expanded(
                  child: TabBarView(children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: Screens.padingHeight(context) * 0.01,
                          bottom: Screens.padingHeight(context) * 0.01,
                          left: Screens.width(context) * 0.01,
                          right: Screens.width(context) * 0.01),
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            top: Screens.padingHeight(context) * 0.01,
                            bottom: Screens.padingHeight(context) * 0.01,
                            left: Screens.width(context) * 0.01,
                            right: Screens.width(context) * 0.01),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Form(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: Screens.width(context) * 0.40,
                                          child: const Text("Amount in Hand")),
                                      SizedBox(
                                          height:
                                              Screens.padingHeight(context) *
                                                  0.06,
                                          width: Screens.width(context) * 0.55,
                                          child: TextField(
                                            readOnly: true,
                                            controller: widget
                                                .settleCon.mycontroller[4],
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.0,
                                                        horizontal: 5.0),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                hintText: "",
                                                hintStyle:
                                                    theme.textTheme.bodyLarge),
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: Screens.width(context) * 0.40,
                                          child: const Text(
                                              "Amount to Settle off")),
                                      SizedBox(
                                          width: Screens.width(context) * 0.55,
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Requierd";
                                              }
                                              return null;
                                            },
                                            keyboardType: TextInputType.number,
                                            controller: widget
                                                .settleCon.mycontroller[5],
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.0,
                                                        horizontal: 5.0),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                hintText: "",
                                                hintStyle:
                                                    theme.textTheme.bodyLarge),
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: Screens.width(context) * 0.40,
                                          child:
                                              const Text("Settlement Account")),
                                      Container(
                                          height:
                                              Screens.padingHeight(context) *
                                                  0.06,
                                          width: Screens.width(context) * 0.55,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Center(
                                            child: DropdownButtonFormField(
                                              decoration:
                                                  InputDecoration.collapsed(
                                                      hintText:
                                                          " Settlement Account",
                                                      hintStyle: theme
                                                          .textTheme.bodyLarge),
                                              value:
                                                  widget.settleCon.valuechoose,
                                              onChanged: (newvalue) {
                                                widget.settleCon
                                                    .dropdownchoose(newvalue);
                                              },
                                              items: widget.settleCon.listitems
                                                  .map((valueitem) {
                                                return DropdownMenuItem(
                                                  value: valueitem,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: Screens.width(
                                                                context) *
                                                            0.01),
                                                    child: Text(
                                                      valueitem,
                                                      style: theme
                                                          .textTheme.bodyLarge,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: Screens.width(context) * 0.40,
                                          child: const Text("Remarks")),
                                      SizedBox(
                                          height:
                                              Screens.padingHeight(context) *
                                                  0.06,
                                          width: Screens.width(context) * 0.55,
                                          child: TextField(
                                            controller: widget
                                                .settleCon.mycontroller[6],
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.0,
                                                        horizontal: 5.0),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                hintText: "Remarks...",
                                                hintStyle:
                                                    theme.textTheme.bodyLarge),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Screens.padingHeight(context) * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      widget.settleCon.insertsettledheader(
                                          "Cash", theme, context);
                                    },
                                    child: const Text("Save")),
                                SizedBox(
                                  width: Screens.width(context) * 0.02,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Cancel")),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: Screens.padingHeight(context) * 0.01,
                          bottom: Screens.padingHeight(context) * 0.01,
                          left: Screens.width(context) * 0.01,
                          right: Screens.width(context) * 0.01),
                      child: Form(
                        child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: Screens.padingHeight(context) * 0.01,
                                bottom: Screens.padingHeight(context) * 0.01,
                                left: Screens.width(context) * 0.01,
                                right: Screens.width(context) * 0.01),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height:
                                              Screens.padingHeight(context) *
                                                  0.06,
                                          width: Screens.padingHeight(context) *
                                              0.30,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Center(
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                focusColor: Colors.white,
                                                hint: Text(
                                                  " Choose Payment Terminal",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: widget.settleCon
                                                                .gethintcolor ==
                                                            false
                                                        ? Colors.grey
                                                        : Colors.red,
                                                  ),
                                                ),
                                                items: widget.settleCon
                                                    .cardpayTerminallist
                                                    .map((valueitem) =>
                                                        DropdownMenuItem<
                                                            String>(
                                                          value: valueitem,
                                                          child: Text(
                                                            valueitem,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ))
                                                    .toList(),
                                                value: widget.settleCon
                                                    .paytermvaluechoose,
                                                onChanged: (newvalue) {
                                                  setState(() {
                                                    widget.settleCon
                                                        .payTermdropdown(
                                                            newvalue);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height:
                                              Screens.padingHeight(context) *
                                                  0.06,
                                          width: Screens.width(context) * 0.20,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: theme.primaryColor,
                                          ),
                                          child: TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  widget.settleCon
                                                      .forcardlistorder(context,
                                                          "Card", theme, 1);
                                                });
                                              },
                                              child: const Text(
                                                "Load",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          Screens.padingHeight(context) * 0.01,
                                    ),
                                    SizedBox(
                                      height:
                                          Screens.padingHeight(context) * 0.50,
                                      width: Screens.width(context),
                                      child:
                                          widget.settleCon.finalcardsettled
                                                  .isEmpty
                                              ? const Center(
                                                  child: Text("No data Found"))
                                              : ListView.builder(
                                                  itemCount: widget.settleCon
                                                      .finalcardsettled.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Card(
                                                        color: Colors.grey[200],
                                                        child: CheckboxListTile(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          activeColor:
                                                              Colors.green,
                                                          value: widget
                                                              .settleCon
                                                              .finalcardsettled[
                                                                  index]
                                                              .checkClr,
                                                          onChanged: (val) {
                                                            setState(() {
                                                              widget.settleCon
                                                                  .carditemDeSelect(
                                                                      index);
                                                            });
                                                          },
                                                          title: Row(
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  SizedBox(
                                                                    width: Screens.width(
                                                                            context) *
                                                                        0.77,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Container(
                                                                            padding:
                                                                                EdgeInsets.only(left: Screens.width(context) * 0.01),
                                                                            child: Text(widget.settleCon.finalcardsettled[index].cardterminal.toString(), style: theme.textTheme.bodyLarge!.copyWith())),
                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                              widget.settleCon.finalcardsettled[index].cardRef.toString(),
                                                                              style: theme.textTheme.bodyLarge!.copyWith(),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text(widget.settleCon.finalcardsettled[index].rupees.toString(),
                                                                                style: theme.textTheme.bodyLarge!.copyWith(fontSize: 15))
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: Screens.width(
                                                                            context) *
                                                                        0.7,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left: Screens.bodyheight(context) *
                                                                              0.008),
                                                                      child: Text(
                                                                          widget
                                                                              .settleCon
                                                                              .finalcardsettled[
                                                                                  index]
                                                                              .Date
                                                                              .toString(),
                                                                          style: theme
                                                                              .textTheme
                                                                              .bodyLarge!
                                                                              .copyWith()),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ));
                                                  }),
                                    ),
                                    SizedBox(
                                      height:
                                          Screens.padingHeight(context) * 0.01,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          widget.settleCon.insertsettledheader(
                                              "Card", theme, context);
                                        },
                                        child: const Text("Save")),
                                    SizedBox(
                                      width: Screens.width(context) * 0.02,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel")),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: Screens.padingHeight(context) * 0.01,
                          bottom: Screens.padingHeight(context) * 0.01,
                          left: Screens.width(context) * 0.01,
                          right: Screens.width(context) * 0.01),
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            top: Screens.padingHeight(context) * 0.01,
                            bottom: Screens.padingHeight(context) * 0.01,
                            left: Screens.width(context) * 0.01,
                            right: Screens.width(context) * 0.01),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                            "Total Unsettled Cheque Value:"),
                                        Container(
                                            child: widget
                                                        .settleCon
                                                        .mycontroller[14]
                                                        .text ==
                                                    ""
                                                ? const Text("Rs.0.00")
                                                : Text(widget
                                                    .settleCon.totalCheque
                                                    .toString())),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          Screens.padingHeight(context) * 0.06,
                                      width: Screens.width(context) * 0.20,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              widget.settleCon.isload = true;
                                              widget.settleCon
                                                  .forChequelistorder(context,
                                                      "Cheque", theme, 1);
                                            });
                                          },
                                          child: const Text("Load")),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Screens.padingHeight(context) * 0.01,
                                ),
                                SizedBox(
                                  height: Screens.padingHeight(context) * 0.50,
                                  width: double.infinity,
                                  child: ListView.builder(
                                      itemCount: widget
                                          .settleCon.finalchequesettled.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                            color: Colors.grey[200],
                                            child: CheckboxListTile(
                                              contentPadding:
                                                  const EdgeInsets.all(0),
                                              activeColor: Colors.green,
                                              value: widget
                                                  .settleCon
                                                  .finalchequesettled[index]
                                                  .checkClr,
                                              onChanged: (val) {
                                                setState(() {
                                                  widget.settleCon
                                                      .chequeitemDeSelect(
                                                          index, val!);
                                                });
                                              },
                                              title: SizedBox(
                                                width: Screens.width(context) *
                                                    0.03,
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: Screens.width(
                                                                  context) *
                                                              0.77,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                  padding: EdgeInsets.only(
                                                                      left: Screens.width(
                                                                              context) *
                                                                          0.01),
                                                                  child: Text(
                                                                      widget
                                                                          .settleCon
                                                                          .finalchequesettled[
                                                                              index]
                                                                          .chequeDate
                                                                          .toString(),
                                                                      style: theme
                                                                          .textTheme
                                                                          .bodyLarge!
                                                                          .copyWith())),
                                                              SizedBox(
                                                                width: Screens
                                                                        .width(
                                                                            context) *
                                                                    0.001,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                      widget
                                                                          .settleCon
                                                                          .finalchequesettled[
                                                                              index]
                                                                          .rupees
                                                                          .toString(),
                                                                      style: theme
                                                                          .textTheme
                                                                          .bodyLarge!
                                                                          .copyWith(
                                                                              fontSize: 18))
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ));
                                      }),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Screens.padingHeight(context) * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      widget.settleCon.insertsettledheader(
                                          "Cheque", theme, context);
                                    },
                                    child: const Text("Save")),
                                SizedBox(
                                  width: Screens.width(context) * 0.02,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Cancel")),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
