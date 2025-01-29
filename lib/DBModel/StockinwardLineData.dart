const String tableStockInLineDB = "StockInLineDB";

class StockInLineData {
  static String branch = "branch";
  static String terminal = "terminal";
  static String docentry = "docentry";
  static String lineno = "lineno";
  static String itemcode = "itemcode";
  static String description = "description";
  static String quantity = 'quantity';
  static String scannedQty = 'scannedQty';
  static String serialBatch = "serialBatch";
  static String status = "status";
  static String baseDocentry = "baseDocentry";
  static String baseDocline = "baseDocline";
  static String transferQty = "transferQty";
}

class StockInLineDataDB {
  String? docentry;
  String? branch;
  String? terminal;
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

  StockInLineDataDB({
    required this.branch,
    required this.terminal,
    required this.lineno,
    required this.docentry,
    required this.itemcode,
    required this.description,
    required this.qty,
    required this.baseDocentry,
    required this.baseDocline,
    required this.status,
    required this.serialBatch,
    required this.traansferQty,
    required this.scannedQty,
  });
  factory StockInLineDataDB.fromjson(Map<String, dynamic> resp) {
    return StockInLineDataDB(
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
        serialBatch: resp['serialBatch'],
        traansferQty: resp['traansferQty'],
        scannedQty: resp['scannedQty']);
  }
  Map<String, Object?> toMap() => {
        StockInLineData.terminal: terminal,
        StockInLineData.branch: branch,
        StockInLineData.lineno: lineno,
        StockInLineData.docentry: docentry,
        StockInLineData.itemcode: itemcode,
        StockInLineData.description: description,
        StockInLineData.quantity: qty,
        StockInLineData.baseDocentry: baseDocentry,
        StockInLineData.baseDocline: baseDocline,
        StockInLineData.status: status,
        StockInLineData.serialBatch: serialBatch,
        StockInLineData.transferQty: traansferQty,
        StockInLineData.scannedQty: scannedQty,
      };
}
