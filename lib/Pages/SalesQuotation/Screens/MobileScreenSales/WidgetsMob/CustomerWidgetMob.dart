// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, unnecessary_null_comparison, must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../Constant/Screen.dart';
import '../../../../../Controller/SalesOrderController/SalesOrderController.dart';

class CustomerWidgetMobile extends StatefulWidget {
  const CustomerWidgetMobile(
      {super.key, required this.theme, required this.prdSI});

  final ThemeData theme;
  final SOCon prdSI;

  @override
  State<CustomerWidgetMobile> createState() => _CustomerWidgetMobileState();
}

class _CustomerWidgetMobileState extends State<CustomerWidgetMobile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Screens.width(context) * 0.02,
          vertical: Screens.padingHeight(context) * 0.01),
      width: Screens.width(context),
      //  height: Screens.padingHeight(context)*0.4,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // width: custWidth * 0.7,
            width: Screens.width(context) * 1,
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromARGB(255, 240, 235, 235)),
              borderRadius: BorderRadius.circular(3),
              color: Colors.grey.withOpacity(0.001),
            ),
            child: TextFormField(
              // controller: prdCD.mycontroller[1],
              onChanged: (v) {},
              readOnly: true,
              onTap: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        contentPadding: EdgeInsets.all(0),
                        // backgroundColor: Colors.transparent,
                        insetPadding:
                            EdgeInsets.all(Screens.bodyheight(context) * 0.02),
                        content: forSearchBtn(context, widget.prdSI),
                      );
                    });
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.search,
                    // size: custHeight * 0.08,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            contentPadding: EdgeInsets.all(0),
                            // backgroundColor: Colors.transparent,
                            insetPadding: EdgeInsets.all(
                                Screens.bodyheight(context) * 0.02),
                            content: forSearchBtn(context, widget.prdSI),
                          );
                        });
                  },
                  color: widget.theme.primaryColor,
                ),
                hintText: 'Customers',
                hintStyle: widget.theme.textTheme.bodyLarge?.copyWith(
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
          SizedBox(
            height: Screens.padingHeight(context) * 0.02,
          ),
          widget.prdSI.getselectedcust == null
              ? Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Screens.padingHeight(context) * 0.02,
                      horizontal: Screens.width(context) * 0.02),
                  child: Wrap(
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children: listContainersProduct(
                        context,
                        widget.theme,
                        widget.prdSI,
                      )),
                )
              : Container(
                  color: Colors.grey[50],
                  padding: EdgeInsets.symmetric(
                      vertical: Screens.padingHeight(context) * 0.02,
                      horizontal: Screens.width(context) * 0.02),
                  // height: Screens.padingHeight(context) * 0.75,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: Screens.width(context),
                          alignment: Alignment.centerRight,
                          // height: Screens.padingHeight(context) * 0.02,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                //  color: Colors.green,
                                width: Screens.width(context) * 0.7,
                                child: Text(
                                  widget.prdSI.getselectedcust!.name != null
                                      ? widget.prdSI.getselectedcust!.name
                                          .toString()
                                      : '',
                                  style: widget.theme.textTheme.bodyLarge
                                      ?.copyWith(
                                          color: Colors.black, fontSize: 20),
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    widget.prdSI.mapUpdateCustomer(
                                        widget.prdSI.getselectedCustomer);
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4))),
                                            contentPadding: EdgeInsets.all(0),
                                            // backgroundColor: Colors.transparent,
                                            insetPadding: EdgeInsets.all(
                                                Screens.bodyheight(context) *
                                                    0.02),
                                            content: forAddNewBtn(
                                                context,
                                                widget.prdSI,
                                                "Update Customer"),
                                          );
                                        });
                                  },
                                  child: Container(
                                    width: Screens.width(context) * 0.06,
                                    alignment: Alignment.center,
                                    //     color: Colors.red,
                                    child: Icon(Icons.edit),
                                  )),
                              InkWell(
                                  onTap: () {
                                    widget.prdSI
                                        .clearData(context, widget.theme);
                                  },
                                  child: Container(
                                    width: Screens.width(context) * 0.06,
                                    alignment: Alignment.center,
                                    //     color: Colors.blue,
                                    child: Icon(Icons.close_sharp),
                                  )),
                            ],
                          ) // IconButton(onPressed: (){}, icon: Icon(Icons.close_sharp))
                          ),
                      SizedBox(
                        height: Screens.padingHeight(context) * 0.01,
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
                                  size: Screens.padingHeight(context) * 0.03,
                                ),
                                Text(
                                    widget.prdSI.getselectedcust!.phNo != null
                                        ? " ${widget.prdSI.getselectedcust!.phNo}  |  "
                                        : '',
                                    style: widget.theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54)),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.mail_outline,
                                  color: Colors.black54,
                                  size: Screens.padingHeight(context) * 0.03,
                                ),
                                Text(
                                    widget.prdSI.getselectedcust!.email != null
                                        ? " ${widget.prdSI.getselectedcust!.email}"
                                        : '',
                                    style: widget.theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Screens.padingHeight(context) * 0.01,
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.88,
                        //   color: Colors.blue,
                        child: Row(
                          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Screens.width(context) * 0.44,

                              // height: Screens.padingHeight(context) * 0.02,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    // color: Colors.green,
                                    width: Screens.width(context) * 0.13,
                                    child: Text("GST",
                                        // "${AppLocalizations.of(context)!.gst}",
                                        style: widget.theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ),
                                  Container(
                                    // color: Colors.blue,
                                    width: Screens.width(context) * 0.3,
                                    padding: EdgeInsets.only(
                                      right: Screens.width(context) * 0.02,
                                    ),
                                    child: Text(
                                        widget.prdSI.getselectedcust!.tarNo !=
                                                null
                                            ? "${widget.prdSI.getselectedcust!.tarNo}"
                                            : '',
                                        style: widget.theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              width: Screens.width(context) * 0.44,
                              // height: Screens.padingHeight(context) * 0.02,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: Screens.width(context) * 0.17,
                                    //   color: Colors.blue,
                                    child: Text("Balance",
                                        style: widget.theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ),
                                  SizedBox(
                                    // color: Colors.red,
                                    width: Screens.width(context) * 0.26,
                                    child: Text(
                                        widget.prdSI.config.slpitCurrency2(
                                            "${widget.prdSI.getselectedcust!.accBalance}"),
                                        style: widget.theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Screens.padingHeight(context) * 0.01,
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.88,
                        // color: Colors.green,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Screens.width(context) * 0.44,
                              //  color: Colors.green,
                              // height: Screens.padingHeight(context) * 0.02,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: Screens.width(context) * 0.15,
                                    //color: Colors.red,
                                    child: Text("Code#",
                                        style: widget.theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ),
                                  Container(
                                    width: Screens.width(context) * 0.28,
                                    //color: Colors.green,
                                    padding: EdgeInsets.only(
                                      right: Screens.width(context) * 0.02,
                                    ),
                                    child: Text(
                                        "${widget.prdSI.getselectedcust!.cardCode}",
                                        style: widget.theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              width: Screens.width(context) * 0.44,
                              // color: Colors.red,
                              // height: Screens.padingHeight(context) * 0.02,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Point",
                                      style: widget.theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black54)),
                                  Text(
                                      widget.prdSI.config.slpitCurrency2(
                                          "${widget.prdSI.getselectedcust!.point}"),
                                      style: widget.theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black54)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Screens.padingHeight(context) * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                // widget.prdSI.getcustaddresslist();
                                billAddress(context, widget.prdSI);
                              });
                            },
                            child: SizedBox(
                              width: Screens.width(context) * 0.4,
                              // color: Colors.red,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Screens.width(context) * 0.4,
                                    padding: EdgeInsets.only(
                                        right: Screens.width(context) * 0.02),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Bill Address",
                                          style: widget
                                              .theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black54),
                                        ),
                                        SizedBox(
                                            width:
                                                Screens.width(context) * 0.04,
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              size: 30,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Text(
                                    " ${widget.prdSI.getselectedcust!.address![widget.prdSI.getselectedBillAdress!].address1 != null ? widget.prdSI.getselectedcust!.address![widget.prdSI.getselectedBillAdress!].address1.toString() : null},${widget.prdSI.getselectedcust!.address![widget.prdSI.getselectedBillAdress!].address2 != null ? widget.prdSI.getselectedcust!.address![widget.prdSI.getselectedBillAdress!].address2.toString() : null}, ${widget.prdSI.getselectedcust!.address![widget.prdSI.getselectedBillAdress!].address3 != null ? widget.prdSI.getselectedcust!.address![widget.prdSI.getselectedBillAdress!].address3.toString() : null}",
                                    maxLines: 1,
                                    style: widget.theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54),
                                  ),
                                  Text(
                                    widget
                                            .prdSI
                                            .getselectedcust!
                                            .address![widget
                                                .prdSI.getselectedBillAdress!]
                                            .billCity
                                            .isNotEmpty
                                        ? widget
                                            .prdSI
                                            .getselectedcust!
                                            .address![widget
                                                .prdSI.getselectedBillAdress!]
                                            .billCity
                                            .toString()
                                        : '',
                                    maxLines: 1,
                                    style: widget.theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54),
                                  ),
                                  Text(
                                    widget
                                            .prdSI
                                            .getselectedcust!
                                            .address![widget
                                                .prdSI.getselectedBillAdress!]
                                            .billPincode
                                            .isNotEmpty
                                        ? widget
                                            .prdSI
                                            .getselectedcust!
                                            .address![widget
                                                .prdSI.getselectedBillAdress!]
                                            .billPincode
                                            .toString()
                                        : '',
                                    maxLines: 1,
                                    style: widget.theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54),
                                  ),
                                  Text(
                                    widget
                                            .prdSI
                                            .getselectedcust!
                                            .address![widget
                                                .prdSI.getselectedBillAdress!]
                                            .billstate
                                            .isNotEmpty
                                        ? widget
                                            .prdSI
                                            .getselectedcust!
                                            .address![widget
                                                .prdSI.getselectedBillAdress!]
                                            .billstate
                                            .toString()
                                        : '',
                                    maxLines: 1,
                                    style: widget.theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // widget.prdSI.getcustaddresslist();
                              shipaddress(context, widget.prdSI);
                            },
                            child: SizedBox(
                              width: Screens.width(context) * 0.465,
                              //color: Colors.green,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Screens.width(context) * 0.465,
                                    padding: EdgeInsets.only(
                                        right: Screens.width(context) * 0.02),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Ship Address",
                                          maxLines: 2,
                                          style: widget
                                              .theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black54),
                                        ),
                                        SizedBox(
                                            width:
                                                Screens.width(context) * 0.04,
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              size: 30,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Text(
                                    " ${widget.prdSI.getselectedcust!.address![widget.prdSI.getselectedShipAdress!].address1 != null ? widget.prdSI.getselectedcust!.address![widget.prdSI.getselectedShipAdress!].address1.toString() : null},${widget.prdSI.getselectedcust!.address![widget.prdSI.getselectedShipAdress!].address2 != null ? widget.prdSI.getselectedcust!.address![widget.prdSI.getselectedShipAdress!].address2.toString() : null}, ${widget.prdSI.getselectedcust!.address![widget.prdSI.getselectedShipAdress!].address3 != null ? widget.prdSI.getselectedcust!.address![widget.prdSI.getselectedShipAdress!].address3.toString() : null}",

                                    // "${widget.prdSI.getselectedcust!.address![widget.prdSI.getselectedShipAdress!].address1.toString()}, " +
                                    //     "${widget.prdSI.getselectedcust!.address![widget.prdSI.getselectedShipAdress!].address2.toString()}, " +
                                    //     "${widget.prdSI.getselectedcust!.address![widget.prdSI.getselectedShipAdress!].address3.toString()}",
                                    maxLines: 1,
                                    style: widget.theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54),
                                  ),
                                  Text(
                                    widget
                                                .prdSI
                                                .getselectedcust!
                                                .address![widget.prdSI
                                                    .getselectedBillAdress!]
                                                .billCity !=
                                            null
                                        ? widget
                                            .prdSI
                                            .getselectedcust!
                                            .address![widget
                                                .prdSI.getselectedBillAdress!]
                                            .billCity
                                            .toString()
                                        : "",
                                    maxLines: 1,
                                    style: widget.theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54),
                                  ),
                                  Text(
                                    widget
                                                .prdSI
                                                .getselectedcust!
                                                .address![widget.prdSI
                                                    .getselectedBillAdress!]
                                                .billPincode !=
                                            null
                                        ? widget
                                            .prdSI
                                            .getselectedcust!
                                            .address![widget
                                                .prdSI.getselectedBillAdress!]
                                            .billPincode
                                            .toString()
                                        : "",
                                    maxLines: 1,
                                    style: widget.theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54),
                                  ),
                                  Text(
                                    widget
                                        .prdSI
                                        .getselectedcust!
                                        .address![
                                            widget.prdSI.getselectedBillAdress!]
                                        .billstate
                                        .toString(),
                                    maxLines: 1,
                                    style: widget.theme.textTheme.bodyLarge
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
        ],
      ),
    );
  }

  forSearchBtn(BuildContext context, SOCon prdsrcbtn) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        width: Screens.width(context),
        height: Screens.padingHeight(context) * 0.7,
        padding: EdgeInsets.only(
            top: Screens.padingHeight(context) * 0.01,
            left: Screens.width(context) * 0.02,
            right: Screens.width(context) * 0.02,
            bottom: Screens.padingHeight(context) * 0.01),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: Screens.width(context),
              height: Screens.padingHeight(context) * 0.05,
              color: theme.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: Screens.padingHeight(context) * 0.02,
                        right: Screens.padingHeight(context) * 0.02),
                    // color: Colors.red,
                    width: Screens.width(context) * 0.4,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Select Customer",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        size: Screens.padingHeight(context) * 0.025,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: Screens.padingHeight(context) * 0.01),
            Container(
              width: Screens.width(context) * 0.9,
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 240, 235, 235)),
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey.withOpacity(0.01),
              ),
              child: TextFormField(
                controller: prdsrcbtn.mycontroller[2],
                cursorColor: Colors.grey,
                onChanged: (v) {
                  st(() {
                    prdsrcbtn.filterList(v);
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search customer..!!',
                  hintStyle:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.grey),
                  filled: true,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 25,
                  ),
                ),
              ),
            ),
            SizedBox(height: Screens.padingHeight(context) * 0.01),
            Expanded(
                child: ListView.builder(
                    itemCount: prdsrcbtn.getfiltercustList.length,
                    itemBuilder: (context, index) {
                      log(" prdsrcbtn.getfiltercustList.length:${prdsrcbtn.getfiltercustList.length}");
                      return Card(
                        child: Container(
                          padding: EdgeInsets.only(
                              top: Screens.padingHeight(context) * 0.01,
                              left: Screens.width(context) * 0.01,
                              right: Screens.width(context) * 0.01,
                              bottom: Screens.padingHeight(context) * 0.01),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: ListTile(
                            onTap: () {
                              prdsrcbtn.custSelected(
                                  prdsrcbtn.getfiltercustList[index],
                                  context,
                                  theme);
                              Navigator.pop(context);
                            },
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: Screens.width(context) * 0.25,
                                      child: Text(
                                        prdsrcbtn
                                            .getfiltercustList[index].cardCode!,
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ),
                                    SizedBox(
                                      width: Screens.width(context) * 0.25,
                                      child: Text(
                                        prdsrcbtn.getfiltercustList[index]
                                            .accBalance!
                                            .toString(),
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: Screens.width(context) * 0.25,
                                      child: Text(
                                        prdsrcbtn
                                            .getfiltercustList[index].name!,
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ),
                                    SizedBox(
                                      width: Screens.width(context) * 0.25,
                                      child: Text(
                                        prdsrcbtn
                                            .getfiltercustList[index].phNo!,
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    })),
            //  SizedBox(height: Screens.padingHeight(context) * 0.09),
            SizedBox(height: Screens.padingHeight(context) * 0.01),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                widget.prdSI.clearCustomer();
                widget.prdSI.clearAddress();
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        contentPadding: EdgeInsets.all(0),
                        // backgroundColor: Colors.transparent,
                        insetPadding:
                            EdgeInsets.all(Screens.bodyheight(context) * 0.02),
                        content:
                            forAddNewBtn(context, widget.prdSI, "New Customer"),
                      );
                    });
              },
              child: Container(
                alignment: Alignment.center,
                height: Screens.padingHeight(context) * 0.045,
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                ),
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Add New",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  forAddNewBtn(BuildContext context, SOCon prdadd, String title) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.only(
            top: Screens.padingHeight(context) * 0.02,
            left: Screens.width(context) * 0.02,
            right: Screens.width(context) * 0.02,
            bottom: Screens.padingHeight(context) * 0.01),
        width: Screens.width(context),
        height: Screens.padingHeight(context) * 0.7,
        // color: Colors.red,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: prdadd.formkey[6],
                child: Column(
                  children: [
                    Container(
                      width: Screens.width(context),
                      height: Screens.padingHeight(context) * 0.05,
                      color: theme.primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: Screens.padingHeight(context) * 0.02,
                                right: Screens.padingHeight(context) * 0.02),
                            // color: Colors.red,
                            width: Screens.width(context) * 0.4,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "$title",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.close,
                                size: Screens.padingHeight(context) * 0.025,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        autofocus: true,
                        controller: prdadd.mycontroller[3],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter the Customer Code";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Customer Code',
                          filled: false,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.03,
                    ),
                    Container(
                      // height: custHeight * 0.15,
                      // width: custWidth * 1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        controller: prdadd.mycontroller[4],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter the Mobile Number";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Mobile Number',
                          filled: false,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.03,
                    ),
                    Container(
                      // width: custWidth * 1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        autofocus: true,
                        controller: prdadd.mycontroller[5],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter the GST No";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Gst",
                          filled: false,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.03,
                    ),
                    Container(
                      // height: Screens.padingHeight(context) * 0.15,
                      // width: custWidth * 1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        controller: prdadd.mycontroller[6],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter the Name";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Name",
                          filled: false,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.02,
                    ),
                    //addreswidget
                    AddressWidget(
                      theme: theme,
                      posController: prdadd,
                      custHeight: Screens.padingHeight(context),
                      custWidth: Screens.width(context),
                    ),

                    SizedBox(
                      height: Screens.padingHeight(context) * 0.02,
                    ),
                    Container(
                      // height: custHeight * 0.15,
                      // width: custWidth * 0.65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        controller: prdadd.mycontroller[21],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter the Email Address";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Email",
                          filled: false,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.02,
                    ),
                    InkWell(
                      onTap: () {
                        if (title == "New Customer") {
                          prdadd.addnewCustomer(context, theme, 6);

                          // prdadd.getCustDetFDB();
                        } else if (title == "Update Customer") {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                  contentPadding: EdgeInsets.all(0),
                                  // backgroundColor: Colors.transparent,
                                  insetPadding: EdgeInsets.all(
                                      Screens.bodyheight(context) * 0.02),
                                  content: updateType(context, widget.prdSI,
                                      widget.prdSI.getselectedBillAdress!),
                                );
                              });
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: Screens.padingHeight(context) * 0.045,
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                          // borderRadius: BorderRadius.only(
                          //     topLeft: Radius.circular(5), topRight: Radius.circular(5))
                        ),
                        child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              title == "New Customer" ? "Save" : "Update",
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  List<Widget> listContainersProduct(
      BuildContext context, ThemeData theme, SOCon posC) {
    return List.generate(
      posC.custList.length >= 10 ? 10 : posC.custList.length,
      (ind) {
        log("posC.custList.length::${posC.custList.length}");
        return TopCustomer(ind: ind, posC: posC, theme: theme);
      },
    );
  }
}

class TopCustomer extends StatelessWidget {
  TopCustomer({
    super.key,
    required this.ind,
    required this.posC,
    required this.theme,
  });
  SOCon posC;
  ThemeData theme;
  int ind;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        posC.custSelected(posC.custList[ind], context, theme);
      },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: theme.primaryColor,
            border: Border.all(color: theme.primaryColor, width: 1),
            borderRadius: BorderRadius.circular(5)),
        child: Text(posC.custList[ind].name!,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: Colors.white,
            )),
      ),
    );
  }
}

