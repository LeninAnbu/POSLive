// _documentLine.AccountCode = tableHeader.Rows[0]["expencecode"].ToString();
//                 _documentLine.SumPaid = Convert.ToDouble(tableHeader.Rows[0]["rcamount"].ToString());
//                 _documentLine.Decription = tableHeader.Rows[0]["reference"].ToString();
//                 _documentLine.GrossAmount = Convert.ToDouble(tableHeader.Rows[0]["rcamount"].ToString());

class ExpenseListMoel {
  String? accountCode;
  double? sumPaid;
  double? grossAmount;
  String? decription;
  String? vatGroup;
  String? ocrCode;
  String? projectCode;
  String? vatAmt;

  ExpenseListMoel(
      {required this.accountCode,
      required this.decription,
      required this.grossAmount,
      required this.projectCode,
      required this.vatGroup,
      required this.vatAmt,
      required this.ocrCode,
      required this.sumPaid});
  Map<String, dynamic> tojson() => {
        "AccountCode": accountCode.toString(),
        "Decription": decription,
        "GrossAmount": grossAmount.toString(),
        "SumPaid": sumPaid.toString(),
        "VatGroup": vatGroup == 'null' || vatGroup == null ? null : vatGroup,
        "ProfitCenter": ocrCode == 'null' || ocrCode == null ? null : ocrCode,
        "VatAmount": vatAmt,
        "ProjectCode":
            projectCode == 'null' || projectCode == null || projectCode!.isEmpty
                ? null
                : projectCode
      };
}
