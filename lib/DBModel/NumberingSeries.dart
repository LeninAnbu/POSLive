const String tableNS = "NumberingSeries";

class NumberingSriesT {
  static String id = 'id';
  static String docID = "DocID";
  static String docName = "DocName";
  static String wareHouse = "WareHouse";
  static String terminal = "Terminal";
  static String prefix = "Prefix";
  static String firstNo = "FirstNo";
  static String lastNo = 'LastNo';
  static String nextNo = "NextNo";
  static String fromDate = "FromDate";
  static String toDate = "ToDate";
}

class NumberingSriesTDB {
  int? id;
  String docName;
  int? docID;
  String? wareHouse;
  String? terminal;
  String? prefix;
  int? firstNo;
  int? lastNo;
  int nextNo;
  String? fromDate;
  String? toDate;

  NumberingSriesTDB({
    required this.docName,
    required this.id,
    required this.docID,
    required this.firstNo,
    required this.fromDate,
    required this.lastNo,
    required this.nextNo,
    required this.prefix,
    required this.terminal,
    required this.toDate,
    required this.wareHouse,
  });
//   createdUserID:item['createdUserID'] ,
  factory NumberingSriesTDB.fromMap(Map<String, dynamic> item) =>
      NumberingSriesTDB(
        id: item['id'],
        docID: item['DocID'],
        firstNo: item['FirstNo'],
        lastNo: item['LastNo'],
        nextNo: item['NextNo'],
        terminal: item['Terminal'],
        toDate: item['ToDate'],
        fromDate: item['FromDate'],
        prefix: item['Prefix'],
        wareHouse: item['WareHouse'],
        docName: item['DocName'],
      );

  Map<String, Object?> toMap() => {
        NumberingSriesT.id: id,
        NumberingSriesT.docID: docID,
        NumberingSriesT.firstNo: firstNo,
        NumberingSriesT.fromDate: fromDate,
        NumberingSriesT.lastNo: lastNo,
        NumberingSriesT.nextNo: nextNo,
        NumberingSriesT.prefix: prefix,
        NumberingSriesT.terminal: terminal,
        NumberingSriesT.toDate: toDate,
        NumberingSriesT.wareHouse: wareHouse,
        NumberingSriesT.docName: docName
      };
}
