import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Controller/CustomerController/CustomerController.dart';

class CustomerdetailPage extends StatelessWidget {
  CustomerdetailPage({
    super.key,
    required this.searchHeight,
    required this.searchWidth,
    // required this.custMaslist
  });

  double searchHeight;
  double searchWidth;
  // int index2;
  // CustomerMasterList? custMaslist;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      // height: searchHeight * 0.25,
      // width: searchWidth*0.95 ,
      padding: EdgeInsets.only(
          top: searchHeight * 0.01,
          left: searchHeight * 0.01,
          right: searchHeight * 0.01,
          bottom: searchHeight * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          // color: Colors.amber,
                          alignment: Alignment.center,
                          width: searchWidth * 0.2,
                          child: Text(
                            "Customer Name",
                            style: theme.textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: searchHeight * 0.007,
                        ),
                        Text(
                          "${context.read<CustomerController>().cusList1!.customername}",
                          style: theme.textTheme.bodyMedium!.copyWith(),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          // color: Colors.amber,
                          alignment: Alignment.center,
                          width: searchWidth * 0.2,
                          child: Text(
                            "Customer Code",
                            style: theme.textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: searchHeight * 0.007,
                        ),
                        Text(
                          "${context.read<CustomerController>().cusList1!.customerCode}",
                          style: theme.textTheme.bodyMedium!.copyWith(),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          // color: Colors.amber,
                          alignment: Alignment.center,
                          width: searchWidth * 0.2,
                          child: Text(
                            "Email Id",
                            style: theme.textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: searchHeight * 0.007,
                        ),
                        Text(
                          "${context.read<CustomerController>().cusList1!.emalid}",
                          style: theme.textTheme.bodyMedium!.copyWith(),
                        )
                      ],
                    ),
                    SizedBox(
                      height: searchWidth * 0.007,
                    ),
                    Column(
                      children: [
                        Container(
                          // color: Colors.amber,
                          alignment: Alignment.center,
                          width: searchWidth * 0.22,
                          child: Text(
                            "Phone No",
                            style: theme.textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: searchHeight * 0.007,
                        ),
                        Text(
                          "${context.read<CustomerController>().cusList1!.phoneno1}",
                          style: theme.textTheme.bodyMedium!.copyWith(),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          // color: Colors.amber,
                          alignment: Alignment.center,
                          width: searchWidth * 0.1,
                          child: Text(
                            "Tax No",
                            style: theme.textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: searchHeight * 0.007,
                        ),
                        Text(
                          "${context.read<CustomerController>().cusList1!.taxno}",
                          style: theme.textTheme.bodyMedium!.copyWith(),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: searchHeight * 0.08,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          // color: Colors.amber,
                          alignment: Alignment.center,
                          width: searchWidth * 0.2,
                          child: Text(
                            "Balance",
                            style: theme.textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: searchHeight * 0.007,
                        ),
                        Text(
                          "${context.read<CustomerController>().cusList1!.balance}",
                          style: theme.textTheme.bodyMedium!.copyWith(),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          // color: Colors.amber,
                          alignment: Alignment.center,
                          width: searchWidth * 0.2,
                          child: Text(
                            "Points",
                            style: theme.textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: searchHeight * 0.007,
                        ),
                        Text(
                          "${context.read<CustomerController>().cusList1!.points}",
                          style: theme.textTheme.bodyMedium!.copyWith(),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          // color: Colors.amber,
                          alignment: Alignment.center,
                          width: searchWidth * 0.2,
                          child: Text(
                            "Customer Type",
                            style: theme.textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: searchHeight * 0.007,
                        ),
                        Text(
                          "${context.read<CustomerController>().cusList1!.customertype}",
                          style: theme.textTheme.bodyMedium!.copyWith(),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: searchHeight * 0.02,
          ),
          Text(
            "  Addresses",
            style: theme.textTheme.bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: context.watch<CustomerController>().cutomerdetail.isEmpty
                ? const Center(child: Text("No Data"))
                : ListView.builder(
                    itemCount: context
                        .watch<CustomerController>()
                        .cutomerdetail
                        .length,
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
                              // borderRadius: BorderRadius.circular(2),
                            ),
                            child: Column(
                              children: [
                                Container(
                                    alignment: Alignment.centerLeft,
                                    // width: searchWidth*0.5,
                                    // color: Colors.amber,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${context.watch<CustomerController>().cutomerdetail[index].address1}",
                                          style: theme.textTheme.bodyLarge!
                                              .copyWith(),
                                        ),
                                        Text(
                                          "${context.watch<CustomerController>().cutomerdetail[index].address2}",
                                          style: theme.textTheme.bodyLarge!
                                              .copyWith(),
                                        ),
                                        Text(
                                          "${context.watch<CustomerController>().cutomerdetail[index].address3}",
                                          style: theme.textTheme.bodyLarge!
                                              .copyWith(),
                                        ),
                                        Text(
                                          "${context.watch<CustomerController>().cutomerdetail[index].city}",
                                          style: theme.textTheme.bodyLarge!
                                              .copyWith(),
                                        ),
                                        Text(
                                          "${context.watch<CustomerController>().cutomerdetail[index].pincode}",
                                          style: theme.textTheme.bodyLarge!
                                              .copyWith(),
                                        ),
                                        Text(
                                          context
                                              .watch<CustomerController>()
                                              .cutomerdetail[index]
                                              .statecode
                                              .toString(),
                                          style: theme.textTheme.bodyLarge!
                                              .copyWith(),
                                        ),
                                        Text(
                                          "${context.watch<CustomerController>().cutomerdetail[index].countrycode}",
                                          style: theme.textTheme.bodyLarge!
                                              .copyWith(),
                                        ),
                                        Text(
                                          "${context.watch<CustomerController>().cutomerdetail[index].geolocation1}",
                                          style: theme.textTheme.bodyLarge!
                                              .copyWith(),
                                        ),
                                        Text(
                                          "${context.watch<CustomerController>().cutomerdetail[index].geolocation2}",
                                          style: theme.textTheme.bodyLarge!
                                              .copyWith(),
                                        ),
                                      ],
                                    )),
                              ],
                            )),
                      );
                    }),
          )
        ],
      ),
    );
  }
}
