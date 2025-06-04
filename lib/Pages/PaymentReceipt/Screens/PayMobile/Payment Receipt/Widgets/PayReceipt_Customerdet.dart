import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:posproject/Constant/Screen.dart';
import '../../../../../../Controller/PaymentReceiptController/PayReceiptController.dart';

class PayReceiptCustomerDetails extends StatefulWidget {
  PayReceiptCustomerDetails({
    super.key,
    required this.theme,
    required this.prdCD,
    required this.cusHeight,
    required this.cusWidth,
  });
  double cusHeight;
  double cusWidth;

  final ThemeData theme;
  PayreceiptController prdCD;

  @override
  State<PayReceiptCustomerDetails> createState() =>
      _PayReceiptCustomerDetailsState();
}

class _PayReceiptCustomerDetailsState extends State<PayReceiptCustomerDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Screens.width(context) * 0.02,
          vertical: Screens.padingHeight(context) * 0.01),
      width: Screens.width(context),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Screens.width(context) * 1,
            decoration: BoxDecoration(
              border:
                  Border.all(color: const Color.fromARGB(255, 240, 235, 235)),
              borderRadius: BorderRadius.circular(3),
              color: Colors.grey.withOpacity(0.001),
            ),
            child: TextFormField(
              controller: widget.prdCD.mycontroller[81],
              onChanged: (v) {},
              onEditingComplete: () {
                widget.prdCD.custcodeScan(context, widget.theme);
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            contentPadding: const EdgeInsets.all(0),
                            insetPadding: EdgeInsets.all(
                                Screens.bodyheight(context) * 0.02),
                            content: forSearchBtn(context, widget.prdCD),
                          );
                        });
                  },
                  color: widget.theme.primaryColor,
                ),
                hintText: 'Customers',
                hintStyle: widget.theme.textTheme.bodyLarge?.copyWith(),
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
          widget.prdCD.getselectedcust == null
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
                        widget.prdCD,
                      )),
                )
              : Container(
                  color: Colors.grey[50],
                  padding: EdgeInsets.symmetric(
                      vertical: Screens.padingHeight(context) * 0.02,
                      horizontal: Screens.width(context) * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: Screens.width(context),
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: Screens.width(context) * 0.7,
                                child: Text(
                                  widget.prdCD.getselectedcust!.name != null
                                      ? widget.prdCD.getselectedcust!.name
                                          .toString()
                                      : '',
                                  style: widget.theme.textTheme.bodyLarge
                                      ?.copyWith(
                                          color: Colors.black, fontSize: 20),
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    widget.prdCD.mapUpdateCustomer(
                                        widget.prdCD.getselectedCustomer);
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4))),
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            insetPadding: EdgeInsets.all(
                                                Screens.bodyheight(context) *
                                                    0.02),
                                            content: forAddNewBtn(
                                                context,
                                                widget.prdCD,
                                                "Update Customer"),
                                          );
                                        });
                                  },
                                  child: Container(
                                    width: Screens.width(context) * 0.06,
                                    alignment: Alignment.center,
                                    child: const Icon(Icons.edit),
                                  )),
                              InkWell(
                                  onTap: () {
                                    widget.prdCD.clearpayData();
                                  },
                                  child: Container(
                                    width: Screens.width(context) * 0.06,
                                    alignment: Alignment.center,
                                    child: const Icon(Icons.close_sharp),
                                  )),
                            ],
                          ) // IconButton(onPressed: (){}, icon: Icon(Icons.close_sharp))
                          ),
                      SizedBox(
                        height: Screens.padingHeight(context) * 0.01,
                      ),
                      SizedBox(
                        width: Screens.width(context),
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
                                    widget.prdCD.getselectedcust!.phNo != null
                                        ? " ${widget.prdCD.getselectedcust!.phNo}  |  "
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
                                SizedBox(
                                  width: Screens.width(context) * 0.43,
                                  child: Text(
                                      widget.prdCD.getselectedcust!.email !=
                                              null
                                          ? " ${widget.prdCD.getselectedcust!.email}"
                                          : '',
                                      style: widget.theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black54)),
                                ),
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
                        child: Row(
                          children: [
                            SizedBox(
                              width: Screens.width(context) * 0.44,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: Screens.width(context) * 0.13,
                                    child: Text("GST",
                                        style: widget.theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ),
                                  Container(
                                    width: Screens.width(context) * 0.3,
                                    padding: EdgeInsets.only(
                                      right: Screens.width(context) * 0.02,
                                    ),
                                    child: Text(
                                        widget.prdCD.getselectedcust!.tarNo !=
                                                null
                                            ? "${widget.prdCD.getselectedcust!.tarNo}"
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: Screens.width(context) * 0.17,
                                    child: Text("Balance",
                                        style: widget.theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ),
                                  SizedBox(
                                    width: Screens.width(context) * 0.26,
                                    child: Text(
                                        widget.prdCD.config.splitValues(
                                            "${widget.prdCD.getselectedcust!.accBalance}"),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Screens.width(context) * 0.44,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: Screens.width(context) * 0.15,
                                    child: Text("Code#",
                                        style: widget.theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ),
                                  Container(
                                    width: Screens.width(context) * 0.28,
                                    padding: EdgeInsets.only(
                                      right: Screens.width(context) * 0.02,
                                    ),
                                    child: Text(
                                        "${widget.prdCD.getselectedcust!.cardCode}",
                                        style: widget.theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              width: Screens.width(context) * 0.44,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Point",
                                      style: widget.theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black54)),
                                  Text(
                                      widget.prdCD.config.splitValues(
                                          "${widget.prdCD.getselectedcust!.point}"),
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
                                widget.prdCD.getcustaddresslist();
                                billAddress(context, widget.prdCD);
                              });
                            },
                            child: SizedBox(
                              width: Screens.width(context) * 0.4,
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
                                          "Billing Address",
                                          style: widget
                                              .theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black54),
                                        ),
                                        SizedBox(
                                            width:
                                                Screens.width(context) * 0.04,
                                            child: const Icon(
                                              Icons.arrow_drop_down,
                                              size: 30,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Text(
                                    " ${widget.prdCD.getselectedcust!.address![widget.prdCD.getselectedBillAdress!].address1 != null ? widget.prdCD.getselectedcust!.address![widget.prdCD.getselectedBillAdress!].address1.toString() : ""},${widget.prdCD.getselectedcust!.address![widget.prdCD.getselectedBillAdress!].address2 != null ? widget.prdCD.getselectedcust!.address![widget.prdCD.getselectedBillAdress!].address2.toString() : ""}, ${widget.prdCD.getselectedcust!.address![widget.prdCD.getselectedBillAdress!].address3 != null ? widget.prdCD.getselectedcust!.address![widget.prdCD.getselectedBillAdress!].address3.toString() : ""}",
                                    maxLines: 1,
                                    style: widget.theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54),
                                  ),
                                  Text(
                                    widget
                                            .prdCD
                                            .getselectedcust!
                                            .address![widget
                                                .prdCD.getselectedBillAdress!]
                                            .billCity
                                            .isNotEmpty
                                        ? widget
                                            .prdCD
                                            .getselectedcust!
                                            .address![widget
                                                .prdCD.getselectedBillAdress!]
                                            .billCity
                                            .toString()
                                        : '',
                                    maxLines: 1,
                                    style: widget.theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54),
                                  ),
                                  Text(
                                    widget
                                            .prdCD
                                            .getselectedcust!
                                            .address![widget
                                                .prdCD.getselectedBillAdress!]
                                            .billPincode
                                            .isNotEmpty
                                        ? widget
                                            .prdCD
                                            .getselectedcust!
                                            .address![widget
                                                .prdCD.getselectedBillAdress!]
                                            .billPincode
                                            .toString()
                                        : '',
                                    maxLines: 1,
                                    style: widget.theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54),
                                  ),
                                  Text(
                                    widget
                                            .prdCD
                                            .getselectedcust!
                                            .address![widget
                                                .prdCD.getselectedBillAdress!]
                                            .billstate
                                            .isNotEmpty
                                        ? widget
                                            .prdCD
                                            .getselectedcust!
                                            .address![widget
                                                .prdCD.getselectedBillAdress!]
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
                              widget.prdCD.getcustaddresslist();
                              shipaddress(context, widget.prdCD);
                            },
                            child: SizedBox(
                              width: Screens.width(context) * 0.465,
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
                                          "Shipping Address",
                                          maxLines: 2,
                                          style: widget
                                              .theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black54),
                                        ),
                                        SizedBox(
                                            width:
                                                Screens.width(context) * 0.04,
                                            child: const Icon(
                                              Icons.arrow_drop_down,
                                              size: 30,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Text(
                                    " ${widget.prdCD.getselectedcust!.address![widget.prdCD.getselectedShipAdress!].address1 != null ? widget.prdCD.getselectedcust!.address![widget.prdCD.getselectedShipAdress!].address1.toString() : ""},${widget.prdCD.getselectedcust!.address![widget.prdCD.getselectedShipAdress!].address2 != null ? widget.prdCD.getselectedcust!.address![widget.prdCD.getselectedShipAdress!].address2.toString() : ""}, ${widget.prdCD.getselectedcust!.address![widget.prdCD.getselectedShipAdress!].address3 != null ? widget.prdCD.getselectedcust!.address![widget.prdCD.getselectedShipAdress!].address3.toString() : ""}",
                                    maxLines: 1,
                                    style: widget.theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54),
                                  ),
                                  Text(
                                    widget
                                                .prdCD
                                                .getselectedcust!
                                                .address![widget.prdCD
                                                    .getselectedBillAdress!]
                                                .billCity !=
                                            null
                                        ? widget
                                            .prdCD
                                            .getselectedcust!
                                            .address![widget
                                                .prdCD.getselectedBillAdress!]
                                            .billCity
                                            .toString()
                                        : "",
                                    maxLines: 1,
                                    style: widget.theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54),
                                  ),
                                  Text(
                                    widget
                                                .prdCD
                                                .getselectedcust!
                                                .address![widget.prdCD
                                                    .getselectedBillAdress!]
                                                .billPincode !=
                                            null
                                        ? widget
                                            .prdCD
                                            .getselectedcust!
                                            .address![widget
                                                .prdCD.getselectedBillAdress!]
                                            .billPincode
                                            .toString()
                                        : "",
                                    maxLines: 1,
                                    style: widget.theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54),
                                  ),
                                  Text(
                                    widget
                                        .prdCD
                                        .getselectedcust!
                                        .address![
                                            widget.prdCD.getselectedBillAdress!]
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

  forSearchBtn(BuildContext context, PayreceiptController prdsrcbtn) {
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
                border:
                    Border.all(color: const Color.fromARGB(255, 240, 235, 235)),
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey.withOpacity(0.01),
              ),
              child: TextFormField(
                controller: prdsrcbtn.mycontroller[2],
                cursorColor: Colors.grey,
                onChanged: (v) {
                  st(() {
                    prdsrcbtn.filtercustomerList(v);
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
                    itemCount: prdsrcbtn.getfiltercustList1.length,
                    itemBuilder: (context, index) {
                      log(" prdsrcbtn.getfiltercustList1.length:${prdsrcbtn.getfiltercustList1.length}");
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
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: ListTile(
                            onTap: () {
                              prdsrcbtn.custSelected(
                                  prdsrcbtn.getfiltercustList1[index],
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
                                        prdsrcbtn.getfiltercustList1[index]
                                            .cardCode!,
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ),
                                    SizedBox(
                                      width: Screens.width(context) * 0.25,
                                      child: Text(
                                        prdsrcbtn.config.splitValues(prdsrcbtn
                                            .getfiltercustList1[index]
                                            .accBalance!
                                            .toString()),
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
                                            .getfiltercustList1[index].name!,
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ),
                                    SizedBox(
                                      width: Screens.width(context) * 0.25,
                                      child: Text(
                                        prdsrcbtn
                                            .getfiltercustList1[index].phNo!,
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
            SizedBox(height: Screens.padingHeight(context) * 0.01),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                widget.prdCD.clearCustomer();
                widget.prdCD.clearAddress();
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        contentPadding: const EdgeInsets.all(0),
                        insetPadding:
                            EdgeInsets.all(Screens.bodyheight(context) * 0.02),
                        content:
                            forAddNewBtn(context, widget.prdCD, "New Customer"),
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

  forAddNewBtn(
      BuildContext context, PayreceiptController prdadd, String title) {
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
                            width: Screens.width(context) * 0.4,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              title,
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
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
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
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
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
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
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
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
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
                    AddressWidget(
                      theme: theme,
                      payreceipt: prdadd,
                      custHeight: Screens.padingHeight(context),
                      custWidth: Screens.width(context),
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
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
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
                        } else if (title == "Update Customer") {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                  contentPadding: const EdgeInsets.all(0),
                                  insetPadding: EdgeInsets.all(
                                      Screens.bodyheight(context) * 0.02),
                                  content: updateType(context, widget.prdCD,
                                      widget.prdCD.getselectedBillAdress!),
                                );
                              });
                        }
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
      BuildContext context, ThemeData theme, PayreceiptController posC) {
    return List.generate(
      posC.custList2.length,
      (ind) {
        log("posC.custList.length::${posC.custList2.length}");
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
  PayreceiptController posC;
  ThemeData theme;
  int ind;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        posC.custSelected(posC.custList2[ind], context, theme);
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: theme.primaryColor,
            border: Border.all(color: theme.primaryColor, width: 1),
            borderRadius: BorderRadius.circular(5)),
        child: Text(posC.custList2[ind].name!,
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

Widget updateType(BuildContext context, PayreceiptController pos, int i) {
  final theme = Theme.of(context);
  return SizedBox(
    width: Screens.width(context),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.center,
          height: Screens.padingHeight(context) * 0.05,
          decoration: BoxDecoration(
            color: theme.primaryColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
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

billAddress(BuildContext context, PayreceiptController pos) async {
  final theme = Theme.of(context);
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))),
          contentPadding: const EdgeInsets.all(0),
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
                  height: Screens.padingHeight(context) * 0.04,
                  color: theme.primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: Screens.padingHeight(context) * 0.03,
                        padding: EdgeInsets.only(
                            left: Screens.padingHeight(context) * 0.02,
                            right: Screens.padingHeight(context) * 0.02),
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
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: Screens.padingHeight(context) * 0.37,
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
                                    Text(
                                        "${pos.getselectedcust!.address![index].address1},${pos.getselectedcust!.address![index].address2}, ${pos.getselectedcust!.address![index].address3}"),
                                    Text(pos.getselectedcust!.address![index]
                                        .billCity),
                                    Text(pos.getselectedcust!.address![index]
                                        .billPincode),
                                    Text(pos.getselectedcust!.address![index]
                                        .billstate)
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
        );
      });
}

shipaddress(BuildContext context, PayreceiptController pos) async {
  final theme = Theme.of(context);
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))),
          contentPadding: const EdgeInsets.all(0),
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
                  height: Screens.padingHeight(context) * 0.37,
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
                            Text(
                                "${pos.getselectedcust!.address![index].address1}, ${pos.getselectedcust!.address![index].address2}, ${pos.getselectedcust!.address![index].address3},"),
                            Text(pos.getselectedcust!.address![index].billCity),
                            Text(pos
                                .getselectedcust!.address![index].billPincode),
                            Text(pos.getselectedcust!.address![index].billstate)
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
        );
      });
}

createAddress(BuildContext context, ThemeData theme, PayreceiptController pos) {
  final theme = Theme.of(context);
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))),
          contentPadding: const EdgeInsets.all(0),
          insetPadding: EdgeInsets.all(Screens.bodyheight(context) * 0.02),
          content: createAddressMethod(theme, context, pos),
        );
      });
}

