import 'package:flutter/material.dart';
import '../../../../../Constant/Screen.dart';
import '../../../../../Controller/SalesOrderController/SalesOrderController.dart';

class ItemSearchWidget extends StatelessWidget {
  const ItemSearchWidget({
    super.key,
    required this.theme,
    required this.prdCD,
  });

  final ThemeData theme;
  final SOCon prdCD;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Screens.width(context),
      // height: Screens.padingHeight(context)*0.5,
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
          Container(
              alignment: Alignment.center,
              width: Screens.width(context),
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 240, 235, 235)),
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey.withOpacity(0.01),
              ),
              child: TextFormField(
                autofocus: true,

                // onTap: () async {
                //   print("object");
                //   prdCD.source1 = await prdCD.getPathOFDB();
                //   prdCD.copyTo = await prdCD.getDirectory();

                //   bool permission = await prdCD.getPermissionStorage();
                //   if (permission == true) {
                //     if ((await prdCD.copyTo!.exists())) {
                //       print("EXISTS");
                //       prdCD.createDBFile(prdCD.copyTo!.path);
                //     } else {
                //       print("Not EXISTS");
                //       prdCD.createDirectory();
                //     }
                //   } else if (permission == false) {
                //     prdCD.showSnackBars(
                //         'Please give stoage permission to continue!!..',
                //         Colors.red);
                //   }
                // },
                // readOnly: true,
                style: theme.textTheme.bodyMedium,
                cursorColor: Colors.grey,
                onChanged: (v) {},
                controller: prdCD.mycontroller[99],
                focusNode: prdCD.focusnode[0],
                onEditingComplete: () {
                  // prdCD.forItemCodecheck(context, theme);

                  // prdCD.scannBAtch(context, theme);
                },
                decoration: InputDecoration(
                  filled: false,
                  hintText: 'Inventories',
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(
                      //  color: Colors.grey
                      //   fontWeight: FontWeight.normal
                      ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                      // size: searchHeight * 0.05,
                      color: Colors.grey,
                    ),
                    onPressed: () async {
                      prdCD.source1 = await prdCD.getPathOFDB();
                      prdCD.copyTo = await prdCD.getDirectory();

                      bool permission = await prdCD.getPermissionStorage();
                      if (permission == true) {
                        if ((await prdCD.copyTo!.exists())) {
                          prdCD.createDBFile(prdCD.copyTo!.path);
                        } else {
                          prdCD.createDirectory();
                        }
                      } else if (permission == false) {
                        prdCD.showSnackBars(
                            'Please give stoage permission to continue!!..',
                            Colors.red);
                      }
                    },
                    color: theme.primaryColor,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                ),
              )),

          //  Expanded(
          // child:
          ListView.builder(
              itemCount: prdCD.getScanneditemData.length,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Card(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                        padding: EdgeInsets.only(
                          top: Screens.padingHeight(context) * 0.01,
                          left: Screens.width(context) * 0.01,
                          right: Screens.width(context) * 0.03,
                          bottom: Screens.padingHeight(context) * 0.02,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      //  color: Colors.red,
                                      width: Screens.width(context) * 0.4,
                                      // height: searchHeight * 0.02,
                                      alignment: Alignment.centerLeft,
                                      child: TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "${prdCD.getScanneditemData[index].itemName}",
                                            maxLines: 2,
                                            // "${prdsrch.getScanneditemData[index].ItemName}",
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          ))),
                                ],
                              ),
                              Container(
                                  width: Screens.width(context) * 0.11,
                                  height: Screens.padingHeight(context) * 0.05,
                                  // color: Colors.blue,
                                  alignment: Alignment.center,
                                  child: TextFormField(
                                    autofocus: true,
                                    style: theme.textTheme.bodyMedium,
                                    onChanged: (v) {},
                                    cursorColor: Colors.grey,
                                    textDirection: TextDirection.ltr,
                                    keyboardType: TextInputType.number,
                                    onEditingComplete: () {
                                      prdCD.itemIncrement11(
                                          index, context, theme);
                                    },
                                    controller: prdCD.qtymycontroller[index],
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 5,
                                      ),
                                    ),
                                  )),
                              // Container(
                              //   // color: Colors.amber,
                              //   // width: Screens.width(context) * 0.23,
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceEvenly,
                              //     children: [
                              //       InkWell(
                              //         onTap: () {
                              //           prdCD.itemdecrement(
                              //               context, theme, index);
                              //         },
                              //         child: Container(
                              //           alignment: Alignment.center,
                              //           width: Screens.width(context) * 0.08,
                              //           height: Screens.padingHeight(context) *
                              //               0.05,
                              //           decoration: BoxDecoration(
                              //             shape: BoxShape.circle,
                              //             color: Colors.blue,
                              //           ),
                              //           child: Icon(
                              //             Icons.remove,
                              //             color: Colors.white,
                              //             size: Screens.padingHeight(context) *
                              //                 0.03,
                              //           ),
                              //         ),
                              //       ),
                              //       Container(
                              //         alignment: Alignment.center,
                              //         // width: Screens.width(context) * 0.015,
                              //         padding: EdgeInsets.symmetric(
                              //             horizontal:
                              //                 Screens.width(context) * 0.005),
                              //         // height: searchHeight *
                              //         //     0.025,
                              //         child: Text(
                              //             "${prdCD.getScanneditemData[index].Qty}",
                              //             style: theme.textTheme.bodyText2
                              //                 ?.copyWith(color: Colors.black)),
                              //       ),
                              //       InkWell(
                              //         onTap: () {
                              //           prdCD.itemIncrement(
                              //               index, context, theme);
                              //         },
                              //         child: Container(
                              //           alignment: Alignment.center,
                              //           width: Screens.width(context) * 0.08,
                              //           height: Screens.padingHeight(context) *
                              //               0.05,
                              //           decoration: BoxDecoration(
                              //             shape: BoxShape.circle,
                              //             color: Colors.blue,
                              //           ),
                              //           child: Icon(
                              //             Icons.add,
                              //             color: Colors.white,
                              //             size: Screens.padingHeight(context) *
                              //                 0.03,
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Container(
                                  width: Screens.width(context) * 0.11,
                                  height: Screens.padingHeight(context) * 0.05,
                                  // color: Colors.blue,
                                  alignment: Alignment.center,
                                  child: TextFormField(
                                    autofocus: true,
                                    style: theme.textTheme.bodyMedium,
                                    onChanged: (v) {},
                                    cursorColor: Colors.grey,
                                    textDirection: TextDirection.ltr,
                                    keyboardType: TextInputType.number,
                                    onEditingComplete: () {
                                      prdCD.calCulateDocVal(context, theme);
                                    },
                                    controller: prdCD.mycontroller[index],
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 5,
                                      ),
                                    ),
                                  )),
                              Container(
                                alignment: Alignment.center,
                                // width: Screens.width(context) * 0.015,
                                padding: EdgeInsets.symmetric(
                                    horizontal: Screens.width(context) * 0.005),
                                // height: searchHeight *
                                //     0.025,
                                child: Text(
                                    prdCD.config.slpitCurrency2(
                                        ' ${prdCD.getScanneditemData[index].taxvalue!.toStringAsFixed(2)}'),
                                    style: theme.textTheme.bodyMedium
                                        ?.copyWith(color: Colors.black)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Screens.padingHeight(context) * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Container(
                                        // color: Colors.green,
                                        // width: Screens.width(context) * 0.3,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "${prdCD.getScanneditemData[index].serialBatch}",
                                          textAlign: TextAlign.start,
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(),
                                        )),
                                    Container(
                                      //  color: Colors.blue,
                                      alignment: Alignment.topLeft,
                                      // width: Screens.width(context) * 0.02,
                                      child: Text(
                                        // "  |  DC-ABV12K-1YR",
                                        "  |  ",
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(),
                                      ),
                                    ),
                                    Container(
                                      //  color: Colors.red,
                                      alignment: Alignment.topLeft,
                                      // width: Screens.width(context) * 0.3,
                                      child: Text(
                                        // "  |  DC-ABV12K-1YR",
                                        "${prdCD.getScanneditemData[index].itemCode}",
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: Screens.width(context) * 0.28,
                                // color: Colors.blue,
                                alignment: Alignment.centerRight,
                                child: Text(
                                  prdCD.config.slpitCurrency2(
                                      "${prdCD.getScanneditemData[index].sellPrice}"),
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.black),
                                ),
                              ),
                            ],
                          )
                        ])),
                  ),
                );
              })
          //),
        ],
      ),
    );
  }
}
