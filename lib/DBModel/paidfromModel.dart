const String tableExpensepaidfrom ="expensepaidfrom";

class expensepaidfromT{
  static String docentry="docentry";
  static String accountcode="accountcode";
  static String accountname="accountname";
  static String balance="balance";
  
  
}
class expensepaidfrom{
  String? docentry;
  String? accountcode;
  String? accountname;
  String? balance;
  
  expensepaidfrom({
    this.docentry,
    required this.accountcode,
    required this.accountname,
    required this.balance,
    
  });
  Map<String, Object?> toMap()=>{
    expensepaidfromT.docentry:docentry,
    expensepaidfromT.accountcode:accountcode,
    expensepaidfromT.accountname:accountname,
    expensepaidfromT.balance:balance,
    

  };
}
