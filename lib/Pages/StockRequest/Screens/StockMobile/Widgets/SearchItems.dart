import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../Constant/Screen.dart';
import '../../../../../Controller/StockRequestController/StockRequestController.dart';

class SearchItems extends StatefulWidget {
  const SearchItems({
    super.key,
  });
// final List<StockSnapTModelDB>? searchedData;
  @override
  State<SearchItems> createState() => _SearchItemsState();
}

class _SearchItemsState extends State<SearchItems> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
        insetPadding: const EdgeInsets.all(10),
        contentPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        content: Container(
          width: Screens.width(context),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: Screens.width(context) * 0.93,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 240, 235, 235)),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    child: TextField(
                      style: theme.textTheme.bodyLarge!
                          .copyWith(color: Colors.black),
                      keyboardType: TextInputType.text,
                      onEditingComplete: () {},
                      onChanged: (val) {
                        setState(() {
                          context
                              .read<StockReqController>()
                              .filterListSearched(val);
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(8),
                        hintText: "Inventories",
                        hintStyle: theme.textTheme.bodyMedium!.copyWith(),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              SizedBox(
                height: Screens.bodyheight(context) * 0.01,
              ),
              Expanded(
                child: context
                        .read<StockReqController>()
                        .getfilterSearchedData
                        .isEmpty
                    ? const Center(child: Text("No data Found..!!"))
                    : ListView.builder(
                        itemCount: context
                            .watch<StockReqController>()
                            .getfilterSearchedData
                            .length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              setState(() {
                                context.read<StockReqController>().onseletFst(
                                    context,
                                    theme,
                                    context
                                        .read<StockReqController>()
                                        .getfilterSearchedData[index]);
                                context
                                    .read<StockReqController>()
                                    .visibleItemList = false;
                                context
                                    .read<StockReqController>()
                                    .disableKeyBoard(context);
                                log("dattaa down");
                                Navigator.pop(context);
                              });
                            },
                            child: Card(
                              child: Container(
                                  width: Screens.bodyheight(context) * 0.8,
                                  padding: EdgeInsets.only(
                                    top: Screens.bodyheight(context) * 0.01,
                                    left: Screens.width(context) * 0.01,
                                    right: Screens.width(context) * 0.01,
                                    bottom: Screens.bodyheight(context) * 0.005,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                  ),
                                  child: IntrinsicHeight(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${context.watch<StockReqController>().getfilterSearchedData[index].itemcode}"),
                                        Text(
                                            "${context.watch<StockReqController>().getfilterSearchedData[index].itemnameshort}"),
                                      ],
                                    ),
                                  )),
                            ),
                          );
                        }),
              )
            ],
          ),
        ));
  }
}
