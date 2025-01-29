import 'package:flutter/material.dart';

import '../../../../../Constant/Screen.dart';

class ContentWidgetMob extends StatelessWidget {
  const ContentWidgetMob({super.key, required this.theme, required this.msg});

  final ThemeData theme;
  final String msg;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Screens.width(context) * 0.5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Screens.width(context) * 0.71,
            height: Screens.padingHeight(context) * 0.05,
            color: Colors.red,
            //theme.primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: Screens.padingHeight(context) * 0.02,
                      right: Screens.padingHeight(context) * 0.02),
                  // color: Colors.red,
                  width: Screens.width(context) * 0.4,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Alert",
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      size: Screens.padingHeight(context) * 0.025,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: Screens.padingHeight(context) * 0.01,
          ),
          Container(
            // color: Colors.green,
            height: Screens.padingHeight(context) * 0.065,
            alignment: Alignment.center,
            padding: EdgeInsets.only(
                left: Screens.padingHeight(context) * 0.02,
                right: Screens.padingHeight(context) * 0.02),
            width: Screens.width(context),
            child: Text(msg),
          ),
          SizedBox(
            height: Screens.padingHeight(context) * 0.01,
          ),
          //    InkWell(
          //   onTap: () {
          //   Navigator.pop(context);
          //   },
          //   child: Container(
          //     alignment: Alignment.center,
          //     height: Screens.padingHeight(context) * 0.045,
          //     decoration: BoxDecoration(
          //       color: theme.primaryColor,
          //       // borderRadius: BorderRadius.only(
          //       //     topLeft: Radius.circular(5), topRight: Radius.circular(5))
          //     ),
          //     child: Center(
          //       child: Container(
          //         alignment: Alignment.center,
          //         child: Text(
          //         "Ok",
          //           textAlign: TextAlign.center,
          //           style: theme.textTheme.bodyMedium
          //               ?.copyWith(color: Colors.white),
          //         ),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
