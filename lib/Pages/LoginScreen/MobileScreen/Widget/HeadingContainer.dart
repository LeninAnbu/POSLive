// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';

class HeadingContainerMob extends StatelessWidget {
  const HeadingContainerMob({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Screens.bodyheight(context) * 0.30,
      width: Screens.width(context) * 1.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Welcome to Login',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
        ],
      ),
    );
  }
}
