// ignore_for_file: prefer_single_quotes, omit_local_variable_types, prefer_final_locals, prefer_interpolation_to_compose_Strings

import '../../DataModel/SeriesMode/SeriesModels.dart';

class SalesQuotStatus {
  SalesQuotStatus(
      {this.statusCode,
      this.error,
      this.erros,
      this.docEntry,
      this.documentNum});
  int? statusCode;
  Errors? error;
  String? erros;
  int? docEntry;
  int? documentNum;
  factory SalesQuotStatus.fromJson(int statusCode) {
    return SalesQuotStatus(
      statusCode: statusCode,
    );
  }
  factory SalesQuotStatus.errorIN(
    Map<String, dynamic> json,
    int statusCode,
  ) {
    return SalesQuotStatus(
      statusCode: statusCode,
      error: Errors.fromJson(json['error']),
    );
  }
  factory SalesQuotStatus.issue(String e, int statusCode) {
    return SalesQuotStatus(
      statusCode: statusCode,
      erros: e,
    );
  }
}

class SAP_Quatation {
  int? DocEntry;
  int? DocNum;
  String? CardCode;
  String? DocDueDate;
  List<QuatationLines>? DocumentLines;
  String? CardName;
  String? Comments;
  String? U_TransID;
  String? U_PBranch;
  String? U_Terminal;
  String? U_OrderDate;
  String? U_Order_Type;
  String? U_GP_Approval;
  String? U_Received_Time;
  String? DocStatus;
  String? SlpCode;
  String? DocDate;
  String? NumAtCard;
  String? Series;
  SAP_Quatation({
    required this.CardCode,
    required this.CardName,
    required this.Comments,
    required this.DocDate,
    required this.DocDueDate,
    required this.DocEntry,
    required this.DocNum,
    required this.DocStatus,
    required this.DocumentLines,
    required this.NumAtCard,
    required this.Series,
    required this.SlpCode,
    required this.U_GP_Approval,
    required this.U_OrderDate,
    required this.U_Order_Type,
    required this.U_PBranch,
    required this.U_Received_Time,
    required this.U_Terminal,
    required this.U_TransID,
  });
}

class QuatationLines {
  String itemName;
  String? itemCode;
  String? quantity;
  String? taxCode;
  String? unitPrice;
  String? leadDate;
  String? price;
  String? discPrcnt;
  String? whsCode;
  String? currency; //"TZS";
  int? basedocentry;
  int? baseline;
  int? lineNo;

  int? baseType;
  // String? fromWarehouse;
  // String? toWarehouse;

  QuatationLines(
      {required this.itemName,
      this.currency,
      this.discPrcnt,
      this.itemCode,
      this.price,
      this.quantity,
      this.lineNo,
      this.taxCode,
      this.unitPrice,
      this.whsCode,
      this.baseType,
      this.basedocentry,
      this.leadDate,
      this.baseline});
  Map<String, dynamic> tojson() {
    Map<String, String> map = {
      "ItemCode": itemCode.toString(),
      "ItemDescription": itemName,
      "DiscountPercent": discPrcnt.toString(),
      "TaxCode": taxCode.toString(),
      "Quantity": quantity.toString(),
      "UnitPrice": unitPrice.toString(),
      "LineNum": lineNo.toString(),
      "BaseType": baseType.toString(),
      "BaseEntry": basedocentry.toString(),
      "BaseLine": baseline.toString(),
      "Currency": "TZS",
      "WarehouseCode": whsCode.toString(),
      "ShipDate": '$leadDate',
      "U_AMDD": '$leadDate',
    };
    return map;
  }

  Map<String, dynamic> tojson2() {
    Map<String, String> map = {
      "ItemCode": itemCode.toString(),
      'LineNum': lineNo.toString(),
      "ItemDescription": itemName,
      "DiscountPercent": discPrcnt.toString(),
      "TaxCode": taxCode.toString(),
      "Quantity": quantity.toString(),
      "UnitPrice": unitPrice.toString(),
      "Currency": "TZS",
      "WarehouseCode": whsCode.toString(),
    };
    return map;
  }

  Map<String, dynamic> tojson3() {
    Map<String, String> map = {
      "ItemCode": itemCode.toString(),
      'LineNum': lineNo.toString(),
      "ItemDescription": itemName,
      "DiscountPercent": discPrcnt.toString(),
      "TaxCode": taxCode.toString(),
      "Quantity": quantity.toString(),
      "UnitPrice": unitPrice.toString(),
      "Currency": "TZS",
      "WarehouseCode": whsCode.toString(),
      "ShipDate": '$leadDate',
      "U_AMDD": '$leadDate',
    };
    return map;
  }
}

class AddItem {
  String itemName;
  String itemCode;
  double? price;
  int? qty;
  double? discount;
  double? total;
  double? tax;
  double? taxPer;
  String? valuechoosed;
  String? taxCode;
  double? discounpercent;
  String? shipToCode;
  double? valueAF;
  int? carton;
  int? lineNo;
  double? U_Pack_Size;
  int? U_Tins_Per_Box;
  AddItem(
      {required this.itemCode,
      required this.itemName,
      required this.price,
      required this.discount,
      required this.qty,
      required this.total,
      required this.tax,
      required this.valuechoosed,
      required this.taxCode,
      required this.discounpercent,
      required this.taxPer,
      this.shipToCode,
      this.valueAF,
      this.lineNo,
      this.carton,
      this.U_Pack_Size,
      this.U_Tins_Per_Box});

  Map<String, dynamic> tojson() {
    Map<String, String> map = {
      "ItemCode": itemCode,
      "ItemDescription": itemName,
      "DiscountPercent": discounpercent.toString(),
      "TaxCode": taxCode.toString(),
      "Quantity": qty.toString(),
      "UnitPrice": price.toString(),
      "Currency": "TZS",
      // "ShipToCode": LogisticPageState.shipto.toString(),
      "valueAF": valueAF.toString(),
      // "WarehouseCode": GetValues.branch.toString(),
    };
    return map;
  }
}

// class postData{
//   String docDate;
//   String dueDate;

// }
