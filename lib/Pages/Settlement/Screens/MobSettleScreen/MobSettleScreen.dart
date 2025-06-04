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
  });

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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: Screens.width(context) * 0.10,
                          child: const Text("Date"),
                        ),
                        Container(
                          height: Screens.padingHeight(context) * 0.05,
                          width: Screens.width(context) * 0.42,
                          decoration: const BoxDecoration(),
                          child: InkWell(
                            child: TextField(
                              readOnly: true,
                              onTap: () {
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

                            setState(() {});
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
                          decoration: const BoxDecoration(),
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
                                hintText: "",
                                hintStyle: theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.black)),
                          ),
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
                          decoration: const BoxDecoration(),
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
                                hintText: "",
                                hintStyle: theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.black)),
                          ),
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
                          decoration: const BoxDecoration(),
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
                                hintText: "",
                                hintStyle: theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.black)),
                          ),
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
