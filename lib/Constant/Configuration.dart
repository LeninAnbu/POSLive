import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'Screen.dart';

class Configure {
  void showDialogBox(String title, String msg, BuildContext context) {
    showDialog<dynamic>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final theme = Theme.of(context);
            return AlertDialog(
              insetPadding: EdgeInsets.all(0),
              title: Container(
                height: Screens.padingHeight(context) * 0.05,
                alignment: Alignment.center,
                color: theme.primaryColor,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: Screens.width(context) * 0.45,
                        child: Text(
                          title,
                          style: theme.textTheme.titleMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.close_outlined, color: Colors.white))
                    ],
                  ),
                ),
              ),
              content: Container(
                width: Screens.width(context) * 0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      msg,
                      style: theme.textTheme.bodyLarge?.copyWith(),
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.02,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<bool> haveInterNet() async {
    final result = await Connectivity().checkConnectivity();
    print('resultresult::${result}');
    final hasInternet = result != ConnectivityResult.none;
    return hasInternet;
  }

  Future<bool?> haveNoInterNet() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    bool? hasnoInternet;

    if (connectivityResult.contains(ConnectivityResult.none) == true) {
      print(
          'VVVVVVVVVVVVVVVVV::::${connectivityResult.contains(ConnectivityResult.none)}');
      hasnoInternet = true;
    } else {
      hasnoInternet = false;
    }

    return hasnoInternet;
  }

  String alignDate(String date) {
    if (date == 'null' || date.isEmpty) {
      return '';
    }
    var dates = DateTime.parse(date);

    return "${dates.day.toString().padLeft(2, '0')}-${dates.month.toString().padLeft(2, '0')}-${dates.year}";
  }

  String aligntimeDate(String date) {
    var dates = DateTime.parse(date);

    String currentDateTime =
        "${dates.day.toString()}-${dates.month.toString().padLeft(2, '0')}-${dates.year.toString().padLeft(2, '0')} ${dates.hour.toString().padLeft(2, '0')}:${dates.minute.toString().padLeft(2, '0')}:${dates.second.toString().padLeft(2, '0')}";
    return currentDateTime;
  }

  String alignDate1(String date) {
    var inputFormat = DateFormat('dd-MM-yyyy');
    var date1 = inputFormat.parse(date);

    var dates = DateTime.parse(date1.toString());
    return "${dates.year}-${dates.month.toString().padLeft(2, '0')}-${dates.day.toString().padLeft(2, '0')}";
  }

  String alignDateT(String date) {
    // log('datedate::$date');
    var dates = DateTime.parse(date);
    return "${dates.day.toString().padLeft(2, '0')}-${dates.month.toString().padLeft(2, '0')}-${dates.year}";
  }

  String alignmeetingdate(String date1) {
    String dateT = date1.replaceAll("T", " ");
    log("DATATTA" + dateT.toString());
    final timestamp = DateTime.parse('$date1');

    final formattedDateTime = DateFormat('dd-MM-yyyy h:mma').format(timestamp);
    log("DATE::" + formattedDateTime);
    return formattedDateTime;
  }

  Future<String?> getdeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id;
    }
    return null;
  }

  String alignDate2(String date) {
    var inputFormat = DateFormat('dd-MM-yyyy');
    var date1 = inputFormat.parse(date);
    var dates = DateTime.parse(date1.toString());
    return "${dates.year}-${dates.month.toString().padLeft(2, '0')}-${dates.day.toString().padLeft(2, '0')}";
  }

  findFirstDateOfTheMonth2(DateTime dateTime) {
    Duration timeZoneOffset = Duration(hours: 5, minutes: 30);

    DateTime dateTimeWithOffset = dateTime.toUtc().add(timeZoneOffset);

    return DateTime(dateTimeWithOffset.year, dateTimeWithOffset.month, 1)
        .toIso8601String();
  }

  String currentDate() {
    DateTime now = DateTime.now();
    String currentDateTime =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
    return currentDateTime;
  }

  String currentDate2() {
    DateTime now = DateTime.now();
    String currentDateTime =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    return currentDateTime;
  }

  String slpitCurrency2(String value) {
    double values = double.parse(value);
    var format = NumberFormat.currency(
      name: "INR",
      locale: 'en_IN',
      decimalDigits: 2,
      symbol: '',
    );
    String formattedCurrency = format.format(values);

    return formattedCurrency;
  }

  String splitValues(String val) {
    var formatter = NumberFormat('###,000.00');
    double formatNO = double.parse(val);

    String retunVal = formatter.format(formatNO).toString();
    return retunVal;
  }

  void showDialogSucessB(String msg, String title) {
    Get.defaultDialog<void>(
        title: title,
        content: Column(
          children: [
            Text(msg),
          ],
        )).then((value) {
      Get.back<void>();
    });
  }

  Future<void> showDialogg(String msg, String title) async {
    Get.defaultDialog<void>(
        title: title,
        content: Column(
          children: [
            Text(msg),
          ],
        ));
  }
}
