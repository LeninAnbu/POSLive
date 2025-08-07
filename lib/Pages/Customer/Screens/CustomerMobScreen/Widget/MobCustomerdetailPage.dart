import 'package:flutter/material.dart';

import '../../../../../Controller/CustomerController/CustomerController.dart';

class MobCustomerdetailPage extends StatelessWidget {
  MobCustomerdetailPage(
      {super.key,
      required this.stChCon,
      required this.searchHeight,
      required this.searchWidth,
      required this.cusList});
  CustomerController stChCon;
  double searchHeight;
  double searchWidth;
  CustomerMasterList? cusList;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(
          top: searchHeight * 0.01,
          left: searchHeight * 0.01,
          right: searchHeight * 0.01,
          bottom: searchHeight * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: EdgeInsets.only(
              top: searchHeight * 0.01,
              left: searchHeight * 0.01,
              right: searchHeight * 0.01,
              bottom: searchHeight * 0.01),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Column(
            children: [
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                            alignment: Alignment.topLeft,
                            width: searchWidth * 0.5,
                            child: Text(
                              "Customer Code",
                              style: theme.textTheme.bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          height: searchHeight * 0.005,
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            width: searchWidth * 0.5,
                            child: Text(
                              "${cusList!.customerCode}",
                              style: theme.textTheme.bodyLarge!.copyWith(),
                            )),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Customer Name",
                              style: theme.textTheme.bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          height: searchHeight * 0.005,
                        ),
                        Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "${cusList!.customername}",
                              style: theme.textTheme.bodyLarge!.copyWith(),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: searchHeight * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          width: searchWidth * 0.5,
                          child: Text(
                            "Balance",
                            style: theme.textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: searchHeight * 0.005,
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          width: searchWidth * 0.5,
                          child: Text(
                            "${cusList!.balance}",
                            style: theme.textTheme.bodyLarge!.copyWith(),
                          )),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Points",
                            style: theme.textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: searchHeight * 0.005,
                      ),
                      Container(
                          alignment: Alignment.centerRight,
                          width: searchWidth * 0.3,
                          child: Text(
                            "${cusList!.points}",
                            style: theme.textTheme.bodyLarge!.copyWith(),
                          )),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: searchHeight * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          width: searchWidth * 0.5,
                          child: Text(
                            "Email ID",
                            style: theme.textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: searchHeight * 0.005,
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          width: searchWidth * 0.5,
                          child: Text(
                            "${cusList!.emalid}",
                            style: theme.textTheme.bodyLarge!.copyWith(),
                          )),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                          alignment: Alignment.center,
                          width: searchWidth * 0.3,
                          child: Text(
                            "Tax No",
                            style: theme.textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: searchHeight * 0.005,
                      ),
                      Container(
                          alignment: Alignment.center,
                          width: searchWidth * 0.3,
                          child: Text(
                            "${cusList!.taxno}",
                            style: theme.textTheme.bodyLarge!.copyWith(),
                          )),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: searchHeight * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          width: searchWidth * 0.5,
                          child: Text(
                            "Phone No",
                            style: theme.textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: searchHeight * 0.005,
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          width: searchWidth * 0.5,
                          child: Text(
                            "${cusList!.phoneno1}",
                            style: theme.textTheme.bodyLarge!.copyWith(),
                          )),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Customer Type",
                            style: theme.textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: searchHeight * 0.005,
                      ),
                      Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "${cusList!.customertype}",
                            style: theme.textTheme.bodyLarge!.copyWith(),
                          )),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: searchHeight * 0.01,
        ),
        Text(
          "  Addresses",
          style:
              theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: stChCon.cutomerdetail.isEmpty
              ? const Center(child: Text("No Data"))
              : ListView.builder(
                  itemCount: stChCon.cutomerdetail.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                          padding: EdgeInsets.only(
                            top: searchHeight * 0.01,
                            left: searchHeight * 0.01,
                            right: searchHeight * 0.01,
                            bottom: searchHeight * 0.02,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child: Column(
                            children: [
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${stChCon.cutomerdetail[index].address1}",
                                        style: theme.textTheme.bodyLarge!
                                            .copyWith(),
                                      ),
                                      Text(
                                        "${stChCon.cutomerdetail[index].address2}",
                                        style: theme.textTheme.bodyLarge!
                                            .copyWith(),
                                      ),
                                      Text(
                                        "${stChCon.cutomerdetail[index].address3}",
                                        style: theme.textTheme.bodyLarge!
                                            .copyWith(),
                                      ),
                                      Text(
                                        "${stChCon.cutomerdetail[index].city}",
                                        style: theme.textTheme.bodyLarge!
                                            .copyWith(),
                                      ),
                                      Text(
                                        "${stChCon.cutomerdetail[index].pincode}",
                                        style: theme.textTheme.bodyLarge!
                                            .copyWith(),
                                      ),
                                      Text(
                                        stChCon.cutomerdetail[index].statecode
                                            .toString(),
                                        style: theme.textTheme.bodyLarge!
                                            .copyWith(),
                                      ),
                                      Text(
                                        "${stChCon.cutomerdetail[index].countrycode}",
                                        style: theme.textTheme.bodyLarge!
                                            .copyWith(),
                                      ),
                                      Text(
                                        "${stChCon.cutomerdetail[index].geolocation1}",
                                        style: theme.textTheme.bodyLarge!
                                            .copyWith(),
                                      ),
                                      Text(
                                        "${stChCon.cutomerdetail[index].geolocation2}",
                                        style: theme.textTheme.bodyLarge!
                                            .copyWith(),
                                      ),
                                    ],
                                  )),
                            ],
                          )),
                    );
                  }),
        ),
      ]),
    );
  }
}
