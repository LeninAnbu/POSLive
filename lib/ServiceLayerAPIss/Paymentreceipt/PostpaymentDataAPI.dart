import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';

import '../../Constant/UserValues.dart';
import '../../Models/ServiceLayerModel/ReceiptModel/PostReceiptLineMode.dart';
import '../../Models/ServiceLayerModel/ReceiptModel/ReceiptDataModel.dart';

import '../../url/url.dart';

class ReceiptPostAPi {
  static String? docType;
  static String? cardCodePost;
  static String? cashAccount;
  static double? cashSum;
  static String? seriesType;
  static String? counterRef;
  static List<PostPaymentCheck>? docPaymentChecks;
  static List<PostPaymentInvoice>? docPaymentInvoices;
  static List<PostPaymentCard>? docPaymentCards;
  // static String? journalRemarks;
  static String? transferReference;
  static String? checkAccount;
  static String? transferAccount;
  static double? transferSum;
  static String? transferDate;
  static String? docDate;
  static String? dueDate;
  static String? remarks;
  static void method() {
    final datax = json.encode({
      "CardCode": "$cardCodePost",
      "DocDate": "$docDate",
      "Remarks": remarks,
      "JournalRemarks": remarks,
      "CashAccount": cashAccount,
      "CashSum": cashSum,
      "DocType": docType,
      "CounterReference": counterRef,
      // 'Series': '$seriesType',
      "CheckAccount": checkAccount,
      "TransferAccount": transferAccount,
      "TransferSum": transferSum,
      "TransferReference": transferReference,
      "U_PosUserCode": UserValues.userCode,
      "U_PosTerminal": AppConstant.terminal,
      "PaymentChecks": docPaymentChecks!.map((e) => e.toJson2()).toList(),
      "PaymentCreditCards": docPaymentCards!.map((e) => e.toJson3()).toList(),
      "PaymentInvoices": docPaymentInvoices!.map((e) => e.toJson3()).toList(),
    });
    log('Payment Receipt data::$datax');
  }

  static Future<SapReceiptModel> getGlobalData() async {
    try {
      final data = json.encode({
        "CardCode": "$cardCodePost",
        "DocDate": "$docDate",
        "Remarks": "$remarks",
        "CashAccount": cashAccount,
        "CashSum": cashSum,
        "DocType": docType,
        "JournalRemarks": remarks,
        // 'Series': '$seriesType',
        "CheckAccount": checkAccount,
        "TransferAccount": transferAccount,
        "TransferSum": transferSum,
        "TransferReference": transferReference,
        "U_PosUserCode": UserValues.userCode,
        "U_PosTerminal": AppConstant.terminal,
        "PaymentChecks": docPaymentChecks!.map((e) => e.toJson2()).toList(),
        "PaymentCreditCards": docPaymentCards!.map((e) => e.toJson3()).toList(),
        "PaymentInvoices": docPaymentInvoices!.map((e) => e.toJson3()).toList(),
      });
      log("${URL.sapUrl}/IncomingPayments");
      final response = await http.post(
        Uri.parse(
          "${URL.sapUrl}/IncomingPayments",
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
          // "Prefer":"return-no-content"
        },
        body: json.encode({
          "CardCode": "$cardCodePost",
          "DocDate": "$docDate",
          "Remarks": "$remarks",
          "CashAccount": cashAccount,
          "CashSum": cashSum,
          "DocType": docType,
          "JournalRemarks": remarks,
          "CounterReference": counterRef,
          // 'Series': '$seriesType',
          "CheckAccount": checkAccount,
          "TransferAccount": transferAccount,
          "TransferSum": transferSum,
          "TransferReference": transferReference,
          "U_PosUserCode": UserValues.userCode,
          "U_PosTerminal": AppConstant.terminal,
          "PaymentChecks": docPaymentChecks!.map((e) => e.toJson2()).toList(),
          "PaymentCreditCards":
              docPaymentCards!.map((e) => e.toJson3()).toList(),
          "PaymentInvoices":
              docPaymentInvoices!.map((e) => e.toJson3()).toList(),
          "U_Request": data,
        }),
      );

      log(
        "Payment Receipt: ${json.encode({
              "CardCode": "$cardCodePost",
              "DocDate": "$docDate",
              "Remarks": "$remarks",
              "CashAccount": cashAccount,
              "CashSum": cashSum,
              "DocType": docType,
              "CounterReference": counterRef,
              // 'Series': '$seriesType',
              "CheckAccount": checkAccount,
              "TransferAccount": transferAccount,
              "TransferSum": transferSum,
              "TransferReference": transferReference,
              "U_PosUserCode": UserValues.userCode,
              "U_PosTerminal": AppConstant.terminal,
              "PaymentChecks":
                  docPaymentChecks!.map((e) => e.toJson2()).toList(),
              "PaymentCreditCards":
                  docPaymentCards!.map((e) => e.toJson3()).toList(),
              "PaymentInvoices":
                  docPaymentInvoices!.map((e) => e.toJson3()).toList(),
              "U_Request": data,
            })}",
      );
      log("ReceiptPost statucCode: ${response.statusCode}");
      // log("SapReceiptModel res: " + response.body.toString());

      if (response.statusCode >= 200 && response.statusCode <= 204) {
        // final dynamic data = json.decode(response.body.toString());
        return SapReceiptModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        log("SapReceiptModel res: " + response.body.toString());

        // throw Exception('Restart the app or contact the admin!!..');
        return SapReceiptModel.issue(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log(e.toString());
      // throw Exception(e);'Restart the app or contact the admin!!..\n'
      return SapReceiptModel.exception(e.toString(), 500);
    }
  }
}
