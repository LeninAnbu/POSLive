import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Constant/padings.dart';
import 'package:posproject/Pages/Sales%20Screen/Screens/MobileScreenSales/AppBar/AppBarMS.dart';
import 'package:posproject/Pages/Stockslist/Screens/Screens.dart';
import 'package:posproject/Widgets/MobileDrawer.dart';

class StockListViewDetails extends StatefulWidget {
  const StockListViewDetails({super.key});

  @override
  State<StockListViewDetails> createState() => StockListViewDetailsState();
}

class StockListViewDetailsState extends State<StockListViewDetails> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: appbarMS("Stock List", theme, context),
        drawer: naviDrawerMob(context),
        body: Container(
          alignment: Alignment.center,
          width: Screens.width(context),
          height: Screens.bodyheight(context),
          padding: paddings.padding3(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Wrap(
                          spacing: 10.0, // gap between adjacent chips
                          runSpacing: 15.0, // gap between lines
                          children: listContainersProduct(
                            theme,
                          )),
                    );
                  },
                ),
              ),
              SizedBox(
                width: Screens.width(context),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => StockMainScreens(
                                  theme: theme,
                                ))));
                  },
                  child: const Text("OK"),
                ),
              )
            ],
          ),
        ));
  }

  List<Widget> listContainersProduct(
    ThemeData theme,
  ) {
    return List.generate(
      42, // context.read<StockListController>().getviewAll.length,

      (index) => GestureDetector(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          width: Screens.width(context) * 0.28,
          height: Screens.bodyheight(context) * 0.06,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Crompton",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.primaryColor,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
