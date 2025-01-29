import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../Constant/Screen.dart';
import '../../../Controller/ExpenseController/ExpenseController.dart';
import '../../SalesQuotation/Widgets/ItemLists.dart';

class TabExpenseScreen extends StatefulWidget {
  const TabExpenseScreen({
    super.key,
  });

  @override
  State<TabExpenseScreen> createState() => _TabExpenseScreenState();
}

class _TabExpenseScreenState extends State<TabExpenseScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ///expenseModel
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: Screens.padingHeight(context) * 0.03,
                left: Screens.width(context) * 0.02,
                right: Screens.width(context) * 0.02,
                bottom: Screens.padingHeight(context) * 0.03),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: context.watch<ExpenseController>().expenseModel.isEmpty
                ? SizedBox(
                    width: Screens.width(context),
                    height: Screens.bodyheight(context),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ))
                : SingleChildScrollView(
                    child: Form(
                      key: context.read<ExpenseController>().formkey[0],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          context.read<ExpenseController>().expBool == true
                              ? Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                            width:
                                                Screens.width(context) * 0.30,
                                            child: Text(
                                              'Expense Code',
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            )),
                                        Container(
                                          width: Screens.width(context) * 0.50,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300]),
                                          child: TextFormField(
                                            controller: context
                                                .read<ExpenseController>()
                                                .mycontroller[9],
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey[300],
                                              labelText: '',
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                    color: theme.primaryColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                    color: theme.primaryColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                      height:
                                          Screens.padingHeight(context) * 0.03,
                                    ),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width:
                                                Screens.width(context) * 0.30,
                                            child: Text(
                                              'Reference',
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            )),
                                        Container(
                                          width: Screens.width(context) * 0.50,
                                          color: Colors.grey[300],
                                          //  height: Screens.padingHeight(context) * 0.06,
                                          child: TextFormField(
                                            controller: context
                                                .read<ExpenseController>()
                                                .mycontroller[10],
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey[300],
                                              labelText: '',
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                    color: theme.primaryColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                    color: theme.primaryColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          Screens.padingHeight(context) * 0.03,
                                    ),
                                    Row(
                                      // mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                                      children: [
                                        SizedBox(
                                            width:
                                                Screens.width(context) * 0.30,
                                            child: Text(
                                              'Expense Amount',
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            )),
                                        Container(
                                          color: Colors.grey[300],
                                          width: Screens.width(context) * 0.50,
                                          child: TextFormField(
                                            controller: context
                                                .read<ExpenseController>()
                                                .mycontroller[11],
                                            keyboardType: TextInputType.number,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey[300],
                                              labelText: '',
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                    color: theme.primaryColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                    color: theme.primaryColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          Screens.padingHeight(context) * 0.03,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                            width:
                                                Screens.width(context) * 0.30,
                                            //color: Colors.amber,
                                            child: Text(
                                              'Date',
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            )),
                                        Container(
                                          color: Colors.grey[300],

                                          width: Screens.width(context) * 0.50,
                                          // height: Screens.padingHeight(context) * 0.06,
                                          child: TextFormField(
                                            readOnly: true,
                                            controller: context
                                                .read<ExpenseController>()
                                                .mycontroller[18],
                                            validator: (data) {
                                              if (data!.isEmpty) {
                                                return "Required*";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              labelText: '',
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                    color: theme.primaryColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                    color: theme.primaryColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // SizedBox(
                                    //   height: Screens.padingHeight(context) * 0.03,
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     SizedBox(
                                    //         width: Screens.width(context) * 0.30,
                                    //         //color: Colors.amber,
                                    //         child: Text(
                                    //           'Paid To',
                                    //           style: theme.textTheme.bodyLarge
                                    //               ?.copyWith(
                                    //                   fontWeight: FontWeight.bold),
                                    //         )),
                                    //     Container(
                                    //       width: Screens.width(context) * 0.50,
                                    //       color: Colors.grey[300],
                                    //       // height: Screens.padingHeight(context) * 0.06,
                                    //       child: TextFormField(
                                    //         controller: context
                                    //             .read<ExpenseController>()
                                    //             .mycontroller[12],
                                    //         readOnly: true,
                                    //         decoration: InputDecoration(
                                    //           fillColor: Colors.grey[300],
                                    //           labelText: '',
                                    //           errorBorder: OutlineInputBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(5),
                                    //             borderSide: const BorderSide(
                                    //                 color: Colors.red),
                                    //           ),
                                    //           focusedErrorBorder: OutlineInputBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(5),
                                    //             borderSide: const BorderSide(
                                    //                 color: Colors.red),
                                    //           ),
                                    //           enabledBorder: OutlineInputBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(5),
                                    //             borderSide: BorderSide(
                                    //                 color: theme.primaryColor),
                                    //           ),
                                    //           focusedBorder: OutlineInputBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(5),
                                    //             borderSide: BorderSide(
                                    //                 color: theme.primaryColor),
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height: Screens.padingHeight(context) * 0.03,
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     SizedBox(

                                    //         //   color: Colors.amber,

                                    //         width: Screens.width(context) * 0.30,
                                    //         child: Text('Paid From',
                                    //             style: theme.textTheme.bodyLarge
                                    //                 ?.copyWith(
                                    //                     fontWeight:
                                    //                         FontWeight.bold))),
                                    //     Container(
                                    //       // height: Screens.padingHeight(context) * 0.07,

                                    //       width: Screens.width(context) * 0.50,

                                    //       //   padding: EdgeInsets.only(

                                    //       //     //top:Screens.padingHeight(context)*0.03,

                                    //       //  //   left:Screens.width(context)*0.03 ,

                                    //       //              //   right:Screens.width(context)*0.03

                                    //       //   ),

                                    //       decoration:
                                    //           BoxDecoration(color: Colors.grey[300]

                                    //               //color: Colors.amber,

                                    //               ),
                                    //       child: TextFormField(
                                    //         // style: theme.textTheme.bodyMedium!.copyWith(
                                    //         //   color: Colors.grey[300]
                                    //         // ),
                                    //         controller: context
                                    //             .read<ExpenseController>()
                                    //             .mycontroller[13],
                                    //         readOnly: true,
                                    //         decoration: InputDecoration(
                                    //           fillColor: Colors.grey[300],
                                    //           labelText: '',
                                    //           enabledBorder: OutlineInputBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(5),
                                    //             borderSide: BorderSide(
                                    //                 color: theme.primaryColor),
                                    //           ),
                                    //           focusedBorder: OutlineInputBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(5),
                                    //             borderSide: BorderSide(
                                    //                 color: theme.primaryColor),
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    SizedBox(
                                      height:
                                          Screens.padingHeight(context) * 0.03,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                            width:
                                                Screens.width(context) * 0.30,
                                            //color: Colors.amber,
                                            child: Text(
                                              'Remarks',
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            )),
                                        Container(
                                          width: Screens.width(context) * 0.50,
                                          color: Colors.grey[300],
                                          // height: Screens.padingHeight(context) * 0.06,
                                          child: TextFormField(
                                            controller: context
                                                .read<ExpenseController>()
                                                .mycontroller[14],
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey[300],
                                              labelText: '',
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                    color: theme.primaryColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                    color: theme.primaryColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        height: Screens.padingHeight(context) *
                                            0.03),
                                    Row(
                                      children: [
                                        SizedBox(
                                            width:
                                                Screens.width(context) * 0.30,
                                            //color: Colors.amber,
                                            child: Text(
                                              'Attachment',
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            )),
                                        Container(
                                          width: Screens.width(context) * 0.50,
                                          color: Colors.grey[300],
                                          // height: Screens.padingHeight(context) * 0.06,
                                          child: TextFormField(
                                            controller: context
                                                .read<ExpenseController>()
                                                .mycontroller[15],
                                            readOnly: true,
                                            onTap: () {
                                              // setState(() {
                                              // context
                                              //     .read<ExpenseController>()
                                              //     .selectattachment();
                                              // });
                                            },
                                            decoration: InputDecoration(
                                              suffixIcon: IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                      Icons.attach_file)),
                                              fillColor: Colors.grey[300],
                                              labelText: '',
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                    color: theme.primaryColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                    color: theme.primaryColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                            width:
                                                Screens.width(context) * 0.30,
                                            child: Text(
                                              'Expense Code',
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            )),
                                        Container(
                                          width: Screens.width(context) * 0.50,
                                          decoration: const BoxDecoration(),
                                          child: DropdownButtonFormField(
                                              validator: (value) =>
                                                  value == null
                                                      ? 'Required*'
                                                      : null,
                                              decoration: InputDecoration(
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  borderSide: const BorderSide(
                                                      color: Colors.red),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  borderSide: const BorderSide(
                                                      color: Colors.red),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  borderSide: BorderSide(
                                                      color:
                                                          theme.primaryColor),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  borderSide: BorderSide(
                                                      color:
                                                          theme.primaryColor),
                                                ),
                                              ),
                                              icon: const Icon(
                                                  Icons.arrow_drop_down),
                                              value: context
                                                  .watch<ExpenseController>()
                                                  .displayExpanseValue,
                                              items: context
                                                  .read<ExpenseController>()
                                                  .expenseModel
                                                  .map((e) {
                                                return DropdownMenuItem(
                                                    value: e.name,
                                                    child: Text(
                                                      e.name.toString(),
                                                    ));
                                              }).toList(),
                                              hint: const Text(
                                                "Choose Expense code",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  // context
                                                  //     .read<ExpenseController>()
                                                  //     .codeValue = value.toString();
                                                  context
                                                      .read<ExpenseController>()
                                                      .selectedCode(value!);
                                                });
                                              }),
                                        ),
                                      ],
                                    ),
                                    context
                                                .watch<ExpenseController>()
                                                .displayExpanseValue !=
                                            null
                                        ? Container(
                                            alignment: Alignment.centerRight,
                                            width:
                                                Screens.width(context) * 0.57,
                                            child: Text(
                                              'Available Amount :  ${context.read<ExpenseController>().availableAmt ?? 0}',
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(),
                                            ))
                                        : Container(),
                                    SizedBox(
                                      height:
                                          Screens.padingHeight(context) * 0.03,
                                    ),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width:
                                                Screens.width(context) * 0.30,
                                            child: Text(
                                              'Reference',
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            )),
                                        SizedBox(
                                          width: Screens.width(context) * 0.50,
                                          //  height: Screens.padingHeight(context) * 0.06,
                                          child: TextFormField(
                                            controller: context
                                                .read<ExpenseController>()
                                                .mycontroller[0],
                                            validator: (data) {
                                              if (data!.isEmpty) {
                                                return "Required*";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              labelText: '',
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                    color: theme.primaryColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                    color: theme.primaryColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          Screens.padingHeight(context) * 0.03,
                                    ),
                                    // Row(
                                    //   children: [
                                    //     SizedBox(

                                    //         //   color: Colors.amber,

                                    //         width: Screens.width(context) * 0.30,
                                    //         child: Text('Paid From',
                                    //             style: theme.textTheme.bodyLarge
                                    //                 ?.copyWith(
                                    //                     fontWeight:
                                    //                         FontWeight.bold))),
                                    //     Container(
                                    //       // height: Screens.padingHeight(context) * 0.07,

                                    //       width: Screens.width(context) * 0.50,

                                    //       decoration: const BoxDecoration(),
                                    //       child: DropdownButtonFormField<String>(

                                    //           //           hint: Text('Expense code'),
                                    //           validator: (value) => value == null
                                    //               ? 'field required'
                                    //               : null,
                                    //           decoration: InputDecoration(
                                    //             errorBorder: OutlineInputBorder(
                                    //               borderRadius:
                                    //                   BorderRadius.circular(5),
                                    //               borderSide: const BorderSide(
                                    //                   color: Colors.red),
                                    //             ),
                                    //             focusedErrorBorder:
                                    //                 OutlineInputBorder(
                                    //               borderRadius:
                                    //                   BorderRadius.circular(5),
                                    //               borderSide: const BorderSide(
                                    //                   color: Colors.red),
                                    //             ),
                                    //             enabledBorder: OutlineInputBorder(
                                    //               borderRadius:
                                    //                   BorderRadius.circular(5),
                                    //               borderSide: BorderSide(
                                    //                   color: theme.primaryColor),
                                    //             ),
                                    //             focusedBorder: OutlineInputBorder(
                                    //               borderRadius:
                                    //                   BorderRadius.circular(5),
                                    //               borderSide: BorderSide(
                                    //                   color: theme.primaryColor),
                                    //             ),
                                    //           ),
                                    //           icon: const Icon(Icons.arrow_drop_down),
                                    //           value: context
                                    //               .read<ExpenseController>()
                                    //               .chosenValue,
                                    //           items: context
                                    //               .read<ExpenseController>()
                                    //               .paidFromData
                                    //               .map<DropdownMenuItem<String>>(
                                    //                   (PaidFrom value) {
                                    //             return DropdownMenuItem<String>(
                                    //               value: value.accountname,
                                    //               child: Text(
                                    //                 value.accountname!,
                                    //                 style: const TextStyle(
                                    //                     color: Colors.black),
                                    //               ),
                                    //             );
                                    //           }).toList(),
                                    //           hint: const Text(
                                    //             "Choose Paid From",
                                    //             style: TextStyle(
                                    //                 color: Colors.black54,
                                    //                 fontSize: 14,
                                    //                 fontWeight: FontWeight.w500),
                                    //           ),
                                    //           onChanged: (String? value) {
                                    //             setState(() {
                                    //               context
                                    //                   .read<ExpenseController>()
                                    //                   .chosenValue = value!;
                                    //               context
                                    //                   .read<ExpenseController>()
                                    //                   .pettyCashValidation();
                                    //             });
                                    //           }),
                                    //     ),
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height: Screens.padingHeight(context) * 0.03,
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     SizedBox(
                                    //         width: Screens.width(context) * 0.30,
                                    //         //color: Colors.amber,
                                    //         child: Text(
                                    //           'Paid To',
                                    //           style: theme.textTheme.bodyLarge
                                    //               ?.copyWith(
                                    //                   fontWeight: FontWeight.bold),
                                    //         )),
                                    //     SizedBox(
                                    //       width: Screens.width(context) * 0.50,
                                    //       // height: Screens.padingHeight(context) * 0.06,
                                    //       child: TextFormField(
                                    //         controller: context
                                    //             .read<ExpenseController>()
                                    //             .mycontroller[2],
                                    //         validator: (data) {
                                    //           if (data!.isEmpty) {
                                    //             return "Required*";
                                    //           }
                                    //           return null;
                                    //         },
                                    //         decoration: InputDecoration(
                                    //           labelText: '',
                                    //           errorBorder: OutlineInputBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(5),
                                    //             borderSide: const BorderSide(
                                    //                 color: Colors.red),
                                    //           ),
                                    //           focusedErrorBorder: OutlineInputBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(5),
                                    //             borderSide: const BorderSide(
                                    //                 color: Colors.red),
                                    //           ),
                                    //           enabledBorder: OutlineInputBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(5),
                                    //             borderSide: BorderSide(
                                    //                 color: theme.primaryColor),
                                    //           ),
                                    //           focusedBorder: OutlineInputBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(5),
                                    //             borderSide: BorderSide(
                                    //                 color: theme.primaryColor),
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height: Screens.padingHeight(context) * 0.03,
                                    // ),
                                    Row(
                                      // mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                                      children: [
                                        SizedBox(
                                            // color: Colors.amber,
                                            width:
                                                Screens.width(context) * 0.30,
                                            child: Text(
                                              'Expense Amount',
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            )),
                                        SizedBox(
                                          //   color: Colors.amber,
                                          width: Screens.width(context) * 0.50,
                                          //height: Screens.padingHeight(context) * 0.06,
                                          child: TextFormField(
                                            controller: context
                                                .read<ExpenseController>()
                                                .mycontroller[1],
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              DecimalInputFormatter()
                                            ],
                                            onChanged: (valu) {
                                              context
                                                  .read<ExpenseController>()
                                                  .doubleDotMethod(1, valu);
                                            },
                                            validator: (data) {
                                              if (data!.isEmpty) {
                                                return "Required*";
                                              }
                                              return null;
                                            },
                                            onEditingComplete: () {
                                              // context
                                              //     .read<ExpenseController>()
                                              //     .pettyCashValidation();
                                              context
                                                  .read<ExpenseController>()
                                                  .disableKeyBoard(context);
                                            },
                                            decoration: InputDecoration(
                                              labelText: '',
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                    color: theme.primaryColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                    color: theme.primaryColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          Screens.padingHeight(context) * 0.03,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                            width:
                                                Screens.width(context) * 0.30,
                                            //color: Colors.amber,
                                            child: Text(
                                              'Date',
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            )),
                                        SizedBox(
                                          width: Screens.width(context) * 0.50,
                                          // height: Screens.padingHeight(context) * 0.06,
                                          child: TextFormField(
                                            readOnly: true,
                                            controller: context
                                                .read<ExpenseController>()
                                                .mycontroller[17],
                                            onTap: () {
                                              context
                                                  .read<ExpenseController>()
                                                  .getPostingDate(context);
                                            },
                                            validator: (data) {
                                              if (data!.isEmpty) {
                                                return "Required*";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              suffixIcon:
                                                  Icon(Icons.calendar_month),
                                              labelText: '',
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                    color: theme.primaryColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                    color: theme.primaryColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          Screens.padingHeight(context) * 0.03,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                            width:
                                                Screens.width(context) * 0.30,
                                            //color: Colors.amber,
                                            child: Text(
                                              'Remarks',
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            )),
                                        SizedBox(
                                          width: Screens.width(context) * 0.50,
                                          // height: Screens.padingHeight(context) * 0.06,
                                          child: TextFormField(
                                            // inputFormatters: [
                                            //   DecimalInputFormatter()
                                            // ],
                                            // onChanged: (valu) {
                                            //   context
                                            //       .read<ExpenseController>()
                                            //       .doubleDotMethod(3, valu);
                                            // },

                                            controller: context
                                                .read<ExpenseController>()
                                                .mycontroller[3],
                                            // validator: (data) {
                                            //   if (data!.isEmpty) {
                                            //     return "Required*";
                                            //   }
                                            //   return null;
                                            // },
                                            decoration: InputDecoration(
                                              labelText: '',
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                    color: theme.primaryColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                    color: theme.primaryColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          Screens.padingHeight(context) * 0.03,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                            width:
                                                Screens.width(context) * 0.30,
                                            //color: Colors.amber,
                                            child: Text(
                                              'Attachment',
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            )),
                                        SizedBox(
                                          width: Screens.width(context) * 0.50,
                                          // height: Screens.padingHeight(context) * 0.06,
                                          child: TextFormField(
                                            controller: context
                                                .read<ExpenseController>()
                                                .mycontroller[16],
                                            readOnly: true,
                                            onTap: () {
                                              setState(() {
                                                context
                                                    .read<ExpenseController>()
                                                    .selectattachment();
                                              });
                                            },
                                            decoration: InputDecoration(
                                              suffixIcon: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              ExpenseController>()
                                                          .selectattachment();
                                                    });
                                                  },
                                                  icon: const Icon(
                                                      Icons.attach_file)),
                                              fillColor: Colors.grey[300],
                                              labelText: '',
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                    color: theme.primaryColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                    color: theme.primaryColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: Screens.padingHeight(context) * 0.03,
                          ),
                          // SizedBox(
                          //   height: Screens.padingHeight(context) * 0.05,
                          // ),
                          context.read<ExpenseController>().expBool == true
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    // ElevatedButton(
                                    //   onPressed: () {
                                    //     setState(() {
                                    //       context
                                    //           .read<ExpenseController>()
                                    //           .cancelbtn = true;

                                    //       context
                                    //           .read<ExpenseController>()
                                    //           .clickcancelbtn(context, theme);
                                    //     });
                                    //   },
                                    //   style: ElevatedButton.styleFrom(
                                    //       fixedSize: const Size(150, 50),
                                    //       foregroundColor: Colors.white,
                                    //       // backgroundColor: Colors.grey[300],
                                    //       shape: RoundedRectangleBorder(
                                    //         borderRadius:
                                    //             BorderRadius.circular(6),
                                    //       )),
                                    //   child: context
                                    //               .watch<ExpenseController>()
                                    //               .cancelbtn ==
                                    //           false
                                    //       ? Text("Cancel",
                                    //           textAlign: TextAlign.center,
                                    //           style: theme.textTheme.bodySmall
                                    //               ?.copyWith(
                                    //             color: Colors.white,
                                    //           ))
                                    //       : CircularProgressIndicator(
                                    //           color: theme.primaryColor),
                                    // ),
                                    context
                                                .read<ExpenseController>()
                                                .isApprove ==
                                            true
                                        ? ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                context
                                                    .read<ExpenseController>()
                                                    .onDisablebutton = true;

                                                context
                                                    .read<ExpenseController>()
                                                    .callApprovaltoDocApi(
                                                        context, theme);
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: const Size(150, 50),
                                                foregroundColor: Colors.white,

                                                // backgroundColor: Colors.grey[300],
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                )),
                                            child: Text("Save",
                                                textAlign: TextAlign.center,
                                                style: theme.textTheme.bodySmall
                                                    ?.copyWith(
                                                  color: Colors.white,
                                                )))
                                        : Container(),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          context
                                              .read<ExpenseController>()
                                              .clearData();
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: const Size(150, 50),
                                          // backgroundColor: Colors.grey[300],
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          )),
                                      child: Text(
                                        'Clear',
                                        style: theme.textTheme.bodyLarge!
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ElevatedButton(
                                      onPressed: context
                                                  .watch<ExpenseController>()
                                                  .onDisablebutton ==
                                              true
                                          ? null
                                          : () {
                                              context
                                                  .read<ExpenseController>()
                                                  .onDisablebutton = true;
                                              context
                                                  .read<ExpenseController>()
                                                  .clearSuspendedData(
                                                      context, theme);
                                              //  context.read<ExpenseController>().insertExpense(
                                              //       "suspend", context, theme);
                                            },
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: const Size(150, 50),
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          )),
                                      child: const Text('Clear All'),
                                    ),
                                    ElevatedButton(
                                      onPressed: context
                                                  .read<ExpenseController>()
                                                  .onDisablebutton ==
                                              true
                                          ? null
                                          : () {
                                              setState(() {
                                                context
                                                    .read<ExpenseController>()
                                                    .onDisablebutton = true;
                                                context
                                                    .read<ExpenseController>()
                                                    .saveValuesTODB(
                                                        "hold", context, theme);
                                              });

                                              // context.read<ExpenseController>().insertExpenseTable("hold", context, theme);
                                            },
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: const Size(150, 50),
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          )),
                                      child: const Text('Hold'),
                                    ),
                                    ElevatedButton(
                                      onPressed: context
                                                  .read<ExpenseController>()
                                                  .onDisablebutton ==
                                              true
                                          ? null
                                          : () {
                                              if (context
                                                  .read<ExpenseController>()
                                                  .formkey[0]
                                                  .currentState!
                                                  .validate()) {
                                                context
                                                    .read<ExpenseController>()
                                                    .onDisablebutton = true;
                                                context
                                                    .read<ExpenseController>()
                                                    .pettyCashValidation(
                                                        context, theme);
                                                // context
                                                //     .read<ExpenseController>()
                                                //     .insertExpenseTable(
                                                //         "submit", context, theme);
                                              }
                                            },
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: const Size(150, 50),
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          )),
                                      child: const Text('Save'),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
          ),
          Visibility(
            visible: context.watch<ExpenseController>().onDisablebutton,
            child: Container(
              width: Screens.width(context),
              height: Screens.bodyheight(context) * 0.95,
              color: Colors.white60,
              child: Center(
                child: SpinKitFadingCircle(
                  size: Screens.bodyheight(context) * 0.08,
                  color: theme.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
