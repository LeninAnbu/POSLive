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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SalesReturnItem(
                            searchHeight: Screens.bodyheight(context) * 0.65,
                            searchWidth: Screens.width(context) * 0.48,
                            theme: widget.theme,
                          ),
                          SalesReturnPayment(
                            theme: widget.theme,
                            paymentWidth: Screens.width(context) * 0.48,
                            paymentHeight: Screens.bodyheight(context) * 0.25,
                          )
                        ],
                      )),
                  SizedBox(
                      width: Screens.width(context) * 0.48,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomerListt(
                            custWidth: Screens.width(context) * 0.48,
                            custHeight: Screens.bodyheight(context) * 0.46,
                            theme: widget.theme,
                          ),
                          InvoiceInfo(
                            theme: widget.theme,
                            cashWidth: Screens.width(context) * 0.48,
                            cashHeight: Screens.bodyheight(context) * 0.24,
                          ),
                          BottomBtn(
                            theme: widget.theme,
                            btnheight: Screens.bodyheight(context) * 0.3,
                            btnWidth: Screens.width(context) * 0.48,
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
