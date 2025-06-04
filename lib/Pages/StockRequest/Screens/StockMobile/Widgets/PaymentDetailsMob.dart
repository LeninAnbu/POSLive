import 'package:flutter/material.dart';

import '../../../../../Controller/StockRequestController/StockRequestController.dart';

class MobReqpaymentDeltails extends StatelessWidget {
  const MobReqpaymentDeltails({
    super.key,
    required this.proWidth,
    required this.proHeight,
    required this.prdsrch,
    required this.theme,
  });

  final double proWidth;
  final double proHeight;
  final StockReqController prdsrch;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: proWidth,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(
                    proHeight * 0.05,
                  ),
                  width: proWidth * 0.4,
                  child: const Text("Total Items"),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(
                    proHeight * 0.05,
                  ),
                  width: proWidth * 0.4,
                  child: prdsrch.calCulteStReq == null
                      ? const Text(
                          "0",
                        )
                      : Text(
                          prdsrch.getScanneditemData.length.toStringAsFixed(0),
                          style: theme.textTheme.bodyMedium),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(
                    proHeight * 0.05,
                  ),
                  width: proWidth * 0.4,
                  child: const Text("Qty"),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(
                    proHeight * 0.05,
                  ),
                  width: proWidth * 0.4,
                  child: prdsrch.calCulteStReq == null
                      ? const Text(
                          "0",
                        )
                      : Text(
                          prdsrch.getNoOfQty().toStringAsFixed(0),
                          style: theme.textTheme.bodyMedium?.copyWith(),
                        ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(
                    proHeight * 0.05,
                  ),
                  width: proWidth * 0.4,
                  child: const Text("Total Weight"),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(
                    proHeight * 0.05,
                  ),
                  width: proWidth * 0.4,
                  child: prdsrch.calCulteStReq == null
                      ? Text("0.00 kg", style: theme.textTheme.bodyMedium)
                      : Text(
                          "${prdsrch.calCulteStReq!.totalweight!.toStringAsFixed(0)}.00kg",
                          style: theme.textTheme.bodyMedium),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(
                    proHeight * 0.05,
                  ),
                  width: proWidth * 0.4,
                  child: const Text("Total Ltr"),
                ),
                Container(
                  padding: EdgeInsets.all(
                    proHeight * 0.05,
                  ),
                  alignment: Alignment.centerRight,
                  width: proWidth * 0.4,
                  child: prdsrch.calCulteStReq == null
                      ? Text(
                          "0.00 ltr",
                          style: theme.textTheme.bodyMedium,
                        )
                      : Text(
                          "${prdsrch.calCulteStReq!.totalLiter!.toStringAsFixed(0)}.00kg",
                          style: theme.textTheme.bodyMedium?.copyWith(),
                        ),
                )
              ],
            )
          ],
        ));
  }
}
