import 'package:flutter/material.dart';
import 'package:posproject/Constant/padings.dart';
import 'package:posproject/DBModel/ItemMaster.dart';
import 'package:provider/provider.dart';
import '../../../../Controller/StockListsController/StockListsController.dart';
import '../../../Constant/Screen.dart';

class StockListScreen extends StatefulWidget {
  StockListScreen(
      {super.key,
      required this.stkCtrl,
      required this.stkHeight,
      required this.stkWidth});
  double stkHeight;
  double stkWidth;
  StockController stkCtrl;

  @override
  State<StockListScreen> createState() => _StockListScreenState();
}

class _StockListScreenState extends State<StockListScreen> {
  int? color = 0;

  Paddings paddings = Paddings();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      // padding: paddings.padding2(context),
      // padding: EdgeInsets.only(
      //     top: widget.stkHeight * 0.01,
      //     bottom: widget.stkHeight * 0.01,
      //     left: widget.stkWidth * 0.01,
      //     right: widget.stkWidth * 0.01),
      height: widget.stkHeight,
      width: widget.stkWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Container(
                decoration: BoxDecoration(
                    border:
                        Border.all(color: theme.primaryColor.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(8)),
                width: widget.stkWidth,
                padding: EdgeInsets.symmetric(
                    horizontal: widget.stkWidth * 0.015,
                    vertical: widget.stkHeight * 0.005),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Brand",
                        style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: Screens.width(context),
                        child: Wrap(
                            spacing: 10.0, // gap between adjacent chips
                            runSpacing: 10.0, // gap between lines
                            children: listContainers(
                                theme,
                                context.watch<StockController>().getbrandList,
                                context)),
                      ),
                      SizedBox(
                        height: widget.stkHeight * 0.005,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            // stkCtrl.viewAllDetails();
                            context
                                .read<StockController>()
                                .isSelectedBrandViewAll2();
                            context
                                .read<StockController>()
                                .isselectedbrandViewAllPage();
                          });

