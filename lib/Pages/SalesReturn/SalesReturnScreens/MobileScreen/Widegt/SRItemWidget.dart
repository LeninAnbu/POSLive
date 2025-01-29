import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Controller/SalesReturnController/SalesReturnController.dart';

class SRItemWid extends StatelessWidget {
  const SRItemWid({
    super.key,
    required this.salesReturnController,
    required this.theme,
  });

  final SalesReturnController salesReturnController;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Screens.width(context),
      // height: Screens.bodyheight(context) * 0.3,
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
      padding: EdgeInsets.symmetric(
          //  horizontal: Screens.width(context) * 0.02,
          vertical: Screens.padingHeight(context) * 0.01),
      child: Column(
        children: [
          salesReturnController.getScanneditemData.isEmpty
              ? Container()
              // : Expanded(
              //     child: ListView.builder(
              //         itemCount: salesReturnController.getScanneditemData.length,
              //         //prdsrch.getsalesInvoiceData[0].item!.length,
              //         itemBuilder: (context, index) {
              //           return Card(
              //             child: Container(
              //                 padding: EdgeInsets.only(
              //                   top: Screens.bodyheight(context) * 0.01,
              //                   left: Screens.width(context) * 0.01,
              //                   right: Screens.width(context) * 0.01,
              //                   bottom: Screens.bodyheight(context) * 0.02,
              //                 ),
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(5),
              //                   color: Colors.grey.withOpacity(0.04),
              //                 ),
              //                 child: Column(children: [
              //                   Row(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       Row(
              //                         mainAxisAlignment:
              //                             MainAxisAlignment.spaceBetween,
              //                         children: [
              //                           Container(
              //                             color: Colors.red,
              //                               width: Screens.width(context) * 0.5,
              //                               // height: searchHeight * 0.02,
              //                               alignment: Alignment.centerLeft,
              //                               child: TextButton(
              //                                   onPressed: () {},
              //                                   child: Text(
              //                                   "${salesReturnController.getScanneditemData[index].itemName}",//  "${prdsrch.getsalesInvoiceData[index].item![index].itemName}",
              //                                     maxLines: 2,
              //                                     //  "${prdsrch.getScanneditemData[index].itemName}",
              //                                     style: theme
              //                                         .textTheme.bodyText2
              //                                         ?.copyWith(
              //                                             color: Colors.black),
              //                                   ))),
              //                         ],
              //                       ),
              //                       Container(
              //                          color: Colors.amber,
              //                         width: Screens.width(context) * 0.2,
              //                         child: Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.spaceEvenly,
              //                           children: [
              //                             InkWell(
              //                               onTap: () {
              //                                  salesReturnController.itemdecrement(index);
              //                               },
              //                               child: Container(
              //                                 alignment: Alignment.center,
              //                                 width: Screens.width(context) * 0.05,
              //                                 height: Screens.bodyheight(context) * 0.05,
              //                                 color: Colors.blue,
              //                                 child: Icon(
              //                                   Icons.remove,
              //                                   color: Colors.white,
              //                                   size: Screens.bodyheight(context) * 0.05,
              //                                 ),
              //                               ),
              //                             ),
              //                             Container(
              //                               alignment: Alignment.center,
              //                               // width: Screens.width(context) * 0.015,
              //                               padding: EdgeInsets.symmetric(
              //                                   horizontal:
              //                                       Screens.width(context) * 0.005),
              //                               // height: searchHeight *
              //                               //     0.025,
              //                               child: Text(
              //                                "${salesReturnController.getScanneditemData[index].Qty}",//    "${prdsrch.getsalesInvoiceData[index].item![index].Qty}",
              //                                   style: theme.textTheme.bodyText2
              //                                       ?.copyWith(
              //                                           color: Colors.black)),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                       Container(
              //                         width: Screens.width(context) * 0.16,
              //                          color: Colors.blue,
              //                         alignment: Alignment.centerRight,
              //                         child: Text(
              //                           "${salesReturnController.getScanneditemData[index].SellPrice}",//  "${prdsrch.getsalesInvoiceData[index].item![index].SellPrice}",
              //                           style: theme.textTheme.bodyText2
              //                               ?.copyWith(color: Colors.black),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                   SizedBox(
              //                     height: Screens.bodyheight(context) * 0.01,
              //                   ),
              //                   Row(
              //                     children: [
              //                       Container(
              //                           alignment: Alignment.centerLeft,
              //                           child: Text(
              //                        "${salesReturnController.getScanneditemData[index].SerialBatch}",//      "${prdsrch.getsalesInvoiceData[index].item![index].SerialBatch}",
              //                             textAlign: TextAlign.start,
              //                             style: theme.textTheme.bodyText2
              //                                 ?.copyWith(),
              //                           )),
              //                       Container(
              //                         alignment: Alignment.centerLeft,
              //                         child: Text(
              //                       "  |  ${salesReturnController.getScanneditemData[index].ItemCode}",//    "  |  ${prdsrch.getsalesInvoiceData[index].item![index].ItemCode}",
              //                           style: theme.textTheme.bodyText2
              //                               ?.copyWith(),
              //                         ),
              //                       ),
              //                     ],
              //                   )
              //                 ])),
              //           );
              //         })),

              : ListView.builder(
                  itemCount: salesReturnController.getScanneditemData.length,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                            padding: EdgeInsets.only(
                              top: Screens.bodyheight(context) * 0.01,
                              left: Screens.width(context) * 0.01,
                              right: Screens.width(context) * 0.01,
                              bottom: Screens.bodyheight(context) * 0.01,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200],
                            ),
                            child: Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      //color: Colors.red,
                                      width: Screens.width(context) * 0.4,
                                      // height: searchHeight * 0.02,
                                      alignment: Alignment.centerLeft,
                                      child: TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "${salesReturnController.getScanneditemData[index].itemName}",
                                            maxLines: 2,
                                            // "${prdsrch.getScanneditemData[index].itemName}",
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          ))),
                                  SizedBox(
                                    width: Screens.width(context) * 0.46,
                                    // color: Colors.green,

                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            width:
                                                Screens.width(context) * 0.11,
                                            height:
                                                Screens.padingHeight(context) *
                                                    0.05,
                                            // color: Colors.blue,
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              autofocus: true,
                                              style: theme.textTheme.bodyMedium,
                                              onChanged: (v) {},
                                              cursorColor: Colors.grey,
                                              textDirection: TextDirection.rtl,
                                              keyboardType:
                                                  TextInputType.number,
                                              onEditingComplete: () {
                                                salesReturnController
                                                    .itemIncrement11(
                                                        index, context, theme);
                                              },
                                              controller: salesReturnController
                                                  .qtymycontroller[index],
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
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
                                        //   width: Screens.width(context) * 0.46,
                                        //   // color: Colors.green,

                                        //   child: Row(
                                        //     mainAxisAlignment:
                                        //         MainAxisAlignment.spaceBetween,
                                        //     children: [
                                        //       Container(
                                        //         child: Container(
                                        //           // color: Colors.amber,
                                        //           width: Screens.width(context) * 0.22,
                                        //           child: Row(
                                        //             mainAxisAlignment:
                                        //                 MainAxisAlignment
                                        //                     .spaceBetween,
                                        //             children: [
                                        //               InkWell(
                                        //                 onTap: () {
                                        //                   salesReturnController
                                        //                       .itemdecrement(index);
                                        //                 },
                                        //                 child: Container(
                                        //                   alignment: Alignment.center,
                                        //                   width:
                                        //                       Screens.width(context) *
                                        //                           0.08,
                                        //                   height:
                                        //                       Screens.padingHeight(
                                        //                               context) *
                                        //                           0.05,
                                        //                   decoration: BoxDecoration(
                                        //                     shape: BoxShape.circle,
                                        //                     color: Colors.blue,
                                        //                   ),
                                        //                   child: Icon(
                                        //                     Icons.remove,
                                        //                     color: Colors.white,
                                        //                     size:
                                        //                         Screens.padingHeight(
                                        //                                 context) *
                                        //                             0.03,
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //               Container(
                                        //                 alignment: Alignment.center,
                                        //                 // width: Screens.width(context) * 0.015,
                                        //                 padding: EdgeInsets.symmetric(
                                        //                     horizontal: Screens.width(
                                        //                             context) *
                                        //                         0.005),
                                        //                 // height: searchHeight *
                                        //                 //     0.025,
                                        //                 child: Text(
                                        //                     "${salesReturnController.getScanneditemData[index].Qty}",
                                        //                     style: theme
                                        //                         .textTheme.bodyText2
                                        //                         ?.copyWith(
                                        //                             color: Colors
                                        //                                 .black)),
                                        //               ),
                                        //               InkWell(
                                        //                 onTap: () {
                                        //                   salesReturnController
                                        //                       .itemIncrement(index,
                                        //                           context, theme);
                                        //                 },
                                        //                 child: Container(
                                        //                   alignment: Alignment.center,
                                        //                   width:
                                        //                       Screens.width(context) *
                                        //                           0.08,
                                        //                   height:
                                        //                       Screens.padingHeight(
                                        //                               context) *
                                        //                           0.05,
                                        //                   decoration: BoxDecoration(
                                        //                     shape: BoxShape.circle,
                                        //                     color: Colors.blue,
                                        //                   ),
                                        //                   child: Icon(
                                        //                     Icons.add,
                                        //                     color: Colors.white,
                                        //                     size:
                                        //                         Screens.padingHeight(
                                        //                                 context) *
                                        //                             0.03,
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       ),
                                        Container(
                                            // color: Colors.red,
                                            width:
                                                Screens.width(context) * 0.12,
                                            alignment: Alignment.center,
                                            child: Text(
                                              "${salesReturnController.getScanneditemData[index].discountper}",
                                              textAlign: TextAlign.start,
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(),
                                            )),
                                        Container(
                                            // color: Colors.green,
                                            width: Screens.width(context) * 0.2,
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              salesReturnController.config
                                                  .splitValues(
                                                      salesReturnController
                                                          .getScanneditemData[
                                                              index]
                                                          .taxvalue!
                                                          .toStringAsFixed(2)),
                                              textAlign: TextAlign.start,
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Screens.padingHeight(context) * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Container(
                                            // color: Colors.green,
                                            // width: Screens.width(context) * 0.2,
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${salesReturnController.getScanneditemData[index].serialBatch}",
                                              textAlign: TextAlign.start,
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(),
                                            )),
                                        // Container(
                                        //   //  color: Colors.blue,
                                        //   alignment: Alignment.topLeft,
                                        //   width: Screens.width(context) * 0.02,
                                        //   child: Text(
                                        //     // "  |  DC-ABV12K-1YR",
                                        //     "  |  ",
                                        //     style: theme.textTheme.bodyText2
                                        //         ?.copyWith(),
                                        //   ),
                                        // ),
                                        Container(
                                          //  color: Colors.red,
                                          alignment: Alignment.topLeft,
                                          width: Screens.width(context) * 0.3,
                                          child: Text(
                                            // "  |  DC-ABV12K-1YR",
                                            "  |  ${salesReturnController.getScanneditemData[index].itemCode}",
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
                                      salesReturnController.config.splitValues(
                                          "${salesReturnController.getScanneditemData[index].sellPrice}"),
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
        ],
      ),
    );
  }
}
