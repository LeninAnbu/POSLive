//     "AccountCode": "_SYS00000000698",
class PostingInvoiceLines {
  String itemName;
  String? itemCode;
  String? quantity;
  String? taxCode;
  String? unitPrice;
  String? price;
  String? discPrcnt;
  String? whsCode;
  String? currency; //"TZS";
  String? basedocentry;
  String? baseline;
//  String accountCode;
  int? baseType;
  List<Invbatch> batchNumbers;
  // String? fromWarehouse;
  // String? toWarehouse;

  PostingInvoiceLines(
      {required this.itemName,
      // required this.accountCode,
      this.currency,
      this.discPrcnt,
      this.itemCode,
      this.price,
      this.quantity,
      this.taxCode,
      this.unitPrice,
      this.whsCode,
      required this.batchNumbers,
      // this.fromWarehouse,
      // this.toWarehouse,
      required this.baseType,
      required this.basedocentry,
      required this.baseline});
  Map<String, dynamic> tojson() => {
        "ItemCode": itemCode.toString(),
        "ItemDescription": itemName,
        "DiscountPercent": discPrcnt.toString(),
        "TaxCode": taxCode,
        "Quantity": quantity.toString(),
        "UnitPrice": unitPrice.toString(),
        "WarehouseCode": whsCode,
        "BaseType": baseType,
        "BaseEntry": basedocentry,
        "BaseLine": baseline, //d14131
        "BatchNumbers":
            List<dynamic>.from(batchNumbers.map((x) => x.toJson2())),
        "Currency": "TZS",
      };
  Map<String, dynamic> tojson2() => {
        "ItemCode": itemCode.toString(),
        "ItemDescription": itemName,
        "DiscountPercent": discPrcnt.toString(),
        "TaxCode": taxCode.toString(),
        "Quantity": quantity.toString(),
        "UnitPrice": unitPrice.toString(),
        "WarehouseCode": whsCode,
        "BatchNumbers":
            List<dynamic>.from(batchNumbers.map((x) => x.toJson2())),
        "Currency": "TZS",
      };
}

class Invbatch {
  double quantity;
  int? lineId;
  String batchNumberProperty;
  String? itemCode;

  Invbatch({
    this.itemCode,
    this.lineId,
    required this.quantity,
    required this.batchNumberProperty,
  });

  factory Invbatch.fromJson(Map<String, dynamic> json) => Invbatch(
        // baseLineNumber: json["BaseLineNumber"],
        quantity: json["Quantity"],
        batchNumberProperty: json["BatchNumbers"],
      );

  Map<String, dynamic> toJson2() => {
        // "BaseLineNumber": baseLineNumber,
        "Quantity": quantity,
        "BatchNumber": batchNumberProperty,
      };
}
