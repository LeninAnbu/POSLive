// To parse this JSON data, do
//
//     final SapOutwardModel = SapOutwardModelFromJson(jsonString);

import '../ErrorModell/ErrorModelSl.dart';

// SapOutwardModel SapOutwardModelFromJson(String str) =>
//     SapOutwardModel.fromJson(json.decode(str));

// String SapOutwardModelToJson(SapOutwardModel data) =>
//     json.encode(data.toJson());

class SapOutwardModel {
  ErrorModel? error;
  int? statusCode;
  String odataMetadata;
  String odataEtag;
  int docEntry;
  int series;
  String printed;
  DateTime? docDate;
  DateTime? dueDate;
  dynamic cardCode;
  dynamic cardName;
  dynamic address;
  String reference1;
  // dynamic reference2;
  String comments;
  // String journalMemo;
  // int priceList;
  // int salesPersonCode;
  // String fromWarehouse;
  // String toWarehouse;
  // DateTime creationDate;
  // DateTime updateDate;
  // int financialPeriod;
  // int transNum;
  int docNum;
  // DateTime taxDate;
  // int contactPerson;
  // dynamic folioPrefixString;
  // dynamic folioNumber;
  // String docObjectCode;
  // String authorizationStatus;
  // dynamic bplid;
  // dynamic bplName;
  // dynamic vatRegNum;
  // dynamic authorizationCode;
  // dynamic startDeliveryDate;
  // dynamic startDeliveryTime;
  // dynamic endDeliveryDate;
  // dynamic endDeliveryTime;
  // dynamic vehiclePlate;
  // dynamic atDocumentType;
  // dynamic eDocExportFormat;
  // dynamic elecCommStatus;
  // dynamic elecCommMessage;
  // dynamic pointOfIssueCode;
  // dynamic letter;
  // dynamic folioNumberFrom;
  // dynamic folioNumberTo;
  // dynamic attachmentEntry;
  // String documentStatus;
  // dynamic shipToCode;
  // dynamic sapPassport;
  // String uPurchaseType;
  // String uApApprove;
  // String uFinalDel;
  // dynamic uIncoTerms;
  // dynamic uSourceDest;
  // dynamic uTransNo;
  // dynamic uVehicleNo;
  // dynamic uSupplierDt;
  // dynamic uQuotNo;
  // dynamic uQuotDate;
  // String uGovPermit;
  // dynamic uGovPermitdt;
  // dynamic uCheckNo;
  // dynamic uCheckDate;
  // dynamic uApprovalDate;
  // dynamic uOrderNoRecd;
  // dynamic uOrderDate;
  // dynamic uClearingAgent;
  // dynamic uDateSubAgent;
  // dynamic uIdfno;
  // dynamic uIdfDate;
  // dynamic uInspectionNo;
  // dynamic uEta;
  // dynamic uAirwayBillNo;
  // dynamic uBol;
  // dynamic uCotecna;
  // dynamic uArrivalDate;
  // int uDahacoAgentFees;
  // int uPortCharges;
  // int uOtherExp;
  // int uClearCharges;
  // int uHiddenChrges;
  // dynamic uGoodsInspBy;
  // dynamic uGoodsReport;
  // dynamic uPymtStatus;
  // dynamic uPymtType;
  // dynamic uTtCopyImage;
  // dynamic uPfiImage;
  // dynamic uSupplierImage;
  // dynamic uBolImage;
  // String uOrderType;
  // String uTruckInternal;
  // String uGpApproval;
  // dynamic uSupplierName;
  // dynamic uVatNumber;
  // String uTransferType;
  // dynamic uSalesOrder;
  // String uReceived;
  // dynamic uDriverName;
  // dynamic uReserveInvoice;
  // dynamic uRefSeries;
  // dynamic uReceivedTime;
  // dynamic uSkuBatchNo;
  // dynamic uInwardNo;
  // dynamic uDispatchTime;
  // dynamic uReceivedDate;
  // dynamic uExpiryDate;
  // String uCnType;
  // dynamic uTinNo;
  // dynamic uLpoNo;
  // dynamic uOrderQty;
  // dynamic uDispatchDate;
  // dynamic uBranch;
  // dynamic uSalAppEntry;
  // dynamic uDocType;
  // dynamic uIntKey;
  // dynamic uQrFileLoc;
  // dynamic uRctCde;
  // dynamic uZno;
  // dynamic uVfdIn;
  // dynamic uQrPath;
  // dynamic uQrValue;
  // dynamic uIdate;
  // dynamic uItime;
  // dynamic uDeviceCode;
  // dynamic uDeviceTransId;
  // dynamic uRvc;
  // dynamic uVrn;
  // dynamic uLongitude;
  // dynamic uLatitude;
  // dynamic uAuditJobGroup;
  // dynamic uAuditName;
  // dynamic uRequest;
  // List<dynamic> stockTransferApprovalRequests;
  // List<dynamic> electronicProtocols;
  List<StockTransferLine> stockTransferLines;
  // StockTransferTaxExtension stockTransferTaxExtension;
  // List<dynamic> documentReferences;

