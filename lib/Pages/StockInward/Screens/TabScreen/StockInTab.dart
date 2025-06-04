import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:posproject/Pages/StockInward/Widgets/InwardItem.dart';
import 'package:provider/provider.dart';
import '../../../../Constant/Screen.dart';
import '../../../../Controller/StockInwardController/StockInwardContler.dart';
import '../../Widgets/openInwardPage.dart';

class StockInTab extends StatefulWidget {
  const StockInTab({super.key, required this.theme});

  final ThemeData theme;

  @override
  State<StockInTab> createState() => _StockInTabState();
}

class _StockInTabState extends State<StockInTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
              color: Colors.grey.withOpacity(0.05),
              padding: EdgeInsets.only(
                top: Screens.padingHeight(context) * 0.01,
                left: Screens.padingHeight(context) * 0.01,
                right: Screens.padingHeight(context) * 0.01,
                bottom: Screens.padingHeight(context) * 0.01,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const OpenInwardListPage(),
                  SizedBox(
                      width: Screens.width(context) * 0.48,
                      child: SingleChildScrollView(
                        child: StockInward(
                          theme: widget.theme,
                          stockInWidth: Screens.width(context) * 0.48,
                          stockInheight: Screens.bodyheight(context) * 0.907,
                          index:
                              context.watch<StockInwrdController>().get_i_value,
                          datatotal:
                              context.watch<StockInwrdController>().stockInward,
                        ),
                      )),
                ],
              )),
          Visibility(
            visible: context.watch<StockInwrdController>().onClickDisable!,
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