Widget updateType(BuildContext context, SOCon pos, int i) {
  final theme = Theme.of(context);
  return SizedBox(
    width: Screens.width(context),
    //  height: Screens.padingHeight(context) * 0.4,

    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.center,
          height: Screens.padingHeight(context) * 0.05,
          decoration: BoxDecoration(
            color: theme.primaryColor,
            // borderRadius: BorderRadius.only(
            //     topLeft: Radius.circular(5), topRight: Radius.circular(5))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // color: Colors.red,
                width: Screens.width(context) * 0.4,
                alignment: Alignment.center,
                child: Text(
                  "Confrim update",
                  textAlign: TextAlign.center,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.white),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    size: Screens.padingHeight(context) * 0.025,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: Screens.bodyheight(context) * 0.02,
        ),
        Container(
          width: Screens.width(context) * 0.9,
          padding: EdgeInsets.symmetric(
            vertical: Screens.padingHeight(context) * 0.01,
            horizontal: Screens.width(context) * 0.01,
          ),
          child: Column(
            children: [
              Text(
                "Do you want to update this customer for this sale or update to server..!!",
                style: theme.textTheme.bodyMedium,
              ),
              SizedBox(
                height: Screens.bodyheight(context) * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: Screens.width(context) * 0.4,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // pos.updateCustomer(i);
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Update to server",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(color: Colors.white),
                        )),
                  ),
                  SizedBox(
                      width: Screens.width(context) * 0.4,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // pos.updateCustomer(i);
                            Navigator.pop(context);
                          },
                          child: Text(
                            "This sale",
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.white),
                          ))),
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}