Container createAddressMethod(
    ThemeData theme, BuildContext context, PayreceiptController pos) {
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
            payreceipt: pos,
            custHeight: Screens.padingHeight(context) * 0.7,
            custWidth: Screens.width(context) * 0.7,
          ),
          SizedBox(
            height: Screens.bodyheight(context) * 0.01,
          ),
          InkWell(
            onTap: () {},
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
      required this.payreceipt,
      required this.custHeight,
      required this.custWidth});

  final ThemeData theme;
  final double custHeight;
  final double custWidth;

  final PayreceiptController payreceipt;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, st) {
      return Form(
        key: payreceipt.formkeyAd,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey.withOpacity(0.01),
              ),
              child: TextFormField(
                autofocus: true,
                controller: payreceipt.mycontroller[7],
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
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.grey),
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey.withOpacity(0.01),
              ),
              child: TextFormField(
                controller: payreceipt.mycontroller[8],
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
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.grey),
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey.withOpacity(0.01),
              ),
              child: TextFormField(
                controller: payreceipt.mycontroller[9],
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
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.grey),
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
                  width: custWidth * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    controller: payreceipt.mycontroller[10],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
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
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: custWidth * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: payreceipt.mycontroller[11],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
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
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
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
                  width: custWidth * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    controller: payreceipt.mycontroller[12],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
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
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: custWidth * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    readOnly: true,
                    controller: payreceipt.mycontroller[13],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    decoration: InputDecoration(
                      hintText: "Ind",
                      filled: false,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
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
                  child: const Text("Copy As Ship Address"),
                ),
                Checkbox(
                    side: const BorderSide(color: Colors.grey),
                    activeColor: Colors.green,
                    value: payreceipt.checkboxx,
                    onChanged: (val) {
                      st(() {
                        payreceipt.checkboxx = val!;
                        payreceipt.billToShip(val);
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    autofocus: true,
                    controller: payreceipt.mycontroller[14],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
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
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    autofocus: true,
                    controller: payreceipt.mycontroller[15],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
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
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
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
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 240, 235, 235)),
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    autofocus: true,
                    controller: payreceipt.mycontroller[16],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
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
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
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
                  width: custWidth * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    controller: payreceipt.mycontroller[17],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
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
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: custWidth * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: payreceipt.mycontroller[18],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
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
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
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
                  width: custWidth * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    controller: payreceipt.mycontroller[19],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
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
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: custWidth * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    readOnly: true,
                    controller: payreceipt.mycontroller[20],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    decoration: InputDecoration(
                      hintText: "Ind",
                      filled: false,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
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
        ),
      );
    });
  }
}



// // ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, avoid_unnecessary_containers
// import 'dart:developer';

// import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// import 'package:posproject/Constant/Screen.dart';
// import '../../../../../../Controller/PaymentReceiptController/PayReceiptController.dart';

// class PayReceipt_CustomerDetails extends StatelessWidget {
//   PayReceipt_CustomerDetails({
//     Key? key,
//     required this.theme,
//     required this.prdCD,
//     required this.CusHeight,
//     required this.CusWidth,
//   }) : super(key: key);
//   double CusHeight;
//   double CusWidth;

//   final ThemeData theme;
//   PayreceiptController prdCD;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Container(
//       width: Screens.width(context),
//       padding: EdgeInsets.symmetric(
//           horizontal: Screens.width(context) * 0.01,
//           vertical: Screens.padingHeight(context) * 0.01),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 3,
//             blurRadius: 7,
//             offset: Offset(0, 3), // changes position of shadow
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Container(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Container(
//                 
//                 
//                   height: CusHeight * 0.34,
//                   width: CusWidth * 0.97,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(color: Colors.grey[300]!),
//                     borderRadius: BorderRadius.all(Radius.circular(5)),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.white.withOpacity(0.3), //color of shadow
//                         spreadRadius: 3, //spread radius
//                         blurRadius: 2, // blur radius
//                         offset: Offset(0, 2), // changes position of shadow
//                       ),
//                     ],
//                   ),
//                   child: TextFormField(
//                     onTap: () {
//                     },
//                   
//                   
//                     controller: prdCD.mycontroller[81],
//                     style: theme.textTheme.bodyText2!
//                         .copyWith(color: Colors.black),
//                     keyboardType: TextInputType.text,
//                   
//                     onEditingComplete: () {
//                       prdCD.custcodeScan(context, theme);
//                     
//                     },
//                   
//                   
//                   
//                   
//                   
//                   
//                   
//                   
//                   
//                   
//                   
//                   
//                   
//                   
//                   
//                   
//                   
//                     onChanged: (val) {
//                     },

//                   
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       filled: false,
//                       contentPadding:
//                           EdgeInsets.symmetric(horizontal: CusWidth * 0.026),
//                       hintText: "Customers..!!",
//                       hintStyle: theme.textTheme.bodyText2!
//                           .copyWith(color: Colors.grey[600]),
//                       suffixIcon: Padding(
//                         padding: EdgeInsets.all(CusHeight * 0.02),
//                         child: Container(
//                           width: CusWidth * 0.03,
//                           height: CusHeight,
//                           decoration: BoxDecoration(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(5)),
//                             
//                               shape: BoxShape.rectangle),
//                           child: IconButton(
//                             onPressed: () {
//                               showDialog(
//                                   context: context,
//                                   barrierDismissible: false,
//                                   builder: (BuildContext context) {
//                                     return AlertDialog(
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(4))),
//                                       contentPadding: EdgeInsets.all(0),
//                                     
//                                       insetPadding: EdgeInsets.all(
//                                           Screens.bodyheight(context) * 0.02),
//                                       content: forSearchBtn(context, prdCD),
//                                     );
//                                   });
//                             },
//                             icon: Icon(
//                               Icons.search,
//                             
//                             ),
//                           ),
//                         ),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                         borderSide: BorderSide(color: Colors.white),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                         borderSide: BorderSide(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           SizedBox(
//             height: Screens.bodyheight(context) * 0.005,
//           ),
//           prdCD.getselectedcust == null
//               ? Container(
//                   alignment: Alignment.centerLeft,
//                 
//                   width: CusWidth,
//                   padding: EdgeInsets.all(
//                     CusHeight * 0.02,
//                   ),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     color: Colors.white,
//                   
//                   
//                   ),
//                   child: Wrap(
//                       spacing: Screens.bodyheight(context) * 0.008,
//                       runSpacing: 10.0,
//                       children: listContainersProduct(
//                         context,
//                         theme,
//                         prdCD,
//                       )),
//                 )
//               : Container(
//                   alignment: Alignment.center,
//                 
//                   width: CusWidth,
//                   padding: EdgeInsets.all(
//                     CusHeight * 0.02,
//                   ),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     color: Colors.white,
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             alignment: Alignment.centerLeft,
//                             width: CusWidth * 0.75,
//                           
//                             child: Text(prdCD.getselectedcust!.name.toString(),
//                                 style: theme.textTheme.subtitle2!
//                                     .copyWith(fontSize: 20)),
//                           ),
//                           InkWell(
//                             onTap: () {
//                             
//                             
//                               showDialog(
//                                   context: context,
//                                   builder: (BuildContext context) {
//                                     return AlertDialog(
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(4))),
//                                       contentPadding: EdgeInsets.all(0),
//                                     
//                                       insetPadding: EdgeInsets.all(
//                                           Screens.bodyheight(context) * 0.02),
//                                       content: forAddNewBtn(
//                                           context, prdCD, "Update Customer"),
//                                     );
//                                   });
//                             },
//                             child: Container(
//                               alignment: Alignment.centerRight,
//                               width: CusWidth * 0.1,
//                               height: CusHeight * 0.2,
//                               child: Icon(Icons.edit),
//                             ),
//                           ),
//                           Container(
//                               alignment: Alignment.centerRight,
//                               width: CusWidth * 0.12,
//                               height: CusHeight * 0.2,
//                             
//                               child: IconButton(
//                                 onPressed: () {
//                                   prdCD.clearpayData();
//                                 },
//                                 icon: Icon(Icons.close),
//                                 iconSize: 24,
//                               )),
//                         ],
//                       ),
//                       Container(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               alignment: Alignment.centerLeft,
//                             
//                             
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     child: Icon(
//                                       Icons.phone,
//                                       color: Colors.black54,
//                                     
//                                     ),
//                                   ),
//                                   Text(prdCD.getselectedcust!.phNo.toString(),
//                                       style: theme.textTheme.bodyText2!
//                                           .copyWith()),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               alignment: Alignment.centerRight,
//                             
//                               height: CusHeight * 0.22,

//                             
//                               child: Text(" | "),
//                             ),
//                             Container(
//                               alignment: Alignment.centerLeft,
//                               width: CusWidth * 0.6,
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     Icons.mail,
//                                     color: Colors.grey,
//                                   ),
//                                   Container(
//                                   
//                                     child: Text(
//                                         prdCD.getselectedcust!.email.toString(),
//                                         style: theme.textTheme.bodyText2!
//                                             .copyWith()),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width: CusWidth,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               width: CusWidth * 0.51,
//                             
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     width: CusWidth * 0.28,
//                                   
//                                     child: Text(
//                                       "GST#",
//                                     
//                                       style:
//                                           theme.textTheme.bodyText2!.copyWith(
//                                             
//                                             
//                                               color: Colors.black),
//                                     ),
//                                   ),
//                                   Container(
//                                     alignment: Alignment.centerLeft,
//                                     width: CusWidth * 0.23,
//                                   
//                                     child: Text(
//                                       "${prdCD.getselectedcust!.tarNo}",
//                                       style:
//                                           theme.textTheme.bodyText2!.copyWith(),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               width: CusWidth * 0.46,
//                             
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     width: CusWidth * 0.17,
//                                   
//                                     alignment: Alignment.centerRight,
//                                     child: Text(
//                                       "Balance",
//                                       style:
//                                           theme.textTheme.bodyText2!.copyWith(
//                                             
//                                             
//                                               color: Colors.black),
//                                     ),
//                                   ),
//                                   Container(
//                                     child: 
//                                   
//                                   
//                                         Text(prdCD.getselectedcust!.accBalance
//                                             .toString()
//                                             .replaceAll(",", ""))
//                                       
//                                       
//                                       
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width: CusWidth,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               width: CusWidth * 0.51,
//                             
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     width: CusWidth * 0.28,
//                                   
//                                     child: Text(
//                                       "Code#",
//                                       style:
//                                           theme.textTheme.bodyText2!.copyWith(
//                                             
//                                             
//                                               color: Colors.black),
//                                     ),
//                                   ),
//                                   Container(
//                                     alignment: Alignment.centerLeft,
//                                     width: CusWidth * 0.23,
//                                   
//                                     child: Text(
//                                       "${prdCD.getselectedcust!.cardCode}",
//                                       style:
//                                           theme.textTheme.bodyText2!.copyWith(),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               width: CusWidth * 0.46,
//                             
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     width: CusWidth * 0.17,
//                                   
//                                     alignment: Alignment.centerRight,
//                                     child: Text(
//                                       "Point",
//                                       style:
//                                           theme.textTheme.bodyText2!.copyWith(
//                                             
//                                             
//                                               color: Colors.black),
//                                     ),
//                                   ),
//                                   Container(
//                                     width: CusWidth * 0.23,
//                                   
//                                     alignment: Alignment.centerRight,
//                                     child: Text(
//                                       "${prdCD.getselectedcust!.point}",
//                                       style:
//                                           theme.textTheme.bodyText2!.copyWith(),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               billAddress(context, prdCD);
//                             },
//                             child: Container(
//                               width: Screens.width(context) * 0.4,
//                             
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     width: Screens.width(context) * 0.4,
//                                     padding: EdgeInsets.only(
//                                         right: Screens.width(context) * 0.02),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(
//                                             child: Text(
//                                           "Billing Address",
//                                           style: theme.textTheme.bodyMedium
//                                               ?.copyWith(color: Colors.black54),
//                                         )),
//                                         Container(
//                                             width:
//                                                 Screens.width(context) * 0.04,
//                                             child: Icon(
//                                               Icons.arrow_drop_down,
//                                               size: 30,
//                                             ))
//                                       ],
//                                     ),
//                                   ),
//                                   Container(
//                                       child: Text(
//                                     "${prdCD.getselectedcust!.address![prdCD.getselectedBillAdress!].address1 != null ? prdCD.getselectedcust!.address![prdCD.getselectedBillAdress!].address1.toString() : ""}" +
//                                         "${prdCD.getselectedcust!.address![prdCD.getselectedBillAdress!].address2 != null ? prdCD.getselectedcust!.address![prdCD.getselectedBillAdress!].address2.toString() : ""}" +
//                                         "${prdCD.getselectedcust!.address![prdCD.getselectedBillAdress!].address3 != null ? prdCD.getselectedcust!.address![prdCD.getselectedBillAdress!].address3.toString() : ""}",
//                                     maxLines: 1,
//                                     style: theme.textTheme.bodyMedium
//                                         ?.copyWith(color: Colors.black54),
//                                   )),
//                                   Container(
//                                       child: Text(
//                                     prdCD
//                                         .getselectedcust!
//                                         .address![prdCD.getselectedBillAdress!]
//                                         .billCity
//                                         .toString(),
//                                     maxLines: 1,
//                                     style: theme.textTheme.bodyMedium
//                                         ?.copyWith(color: Colors.black54),
//                                   )),
//                                   Container(
//                                       child: Text(
//                                     prdCD
//                                         .getselectedcust!
//                                         .address![prdCD.getselectedBillAdress!]
//                                         .billPincode
//                                         .toString(),
//                                     maxLines: 1,
//                                     style: theme.textTheme.bodyMedium
//                                         ?.copyWith(color: Colors.black54),
//                                   )),
//                                   Container(
//                                       child: Text(
//                                     prdCD
//                                         .getselectedcust!
//                                         .address![prdCD.getselectedBillAdress!]
//                                         .billstate
//                                         .toString(),
//                                     maxLines: 1,
//                                     style: theme.textTheme.bodyMedium
//                                         ?.copyWith(color: Colors.black54),
//                                   )),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () {
//                             
//                             },
//                             child: Container(
//                               width: Screens.width(context) * 0.465,
//                             
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     width: Screens.width(context) * 0.465,
//                                     padding: EdgeInsets.only(
//                                         right: Screens.width(context) * 0.02),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(
//                                             child: Text(
//                                           "Ship Address",
//                                           maxLines: 2,
//                                           style: theme.textTheme.bodyMedium
//                                               ?.copyWith(color: Colors.black54),
//                                         )),
//                                         Container(
//                                             width:
//                                                 Screens.width(context) * 0.04,
//                                             child: Icon(
//                                               Icons.arrow_drop_down,
//                                               size: 30,
//                                             ))
//                                       ],
//                                     ),
//                                   ),
//                                   Container(
//                                       child: Text(
//                                     '${prdCD.getselectedcust!.address![prdCD.getselectedShipAdress!].address1 != null ? prdCD.getselectedcust!.address![prdCD.getselectedShipAdress!].address1.toString() : ''}' +
//                                         '${prdCD.getselectedcust!.address![prdCD.getselectedShipAdress!].address2 != null ? prdCD.getselectedcust!.address![prdCD.getselectedShipAdress!].address2.toString() : ''}' +
//                                         "${prdCD.getselectedcust!.address![prdCD.getselectedShipAdress!].address3 != null ? prdCD.getselectedcust!.address![prdCD.getselectedShipAdress!].address3.toString() : ""}",
//                                     maxLines: 1,
//                                     style: theme.textTheme.bodyMedium
//                                         ?.copyWith(color: Colors.black54),
//                                   )),
//                                   Container(
//                                       child: Text(
//                                     prdCD
//                                         .getselectedcust!
//                                         .address![prdCD.getselectedShipAdress!]
//                                         .billCity
//                                         .toString(),
//                                     maxLines: 1,
//                                     style: theme.textTheme.bodyMedium
//                                         ?.copyWith(color: Colors.black54),
//                                   )),
//                                   Container(
//                                       child: Text(
//                                     prdCD
//                                         .getselectedcust!
//                                         .address![prdCD.getselectedShipAdress!]
//                                         .billPincode
//                                         .toString(),
//                                     maxLines: 1,
//                                     style: theme.textTheme.bodyMedium
//                                         ?.copyWith(color: Colors.black54),
//                                   )),
//                                   Container(
//                                       child: Text(
//                                     prdCD
//                                         .getselectedcust!
//                                         .address![prdCD.getselectedShipAdress!]
//                                         .billstate
//                                         .toString(),
//                                     maxLines: 1,
//                                     style: theme.textTheme.bodyMedium
//                                         ?.copyWith(color: Colors.black54),
//                                   )),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   )),
//         ],
//       ),
//     );
//   }

//   forSearchBtn(BuildContext context, PayreceiptController prdsrcbtn) {
//     final theme = Theme.of(context);
//     return StatefulBuilder(builder: (context, st) {
//       return Container(
//         width: Screens.width(context),
//         height: Screens.padingHeight(context) * 0.7,
//         padding: EdgeInsets.only(
//             top: Screens.padingHeight(context) * 0.01,
//             left: Screens.width(context) * 0.02,
//             right: Screens.width(context) * 0.02,
//             bottom: Screens.padingHeight(context) * 0.01),
//         color: Colors.white,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: Screens.width(context),
//               height: Screens.padingHeight(context) * 0.05,
//               color: theme.primaryColor,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.only(
//                         left: Screens.padingHeight(context) * 0.02,
//                         right: Screens.padingHeight(context) * 0.02),
//                   
//                     width: Screens.width(context) * 0.4,
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       "Select Customer",
//                       style: theme.textTheme.bodyText2
//                           ?.copyWith(color: Colors.white),
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: Icon(
//                         Icons.close,
//                         size: Screens.padingHeight(context) * 0.025,
//                         color: Colors.white,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(height: Screens.padingHeight(context) * 0.01),
//             Container(
//               width: Screens.width(context) * 0.9,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Color.fromARGB(255, 240, 235, 235)),
//                 borderRadius: BorderRadius.circular(3),
//                 color: Colors.grey.withOpacity(0.01),
//               ),
//               child: TextFormField(
//                 controller: prdsrcbtn.mycontroller[2],
//                 cursorColor: Colors.grey,
//                 onChanged: (v) {
//                   st(() {
//                     prdsrcbtn.filtertop10List(v);
//                   });
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'Search customer..!!',
//                   hintStyle:
//                       theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
//                   filled: true,
//                   enabledBorder: InputBorder.none,
//                   focusedBorder: InputBorder.none,
//                   contentPadding: const EdgeInsets.symmetric(
//                     vertical: 12,
//                     horizontal: 25,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: Screens.padingHeight(context) * 0.01),
//             Expanded(
//                 child: ListView.builder(
//                     itemCount: prdsrcbtn.getfiltercustList1.length,
//                     itemBuilder: (context, index) {
//                       log("prdsrcbtn.getfiltercustList1.length::" +
//                           prdsrcbtn.getfiltercustList1.length.toString());
//                       return Card(
//                         child: Container(
//                           padding: EdgeInsets.only(
//                               top: Screens.padingHeight(context) * 0.01,
//                               left: Screens.width(context) * 0.01,
//                               right: Screens.width(context) * 0.01,
//                               bottom: Screens.padingHeight(context) * 0.01),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 spreadRadius: 2,
//                                 blurRadius: 2,
//                                 offset:
//                                     Offset(0, 3), // changes position of shadow
//                               ),
//                             ],
//                           ),
//                           child: ListTile(
//                             onTap: () {
//                               prdsrcbtn.custSelected(
//                                   prdsrcbtn.getfiltercustList1[index], context);
//                               Navigator.pop(context);
//                             },
//                             title: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       width: Screens.width(context) * 0.25,
//                                       child: Text(
//                                         prdsrcbtn.getfiltercustList1[index]
//                                             .cardCode!,
//                                         style: theme.textTheme.bodySmall,
//                                       ),
//                                     ),
//                                     Container(
//                                       width: Screens.width(context) * 0.25,
//                                       child: Text(
//                                         prdsrcbtn.getfiltercustList1[index]
//                                             .accBalance!
//                                             .toString(),
//                                         style: theme.textTheme.bodySmall,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       width: Screens.width(context) * 0.25,
//                                       child: Text(
//                                         prdsrcbtn
//                                             .getfiltercustList1[index].name!,
//                                         style: theme.textTheme.bodySmall,
//                                       ),
//                                     ),
//                                     Container(
//                                       width: Screens.width(context) * 0.25,
//                                       child: Text(
//                                         prdsrcbtn
//                                             .getfiltercustList1[index].phNo!,
//                                         style: theme.textTheme.bodySmall,
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     })),
//           
//             SizedBox(height: Screens.padingHeight(context) * 0.01),
//             InkWell(
//               onTap: () {
//                 Navigator.pop(context);
//                 prdsrcbtn.clearCustomer();
//                 prdsrcbtn.clearAddress();
//                 showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(4))),
//                         contentPadding: EdgeInsets.all(0),
//                       
//                         insetPadding:
//                             EdgeInsets.all(Screens.bodyheight(context) * 0.02),
//                         content:
//                             forAddNewBtn(context, prdsrcbtn, "New Customer"),
//                       );
//                     });
//               },
//               child: Container(
//                 alignment: Alignment.center,
//                 height: Screens.padingHeight(context) * 0.045,
//                 decoration: BoxDecoration(
//                   color: theme.primaryColor,
//                 ),
//                 child: Center(
//                   child: Container(
//                     alignment: Alignment.center,
//                     child: Text(
//                       "Add New",
//                       textAlign: TextAlign.center,
//                       style: theme.textTheme.bodyMedium
//                           ?.copyWith(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       );
//     });
//   }

