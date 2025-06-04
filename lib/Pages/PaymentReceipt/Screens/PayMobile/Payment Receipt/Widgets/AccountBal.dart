import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';

import '../../../../../../Controller/PaymentReceiptController/PayReceiptController.dart';

StatefulBuilder forAccBal(
  BuildContext context,
  PayreceiptController posC,
) {
  final theme = Theme.of(context);
  return StatefulBuilder(builder: (context, st) {
    return Container(
      padding: EdgeInsets.only(
          top: Screens.bodyheight(context) * 0.01,
          left: Screens.bodyheight(context) * 0.01,
          right: Screens.bodyheight(context) * 0.01,
          bottom: Screens.bodyheight(context) * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            posC.getmsgforAmount == null ? '' : "${posC.getmsgforAmount}",
            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
          ),
          Form(
            key: posC.formkey[9],
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: Screens.width(context) * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.grey.withOpacity(0.01),
                    ),
                    child: TextFormField(
                      readOnly: true,
                      controller: posC.mycontroller[55],
                      cursorColor: Colors.grey,
                      style: theme.textTheme.bodyMedium?.copyWith(),
                      onChanged: (v) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ' Please Enter the Account Balance';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Available Balance",
                        filled: false,
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        errorBorder: OutlineInputBorder(
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
                  SizedBox(height: Screens.bodyheight(context) * 0.02),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: Screens.width(context) * 0.7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        controller: posC.mycontroller[42],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyMedium?.copyWith(),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ' Please Enter the Adjust Amount';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Amount to Adjust",
                          filled: false,
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          errorBorder: OutlineInputBorder(
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
                  ),
                ]),
          ),
        ],
      ),
    );
  });
}