  SapOutwardModel({
    required this.statusCode,
    required this.error,
    required this.odataMetadata,
    required this.odataEtag,
    required this.docEntry,
    required this.series,
    required this.printed,
    required this.docDate,
    required this.dueDate,
    required this.cardCode,
    required this.cardName,
    required this.address,
    required this.reference1,
    // required this.reference2,
    required this.comments,
    // required this.journalMemo,
    // required this.priceList,
    // required this.salesPersonCode,
    // required this.fromWarehouse,
    // required this.toWarehouse,
    // required this.creationDate,
    // required this.updateDate,
    // required this.financialPeriod,
    // required this.transNum,
    required this.docNum,
    // required this.taxDate,
    // required this.contactPerson,
    // required this.folioPrefixString,
    // required this.folioNumber,
    // required this.docObjectCode,
    // required this.authorizationStatus,
    // required this.bplid,
    // required this.bplName,
    // required this.vatRegNum,
    // required this.authorizationCode,
    // required this.startDeliveryDate,
    // required this.startDeliveryTime,
    // required this.endDeliveryDate,
    // required this.endDeliveryTime,
    // required this.vehiclePlate,
    // required this.atDocumentType,
    // required this.eDocExportFormat,
    // required this.elecCommStatus,
    // required this.elecCommMessage,
    // required this.pointOfIssueCode,
    // required this.letter,
    // required this.folioNumberFrom,
    // required this.folioNumberTo,
    // required this.attachmentEntry,
    // required this.documentStatus,
    // required this.shipToCode,
    // required this.sapPassport,
    // required this.uPurchaseType,
    // required this.uApApprove,
    // required this.uFinalDel,
    // required this.uIncoTerms,
    // required this.uSourceDest,
    // required this.uTransNo,
    // required this.uVehicleNo,
    // required this.uSupplierDt,
    // required this.uQuotNo,
    // required this.uQuotDate,
    // required this.uGovPermit,
    // required this.uGovPermitdt,
    // required this.uCheckNo,
    // required this.uCheckDate,
    // required this.uApprovalDate,
    // required this.uOrderNoRecd,
    // required this.uOrderDate,
    // required this.uClearingAgent,
    // required this.uDateSubAgent,
    // required this.uIdfno,
    // required this.uIdfDate,
    // required this.uInspectionNo,
    // required this.uEta,
    // required this.uAirwayBillNo,
    // required this.uBol,
    // required this.uCotecna,
    // required this.uArrivalDate,
    // required this.uDahacoAgentFees,
    // required this.uPortCharges,
    // required this.uOtherExp,
    // required this.uClearCharges,
    // required this.uHiddenChrges,
    // required this.uGoodsInspBy,
    // required this.uGoodsReport,
    // required this.uPymtStatus,
    // required this.uPymtType,
    // required this.uTtCopyImage,
    // required this.uPfiImage,
    // required this.uSupplierImage,
    // required this.uBolImage,
    // required this.uOrderType,
    // required this.uTruckInternal,
    // required this.uGpApproval,
    // required this.uSupplierName,
    // required this.uVatNumber,
    // required this.uTransferType,
    // required this.uSalesOrder,
    // required this.uReceived,
    // required this.uDriverName,
    // required this.uReserveInvoice,
    // required this.uRefSeries,
    // required this.uReceivedTime,
    // required this.uSkuBatchNo,
    // required this.uInwardNo,
    // required this.uDispatchTime,
    // required this.uReceivedDate,
    // required this.uExpiryDate,
    // required this.uCnType,
    // required this.uTinNo,
    // required this.uLpoNo,
    // required this.uOrderQty,
    // required this.uDispatchDate,
    // required this.uBranch,
    // required this.uSalAppEntry,
    // required this.uDocType,
    // required this.uIntKey,
    // required this.uQrFileLoc,
    // required this.uRctCde,
    // required this.uZno,
    // required this.uVfdIn,
    // required this.uQrPath,
    // required this.uQrValue,
    // required this.uIdate,
    // required this.uItime,
    // required this.uDeviceCode,
    // required this.uDeviceTransId,
    // required this.uRvc,
    // required this.uVrn,
    // required this.uLongitude,
    // required this.uLatitude,
    // required this.uAuditJobGroup,
    // required this.uAuditName,
    // required this.uRequest,
    // required this.stockTransferApprovalRequests,
    // required this.electronicProtocols,
    required this.stockTransferLines,
    // required this.stockTransferTaxExtension,
    // required this.documentReferences,
  });