//   forAddNewBtn(
//       BuildContext context, PayreceiptController prdadd, String title) {
//     final theme = Theme.of(context);
//     return StatefulBuilder(builder: (context, st) {
//       return Container(
//         padding: EdgeInsets.only(
//             top: Screens.padingHeight(context) * 0.02,
//             left: Screens.width(context) * 0.02,
//             right: Screens.width(context) * 0.02,
//             bottom: Screens.padingHeight(context) * 0.01),
//         width: Screens.width(context),
//         height: Screens.padingHeight(context) * 0.7,
//       
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Form(
//                 key: prdadd.formkey[6],
//                 child: Column(
//                   children: [
//                     Container(
//                       width: Screens.width(context),
//                       height: Screens.padingHeight(context) * 0.05,
//                       color: theme.primaryColor,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             padding: EdgeInsets.only(
//                                 left: Screens.padingHeight(context) * 0.02,
//                                 right: Screens.padingHeight(context) * 0.02),
//                           
//                             width: Screens.width(context) * 0.4,
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               title,
//                               style: theme.textTheme.bodyText2
//                                   ?.copyWith(color: Colors.white),
//                             ),
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                             child: IconButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               icon: Icon(
//                                 Icons.close,
//                                 size: Screens.padingHeight(context) * 0.025,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: Screens.padingHeight(context) * 0.02,
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(3),
//                         color: Colors.grey.withOpacity(0.01),
//                       ),
//                       child: TextFormField(
//                         autofocus: true,
//                         controller: prdadd.mycontroller[3],
//                         cursorColor: Colors.grey,
//                         style: theme.textTheme.bodyMedium
//                             ?.copyWith(color: Colors.black),
//                         onChanged: (v) {},
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Please Enter the Customer Code";
//                           } else {
//                             return null;
//                           }
//                         },
//                         decoration: InputDecoration(
//                           labelText: 'Customer Code',
//                           filled: false,
//                           errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             vertical: 5,
//                             horizontal: 10,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: Screens.padingHeight(context) * 0.03,
//                     ),
//                     Container(
//                     
//                     
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(3),
//                         color: Colors.grey.withOpacity(0.01),
//                       ),
//                       child: TextFormField(
//                         autofocus: true,
//                         keyboardType: TextInputType.number,
//                         controller: prdadd.mycontroller[4],
//                         cursorColor: Colors.grey,
//                         style: theme.textTheme.bodyMedium
//                             ?.copyWith(color: Colors.black),
//                         onChanged: (v) {},
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Please Enter the Mobile Number";
//                           } else {
//                             return null;
//                           }
//                         },
//                         decoration: InputDecoration(
//                           labelText: 'Mobile Number',
//                           filled: false,
//                           errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             vertical: 5,
//                             horizontal: 10,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: Screens.padingHeight(context) * 0.03,
//                     ),
//                     Container(
//                     
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(3),
//                         color: Colors.grey.withOpacity(0.01),
//                       ),
//                       child: TextFormField(
//                         autofocus: true,
//                         controller: prdadd.mycontroller[5],
//                         cursorColor: Colors.grey,
//                         style: theme.textTheme.bodyMedium
//                             ?.copyWith(color: Colors.black),
//                         onChanged: (v) {},
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Please Enter the GST No";
//                           } else {
//                             return null;
//                           }
//                         },
//                         decoration: InputDecoration(
//                           labelText: "Gst",
//                           filled: false,
//                           errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             vertical: 5,
//                             horizontal: 10,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: Screens.padingHeight(context) * 0.03,
//                     ),
//                     Container(
//                     
//                     
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(3),
//                         color: Colors.grey.withOpacity(0.01),
//                       ),
//                       child: TextFormField(
//                         controller: prdadd.mycontroller[6],
//                         cursorColor: Colors.grey,
//                         style: theme.textTheme.bodyMedium
//                             ?.copyWith(color: Colors.black),
//                         onChanged: (v) {},
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Please Enter the Name";
//                           } else {
//                             return null;
//                           }
//                         },
//                         decoration: InputDecoration(
//                           labelText: "Name",
//                           filled: false,
//                           errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             vertical: 5,
//                             horizontal: 10,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: Screens.padingHeight(context) * 0.02,
//                     ),
//                   
//                     AddressWidget(
//                       theme: theme,
//                       PayreceiptController: prdadd,
//                       custHeight: Screens.padingHeight(context),
//                       custWidth: Screens.width(context),
//                     ),

//                     SizedBox(
//                       height: Screens.padingHeight(context) * 0.02,
//                     ),
//                     Container(
//                     
//                     
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(3),
//                         color: Colors.grey.withOpacity(0.01),
//                       ),
//                       child: TextFormField(
//                         controller: prdadd.mycontroller[21],
//                         cursorColor: Colors.grey,
//                         style: theme.textTheme.bodyMedium
//                             ?.copyWith(color: Colors.black),
//                         onChanged: (v) {},
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Please Enter the Email Address";
//                           } else {
//                             return null;
//                           }
//                         },
//                         decoration: InputDecoration(
//                           labelText: "Email",
//                           filled: false,
//                           errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             vertical: 5,
//                             horizontal: 10,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: Screens.padingHeight(context) * 0.02,
//                     ),
//                     InkWell(
//                       onTap: () {
//                         if (title == "New Customer") {
//                           prdadd.addnewCustomer(context, 6);
//                         } else if (title == "Update Customer") {
//                           showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return AlertDialog(
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(4))),
//                                   contentPadding: EdgeInsets.all(0),
//                                 
//                                   insetPadding: EdgeInsets.all(
//                                       Screens.bodyheight(context) * 0.02),
//                                   content: updateType(context, prdCD),
//                                 );
//                               });
//                         }
//                       },
//                       child: Container(
//                         alignment: Alignment.center,
//                         height: Screens.padingHeight(context) * 0.045,
//                         decoration: BoxDecoration(
//                           color: theme.primaryColor,
//                         
//                         
//                         ),
//                         child: Center(
//                           child: Container(
//                             alignment: Alignment.center,
//                             child: Text(
//                               title == "New Customer" ? "Save" : "Update",
//                               textAlign: TextAlign.center,
//                               style: theme.textTheme.bodyMedium
//                                   ?.copyWith(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }

