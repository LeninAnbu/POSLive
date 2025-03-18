import 'package:flutter/material.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import 'package:provider/provider.dart';
import '../../../Constant/Screen.dart';
import '../../../Controller/SalesQuotationController/SalesQuotationController.dart';
import '../../../Widgets/ContentContainer.dart';

class SQCashWidget extends StatefulWidget {
  SQCashWidget({
    super.key,
    required this.theme,
    required this.cashHeight,
    required this.cashWidth,
  });
  double cashHeight;
  double cashWidth;
  final ThemeData theme;

  @override
  State<SQCashWidget> createState() => _SQCashWidgetState();
}

class _SQCashWidgetState extends State<SQCashWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            context.read<SalesQuotationCon>().getScanneditemData2.isNotEmpty &&
                    context.read<SalesQuotationCon>().selectedcust2 != null
                ? Colors.grey[300]
                : Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.only(
          top: widget.cashHeight * 0.01,
          left: widget.cashHeight * 0.01,
          right: widget.cashHeight * 0.01,
          bottom: widget.cashHeight * 0.01),
      width: widget.cashWidth,
      height: widget.cashHeight,
      child: Center(
          // child: Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          // Row(
          //   children: [
          // context
          //             .read<SalesQuotationCon>()
          //             .getScanneditemData2
          //             .isNotEmpty &&
          //         context.read<SalesQuotationCon>().userTypes ==
          //             'corporate'
          //     ? Container(
          //         padding:
          //             EdgeInsets.only(left: widget.cashHeight * 0.05),
          //         height: Screens.padingHeight(context) * 0.057,
          //         width: Screens.width(context) * 0.24,
          //         decoration: const BoxDecoration(),
          //         child: TextFormField(
          //           controller: context
          //               .read<SalesQuotationCon>()
          //               .warehousectrl[0],
          //           validator: (value) =>
          //               value == null ? 'Required*' : null,
          //           decoration: InputDecoration(
          //             contentPadding: EdgeInsets.symmetric(
          //                 vertical: 10, horizontal: 5),
          //             // errorBorder: OutlineInputBorder(
          //             //   borderRadius: BorderRadius.circular(5),
          //             //   borderSide: const BorderSide(color: Colors.red),
          //             // ),
          //             // focusedErrorBorder: OutlineInputBorder(
          //             //   borderRadius: BorderRadius.circular(5),
          //             //   borderSide: const BorderSide(color: Colors.red),
          //             // ),
          //             enabledBorder: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(5),
          //               borderSide: BorderSide(color: Colors.grey),
          //             ),
          //             focusedBorder: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(5),
          //               borderSide: BorderSide(color: Colors.grey),
          //             ),
          //           ),
          //         ),
          //       )
          //     : context.read<SalesQuotationCon>().userTypes == 'corporate'
          //         ? Container(
          //             padding:
          //                 EdgeInsets.only(left: widget.cashHeight * 0.05),
          //             height: Screens.padingHeight(context) * 0.057,
          //             width: Screens.width(context) * 0.24,
          //             decoration: const BoxDecoration(),
          //             child: DropdownButtonFormField(
          //                 validator: (value) =>
          //                     value == null ? 'Required*' : null,
          //                 decoration: InputDecoration(
          //                   contentPadding: EdgeInsets.symmetric(
          //                       vertical: 10, horizontal: 5),
          //                   errorBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(5),
          //                     borderSide:
          //                         const BorderSide(color: Colors.red),
          //                   ),
          //                   focusedErrorBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(5),
          //                     borderSide:
          //                         const BorderSide(color: Colors.red),
          //                   ),
          //                   enabledBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(5),
          //                     borderSide: BorderSide(
          //                         color: widget.theme.primaryColor),
          //                   ),
          //                   focusedBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(5),
          //                     borderSide: BorderSide(
          //                         color: widget.theme.primaryColor),
          //                   ),
          //                 ),
          //                 icon: const Icon(Icons.arrow_drop_down),
          //                 value:
          //                     context.watch<SalesQuotationCon>().whsName,
          //                 items: context
          //                     .read<SalesQuotationCon>()
          //                     .whsLists
          //                     .map((e) {
          //                   return DropdownMenuItem(
          //                       value: e.companyName,
          //                       child: Text(
          //                         e.companyName.toString(),
          //                       ));
          //                 }).toList(),
          //                 hint: const Text(
          //                   "Choose warehouse code",
          //                   style: TextStyle(
          //                       color: Colors.black54,
          //                       fontSize: 14,
          //                       fontWeight: FontWeight.w500),
          //                 ),
          //                 onChanged: (value) {
          //                   setState(() {
          //                     context.read<SalesQuotationCon>().whsName =
          //                         value!;
          //                     context
          //                         .read<SalesQuotationCon>()
          //                         .selectedWhsCode(value.toString());
          //                   });
          //                 }),
          //           )
          //         : Container(
          //             width: Screens.width(context) * 0.15,
          //           ),
          // SizedBox(
          //   width: Screens.width(context) * 0.025,
          // ),
          child: context
                      .read<SalesQuotationCon>()
                      .getScanneditemData2
                      .isNotEmpty &&
                  context.read<SalesQuotationCon>().selectedcust2 != null
              ? Container()
              : Center(
                  child: GestureDetector(
                      onTap: context.read<SalesQuotationCon>().userTypes ==
                              'corporate'
                          ? null
                          : () async {
                              context.read<SalesQuotationCon>().nullErrorMsg();
                              if (context
                                      .read<SalesQuotationCon>()
                                      .getselectedcust ==
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
                                                content: 'Choose cusotmer..!!',
                                                theme: widget.theme,
                                              )),
                                              buttonName: null));
                                    });
                              } else if (context
                                      .read<SalesQuotationCon>()
                                      .getScanneditemData
                                      .length <
                                  1) {
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
                                context.read<SalesQuotationCon>().schemebtnclk =
                                    true;
                                await context
                                    .read<SalesQuotationCon>()
                                    .schemeapiforckout(context, widget.theme);
                              }
                              context
                                  .read<SalesQuotationCon>()
                                  .disableKeyBoard(context);
                            },
                      child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                              left: widget.cashHeight * 0.01,
                              right: widget.cashHeight * 0.01),
                          height: widget.cashHeight * 0.35,
                          width: widget.cashWidth * 0.25,
                          decoration: BoxDecoration(
                            color: context
                                        .read<SalesQuotationCon>()
                                        .userTypes ==
                                    'corporate'
                                ? Colors.grey[300]
                                : widget.theme.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                height: widget.cashHeight * 0.6,
                                width: widget.cashWidth * 0.05,
                                decoration: BoxDecoration(
                                  // color: Colors.red,
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
                )
          //   ],
          // ),
          // context.read<SalesQuotationCon>().getScanneditemData2.isNotEmpty &&
          //         context.read<SalesQuotationCon>().userTypes == 'corporate'
          //     ? Container(
          //         padding: EdgeInsets.only(left: widget.cashHeight * 0.05),
          //         height: Screens.padingHeight(context) * 0.057,
          //         width: Screens.width(context) * 0.24,
          //         decoration: const BoxDecoration(),
          //         child: TextFormField(
          //           controller:
          //               context.read<SalesQuotationCon>().warehousectrl[1],
          //           validator: (value) => value == null ? 'Required*' : null,
          //           decoration: InputDecoration(
          //             contentPadding:
          //                 EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          //             enabledBorder: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(5),
          //               borderSide: BorderSide(color: Colors.grey),
          //             ),
          //             focusedBorder: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(5),
          //               borderSide: BorderSide(color: Colors.grey),
          //             ),
          //           ),
          //         ))
          //     : context.read<SalesQuotationCon>().userTypes == 'corporate'
          //         ? Container(
          //             padding:
          //                 EdgeInsets.only(left: widget.cashHeight * 0.05),
          //             height: Screens.padingHeight(context) * 0.057,
          //             width: Screens.width(context) * 0.24,
          //             decoration: const BoxDecoration(),
          //             child: DropdownButtonFormField(
          //                 validator: (value) =>
          //                     value == null ? 'Required*' : null,
          //                 decoration: InputDecoration(
          //                   contentPadding: EdgeInsets.symmetric(
          //                       vertical: 5, horizontal: 5),
          //                   errorBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(5),
          //                     borderSide: const BorderSide(color: Colors.red),
          //                   ),
          //                   focusedErrorBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(5),
          //                     borderSide: const BorderSide(color: Colors.red),
          //                   ),
          //                   enabledBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(5),
          //                     borderSide: BorderSide(
          //                         color: widget.theme.primaryColor),
          //                   ),
          //                   focusedBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(5),
          //                     borderSide: BorderSide(
          //                         color: widget.theme.primaryColor),
          //                   ),
          //                 ),
          //                 icon: const Icon(Icons.arrow_drop_down),
          //                 value: context
          //                     .watch<SalesQuotationCon>()
          //                     .newSeriesName,
          //                 items: context
          //                     .read<SalesQuotationCon>()
          //                     .newDocSeries
          //                     .map((e) {
          //                   return DropdownMenuItem(
          //                       value: e.seriesName,
          //                       child: Text(
          //                         e.seriesName.toString(),
          //                       ));
          //                 }).toList(),
          //                 hint: const Text(
          //                   "Choose series",
          //                   style: TextStyle(
          //                       color: Colors.black54,
          //                       fontSize: 14,
          //                       fontWeight: FontWeight.w500),
          //                 ),
          //                 onChanged: (value) {
          //                   setState(() {
          //                     context
          //                         .read<SalesQuotationCon>()
          //                         .newSeriesName = value.toString();
          //                     context
          //                         .read<SalesQuotationCon>()
          //                         .selectDocSeries(value.toString());
          //                   });
          //                 }),
          //           )
          //         : Container(
          //             width: Screens.width(context) * 0.15,
          //           ),
          //   ],
          // ),
          ),
    );
  }
}
