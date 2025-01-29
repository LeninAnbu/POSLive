import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Controller/DepositController/DepositsController.dart';
import 'package:provider/provider.dart';

import 'Mobwidgets/MobSecondScreen.dart';
import 'Mobwidgets/MobsettledCon.dart';

class MobSettleScreen extends StatefulWidget {
  const MobSettleScreen({
    super.key,
    // required this.settleCon,
  });
  // DepositsController settleCon;

  @override
  State<MobSettleScreen> createState() => _MobSettleScreenState();
}

class _MobSettleScreenState extends State<MobSettleScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
          top: Screens.padingHeight(context) * 0.02,
          left: Screens.width(context) * 0.01,
          right: Screens.width(context) * 0.01,
          bottom: Screens.padingHeight(context) * 0.02),
      child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(
                top: Screens.padingHeight(context) * 0.05,
                left: Screens.width(context) * 0.01,
                right: Screens.width(context) * 0.01,
                bottom: Screens.padingHeight(context) * 0.02),
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          // alignment: Alignment.center,
                          // color: Colors.blue,
                          width: Screens.width(context) * 0.10,
                          child: const Text("Date"),
                        ),
                        Container(
                          height: Screens.padingHeight(context) * 0.05,
                          width: Screens.width(context) * 0.42,
                          decoration: const BoxDecoration(
                              //  color: Colors.amber,
                              //   borderRadius: BorderRadius.circular(4),
                              //  border: Border.all(),
                              ),
                          child:
                              // Center(child: Text("2023-03-03"))
                              InkWell(
                            child: TextField(
                              readOnly: true,
                              onTap: () {
                                // context.read<DepositsController>().getDate(context, '');

                                log("ontap");
                              },
                              controller: context
                                  .read<DepositsController>()
                                  .mycontroller[0],
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 5.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                  //   labelText: "Date",
                                  hintText: "",
                                  hintStyle: theme.textTheme.bodyLarge!
                                      .copyWith(color: Colors.black),
                                  suffixIcon: const Icon(Icons.calendar_today)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.05,
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              context
                                  .read<DepositsController>()
                                  .mycontroller[4]
                                  .text = "";
                              context
                                  .read<DepositsController>()
                                  .forcashlistorder(context, "Cash", theme);
                            });

                            setState(() {
                              //  if(context.read<DepositsController>().mycontroller[0].text == context.read<DepositsController>().currentDate()){
                              //   log("successs");

                              // }else{
                              //   log("Nw Settlement disbled");
                              // }
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SettledScecondScreen(
                                          settleCon: context
                                              .read<DepositsController>(),
                                        )));
                            context
                                .read<DepositsController>()
                                .clearcarddetails();
                          },
                          child: const Text("New Settlement")),
                    )
                  ],
                ),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.03,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context
                                .read<DepositsController>()
                                .deleteDeposittb();
                          },
                          child: SizedBox(
                            width: Screens.width(context) * 0.30,
                            child: const Text("Net Collection"),
                          ),
                        ),
                        Container(
                          height: Screens.padingHeight(context) * 0.05,
                          width: Screens.width(context) * 0.62,

                          decoration: const BoxDecoration(
                              // color: Colors.amber,
                              //   borderRadius: BorderRadius.circular(4),
                              //  border: Border.all(),
                              ),

                          child: TextField(
                            keyboardType: TextInputType.number,
                            readOnly: true,
                            controller: context
                                .read<DepositsController>()
                                .mycontroller[1],
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                //   labelText: "Date",
                                hintText: "",
                                hintStyle: theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.black)),
                          ),
                          //Center(child: Text("2000"))
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: Screens.width(context) * 0.30,
                          child: const Text("Net Settled"),
                        ),
                        Container(
                          height: Screens.padingHeight(context) * 0.05,
                          width: Screens.width(context) * 0.62,

                          decoration: const BoxDecoration(
                              //color: Colors.amber,
                              //   borderRadius: BorderRadius.circular(4),
                              //  border: Border.all(),
                              ),

                          child: TextField(
                            keyboardType: TextInputType.number,
                            readOnly: true,
                            controller: context
                                .read<DepositsController>()
                                .mycontroller[2],
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                //    labelText: "Date",
                                hintText: "",
                                hintStyle: theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.black)),
                          ),
                          //Center(child: Text("202"))
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: Screens.width(context) * 0.30,
                          child: const Text("Unsettled Amount"),
                        ),
                        Container(
                          height: Screens.padingHeight(context) * 0.05,
                          width: Screens.width(context) * 0.62,

                          decoration: const BoxDecoration(
                              //color: Colors.amber,
                              //   borderRadius: BorderRadius.circular(4),
                              //  border: Border.all(),
                              ),

                          child: TextField(
                            readOnly: true,
                            controller: context
                                .read<DepositsController>()
                                .mycontroller[3],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                // labelText: "Date",
                                hintText: "",
                                hintStyle: theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.black)),
                          ),
                          //Center(child: Text("2000"))
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.03,
                ),
                createTable(
                  context,
                ),
              ],
            ),
          )),
    );
  }
}