//   List<Widget> listContainersProduct(
//       BuildContext context, ThemeData theme, PayreceiptController posC) {
//     return List.generate(
//       posC.custList.length >= 10 ? 10 : posC.custList.length,
//       (ind) {
//         return TopCustomer(ind: ind, posC: posC, theme: theme);
//       },
//     );
//   }
// }

// class TopCustomer extends StatelessWidget {
//   TopCustomer({
//     Key? key,
//     required this.ind,
//     required this.posC,
//     required this.theme,
//   }) : super(key: key);
//   PayreceiptController posC;
//   ThemeData theme;
//   int ind;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         print("Datatatat: ");
//         posC.custSelected(
//           posC.custList[ind],
//           context,
//         );
//       },
//       child: Container(
//         padding: EdgeInsets.all(Screens.bodyheight(context) * 0.003),
//         decoration: BoxDecoration(
//             color: theme.primaryColor,
//             border: Border.all(color: theme.primaryColor, width: 1),
//             borderRadius: BorderRadius.circular(5)),
//         child: Text(posC.custList[ind].name.toString(),
//             textAlign: TextAlign.center,
//             style: theme.textTheme.bodyText2?.copyWith(
//               fontWeight: FontWeight.normal,
//               fontSize: 16,
//               color: Colors.white,
//             )),
//       ),
//     );
//   }
// }

