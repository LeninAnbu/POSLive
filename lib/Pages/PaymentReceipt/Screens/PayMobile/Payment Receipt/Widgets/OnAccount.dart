import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';

import '../../../../../../Controller/PaymentReceiptController/PayReceiptController.dart';

forOnAcc(BuildContext context, ThemeData theme, PayreceiptController prdCD) {
  return Container(
    padding: EdgeInsets.only(
        top: Screens.bodyheight(context) * 0.02,
        left: Screens.bodyheight(context) * 0.01,
        right: Screens.bodyheight(context) * 0.01,
        bottom: Screens.bodyheight(context) * 0.02),
    child: Form(
      key: prdCD.formkey[10],
      child: Container(
        width: Screens.width(context) * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Colors.grey.withOpacity(0.01),
        ),
        child: TextFormField(
          autofocus: true,
          controller: prdCD.mycontroller[45],
          cursorColor: Colors.grey,
          style: theme.textTheme.bodyMedium?.copyWith(),
          onChanged: (v) {},
          validator: (value) {
            if (value!.isEmpty) {
              return ' Please Enter the Amount';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            hintText: "Amount",
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
  );
}
