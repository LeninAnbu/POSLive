import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:posproject/Controller/DepositController/DepositsController.dart';
import 'package:posproject/Pages/Deposits/Widgets/TabsetledSecondScreen.dart';
import 'package:provider/provider.dart';

import '../../../Constant/Screen.dart';
import '../Screens/MobSettleScreen/Mobwidgets/MobsettledCon.dart';

class SettleFirstscreen extends StatefulWidget {
  SettleFirstscreen(
      {super.key, required this.custHeight, required this.custWidth});
  double custHeight;
  double custWidth;

  @override
  State<SettleFirstscreen> createState() => _SettleFirstscreenState();
}

class _SettleFirstscreenState extends State<SettleFirstscreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(
          top: widget.custHeight * 0.03,
          left: widget.custWidth * 0.02,
          right: widget.custWidth * 0.02,
          bottom: widget.custHeight * 0.02),
      child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(
              top: widget.custHeight * 0.05,
              left: widget.custWidth * 0.02,
              right: widget.custWidth * 0.02,
              bottom: widget.custHeight * 0.02),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: widget.custWidth * 0.15,
                        child: const Text("Date"),
                      ),
                      Container(
                        height: widget.custHeight * 0.07,
                        width: widget.custWidth * 0.20,
                        decoration: const BoxDecoration(),
                        child: TextField(
                          readOnly: true,
                          controller: context
                              .read<DepositsController>()
                              .mycontroller[0],
                          onTap: () {
                            context.read<DepositsController>().getDocDate(
                                  context,
                                );
                          },
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
                    ],
                  ),
                  SizedBox(
                    height: widget.custHeight * 0.07,
                    width: widget.custWidth * 0.15,
                    child: context.watch<DepositsController>().loadigBtn ==
                            false
                        ? ElevatedButton(
                            onPressed: () async {
                              context
                                  .read<DepositsController>()
                                  .onDisablebutton = false;
                              context
                                  .read<DepositsController>()
                                  .chequeQueryData = [];
                              context
                                  .read<DepositsController>()
                                  .selectedBankType = null;
                              context
                                  .read<DepositsController>()
                                  .isSelectedAllCheque = false;

                              context
                                  .read<DepositsController>()
                                  .forcashlistorder(context, "Cash", theme);

                              Get.to(() => TabsetledSecondScreen(
                                    custHeight:
                                        Screens.padingHeight(context) * 0.90,
                                    custWidth: Screens.width(context) * 0.90,
                                  ));
                            },
                            child: const Text("New Settlement"))
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: theme.primaryColor,
                            ),
                            child: const Center(
                                child: CircularProgressIndicator(
                              color: Colors.white,
                            )),
                          ),
                  )
                ],
              ),
              SizedBox(
                height: widget.custHeight * 0.03,
              ),
              Column(
                children: [
                  SizedBox(
                    height: widget.custHeight * 0.01,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<DepositsController>().deleteDeposittb();
                        },
                        child: SizedBox(
                          width: widget.custWidth * 0.15,
                          child: const Text("Net Collection"),
                        ),
                      ),
                      Container(
                        height: widget.custHeight * 0.07,
                        width: widget.custWidth * 0.40,
                        decoration: const BoxDecoration(),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          readOnly: true,
                          controller: context
                              .watch<DepositsController>()
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
                    height: widget.custHeight * 0.02,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: widget.custWidth * 0.15,
                        child: const Text("Net Settled"),
                      ),
                      Container(
                        height: widget.custHeight * 0.07,
                        width: widget.custWidth * 0.40,
                        decoration: const BoxDecoration(),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          readOnly: true,
                          controller: context
                              .watch<DepositsController>()
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
                    height: widget.custHeight * 0.02,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: widget.custWidth * 0.15,
                        child: const Text("Unsettled Amount"),
                      ),
                      Container(
                        height: widget.custHeight * 0.07,
                        width: widget.custWidth * 0.40,
                        decoration: const BoxDecoration(),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          readOnly: true,
                          controller: context
                              .watch<DepositsController>()
                              .mycontroller[3],
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
                height: widget.custHeight * 0.03,
              ),
              const NewWidget(),
            ],
          )),
    );
  }
}

class NewWidget extends StatefulWidget {
  const NewWidget({
    super.key,
  });

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: createTable(
      context,
    ));
  }
}
