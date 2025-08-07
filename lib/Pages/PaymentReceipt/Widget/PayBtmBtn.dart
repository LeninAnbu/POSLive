import 'package:flutter/material.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import 'package:provider/provider.dart';
import '../../../Constant/Screen.dart';
import '../../../Controller/PaymentReceiptController/PayReceiptController.dart';

class PayBtmBtn extends StatefulWidget {
  PayBtmBtn({
    super.key,
    required this.theme,
    required this.btnWidth,
    required this.btnheight,
  });

  final ThemeData theme;
  double btnheight;
  double btnWidth;

  @override
  State<PayBtmBtn> createState() => _PayBtmBtnState();
}

class _PayBtmBtnState extends State<PayBtmBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: widget.btnheight * 0.03,
        left: widget.btnheight * 0.03,
        right: widget.btnheight * 0.03,
        bottom: widget.btnheight * 0.03,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      height: widget.btnheight,
      width: widget.btnWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(widget.btnheight * 0.01),
                child: Text(
                  context.read<PayreceiptController>().getpaymentWay.isNotEmpty
                      ? "Payment Method"
                      : '',
                  textAlign: TextAlign.start,
                  style: widget.theme.textTheme.bodyMedium?.copyWith(
                    color: widget.theme.primaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: widget.btnheight * 0.65,
                child: context
                        .read<PayreceiptController>()
                        .getpaymentWay2
                        .isNotEmpty
                    ? ListView.builder(
                        itemCount: context
                            .read<PayreceiptController>()
                            .getpaymentWay2
                            .length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Card(
                              elevation: 2,
                              child: Container(
                                  padding: EdgeInsets.only(
                                    right: widget.btnheight * 0.03,
                                    left: widget.btnheight * 0.03,
                                    bottom: widget.btnheight * 0.03,
                                    top: widget.btnheight * 0.03,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: widget.btnWidth * 0.25,
                                        child: Text(
                                          '${context.watch<PayreceiptController>().getpaymentWay2[index].type}',
                                          style: widget
                                              .theme.textTheme.bodyMedium
                                              ?.copyWith(color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        width: widget.btnWidth * 0.28,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '${context.watch<PayreceiptController>().getpaymentWay2[index].reference}',
                                          style: widget
                                              .theme.textTheme.bodyMedium
                                              ?.copyWith(color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          context
                                              .read<PayreceiptController>()
                                              .config
                                              .splitValues(context
                                                  .read<PayreceiptController>()
                                                  .getpaymentWay2[index]
                                                  .amt!
                                                  .toStringAsFixed(2)),
                                          style: widget
                                              .theme.textTheme.bodyMedium
                                              ?.copyWith(color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        width: widget.btnWidth * 0.05,
                                      ),
                                    ],
                                  )),
                            ),
                          );
                        })
                    : ListView.builder(
                        itemCount: context
                            .watch<PayreceiptController>()
                            .getpaymentWay
                            .length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Card(
                              elevation: 2,
                              child: Container(
                                  padding: EdgeInsets.only(
                                    right: widget.btnheight * 0.03,
                                    left: widget.btnheight * 0.03,
                                    bottom: widget.btnheight * 0.03,
                                    top: widget.btnheight * 0.03,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: widget.btnWidth * 0.25,
                                        child: Text(
                                          '${context.watch<PayreceiptController>().getpaymentWay[index].type}',
                                          style: widget
                                              .theme.textTheme.bodyMedium
                                              ?.copyWith(color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        width: widget.btnWidth * 0.28,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '${context.watch<PayreceiptController>().getpaymentWay[index].reference}',
                                          style: widget
                                              .theme.textTheme.bodyMedium
                                              ?.copyWith(color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          context
                                              .read<PayreceiptController>()
                                              .config
                                              .splitValues22(context
                                                  .watch<PayreceiptController>()
                                                  .getpaymentWay[index]
                                                  .amt!
                                                  .toString()),
                                          style: widget
                                              .theme.textTheme.bodyMedium
                                              ?.copyWith(color: Colors.black),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          context
                                              .read<PayreceiptController>()
                                              .removePayment(index);
                                        },
                                        child: SizedBox(
                                          width: widget.btnWidth * 0.05,
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          );
                        }),
              ),
            ],
          ),
          SizedBox(height: widget.btnheight * 0.01),
          context.read<PayreceiptController>().selectedcust2 != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        onTap: () async {
                          await context
                              .read<PayreceiptController>()
                              .clearpayData();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: widget.btnheight * 0.15,
                          width: widget.btnWidth * 0.25,
                          child: Text("Clear",
                              style:
                                  widget.theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.black,
                              )),
                        )),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: widget.btnheight * 0.15,
                      width: widget.btnWidth * 0.25,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                color: widget.theme.primaryColor,
                              )),
                          onPressed: context
                                      .read<PayreceiptController>()
                                      .ondDisablebutton ==
                                  true
                              ? null
                              : () {
                                  context
                                      .read<PayreceiptController>()
                                      .ondDisablebutton = true;
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                            builder: (context, setState) {
                                          return AlertDialog(
                                              contentPadding:
                                                  const EdgeInsets.all(0),
                                              content: AlertBox(
                                                payMent: 'Suspended',
                                                widget: forSuspend(context),
                                                buttonName: null,
                                                callback: () {
                                                  Navigator.pop(context);
                                                },
                                              ));
                                        });
                                      }).then((value) {
                                    context
                                        .read<PayreceiptController>()
                                        .ondDisablebutton = false;
                                  });
                                },
                          child: Text(
                            "Clear All",
                            style: widget.theme.textTheme.bodyMedium!
                                .copyWith(color: widget.theme.primaryColor),
                          )),
                    ),
                    SizedBox(
                      height: widget.btnheight * 0.15,
                      width: widget.btnWidth * 0.25,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                color: widget.theme.primaryColor,
                              )),
                          onPressed: context
                                      .read<PayreceiptController>()
                                      .ondDisablebutton ==
                                  true
                              ? null
                              : () {
                                  context
                                      .read<PayreceiptController>()
                                      .onHoldClicked(context, widget.theme);
                                },
                          child: Text(
                            "Hold",
                            style: widget.theme.textTheme.bodyMedium!
                                .copyWith(color: widget.theme.primaryColor),
                          )),
                    ),
                    SizedBox(
                      height: widget.btnheight * 0.15,
                      width: widget.btnWidth * 0.25,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: widget.theme.primaryColor,
                              side: BorderSide(
                                color: widget.theme.primaryColor,
                              )),
                          onPressed: context
                                      .read<PayreceiptController>()
                                      .ondDisablebutton ==
                                  true
                              ? null
                              : () {
                                  context
                                      .read<PayreceiptController>()
                                      .submitted(context, widget.theme);
                                },
                          child: Text(
                            "Submit",
                            style: widget.theme.textTheme.bodyMedium!
                                .copyWith(color: Colors.white),
                          )),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  forSuspend(
    BuildContext context,
  ) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: Screens.width(context) * 0.02,
            vertical: Screens.bodyheight(context) * 0.005),
        child: Column(
          children: [
            SizedBox(
                height: widget.btnheight * 0.25,
                child: const Center(
                    child: Text(
                        "You about to suspended all information will be unsaved  "))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: Screens.width(context) * 0.15,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        context
                            .read<PayreceiptController>()
                            .clearSuspendedData(context, widget.theme);
                      },
                      child: const Text("Yes")),
                ),
                SizedBox(
                  width: Screens.width(context) * 0.15,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("No")),
                ),
              ],
            )
          ],
        ));
  }
}