  factory SapOutwardModel.fromJson(Map<String, dynamic> json, int stscode) =>
      SapOutwardModel(
        statusCode: stscode,
        error: null,
        odataMetadata: json["odata.metadata"],
        odataEtag: json["odata.etag"],
        docEntry: json["DocEntry"],
        series: json["Series"],
        printed: json["Printed"],
        docDate: DateTime.parse(json["DocDate"]),
        dueDate: DateTime.parse(json["DueDate"]),
        cardCode: json["CardCode"],
        cardName: json["CardName"],
        address: json["Address"],
        reference1: json["Reference1"],
        // reference2: json["Reference2"],
        comments: json["Comments"] ?? '',
        // journalMemo: json["JournalMemo"],
        // priceList: json["PriceList"],
        // salesPersonCode: json["SalesPersonCode"],
        // fromWarehouse: json["FromWarehouse"],
        // toWarehouse: json["ToWarehouse"],
        // creationDate: DateTime.parse(json["CreationDate"]),
        // updateDate: DateTime.parse(json["UpdateDate"]),
        // financialPeriod: json["FinancialPeriod"],
        // transNum: json["TransNum"],
        docNum: json["DocNum"],
        // taxDate: DateTime.parse(json["TaxDate"]),
        // contactPerson: json["ContactPerson"],
        // folioPrefixString: json["FolioPrefixString"],
        // folioNumber: json["FolioNumber"],
        // docObjectCode: json["DocObjectCode"],
        // authorizationStatus: json["AuthorizationStatus"],
        // bplid: json["BPLID"],
        // bplName: json["BPLName"],
        // vatRegNum: json["VATRegNum"],
        // authorizationCode: json["AuthorizationCode"],
        // startDeliveryDate: json["StartDeliveryDate"],
        // startDeliveryTime: json["StartDeliveryTime"],
        // endDeliveryDate: json["EndDeliveryDate"],
        // endDeliveryTime: json["EndDeliveryTime"],
        // vehiclePlate: json["VehiclePlate"],
        // atDocumentType: json["ATDocumentType"],
        // eDocExportFormat: json["EDocExportFormat"],
        // elecCommStatus: json["ElecCommStatus"],
        // elecCommMessage: json["ElecCommMessage"],
        // pointOfIssueCode: json["PointOfIssueCode"],
        // letter: json["Letter"],
        // folioNumberFrom: json["FolioNumberFrom"],
        // folioNumberTo: json["FolioNumberTo"],
        // attachmentEntry: json["AttachmentEntry"],
        // documentStatus: json["DocumentStatus"],
        // shipToCode: json["ShipToCode"],
        // sapPassport: json["SAPPassport"],
        // uPurchaseType: json["U_Purchase_Type"],
        // uApApprove: json["U_AP_Approve"],
        // uFinalDel: json["U_Final_Del"],
        // uIncoTerms: json["U_Inco_Terms"],
        // uSourceDest: json["U_Source_Dest"],
        // uTransNo: json["U_Trans_NO"],
        // uVehicleNo: json["U_Vehicle_NO"],
        // uSupplierDt: json["U_Supplier_DT"],
        // uQuotNo: json["U_QuotNo"],
        // uQuotDate: json["U_QuotDate"],
        // uGovPermit: json["U_GovPermit"],
        // uGovPermitdt: json["U_GovPermitdt"],
        // uCheckNo: json["U_CheckNo"],
        // uCheckDate: json["U_CheckDate"],
        // uApprovalDate: json["U_ApprovalDate"],
        // uOrderNoRecd: json["U_OrderNoRecd"],
        // uOrderDate: json["U_OrderDate"],
        // uClearingAgent: json["U_ClearingAgent"],
        // uDateSubAgent: json["U_DateSubAgent"],
        // uIdfno: json["U_IDFNO"],
        // uIdfDate: json["U_IDFDate"],
        // uInspectionNo: json["U_InspectionNo"],
        // uEta: json["U_ETA"],
        // uAirwayBillNo: json["U_AirwayBillNo"],
        // uBol: json["U_BOL"],
        // uCotecna: json["U_Cotecna"],
        // uArrivalDate: json["U_ArrivalDate"],
        // uDahacoAgentFees: json["U_DahacoAgentFees"],
        // uPortCharges: json["U_PortCharges"],
        // uOtherExp: json["U_OtherExp"],
        // uClearCharges: json["U_ClearCharges"],
        // uHiddenChrges: json["U_HiddenChrges"],
        // uGoodsInspBy: json["U_GoodsInspBy"],
        // uGoodsReport: json["U_GoodsReport"],
        // uPymtStatus: json["U_PymtStatus"],
        // uPymtType: json["U_PymtType"],
        // uTtCopyImage: json["U_TTCopyImage"],
        // uPfiImage: json["U_PFI_Image"],
        // uSupplierImage: json["U_Supplier_Image"],
        // uBolImage: json["U_BOL_Image"],
        // uOrderType: json["U_Order_Type"],
        // uTruckInternal: json["U_Truck_Internal"],
        // uGpApproval: json["U_GP_Approval"],
        // uSupplierName: json["U_SUPPLIER_NAME"],
        // uVatNumber: json["U_VAT_NUMBER"],
        // uTransferType: json["U_Transfer_Type"],
        // uSalesOrder: json["U_Sales_Order"],
        // uReceived: json["U_Received"],
        // uDriverName: json["U_Driver_Name"],
        // uReserveInvoice: json["U_Reserve_Invoice"],
        // uRefSeries: json["U_Ref_Series"],
        // uReceivedTime: json["U_Received_Time"],
        // uSkuBatchNo: json["U_SKU_Batch_No"],
        // uInwardNo: json["U_Inward_No"],
        // uDispatchTime: json["U_Dispatch_Time"],
        // uReceivedDate: json["U_Received_Date"],
        // uExpiryDate: json["U_Expiry_Date"],
        // uCnType: json["U_CN_Type"],
        // uTinNo: json["U_TinNO"],
        // uLpoNo: json["U_LPONo"],
        // uOrderQty: json["U_OrderQty"],
        // uDispatchDate: json["U_Dispatch_Date"],
        // uBranch: json["U_Branch"],
        // uSalAppEntry: json["U_SalAppEntry"],
        // uDocType: json["U_DocType"],
        // uIntKey: json["U_IntKey"],
        // uQrFileLoc: json["U_QRFileLoc"],
        // uRctCde: json["U_rctCde"],
        // uZno: json["U_Zno"],
        // uVfdIn: json["U_VfdIn"],
        // uQrPath: json["U_QRPath"],
        // uQrValue: json["U_QRValue"],
        // uIdate: json["U_idate"],
        // uItime: json["U_itime"],
        // uDeviceCode: json["U_DeviceCode"],
        // uDeviceTransId: json["U_DeviceTransID"],
        // uRvc: json["U_RVC"],
        // uVrn: json["U_VRN"],
        // uLongitude: json["U_longitude"],
        // uLatitude: json["U_latitude"],
        // uAuditJobGroup: json["U_AUDIT_JOB_GROUP"],
        // uAuditName: json["U_AUDIT_NAME"],
        // uRequest: json["U_Request"],
        // stockTransferApprovalRequests: List<dynamic>.from(json["StockTransfer_ApprovalRequests"].map((x) => x)),
        // electronicProtocols: List<dynamic>.from(json["ElectronicProtocols"].map((x) => x)),
        stockTransferLines: List<StockTransferLine>.from(
            json["StockTransferLines"]
                .map((x) => StockTransferLine.fromJson(x))),
        // stockTransferTaxExtension: StockTransferTaxExtension.fromJson(json["StockTransferTaxExtension"]),
        // documentReferences: List<dynamic>.from(json["DocumentReferences"].map((x) => x)),
      );
  factory SapOutwardModel.issue(Map<String, dynamic> json, int statuscode) {
    return SapOutwardModel(
      statusCode: statuscode,
      odataMetadata: '',
      odataEtag: '',
      docEntry: 0,
      printed: "",
      cardCode: '',
      cardName: '',
      comments: '',
      address: '',
      reference1: '',
      stockTransferLines: [],
      error: ErrorModel.fromJson(json['error']),
      docDate: null,
      dueDate: null,
      series: 0,
      docNum: 0,
    );
  }
  Map<String, dynamic> toJson() => {
        "odata.metadata": odataMetadata,
        "odata.etag": odataEtag,
        "DocEntry": docEntry,
        "Series": series,
        "Printed": printed,
        "DocDate":
            "${docDate!.year.toString().padLeft(4, '0')}-${docDate!.month.toString().padLeft(2, '0')}-${docDate!.day.toString().padLeft(2, '0')}",
        "DueDate":
            "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
        "CardCode": cardCode,
        "CardName": cardName,
        "Address": address,
        "Reference1": reference1,
        // "Reference2": reference2,
        "Comments": comments,
        // "JournalMemo": journalMemo,
        // "PriceList": priceList,
        // "SalesPersonCode": salesPersonCode,
        // "FromWarehouse": fromWarehouse,
        // "ToWarehouse": toWarehouse,
        // "CreationDate": "${creationDate.year.toString().padLeft(4, '0')}-${creationDate.month.toString().padLeft(2, '0')}-${creationDate.day.toString().padLeft(2, '0')}",
        // "UpdateDate": "${updateDate.year.toString().padLeft(4, '0')}-${updateDate.month.toString().padLeft(2, '0')}-${updateDate.day.toString().padLeft(2, '0')}",
        // "FinancialPeriod": financialPeriod,
        // "TransNum": transNum,
        "DocNum": docNum,
        // "TaxDate": "${taxDate.year.toString().padLeft(4, '0')}-${taxDate.month.toString().padLeft(2, '0')}-${taxDate.day.toString().padLeft(2, '0')}",
        // "ContactPerson": contactPerson,
        // "FolioPrefixString": folioPrefixString,
        // "FolioNumber": folioNumber,
        // "DocObjectCode": docObjectCode,
        // "AuthorizationStatus": authorizationStatus,
        // "BPLID": bplid,
        // "BPLName": bplName,
        // "VATRegNum": vatRegNum,
        // "AuthorizationCode": authorizationCode,
        // "StartDeliveryDate": startDeliveryDate,
        // "StartDeliveryTime": startDeliveryTime,
        // "EndDeliveryDate": endDeliveryDate,
        // "EndDeliveryTime": endDeliveryTime,
        // "VehiclePlate": vehiclePlate,
        // "ATDocumentType": atDocumentType,
        // "EDocExportFormat": eDocExportFormat,
        // "ElecCommStatus": elecCommStatus,
        // "ElecCommMessage": elecCommMessage,
        // "PointOfIssueCode": pointOfIssueCode,
        // "Letter": letter,
        // "FolioNumberFrom": folioNumberFrom,
        // "FolioNumberTo": folioNumberTo,
        // "AttachmentEntry": attachmentEntry,
        // "DocumentStatus": documentStatus,
        // "ShipToCode": shipToCode,
        // "SAPPassport": sapPassport,
        // "U_Purchase_Type": uPurchaseType,
        // "U_AP_Approve": uApApprove,
        // "U_Final_Del": uFinalDel,
        // "U_Inco_Terms": uIncoTerms,
        // "U_Source_Dest": uSourceDest,
        // "U_Trans_NO": uTransNo,
        // "U_Vehicle_NO": uVehicleNo,
        // "U_Supplier_DT": uSupplierDt,
        // "U_QuotNo": uQuotNo,
        // "U_QuotDate": uQuotDate,
        // "U_GovPermit": uGovPermit,
        // "U_GovPermitdt": uGovPermitdt,
        // "U_CheckNo": uCheckNo,
        // "U_CheckDate": uCheckDate,
        // "U_ApprovalDate": uApprovalDate,
        // "U_OrderNoRecd": uOrderNoRecd,
        // "U_OrderDate": uOrderDate,
        // "U_ClearingAgent": uClearingAgent,
        // "U_DateSubAgent": uDateSubAgent,
        // "U_IDFNO": uIdfno,
        // "U_IDFDate": uIdfDate,
        // "U_InspectionNo": uInspectionNo,
        // "U_ETA": uEta,
        // "U_AirwayBillNo": uAirwayBillNo,
        // "U_BOL": uBol,
        // "U_Cotecna": uCotecna,
        // "U_ArrivalDate": uArrivalDate,
        // "U_DahacoAgentFees": uDahacoAgentFees,
        // "U_PortCharges": uPortCharges,
        // "U_OtherExp": uOtherExp,
        // "U_ClearCharges": uClearCharges,
        // "U_HiddenChrges": uHiddenChrges,
        // "U_GoodsInspBy": uGoodsInspBy,
        // "U_GoodsReport": uGoodsReport,
        // "U_PymtStatus": uPymtStatus,
        // "U_PymtType": uPymtType,
        // "U_TTCopyImage": uTtCopyImage,
        // "U_PFI_Image": uPfiImage,
        // "U_Supplier_Image": uSupplierImage,
        // "U_BOL_Image": uBolImage,
        // "U_Order_Type": uOrderType,
        // "U_Truck_Internal": uTruckInternal,
        // "U_GP_Approval": uGpApproval,
        // "U_SUPPLIER_NAME": uSupplierName,
        // "U_VAT_NUMBER": uVatNumber,
        // "U_Transfer_Type": uTransferType,
        // "U_Sales_Order": uSalesOrder,
        // "U_Received": uReceived,
        // "U_Driver_Name": uDriverName,
        // "U_Reserve_Invoice": uReserveInvoice,
        // "U_Ref_Series": uRefSeries,
        // "U_Received_Time": uReceivedTime,
        // "U_SKU_Batch_No": uSkuBatchNo,
        // "U_Inward_No": uInwardNo,
        // "U_Dispatch_Time": uDispatchTime,
        // "U_Received_Date": uReceivedDate,
        // "U_Expiry_Date": uExpiryDate,
        // "U_CN_Type": uCnType,
        // "U_TinNO": uTinNo,
        // "U_LPONo": uLpoNo,
        // "U_OrderQty": uOrderQty,
        // "U_Dispatch_Date": uDispatchDate,
        // "U_Branch": uBranch,
        // "U_SalAppEntry": uSalAppEntry,
        // "U_DocType": uDocType,
        // "U_IntKey": uIntKey,
        // "U_QRFileLoc": uQrFileLoc,
        // "U_rctCde": uRctCde,
        // "U_Zno": uZno,
        // "U_VfdIn": uVfdIn,
        // "U_QRPath": uQrPath,
        // "U_QRValue": uQrValue,
        // "U_idate": uIdate,
        // "U_itime": uItime,
        // "U_DeviceCode": uDeviceCode,
        // "U_DeviceTransID": uDeviceTransId,
        // "U_RVC": uRvc,
        // "U_VRN": uVrn,
        // "U_longitude": uLongitude,
        // "U_latitude": uLatitude,
        // "U_AUDIT_JOB_GROUP": uAuditJobGroup,
        // "U_AUDIT_NAME": uAuditName,
        // "U_Request": uRequest,
        // "StockTransfer_ApprovalRequests": List<dynamic>.from(stockTransferApprovalRequests.map((x) => x)),
        // "ElectronicProtocols": List<dynamic>.from(electronicProtocols.map((x) => x)),
        "StockTransferLines":
            List<dynamic>.from(stockTransferLines.map((x) => x.toJson())),
        // "StockTransferTaxExtension": stockTransferTaxExtension.toJson(),
        // "DocumentReferences": List<dynamic>.from(documentReferences.map((x) => x)),
      };
}

