class ApprovalDetailsValue {
  int? docEntry;
  String? cardCode;
  String? cardName;
  int? DocNum;
  String? DocDate;
  List<DocumentApprovalValue>? documentLines;
  String? DocumentStatus;
  String? CancelStatus;
  String? DocCurrency;
  double? totalDiscount;
  double? vatSum;
  double? docTotal;
  String? DocDueDate;
  int? salesPersonCode;

  String? error;
  String? U_OrderDate;
  String? U_Order_Type;
  String? U_GP_Approval;
  String? U_Received_Time;
  String? numAt;
  String? uDevicTransId;

  String? PostOrder_Type;
  String? PostGP_Approval;
  ApprovalDetailsValue(
      {this.docEntry,
      this.cardCode,
      this.cardName,
      this.DocNum,
      this.DocDate,
      this.documentLines,
      this.DocumentStatus,
      this.CancelStatus,
      this.DocCurrency,
      this.docTotal,
      this.totalDiscount,
      this.vatSum,
      this.error,
      this.uDevicTransId,
      this.DocDueDate,
      this.U_Received_Time,
      this.U_Order_Type,
      this.U_OrderDate,
      this.U_GP_Approval,
      this.numAt,
      this.PostGP_Approval,
      this.PostOrder_Type,
      this.salesPersonCode});

  factory ApprovalDetailsValue.fromJson(dynamic jsons) {
    if (jsons['DocumentLines'] != null && jsons['AddressExtension'] != null) {
      final list = jsons['DocumentLines'] as List;
      print(list.length);
      List<DocumentApprovalValue> dataList = list
          .map((dynamic enquiries) => DocumentApprovalValue.fromJson(enquiries))
          .toList();
      return ApprovalDetailsValue(
        uDevicTransId: jsons['U_DeviceTransID'].toString(),
        docEntry: jsons['DocEntry'] as int,
        cardCode: jsons['CardCode'].toString(),
        cardName: jsons['CardName'].toString(),
        DocDate: jsons['DocDate'].toString(),
        DocNum: jsons['DocNum'] as int,
        DocumentStatus: jsons['DocumentStatus'].toString(),
        CancelStatus: jsons['CancelStatus'].toString(),
        DocCurrency: jsons['DocCurrency'].toString(),
        documentLines: dataList,
        salesPersonCode: jsons['SalesPersonCode'] as int,
        docTotal: jsons['DocTotal'] as double,
        totalDiscount: jsons['TotalDiscount'] as double,
        vatSum: jsons['VatSum'] as double,
        DocDueDate: jsons['DocDueDate'].toString(),
        U_OrderDate:
            jsons['U_OrderDate'] == null ? '' : jsons['U_OrderDate'] as String,
        U_GP_Approval: jsons['U_Order_Type'] == null
            ? ''
            : jsons['U_Order_Type'] == '0'
                ? 'No'
                : jsons['U_Order_Type'] == '1'
                    ? 'Yes'
                    : jsons['U_Order_Type'] as String,
        U_Order_Type: jsons['U_GP_Approval'] == null
            ? ''
            : jsons['U_GP_Approval'] == '0'
                ? 'Select'
                : jsons['U_GP_Approval'] == '1'
                    ? 'Normal'
                    : jsons['U_GP_Approval'] == '2'
                        ? 'Depot Transfer'
                        : jsons['U_GP_Approval'] == '3'
                            ? 'Root Sale'
                            : jsons['U_GP_Approval'] == '4'
                                ? 'Project Sale'
                                : jsons['U_GP_Approval'] == '5'
                                    ? 'Special Order'
                                    : jsons['U_GP_Approval'] as String,
        U_Received_Time: jsons['U_Received_Time'] == null
            ? ''
            : jsons['U_Received_Time'] as String,
        numAt: jsons['NumAtCard'] == null ? '' : jsons['NumAtCard'] as String,
        PostOrder_Type: jsons['U_Order_Type'] == null
            ? ''
            : jsons['U_Order_Type'] as String,
        PostGP_Approval: jsons['U_GP_Approval'] == null
            ? ''
            : jsons['U_GP_Approval'] as String,
      );
    } else {
      return ApprovalDetailsValue(
        DocDate: jsons['DocDate'].toString(),
      );
    }
  }

  factory ApprovalDetailsValue.issue(String e) {
    return ApprovalDetailsValue(
      error: e,
    );
  }
}

class DocumentApprovalValue {
  int? lineNum;
  String? itemCode;
  String? itemDescription;
  double? quantity;
  double? price;
  String? taxCode;
  double? lineTotal;
  double? unitPrice;
  double? taxTotal;
  double? discountPercent;
  double? total;
  String? warehouseCode;
  int? baseEntry;
  int? baseLine;
  int? baseType;

  DocumentApprovalValue(
      {this.lineNum,
      this.itemCode,
      this.itemDescription,
      this.lineTotal,
      this.price,
      this.quantity,
      this.taxCode,
      this.unitPrice,
      this.taxTotal,
      this.discountPercent,
      this.total,
      this.warehouseCode,
      this.baseEntry,
      this.baseLine,
      this.baseType});