// Widget updateType(BuildContext context, PayreceiptController pos) {
//   final theme = Theme.of(context);
//   return Container(
//     width: Screens.width(context),
//   

//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           alignment: Alignment.center,
//           height: Screens.padingHeight(context) * 0.05,
//           decoration: BoxDecoration(
//             color: theme.primaryColor,
//           
//           
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//               
//                 width: Screens.width(context) * 0.4,
//                 alignment: Alignment.center,
//                 child: Text(
//                   "Confrim update",
//                   textAlign: TextAlign.center,
//                   style:
//                       theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: Icon(
//                     Icons.close,
//                     size: Screens.padingHeight(context) * 0.025,
//                     color: Colors.white,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//         SizedBox(
//           height: Screens.bodyheight(context) * 0.02,
//         ),
//         Container(
//           width: Screens.width(context) * 0.9,
//           padding: EdgeInsets.symmetric(
//             vertical: Screens.padingHeight(context) * 0.01,
//             horizontal: Screens.width(context) * 0.01,
//           ),
//           child: Column(
//             children: [
//               Container(
//                 child: Text(
//                   "Do you want to update this customer for this sale or update to server..!!",
//                   style: theme.textTheme.bodyText2,
//                 ),
//               ),
//               SizedBox(
//                 height: Screens.bodyheight(context) * 0.02,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     width: Screens.width(context) * 0.4,
//                     child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         
//                           Navigator.pop(context);
//                         },
//                         child: Text(
//                           "Update to server",
//                           textAlign: TextAlign.center,
//                           style: theme.textTheme.bodyMedium
//                               ?.copyWith(color: Colors.white),
//                         )),
//                   ),
//                   Container(
//                       width: Screens.width(context) * 0.4,
//                       child: ElevatedButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           
//                             Navigator.pop(context);
//                           },
//                           child: Text(
//                             "This sale",
//                             textAlign: TextAlign.center,
//                             style: theme.textTheme.bodyMedium
//                                 ?.copyWith(color: Colors.white),
//                           ))),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }

