import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posproject/main.dart';
import 'package:provider/provider.dart';

import '../../../Constant/Screen.dart';
import '../../../Controller/CustomerController/CustomerController.dart';

class CustomerdetailPage extends StatefulWidget {
  CustomerdetailPage({
    super.key,
    required this.searchHeight,
    required this.searchWidth,
  });

  double searchHeight;
  double searchWidth;

  @override
  State<CustomerdetailPage> createState() => _CustomerdetailPageState();
}

class _CustomerdetailPageState extends State<CustomerdetailPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () => context.read<CustomerController>().onbackpress3(),
      child: Scaffold(
        appBar: AppBar(
            title: Text(
          'Customer Details',
        )),
        body: Container(
          padding: EdgeInsets.only(
              top: widget.searchHeight * 0.01,
              left: widget.searchHeight * 0.01,
              right: widget.searchHeight * 0.01,
              bottom: widget.searchHeight * 0.01),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: widget.searchHeight * 0.01,
                    left: widget.searchHeight * 0.01,
                    right: widget.searchHeight * 0.01,
                    bottom: widget.searchHeight * 0.01),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.2,
                              child: Text(
                                "Customer Name",
                                style: theme.textTheme.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: widget.searchHeight * 0.007,
                            ),
                            Container(
                              width: widget.searchWidth * 0.25,
                              child: Text(
                                "${context.read<CustomerController>().cusList1!.customername}",
                                style: theme.textTheme.bodyMedium!.copyWith(),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.2,
                              child: Text(
                                "Customer Code",
                                style: theme.textTheme.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: widget.searchHeight * 0.007,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.1,
                              child: Text(
                                "${context.read<CustomerController>().cusList1!.customerCode}",
                                style: theme.textTheme.bodyMedium!.copyWith(),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.15,
                              child: Text(
                                "Email Id",
                                style: theme.textTheme.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: widget.searchHeight * 0.007,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.18,
                              child: Text(
                                "${context.read<CustomerController>().cusList1!.emalid}",
                                style: theme.textTheme.bodyMedium!.copyWith(),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: widget.searchWidth * 0.007,
                        ),
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.22,
                              child: Text(
                                "Phone No",
                                style: theme.textTheme.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: widget.searchHeight * 0.007,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.1,
                              child: Text(
                                "${context.read<CustomerController>().cusList1!.phoneno1}",
                                style: theme.textTheme.bodyMedium!.copyWith(),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.1,
                              child: Text(
                                "Tax No",
                                style: theme.textTheme.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: widget.searchHeight * 0.007,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.1,
                              child: Text(
                                "${context.read<CustomerController>().cusList1!.taxno}",
                                style: theme.textTheme.bodyMedium!.copyWith(),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: widget.searchHeight * 0.05,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.2,
                              child: Text(
                                "Balance",
                                style: theme.textTheme.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: widget.searchHeight * 0.007,
                            ),
                            Text(
                              config.splitValues(
                                  "${context.read<CustomerController>().cusList1!.balance!.toStringAsFixed(2)}"),
                              style: theme.textTheme.bodyMedium!.copyWith(),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.2,
                              child: Text(
                                "Points",
                                style: theme.textTheme.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: widget.searchHeight * 0.007,
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
                              alignment: Alignment.center,
                              width: widget.searchWidth * 0.2,
                              child: Text(
                                "Customer Type",
                                style: theme.textTheme.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: widget.searchHeight * 0.007,
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
                height: widget.searchHeight * 0.02,
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
                                  top: widget.searchHeight * 0.01,
                                  left: widget.searchHeight * 0.01,
                                  right: widget.searchHeight * 0.01,
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
              ),
              SizedBox(
                height: Screens.padingHeight(context) * 0.02,
              ),
              Container(
                padding: EdgeInsets.only(
                    left: Screens.width(context) * 0.01,
                    bottom: Screens.padingHeight(context) * 0.005,
                    top: Screens.padingHeight(context) * 0.005),
                width: Screens.width(context) * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: theme.primaryColor,
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      context.read<CustomerController>().nowCurrentDate();
                      customerSaleslogbottomsheet('YTDGrowthSLP', context);
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sub-Group Wise Sales YTD Growth SLP',
                          style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      Icon(
                        Icons.navigate_next_outlined,
                        color: Colors.white,
                        size: Screens.padingHeight(context) * 0.05,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Screens.padingHeight(context) * 0.02,
              ),
              Container(
                padding: EdgeInsets.only(
                    left: Screens.width(context) * 0.01,
                    bottom: Screens.padingHeight(context) * 0.005,
                    top: Screens.padingHeight(context) * 0.005),
                width: Screens.width(context) * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: theme.primaryColor,
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      approvalReqBottomSheet(context);
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Approval Request Report',
                          style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      Icon(
                        Icons.navigate_next_outlined,
                        color: Colors.white,
                        size: Screens.padingHeight(context) * 0.05,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Screens.padingHeight(context) * 0.02,
              ),
              Container(
                padding: EdgeInsets.only(
                    left: Screens.width(context) * 0.01,
                    bottom: Screens.padingHeight(context) * 0.005,
                    top: Screens.padingHeight(context) * 0.005),
                width: Screens.width(context) * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: theme.primaryColor,
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      context
                          .read<CustomerController>()
                          .searchmycontroller[3]
                          .text = '';
                      context
                              .read<CustomerController>()
                              .searchmycontroller[4]
                              .text =
                          context
                              .read<CustomerController>()
                              .cusList1!
                              .customerCode!;
                      ageingBottomSheet(theme, context);
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Aging Report',
                          style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      Icon(
                        Icons.navigate_next_outlined,
                        color: Colors.white,
                        size: Screens.padingHeight(context) * 0.05,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Screens.padingHeight(context) * 0.02,
              ),
              Container(
                padding: EdgeInsets.only(
                    left: Screens.width(context) * 0.01,
                    bottom: Screens.padingHeight(context) * 0.005,
                    top: Screens.padingHeight(context) * 0.005),
                width: Screens.width(context) * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: theme.primaryColor,
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      context
                          .read<CustomerController>()
                          .searchmycontroller[1]
                          .text = '';
                      context
                          .read<CustomerController>()
                          .searchmycontroller[2]
                          .text = '';

                      bottomSheet(theme);
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('View Customer Details',
                          style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      Icon(
                        Icons.navigate_next_outlined,
                        color: Colors.white,
                        size: Screens.padingHeight(context) * 0.05,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Screens.padingHeight(context) * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void customerSaleslogbottomsheet(String methodName, BuildContext context) {
    showModalBottomSheet<dynamic>(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          height: 200,
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Do you want to open in? ',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.pop(context);

                        if (methodName == 'YTDGrowthSLP') {
                          context
                              .read<CustomerController>()
                              .callSubGroupSalesPdfApi(methodName, context);
                        } else {}
                      });
                    },
                    child: Text(
                      'PDF',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          Navigator.pop(context);
                          if (methodName == 'YTDGrowthSLP') {
                            context
                                .read<CustomerController>()
                                .callSubGroupSalesExcelApi(methodName, context);
                          } else {}
                        },
                      );
                    },
                    child: Text(
                      'Excel',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void approvalReqBottomSheet(BuildContext context) {
    showModalBottomSheet<dynamic>(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          height: 200,
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Do you want to open in? ',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.pop(context);

                        context
                            .read<CustomerController>()
                            .callApprovalReqPdfApi(context);
                      });
                    },
                    child: Text(
                      'PDF',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          Navigator.pop(context);

                          context
                              .read<CustomerController>()
                              .callApprovalReqExcelApi(context);
                        },
                      );
                    },
                    child: Text(
                      'Excel',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  DateTime findPreviousYear2(DateTime dateTime) {
    var dateTimeWithOffset = dateTime;

    log('dateTimeWithOffset Firstyear::$dateTimeWithOffset');
    return DateTime(dateTimeWithOffset.year - 1, 1);
  }

  void bottomSheet(ThemeData theme) {
    showDialog<dynamic>(
      barrierDismissible: false,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          content: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: Form(
              key: context.watch<CustomerController>().formkey[0],
              child: Container(
                child: Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.23,
                        child: TextFormField(
                          onTap: () {
                            showDate(context);
                          },
                          readOnly: true,
                          controller: context
                              .watch<CustomerController>()
                              .searchmycontroller[1],
                          onChanged: (val) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'ENTER FROM DATE';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.calendar_today_outlined,
                              color: theme.primaryColor,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            labelText: 'Choose from date',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.23,
                        child: TextFormField(
                          onTap: () {
                            showToDate(context);
                          },
                          readOnly: true,
                          controller: context
                              .watch<CustomerController>()
                              .searchmycontroller[2],
                          onChanged: (val) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'ENTER TO DATE';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.calendar_today_outlined,
                              color: theme.primaryColor,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            labelText: 'Choose to date',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                backgroundColor: theme.primaryColor,
                              ),
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                '  Cancel  ',
                              ),
                            ),
                          ),
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                backgroundColor: theme.primaryColor,
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    context
                                        .read<CustomerController>()
                                        .callApi(context);
                                  },
                                );
                              },
                              child: Text(
                                '  Search  ',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2050),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        context.read<CustomerController>().searchmycontroller[1].text =
            value.toString();
        final date = DateTime.parse(
            context.read<CustomerController>().searchmycontroller[1].text);
        context.read<CustomerController>().searchmycontroller[1].text = '';
        context.read<CustomerController>().searchmycontroller[1].text =
            "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString().padLeft(2, '0')}";
        context.read<CustomerController>().apiFromDate =
            "${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}";
      });
    });
  }

  void showToDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2050),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        context.read<CustomerController>().searchmycontroller[2].text =
            value.toString();
        final date = DateTime.parse(
            context.read<CustomerController>().searchmycontroller[2].text);
        context.read<CustomerController>().searchmycontroller[2].text = '';
        context.read<CustomerController>().searchmycontroller[2].text =
            "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString().padLeft(2, '0')}";
        context.read<CustomerController>().apiToDate =
            "${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}";
      });
    });
  }

  void ageingBottomSheet(ThemeData theme, BuildContext context) {
    showDialog<dynamic>(
        barrierDismissible: false,
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                content: Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: context.read<CustomerController>().formkeyaging[0],
                        child: Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: SizedBox(
                            width: Screens.width(context) * 0.23,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  onTap: () async {
                                    context
                                        .read<CustomerController>()
                                        .apiAgeingDate = '';
                                    context
                                        .read<CustomerController>()
                                        .showAgeingDate(context);
                                  },
                                  readOnly: true,
                                  controller: context
                                      .read<CustomerController>()
                                      .searchmycontroller[3],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Date';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(fontSize: 15),
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.calendar_today_outlined,
                                      color: theme.primaryColor,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 10,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    labelText: 'Choose Date',
                                  ),
                                ),
                                SizedBox(height: 10),
                                SizedBox(
                                  width: Screens.width(context) * 0.23,
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: context
                                        .read<CustomerController>()
                                        .searchmycontroller[4],
                                    style: TextStyle(fontSize: 15),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Customer Code';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Customer Code',
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 10,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                              child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              backgroundColor: theme.primaryColor,
                            ),
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              '  Cancel  ',
                            ),
                          )),
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                backgroundColor: theme.primaryColor,
                              ),
                              onPressed: () {
                                Get.back();
                                ageingBottomSheetViewer(context);
                              },
                              child: Text(
                                '  Search  ',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  void ageingBottomSheetViewer(BuildContext context) {
    showModalBottomSheet<dynamic>(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          height: 200,
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Do you want to open in? ',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (context
                              .read<CustomerController>()
                              .searchmycontroller[3]
                              .text
                              .isNotEmpty &&
                          context
                              .read<CustomerController>()
                              .searchmycontroller[4]
                              .text
                              .isNotEmpty) {
                        Get.back();

                        context
                            .read<CustomerController>()
                            .callAgeingApi(context);
                      }
                    },
                    child: Text(
                      'PDF',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (context
                              .read<CustomerController>()
                              .searchmycontroller[3]
                              .text
                              .isNotEmpty &&
                          context
                              .read<CustomerController>()
                              .searchmycontroller[4]
                              .text
                              .isNotEmpty) {
                        Get.back();

                        context
                            .read<CustomerController>()
                            .callAgeingExcelApi(context);
                      }
                    },
                    child: Text(
                      'Excel',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
