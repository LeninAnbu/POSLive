import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../../Constant/AppConstant.dart';
import '../../../Models/QueryUrlModel/DepositsQueryModel/ChequeDepositModel.dart';

class CardDepositsQueryAPi {
  static Future<ChequeDepositQueryModel> getGlobalData(
    String creditCard,
  ) async {
    log("Select  T0.VoucherNum as 'VoucherNo',T3.AbsId As 'CreditKey',T0.FirstDue As 'DocDate',T2.CardName As 'CardName', T1.CrTypeName As 'PayMethod',T0.NumOfPmnts As 'NoOfPay',T0.CreditSum As 'TotalAmount','Deposit' as 'Action', T5.AcctCode as 'CommAcct',(IsNull(T5.U_CreTax,0) / 100) * T0.U_Comm As 'TaxAmt',T0.U_Comm as 'CommAmt' From RCT3 T0 Inner Join OCRP T1 On T0.CrTypeCode = T1.CrTypeCode Inner Join OCRC T2 On T0.CreditCard = T2.CreditCard  Inner Join OCRH T3 On T3.RctAbs = T0.DocNum And T3.Deposited = 'N' And T3.Canceled = 'N' And T3.RcptLineId = T0.LineID And T3.CreditSum > 0 Left Outer Join OACT T5 On T5.AcctCode = @CCCAcct Where 1 = 1 And	 T2.CardName = '$creditCard'");

    try {
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query":
                    "EXEC BZ_POS_CardDepositsQueryAPi  @CCCAcct , '$creditCard'"
              }));

      log("CardDeposits sts: ${response.statusCode}");

      if (response.statusCode == 200) {
        return ChequeDepositQueryModel.fromJson(
            response.body, response.statusCode);
      } else {
        return ChequeDepositQueryModel.fromJson(
            response.body, response.statusCode);
      }
    } catch (e) {
      log('exp::${e.toString()}');

      return ChequeDepositQueryModel.fromJson(e.toString(), 500);
    }
  }
}
