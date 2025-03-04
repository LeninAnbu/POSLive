import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../../Constant/AppConstant.dart';
import '../../../Models/QueryUrlModel/DepositsQueryModel/ChequeDepositModel.dart';

class ChequeDepositsQueryAPi {
  static Future<ChequeDepositQueryModel> getGlobalData(
    String chequeBank,
  ) async {
    log("Select Convert(Varchar(30),T0.CheckNum) As 'Cheque',T0.CheckAbs As 'ChequeKey',T0.DueDate As 'ChequeDate',	T0.BankCode As 'Bank',T0.Branch,T0.AcctNum As 'AccNo',T0.CheckSum As 'ChequeAmt','Deposit' As 'Action' From  RCT1 T0 JOIN ORCT T1 On T0.DocNum = T1.DocNum And T1.DocType = 'C' JOIN OCHH T2 ON T0.CheckAbs = T2.CheckKey And T2.Deposited = 'N' And T1.Canceled = 'N' And T2.Trnsfrable = 'N' Where T0.BankCode = '$chequeBank'");

    try {
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              //DISTINCT
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query":
                "EXEC BZ_POS_ChequeDepositsQueryAPi '$chequeBank'"
                    // "Select Convert(Varchar(30),T0.CheckNum) As 'Cheque',T0.CheckAbs As 'ChequeKey',T0.DueDate As 'ChequeDate',	T0.BankCode As 'Bank',T0.Branch,T0.AcctNum As 'AccNo',T0.CheckSum As 'ChequeAmt','Deposit' As 'Action' From  RCT1 T0 JOIN ORCT T1 On T0.DocNum = T1.DocNum And T1.DocType = 'C' JOIN OCHH T2 ON T0.CheckAbs = T2.CheckKey And T2.Deposited = 'N' And T1.Canceled = 'N' And T2.Trnsfrable = 'N' Where T0.BankCode = '$chequeBank'"
              }));
      // Select CurrTotal CardBalance From [@BZ_POSBR] T0 Inner Join OACT T1 on T0.U_CreditAcct = T1.AcctCode Where T0.U_WhsCode = '$siteCode' Select CurrTotal WalletBalance From [@BZ_POSBR] T0 Inner Join OACT T1 on T0.U_WalletAcct = T1.AcctCode Where T0.U_WhsCode = '$siteCode' Select CurrTotal ChequeBalance From [@BZ_POSBR] T0 Inner Join OACT T1 on T0.U_ChequeAcct = T1.AcctCode Where T0.U_WhsCode = '$siteCode'"

      log("Acc Data sts: ${response.statusCode}");

      // log("Cheque Res: ${json.decode(response.body)}");

      if (response.statusCode == 200) {
        return ChequeDepositQueryModel.fromJson(
            response.body, response.statusCode);
      } else {
        // throw Exception("Error!!...");
        return ChequeDepositQueryModel.fromJson(
            response.body, response.statusCode);
      }
    } catch (e) {
      log('exp::${e.toString()}');
      //  throw Exception("Exception: $e");
      return ChequeDepositQueryModel.fromJson(e.toString(), 500);
    }
  }
}
