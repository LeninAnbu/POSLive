import 'package:flutter/material.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import 'package:provider/provider.dart';

import '../../../Controller/PaymentReceiptController/PayReceiptController.dart';
import '../../../Controller/RefundsController/RefundController.dart';

class RefundModeTypeBtns extends StatelessWidget {
  RefundModeTypeBtns({
    super.key,
    // required this.payController,
    required this.theme,
    required this.cashHeight,
    required this.cashWidth,
  });
  double cashHeight;
  double cashWidth;
  final ThemeData theme;
  // PayreceiptController payController;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.only(
          top: cashHeight * 0.01,
          left: cashHeight * 0.01,
          right: cashHeight * 0.01,
          bottom: cashHeight * 0.01),
      width: cashWidth,
      height: cashHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              context.read<RefundController>().nullErrorMsg();

              // if (payController.getpayselect!.length < 1) {
              //   showDialog(
              //       context: context,
              //       barrierDismissible: true,
              //       builder: (BuildContext context) {
              //         return AlertDialog(
              //             contentPadding: EdgeInsets.all(0),
              //             content: AlertBox(
              //                 payMent: 'Alert',
              //                 errormsg: true,
              //                 widget: Center(
              //                     child: ContentContainer(
              //                   content: 'Choose Customer..!!',
              //                   theme: theme,
              //                 )),
              //                 buttonName: null));
              //       });
              // } else {
              context.read<RefundController>().getselectcust == null
                  // ?   context.read<RefundController>().foraccselect(context, theme,"")
                  // : payController.totalduepay == 0
                  //     ? payController.foracctotaldue(context, theme)
                  // :
                  ? showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            contentPadding: const EdgeInsets.all(0),
                            content: AlertBox(
                                payMent: 'Payment Mode - Cash',
                                widget: forCashDialog(context),
                                callback: () {
                                  context
                                      .read<RefundController>()
                                      .addEnteredAmtType(
                                          'Cash', context, 1, theme);
                                },
                                buttonName: "Ok"));
                      })
                  : "";
            },
            child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    top: cashHeight * 0.01,
                    left: cashHeight * 0.01,
                    right: cashHeight * 0.01,
                    bottom: cashHeight * 0.01),
                height: cashHeight * 0.35,
                width: cashWidth * 0.25,
                decoration: BoxDecoration(
                  // color:Colors.green,
                  // color: Colors.grey.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: cashHeight * 0.01, right: cashHeight * 0.01),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: const DecorationImage(
                            image: AssetImage("assets/Cashpng.png"),
                          ),
                        ),
                        alignment: Alignment.center,
                        height: cashHeight * 0.2,
                        width: cashWidth * 0.05,
                      ),
                      Container(
                          // color: Colors.red,
                          alignment: Alignment.centerLeft,
                          // height: cashHeight * 0.13,
                          width: cashWidth * 0.17,
                          child: Text(
                            "Cash",
                            style: theme.textTheme.bodyMedium,
                          )),
                    ])),
          ),
          GestureDetector(
              onTap: () {
                context.read<RefundController>().nullErrorMsg();
                context.read<RefundController>().getselectcust == null
                    // ?   context.read<RefundController>().foraccselect(context, theme,"")
                    // : payController.totalduepay == 0
                    //     ? payController.foracctotaldue(context, theme)
                    // :
                    ? showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder: (context, st) {
                            return AlertDialog(
                                contentPadding: const EdgeInsets.all(0),
                                content: AlertBox(
                                    callback: () {
                                      st(
                                        () {
                                          context
                                              .read<RefundController>()
                                              .addEnteredAmtType(
                                                  'Cheque', context, 2, theme);
                                        },
                                      );
                                    },
                                    payMent: 'Payment Mode - Cheque',
                                    widget: forCheque(
                                      context,
                                    ),
                                    buttonName: 'OK'));
                          });
                        })
                    : "";
              },
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                      left: cashHeight * 0.01, right: cashHeight * 0.01),
                  height: cashHeight * 0.35,
                  width: cashWidth * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            height: cashHeight * 0.2,
                            width: cashWidth * 0.04,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 155, 65, 228),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Icon(
                              Icons.credit_card,
                              color: Colors.white,
                              size: cashHeight * 0.1,
                            )),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: cashWidth * 0.17,
                          child: Text("Cheque",
                              style: theme.textTheme.bodyMedium?.copyWith()),
                        ),
                      ]))),
          GestureDetector(
              onTap: () {
                context.read<RefundController>().nullErrorMsg();
                context.read<RefundController>().getselectcust == null
                    // ?   context.read<RefundController>().foraccselect(context, theme,"")
                    // : payController.totalduepay == 0
                    //     ? payController.foracctotaldue(context, theme)
                    // :
                    ? showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder: (context, st) {
                            return AlertDialog(
                                contentPadding: const EdgeInsets.all(0),
                                content: AlertBox(
                                    callback: () {
                                      st(() {
                                        context
                                            .read<RefundController>()
                                            .addEnteredAmtType(
                                                'Transfer', context, 6, theme);
                                      });
                                    },
                                    payMent: 'Payment Mode - Transfer',
                                    widget: forTransfer(
                                      context,
                                    ),
                                    buttonName: 'OK'));
                          });
                        })
                    : "";
              },
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                      left: cashHeight * 0.01, right: cashHeight * 0.01),
                  height: cashHeight * 0.35,
                  width: cashWidth * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          height: cashHeight * 0.2,
                          width: cashWidth * 0.05,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage("assets/upiicon.png"),
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: cashWidth * 0.17,
                          // color: Colors.red,

                          child: Text("Transfer",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.black)),
                        ),
                      ]))),
        ],
      ),
    );
  }

  forCashDialog(
    BuildContext context,
    // PayreceiptController posC,
  ) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        width: cashWidth * 1.1,
        padding: EdgeInsets.only(
            top: cashHeight * 0.05,
            left: cashHeight * 0.1,
            right: cashHeight * 0.1,
            bottom: cashHeight * 0.1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.watch<RefundController>().getmsgforAmount == null
                  ? ''
                  : "${context.watch<RefundController>().getmsgforAmount}",
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
            ),
            Form(
              key: context.read<RefundController>().formkey[1],
              child: Container(
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.001),
                ),
                child: TextFormField(
                  autofocus: true,
                  controller: context.read<RefundController>().mycontroller[22],
                  cursorColor: Colors.grey,
                  onChanged: (v) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ' Please Enter the Amount';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
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
                    hintText: 'Enter the Amount',
                    hintStyle: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.grey),
                    filled: false,
                    // enabledBorder: InputBorder.none,
                    // focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 25,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  forCheque(
    BuildContext context,
  ) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.only(
            top: cashHeight * 0.05,
            left: cashHeight * 0.05,
            right: cashHeight * 0.05,
            bottom: cashHeight * 0.05),
        width: cashWidth * 1.1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.watch<RefundController>().getmsgforAmount == null
                  ? ''
                  : "${context.watch<RefundController>().getmsgforAmount}",
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
            ),
            Form(
                key: context.read<RefundController>().formkey[2],
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            // height: cashHeight * 0.1,
                            // width: Screens.width(context) * 0.18,
                            child: const Text("Cheque No"),
                          ),
                          Container(
                            // height: cashHeight * 0.2,
                            width: cashWidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              autofocus: true,
                              controller: context
                                  .read<RefundController>()
                                  .mycontroller[23],
                              cursorColor: Colors.grey,
                              style: theme.textTheme.bodyMedium?.copyWith(),
                              onChanged: (v) {},
                              validator: ((value) {
                                if (value!.isEmpty) {
                                  return " Please Enter Cheque Number";
                                } else {
                                  return null;
                                }
                              }),
                              decoration: InputDecoration(
                                filled: false,
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: cashHeight * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            // height: cashHeight * 0.1,
                            child: const Text("Cheque Date"),
                          ),
                          Container(
                            // height: cashHeight * 0.2,
                            width: cashWidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                // st(() {
                                //    context.read<RefundController>().getDate2(context, 'Cheque');
                                // });
                              },
                              child: TextFormField(
                                onTap: () {
                                  context
                                      .read<RefundController>()
                                      .getDate(context, 'Cheque');
                                },
                                autofocus: true,
                                readOnly: true,
                                controller: context
                                    .read<RefundController>()
                                    .mycontroller[24],
                                cursorColor: Colors.grey,
                                style: theme.textTheme.bodyMedium?.copyWith(),
                                onChanged: (v) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '  Please Enter the Cheque Date';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        context
                                            .read<RefundController>()
                                            .getDate(context, 'Cheque');
                                      },
                                      icon: const Icon(Icons.date_range)),
                                  filled: false,
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: cashHeight * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: cashWidth * 0.35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  // height: cashHeight * 0.1,
                                  child: const Text("Amount"),
                                ),
                                IconButton(
                                    onPressed: () {
                                      context
                                          .read<RefundController>()
                                          .cpyBtnclik(25);
                                    },
                                    icon: const Icon(
                                      Icons.copy,
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            // height: cashHeight * 0.2,
                            width: cashWidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              autofocus: true,
                              controller: context
                                  .read<RefundController>()
                                  .mycontroller[25],
                              cursorColor: Colors.grey,
                              style: theme.textTheme.bodyMedium?.copyWith(),
                              onChanged: (v) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ' Please Enter the Amount';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                filled: false,
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: cashHeight * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            // height: cashHeight * 0.1,
                            child: const Text("Remarks"),
                          ),
                          Container(
                            // height: cashHeight * 0.2,
                            width: cashWidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              autofocus: true,
                              controller: context
                                  .read<RefundController>()
                                  .mycontroller[26],
                              cursorColor: Colors.grey,
                              style: theme.textTheme.bodyMedium?.copyWith(),
                              onChanged: (v) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '  Please Enter the Remark';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                filled: false,
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                // enabledBorder: InputBorder.none,
                                // focusedBorder: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ])),

            // ),
          ],
        ),
      );
    });
  }

  forTransfer(
    BuildContext context,
  ) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.only(
            top: cashHeight * 0.02,
            left: cashHeight * 0.1,
            right: cashHeight * 0.1,
            bottom: cashHeight * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.watch<RefundController>().getmsgforAmount == null
                  ? ''
                  : "${context.watch<RefundController>().getmsgforAmount}",
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
            ),
            Form(
              key: context.read<RefundController>().formkey[6],
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          // width: Screens.width(context) * 0.05,
                          child: const Text("Trans Type"),
                        ),
                        Container(
                          width: cashWidth * 0.7,
                          padding: EdgeInsets.only(
                            left: cashHeight * 0.01,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              focusColor: Colors.white,
                              hint: Text(
                                'Select Trans Type',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: context
                                              .read<RefundController>()
                                              .gethintcolor ==
                                          false
                                      ? Colors.grey
                                      : Colors.red,
                                ),
                              ),
                              items: context
                                  .watch<RefundController>()
                                  .gettransType
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value: context
                                  .watch<RefundController>()
                                  .selectedType,
                              onChanged: (value) {
                                st(() {
                                  context
                                      .read<RefundController>()
                                      .selectedType = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          // width: Screens.width(context) * 0.05,
                          child: const Text("Trans Reference"),
                        ),
                        Container(
                          // height: cashHeight * 0.2,
                          width: cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller: context
                                .read<RefundController>()
                                .mycontroller[30],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Please Enter the Trans Reference';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
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
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: cashWidth * 0.35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                // height: cashHeight * 0.1,
                                child: const Text("Amount"),
                              ),
                              IconButton(
                                  onPressed: () {
                                    st(() {
                                      context
                                          .read<RefundController>()
                                          .cpyBtnclik(31);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.copy,
                                    // size: cashHeight * 0.15,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          // height: cashHeight * 0.2,
                          width: cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller: context
                                .read<RefundController>()
                                .mycontroller[31],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Please Enter the Amount';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
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
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ],
        ),
      );
    });
  }

  // forCashConfirm(BuildContext context, ) {
  //   return StatefulBuilder(builder: (context, st) {
  //     return Container(
  //       padding: EdgeInsets.only(
  //         top: cashHeight * 0.01,
  //         left: cashHeight * 0.09,
  //         right: cashHeight * 0.09,
  //       ),
  //       height: cashHeight * 1,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Container(
  //               height: cashHeight * 0.6,
  //               alignment: Alignment.center,
  //               child: Text(
  //                   "Is full amount (Rs. ${context.watch<RefundController>().config.splitValues(context.watch<RefundController>().getBalancePaid().toStringAsFixed(0))})  as Cash")),
  //           Container(
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 GestureDetector(
  //                     onTap: () {
  //                       st(
  //                         () {
  //                           // context.read<RefundController>().fullamt('Cash', context, theme);
  //                         },
  //                       );
  //                     },
  //                     child: Container(
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(5),
  //                         color: Colors.blue,
  //                       ),
  //                       alignment: Alignment.center,
  //                       width: cashWidth * 0.2,
  //                       height: cashHeight * 0.3,
  //                       child: Text(
  //                         "yes",
  //                         style: theme.textTheme.bodyText2
  //                             ?.copyWith(color: Colors.white),
  //                       ),
  //                     )),
  //                 GestureDetector(
  //                     onTap: () {
  //                       Navigator.pop(context);
  // context.read<RefundController>().nullErrorMsg();
  //                       showDialog(
  //                           context: context,
  //                           barrierDismissible: true,
  //                           builder: (BuildContext context) {
  //                             return StatefulBuilder(builder: (context, st) {
  //                               return AlertDialog(
  //                                   contentPadding: EdgeInsets.all(0),
  //                                   content: AlertBox(
  //                                     payMent: 'Payment Mode - Cash',
  //                                     widget: forCashDialog(context, ),
  //                                     buttonName: 'OK',
  //                                     callback: () {
  //                                       st(
  //                                         () {
  //                                               // context.read<RefundController>().addEnteredAmtType(
  //                                               // 'Cash', context, 1, theme);
  //                                         },
  //                                       );
  //                                     },
  //                                   ));
  //                             });
  //                           });
  //                     },
  //                     child: Container(
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(5),
  //                         color: Colors.blue,
  //                       ),
  //                       alignment: Alignment.center,
  //                       width: cashWidth * 0.2,
  //                       height: cashHeight * 0.3,
  //                       child: Text(
  //                         "Partial Amount",
  //                         style: theme.textTheme.bodyText2
  //                             ?.copyWith(color: Colors.white),
  //                       ),
  //                     ))
  //               ],
  //             ),
  //           )
  //         ],
  //       ),
  //     );
  //   });
  // }

  // forDiscount(BuildContext context, payController posC) {
  //   final theme = Theme.of(context);
  //   return StatefulBuilder(builder: (context, st) {
  //     return Container(
  //       width: cashWidth * 1.1,
  //       padding: EdgeInsets.only(
  //           top: cashHeight * 0.02,
  //           left: cashHeight * 0.1,
  //           right: cashHeight * 0.1,
  //           bottom: cashHeight * 0.02),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Container(
  //             child: Text(
  //               posC.getmsgforAmount == null ? '' : "${posC.getmsgforAmount}",
  //               style: theme.textTheme.bodyText2?.copyWith(color: Colors.red),
  //             ),
  //           ),
  //           Container(
  //               child: Form(
  //             key: posC.formkey[9],
  //             child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Container(
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Container(
  //                           alignment: Alignment.centerLeft,
  //                           // width: Screens.width(context) * 0.05,
  //                           child: Text("Discount Type"),
  //                         ),
  //                         Container(
  //                           width: cashWidth * 0.7,
  //                           padding: EdgeInsets.only(
  //                             left: cashHeight * 0.01,
  //                           ),
  //                           decoration: BoxDecoration(
  //                             border: Border.all(color: Colors.grey),
  //                             borderRadius: BorderRadius.circular(3),
  //                             color: Colors.grey.withOpacity(0.01),
  //                           ),
  //                           child: DropdownButtonHideUnderline(
  //                             child: DropdownButton(
  //                               focusColor: Colors.white,
  //                               hint: Text(
  //                                 'Select Discount Type',
  //                                 style: TextStyle(
  //                                   fontSize: 14,
  //                                   color: posC.gethintcolor == false
  //                                       ? Colors.grey
  //                                       : Colors.red,
  //                                 ),
  //                               ),
  //                               items: posC.getdiscountType
  //                                   .map((item) => DropdownMenuItem<String>(
  //                                         value: item,
  //                                         child: Text(
  //                                           item,
  //                                           style: const TextStyle(
  //                                             fontSize: 14,
  //                                           ),
  //                                         ),
  //                                       ))
  //                                   .toList(),
  //                               value: posC.discount,
  //                               onChanged: (value) {
  //                                 st(() {
  //                                   posC.discount = value;
  //                                 });
  //                               },
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(height: cashHeight * 0.05),
  //                   Container(
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Container(
  //                           alignment: Alignment.centerLeft,
  //                           // width: Screens.width(context) * 0.05,
  //                           child: Text("Discount Reference"),
  //                         ),
  //                         Container(
  //                           // height: cashHeight * 0.2,
  //                           width: cashWidth * 0.7,
  //                           decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(3),
  //                             color: Colors.grey.withOpacity(0.01),
  //                           ),
  //                           child: TextFormField(
  //                             controller: posC.mycontroller[41],
  //                             cursorColor: Colors.grey,
  //                             style: theme.textTheme.bodyText2?.copyWith(),
  //                             onChanged: (v) {},
  //                             validator: (value) {
  //                               if (value!.isEmpty) {
  //                                 return ' Please Enter the Discount Reference';
  //                               } else {
  //                                 return null;
  //                               }
  //                             },
  //                             decoration: InputDecoration(
  //                               filled: false,
  //                               focusedErrorBorder: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(5),
  //                                 borderSide: BorderSide(color: Colors.red),
  //                               ),
  //                               errorBorder: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(5),
  //                                 borderSide: BorderSide(color: Colors.red),
  //                               ),
  //                               enabledBorder: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(5),
  //                                 borderSide: BorderSide(color: Colors.grey),
  //                               ),
  //                               focusedBorder: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(5),
  //                                 borderSide: BorderSide(color: Colors.grey),
  //                               ),
  //                               contentPadding: const EdgeInsets.symmetric(
  //                                 vertical: 5,
  //                                 horizontal: 10,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(height: cashHeight * 0.05),
  //                   Container(
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Container(
  //                           width: cashWidth * 0.35,
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Container(
  //                                 alignment: Alignment.centerLeft,
  //                                 // height: cashHeight * 0.1,
  //                                 child: Text("Amount"),
  //                               ),
  //                               IconButton(
  //                                   onPressed: () {
  //                                     posC.cpyBtnclik(42);
  //                                   },
  //                                   icon: Icon(
  //                                     Icons.copy,
  //                                     size: cashHeight * 0.15,
  //                                   )),
  //                             ],
  //                           ),
  //                         ),
  //                         Container(
  //                           // height: cashHeight * 0.2,
  //                           width: cashWidth * 0.7,
  //                           decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(3),
  //                             color: Colors.grey.withOpacity(0.01),
  //                           ),
  //                           child: TextFormField(
  //                             controller: posC.mycontroller[42],
  //                             cursorColor: Colors.grey,
  //                             style: theme.textTheme.bodyText2?.copyWith(),
  //                             onChanged: (v) {},
  //                             validator: (value) {
  //                               if (value!.isEmpty) {
  //                                 return ' Please Enter the Amount';
  //                               } else {
  //                                 return null;
  //                               }
  //                             },
  //                             decoration: InputDecoration(
  //                               filled: false,
  //                               focusedErrorBorder: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(5),
  //                                 borderSide: BorderSide(color: Colors.red),
  //                               ),
  //                               errorBorder: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(5),
  //                                 borderSide: BorderSide(color: Colors.red),
  //                               ),
  //                               enabledBorder: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(5),
  //                                 borderSide: BorderSide(color: Colors.grey),
  //                               ),
  //                               focusedBorder: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(5),
  //                                 borderSide: BorderSide(color: Colors.grey),
  //                               ),
  //                               contentPadding: const EdgeInsets.symmetric(
  //                                 vertical: 5,
  //                                 horizontal: 10,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ]),
  //           )),
  //         ],
  //       ),
  //     );
  //   });
  // }

  forAccBal(BuildContext context, PayreceiptController posC) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        width: cashWidth * 1.1,
        padding: EdgeInsets.only(
            top: cashHeight * 0.02,
            left: cashHeight * 0.1,
            right: cashHeight * 0.1,
            bottom: cashHeight * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              posC.getmsgforAmount == null ? '' : "${posC.getmsgforAmount}",
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
            ),
            Form(
              key: posC.formkey[9],
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          // width: Screens.width(context) * 0.05,
                          child: const Text("Available Balance"),
                        ),
                        Container(
                          // height: cashHeight * 0.2,
                          width: cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            readOnly: true,
                            controller: posC.mycontroller[55],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Please Enter the Account Balance';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
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
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          // width: Screens.width(context) * 0.05,
                          child: const Text("Amount to Adjust"),
                        ),
                        GestureDetector(
                          onTap: () {
                            // posC.getDate(context);
                          },
                          child: Container(
                            // height: cashHeight * 0.2,
                            width: cashWidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              autofocus: true,
                              controller: posC.mycontroller[42],
                              cursorColor: Colors.grey,
                              style: theme.textTheme.bodyMedium?.copyWith(),
                              onChanged: (v) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ' Please Enter the Adjust Amount';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                // suffixIcon: IconButton(
                                //     onPressed: () {
                                //       posC.getDate(context, 'Credit');
                                //     },
                                //     icon: Icon(Icons.date_range)),
                                filled: false,
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
            SizedBox(height: cashHeight * 0.05),
          ],
        ),
      );
    });
  }

  forOnAcc(BuildContext context, PayreceiptController posC) {
    return Container(
        padding: EdgeInsets.only(
            top: cashHeight * 0.1,
            left: cashHeight * 0.1,
            right: cashHeight * 0.1,
            bottom: cashHeight * 0.1),
        child: Form(
          key: posC.formkey[10],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                // width: Screens.width(context) * 0.05,
                child: const Text("Amount"),
              ),
              Container(
                // height: cashHeight * 0.2,
                width: cashWidth * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.01),
                ),
                child: TextFormField(
                  autofocus: true,
                  controller: posC.mycontroller[45],
                  cursorColor: Colors.grey,
                  style: theme.textTheme.bodyMedium?.copyWith(),
                  onChanged: (v) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ' Please Enter the Amount';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
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
            ],
          ),
        ));
  }
}