class StockTransferLine {
  int lineNum;
  int docEntry;
  String itemCode;
  String itemDescription;
  double quantity;
  double price;
  String currency;
  double rate;
  double discountPercent;
  // String vendorNum;
  // dynamic serialNumber;
  // String warehouseCode;
  // String fromWarehouseCode;
  // String projectCode;
  // double factor;
  // double factor2;
  // double factor3;
  // double factor4;
  // dynamic distributionRule;
  // dynamic distributionRule2;
  // dynamic distributionRule3;
  // dynamic distributionRule4;
  // dynamic distributionRule5;
  // String useBaseUnits;
  // String measureUnit;
  // double unitsOfMeasurment;
  // String baseType;
  // dynamic baseLine;
  // dynamic baseEntry;
  // double unitPrice;
  // double uoMEntry;
  // String uoMCode;
  // int inventoryQuantity;
  // double remainingOpenQuantity;
  // double remainingOpenInventoryQuantity;
  String lineStatus;
  // double uQtyOrdered;
  // double? uOpenQty;
  // double uTonnage;
  // double uPackSize;
  // dynamic uProfitCentre;
  // dynamic uNumberDrums;
  // dynamic uDrumSize;
  // dynamic uPails;
  // dynamic uCartons;
  // dynamic uLooseTins;
  // dynamic uNettWt;
  // dynamic uGrossWt;
  // dynamic uAppLinId;
  // dynamic uMuQty;
  // dynamic uRvc;
  // dynamic uVrn;
  // List<dynamic> serialNumbers;
  // List<dynamic> batchNumbers;
  // List<dynamic> ccdNumbers;
  // List<dynamic> stockTransferLinesBinAllocations;

