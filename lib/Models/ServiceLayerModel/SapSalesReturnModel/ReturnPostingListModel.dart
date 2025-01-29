// import 'dart:convert';
// import '../SAPInwardModel/InwardPostList.dart';
// import '../SapInvoiceModel/InvPostingLineModel.dart';

// class PostingReturnLines {
//   String itemName;
//   String? ItemCode;
//   String? Quantity;
//   String? Price;
//   String? DiscPrcnt;
// String? basedocentry;
// String? baseline;
// int? baseType;
//   List<Invbatch> batchNumbers;

//   PostingReturnLines(
//       {required this.itemName,
//       this.DiscPrcnt,
//       this.ItemCode,
//       this.Price,
//       this.Quantity,
//       required this.batchNumbers,
//      required this.baseType,
//      required this.basedocentry,
//      required this.baseline});
//   Map<String, dynamic> tojson() => {
//         "ItemCode": ItemCode.toString(),
//         "ItemDescription": itemName.toString(),
//         "DiscountPercent": DiscPrcnt.toString(),
//         "Quantity": Quantity.toString(),
//         "BaseEntry": basedocentry.toString(),
//         "Price":Price,
//         "BaseLine": baseline.toString(),
//         'BaseType': baseType.toString(),
// "BatchNumbers":
//     List<dynamic>.from(batchNumbers.map((x) => x.toJson2())),
//       };
// }

// // class Invbatch {
// //   double quantity;
// //   String batchNumberProperty;

// //   Invbatch({
// //     required this.quantity,
// //     required this.batchNumberProperty,
// //   });

// //   factory Invbatch.fromJson(Map<String, dynamic> json) => Invbatch(
// //         quantity: json["Quantity"],
// //         batchNumberProperty: json["BatchNumbers"],
// //       );

// //   Map<String, dynamic> toJson2() => {
// //         "Quantity": quantity,
// //         "BatchNumber": batchNumberProperty,
// //       };
// // }

import '../SapInvoiceModel/InvPostingLineModel.dart';

class ReturnValuess {
  String docDate;
  String docDueDate;
  String cardCode;
  String cardName;
  // double docTotal;
  // double docRate;
  String reference1;
  List<ReturnPostingtLine> returnDocumentLines;

  ReturnValuess({
    required this.docDate,
    required this.docDueDate,
    required this.cardCode,
    required this.cardName,
    // required this.docTotal,
    // required this.docRate,
    required this.reference1,
    required this.returnDocumentLines,
  });

  // factory ReturnValuess.fromJson(Map<String, dynamic> json) => ReturnValuess(
  //       // docEntry: json["DocEntry"],
  //       // docNum: json["DocNum"],
  //       docDate: DateTime.parse(json["DocDate"]),
  //       docDueDate: DateTime.parse(json["DocDueDate"]),
  //       cardCode: json["CardCode"],
  //       cardName: json["CardName"],

  //       docTotal: json["DocTotal"],

  //       docRate: json["DocRate"],
  //       reference1: json["Reference1"],
  //       returnDocumentLines:
  //       //  List<ReturnDocumentLine>.from(
  //       //     json["ReturnDocumentLines"]
  //       //         .map((x) => ReturnDocumentLine.fromJson(x))),
  //     );

  Map<String, dynamic> toJson() => {
        // "DocEntry": docEntry,
        // "DocNum": docNum,
        // "DocType": docType,

        "DocDate": docDate,
        // "${docDate.year.toString().padLeft(4, '0')}-${docDate.month.toString().padLeft(2, '0')}-${docDate.day.toString().padLeft(2, '0')}",
        "DocDueDate": docDueDate,
        // "${docDueDate.year.toString().padLeft(4, '0')}-${docDueDate.month.toString().padLeft(2, '0')}-${docDueDate.day.toString().padLeft(2, '0')}",
        "CardCode": cardCode,
        "CardName": cardName,

        // "DocTotal": docTotal,
        "DocumentLines":
            List<dynamic>.from(returnDocumentLines.map((x) => x.toJson3())),
        // "DocRate": docRate,
        "Reference1": reference1,
      };
}

class ReturnPostingtLine {
  int lineNum;
  String itemCode;
  String itemDescription;
  double quantity;
  double price;
  double discountPercent;
  String warehouseCode;
  int basedocentry;
  int? baseline;
  int? baseType;
  List<Invbatch> batchNumbers;
  ReturnPostingtLine({
    required this.lineNum,
    required this.itemCode,
    required this.itemDescription,
    required this.quantity,
    required this.price,
    required this.discountPercent,
    required this.warehouseCode,
    required this.batchNumbers,
    required this.baseType,
    required this.basedocentry,
    required this.baseline,
  });

  // factory ReturnDocumentLine.fromJson(Map<String, dynamic> json) =>
  //     ReturnDocumentLine(
  //       lineNum: json["LineNum"],
  //       itemCode: json["ItemCode"],
  //       itemDescription: json["ItemDescription"],
  //       quantity: json["Quantity"],
  //       price: json["Price"],
  //       discountPercent: json["DiscountPercent"],
  //       warehouseCode: json["WarehouseCode"]!, batchNumbers: ,
  //     );

  Map<String, dynamic> toJson3() => {
        "LineNum": lineNum,
        "ItemCode": itemCode,
        "ItemDescription": itemDescription,
        "Quantity": quantity,
        "Price": price,
        "DiscountPercent": discountPercent,
        "WarehouseCode": warehouseCode,
        "BaseType": baseType,
        "BaseEntry": basedocentry,
        "BaseLine": baseline,
        "BatchNumbers":
            List<dynamic>.from(batchNumbers.map((x) => x.toJson2())),
      };
}
