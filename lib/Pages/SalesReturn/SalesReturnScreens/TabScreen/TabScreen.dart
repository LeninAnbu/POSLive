import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:posproject/Controller/SalesReturnController/SalesReturnController.dart';
import 'package:posproject/Pages/SalesReturn/Widget/CustomerListt.dart';
import 'package:posproject/Pages/SalesReturn/Widget/InvoiceInfo.dart';
import 'package:posproject/Pages/SalesReturn/Widget/ItemList.dart';
import 'package:posproject/Pages/SalesReturn/Widget/SalesReturnPayment.dart';
import 'package:provider/provider.dart';
import '../../../../Constant/Screen.dart';
import '../../Widget/BottomBtn.dart';

class SalesReturnTabScreen extends StatefulWidget {
  const SalesReturnTabScreen({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  State<SalesReturnTabScreen> createState() => _SalesReturnTabScreenState();
}

class _SalesReturnTabScreenState extends State<SalesReturnTabScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // context.read<SalesReturnController>().clearAllData();
      // context.read<SalesReturnController>().init();
    });
  }

//return Stack(
// SalesReturnController prdSR;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
              color: Colors.grey.withOpacity(0.05),
              height: Screens.bodyheight(context) * 0.95,
              padding: EdgeInsets.only(
                top: Screens.bodyheight(context) * 0.02,
                left: Screens.bodyheight(context) * 0.01,
                right: Screens.bodyheight(context) * 0.01,
                bottom: Screens.bodyheight(context) * 0.01,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: Screens.width(context) * 0.5,
                      // color:Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SalesReturnItem(
                            searchHeight: Screens.bodyheight(context) * 0.65,
                            searchWidth: Screens.width(context) * 0.48,
                            theme: widget.theme,
                            // prdsrch: prdSR,
                          ),
                          // PaymentDetails(
                          //   theme: theme,
                          //   prdPmt: prdSCD,
                          //   paymentWidth: Screens.width(context) * 0.48,
                          //   paymentHeight: Screens.bodyheight(context) * 0.5,
                          // )
                          SalesReturnPayment(
                            theme: widget.theme,
                            // prdSR: prdSR,
                            paymentWidth: Screens.width(context) * 0.48,
                            paymentHeight: Screens.bodyheight(context) * 0.25,
                          )
                        ],
                      )),
                  SizedBox(
                      width: Screens.width(context) * 0.48,
                      //  color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomerListt(
                            custWidth: Screens.width(context) * 0.48,
                            custHeight: Screens.bodyheight(context) * 0.46,
                            theme: widget.theme,
                            // prdSR: prdSR,
                          ),
                          InvoiceInfo(
                            theme: widget.theme,
                            // posSR: prdSR,
                            cashWidth: Screens.width(context) * 0.48,
                            cashHeight: Screens.bodyheight(context) * 0.24,
                          ),
                          //  prdSR.scanneditemData2.isNotEmpty
                          //     ? Container()
                          //     : PaymentModeBtn(
                          //   theme: theme,
                          //   salesReturnController: prdSR,
                          //   cashWidth: Screens.width(context) * 0.48,
                          //   cashHeight: Screens.bodyheight(context) * 0.08,
                          //   dialogheight: Screens.bodyheight(context) * 0.3,
                          //   dialogwidth:  Screens.width(context) * 0.48,
                          // ),
                          BottomBtn(
                            theme: widget.theme,
                            btnheight: Screens.bodyheight(context) * 0.3,
                            btnWidth: Screens.width(context) * 0.48,
                            // posSR: prdSR,
                          )
                        ],
                      )),
                ],
              )),
          Visibility(
            visible: context.watch<SalesReturnController>().freezeScrn,
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
