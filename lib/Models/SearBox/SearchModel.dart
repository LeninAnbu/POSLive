class searchModel {
  int docentry;
  String docNo;
  int? sapDocNo;
  String qStatus;
  String docDate;
  int? sapNo;
  String sapDate;
  String customeraName;
  double doctotal;
  String? type;
  String? username;
  String? terminal;

  searchModel({
    required this.username,
    required this.terminal,
    required this.docNo,
    required this.docentry,
    required this.docDate,
    this.sapNo,
    required this.sapDate,
    this.sapDocNo,
    required this.qStatus,
    required this.customeraName,
    required this.doctotal,
    this.type,
  });
}
