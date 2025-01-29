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

  // Future<bool> onbackpress() {
  //   DateTime now = DateTime.now(); //StockListController
  //   if (currentBackPressTime == null ||
  //       now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
  //     currentBackPressTime = now;
  //     print("are you sure");
  //     //if(context.read<StockListController>().getviewAll[0].brand != 'null'){
  //     if (context.read<StockListController>().getviewAllBrandSelected == true) {
  //       print("Brand");
  //       context.read<StockListController>().brandViewAllData().then((value) {
  //         context.read<StockListController>().clearViewAllData();
  //       });
  //     } else if (context
  //             .read<StockListController>()
  //             .getviewAllProductSelected ==
  //         true) {
  //       print("category");
  //       context.read<StockListController>().productViewAllData().then((value) {
  //         context.read<StockListController>().clearViewAllData();
  //       });
  //     } else {
  //       print("segment");
  //       context.read<StockListController>().segmentViewAllData().then((value) {
  //         context.read<StockListController>().clearViewAllData();
  //       });
  //     }
  //   }
  //  disa
  //   return Future.value(true);
  // }

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
                    //     if (context
                    //             .read<StockListController>()
                    //             .getviewAllBrandSelected ==
                    //         true) {
                    //       print("Brand");
                    //       context
                    //           .read<StockListController>()
                    //           .brandViewAllData()
                    //           .then((value) {
                    //         context
                    //             .read<StockListController>()
                    //             .clearViewAllData();
                    //       });
                    //     } else if (context
                    //             .read<StockListController>()
                    //             .getviewAllProductSelected ==
                    //         true) {
                    //       print("category");
                    //       context
                    //           .read<StockListController>()
                    //           .productViewAllData()
                    //           .then((value) {
                    //         context
                    //             .read<StockListController>()
                    //             .clearViewAllData();
                    //       });
                    //     } else {
                    //       print("segment");
                    //       context
                    //           .read<StockListController>()
                    //           .segmentViewAllData()
                    //           .then((value) {
                    //         context
                    //             .read<StockListController>()
                    //             .clearViewAllData();
                    //   });
                    // }
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
    // List<ItemMasterDBModel> content,
  ) {
    // if(content[0].brand != 'null'){
    // if (context.read<StockListController>().getviewAllBrandSelected == true) {
    return List.generate(
      42, // context.read<StockListController>().getviewAll.length,
      //    content.length,
      (index) => GestureDetector(
        onTap: () {
          // context.read<StockListController>().isselectedBrandViewAll(index);
        },
        child: Container(
          alignment: Alignment.center,
          width: Screens.width(context) * 0.28,
          height: Screens.bodyheight(context) * 0.06,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              // color: context
              //             .watch<StockListController>()
              //             .getviewAll[index]
              //             .isselected ==
              // 1
              //     content[index].isselected == 1
              // ? theme.primaryColor
              // :
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
                    // color: context
                    //             .watch<StockListController>()
                    //             .getviewAll[index]
                    //             .isselected ==
                    //         1
                    //     //content[index].isselected == 1
                    // ? Colors.white
                    // :
                    color: theme.primaryColor,
                  ))
            ],
          ),
        ),
      ),
    );
  }
  // else if(content[0].category != 'null'){

  // else if (context.read<StockListController>().getviewAllProductSelected ==
  //     true) {
  //   return List.generate(
  //     content.length,
  //     (index) => GestureDetector(
  //       onTap: () {
  //         context.read<StockListController>().isselectedProductViewAll(index);
  //       },
  //       child: Container(
  //         alignment: Alignment.center,
  //         width: Screens.width(context) * 0.28,
  //         height: Screens.bodyheight(context) * 0.06,
  //         padding: EdgeInsets.all(5),
  //         decoration: BoxDecoration(
  //             color: context
  //                         .watch<StockListController>()
  //                         .getviewAll[index]
  //                         .isselected ==
  //                     1
  //                 // content[index].isselected == 1
  //                 ? theme.primaryColor
  //                 : Colors.white,
  //             border: Border.all(color: theme.primaryColor, width: 1),
  //             borderRadius: BorderRadius.circular(10)),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text(content[index].category,
  //                 maxLines: 1,
  //                 overflow: TextOverflow.ellipsis,
  //                 style: theme.textTheme.bodyMedium?.copyWith(
  //                   fontSize: 10,
  //                   color: context
  //                               .watch<StockListController>()
  //                               .getviewAll[index]
  //                               .isselected ==
  //                           1
  //                       // content[index].isselected == 1
  //                       ? Colors.white
  //                       : theme.primaryColor,
  //                 ))
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // /// ELSE
  // ///
  //   return List.generate(
  //  10,
  //     (index) => GestureDetector(
  //       onTap: () {
  //         context.read<StockListController>().isselectedSegmentViewAll(index);
  //       },
  //       child: Container(
  //         alignment: Alignment.center,
  //         width: Screens.width(context) * 0.28,
  //         height: Screens.bodyheight(context) * 0.06,
  //         padding: EdgeInsets.all(5),
  //         decoration: BoxDecoration(
  //             color: context
  //                         .watch<StockListController>()
  //                         .getviewAll[index]
  //                         .isselected ==
  //                     1
  //                 //content[index].isselected == 1
  //                 ? theme.primaryColor
  //                 : Colors.white,
  //             border: Border.all(color: theme.primaryColor, width: 1),
  //             borderRadius: BorderRadius.circular(10)),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text(content[index].segment,
  //                 maxLines: 1,
  //                 overflow: TextOverflow.ellipsis,
  //                 style: theme.textTheme.bodyMedium?.copyWith(
  //                   fontSize: 10,
  //                   color: context
  //                               .watch<StockListController>()
  //                               .getviewAll[index]
  //                               .isselected ==
  //                           1
  //                       //content[index].isselected == 1
  //                       ? Colors.white
  //                       : theme.primaryColor,
  //                 ))
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
}
