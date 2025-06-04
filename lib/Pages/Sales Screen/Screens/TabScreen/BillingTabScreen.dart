import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:posproject/Controller/SalesInvoice/SalesInvoiceController.dart';
import 'package:provider/provider.dart';

import '../../../../Constant/Screen.dart';
import '../../Widgets/BottomButton.dart';
import '../../Widgets/CashandCheque.dart';
import '../../Widgets/CustomerDetails.dart';
import '../../Widgets/Paymentpage.dart';
import '../../Widgets/ItemLists.dart';

class SalesInvoiceTabScreen extends StatefulWidget {
  const SalesInvoiceTabScreen({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  State<SalesInvoiceTabScreen> createState() => _SalesInvoiceTabScreenState();
}

class _SalesInvoiceTabScreenState extends State<SalesInvoiceTabScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
              color: Colors.grey.withOpacity(0.05),
              height: Screens.bodyheight(context) * 0.95,
              padding: EdgeInsets.only(
                top: Screens.bodyheight(context) * 0.01,
                left: Screens.bodyheight(context) * 0.01,
                right: Screens.bodyheight(context) * 0.01,
                bottom: Screens.bodyheight(context) * 0.01,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: Screens.width(context) * 0.55,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SearchWidget(
                              searchHeight: Screens.bodyheight(context) * 0.67,
                              searchWidth: Screens.width(context) * 0.55,
                              theme: widget.theme,
                            ),
                            PaymentDetails(
                              theme: widget.theme,
                              paymentWidth: Screens.width(context) * 0.55,
                              paymentHeight: Screens.bodyheight(context) * 0.25,
                            )
                          ])),
                  SizedBox(
                      width: Screens.width(context) * 0.43,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          context.watch<PosController>().loadingscrn == true
                              ? SizedBox(
                                  width: Screens.width(context) * 0.43,
                                  height: Screens.bodyheight(context) * 0.3,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: widget.theme.primaryColor,
                                    ),
                                  ),
                                )
                              : CustomerDetails(
                                  custWidth: Screens.width(context) * 0.43,
                                  custHeight:
                                      Screens.bodyheight(context) * 0.25,
                                  theme: widget.theme,
                                ),
                          context
                                      .watch<PosController>()
                                      .scanneditemData2
                                      .isNotEmpty &&
                                  context
                                          .watch<PosController>()
                                          .getselectedcust2 !=
                                      null
                              ? Container()
                              : CashWidget(
                                  cashWidth: Screens.width(context) * 0.43,
                                  cashHeight: Screens.bodyheight(context) * 0.2,
                                  theme: widget.theme,
                                ),
                          BottomButtons(
                            theme: widget.theme,
                            btnheight: Screens.bodyheight(context) * 0.28,
                            btnWidth: Screens.width(context) * 0.43,
                          )
                        ],
                      )),
                ],
              )),
          Visibility(
            visible: context.watch<PosController>().ondDisablebutton,
            child: Container(
              width: Screens.width(context),
              height: Screens.bodyheight(context) * 0.95,
              color: Colors.white60,
              child: Center(
                child: SpinKitFadingCircle(
                  size: Screens.bodyheight(context) * 0.08,
                  color: widget.theme.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class Base64Image extends StatelessWidget {
//   final String base64String;

//   const Base64Image({required this.base64String});

//   @override
//   Widget build(BuildContext context) {
//     try {
//       String base64Stringx = base64String.split(',').last;
//       Uint8List imageBytes = base64Decode(base64Stringx);

//       return Image.memory(imageBytes);
//     } catch (e) {
//       return Text('Invalid Base64 String');
//     }
//   }
// }
