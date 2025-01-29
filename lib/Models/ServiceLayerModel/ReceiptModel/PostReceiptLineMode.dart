class PostPaymentCheck {
  String? dueDate;
  int? checkNumber;
  String? bankCode;

  String? accounttNum;
  String details;
  double? checkSum;

  PostPaymentCheck({
    required this.dueDate,
    required this.checkNumber,
    required this.bankCode,
    required this.accounttNum,
    required this.details,
    required this.checkSum,
  });

  Map<String?, dynamic> toJson2() => {
        "DueDate": dueDate,
        "CheckNumber": checkNumber,
        "BankCode": bankCode,
        "AccounttNum": accounttNum,
        "Details": details,
        "CheckSum": checkSum,
      };
}

class PostPaymentCard {
  String? lineNum;
  String? creditAcc;
  String? cardValidity;
  double? creditSum;
  String creditCardNum;
  int creditcardCode;
  String voucherNum;

  PostPaymentCard({
    this.lineNum,
    required this.creditAcc,
    required this.cardValidity,
    required this.creditSum,
    required this.creditcardCode,
    required this.voucherNum,
    required this.creditCardNum,
  });

  Map<String?, dynamic> toJson3() => {
        "CreditAcct": creditAcc,
        "CreditCard": creditcardCode,
        "VoucherNum": voucherNum,
        "CardValidUntil": cardValidity,
        "CreditSum": creditSum,
        "CreditCardNumber": creditCardNum,
      };
}

class PostPaymentInvoice {
  int? docEntry;
  int? docNum;
  double? sumApplied;
  String? invoiceType;

  PostPaymentInvoice({
    required this.docEntry,
    required this.docNum,
    required this.sumApplied,
    required this.invoiceType,
  });

  Map<String?, dynamic> toJson3() => {
        "DocEntry": docEntry,
        "DocNum": docNum,
        "SumApplied": sumApplied,
        "InvoiceType": invoiceType,
      };
}
