import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';

class MobLoadBtns extends StatelessWidget {
  const MobLoadBtns({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Screens.width(context) * 0.95,
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: Screens.width(context) * 0.4,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                    ),
                    onPressed: () {},
                    child: Text(
                      "Load Self Requirement",
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: Colors.black),
                    )),
              ),
              Container(
                alignment: Alignment.centerRight,
                width: Screens.width(context) * 0.4,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                    ),
                    onPressed: () {},
                    child: Text(
                      "Load Min/Max Requirement",
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: Colors.black),
                    )),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: Screens.width(context) * 0.4,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                    ),
                    onPressed: () {},
                    child: Text(
                      "Load Last Day Sold Items",
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: Colors.black),
                    )),
              ),
              Container(
                alignment: Alignment.centerRight,
                width: Screens.width(context) * 0.4,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                    ),
                    onPressed: () {},
                    child: Text(
                      "Load Recently Received Items",
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: Colors.black),
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
