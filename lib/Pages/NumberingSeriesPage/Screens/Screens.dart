import 'package:posproject/Pages/NumberingSeriesPage/Screens/TabScreen/NumberSeriesScrn.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../../Constant/Screen.dart';
import '../../../Controller/NumberingSeriesCtrl/NumberingSeriesCtrler.dart';
import '../../../Widgets/Drawer.dart';
import '../../../Widgets/MobileDrawer.dart';

class NumberingScreens extends StatefulWidget {
  const NumberingScreens({super.key});

  @override
  State<NumberingScreens> createState() => _NumberingScreensState();
}

class _NumberingScreensState extends State<NumberingScreens> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<NumberSeriesCtrl>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        return Scaffold(
            drawer: naviDrawerMob(context),
            body: SafeArea(
              child: NumberingSeriesPage(
                searchWidth: Screens.width(context) * 0.48,
                searchHeight: Screens.bodyheight(context) * 0.3,
                theme: theme,
              ),
            ));
      } else {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Numbering Series'),
            ),
            drawer: naviDrawer(),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        right: Screens.width(context) * 0.005,
                        left: Screens.width(context) * 0.005),
                    child: NumberingSeriesPage(
                      searchWidth: Screens.width(context) * 0.3,
                      searchHeight: Screens.bodyheight(context) * 0.96,
                      theme: theme,
                    ),
                  ),
                ]),
              ),
            ));
      }
    });
  }
}

//     return  Placeholder(
//       child: NumberingSeriesPage(),
//     );
//   }
// }