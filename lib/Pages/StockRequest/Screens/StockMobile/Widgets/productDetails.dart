import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Controller/StockRequestController/StockRequestController.dart';

import 'SearchItems.dart';

class ProductWidget extends StatelessWidget {
  ProductWidget({
    super.key,
    required this.prdsrch,
  });

  StockReqController prdsrch;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: Screens.width(context),
      padding: EdgeInsets.only(
        top: Screens.bodyheight(context) * 0.01,
        bottom: Screens.bodyheight(context) * 0.02,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: Screens.width(context) * 0.95,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 240, 235, 235)),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                child: TextField(
                  controller: prdsrch.searchcon,
                  style:
                      theme.textTheme.bodyLarge!.copyWith(color: Colors.black),
                  keyboardType: TextInputType.text,
                  onEditingComplete: () {
                    prdsrch.getAllList(prdsrch.searchcon.text).then((value) {
                      showDialog<dynamic>(
                          context: context,
                          builder: (_) {
                            return const SearchItems();
                          });
                    });
                  },
                  onChanged: (val) {},
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(8),
                    hintText: "Inventories",
                    hintStyle: theme.textTheme.bodyMedium!.copyWith(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        prdsrch
                            .getAllList(prdsrch.searchcon.text)
                            .then((value) {
                          showDialog<dynamic>(
                              context: context,
                              builder: (_) {
                                return const SearchItems();
                              });
                        });
                      },
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
              )
            ],
          ),
          SizedBox(
            height: Screens.bodyheight(context) * 0.004,
          ),
          prdsrch.getScanneditemData.isEmpty
              ? Container()
              : Container(
                  color: Colors.white,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(), // new

                      itemCount: prdsrch.getScanneditemData.length,
                      itemBuilder: (context, index) {
                        return Card(
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
                                      SizedBox(
                                        width: Screens.width(context),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width:
                                                  Screens.width(context) * 0.49,
                                              padding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.006),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: Text(
                                                "${prdsrch.getScanneditemData[index].itemName}",
                                                style: theme
                                                    .textTheme.bodySmall!
                                                    .copyWith(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    prdsrch
                                                        .itemdecrement(index);
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width:
                                                        Screens.width(context) *
                                                            0.08,
                                                    height:
                                                        Screens.padingHeight(
                                                                context) *
                                                            0.05,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.blue,
                                                    ),
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: Colors.white,
                                                      size:
                                                          Screens.padingHeight(
                                                                  context) *
                                                              0.03,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: Screens.width(
                                                              context) *
                                                          0.005),
                                                  child: Text(
                                                      "${prdsrch.getScanneditemData[index].qty}",
                                                      style: theme
                                                          .textTheme.bodyMedium
                                                          ?.copyWith(
                                                              color: Colors
                                                                  .black)),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    prdsrch.itemIncrementClick(
                                                        index, context, theme);
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width:
                                                        Screens.width(context) *
                                                            0.08,
                                                    height:
                                                        Screens.padingHeight(
                                                                context) *
                                                            0.05,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.blue,
                                                    ),
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                      size:
                                                          Screens.padingHeight(
                                                                  context) *
                                                              0.03,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ), //
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.002,
                                      ),
                                      SizedBox(
                                        width: Screens.width(context),
                                        child: IntrinsicHeight(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: Screens.width(context) *
                                                    0.32,
                                                padding: EdgeInsets.all(
                                                    Screens.bodyheight(
                                                            context) *
                                                        0.005),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: Text(
                                                  "${prdsrch.getScanneditemData[index].serialBatch}",
                                                  style: theme
                                                      .textTheme.bodyMedium!
                                                      .copyWith(),
                                                ),
                                              ),
                                              Container(
                                                width: Screens.width(context) *
                                                    0.35,
                                                decoration:
                                                    const BoxDecoration(),
                                                child: Text(
                                                  "  |  ${prdsrch.getScanneditemData[index].itemCode}",
                                                  style: theme
                                                      .textTheme.bodyMedium!
                                                      .copyWith(),
                                                ),
                                              ),
                                              Container(
                                                width: Screens.width(context) *
                                                    0.23,
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  prdsrch.config.splitValues(
                                                      "${prdsrch.getScanneditemData[index].sellPrice}"),
                                                  style: theme
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                          color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                              )),
                        );
                      }),
                ),
        ],
      ),
    );
  }
}