billAddress(BuildContext context, SOCon pos) async {
  final theme = Theme.of(context);
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))),
          contentPadding: EdgeInsets.all(0),
          // backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(Screens.bodyheight(context) * 0.02),
          content: Container(
            width: Screens.width(context),
            padding: EdgeInsets.symmetric(
              vertical: Screens.padingHeight(context) * 0.01,
              horizontal: Screens.width(context) * 0.01,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: Screens.width(context),
                  height: Screens.padingHeight(context) * 0.05,
                  color: theme.primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: Screens.padingHeight(context) * 0.02,
                            right: Screens.padingHeight(context) * 0.02),
                        // color: Colors.red,
                        width: Screens.width(context) * 0.4,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Address",
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            size: Screens.padingHeight(context) * 0.025,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: Screens.padingHeight(context) * 0.4,
                  padding: EdgeInsets.symmetric(
                    vertical: Screens.padingHeight(context) * 0.01,
                    horizontal: Screens.width(context) * 0.01,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: pos.getselectedcust!.address!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          pos.changeBillAddress(index);
                          Navigator.pop(context);
                        },
                        child: Card(
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical:
                                      Screens.padingHeight(context) * 0.01,
                                  horizontal: Screens.width(context) * 0.01,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //             ListTile(
                                    //   title: Text( pos.selectedcust!.address[index].billAddress,
                                    //       style: theme.textTheme.bodySmall),
                                    //   onTap: () {
                                    //     pos.changeBillAddress(index);
                                    //     //pos.selectedcust!.address[pos.selectedAdress].billAddress = pos.selectedcust!.address[index].billAddress;
                                    //     Navigator.pop(context);
                                    //   },
                                    // ),
                                    Text(
                                        "${pos.getselectedcust!.address![index].address1},${pos.getselectedcust!.address![index].address2}, ${pos.getselectedcust!.address![index].address3}"),
                                    Text(
                                        "${pos.getselectedcust!.address![index].billCity}"),
                                    Text(
                                        "${pos.getselectedcust!.address![index].billPincode}"),
                                    Text(
                                        "${pos.getselectedcust!.address![index].billstate}")
                                  ],
                                ))),
                      );
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    pos.clearAddress();
                    createAddress(context, theme, pos);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: Screens.padingHeight(context) * 0.045,
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      // borderRadius: BorderRadius.only(
                      //     topLeft: Radius.circular(5), topRight: Radius.circular(5))
                    ),
                    child: Center(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Create address",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          //  AlertBox(
          //   payMent: 'Address',
          //   widget:
          //   buttonName: "Create Address",
          //   callback: () {
          //     Navigator.pop(context);
          //     createAddress(context, theme, pos);
          //   },
          // )
        );
      });
}

