import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';

class StIn_Alertbox extends StatelessWidget {
  StIn_Alertbox({super.key, required this.content, required this.theme});
  String content;
  final ThemeData theme;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: Screens.padingHeight(context) * 0.02),
      height: Screens.padingHeight(context) * 0.09,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                alignment: Alignment.center,
                height: Screens.padingHeight(context) * 0.1,
                width: Screens.width(context) * 0.1,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/AlertIcon.png"),
                  ),
                )),
            SizedBox(
              width: Screens.width(context) * 0.02,
            ),
            Text(content, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
