import 'package:flutter/material.dart';
import 'package:posproject/Pages/Expenses/widgets/BillingOptions.dart';

import '../../../Constant/Screen.dart';
import '../../../Controller/ExpenseController/ExpenseController.dart';
import '../../Sales Screen/Widgets/QuickOptions.dart';

class PosExpenseScreen extends StatefulWidget {
  PosExpenseScreen({super.key, required this.ExpenseCon});

  ExpenseController ExpenseCon;
  @override
  State<PosExpenseScreen> createState() => _PosExpenseScreenState();
}

class _PosExpenseScreenState extends State<PosExpenseScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        SizedBox(
          width: Screens.width(context) * 0.90,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: Screens.padingHeight(context) * 0.05,
                    left: Screens.width(context) * 0.04,
                    right: Screens.width(context) * 0.04,
                    bottom: Screens.padingHeight(context) * 0.05),
                child: Container(
                  color: Colors.white,
                  height: Screens.padingHeight(context) * 0.90,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: Screens.padingHeight(context) * 0.05,
                        left: Screens.width(context) * 0.04,
                        right: Screens.width(context) * 0.04,
                        bottom: Screens.padingHeight(context) * 0.03),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Expense Code:',
                                  style: theme.textTheme.bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  width: Screens.width(context) * 0.50,
                                  decoration: const BoxDecoration(),
                                  child: DropdownButtonFormField<String>(
                                      validator: (value) => value == null
                                          ? 'field required'
                                          : null,
                                      decoration: InputDecoration(
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                              color: Colors.red),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
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
                                      icon: const Icon(Icons.arrow_drop_down),
                                      value: widget.ExpenseCon.codeValue,
                                      items: <String>[
                                        'item1',
                                        'item2',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        );
                                      }).toList(),
                                      hint: const Text(
                                        "",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      onChanged: (String? value) {
                                        setState(() {
                                          widget.ExpenseCon.codeValue = value!;
                                        });
                                      }),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Screens.padingHeight(context) * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Reference:',
                                  style: theme.textTheme.bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: Screens.width(context) * 0.50,
                                  child: TextFormField(
                                    controller:
                                        widget.ExpenseCon.mycontroller[0],
                                    validator: (data) {
                                      if (data!.isEmpty) {
                                        return "Required*";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: '',
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide:
                                            const BorderSide(color: Colors.red),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide:
                                            const BorderSide(color: Colors.red),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            color: theme.primaryColor),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            color: theme.primaryColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Screens.padingHeight(context) * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Expense Amount:',
                                  style: theme.textTheme.bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: Screens.width(context) * 0.50,
                                  child: TextFormField(
                                    controller:
                                        widget.ExpenseCon.mycontroller[1],
                                    validator: (data) {
                                      if (data!.isEmpty) {
                                        return "Required*";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: '',
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide:
                                            const BorderSide(color: Colors.red),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide:
                                            const BorderSide(color: Colors.red),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            color: theme.primaryColor),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            color: theme.primaryColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Screens.padingHeight(context) * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Paid To:',
                                  style: theme.textTheme.bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: Screens.width(context) * 0.50,
                                  child: TextFormField(
                                    controller:
                                        widget.ExpenseCon.mycontroller[2],
                                    validator: (data) {
                                      if (data!.isEmpty) {
                                        return "Required*";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: '',
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide:
                                            const BorderSide(color: Colors.red),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide:
                                            const BorderSide(color: Colors.red),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            color: theme.primaryColor),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            color: theme.primaryColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Screens.padingHeight(context) * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Paid From:',
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold)),
                                Container(
                                  width: Screens.width(context) * 0.50,
                                  decoration: const BoxDecoration(),
                                  child: DropdownButtonFormField<String>(
                                      validator: (value) => value == null
                                          ? 'field required'
                                          : null,
                                      decoration: InputDecoration(
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                              color: Colors.red),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
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
                                      icon: const Icon(Icons.arrow_drop_down),
                                      value: widget.ExpenseCon.chosenValue,
                                      items: <String>[
                                        'item1',
                                        'item2',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        );
                                      }).toList(),
                                      hint: const Text(
                                        "",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      onChanged: (String? value) {
                                        setState(() {
                                          widget.ExpenseCon.chosenValue =
                                              value!;
                                        });
                                      }),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(150, 50),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  )),
                              child: const Text('Suspend'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                widget.ExpenseCon.insertExpenseTable(
                                    "hold", context, theme);
                              },
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(150, 50),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  )),
                              child: const Text('Hold'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                widget.ExpenseCon.insertExpenseTable(
                                    "submit", context, theme);
                              },
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(150, 50),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  )),
                              child: const Text('Submit'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
            child: Column(
          children: [
            BillingOptions(
              theme: theme,
            ),
            const QuickOptions(),
          ],
        ))
      ],
    );
  }
}