  StockTransferLine({
    required this.lineNum,
    required this.docEntry,
    required this.itemCode,
    required this.itemDescription,
    required this.quantity,
    required this.price,
    required this.currency,
    required this.rate,
    required this.discountPercent,
    // required this.vendorNum,
    // required this.serialNumber,
    // required this.warehouseCode,
    // required this.fromWarehouseCode,
    // required this.projectCode,
    // required this.factor,
    // required this.factor2,
    // required this.factor3,
    // required this.factor4,
    // required this.distributionRule,
    // required this.distributionRule2,
    // required this.distributionRule3,
    // required this.distributionRule4,
    // required this.distributionRule5,
    // required this.useBaseUnits,
    // required this.measureUnit,
    // required this.unitsOfMeasurment,
    // required this.baseType,
    // required this.baseLine,
    // required this.baseEntry,
    // required this.unitPrice,
    // required this.uoMEntry,
    // required this.uoMCode,
    // required this.inventoryQuantity,
    // required this.remainingOpenQuantity,
    // required this.remainingOpenInventoryQuantity,
    required this.lineStatus,
    // required this.uQtyOrdered,
    // required this.uOpenQty,
    // required this.uTonnage,
    // required this.uPackSize,
    // required this.uProfitCentre,
    // required this.uNumberDrums,
    // required this.uDrumSize,
    // required this.uPails,
    // required this.uCartons,
    // required this.uLooseTins,
    // required this.uNettWt,
    // required this.uGrossWt,
    // required this.uAppLinId,
    // required this.uMuQty,
    // required this.uRvc,
    // required this.uVrn,
    // required this.serialNumbers,
    // required this.batchNumbers,
    // required this.ccdNumbers,
    // required this.stockTransferLinesBinAllocations,
  });

