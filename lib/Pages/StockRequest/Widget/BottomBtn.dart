import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Controller/StockRequestController/StockRequestController.dart';
import 'package:provider/provider.dart';

class StockReqBottomBtn extends StatefulWidget {
  StockReqBottomBtn({
    super.key,
    required this.theme,
    required this.btnWidth,
    required this.btnheight,
  });

  final ThemeData theme;
  double btnheight;
  double btnWidth;

  @override
  State<StockReqBottomBtn> createState() => _StockReqBottomBtnState();
}

class _StockReqBottomBtnState extends State<StockReqBottomBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.btnWidth * 1,
      padding: EdgeInsets.only(
        top: widget.btnheight * 0.06,
        left: widget.btnheight * 0.06,
        right: widget.btnheight * 0.06,
        // bottom: widget.btnheight * 0.06,
      ),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          context.watch<StockReqController>().scanneditemData2.isNotEmpty
              ? Container(
                  alignment: Alignment.center,
                  width: widget.btnWidth * 1,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: TextFormField(
                    controller:
                        context.read<StockReqController>().remarkscontroller2,
                    cursorColor: Colors.grey,
                    style: widget.theme.textTheme.bodyMedium?.copyWith(),
                    onChanged: (v) {},
                    readOnly: true,
                    decoration: InputDecoration(
                      filled: false,
                      labelText: "Remarks",
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                    ),
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  width: widget.btnWidth * 1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: TextFormField(
                    controller:
                        context.read<StockReqController>().remarkscontroller,
                    cursorColor: Colors.grey,
                    style: widget.theme.textTheme.bodyMedium?.copyWith(),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ' Please Enter the Remark';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Remarks",
                      filled: false,
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                    ),
                  ),
                ),
          SizedBox(
            height: widget.btnheight * 0.1,
          ),
          context.watch<StockReqController>().scanneditemData2.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // SizedBox(
                    //   height: widget.btnheight * 0.4,
                    //   width: widget.btnWidth * 0.2,
                    //   child: ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: Colors.grey[300],
                    //     ),
                    //     onPressed: () {
                    //       setState(() {
                    //         context.read<StockReqController>().cancelbtn = true;
                    //         context
                    //             .read<StockReqController>()
                    //             .clickcancelbtn(context, widget.theme);
                    //       });
                    //     },
                    //     child: context.read<StockReqController>().cancelbtn ==
                    //             false
                    //         ? Text("Cancel",
                    //             textAlign: TextAlign.center,
                    //             style:
                    //                 widget.theme.textTheme.bodySmall?.copyWith(
                    //               color: Colors.black,
                    //             ))
                    //         : CircularProgressIndicator(
                    //             color: widget.theme.primaryColor),
                    //   ),
                    // ),
                    SizedBox(
                      height: widget.btnheight * 0.4,
                      width: widget.btnWidth * 0.2,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                          ),
                          onPressed: () {
                            setState(() {
                              context.read<StockReqController>().searchclear();
                            });
                          },
                          child: Text(
                            "Clear",
                            textAlign: TextAlign.center,
                            style: widget.theme.textTheme.bodyLarge!.copyWith(
                              color: Colors.black,
                            ),
                          )),
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: widget.btnheight * 0.4,
                      width: widget.btnWidth * 0.2,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                color: widget.theme.primaryColor,
                              )),
                          onPressed: context
                                      .read<StockReqController>()
                                      .onclickDisable ==
                                  true
                              ? null
                              : () {
                                  context
                                      .read<StockReqController>()
                                      .onclickDisable = true;
                                  if (context
                                          .read<StockReqController>()
                                          .scanneditemData
                                          .isNotEmpty ||
                                      context
                                              .read<StockReqController>()
                                              .whssSlectedList !=
                                          null) {
                                    forSuspend(context, widget.theme);
                                  } else {
                                    context
                                        .read<StockReqController>()
                                        .remarkscontroller
                                        .text = "";

                                    Get.defaultDialog(
                                      title: "Alert",
                                      middleText:
                                          "Already empty Details here..",
                                      backgroundColor: Colors.white,
                                      titleStyle: widget
                                          .theme.textTheme.bodyLarge!
                                          .copyWith(color: Colors.red),
                                      middleTextStyle:
                                          widget.theme.textTheme.bodyLarge,
                                      radius: 0,
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              child: const Text("Close"),
                                              onPressed: () => Get.back(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ).then((value) {
                                      context
                                          .read<StockReqController>()
                                          .onclickDisable = false;
                                    });
                                  }

                                  context
                                      .read<StockReqController>()
                                      .onclickDisable = false;
                                  context
                                      .read<StockReqController>()
                                      .disableKeyBoard(context);
                                },
                          child: Text(
                            "Clear All",
                            style: widget.theme.textTheme.bodyMedium!
                                .copyWith(color: widget.theme.primaryColor),
                          )),
                    ),
                    SizedBox(
                      height: widget.btnheight * 0.4,
                      width: widget.btnWidth * 0.2,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                color: widget.theme.primaryColor,
                              )),
                          onPressed: context
                                      .read<StockReqController>()
                                      .onclickDisable ==
                                  false
                              ? () async {
                                  await context
                                      .read<StockReqController>()
                                      .removeEmptyList(context);

                                  context
                                      .read<StockReqController>()
                                      .holdButton(context, widget.theme);
                                  context
                                      .read<StockReqController>()
                                      .disableKeyBoard(context);
                                }
                              : null,
                          child: Text(
                            "Hold",
                            style: widget.theme.textTheme.bodyMedium!
                                .copyWith(color: widget.theme.primaryColor),
                          )),
                    ),
                    SizedBox(
                      width: widget.btnWidth * 0.2,
                      height: widget.btnheight * 0.4,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: widget.theme.primaryColor,
                              side: BorderSide(
                                color: widget.theme.primaryColor,
                              )),
                          onPressed: context
                                      .read<StockReqController>()
                                      .onclickDisable ==
                                  true
                              ? null
                              : () async {
                                  context
                                      .read<StockReqController>()
                                      .removeEmptyList(context);

                                  context.read<StockReqController>().saveButton(
                                      context, widget.theme, "Save");
                                  context
                                      .read<StockReqController>()
                                      .disableKeyBoard(context);
                                },
                          child: Text(
                            "Save",
                            textAlign: TextAlign.center,
                            style: widget.theme.textTheme.bodyMedium!
                                .copyWith(color: Colors.white, fontSize: 12),
                          )),
                    )
                  ],
                ),
        ],
      ),
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
                    context
                        .read<StockReqController>()
                        .suspendMethodDB(context, theme, "suspend");
                  },
                  child: Container(
                    width: Screens.width(context) * 0.1,
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
                    width: Screens.width(context) * 0.1,
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