  factory DocumentApprovalValue.fromJson(dynamic jsons) {
    return DocumentApprovalValue(
      lineNum: jsons['LineNum'] as int,
      itemCode: jsons['ItemCode'].toString(),
      itemDescription: jsons['ItemDescription'].toString(),
      lineTotal: jsons['LineTotal'] == null ? 0 : jsons['LineTotal'] as double,
      unitPrice: double.parse(jsons['UnitPrice'].toString()),
      price:
          jsons['Price'] == null ? 0 : double.parse(jsons['Price'].toString()),
      quantity: jsons['Quantity'] == null ? 0 : jsons['Quantity'] as double,
      taxCode: jsons['TaxCode'].toString(),
      taxTotal: jsons['TaxTotal'] == null ? 0 : jsons['TaxTotal'] as double,
      discountPercent: jsons['DiscountPercent'] == null
          ? 0
          : jsons['DiscountPercent'] as double,
      total:
          jsons['PriceAfterVAT'] == null ? 0 : jsons['PriceAfterVAT'] as double,
      warehouseCode: jsons['WarehouseCode'].toString(),
      baseEntry: jsons['BaseEntry'] == null ? 0 : jsons['BaseEntry'] as int,
      baseLine: jsons['BaseLine'] == null ? 0 : jsons['BaseLine'] as int,
      baseType: jsons['BaseType'] == null ? 0 : jsons['BaseType'] as int,
    );
  }
}

class AddressExtension {
  String? billToStreet;
  dynamic billToStreetNo;
  String? billToBlock;
  dynamic billToBuilding;
  String? billToCity;
  String? billToZipCode;
  String? billToCounty;
  String? billToState;
  String? shipToStreet;
  String? shipToStreetNo;
  String? shipToBlock;
  String? shipToBuilding;
  String? shipToCity;
  String? shipToZipCode;
  String? shipToCounty;
  String? shipToState;
  String? shipToCountry;
  AddressExtension({
    this.billToStreet,
    this.billToStreetNo,
    this.billToBlock,
    this.billToBuilding,
    this.billToCity,
    this.billToZipCode,
    this.billToCounty,
    this.billToState,
    this.shipToStreet,
    this.shipToStreetNo,
    this.shipToBlock,
    this.shipToBuilding,
    this.shipToCity,
    this.shipToZipCode,
    this.shipToCounty,
    this.shipToState,
    this.shipToCountry,
  });

  factory AddressExtension.fromJson(dynamic jsons) {
    return AddressExtension(
      billToStreet:
          jsons['BillToStreet'] == null ? '' : jsons['BillToStreet'].toString(),
      billToStreetNo: jsons['BillToStreetNo'],
      billToBlock: jsons['BillToBlock'].toString(),
      billToBuilding: jsons['BillToBuilding'].toString(),
      billToCity:
          jsons['BillToCity'] == null ? '' : jsons['BillToCity'].toString(),
      billToZipCode: jsons['BillToZipCode'].toString(),
      billToCounty:
          jsons['billToCounty'] == null ? '' : jsons['billToCounty'].toString(),
      billToState:
          jsons['BillToState'] == null ? '' : jsons['BillToState'].toString(),
      shipToStreet:
          jsons['ShipToStreet'] == null ? '' : jsons['ShipToStreet'].toString(),
      shipToStreetNo: jsons['ShipToStreetNo'].toString(),
      shipToBlock: jsons['ShipToBlock'].toString(),
      shipToBuilding: jsons['ShipToBuilding'].toString(),
      shipToCity:
          jsons['ShipToCity'] == null ? '' : jsons['ShipToCity'].toString(),
      shipToZipCode: jsons['ShipToZipCode'].toString(),
      shipToCounty: jsons['ShipToCounty'].toString(),
      shipToState:
          jsons['ShipToState'] == null ? '' : jsons['ShipToState'].toString(),
      shipToCountry: jsons['ShipToCountry'] == null
          ? ''
          : jsons['ShipToCountry'].toString(),
    );
  }
}

class AddQuotEditItem {
  String? itemName;
  String itemCode;
  double? price;
  double? qty;
  double? discount;
  double? total;
  double? tax;
  double? taxPer;
  String? valuechoosed;
  String? taxCode;
  double? discounpercent;
  String? warehouse;
  String? shipToCode;
  double? valueAF;
  int? carton;
  int? lineNo;
  double? U_Pack_Size;
  int? U_Tins_Per_Box;
  AddQuotEditItem(
      {required this.itemCode,
      this.warehouse,
      this.itemName,
      this.price,
      this.discount,
      this.qty,
      this.total,
      this.tax,
      this.valuechoosed,
      this.taxCode,
      this.discounpercent,
      this.taxPer,
      this.shipToCode,
      this.valueAF,
      this.lineNo,
      this.carton,
      this.U_Pack_Size,
      this.U_Tins_Per_Box});

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> mapData = {
      "LineNum": lineNo,
      "ItemCode": itemCode,
      "ItemDescription": itemName,
      "DiscountPercent": discounpercent.toString(),
      "TaxCode": taxCode.toString(),
      "Quantity": qty.toString(),
      "UnitPrice": price.toString(),
      "Currency": '',
      "ShipToCode": '',
      "valueAF": valueAF.toString(),
      "WarehouseCode": warehouse
    };
    if (mapData["LineNum"] == null) {
      mapData.remove("LineNum");
    }
    //  mapData.removeWhere((key, value) => value == null);
    return mapData;
  }

  Map<String, dynamic> tojson2() {
    final Map<String, dynamic> map = {
      // "LineNum": lineNo,
      "ItemCode": itemCode,
      "ItemDescription": itemName,
      "DiscountPercent": discounpercent.toString(),
      "TaxCode": taxCode.toString(),
      "Quantity": qty.toString(),
      "UnitPrice": price.toString(),
      "Currency": '',
      "ShipToCode": '',
      "valueAF": valueAF.toString(),
      "WarehouseCode": warehouse
    };
    return map;
  }
}