                          // print("widget.viewAll:${stkCtrl.viewAll}");
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          width: widget.stkWidth,
                          // child: InkWell(
                          // onTap: () {
                          //   widget.stkCtrl.viewAll = true;

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           StockListViewDetails(),
                          //     ));
                          //
                          // },
                          child: Text(
                            "View All",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(fontSize: 16, color: Colors.grey),
                          ),
                          // ),
                        ),
                      )
                    ])),
          ),
          Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Container(
                decoration: BoxDecoration(
                    border:
                        Border.all(color: theme.primaryColor.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(8)),
                width: widget.stkWidth,
                //height: Screens.bodyheight(context) * 0.26,
                padding: EdgeInsets.symmetric(
                    horizontal: widget.stkWidth * 0.015,
                    vertical: widget.stkHeight * 0.005),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Product",
                        style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: Screens.width(context),
                        child: Wrap(
                            spacing: 10.0, // gap between adjacent chips
                            runSpacing: 10.0, // gap between lines
                            children: listContainersProduct(
                                theme,
                                context.watch<StockController>().getproductList,
                                context)),
                      ),
                      SizedBox(
                        height: widget.stkHeight * 0.01,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            // stkCtrl.viewAllDetails();
                            context
                                .read<StockController>()
                                .isSelectedProductViewAll2();
                            context
                                .read<StockController>()
                                .isselectedProductViewAllPage();
                          });
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          width: widget.stkWidth,
                          // child: InkWell(
                          //   onTap: () {
                          //
                          //     // Navigator.push(
                          //     //     context,
                          //     //     MaterialPageRoute(
                          //     //       builder: (context) =>
                          //     //           StockListViewDetails(),
                          //     //     ));
                          //   },
                          child: Text(
                            "View All",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      ),
                      // )
                    ])),
          ),
          Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Container(
                decoration: BoxDecoration(
                    border:
                        Border.all(color: theme.primaryColor.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(8)),
                width: widget.stkWidth,
                padding: EdgeInsets.symmetric(
                    horizontal: widget.stkWidth * 0.015,
                    vertical: widget.stkHeight * 0.005),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Segment",
                        style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: Screens.width(context),
                        child: Wrap(
                            spacing: 10.0, // gap between adjacent chips
                            runSpacing: 10.0, // gap between lines
                            children: listContainersSegment(
                                theme,
                                context.watch<StockController>().getsegmentList,
                                context)),
                      ),
                      SizedBox(
                        height: widget.stkHeight * 0.005,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            context
                                .read<StockController>()
                                .isSelectedSegmentViewAll2();
                            context
                                .read<StockController>()
                                .isselectedSegmentViewAllPage();
                          });

                          // context.read<StockController>().viewAllDetails();
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          width: widget.stkWidth,
                          // child: InkWell(
                          // onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           StockListViewDetails(),
                          //     ));
                          //
                          // },
                          child: Text(
                            "View All",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(fontSize: 16, color: Colors.grey),
                          ),
                          // ),
                        ),
                      )
                    ])),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: widget.stkWidth * 0.2,
                height: widget.stkHeight * 0.055,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        context.read<StockController>().listshow = false;
                        widget.stkCtrl.showSearchDialogBox(context);
                      });
                    },
                    onLongPress: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Icon(Icons.search) //const Text('Search')
                    ),
              ),
              SizedBox(
                width: widget.stkWidth * 0.5,
                height: widget.stkHeight * 0.055,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        context.read<StockController>().setList();
                      });
                      // stkCtrl. viewSearchList();
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: ((context) => SearchStockList())));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Search')),
              ),
              SizedBox(
                width: widget.stkWidth * 0.15,
                height: widget.stkHeight * 0.055,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        context.read<StockController>().clearAllData();
                      });

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: ((context) => StockMainScreens(
                      //               theme: theme,
                      //             ))));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child:
                        const Icon(Icons.filter_alt_off) //const Text('Clear')
                    ),
              ),
            ],
          )
        ],
      ),
    );
  }

  isselectedBrand(int i) {
    if (i == 0) {
      i = 1;
      // addBrand(brandList[i].brand);
    } else {
      i = 0;
      // removeBrand(brandList[i].brand);
    }
    // notifyListeners();
  }

  List<Widget> listContainers(
      ThemeData theme, List<ItemMasterModelDB> content, BuildContext context) {
    if (content.length <= 9) {
      return List.generate(
        content.length,
        (index) => GestureDetector(
          onTap: () {
            context.read<StockController>().isselectedBrand(index);
            context.read<StockController>().isSelectedBPS();
            context.read<StockController>().listshow = false;
          },
          child: Container(
            alignment: Alignment.center,
            width: Screens.width(context) * 0.1,
            height: Screens.bodyheight(context) * 0.06,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: content[index].isselected == 1
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
                      color: content[index].isselected == 1
                          ? Colors.white
                          : theme.primaryColor,
                    ))
              ],
            ),
          ),
        ),
      );
    } else {
      return List.generate(
        9,
        (index) => GestureDetector(
          onTap: () {
            context.read<StockController>().isselectedBrand(index);
            context.read<StockController>().isSelectedBPS();
            context.read<StockController>().listshow = false;
          },
          child: Container(
            alignment: Alignment.center,
            width: Screens.width(context) * 0.1,
            height: Screens.bodyheight(context) * 0.06,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: content[index].isselected == 1
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
                      color: content[index].isselected == 1
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

  List<Widget> listContainersProduct(
      ThemeData theme, List<ItemMasterModelDB> content, BuildContext context) {
    if (content.length <= 9) {
      return List.generate(
        content.length,
        (index) => GestureDetector(
          onTap: () {
            context.read<StockController>().isselectedProduct(index);
            context.read<StockController>().isSelectedBPS();
            context.read<StockController>().listshow = false;
          },
          child: Container(
            alignment: Alignment.center,
            width: Screens.width(context) * 0.1,
            height: Screens.bodyheight(context) * 0.06,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: content[index].isselected == 1
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
                      color: content[index].isselected == 1
                          ? Colors.white
                          : theme.primaryColor,
                    ))
              ],
            ),
          ),
        ),
      );
    } else {
      return List.generate(
        9,
        (index) => GestureDetector(
          onTap: () {
            context.read<StockController>().isselectedProduct(index);
            context.read<StockController>().isSelectedBPS();
            context.read<StockController>().listshow = false;
          },
          child: Container(
            alignment: Alignment.center,
            width: Screens.width(context) * 0.1,
            height: Screens.bodyheight(context) * 0.06,

            ///   padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: content[index].isselected == 1
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
                      color: content[index].isselected == 1
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

  List<Widget> listContainersSegment(
      ThemeData theme, List<ItemMasterModelDB> content, BuildContext context) {
    if (content.length <= 9) {
      return List.generate(
        content.length,
        (index) => GestureDetector(
          onTap: () {
            context.read<StockController>().isselectedSegment(index);
            context.read<StockController>().isSelectedBPS();
            context.read<StockController>().listshow = false;
          },
          child: Container(
            alignment: Alignment.center,
            width: Screens.width(context) * 0.1,
            height: Screens.bodyheight(context) * 0.06,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: content[index].isselected == 1
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
                      color: content[index].isselected == 1
                          ? Colors.white
                          : theme.primaryColor,
                    ))
              ],
            ),
          ),
        ),
      );
    } else {
      return List.generate(
        9,
        (index) => GestureDetector(
          onTap: () {
            context.read<StockController>().isselectedSegment(index);
            context.read<StockController>().isSelectedBPS();
            context.read<StockController>().listshow = false;
          },
          child: Container(
            alignment: Alignment.center,
            width: Screens.width(context) * 0.1,
            height: Screens.bodyheight(context) * 0.06,

            ///   padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: content[index].isselected == 1
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
                      color: content[index].isselected == 1
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
}
