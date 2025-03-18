import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import 'package:posproject/main.dart';
import 'package:provider/provider.dart';
import '../../../Controller/SalesOrderController/SalesOrderController.dart';
import '../../../Widgets/ContentContainer.dart';
import '../../SalesQuotation/Widgets/ItemLists.dart';

class POCashWidget extends StatefulWidget {
  POCashWidget({
    super.key,
    required this.theme,
    required this.cashHeight,
    required this.cashWidth,
  });
  double cashHeight;
  double cashWidth;
  final ThemeData theme;

  @override
  State<POCashWidget> createState() => _POCashWidgetState();
}

class _POCashWidgetState extends State<POCashWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.only(
          top: widget.cashHeight * 0.01,
          left: widget.cashHeight * 0.01,
          right: widget.cashHeight * 0.01,
          bottom: widget.cashHeight * 0.01),
      width: widget.cashWidth,
      height: widget.cashHeight,
      child: context.read<SOCon>().editqty == true
          ? Center(
              child: SizedBox(
                height: widget.cashHeight * 0.29,
                width: widget.cashWidth * 0.25,
                child: GestureDetector(
                    onTap: context.read<SOCon>().userTypes == 'corporate'
                        ? null
                        : () async {
                            context.read<SOCon>().nullErrorMsg();

                            if (context.read<SOCon>().selectedcust == null) {
                              showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        contentPadding: const EdgeInsets.all(0),
                                        content: AlertBox(
                                            payMent: 'Alert',
                                            errormsg: true,
                                            widget: Center(
                                                child: ContentContainer(
                                              content: 'Choose cusotmer..!!',
                                              theme: widget.theme,
                                            )),
                                            buttonName: null));
                                  });
                            } else if (context
                                .read<SOCon>()
                                .getScanneditemData
                                .isEmpty) {
                              showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        contentPadding: const EdgeInsets.all(0),
                                        content: AlertBox(
                                            payMent: 'Alert',
                                            errormsg: true,
                                            widget: Center(
                                                child: ContentContainer(
                                              content: 'Choose Product..!!',
                                              theme: widget.theme,
                                            )),
                                            buttonName: null));
                                  });
                            } else {
                              context.read<SOCon>().schemebtnclk = true;
                              await context
                                  .read<SOCon>()
                                  .scehmeapiforckout(context, widget.theme);
                            }
                            context.read<SOCon>().disableKeyBoard(context);
                          },
                    child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                            left: widget.cashHeight * 0.01,
                            right: widget.cashHeight * 0.01),
                        height: widget.cashHeight * 0.29,
                        width: widget.cashWidth * 0.25,
                        decoration: BoxDecoration(
                          color: context.read<SOCon>().userTypes == 'corporate'
                              ? Colors.grey[300]
                              : widget.theme.primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              height: widget.cashHeight * 0.4,
                              width: widget.cashWidth * 0.05,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage("assets/disssccimg.png"),
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            SizedBox(
                              width: widget.cashWidth * 0.17,
                              child: Text("Scheme",
                                  style: widget.theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.black)),
                            ),
                          ],
                        ))),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: context.read<SOCon>().selectedcust != null &&
                              context.read<SOCon>().selectedcust!.U_CashCust !=
                                  null &&
                              context.read<SOCon>().selectedcust!.U_CashCust !=
                                  'YES'
                          ? null
                          : () {
                              context.read<SOCon>().nullErrorMsg();

                              if (context
                                  .read<SOCon>()
                                  .getScanneditemData
                                  .isEmpty) {
                                showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          content: AlertBox(
                                              payMent: 'Alert',
                                              errormsg: true,
                                              widget: Center(
                                                  child: ContentContainer(
                                                content: 'Choose Product..!!',
                                                theme: widget.theme,
                                              )),
                                              buttonName: null));
                                    });
                              } else {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                          builder: (context, st) {
                                        return AlertDialog(
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            content: AlertBox(
                                              payMent: 'Payment Mode - Cash',
                                              widget: forCashDialog(context),
                                              buttonName: 'OK',
                                              callback: () {
                                                st(
                                                  () {
                                                    context
                                                        .read<SOCon>()
                                                        .addEnteredAmtType(
                                                            'Cash',
                                                            context,
                                                            1,
                                                            widget.theme);
                                                  },
                                                );
                                              },
                                            ));
                                      });
                                    });
                              }
                              context.read<SOCon>().disableKeyBoard(context);
                            },
                      child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                              top: widget.cashHeight * 0.01,
                              left: widget.cashHeight * 0.01,
                              right: widget.cashHeight * 0.01,
                              bottom: widget.cashHeight * 0.01),
                          height: widget.cashHeight * 0.29,
                          width: widget.cashWidth * 0.25,
                          decoration: BoxDecoration(
                            color: context.read<SOCon>().selectedcust != null &&
                                    context
                                            .read<SOCon>()
                                            .selectedcust!
                                            .U_CashCust !=
                                        null &&
                                    context
                                            .read<SOCon>()
                                            .selectedcust!
                                            .U_CashCust !=
                                        'YES'
                                ? Colors.grey.withOpacity(0.2)
                                : widget.theme.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: widget.cashHeight * 0.01,
                                      right: widget.cashHeight * 0.01),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: const DecorationImage(
                                      image: AssetImage("assets/Cashpng.png"),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  height: widget.cashHeight * 0.13,
                                  width: widget.cashWidth * 0.05,
                                ),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    width: widget.cashWidth * 0.17,
                                    child: Text(
                                      "Cash",
                                      style: widget.theme.textTheme.bodyMedium,
                                    )),
                              ])),
                    ),
                    GestureDetector(
                        onTap: context.read<SOCon>().selectedcust != null &&
                                context
                                        .read<SOCon>()
                                        .selectedcust!
                                        .U_CashCust !=
                                    null &&
                                context
                                        .read<SOCon>()
                                        .selectedcust!
                                        .U_CashCust !=
                                    'YES'
                            ? null
                            : () {
                                context.read<SOCon>().nullErrorMsg();
                                context.read<SOCon>().selectedBankType = null;
                                if (context
                                    .read<SOCon>()
                                    .getScanneditemData
                                    .isEmpty) {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            content: AlertBox(
                                                payMent: 'Alert',
                                                errormsg: true,
                                                widget: Center(
                                                    child: ContentContainer(
                                                  content: 'Choose Product..!!',
                                                  theme: widget.theme,
                                                )),
                                                buttonName: null));
                                      });
                                } else {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                            builder: (context, st) {
                                          return AlertDialog(
                                              contentPadding:
                                                  const EdgeInsets.all(0),
                                              content: AlertBox(
                                                  callback: () {
                                                    st(
                                                      () {
                                                        context
                                                            .read<SOCon>()
                                                            .addEnteredAmtType(
                                                                'Cheque',
                                                                context,
                                                                2,
                                                                widget.theme);
                                                      },
                                                    );
                                                  },
                                                  payMent:
                                                      'Payment Mode - Cheque',
                                                  widget: forCheque(context),
                                                  buttonName: 'OK'));
                                        });
                                      });
                                }
                                context.read<SOCon>().disableKeyBoard(context);
                              },
                        child: Container(
                            alignment: Alignment.center,
                            padding:
                                EdgeInsets.only(
                                    left: widget.cashHeight * 0.01,
                                    right: widget.cashHeight * 0.01),
                            height: widget.cashHeight * 0.29,
                            width: widget.cashWidth * 0.25,
                            decoration: BoxDecoration(
                              color: context.read<SOCon>().selectedcust !=
                                          null &&
                                      context
                                              .read<SOCon>()
                                              .selectedcust!
                                              .U_CashCust !=
                                          null &&
                                      context
                                              .read<SOCon>()
                                              .selectedcust!
                                              .U_CashCust !=
                                          'YES'
                                  ? Colors.grey.withOpacity(0.2)
                                  : widget.theme.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      height: widget.cashHeight * 0.13,
                                      width: widget.cashWidth * 0.04,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 155, 65, 228),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Icon(
                                        Icons.credit_card,
                                        color: Colors.white,
                                        size: widget.cashHeight * 0.1,
                                      )),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: widget.cashWidth * 0.17,
                                    child: Text("Cheque",
                                        style: widget.theme.textTheme.bodyMedium
                                            ?.copyWith()),
                                  ),
                                ]))),
                    GestureDetector(
                        onTap: context.read<SOCon>().selectedcust != null &&
                                context
                                        .read<SOCon>()
                                        .selectedcust!
                                        .U_CashCust !=
                                    null &&
                                context
                                        .read<SOCon>()
                                        .selectedcust!
                                        .U_CashCust !=
                                    'YES'
                            ? null
                            : () {
                                context.read<SOCon>().nullErrorMsg();
                                if (context
                                    .read<SOCon>()
                                    .getScanneditemData
                                    .isEmpty) {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            content: AlertBox(
                                                payMent: 'Alert',
                                                errormsg: true,
                                                widget: Center(
                                                    child: ContentContainer(
                                                  content: 'Choose Product..!!',
                                                  theme: widget.theme,
                                                )),
                                                buttonName: null));
                                      });
                                } else {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                            builder: (context, st) {
                                          return AlertDialog(
                                              contentPadding:
                                                  const EdgeInsets.all(0),
                                              content: AlertBox(
                                                callback: () {
                                                  st(
                                                    () {
                                                      context
                                                          .read<SOCon>()
                                                          .addEnteredAmtType(
                                                              'Card',
                                                              context,
                                                              3,
                                                              widget.theme);
                                                    },
                                                  );
                                                },
                                                payMent: 'Payment Mode - Card',
                                                widget:
                                                    forCard(context, "Card"),
                                                buttonName: 'OK',
                                              ));
                                        });
                                      });
                                }
                                context.read<SOCon>().disableKeyBoard(context);
                              },
                        child: Container(
                            alignment: Alignment.center,
                            padding:
                                EdgeInsets.only(
                                    left: widget.cashHeight * 0.01,
                                    right: widget.cashHeight * 0.01),
                            height: widget.cashHeight * 0.29,
                            width: widget.cashWidth * 0.25,
                            decoration: BoxDecoration(
                              color: context.read<SOCon>().selectedcust !=
                                          null &&
                                      context
                                              .read<SOCon>()
                                              .selectedcust!
                                              .U_CashCust !=
                                          null &&
                                      context
                                              .read<SOCon>()
                                              .selectedcust!
                                              .U_CashCust !=
                                          'YES'
                                  ? Colors.grey.withOpacity(0.2)
                                  : widget.theme.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height: widget.cashHeight * 0.12,
                                    width: widget.cashWidth * 0.05,
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                        image:
                                            AssetImage("assets/creditIcon.png"),
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: widget.cashWidth * 0.17,
                                    child: Text("Card",
                                        style: widget.theme.textTheme.bodyMedium
                                            ?.copyWith(color: Colors.black)),
                                  ),
                                ]))),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: context.read<SOCon>().selectedcust != null &&
                                context
                                        .read<SOCon>()
                                        .selectedcust!
                                        .U_CashCust !=
                                    null &&
                                context
                                        .read<SOCon>()
                                        .selectedcust!
                                        .U_CashCust !=
                                    'YES'
                            ? null
                            : () {
                                context.read<SOCon>().nullErrorMsg();
                                if (context
                                    .read<SOCon>()
                                    .getScanneditemData
                                    .isEmpty) {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            content: AlertBox(
                                                payMent: 'Alert',
                                                errormsg: true,
                                                widget: Center(
                                                    child: ContentContainer(
                                                  content: 'Choose Product..!!',
                                                  theme: widget.theme,
                                                )),
                                                buttonName: null));
                                      });
                                } else {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                            builder: (context, st) {
                                          return AlertDialog(
                                              contentPadding:
                                                  const EdgeInsets.all(0),
                                              content: AlertBox(
                                                  callback: () {
                                                    st(() {
                                                      context
                                                          .read<SOCon>()
                                                          .addEnteredAmtType(
                                                              'Wallet',
                                                              context,
                                                              5,
                                                              widget.theme);
                                                    });
                                                  },
                                                  payMent:
                                                      'Payment Mode - Wallet',
                                                  widget: forwallet(context),
                                                  buttonName: 'OK'));
                                        });
                                      });
                                }
                                context.read<SOCon>().disableKeyBoard(context);
                              },
                        child: Container(
                            alignment: Alignment.center,
                            padding:
                                EdgeInsets.only(
                                    left: widget.cashHeight * 0.01,
                                    right: widget.cashHeight * 0.01),
                            height: widget.cashHeight * 0.29,
                            width: widget.cashWidth * 0.25,
                            decoration: BoxDecoration(
                              color: context.read<SOCon>().selectedcust !=
                                          null &&
                                      context
                                              .read<SOCon>()
                                              .selectedcust!
                                              .U_CashCust !=
                                          null &&
                                      context
                                              .read<SOCon>()
                                              .selectedcust!
                                              .U_CashCust !=
                                          'YES'
                                  ? Colors.grey.withOpacity(0.2)
                                  : widget.theme.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height: widget.cashHeight * 0.12,
                                    width: widget.cashWidth * 0.05,
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                        image: AssetImage("assets/NetIcon.png"),
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: widget.cashWidth * 0.17,
                                    child: Text("Wallet",
                                        style: widget.theme.textTheme.bodyMedium
                                            ?.copyWith(color: Colors.black)),
                                  ),
                                ]))),
                    GestureDetector(
                        onTap: context.read<SOCon>().selectedcust != null &&
                                context
                                        .read<SOCon>()
                                        .selectedcust!
                                        .U_CashCust !=
                                    null &&
                                context
                                        .read<SOCon>()
                                        .selectedcust!
                                        .U_CashCust !=
                                    'YES'
                            ? null
                            : () {
                                context.read<SOCon>().nullErrorMsg();
                                if (context
                                    .read<SOCon>()
                                    .getScanneditemData
                                    .isEmpty) {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            content: AlertBox(
                                                payMent: 'Alert',
                                                errormsg: true,
                                                widget: Center(
                                                    child: ContentContainer(
                                                  content: 'Choose Product..!!',
                                                  theme: widget.theme,
                                                )),
                                                buttonName: null));
                                      });
                                } else {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                            builder: (context, st) {
                                          return AlertDialog(
                                              contentPadding:
                                                  const EdgeInsets.all(0),
                                              content: AlertBox(
                                                  callback: () {
                                                    st(() {
                                                      context
                                                          .read<SOCon>()
                                                          .addEnteredAmtType(
                                                              'Transfer',
                                                              context,
                                                              4,
                                                              widget.theme);
                                                    });
                                                  },
                                                  payMent:
                                                      'Payment Mode - Transfer',
                                                  widget: forTransfer(context),
                                                  buttonName: 'OK'));
                                        });
                                      });
                                }
                                context.read<SOCon>().disableKeyBoard(context);
                              },
                        child: Container(
                            alignment: Alignment.center,
                            padding:
                                EdgeInsets.only(
                                    left: widget.cashHeight * 0.01,
                                    right: widget.cashHeight * 0.01),
                            height: widget.cashHeight * 0.29,
                            width: widget.cashWidth * 0.25,
                            decoration: BoxDecoration(
                              color: context.read<SOCon>().selectedcust !=
                                          null &&
                                      context
                                              .read<SOCon>()
                                              .selectedcust!
                                              .U_CashCust !=
                                          null &&
                                      context
                                              .read<SOCon>()
                                              .selectedcust!
                                              .U_CashCust !=
                                          'YES'
                                  ? Colors.grey.withOpacity(0.2)
                                  : widget.theme.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height: widget.cashHeight * 0.12,
                                    width: widget.cashWidth * 0.05,
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                        image: AssetImage("assets/upiicon.png"),
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: widget.cashWidth * 0.17,
                                    child: Text("Transfer",
                                        style: widget.theme.textTheme.bodyMedium
                                            ?.copyWith(color: Colors.black)),
                                  ),
                                ]))),
                    GestureDetector(
                        onTap: context.read<SOCon>().userTypes == 'corporate'
                            ? null
                            : () async {
                                context.read<SOCon>().nullErrorMsg();

                                if (context.read<SOCon>().selectedcust ==
                                    null) {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            content: AlertBox(
                                                payMent: 'Alert',
                                                errormsg: true,
                                                widget: Center(
                                                    child: ContentContainer(
                                                  content:
                                                      'Choose cusotmer..!!',
                                                  theme: widget.theme,
                                                )),
                                                buttonName: null));
                                      });
                                } else if (context
                                    .read<SOCon>()
                                    .getScanneditemData
                                    .isEmpty) {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            content: AlertBox(
                                                payMent: 'Alert',
                                                errormsg: true,
                                                widget: Center(
                                                    child: ContentContainer(
                                                  content: 'Choose Product..!!',
                                                  theme: widget.theme,
                                                )),
                                                buttonName: null));
                                      });
                                } else {
                                  context.read<SOCon>().schemebtnclk = true;
                                  await context
                                      .read<SOCon>()
                                      .scehmeapiforckout(context, widget.theme);
                                }
                                context.read<SOCon>().disableKeyBoard(context);
                              },
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(
                                left: widget.cashHeight * 0.01,
                                right: widget.cashHeight * 0.01),
                            height: widget.cashHeight * 0.29,
                            width: widget.cashWidth * 0.25,
                            decoration: BoxDecoration(
                              color: context.read<SOCon>().userTypes ==
                                      'corporate'
                                  ? Colors.grey[300]
                                  : widget.theme.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: widget.cashHeight * 0.4,
                                  width: widget.cashWidth * 0.05,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image:
                                          AssetImage("assets/disssccimg.png"),
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                SizedBox(
                                  width: widget.cashWidth * 0.17,
                                  child: Text("Scheme",
                                      style: widget.theme.textTheme.bodyMedium
                                          ?.copyWith(color: Colors.black)),
                                ),
                              ],
                            ))),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: context.read<SOCon>().selectedcust != null &&
                              context.read<SOCon>().selectedcust!.U_CashCust !=
                                  null &&
                              context.read<SOCon>().selectedcust!.U_CashCust !=
                                  'YES'
                          ? null
                          : () {
                              context.read<SOCon>().nullErrorMsg();
                              if (context.read<SOCon>().getselectedcust ==
                                  null) {
                                showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          content: AlertBox(
                                            payMent: 'Alert',
                                            errormsg: true,
                                            widget: Center(
                                                child: ContentContainer(
                                              content: 'Choose customer..!!',
                                              theme: widget.theme,
                                            )),
                                            buttonName: null,
                                          ));
                                    });
                              } else if (context
                                  .read<SOCon>()
                                  .getScanneditemData
                                  .isEmpty) {
                                showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          content: AlertBox(
                                              payMent: 'Alert',
                                              errormsg: true,
                                              widget: Center(
                                                  child: ContentContainer(
                                                content: 'Choose Product..!!',
                                                theme: widget.theme,
                                              )),
                                              buttonName: null));
                                    });
                              } else {
                                context.read<SOCon>().mycontroller[37].text =
                                    context
                                        .read<SOCon>()
                                        .getselectedcust!
                                        .point!;
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                          builder: (context, st) {
                                        return AlertDialog(
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            content: AlertBox(
                                              callback: () {
                                                st(() {
                                                  context
                                                      .read<SOCon>()
                                                      .addEnteredAmtType(
                                                          'Points Redemption',
                                                          context,
                                                          8,
                                                          widget.theme);
                                                });
                                              },
                                              buttonName: 'OK',
                                              payMent:
                                                  'Payment Mode - Points Redemption',
                                              widget: forPoints(context),
                                            ));
                                      });
                                    });
                              }
                              context.read<SOCon>().disableKeyBoard(context);
                            },
                      child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                              left: widget.cashHeight * 0.01,
                              right: widget.cashHeight * 0.01),
                          height: widget.cashHeight * 0.29,
                          width: widget.cashWidth * 0.25,
                          decoration: BoxDecoration(
                            color: context.read<SOCon>().selectedcust != null &&
                                    context
                                            .read<SOCon>()
                                            .selectedcust!
                                            .U_CashCust !=
                                        null &&
                                    context
                                            .read<SOCon>()
                                            .selectedcust!
                                            .U_CashCust !=
                                        'YES'
                                ? Colors.grey.withOpacity(0.2)
                                : widget.theme.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text("Point Redemption",
                              style: widget.theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.black))),
                    ),
                    GestureDetector(
                      onTap: context.read<SOCon>().selectedcust != null &&
                              context.read<SOCon>().selectedcust!.U_CashCust !=
                                  null &&
                              context.read<SOCon>().selectedcust!.U_CashCust ==
                                  'YES'
                          ? null
                          : () {
                              context.read<SOCon>().nullErrorMsg();

                              if (context.read<SOCon>().selectedcust == null) {
                                showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          content: AlertBox(
                                              payMent: 'Alert',
                                              errormsg: true,
                                              widget: Center(
                                                  child: ContentContainer(
                                                content: 'Choose Customer..!!',
                                                theme: widget.theme,
                                              )),
                                              buttonName: null));
                                    });
                              } else if (context
                                  .read<SOCon>()
                                  .getScanneditemData
                                  .isEmpty) {
                                showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          content: AlertBox(
                                              payMent: 'Alert',
                                              errormsg: true,
                                              widget: Center(
                                                  child: ContentContainer(
                                                content: 'Choose Product..!!',
                                                theme: widget.theme,
                                              )),
                                              buttonName: null));
                                    });
                              } else {
                                context.read<SOCon>().mycontroller[35].text =
                                    config.splitValues(context
                                        .read<SOCon>()
                                        .selectedcust!
                                        .accBalance!
                                        .toStringAsFixed(2));
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                          builder: (context, st) {
                                        return AlertDialog(
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            content: AlertBox(
                                              payMent:
                                                  'Payment Mode - Account Balance',
                                              widget: forAccBal(context),
                                              buttonName: 'OK',
                                              callback: () {
                                                st(() {
                                                  context.read<SOCon>().adjamt(
                                                      context, widget.theme);
                                                });
                                              },
                                            ));
                                      });
                                    });
                              }
                              context.read<SOCon>().disableKeyBoard(context);
                            },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                            left: widget.cashHeight * 0.01,
                            right: widget.cashHeight * 0.01),
                        height: widget.cashHeight * 0.29,
                        width: widget.cashWidth * 0.25,
                        decoration: BoxDecoration(
                          color: context.read<SOCon>().selectedcust != null &&
                                  context
                                          .read<SOCon>()
                                          .selectedcust!
                                          .U_CashCust !=
                                      null &&
                                  context
                                          .read<SOCon>()
                                          .selectedcust!
                                          .U_CashCust ==
                                      'YES'
                              ? Colors.grey.withOpacity(0.2)
                              : widget.theme.primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text("Account Balance",
                            style: widget.theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.black)),
                      ),
                    ),
                    GestureDetector(
                        onTap: context.read<SOCon>().selectedcust != null &&
                                context
                                        .read<SOCon>()
                                        .selectedcust!
                                        .U_CashCust !=
                                    null &&
                                context
                                        .read<SOCon>()
                                        .selectedcust!
                                        .U_CashCust ==
                                    'YES'
                            ? null
                            : () {
                                context.read<SOCon>().nullErrorMsg();
                                if (context
                                    .read<SOCon>()
                                    .getScanneditemData
                                    .isEmpty) {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            content: AlertBox(
                                                payMent: 'Alert',
                                                errormsg: true,
                                                widget: Center(
                                                    child: ContentContainer(
                                                  content: 'Choose Product..!!',
                                                  theme: widget.theme,
                                                )),
                                                buttonName: null));
                                      });
                                } else {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                            builder: (context, st) {
                                          return AlertDialog(
                                              contentPadding:
                                                  const EdgeInsets.all(0),
                                              content: AlertBox(
                                                  callback: () {
                                                    st(() {
                                                      context
                                                          .read<SOCon>()
                                                          .addEnteredAmtType(
                                                              'Credit',
                                                              context,
                                                              10,
                                                              widget.theme);
                                                    });
                                                  },
                                                  payMent:
                                                      'Payment Mode - Credit',
                                                  widget: forCredit(
                                                    context,
                                                  ),
                                                  buttonName: 'OK'));
                                        });
                                      });
                                }
                                context.read<SOCon>().disableKeyBoard(context);
                              },
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(
                                left: widget.cashHeight * 0.01,
                                right: widget.cashHeight * 0.01),
                            height: widget.cashHeight * 0.29,
                            width: widget.cashWidth * 0.25,
                            decoration: BoxDecoration(
                              color: context.read<SOCon>().selectedcust !=
                                          null &&
                                      context
                                              .read<SOCon>()
                                              .selectedcust!
                                              .U_CashCust !=
                                          null &&
                                      context
                                              .read<SOCon>()
                                              .selectedcust!
                                              .U_CashCust ==
                                          'YES'
                                  ? Colors.grey.withOpacity(0.2)
                                  : widget.theme.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text("Credit",
                                style: widget.theme.textTheme.bodyMedium
                                    ?.copyWith(color: Colors.black))))
                  ],
                ),
              ],
            ),
    );
  }

  forCashDialog(BuildContext context) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        width: widget.cashWidth * 1.1,
        padding: EdgeInsets.only(
            top: widget.cashHeight * 0.05,
            left: widget.cashWidth * 0.05,
            right: widget.cashWidth * 0.01,
            bottom: widget.cashHeight * 0.1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.read<SOCon>().getmsgforAmount == null
                  ? ''
                  : "${context.watch<SOCon>().getmsgforAmount}",
              style: widget.theme.textTheme.bodyMedium
                  ?.copyWith(color: Colors.red),
            ),
            Form(
              key: context.read<SOCon>().formkey[1],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: widget.cashHeight * 0.03),
                  Row(
                    children: [
                      const Text('Amount'),
                      SizedBox(width: widget.cashWidth * 0.02),
                      IconButton(
                          onPressed: () {
                            context.read<SOCon>().cpyBtnclik(22);
                          },
                          icon: const Icon(
                            Icons.copy,
                          )),
                      SizedBox(width: widget.cashWidth * 0.04),
                      Container(
                        width: widget.cashWidth * 0.7,
                        alignment: Alignment.centerRight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.grey.withOpacity(0.001),
                        ),
                        child: TextFormField(
                          autofocus: true,
                          controller: context.read<SOCon>().mycontroller[22],
                          cursorColor: Colors.grey,
                          keyboardType: TextInputType.number,
                          inputFormatters: [DecimalInputFormatter()],
                          onChanged: (v) {
                            context
                                .read<SOCon>()
                                .doubleDotMethodPayTerms(22, v);
                          },
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
                            hintStyle: widget.theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey),
                            filled: false,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  forCheque(BuildContext context) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.only(
            top: widget.cashHeight * 0.05,
            left: widget.cashHeight * 0.05,
            right: widget.cashHeight * 0.05,
            bottom: widget.cashHeight * 0.05),
        width: widget.cashWidth * 1.1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.read<SOCon>().getmsgforAmount == null
                  ? ''
                  : "${context.watch<SOCon>().getmsgforAmount}",
              style: widget.theme.textTheme.bodyMedium
                  ?.copyWith(color: Colors.red),
            ),
            Form(
                key: context.read<SOCon>().formkey[2],
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: widget.cashHeight * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text("Cheque No"),
                          ),
                          Container(
                            width: widget.cashWidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              autofocus: true,
                              maxLength: 6,
                              controller:
                                  context.read<SOCon>().mycontroller[23],
                              cursorColor: Colors.grey,
                              style:
                                  widget.theme.textTheme.bodyMedium?.copyWith(),
                              onChanged: (v) {},
                              validator: ((value) {
                                if (value!.isEmpty) {
                                  return " Please Enter Cheque Number";
                                } else if (value.length < 6) {
                                  return " Please Enter a 6 digit Cheque Number";
                                } else {
                                  return null;
                                }
                              }),
                              decoration: InputDecoration(
                                counterText: '',
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
                      SizedBox(height: widget.cashHeight * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text("Cheque Date"),
                          ),
                          Container(
                            width: widget.cashWidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              onTap: () {
                                context
                                    .read<SOCon>()
                                    .getDate(context, 'Cheque');
                              },
                              autofocus: true,
                              readOnly: true,
                              controller:
                                  context.read<SOCon>().mycontroller[24],
                              cursorColor: Colors.grey,
                              style:
                                  widget.theme.textTheme.bodyMedium?.copyWith(),
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
                                          .read<SOCon>()
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
                        ],
                      ),
                      SizedBox(height: widget.cashHeight * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text("Bank Name"),
                          ),
                          SizedBox(height: widget.cashHeight * 0.05),
                          Container(
                            width: widget.cashWidth * 0.7,
                            padding: EdgeInsets.only(
                              left: widget.cashHeight * 0.01,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      context.read<SOCon>().getbankhintcolor ==
                                              true
                                          ? Colors.red
                                          : Colors.grey),
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                focusColor: Colors.white,
                                hint: Text(
                                  ' Select Bank Name',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: context
                                                  .read<SOCon>()
                                                  .getbankhintcolor ==
                                              true
                                          ? Colors.red
                                          : Colors.grey),
                                ),
                                items: context
                                    .read<SOCon>()
                                    .bankList
                                    .map((item) => DropdownMenuItem<String>(
                                        value: item.bankName,
                                        child: Text(
                                          item.bankName!,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        )))
                                    .toList(),
                                value: context.read<SOCon>().selectedBankType,
                                onChanged: (value) {
                                  st(() {
                                    context.read<SOCon>().selectedBankType =
                                        value;
                                    context.read<SOCon>().getSelectbankCode(
                                        context
                                            .read<SOCon>()
                                            .selectedBankType
                                            .toString());
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: widget.cashHeight * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: widget.cashWidth * 0.35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Text("Amount"),
                                ),
                                IconButton(
                                    onPressed: () {
                                      context.read<SOCon>().cpyBtnclik(25);
                                    },
                                    icon: const Icon(
                                      Icons.copy,
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            width: widget.cashWidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              autofocus: true,
                              controller:
                                  context.read<SOCon>().mycontroller[25],
                              cursorColor: Colors.grey,
                              style:
                                  widget.theme.textTheme.bodyMedium?.copyWith(),
                              keyboardType: TextInputType.number,
                              inputFormatters: [DecimalInputFormatter()],
                              onChanged: (v) {
                                context
                                    .read<SOCon>()
                                    .doubleDotMethodPayTerms(25, v);
                              },
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
                      SizedBox(height: widget.cashHeight * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text("Remarks"),
                          ),
                          Container(
                            width: widget.cashWidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              autofocus: true,
                              controller:
                                  context.read<SOCon>().mycontroller[26],
                              cursorColor: Colors.grey,
                              style:
                                  widget.theme.textTheme.bodyMedium?.copyWith(),
                              onChanged: (v) {},
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
                    ])),
          ],
        ),
      );
    });
  }

  forCard(BuildContext context, String cardType) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        color: Colors.white,
        width: widget.cashWidth * 1.1,
        padding: EdgeInsets.only(
            top: widget.cashHeight * 0.05,
            left: widget.cashHeight * 0.1,
            right: widget.cashHeight * 0.1,
            bottom: widget.cashHeight * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.read<SOCon>().getmsgforAmount == null
                  ? ''
                  : "${context.watch<SOCon>().getmsgforAmount}",
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
            ),
            Form(
                key: context.read<SOCon>().formkey[3],
                child: Column(
                  children: [
                    SizedBox(height: widget.cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Payment Terminal"),
                        ),
                        SizedBox(height: widget.cashHeight * 0.05),
                        Container(
                          width: widget.cashWidth * 0.7,
                          padding: EdgeInsets.only(
                            left: widget.cashHeight * 0.01,
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
                                'Select Payment Terminal',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: context.read<SOCon>().gethintcolor ==
                                            true
                                        ? Colors.red
                                        : Colors.grey),
                              ),
                              items: context
                                  .read<SOCon>()
                                  .getpayTerminal
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
                              value: context.read<SOCon>().paymentterm,
                              onChanged: (value) {
                                st(() {
                                  context.read<SOCon>().paymentterm = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: widget.cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Approval No"),
                        ),
                        Container(
                          width: widget.cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller: context.read<SOCon>().mycontroller[27],
                            cursorColor: Colors.grey,
                            inputFormatters: [DecimalInputFormatter()],
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Please Enter the Approval Number';
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
                    SizedBox(height: widget.cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Card Reference"),
                        ),
                        Container(
                          width: widget.cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: context.read<SOCon>().mycontroller[28],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Please Enter the Card Reference';
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
                    SizedBox(height: widget.cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: widget.cashWidth * 0.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text("Amount"),
                              ),
                              IconButton(
                                  onPressed: () {
                                    context.read<SOCon>().cpyBtnclik(29);
                                  },
                                  icon: const Icon(
                                    Icons.copy,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          width: widget.cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller: context.read<SOCon>().mycontroller[29],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            keyboardType: TextInputType.number,
                            inputFormatters: [DecimalInputFormatter()],
                            onChanged: (v) {
                              context
                                  .read<SOCon>()
                                  .doubleDotMethodPayTerms(29, v);
                            },
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
                  ],
                )),
          ],
        ),
      );
    });
  }

  forTransfer(BuildContext context) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.only(
            top: widget.cashHeight * 0.02,
            left: widget.cashHeight * 0.1,
            right: widget.cashHeight * 0.1,
            bottom: widget.cashHeight * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.read<SOCon>().getmsgforAmount == null
                  ? ''
                  : "${context.watch<SOCon>().getmsgforAmount}",
              style: widget.theme.textTheme.bodyMedium
                  ?.copyWith(color: Colors.red),
            ),
            Form(
              key: context.read<SOCon>().formkey[4],
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: widget.cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Trans Type"),
                        ),
                        Container(
                          width: widget.cashWidth * 0.7,
                          padding: EdgeInsets.only(
                            left: widget.cashHeight * 0.01,
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
                                  color: context.read<SOCon>().gethintcolor ==
                                          false
                                      ? Colors.grey
                                      : Colors.red,
                                ),
                              ),
                              items: context
                                  .read<SOCon>()
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
                              value: context.read<SOCon>().selectedType,
                              onChanged: (value) {
                                st(() {
                                  context.read<SOCon>().selectedType = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: widget.cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Trans Reference"),
                        ),
                        Container(
                          width: widget.cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller: context.read<SOCon>().mycontroller[30],
                            cursorColor: Colors.grey,
                            style:
                                widget.theme.textTheme.bodyMedium?.copyWith(),
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
                    SizedBox(height: widget.cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: widget.cashWidth * 0.35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text("Amount"),
                              ),
                              IconButton(
                                  onPressed: () {
                                    st(() {
                                      context.read<SOCon>().cpyBtnclik(31);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.copy,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          width: widget.cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            inputFormatters: [DecimalInputFormatter()],
                            onChanged: (v) {
                              context
                                  .read<SOCon>()
                                  .doubleDotMethodPayTerms(31, v);
                            },
                            controller: context.read<SOCon>().mycontroller[31],
                            cursorColor: Colors.grey,
                            style:
                                widget.theme.textTheme.bodyMedium?.copyWith(),
                            keyboardType: TextInputType.number,
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

  forwallet(BuildContext context) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.only(
            top: widget.cashHeight * 0.02,
            left: widget.cashHeight * 0.1,
            right: widget.cashHeight * 0.1,
            bottom: widget.cashHeight * 0.02),
        child: Column(
          children: [
            Text(
              context.read<SOCon>().getmsgforAmount == null
                  ? ''
                  : "${context.watch<SOCon>().getmsgforAmount}",
              style: widget.theme.textTheme.bodyMedium
                  ?.copyWith(color: Colors.red),
            ),
            Form(
                key: context.read<SOCon>().formkey[5],
                child: Column(
                  children: [
                    SizedBox(height: widget.cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Wallet"),
                        ),
                        SizedBox(height: widget.cashHeight * 0.05),
                        Container(
                          width: widget.cashWidth * 0.7,
                          padding: EdgeInsets.only(
                            left: widget.cashHeight * 0.01,
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
                                'Select Wallet Type',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: context.read<SOCon>().gethintcolor ==
                                            true
                                        ? Colors.red
                                        : Colors.grey),
                              ),
                              items: context
                                  .read<SOCon>()
                                  .walletlist
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
                              value: context.read<SOCon>().wallet,
                              onChanged: (value) {
                                st(() {
                                  context.read<SOCon>().wallet = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: widget.cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Waller ID"),
                        ),
                        Container(
                          width: widget.cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller: context.read<SOCon>().mycontroller[32],
                            cursorColor: Colors.grey,
                            style:
                                widget.theme.textTheme.bodyMedium?.copyWith(),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Please Enter the Wallet ID';
                              } else {
                                return null;
                              }
                            },
                            inputFormatters: [DecimalInputFormatter()],
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
                    SizedBox(height: widget.cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Payment Reference"),
                        ),
                        Container(
                          width: widget.cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller: context.read<SOCon>().mycontroller[33],
                            cursorColor: Colors.grey,
                            style:
                                widget.theme.textTheme.bodyMedium?.copyWith(),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Please Enter the Payment Reference';
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
                    SizedBox(height: widget.cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: widget.cashWidth * 0.35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text("Amount"),
                              ),
                              IconButton(
                                  onPressed: () {
                                    context.read<SOCon>().cpyBtnclik(34);
                                  },
                                  icon: const Icon(
                                    Icons.copy,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          width: widget.cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller: context.read<SOCon>().mycontroller[34],
                            cursorColor: Colors.grey,
                            style:
                                widget.theme.textTheme.bodyMedium?.copyWith(),
                            keyboardType: TextInputType.number,
                            onChanged: (v) {
                              context
                                  .read<SOCon>()
                                  .doubleDotMethodPayTerms(34, v);
                            },
                            inputFormatters: [DecimalInputFormatter()],
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
                  ],
                ))
          ],
        ),
      );
    });
  }

  // forCashConfirm(BuildContext context) {
  //   return StatefulBuilder(builder: (context, st) {
  //     return Container(
  //       padding: EdgeInsets.only(
  //         top: widget.cashHeight * 0.01,
  //         left: widget.cashHeight * 0.09,
  //         right: widget.cashHeight * 0.09,
  //       ),
  //       height: widget.cashHeight * 1,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Container(
  //               height: widget.cashHeight * 0.6,
  //               alignment: Alignment.center,
  //               child: Text(
  //                   "Is full amount Rs. ${context.read<SOCon>().config.splitValues(context.watch<SOCon>().getBalancePaid().toStringAsFixed(2))}")),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               GestureDetector(
  //                   onTap: () {
  //                     st(
  //                       () {
  //                         context
  //                             .read<SOCon>()
  //                             .fullamt('Cash', context, widget.theme);
  //                       },
  //                     );
  //                   },
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(5),
  //                       color: Colors.blue,
  //                     ),
  //                     alignment: Alignment.center,
  //                     width: widget.cashWidth * 0.2,
  //                     height: widget.cashHeight * 0.3,
  //                     child: Text(
  //                       "Yes",
  //                       style: widget.theme.textTheme.bodyMedium
  //                           ?.copyWith(color: Colors.white),
  //                     ),
  //                   )),
  //               GestureDetector(
  //                   onTap: () {
  //                     Navigator.pop(context);
  //                     context.read<SOCon>().nullErrorMsg();
  //                     showDialog(
  //                         context: context,
  //                         barrierDismissible: true,
  //                         builder: (BuildContext context) {
  //                           return StatefulBuilder(builder: (context, st) {
  //                             return AlertDialog(
  //                                 contentPadding: const EdgeInsets.all(0),
  //                                 content: AlertBox(
  //                                   payMent: 'Payment Mode - Cash',
  //                                   widget: forCashDialog(
  //                                     context,
  //                                   ),
  //                                   buttonName: 'OK',
  //                                   callback: () {
  //                                     st(
  //                                       () {
  //                                         context
  //                                             .read<SOCon>()
  //                                             .addEnteredAmtType('Cash',
  //                                                 context, 1, widget.theme);
  //                                       },
  //                                     );
  //                                   },
  //                                 ));
  //                           });
  //                         });
  //                   },
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(5),
  //                       color: Colors.blue,
  //                     ),
  //                     alignment: Alignment.center,
  //                     width: widget.cashWidth * 0.2,
  //                     height: widget.cashHeight * 0.3,
  //                     child: Text(
  //                       "Partial Amount",
  //                       style: widget.theme.textTheme.bodyMedium
  //                           ?.copyWith(color: Colors.white),
  //                     ),
  //                   ))
  //             ],
  //           )
  //         ],
  //       ),
  //     );
  //   });
  // }

  forAccBal(
    BuildContext context,
  ) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        width: widget.cashWidth * 1.1,
        padding: EdgeInsets.only(
            top: widget.cashHeight * 0.02,
            left: widget.cashHeight * 0.1,
            right: widget.cashHeight * 0.1,
            bottom: widget.cashHeight * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.watch<SOCon>().getmsgforAmount == null
                  ? ''
                  : "${context.watch<SOCon>().getmsgforAmount}",
              style: widget.theme.textTheme.bodyMedium
                  ?.copyWith(color: Colors.red),
            ),
            Form(
              key: context.read<SOCon>().formkey[7],
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Available Balance"),
                        ),
                        Container(
                          width: widget.cashWidth * 0.65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            readOnly: true,
                            controller: context.read<SOCon>().mycontroller[35],
                            cursorColor: Colors.grey,
                            style:
                                widget.theme.textTheme.bodyMedium?.copyWith(),
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
                    SizedBox(height: widget.cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Amount to Adjust"),
                        ),
                        IconButton(
                            onPressed: () {
                              context.read<SOCon>().cpyBtnclik(36);
                            },
                            icon: Icon(Icons.copy)),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: widget.cashWidth * 0.65,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r"[0-9.]")),
                              ],
                              autofocus: true,
                              controller:
                                  context.read<SOCon>().mycontroller[36],
                              cursorColor: Colors.grey,
                              style:
                                  widget.theme.textTheme.bodyMedium?.copyWith(),
                              onChanged: (v) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ' Please Enter the Adjust Amount';
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
                        ),
                      ],
                    ),
                  ]),
            ),
            SizedBox(height: widget.cashHeight * 0.05),
          ],
        ),
      );
    });
  }

  forPoints(BuildContext context) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        width: widget.cashWidth * 1.1,
        padding: EdgeInsets.only(
            top: widget.cashHeight * 0.02,
            left: widget.cashHeight * 0.1,
            right: widget.cashHeight * 0.1,
            bottom: widget.cashHeight * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.read<SOCon>().getmsgforAmount == null
                  ? ''
                  : "${context.watch<SOCon>().getmsgforAmount}",
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
            ),
            Form(
              key: context.read<SOCon>().formkey[8],
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Available Points"),
                        ),
                        Container(
                          width: widget.cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            readOnly: true,
                            controller: context.read<SOCon>().mycontroller[37],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            onChanged: (v) {},
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
                    SizedBox(height: widget.cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Points to Redeem"),
                        ),
                        Container(
                          width: widget.cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            onEditingComplete: () {
                              st(() {
                                context.read<SOCon>().pointconvert();
                              });
                            },
                            controller: context.read<SOCon>().mycontroller[38],
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Please Enter the Redeem points';
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
                    SizedBox(height: widget.cashHeight * 0.05),
                    InkWell(
                      onTap: () {
                        st(() {
                          context.read<SOCon>().pointconvert();
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: widget.cashHeight * 0.25,
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                        ),
                        child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Convert points to redeem",
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: widget.cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: widget.cashWidth * 0.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text("Amount"),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: widget.cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            onTap: () {
                              st(() {
                                context.read<SOCon>().pointconvert();
                              });
                            },
                            controller: context.read<SOCon>().mycontroller[40],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            keyboardType: TextInputType.number,
                            onChanged: (v) {
                              context
                                  .read<SOCon>()
                                  .doubleDotMethodPayTerms(40, v);
                            },
                            inputFormatters: [DecimalInputFormatter()],
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

  forDiscount(
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        width: widget.cashWidth * 1.1,
        padding: EdgeInsets.only(
            top: widget.cashHeight * 0.02,
            left: widget.cashHeight * 0.1,
            right: widget.cashHeight * 0.1,
            bottom: widget.cashHeight * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.read<SOCon>().getmsgforAmount == null
                  ? ''
                  : "${context.read<SOCon>().getmsgforAmount}",
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
            ),
            Form(
              key: context.read<SOCon>().formkey[9],
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Finance Type"),
                        ),
                        Container(
                          width: widget.cashWidth * 0.7,
                          padding: EdgeInsets.only(
                            left: widget.cashHeight * 0.01,
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
                                'Select Finance Type',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: context.read<SOCon>().gethintcolor ==
                                          false
                                      ? Colors.grey
                                      : Colors.red,
                                ),
                              ),
                              items: context
                                  .read<SOCon>()
                                  .getdiscountType
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
                              value: context.read<SOCon>().discount,
                              onChanged: (value) {
                                st(() {
                                  context.read<SOCon>().discount = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: widget.cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Finance Reference"),
                        ),
                        Container(
                          width: widget.cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller: context.read<SOCon>().mycontroller[41],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Please Enter the Discount Reference';
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
                    SizedBox(height: widget.cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: widget.cashWidth * 0.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text("Amount"),
                              ),
                              IconButton(
                                  onPressed: () {
                                    context.read<SOCon>().cpyBtnclik(42);
                                  },
                                  icon: const Icon(
                                    Icons.copy,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          width: widget.cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller: context.read<SOCon>().mycontroller[42],
                            cursorColor: Colors.grey,
                            keyboardType: TextInputType.number,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            onChanged: (v) {
                              context
                                  .read<SOCon>()
                                  .doubleDotMethodPayTerms(42, v);
                            },
                            inputFormatters: [DecimalInputFormatter()],
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

  forCredit(BuildContext context) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        width: widget.cashWidth * 1.1,
        padding: EdgeInsets.only(
            top: widget.cashHeight * 0.02,
            left: widget.cashHeight * 0.1,
            right: widget.cashHeight * 0.1,
            bottom: widget.cashHeight * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.read<SOCon>().getmsgforAmount == null
                  ? ''
                  : "${context.read<SOCon>().getmsgforAmount}",
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
            ),
            Form(
              key: context.read<SOCon>().formkey[10],
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Credit Reference"),
                        ),
                        Container(
                          width: widget.cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller: context.read<SOCon>().mycontroller[43],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Please Enter the Credit Reference';
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
                    SizedBox(height: widget.cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Recovery Date"),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: widget.cashWidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              readOnly: true,
                              controller:
                                  context.read<SOCon>().mycontroller[44],
                              cursorColor: Colors.grey,
                              style: theme.textTheme.bodyMedium?.copyWith(),
                              onChanged: (v) {},
                              onTap: () {
                                context
                                    .read<SOCon>()
                                    .recoveryGetDate(context, 'Credit');
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ' Please Enter the Recovery Date';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                suffixIcon: const Icon(Icons.date_range),
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
                    SizedBox(height: widget.cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: widget.cashWidth * 0.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text("Amount"),
                              ),
                              IconButton(
                                  onPressed: () {
                                    context.read<SOCon>().cpyBtnclik(45);
                                  },
                                  icon: const Icon(
                                    Icons.copy,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          width: widget.cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller: context.read<SOCon>().mycontroller[45],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            keyboardType: TextInputType.number,
                            onChanged: (v) {
                              context
                                  .read<SOCon>()
                                  .doubleDotMethodPayTerms(45, v);
                            },
                            inputFormatters: [DecimalInputFormatter()],
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

  validate() {
    return const Text("Ggggggggg");
  }
}
