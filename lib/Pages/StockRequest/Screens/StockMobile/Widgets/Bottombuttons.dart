import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Controller/StockRequestController/StockRequestController.dart';

class Bottombuttons extends StatelessWidget {
  Bottombuttons({
    super.key,
    required this.SR_Con,
  });

  StockReqController SR_Con;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: Screens.bodyheight(context) * 0.004),
          width: Screens.width(context) * 0.95,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: Screens.width(context) * 0.4,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(
                              color: theme.primaryColor,
                            )),
                        onPressed: () {
                          if (SR_Con.scanneditemData.isNotEmpty ||
                              SR_Con.whssSlectedList != null) {
                            forSuspend(context, theme);
                          } else {
                            Get.defaultDialog(
                              title: "Alert",
                              middleText: "Already empty Details here..",
                              backgroundColor: Colors.white,
                              titleStyle: theme.textTheme.bodyLarge!
                                  .copyWith(color: Colors.red),
                              middleTextStyle: theme.textTheme.bodyLarge,
                              radius: 0,
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      child: const Text("Close"),
                                      onPressed: () => Get.back(),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                        },
                        child: Text(
                          "Clear All",
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: theme.primaryColor),
                        )),
                  ),
                  SizedBox(
                    width: Screens.width(context) * 0.4,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(
                              color: theme.primaryColor,
                            )),
                        onPressed: () {
                          SR_Con.holdButton(context, theme);
                        },
                        child: Text(
                          "Hold",
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: theme.primaryColor),
                        )),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: Screens.width(context) * 0.4,
                    child: ElevatedButton(
                        onPressed: SR_Con.onclickDisable == false
                            ? () {
                                SR_Con.saveButton(
                                    context, theme, "against order");
                              }
                            : null,
                        child: Text(
                          "Against Order",
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: Colors.white),
                        )),
                  ),
                  SizedBox(
                    width: Screens.width(context) * 0.4,
                    child: ElevatedButton(
                        onPressed: SR_Con.onclickDisable == false
                            ? () {
                                SR_Con.saveButton(
                                    context, theme, "against stock");
                              }
                            : null,
                        child: Text(
                          "Against Stock",
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: Colors.white),
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  forSuspend(BuildContext context, ThemeData theme) {
    return Get.defaultDialog(
        title: "Alert",
        middleText: "You about to suspended all information will be unsaved",
        backgroundColor: Colors.white,
        titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
        middleTextStyle: theme.textTheme.bodyLarge,
        radius: 0,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    SR_Con.suspendMethodDB(context, theme, "suspend");
                  },
                  child: Container(
                    width: Screens.width(context) * 0.22,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(
                          color: theme.primaryColor,
                        )),
                    height: Screens.bodyheight(context) * 0.05,
                    child: Text("Yes",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        )),
                  )),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: Screens.width(context) * 0.22,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: theme.primaryColor,
                        border: Border.all(
                          color: theme.primaryColor,
                        )),
                    height: Screens.bodyheight(context) * 0.05,
                    child: Text("No",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        )),
                  )),
            ],
          ),
        ]);
  }
}
