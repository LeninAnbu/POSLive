const String tableStockOutBatchDB = "StockOutBatchDB";

class StockOutBatchData {
  static String docentry = "docentry";
  static String baseDocentry = "baseDocentry";
  static String lineno = "lineno";
  static String itemcode = "itemcode";
  static String qty = 'quantity';
  static String seialBatch = "serialBatch";
  static String docstatus = "docstatus";

  // static String scannedQty = "scannedQty";
}

class StockOutBatchDataDB {
  String? docentry;
  String? baseDocentry;

  String? lineno;
  String? itemcode;
  double? qty;
  int? scannedQty;
  String? serialbatch;
  String? docstatus;

  StockOutBatchDataDB(
      {required this.lineno,
      required this.docentry,
      required this.itemcode,
      required this.qty,
      required this.docstatus,
      required this.baseDocentry,
      required this.serialbatch});

  factory StockOutBatchDataDB.fromjson(Map<String, dynamic> resp) {
    return StockOutBatchDataDB(
        lineno: resp['lineno'].toString(),
        docentry: resp['docentry'].toString(),
        itemcode: resp['itemcode'],
        qty: resp['quantity'] ?? 0,
        baseDocentry: resp['baseDocentry'].toString(),
        docstatus: resp['docstatus'],
        serialbatch: resp['serialBatch']);
  }

  Map<String, Object?> toMap() => {
        StockOutBatchData.lineno: lineno,
        StockOutBatchData.docentry: docentry,
        StockOutBatchData.itemcode: itemcode,
        StockOutBatchData.qty: qty,
        StockOutBatchData.docstatus: docstatus,
        StockOutBatchData.baseDocentry: baseDocentry,
        StockOutBatchData.seialBatch: serialbatch,
      };
}