// billAddress(BuildContext context, PayreceiptController pos) async {
//   final theme = Theme.of(context);
//   return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(4))),
//           contentPadding: EdgeInsets.all(0),
//         
//           insetPadding: EdgeInsets.all(Screens.bodyheight(context) * 0.02),
//           content: Container(
//             width: Screens.width(context),
//             padding: EdgeInsets.symmetric(
//               vertical: Screens.padingHeight(context) * 0.01,
//               horizontal: Screens.width(context) * 0.01,
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   width: Screens.width(context),
//                   height: Screens.padingHeight(context) * 0.05,
//                   color: theme.primaryColor,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         padding: EdgeInsets.only(
//                             left: Screens.padingHeight(context) * 0.02,
//                             right: Screens.padingHeight(context) * 0.02),
//                       
//                         width: Screens.width(context) * 0.4,
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           "Address",
//                           style: theme.textTheme.bodyText2
//                               ?.copyWith(color: Colors.white),
//                         ),
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         child: IconButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           icon: Icon(
//                             Icons.close,
//                             size: Screens.padingHeight(context) * 0.025,
//                             color: Colors.white,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 Container(
//                   height: Screens.padingHeight(context) * 0.4,
//                   padding: EdgeInsets.symmetric(
//                     vertical: Screens.padingHeight(context) * 0.01,
//                     horizontal: Screens.width(context) * 0.01,
//                   ),
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: pos.selectcust!.address!.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return InkWell(
//                         onTap: () {
//                           pos.changeBillAddress(index);
//                           Navigator.pop(context);
//                         },
//                         child: Card(
//                             child: Container(
//                                 padding: EdgeInsets.symmetric(
//                                   vertical:
//                                       Screens.padingHeight(context) * 0.01,
//                                   horizontal: Screens.width(context) * 0.01,
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                   
//                                   
//                                   
//                                   
//                                   
//                                   
//                                   
//                                   
//                                   
//                                     Container(
//                                       child: Text(
//                                           "${pos.selectcust!.address![index].address1}${pos.selectcust!.address![index].address2}${pos.selectcust!.address![index].address3}"),
//                                     ),
//                                     Container(
//                                       child: Text(
//                                           pos.selectcust!.address![index].billCity),
//                                     ),
//                                     Container(
//                                       child: Text(
//                                           pos.selectcust!.address![index].billPincode),
//                                     ),
//                                     Container(
//                                       child: Text(
//                                           pos.selectcust!.address![index].billstate),
//                                     )
//                                   ],
//                                 ))),
//                       );
//                     },
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     Navigator.pop(context);
//                     pos.clearAddress();
//                     createAddress(context, theme, pos);
//                   },
//                   child: Container(
//                     alignment: Alignment.center,
//                     height: Screens.padingHeight(context) * 0.045,
//                     decoration: BoxDecoration(
//                       color: theme.primaryColor,
//                     
//                     
//                     ),
//                     child: Center(
//                       child: Container(
//                         alignment: Alignment.center,
//                         child: Text(
//                           "Create address",
//                           textAlign: TextAlign.center,
//                           style: theme.textTheme.bodyMedium
//                               ?.copyWith(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         
//         
//         
//         
//         
//         
//         
//         
//         
//         );
//       });
// }

// shipaddress(BuildContext context, PayreceiptController pos) async {
//   final theme = Theme.of(context);
//   return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(4))),
//           contentPadding: EdgeInsets.all(0),
//         
//           insetPadding: EdgeInsets.all(Screens.bodyheight(context) * 0.02),
//           content: Container(
//             width: Screens.width(context),
//             padding: EdgeInsets.symmetric(
//               vertical: Screens.padingHeight(context) * 0.01,
//               horizontal: Screens.width(context) * 0.01,
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   width: Screens.width(context),
//                   height: Screens.padingHeight(context) * 0.05,
//                   color: theme.primaryColor,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         padding: EdgeInsets.only(
//                             left: Screens.padingHeight(context) * 0.02,
//                             right: Screens.padingHeight(context) * 0.02),
//                       
//                         width: Screens.width(context) * 0.4,
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           "Address",
//                           style: theme.textTheme.bodyText2
//                               ?.copyWith(color: Colors.white),
//                         ),
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         child: IconButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           icon: Icon(
//                             Icons.close,
//                             size: Screens.padingHeight(context) * 0.025,
//                             color: Colors.white,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 Container(
//                   height: Screens.padingHeight(context) * 0.4,
//                 
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: pos.selectcust!.address!.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return InkWell(
//                         onTap: () {
//                           pos.changeShipAddress(index);
//                           Navigator.pop(context);
//                         },
//                         child: Card(
//                             child: Container(
//                                 child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                           
//                           
//                           
//                           
//                           
//                           
//                           
//                           
//                           
//                           
//                             Container(
//                               child: Text(
//                                   pos.selectcust!.address![index].address1!+ pos.selectcust!.address![index].address2!+ pos.selectcust!.address![index].address3!),
//                             ),
//                             Container(
//                               child: Text(
//                                   pos.selectcust!.address![index].billCity),
//                             ),
//                             Container(
//                               child: Text(
//                                   pos.selectcust!.address![index].billPincode),
//                             ),
//                             Container(
//                               child: Text(
//                                   pos.selectcust!.address![index].billstate),
//                             )
//                           ],
//                         ))),
//                       );
//                     },
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     Navigator.pop(context);
//                     pos.clearAddress();
//                     createAddress(context, theme, pos);
//                   },
//                   child: Container(
//                     alignment: Alignment.center,
//                     height: Screens.padingHeight(context) * 0.045,
//                     decoration: BoxDecoration(
//                       color: theme.primaryColor,
//                     
//                     
//                     ),
//                     child: Center(
//                       child: Container(
//                         alignment: Alignment.center,
//                         child: Text(
//                           "Create address",
//                           textAlign: TextAlign.center,
//                           style: theme.textTheme.bodyMedium
//                               ?.copyWith(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         
//         
//         
//         
//         
//         
//         
//         
//         
//         );
//       });
// }

// createAddress(
//     BuildContext context, ThemeData theme, PayreceiptController pos) async {
//   final theme = Theme.of(context);
//   return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(4))),
//           contentPadding: EdgeInsets.all(0),
//         
//           insetPadding: EdgeInsets.all(Screens.bodyheight(context) * 0.02),
//         
//           content: createAddressMethod(theme, context, pos),
//         
//         
//         
//         
//         
//         
//         
//         
//         );
//       });
// }

// Container createAddressMethod(
//     ThemeData theme, BuildContext context, PayreceiptController pos) {
//   return Container(
//     width: Screens.width(context),
//     height: Screens.padingHeight(context) * 0.7,
//     padding: EdgeInsets.only(
//       left: Screens.width(context) * 0.02,
//       right: Screens.width(context) * 0.02,
//       bottom: Screens.padingHeight(context) * 0.01,
//       top: Screens.padingHeight(context) * 0.01,
//     ),
//     child: SingleChildScrollView(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             alignment: Alignment.center,
//             height: Screens.padingHeight(context) * 0.045,
//             decoration: BoxDecoration(color: theme.primaryColor),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(
//                       left: Screens.padingHeight(context) * 0.02,
//                       right: Screens.padingHeight(context) * 0.02),
//                 
//                   width: Screens.width(context) * 0.4,
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "Create Address",
//                     style: theme.textTheme.bodyText2
//                         ?.copyWith(color: Colors.white),
//                   ),
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(
//                       Icons.close,
//                       size: Screens.padingHeight(context) * 0.025,
//                       color: Colors.white,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           SizedBox(
//             height: Screens.bodyheight(context) * 0.02,
//           ),
//           AddressWidget(
//             theme: theme,
//             PayreceiptController: pos,
//             custHeight: Screens.padingHeight(context) * 0.7,
//             custWidth: Screens.width(context) * 0.7,
//           ),
//           SizedBox(
//             height: Screens.bodyheight(context) * 0.01,
//           ),
//           InkWell(
//             onTap: () {
//               pos.addadress(context);
//             },
//             child: Container(
//               alignment: Alignment.center,
//               height: Screens.padingHeight(context) * 0.045,
//               decoration: BoxDecoration(
//                 color: theme.primaryColor,
//               
//               
//               ),
//               child: Center(
//                 child: Container(
//                   alignment: Alignment.center,
//                   child: Text(
//                     "Save",
//                     textAlign: TextAlign.center,
//                     style: theme.textTheme.bodyMedium
//                         ?.copyWith(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// }

// class AddressWidget extends StatelessWidget {
//   const AddressWidget(
//       {Key? key,
//       required this.theme,
//       required this.PayreceiptController,
//       required this.custHeight,
//       required this.custWidth})
//       : super(key: key);

//   final ThemeData theme;
//   final double custHeight;
//   final double custWidth;

//   final PayreceiptController PayreceiptController;

//   @override
//   Widget build(BuildContext context) {
//     return StatefulBuilder(builder: (context, st) {
//       return Column(
//         children: [
//           Container(
//           
//           
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(3),
//               color: Colors.grey.withOpacity(0.01),
//             ),
//             child: TextFormField(
//               controller: PayreceiptController.mycontroller[7],
//               cursorColor: Colors.grey,
//               style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
//               onChanged: (v) {},
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return "Please Enter the Address1";
//                 } else {
//                   return null;
//                 }
//               },
//               decoration: InputDecoration(
//                 labelText: "Bill Address1",
//                 filled: false,
//                 errorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(color: Colors.red),
//                 ),
//                 focusedErrorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(color: Colors.red),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(color: Colors.grey),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(color: Colors.grey),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(
//                   vertical: 5,
//                   horizontal: 10,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: custHeight * 0.02,
//           ),
//           Container(
//           
//           
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(3),
//               color: Colors.grey.withOpacity(0.01),
//             ),
//             child: TextFormField(
//               controller: PayreceiptController.mycontroller[8],
//               cursorColor: Colors.grey,
//               style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
//               onChanged: (v) {},
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return "Please Enter the Address2";
//                 } else {
//                   return null;
//                 }
//               },
//               decoration: InputDecoration(
//                 labelText: "Bill Address2",
//                 filled: false,
//                 errorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(color: Colors.red),
//                 ),
//                 focusedErrorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(color: Colors.red),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(color: Colors.grey),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(color: Colors.grey),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(
//                   vertical: 5,
//                   horizontal: 10,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: custHeight * 0.02,
//           ),
//           Container(
//           
//           
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(3),
//               color: Colors.grey.withOpacity(0.01),
//             ),
//             child: TextFormField(
//               controller: PayreceiptController.mycontroller[9],
//               cursorColor: Colors.grey,
//               style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
//               onChanged: (v) {},
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return "Please Enter the Address3";
//                 } else {
//                   return null;
//                 }
//               },
//               decoration: InputDecoration(
//                 labelText: "Bill Address3",
//                 filled: false,
//                 errorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(color: Colors.red),
//                 ),
//                 focusedErrorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(color: Colors.red),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(color: Colors.grey),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(color: Colors.grey),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(
//                   vertical: 5,
//                   horizontal: 10,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: custHeight * 0.02,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//               
//                 width: custWidth * 0.35,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(3),
//                   color: Colors.grey.withOpacity(0.01),
//                 ),
//                 child: TextFormField(
//                   controller: PayreceiptController.mycontroller[10],
//                   cursorColor: Colors.grey,
//                   style:
//                       theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
//                   onChanged: (v) {},
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Please Enter the City Name";
//                     } else {
//                       return null;
//                     }
//                   },
//                   decoration: InputDecoration(
//                     labelText: "City",
//                     filled: false,
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                       vertical: 5,
//                       horizontal: 10,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//               
//                 width: custWidth * 0.35,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(3),
//                   color: Colors.grey.withOpacity(0.01),
//                 ),
//                 child: TextFormField(
//                   controller: PayreceiptController.mycontroller[11],
//                   cursorColor: Colors.grey,
//                   style:
//                       theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
//                   onChanged: (v) {},
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Please Enter the Pincode";
//                     } else {
//                       return null;
//                     }
//                   },
//                   decoration: InputDecoration(
//                     labelText: "Pincode",
//                     filled: false,
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                       vertical: 5,
//                       horizontal: 10,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: custHeight * 0.02,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//               
//                 width: custWidth * 0.35,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(3),
//                   color: Colors.grey.withOpacity(0.01),
//                 ),
//                 child: TextFormField(
//                   controller: PayreceiptController.mycontroller[12],
//                   cursorColor: Colors.grey,
//                   style:
//                       theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
//                   onChanged: (v) {},
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Please Enter the State";
//                     } else {
//                       return null;
//                     }
//                   },
//                   decoration: InputDecoration(
//                     labelText: "State",
//                     filled: false,
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                       vertical: 5,
//                       horizontal: 10,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//               
//                 width: custWidth * 0.35,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(3),
//                   color: Colors.grey.withOpacity(0.01),
//                 ),
//                 child: TextFormField(
//                   readOnly: true,
//                   controller: PayreceiptController.mycontroller[13],
//                   cursorColor: Colors.grey,
//                   style:
//                       theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
//                   onChanged: (v) {},
//                 
//                 
//                 
//                 
//                 
//                 
//                 
//                   decoration: InputDecoration(
//                     hintText: "Ind",
//                     filled: false,
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                       vertical: 5,
//                       horizontal: 10,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: custHeight * 0.02,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 alignment: Alignment.centerLeft,
//                 height: custHeight * 0.1,
//                 child: Text("Copy As Ship Address"),
//               ),
//               Checkbox(
//                   side: BorderSide(color: Colors.grey),
//                   activeColor: Colors.green,
//                   value: PayreceiptController.checkboxx,
//                   onChanged: (val) {
//                     st(() {
//                       PayreceiptController.checkboxx = val!;
//                       PayreceiptController.billToShip(val);
//                     });
//                   }),
//             ],
//           ),
//           SizedBox(
//             height: custHeight * 0.02,
//           ),
//           Container(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                 
//                 
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(3),
//                     color: Colors.grey.withOpacity(0.01),
//                   ),
//                   child: TextFormField(
//                     autofocus: true,
//                     controller: PayreceiptController.mycontroller[14],
//                     cursorColor: Colors.grey,
//                     style: theme.textTheme.bodyMedium
//                         ?.copyWith(color: Colors.black),
//                     onChanged: (v) {},
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "Please Enter the Ship Address1";
//                       } else {
//                         return null;
//                       }
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'Ship Address1',
//                       filled: false,
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.red),
//                       ),
//                       focusedErrorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.red),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.grey),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.grey),
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                         vertical: 5,
//                         horizontal: 10,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: custHeight * 0.02,
//                 ),
//                 Container(
//                 
//                 
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(3),
//                     color: Colors.grey.withOpacity(0.01),
//                   ),
//                   child: TextFormField(
//                     autofocus: true,
//                     controller: PayreceiptController.mycontroller[15],
//                     cursorColor: Colors.grey,
//                     style: theme.textTheme.bodyMedium
//                         ?.copyWith(color: Colors.black),
//                     onChanged: (v) {},
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "Please Enter the Ship Address2";
//                       } else {
//                         return null;
//                       }
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'Ship Address2',
//                       filled: false,
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.red),
//                       ),
//                       focusedErrorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.red),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.grey),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.grey),
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                         vertical: 5,
//                         horizontal: 10,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: custHeight * 0.02,
//                 ),
//                 Container(
//                 
//                 
//                   decoration: BoxDecoration(
//                     border:
//                         Border.all(color: Color.fromARGB(255, 240, 235, 235)),
//                     borderRadius: BorderRadius.circular(3),
//                     color: Colors.grey.withOpacity(0.01),
//                   ),
//                   child: TextFormField(
//                     autofocus: true,
//                     controller: PayreceiptController.mycontroller[16],
//                     cursorColor: Colors.grey,
//                     style: theme.textTheme.bodyMedium
//                         ?.copyWith(color: Colors.black),
//                     onChanged: (v) {},
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "Please Enter the Ship Address3";
//                       } else {
//                         return null;
//                       }
//                     },
//                     decoration: InputDecoration(
//                       labelText: "Ship Address3",
//                       filled: false,
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.red),
//                       ),
//                       focusedErrorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.red),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.grey),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.grey),
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                         vertical: 5,
//                         horizontal: 10,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: custHeight * 0.02,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//               
//                 width: custWidth * 0.35,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(3),
//                   color: Colors.grey.withOpacity(0.01),
//                 ),
//                 child: TextFormField(
//                   controller: PayreceiptController.mycontroller[17],
//                   cursorColor: Colors.grey,
//                   style:
//                       theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
//                   onChanged: (v) {},
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Please Enter the City Name";
//                     } else {
//                       return null;
//                     }
//                   },
//                   decoration: InputDecoration(
//                     labelText: "City",
//                     filled: false,
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                       vertical: 5,
//                       horizontal: 10,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//               
//                 width: custWidth * 0.35,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(3),
//                   color: Colors.grey.withOpacity(0.01),
//                 ),
//                 child: TextFormField(
//                   controller: PayreceiptController.mycontroller[18],
//                   cursorColor: Colors.grey,
//                   style:
//                       theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
//                   onChanged: (v) {},
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Please Enter the Pincode";
//                     } else {
//                       return null;
//                     }
//                   },
//                   decoration: InputDecoration(
//                     labelText: "Pincode",
//                     filled: false,
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                       vertical: 5,
//                       horizontal: 10,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: custHeight * 0.02,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//               
//                 width: custWidth * 0.35,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(3),
//                   color: Colors.grey.withOpacity(0.01),
//                 ),
//                 child: TextFormField(
//                   controller: PayreceiptController.mycontroller[19],
//                   cursorColor: Colors.grey,
//                   style:
//                       theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
//                   onChanged: (v) {},
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Please Enter the State";
//                     } else {
//                       return null;
//                     }
//                   },
//                   decoration: InputDecoration(
//                     labelText: "State",
//                     filled: false,
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                       vertical: 5,
//                       horizontal: 10,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//               
//                 width: custWidth * 0.35,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(3),
//                   color: Colors.grey.withOpacity(0.01),
//                 ),
//                 child: TextFormField(
//                   readOnly: true,
//                   controller: PayreceiptController.mycontroller[20],
//                   cursorColor: Colors.grey,
//                   style:
//                       theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
//                   onChanged: (v) {},
//                 
//                 
//                 
//                 
//                 
//                 
//                 
//                   decoration: InputDecoration(
//                     hintText: "Ind",
//                     filled: false,
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                       vertical: 5,
//                       horizontal: 10,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       );
//     });
//   }
// }
// 


