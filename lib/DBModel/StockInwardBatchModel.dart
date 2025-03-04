const String tableStockInBatchDB = "StockInBatchDB";

class StockInBatchData {
  static String docentry = "docentry";
  static String baseDocentry = "baseDocentry";

  static String lineno = "lineno";
  static String itemcode = "itemcode";
  static String itemCode = "itemName";

  static String qty = 'quantity';
  static String seialBatch = "serialBatch";
  static String docstatus = "docstatus";

  // static String scannedQty = "scannedQty";
}

class StockInBatchDataDB {
  String? docentry;
  String? lineno;
  String? itemcode;
  double? qty;
  int? scannedQty;
  String? serialbatch;
  String? docstatus;
  String? baseDocentry;

  StockInBatchDataDB(
      {required this.lineno,
      required this.docentry,
      required this.itemcode,
      required this.qty,
      required this.docstatus,
      required this.baseDocentry,
      required this.serialbatch});

  factory StockInBatchDataDB.fromjson(Map<String, dynamic> resp) {
    return StockInBatchDataDB(
        lineno: resp['lineno'].toString(),
        docentry: resp['docentry'].toString(),
        itemcode: resp['itemcode'],
        qty: resp['quantity'] ?? 0,
        baseDocentry: resp['baseDocentry'].toString(),
        docstatus: resp['docstatus'].toString(),
        serialbatch: resp['serialBatch']);
  }

  Map<String, Object?> toMap() => {
        StockInBatchData.lineno: lineno,
        StockInBatchData.docentry: docentry,
        StockInBatchData.itemcode: itemcode,
        StockInBatchData.qty: qty,
        StockInBatchData.baseDocentry: baseDocentry,
        StockInBatchData.seialBatch: serialbatch,
        StockInBatchData.docstatus: docstatus,
      };
}
