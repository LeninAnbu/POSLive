import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Constant/padings.dart';
import 'package:posproject/Controller/StockListsController/StockListsController.dart';
import 'package:provider/provider.dart';

import '../../../DBModel/ItemMaster.dart';

class ViewAllDetails extends StatefulWidget {
  ViewAllDetails(
      {super.key,
      required this.stkHeight,
      required this.stkWidth,
      required this.stkCtrl});
  double stkHeight;
  double stkWidth;
  StockController stkCtrl;
  @override
  State<ViewAllDetails> createState() => ViewAllDetailsState();
}

class ViewAllDetailsState extends State<ViewAllDetails> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  DateTime? currentBackPressTime;

  // Future<bool> onbackpress() {
  //   DateTime now = DateTime.now(); //StockController
  //   if (currentBackPressTime == null ||
  //       now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
  //     currentBackPressTime = now;
  //     print("are you sure");
  //     //if(context.read<StockController>().getviewAll[0].brand != 'null'){
  //     if (context.read<StockController>().getviewAllBrandSelected == true) {
  //       print("Brand");
  //       context.read<StockController>().brandViewAllData().then((value) {
  //         context.read<StockController>().clearViewAllData();
  //       });
  //     } else if (context
  //             .read<StockController>()
  //             .getviewAllProductSelected ==
  //         true) {
  //       print("category");
  //       context.read<StockController>().productViewAllData().then((value) {
  //         context.read<StockController>().clearViewAllData();
  //       });
  //     } else {
  //       print("segment");
  //       context.read<StockController>().segmentViewAllData().then((value) {
  //         context.read<StockController>().clearViewAllData();
  //       });
  //     }
  //   }
  //   ScaffoldMessenger.of(context).removeCurrentSnackBar();
  //   return Future.value(true);
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        padding: EdgeInsets.only(
            top: widget.stkHeight * 0.01,
            bottom: widget.stkHeight * 0.01,
            left: widget.stkWidth * 0.01,
            right: widget.stkWidth * 0.01),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        alignment: Alignment.center,
        width: widget.stkWidth,
        height: widget.stkHeight,
        // padding: paddings.padding3(context),
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
                            theme, context.read<StockController>().getviewAll)),
                  );
                },
              ),
            ),
            SizedBox(
              width: Screens.width(context),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    // Navigator.push(
                    //     context,
                    // MaterialPageRoute(
                    //     builder: ((context) => StockMainScreens(
                    //           theme: theme,
                    //         ))));
                    if (context
                            .read<StockController>()
                            .getviewAllBrandSelected ==
                        true) {
                      context
                          .read<StockController>()
                          .brandViewAllData()
                          .then((value) {
                        context.read<StockController>().clearViewAllData();
                      });
                    } else if (context
                            .read<StockController>()
                            .getviewAllProductSelected ==
                        true) {
                      context
                          .read<StockController>()
                          .productViewAllData()
                          .then((value) {
                        context.read<StockController>().clearViewAllData();
                      });
                    } else {
                      context
                          .read<StockController>()
                          .segmentViewAllData()
                          .then((value) {
                        context.read<StockController>().clearViewAllData();
                      });
                    }
                  });
                },
                child: const Text("OK"),
              ),
            )
          ],
        ));
  }

  List<Widget> listContainersProduct(
    ThemeData theme,
    List<ItemMasterModelDB> content,
  ) {
    // if(content[0].brand != 'null'){
    if (context.read<StockController>().getviewAllBrandSelected == true) {
      return List.generate(
        context.read<StockController>().getviewAll.length,
        //    content.length,
        (index) => GestureDetector(
          onTap: () {
            context.read<StockController>().isselectedBrandViewAll(index);
          },
          child: Container(
            alignment: Alignment.center,
            width: Screens.width(context) * 0.1,
            height: Screens.bodyheight(context) * 0.06,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: context
                            .watch<StockController>()
                            .getviewAll[index]
                            .isselected ==
                        1
                    //     content[index].isselected == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(content[index].brand!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontSize: 10,
                      color: context
                                  .watch<StockController>()
                                  .getviewAll[index]
                                  .isselected ==
                              1
                          //content[index].isselected == 1
                          ? Colors.white
                          : theme.primaryColor,
                    ))
              ],
            ),
          ),
        ),
      );
    }
    // else if(content[0].category != 'null'){

    else if (context.read<StockController>().getviewAllProductSelected ==
        true) {
      return List.generate(
        content.length,
        (index) => GestureDetector(
          onTap: () {
            context.read<StockController>().isselectedProductViewAll(index);
          },
          child: Container(
            alignment: Alignment.center,
            width: Screens.width(context) * 0.1,
            height: Screens.bodyheight(context) * 0.06,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: context
                            .watch<StockController>()
                            .getviewAll[index]
                            .isselected ==
                        1
                    // content[index].isselected == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(content[index].itemcode!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontSize: 10,
                      color: context
                                  .watch<StockController>()
                                  .getviewAll[index]
                                  .isselected ==
                              1
                          // content[index].isselected == 1
                          ? Colors.white
                          : theme.primaryColor,
                    ))
              ],
            ),
          ),
        ),
      );
    }

    /// ELSE
    ///
    return List.generate(
      content.length,
      (index) => GestureDetector(
        onTap: () {
          context.read<StockController>().isselectedSegmentViewAll(index);
        },
        child: Container(
          alignment: Alignment.center,
          width: Screens.width(context) * 0.1,
          height: Screens.bodyheight(context) * 0.06,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: context
                          .watch<StockController>()
                          .getviewAll[index]
                          .isselected ==
                      1
                  //content[index].isselected == 1
                  ? theme.primaryColor
                  : Colors.white,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(content[index].itemnameshort!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontSize: 10,
                    color: context
                                .watch<StockController>()
                                .getviewAll[index]
                                .isselected ==
                            1
                        //content[index].isselected == 1
                        ? Colors.white
                        : theme.primaryColor,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
