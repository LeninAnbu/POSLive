import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      height: widget.stkHeight,
      width: widget.stkWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              width: widget.stkWidth,
              padding: EdgeInsets.symmetric(
                  horizontal: widget.stkWidth * 0.015,
                  vertical: widget.stkHeight * 0.005),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Screens.width(context),
                      padding: EdgeInsets.only(top: 1, left: 10, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5)),
                      child: DropdownButton(
                        dropdownColor: Colors.white,
                        hint: Text(
                          "Select Main Group: ",
                        ),
                        value:
                            context.read<StockController>().valueSelectedMain,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 30,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        isExpanded: true,
                        onChanged: (val) {
                          setState(() {
                            context.read<StockController>().valueSelectedMain =
                                val.toString();
                            context
                                .read<StockController>()
                                .selectedMainGroup(val!);
                          });
                        },
                        items: context
                            .read<StockController>()
                            .mainValueValue
                            .map((e) {
                          return DropdownMenuItem(
                              value: "${e.code}",
                              child: Text(
                                '${e.name}',
                              ));
                        }).toList(),
                      ),
                    ),
                  ])),
          Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              width: widget.stkWidth,
              padding: EdgeInsets.symmetric(
                  horizontal: widget.stkWidth * 0.015,
                  vertical: widget.stkHeight * 0.005),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Screens.width(context),
                      padding: EdgeInsets.only(top: 1, left: 10, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5)),
                      child: DropdownButton(
                        dropdownColor: Colors.white,
                        hint: Text(
                          "Select Sub Group: ",
                        ),
                        value: context.read<StockController>().valueSelectedSub,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 30,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        isExpanded: true,
                        onChanged: (val) {
                          setState(() {
                            context.read<StockController>().valueSelectedSub =
                                val.toString();

                            context
                                .read<StockController>()
                                .selectedSubGroup(val!);
                          });
                        },
                        items: context
                            .read<StockController>()
                            .subValueValue
                            .map((e) {
                          return DropdownMenuItem(
                              value: "${e.code}",
                              child: Text(
                                '${e.name}',
                              ));
                        }).toList(),
                      ),
                    ),
                  ])),
          Container(
              decoration: BoxDecoration(),
              width: widget.stkWidth,
              padding: EdgeInsets.symmetric(
                  horizontal: widget.stkWidth * 0.015,
                  vertical: widget.stkHeight * 0.005),
              child: SizedBox(
                child: TextFormField(
                  controller:
                      context.read<StockController>().groupmycontroller[0],
                  onChanged: (val) {},
                  style: TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(05),
                      ),
                    ),
                    hintText: "Enter pack",
                  ),
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: widget.stkWidth * 0.2,
                height: widget.stkHeight * 0.055,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {});
                    },
                    onLongPress: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Icon(Icons.search)),
              ),
              SizedBox(
                width: widget.stkWidth * 0.5,
                height: widget.stkHeight * 0.055,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        context
                            .read<StockController>()
                            .groupmycontroller[1]
                            .text = '';
                        context.read<StockController>().visibleItemList = true;

                        context.read<StockController>().getAllListItem22(
                              context
                                      .read<StockController>()
                                      .valueSelectedMainName ??
                                  '_',
                              context
                                      .read<StockController>()
                                      .valueSelectedSubName ??
                                  '_',
                            );
                      });
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
                        context.read<StockController>().clearData();
                      });
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
    } else {
      i = 0;
    }
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
