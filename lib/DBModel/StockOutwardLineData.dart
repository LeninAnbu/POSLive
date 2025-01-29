const String tableStockOutLineDB = "StockOutLineDB";

class StockOutLineData {
  static String terminal = "terminal";
  static String branch = "branch";
  static String docentry = "docentry";
  static String lineno = "lineno";
  static String itemcode = "itemcode";
  static String description = "description";
  static String quantity = 'quantity';
  static String inStkQty = 'InStkQty';
  static String scannedQty = 'scannedQty';
  static String serialBatch = "serialBatch";
  static String status = "status";
  static String baseDocentry = "baseDocentry";
  static String baseDocline = "baseDocline";
  static String transferQty = "transferQty";
}

class StockOutLineDataDB {
  String? docentry;
  String? branch;
  String? terminal;
  double? inStkQty;

  String? lineno;
  String? itemcode;
  String? description;
  double? qty;
  double? traansferQty;
  double? scannedQty;
  String? status;
  String? baseDocentry;
  String? baseDocline;
  String? serialBatch;
  StockOutLineDataDB({
    required this.lineno,
    required this.terminal,
    required this.branch,
    required this.docentry,
    required this.itemcode,
    required this.description,
    required this.qty,
    required this.baseDocentry,
    required this.baseDocline,
    required this.status,
    required this.serialBatch,
    required this.traansferQty,
    required this.inStkQty,
    required this.scannedQty,
  });
  factory StockOutLineDataDB.fromjson(Map<String, dynamic> resp) {
    return StockOutLineDataDB(
        lineno: resp['lineno'].toString(),
        terminal: resp['terminal'],
        branch: resp['branch'],
        docentry: resp['docentry'].toString(),
        itemcode: resp['itemcode'],
        description: resp['description'],
        qty: resp['quantity'],
        baseDocentry: resp['baseDocentry'].toString(),
        baseDocline: resp['baseDocline'].toString(),
        status: resp['status'],
        inStkQty: resp['InStkQty'],
        serialBatch: resp['serialBatch'],
        traansferQty: resp['transferQty'],
        scannedQty: resp['scannedQty']);
  }
  Map<String, Object?> toMap() => {
        StockOutLineData.lineno: lineno,
        StockOutLineData.terminal: terminal,
        StockOutLineData.branch: branch,
        StockOutLineData.docentry: docentry,
        StockOutLineData.inStkQty: inStkQty,
        StockOutLineData.itemcode: itemcode,
        StockOutLineData.description: description,
        StockOutLineData.quantity: qty,
        StockOutLineData.baseDocentry: baseDocentry,
        StockOutLineData.baseDocline: baseDocline,
        StockOutLineData.status: status,
        StockOutLineData.serialBatch: serialBatch,
        StockOutLineData.transferQty: traansferQty,
        StockOutLineData.scannedQty: scannedQty,
      };
}
