import 'package:flutter/material.dart';
import 'package:posproject/Controller/LoginController/LoginController.dart';
import 'package:provider/provider.dart';

import '../../../Constant/Screen.dart';

class HeaderLoginTab extends StatelessWidget {
  const HeaderLoginTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Screens.bodyheight(context) * 0.25,
      width: Screens.width(context) * 1.0,
      //color: Colors.amber,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Welcome to Login',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          SizedBox(
            height: Screens.fullHeight(context) * 0.01,
          ),
          context.watch<LoginController>().incorrectPwd.isNotEmpty
              ? Text('${context.watch<LoginController>().incorrectPwd}',
                  style: TextStyle(
                    color: Colors.red,
                  ))
              : Container(),
        ],
      ),
    );
  }
}
