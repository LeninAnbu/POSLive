import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class Utils {
  static String versionNumber = "1.0.9"; //  "1.1.5" 1.0.9
  static String? slpName;
  static String? slpCode;

  static void showTopSnackBar(
          BuildContext context, String message, Color color) =>
      showSimpleNotification(const Text("Check Internet Connectivity"),
          subtitle: Text(message), background: color);

  static void showTopSnackBarValidation(
          BuildContext context, String message, Color color) =>
      showSimpleNotification(const Text("Check Your Credential !!.."),
          subtitle: Text(message), background: color);

  static void showTopSnackBarEmptyField(
          BuildContext context, String message, Color color) =>
      showSimpleNotification(const Text("Field Is Empty !!.."),
          subtitle: Text(message), background: color);

  static void showTopSnackBarFailure(
          BuildContext context, String message, Color color) =>
      showSimpleNotification(const Text("Error!!.."),
          subtitle: Text(message), background: color);

  static void showTopSnackBarNoData(
          BuildContext context, String message, Color color) =>
      showSimpleNotification(const Text("No Data!!.."),
          subtitle: Text(message), background: color);

  static void showTopSnackBarSuccess(
          BuildContext context, String message, Color color) =>
      showSimpleNotification(const Text("Success!!.."),
          subtitle: Text(message), background: color);

  static void showTopSnackBarfullamount(
          BuildContext context, String message, Color color) =>
      showSimpleNotification(const Text("Warning!!.."),
          subtitle: Text(message), background: color);

  static void showTopSnackBarWarning(
          BuildContext context, String message, Color color) =>
      showSimpleNotification(const Text("Warning!!.."),
          subtitle: Text(message), background: color);

  static TextStyle txtHeading = const TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);

  static TextStyle txtContent =
      const TextStyle(fontSize: 15.0, color: Colors.black);

  static TextStyle txtCard = const TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black);

  static TextStyle txtCardHead = const TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black);

  static TextStyle txtCardCtnt = const TextStyle(
    fontSize: 15.0,
  );

  static TextStyle dashBoardtxtContent = const TextStyle(
      fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500);

  static Color leadbookTxtFld = Colors.green;
  static Color leadbookChkBox = Colors.green;
  static Color leadbookChkBoxAct = Colors.green;
  static Color leadbookRdioBtn = Colors.green;
  static Color greenAccent = Colors.greenAccent;
  static Color pink = Colors.pink;
  static Color blue = Colors.blue;
  static Color grey = Colors.grey;
  static Color? drawerHeadercolor = Colors.greenAccent[400];
  static Color? drawerSelectedColor = Colors.greenAccent[100];
  static Color btnColor = Colors.green;
}
