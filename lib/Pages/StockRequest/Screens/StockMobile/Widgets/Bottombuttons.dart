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
                    // color: Colofrs.amber,
                    width: Screens.width(context) * 0.4,

                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(
                              // width: 5.0,
                              color: theme.primaryColor,
                            )),
                        onPressed: () {
                          if (SR_Con.scanneditemData.isNotEmpty ||
                                  SR_Con.whssSlectedList != null
                              // ||
                              // SR_Con.ShipSelectedList != null
                              ) {
                            // showDialog(
                            //     context: context,
                            //     barrierDismissible: true,
                            //     builder: (BuildContext context) {
                            //       return AlertDialog(
                            //           contentPadding: EdgeInsets.all(0),
                            //           content: AlertBox(
                            //             payMent: 'Suspended',
                            // widget:
                            forSuspend(context, theme);
                            //         buttonName: null,
                            //       ));
                            // });
                          } else {
                            // showDialog(
                            //     context: context,
                            //     barrierDismissible: true,
                            //     builder: (BuildContext context) {
                            //       return AlertDialog(
                            //           contentPadding: EdgeInsets.all(0),
                            //           content: AlertBox(
                            //             payMent: 'Alert',
                            //             errormsg: true,
                            //             widget: Center(
                            //                 child: ContentContainer(
                            //               content:
                            //                   'Alreaty empty Details here..',
                            //               theme: theme,
                            //             )),
                            //             buttonName: null,
                            //           ));
                            //     });
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
                    // color: Colors.amber,
                    width: Screens.width(context) * 0.4,
                    // height: Screens.bodyheight(context) * 0.1,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(
                              // width: 5.0,
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
                    // color: Colofrs.amber,
                    width: Screens.width(context) * 0.4,
                    child: ElevatedButton(
                        // style: ElevatedButton.styleFrom(
                        //     primary: Colors.white,
                        //     side: BorderSide(
                        //       // width: 5.0,
                        //       color: theme.primaryColor,
                        //     )),
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
                    // alignment: Alignment.centerRight,

                    // color: Colors.orange,
                    width: Screens.width(context) * 0.4,
                    child: ElevatedButton(
                        // style: ElevatedButton.styleFrom(
                        //     primary: Colors.white,
                        //     side: BorderSide(
                        //       // width: 5.0,
                        //       color: theme.primaryColor,
                        //     )),
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

  // forSuspend(BuildContext context, ThemeData theme) {
  //   return Container(
  //       child: Column(
  //     children: [
  //       Container(
  //           // color: Colors.amber,
  //           padding: EdgeInsets.all(Screens.bodyheight(context) * 0.02),
  //           // ignore: prefer_const_constructors
  //           child: Center(
  //               child: Text(
  //             "You about to suspended all information will be unsaved",
  //             textAlign: TextAlign.center,
  //           ))),
  //       Padding(
  //         padding: EdgeInsets.all(Screens.bodyheight(context) * 0.008),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             GestureDetector(
  //                 onTap: () {
  //                   Navigator.pop(context);
  //                   SR_Con.SuspendMethodDB(context, theme, "suspend");
  //                 },
  //                 child: Container(
  //                   width: Screens.width(context) * 0.22,
  //                   alignment: Alignment.center,
  //                   decoration: BoxDecoration(
  //                       color: theme.primaryColor,
  //                       borderRadius: BorderRadius.circular(3),
  //                       border: Border.all(
  //                         color: theme.primaryColor,
  //                       )),
  //                   height: Screens.bodyheight(context) * 0.05,
  //                   child: Text("Yes",
  //                       style: theme.textTheme.bodyText2?.copyWith(
  //                         color: Colors.white,
  //                       )),
  //                 )),
  //             GestureDetector(
  //                 onTap: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Container(
  //                   width: Screens.width(context) * 0.22,
  //                   alignment: Alignment.center,
  //                   decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(3),
  //                       color: theme.primaryColor,
  //                       border: Border.all(
  //                         color: theme.primaryColor,
  //                       )),
  //                   height: Screens.bodyheight(context) * 0.05,
  //                   child: Text("No",
  //                       style: theme.textTheme.bodyText2?.copyWith(
  //                         color: Colors.white,
  //                       )),
  //                 )),
  //           ],
  //         ),
  //       ),
  //     ],
  //   ));
  // }
  forSuspend(BuildContext context, ThemeData theme) {
    return Get.defaultDialog(
        title: "Alert",
        middleText: "You about to suspended all information will be unsaved",
        backgroundColor: Colors.white,
        titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
        middleTextStyle: theme.textTheme.bodyLarge,
        radius: 0,
        // onCancel: (){},
        // onConfirm: (){},
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