shipaddress(BuildContext context, SOCon pos) async {
  final theme = Theme.of(context);
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))),
          contentPadding: EdgeInsets.all(0),
          // backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(Screens.bodyheight(context) * 0.02),
          content: Container(
            width: Screens.width(context),
            padding: EdgeInsets.symmetric(
              vertical: Screens.padingHeight(context) * 0.01,
              horizontal: Screens.width(context) * 0.01,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: Screens.width(context),
                  height: Screens.padingHeight(context) * 0.05,
                  color: theme.primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: Screens.padingHeight(context) * 0.02,
                            right: Screens.padingHeight(context) * 0.02),
                        // color: Colors.red,
                        width: Screens.width(context) * 0.4,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Address",
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            size: Screens.padingHeight(context) * 0.025,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.4,
                  // width: Screens.width(context) * 0.25,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: pos.getselectedcust!.address!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          pos.changeShipAddress(index);
                          Navigator.pop(context);
                        },
                        child: Card(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //             ListTile(
                            //   title: Text(pos.selectedcust!.address[index].shipAddress,
                            //       style: theme.textTheme.bodySmall),
                            //   onTap: () {
                            //     pos.changeShipAddress(index);
                            //     // pos.selectedcust!.address[0].shipAddress =
                            //     //     pos.selectedcust!.address[index].shipAddress;
                            //     Navigator.pop(context);
                            //   },
                            // ),
                            Text(
                                "${pos.getselectedcust!.address![index].address1}, ${pos.getselectedcust!.address![index].address2}, ${pos.getselectedcust!.address![index].address3},"),
                            Text(
                                "${pos.getselectedcust!.address![index].billCity}"),
                            Text(
                                "${pos.getselectedcust!.address![index].billPincode}"),
                            Text(
                                "${pos.getselectedcust!.address![index].billstate}")
                          ],
                        )),
                      );
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    pos.clearAddress();
                    createAddress(context, theme, pos);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: Screens.padingHeight(context) * 0.045,
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      // borderRadius: BorderRadius.only(
                      //     topLeft: Radius.circular(5), topRight: Radius.circular(5))
                    ),
                    child: Center(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Create address",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          // AlertBox(
          //   payMent: 'Address',
          //   widget:
          //   buttonName: "Create Address",
          //   callback: () {
          //     Navigator.pop(context);
          //     createAddress(context, theme, pos);
          //   },
          // )
        );
      });
}

