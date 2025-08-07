const String tableBranch = "BranchMaster";

class BranchT {
  static String whsCode = "WhsCode";
  static String whsName = "WhsName";
  static String cashAccount = 'CashAccount';
  static String creditAccount = 'CreditAccount';
  static String chequeAccount = 'ChequeAccount';
  static String transFerAccount = 'TransFerAccount';
  static String walletAccount = 'WalletAccount';
  static String gitWhs = 'GITWhs';

  static String location = 'Location';
  static String companyName = 'CompanyName';
  static String companyHeader = 'CompanyHeader';
  static String e_Mail = 'E_Mail';
  static String cOGSAcct = 'COGSAcct';
  static String pAN = 'PAN';
  static String address1 = 'Address1';
  static String address2 = 'Address2';
  static String city = 'City';
  static String pincode = 'Pincode';
}

class BranchTModelDB {
  String? whsCode;
  String? whsName;

  String? cashAccount;
  String? creditAccount;
  String? chequeAccount;
  String? transFerAccount;
  String? wallerAccount;
  String? gitWhs;

  String? location;
  String? companyName;
  String? companyHeader;
  String? e_Mail;

  BranchTModelDB({
    required this.whsCode,
    required this.whsName,
    required this.wallerAccount,
    required this.gitWhs,
    required this.cashAccount,
    required this.creditAccount,
    required this.chequeAccount,
    required this.transFerAccount,
    required this.location,
    required this.companyName,
    required this.companyHeader,
    required this.e_Mail,
  });

  Map<String, Object?> toMap() => {
        BranchT.whsCode: whsCode,
        BranchT.whsName: whsName,
        BranchT.gitWhs: gitWhs,
        BranchT.cashAccount: cashAccount,
        BranchT.chequeAccount: chequeAccount,
        BranchT.creditAccount: creditAccount,
        BranchT.transFerAccount: transFerAccount,
        BranchT.walletAccount: wallerAccount,
        BranchT.companyHeader: companyHeader,
        BranchT.companyName: companyName,
        BranchT.e_Mail: e_Mail,
        BranchT.location: location,
      };
}
