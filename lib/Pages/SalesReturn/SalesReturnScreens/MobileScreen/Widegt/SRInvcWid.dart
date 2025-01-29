import 'package:flutter/material.dart';
import '../../../../../Constant/Screen.dart';
import '../../../../../Controller/SalesReturnController/SalesReturnController.dart';

class SRInvcCusWid extends StatelessWidget {
  const SRInvcCusWid({
    super.key,
    required this.salesReturnController,
    required this.theme,
  });

  final SalesReturnController salesReturnController;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      //customer
      children: [
        Container(
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
              horizontal: Screens.width(context) * 0.02,
              vertical: Screens.padingHeight(context) * 0.01),
          child: Column(children: [
            Container(
              // width: Screens.width(context) * 0.7,
              width: Screens.width(context),
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 240, 235, 235)),
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey.withOpacity(0.001),
              ),
              child: TextFormField(
                textDirection: TextDirection.ltr,
                controller: salesReturnController.srmycontroller[1],
                onChanged: (v) {},
                onEditingComplete: () {
                  salesReturnController.invoiceScan(context, theme);
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                      // size: Screens.bodyheight(context) * 0.08,
                      color: Colors.grey,
                    ),
                    onPressed: () {
// salesReturnController.dlete();
                    },
                    color: theme.primaryColor,
                  ),
                  hintText: 'Invoice Number',
                  hintStyle: theme.textTheme.bodyLarge?.copyWith(
                      // color: Colors.grey
                      ),
                  filled: false,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                ),
              ),
            ),

            //
            SizedBox(
              height: Screens.bodyheight(context) * 0.01,
            ),
            salesReturnController.getselectedcust == null
                ? Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Screens.bodyheight(context) * 0.02,
                        horizontal: Screens.width(context) * 0.02),
                    child: const Text(""))
                : Container(
                    color: Colors.grey[50],
                    padding: EdgeInsets.symmetric(
                        vertical: Screens.bodyheight(context) * 0.02,
                        horizontal: Screens.width(context) * 0.02),
                    // height: Screens.bodyheight(context) * 0.75,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: Screens.width(context),
                            alignment: Alignment.centerRight,
                            // height: Screens.bodyheight(context) * 0.02,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  //  color: Colors.green,
                                  width: Screens.width(context) * 0.75,
                                  child: Text(
                                    salesReturnController.getselectedcust!.name
                                        .toString(),
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      salesReturnController.clearData();
                                    },
                                    child: Container(
                                      width: Screens.width(context) * 0.06,
                                      alignment: Alignment.center,
                                      // color: Colors.blue,
                                      child: const Icon(Icons.close_sharp),
                                    )),
                              ],
                            ) // IconButton(onPressed: (){}, icon: Icon(Icons.close_sharp))
                            ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.01,
                        ),
                        SizedBox(
                          width: Screens.width(context),
                          // color: Colors.green,
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: Colors.black54,
                                    size: Screens.bodyheight(context) * 0.03,
                                  ),
                                  Text(
                                      " ${salesReturnController.getselectedcust!.phNo}  |  ",
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black54)),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.mail_outline,
                                    color: Colors.black54,
                                    size: Screens.bodyheight(context) * 0.03,
                                  ),
                                  Text(
                                      " ${salesReturnController.getselectedcust!.email}",
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black54)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.01,
                        ),
                        SizedBox(
                          width: Screens.width(context),
                          // color: Colors.green,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: Screens.width(context) * 0.44,
                                // color: Colors.green,
                                // height: Screens.bodyheight(context) * 0.02,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("GST",
                                        // AppLocalizations.of(context)!.gst,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                    Container(
                                      padding: EdgeInsets.only(
                                        right: Screens.width(context) * 0.02,
                                      ),
                                      child: Text(
                                          "${salesReturnController.getselectedcust!.tarNo}",
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(
                                                  color: Colors.black54)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: Screens.width(context) * 0.44,
                                //color: Colors.red,
                                // height: Screens.bodyheight(context) * 0.02,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Balance",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                    Text(
                                        salesReturnController.accbal == 0
                                            ? "${salesReturnController.getselectedcust!.accBalance}"
                                            : "${salesReturnController.accbal}",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.01,
                        ),
                        SizedBox(
                          width: Screens.width(context),
                          // color: Colors.green,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: Screens.width(context) * 0.44,
                                //  color: Colors.green,
                                // height: Screens.bodyheight(context) * 0.02,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Code#",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                    Container(
                                      padding: EdgeInsets.only(
                                        right: Screens.width(context) * 0.02,
                                      ),
                                      child: Text(
                                          "${salesReturnController.getselectedcust!.cardCode}",
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(
                                                  color: Colors.black54)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: Screens.width(context) * 0.44,
                                // color: Colors.red,
                                // height: Screens.bodyheight(context) * 0.02,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Point",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                    Text(
                                        "${salesReturnController.getselectedcust!.point}",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: SizedBox(
                                width: Screens.width(context) * 0.44,
                                // color: Colors.red,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: Screens.width(context) * 0.44,
                                      padding: EdgeInsets.only(
                                          right: Screens.width(context) * 0.02),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Bill Address",
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "${salesReturnController.getselectedcust!.address![salesReturnController.getselectedBillAdress!].address1 != null ? salesReturnController.getselectedcust!.address![salesReturnController.getselectedBillAdress!].address1.toString().replaceAll(",", '') : ""} ${salesReturnController.getselectedcust!.address![salesReturnController.getselectedBillAdress!].address2 != null ? salesReturnController.getselectedcust!.address![salesReturnController.getselectedBillAdress!].address2.toString() : ""} ${salesReturnController.getselectedcust!.address![salesReturnController.getselectedBillAdress!].address3 != null ? salesReturnController.getselectedcust!.address![salesReturnController.getselectedBillAdress!].address3.toString() : ""}",
                                      maxLines: 1,
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: SizedBox(
                                width: Screens.width(context) * 0.44,
                                //color: Colors.green,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: Screens.width(context) * 0.44,
                                      padding: EdgeInsets.only(
                                          right: Screens.width(context) * 0.02),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Ship Address",
                                            maxLines: 2,
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "${salesReturnController.getselectedcust!.address![salesReturnController.getselectedBillAdress!].address1 != null ? salesReturnController.getselectedcust!.address![salesReturnController.getselectedBillAdress!].address1.toString().replaceAll(",", '') : ""} ${salesReturnController.getselectedcust!.address![salesReturnController.getselectedBillAdress!].address2 != null ? salesReturnController.getselectedcust!.address![salesReturnController.getselectedBillAdress!].address2.toString() : ""} ${salesReturnController.getselectedcust!.address![salesReturnController.getselectedBillAdress!].address3 != null ? salesReturnController.getselectedcust!.address![salesReturnController.getselectedBillAdress!].address3.toString() : ""}",
                                      maxLines: 1,
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
          ]),
        ),
      ],
    );
  }
}
