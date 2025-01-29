import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Controller/StockRequestController/StockRequestController.dart';

class LoadButtons extends StatelessWidget {
  LoadButtons({super.key, required this.loadheight, required this.loadWidth});
  double loadheight;
  double loadWidth;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: loadWidth,
      padding: EdgeInsets.only(
          top: loadheight * 0.08,
          bottom: loadheight * 0.08,
          left: loadheight * 0.1,
          right: loadheight * 0.1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  context.read<StockReqController>().loadShelfReqData(theme);
                  context.read<StockReqController>().disableKeyBoard(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: loadWidth * 0.46,
                  padding: EdgeInsets.all(loadheight * 0.1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey.withOpacity(0.08),
                  ),
                  child: const Text("Load Shelf Requirement"),
                ),
              ),
              InkWell(
                onTap: () {
                  context.read<StockReqController>().loadMiniMaxData(theme);
                  context.read<StockReqController>().disableKeyBoard(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: loadWidth * 0.46,
                  padding: EdgeInsets.all(loadheight * 0.1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey.withOpacity(0.08),
                  ),
                  child: const Text("Load Min/Max Requirement"),
                ),
              )
            ],
          ),
          SizedBox(
            height: loadheight * 0.05,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  context
                      .read<StockReqController>()
                      .loadLastSoldItemsData(theme);
                  context.read<StockReqController>().disableKeyBoard(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: loadWidth * 0.46,
                  padding: EdgeInsets.all(loadheight * 0.1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey.withOpacity(0.08),
                  ),
                  child: const Text("Load Last Day Sold Items"),
                ),
              ),
              InkWell(
                onTap: () {
                  context.read<StockReqController>().disableKeyBoard(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: loadWidth * 0.46,
                  padding: EdgeInsets.all(loadheight * 0.1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey.withOpacity(0.08),
                  ),
                  child: const Text(
                    "Load Recently Received Items",
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