  factory StockTransferLine.fromJson(Map<String, dynamic> json) =>
      StockTransferLine(
        lineNum: json["LineNum"],
        docEntry: json["DocEntry"],
        itemCode: json["ItemCode"],
        itemDescription: json["ItemDescription"],
        quantity: json["Quantity"],
        price: json["Price"]?.toDouble(),
        currency: json["Currency"],
        rate: json["Rate"],
        discountPercent: json["DiscountPercent"],
        // vendorNum: json["VendorNum"],
        // serialNumber: json["SerialNumber"],
        // warehouseCode: json["WarehouseCode"],
        // fromWarehouseCode: json["FromWarehouseCode"],
        // projectCode: json["ProjectCode"],
        // factor: json["Factor"],
        // factor2: json["Factor2"],
        // factor3: json["Factor3"],
        // factor4: json["Factor4"],
        // distributionRule: json["DistributionRule"],
        // distributionRule2: json["DistributionRule2"],
        // distributionRule3: json["DistributionRule3"],
        // distributionRule4: json["DistributionRule4"],
        // distributionRule5: json["DistributionRule5"],
        // useBaseUnits: json["UseBaseUnits"],
        // measureUnit: json["MeasureUnit"],
        // unitsOfMeasurment: json["UnitsOfMeasurment"],
        // baseType: json["BaseType"],
        // baseLine: json["BaseLine"],
        // baseEntry: json["BaseEntry"],
        // unitPrice: json["UnitPrice"]?.toDouble(),
        // uoMEntry: json["UoMEntry"],
        // uoMCode: json["UoMCode"],
        // inventoryQuantity: json["InventoryQuantity"],
        // remainingOpenQuantity: json["RemainingOpenQuantity"],
        // remainingOpenInventoryQuantity: json["RemainingOpenInventoryQuantity"],
        lineStatus: json["LineStatus"],
        // uQtyOrdered: json["U_Qty_Ordered"],
        // uOpenQty: json["U_Open_Qty"],
        // uTonnage: json["U_Tonnage"],
        // uPackSize: json["U_PackSize"]?.toDouble(),
        // uProfitCentre: json["U_Profit_Centre"],
        // uNumberDrums: json["U_Number_Drums"],
        // uDrumSize: json["U_Drum_Size"],
        // uPails: json["U_Pails"],
        // uCartons: json["U_Cartons"],
        // uLooseTins: json["U_Loose_Tins"],
        // uNettWt: json["U_Nett_Wt"],
        // uGrossWt: json["U_Gross_Wt"],
        // uAppLinId: json["U_AppLinId"],
        // uMuQty: json["U_MUQty"],
        // uRvc: json["U_RVC"],
        // uVrn: json["U_VRN"],
        // serialNumbers: List<dynamic>.from(json["SerialNumbers"].map((x) => x)),
        // batchNumbers: List<dynamic>.from(json["BatchNumbers"].map((x) => x)),
        // ccdNumbers: List<dynamic>.from(json["CCDNumbers"].map((x) => x)),
        // stockTransferLinesBinAllocations: List<dynamic>.from(
        //     json["StockTransferLinesBinAllocations"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "LineNum": lineNum,
        "DocEntry": docEntry,
        "ItemCode": itemCode,
        "ItemDescription": itemDescription,
        "Quantity": quantity,
        "Price": price,
        "Currency": currency,
        "Rate": rate,
        "DiscountPercent": discountPercent,
        // "VendorNum": vendorNum,
        // "SerialNumber": serialNumber,
        // "WarehouseCode": warehouseCode,
        // "FromWarehouseCode": fromWarehouseCode,
        // "ProjectCode": projectCode,
        // "Factor": factor,
        // "Factor2": factor2,
        // "Factor3": factor3,
        // "Factor4": factor4,
        // "DistributionRule": distributionRule,
        // "DistributionRule2": distributionRule2,
        // "DistributionRule3": distributionRule3,
        // "DistributionRule4": distributionRule4,
        // "DistributionRule5": distributionRule5,
        // "UseBaseUnits": useBaseUnits,
        // "MeasureUnit": measureUnit,
        // "UnitsOfMeasurment": unitsOfMeasurment,
        // "BaseType": baseType,
        // "BaseLine": baseLine,
        // "BaseEntry": baseEntry,
        // "UnitPrice": unitPrice,
        // "UoMEntry": uoMEntry,
        // "UoMCode": uoMCode,
        // "InventoryQuantity": inventoryQuantity,
        // "RemainingOpenQuantity": remainingOpenQuantity,
        // "RemainingOpenInventoryQuantity": remainingOpenInventoryQuantity,
        // "LineStatus": lineStatus,
        // "U_Qty_Ordered": uQtyOrdered,
        // "U_Open_Qty": uOpenQty,
        // "U_Tonnage": uTonnage,
        // "U_PackSize": uPackSize,
        // "U_Profit_Centre": uProfitCentre,
        // "U_Number_Drums": uNumberDrums,
        // "U_Drum_Size": uDrumSize,
        // "U_Pails": uPails,
        // "U_Cartons": uCartons,
        // "U_Loose_Tins": uLooseTins,
        // "U_Nett_Wt": uNettWt,
        // "U_Gross_Wt": uGrossWt,
        // "U_AppLinId": uAppLinId,
        // "U_MUQty": uMuQty,
        // "U_RVC": uRvc,
        // "U_VRN": uVrn,
        // "SerialNumbers": List<dynamic>.from(serialNumbers.map((x) => x)),
        // "BatchNumbers": List<dynamic>.from(batchNumbers.map((x) => x)),
        // "CCDNumbers": List<dynamic>.from(ccdNumbers.map((x) => x)),
        // "StockTransferLinesBinAllocations":
        //     List<dynamic>.from(stockTransferLinesBinAllocations.map((x) => x)),
      };
}

class StockTransferTaxExtension {
  String supportVat;
  dynamic formNumber;
  dynamic transactionCategory;

  StockTransferTaxExtension({
    required this.supportVat,
    required this.formNumber,
    required this.transactionCategory,
  });

  factory StockTransferTaxExtension.fromJson(Map<String, dynamic> json) =>
      StockTransferTaxExtension(
        supportVat: json["SupportVAT"],
        formNumber: json["FormNumber"],
        transactionCategory: json["TransactionCategory"],
      );

  Map<String, dynamic> toJson() => {
        "SupportVAT": supportVat,
        "FormNumber": formNumber,
        "TransactionCategory": transactionCategory,
      };
}