createAddress(BuildContext context, ThemeData theme, SOCon pos) async {
  final theme = Theme.of(context);
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))),
          contentPadding: EdgeInsets.all(0),
          // backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(Screens.bodyheight(context) * 0.02),
          // contentPadding: EdgeInsets.all(0),
          content: createAddressMethod(theme, context, pos),
          // AlertBox(
          //   payMent: 'Create Address',
          //   widget: createAddressMethod(theme, context, pos),
          //   buttonName: "Save",
          //   callback: () {
          //     pos.addadress(context);
          //   },
          // )
        );
      });
}

Container createAddressMethod(
    ThemeData theme, BuildContext context, SOCon pos) {
  return Container(
    width: Screens.width(context),
    height: Screens.padingHeight(context) * 0.7,
    padding: EdgeInsets.only(
      left: Screens.width(context) * 0.02,
      right: Screens.width(context) * 0.02,
      bottom: Screens.padingHeight(context) * 0.01,
      top: Screens.padingHeight(context) * 0.01,
    ),
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            height: Screens.padingHeight(context) * 0.045,
            decoration: BoxDecoration(color: theme.primaryColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: Screens.padingHeight(context) * 0.02,
                      right: Screens.padingHeight(context) * 0.02),
                  // color: Colors.red,
                  width: Screens.width(context) * 0.4,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Create Address",
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      size: Screens.padingHeight(context) * 0.025,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: Screens.bodyheight(context) * 0.02,
          ),
          AddressWidget(
            theme: theme,
            posController: pos,
            custHeight: Screens.padingHeight(context) * 0.7,
            custWidth: Screens.width(context) * 0.7,
          ),
          SizedBox(
            height: Screens.bodyheight(context) * 0.01,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              // pos.insertCreatenewAddress();
              pos.createNewBillAdd();
              // pos.addadress(context);
            },
            child: Container(
              alignment: Alignment.center,
              height: Screens.padingHeight(context) * 0.045,
              decoration: BoxDecoration(
                color: theme.primaryColor,
                // borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(5), topRight: Radius.circular(5))
              ),
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Save",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

class AddressWidget extends StatelessWidget {
  const AddressWidget(
      {super.key,
      required this.theme,
      required this.posController,
      required this.custHeight,
      required this.custWidth});

  final ThemeData theme;
  final double custHeight;
  final double custWidth;

  final SOCon posController;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, st) {
      return Column(
        children: [
          Container(
            // height: custHeight * 0.15,
            // width: custWidth * 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.grey.withOpacity(0.01),
            ),
            child: TextFormField(
              autofocus: true,
              controller: posController.mycontroller[7],
              cursorColor: Colors.grey,
              style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
              onChanged: (v) {},
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please Enter the Address1";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                labelText: "Bill Address1",
                filled: false,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
              ),
            ),
          ),
          SizedBox(
            height: custHeight * 0.02,
          ),
          Container(
            // height: custHeight * 0.15,
            // width: custWidth * 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.grey.withOpacity(0.01),
            ),
            child: TextFormField(
              controller: posController.mycontroller[8],
              cursorColor: Colors.grey,
              style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
              onChanged: (v) {},
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please Enter the Address2";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                labelText: "Bill Address2",
                filled: false,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
              ),
            ),
          ),
          SizedBox(
            height: custHeight * 0.02,
          ),
          Container(
            // height: custHeight * 0.15,
            // width: custWidth * 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.grey.withOpacity(0.01),
            ),
            child: TextFormField(
              controller: posController.mycontroller[9],
              cursorColor: Colors.grey,
              style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
              onChanged: (v) {},
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please Enter the Address3";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                labelText: "Bill Address3",
                filled: false,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
              ),
            ),
          ),
          SizedBox(
            height: custHeight * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // height: custHeight * 0.15,
                width: custWidth * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.01),
                ),
                child: TextFormField(
                  controller: posController.mycontroller[10],
                  cursorColor: Colors.grey,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                  onChanged: (v) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter the City Name";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "City",
                    filled: false,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                  ),
                ),
              ),
              Container(
                // height: custHeight * 0.15,
                width: custWidth * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.01),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: posController.mycontroller[11],
                  cursorColor: Colors.grey,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                  onChanged: (v) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter the Pincode";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Pincode",
                    filled: false,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: custHeight * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // height: custHeight * 0.15,
                width: custWidth * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.01),
                ),
                child: TextFormField(
                  controller: posController.mycontroller[12],
                  cursorColor: Colors.grey,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                  onChanged: (v) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter the State";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "State",
                    filled: false,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                  ),
                ),
              ),
              Container(
                // height: custHeight * 0.15,
                width: custWidth * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.01),
                ),
                child: TextFormField(
                  readOnly: true,
                  controller: posController.mycontroller[13],
                  cursorColor: Colors.grey,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                  onChanged: (v) {},
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return "Please Enter the State";
                  //   } else {
                  //     return null;
                  //   }
                  // },
                  decoration: InputDecoration(
                    hintText: "Ind",
                    filled: false,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: custHeight * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                height: custHeight * 0.1,
                child: Text("Copy As Ship Address"),
              ),
              Checkbox(
                  side: BorderSide(color: Colors.grey),
                  activeColor: Colors.green,
                  value: posController.checkboxx,
                  onChanged: (val) {
                    st(() {
                      posController.checkboxx = val!;
                      posController.billToShip(val);
                    });
                  }),
            ],
          ),
          SizedBox(
            height: custHeight * 0.02,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // height: custHeight * 0.15,
                // width: custWidth * 0.65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.01),
                ),
                child: TextFormField(
                  autofocus: true,
                  controller: posController.mycontroller[14],
                  cursorColor: Colors.grey,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                  onChanged: (v) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter the Ship Address1";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Ship Address1',
                    filled: false,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: custHeight * 0.02,
              ),
              Container(
                // height: custHeight * 0.15,
                // width: custWidth * 0.65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.01),
                ),
                child: TextFormField(
                  autofocus: true,
                  controller: posController.mycontroller[15],
                  cursorColor: Colors.grey,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                  onChanged: (v) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter the Ship Address2";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Ship Address2',
                    filled: false,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: custHeight * 0.02,
              ),
              Container(
                // height: custHeight * 0.15,
                // width: custWidth * 0.65,
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 240, 235, 235)),
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.01),
                ),
                child: TextFormField(
                  autofocus: true,
                  controller: posController.mycontroller[16],
                  cursorColor: Colors.grey,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                  onChanged: (v) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter the Ship Address3";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Ship Address3",
                    filled: false,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: custHeight * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // height: custHeight * 0.15,
                width: custWidth * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.01),
                ),
                child: TextFormField(
                  controller: posController.mycontroller[17],
                  cursorColor: Colors.grey,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                  onChanged: (v) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter the City Name";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "City",
                    filled: false,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                  ),
                ),
              ),
              Container(
                // height: custHeight * 0.15,
                width: custWidth * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.01),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: posController.mycontroller[18],
                  cursorColor: Colors.grey,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                  onChanged: (v) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter the Pincode";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Pincode",
                    filled: false,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: custHeight * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // height: custHeight * 0.15,
                width: custWidth * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.01),
                ),
                child: TextFormField(
                  controller: posController.mycontroller[19],
                  cursorColor: Colors.grey,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                  onChanged: (v) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter the State";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "State",
                    filled: false,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                  ),
                ),
              ),
              Container(
                // height: custHeight * 0.15,
                width: custWidth * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.01),
                ),
                child: TextFormField(
                  readOnly: true,
                  controller: posController.mycontroller[20],
                  cursorColor: Colors.grey,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                  onChanged: (v) {},
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return "Please Enter the State";
                  //   } else {
                  //     return null;
                  //   }
                  // },
                  decoration: InputDecoration(
                    hintText: "Ind",
                    filled: false,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  //
}
