// To parse this JSON data, do
//
//     final getOrderDetails = getOrderDetailsFromJson(jsonString);

// GetOrderDetails getOrderDetailsFromJson(String str) =>
//     GetOrderDetails.fromJson(json.decode(str));

// String getOrderDetailsToJson(GetOrderDetails data) =>
//     json.encode(data.toJson());

class GetOrderDetails {
  int? statusCode;
  String? error;
  String? odataMetadata;
  String? odataEtag;
  int? docEntry;
  int? docNum;
  String? docType;
  String? handWritten;
  String? printed;
  DateTime? docDate;
  DateTime? docDueDate;
  String? cardCode;
  String? cardName;
  String? address;
  String? numAtCard;
  double? docTotal;
  dynamic attachmentEntry;
  String? docCurrency;
  int? docRate;
  String? reference1;
  dynamic reference2;
  String? comments;
  String? journalMemo;
  int? paymentGroupCode;
  String? docTime;
  int? salesPersonCode;
  int? transportationCode;
  String? confirmed;
  dynamic importFileNum;
  String? summeryType;
  int? contactPersonCode;
  String? showScn;
  int? series;
  String? taxDate;
  String? partialSupply;
  String? docObjectCode;
  String? shipToCode;
  dynamic indicator;
  dynamic federalTaxId;
  int? discountPercent;
  dynamic paymentReference;
  String? creationDate;
  String? updateDate;
  int? financialPeriod;
  int? userSign;
  dynamic transNum;
  double? vatSum;
  double? vatSumSys;
  int? vatSumFc;
  String? netProcedure;
  int? docTotalFc;
  double? docTotalSys;
  dynamic form1099;
  dynamic box1099;
  String? revisionPo;
  String? requriedDate;
  String? cancelDate;
  String? blockDunning;
  String? submitted;
  int? segment;
  String? pickStatus;
  String? pick;
  dynamic paymentMethod;
  String? paymentBlock;
  dynamic paymentBlockEntry;
  dynamic centralBankIndicator;
  String? maximumCashDiscount;
  String? reserve;
  dynamic project;
  dynamic exemptionValidityDateFrom;
  dynamic exemptionValidityDateTo;
  String? wareHouseUpdateType;
  String? rounding;
  dynamic externalCorrectedDocNum;
  dynamic internalCorrectedDocNum;
  dynamic nextCorrectingDocument;
  String? deferredTax;
  dynamic taxExemptionLetterNum;
  int? wtApplied;
  int? wtAppliedFc;
  String? billOfExchangeReserved;
  dynamic agentCode;
  int? wtAppliedSc;
  int? totalEqualizationTax;
  int? totalEqualizationTaxFc;
  int? totalEqualizationTaxSc;
  int? numberOfInstallments;
  String? applyTaxOnFirstInstallment;
  String? taxOnInstallments;
  int? wtNonSubjectAmount;
  int? wtNonSubjectAmountSc;
  int? wtNonSubjectAmountFc;
  int? wtExemptedAmount;
  int? wtExemptedAmountSc;
  int? wtExemptedAmountFc;
  int? baseAmount;
  int? baseAmountSc;
  int? baseAmountFc;
  int? wtAmount;
  int? wtAmountSc;
  int? wtAmountFc;
  dynamic vatDate;
  dynamic documentsOwner;
  dynamic folioPrefixString;
  dynamic folioNumber;
  String? documentSubType;
  dynamic bpChannelCode;
  dynamic bpChannelContact;
  String? address2;
  String? documentStatus;
  String? periodIndicator;
  String? payToCode;
  dynamic manualNumber;
  String? useShpdGoodsAct;
  String? isPayToBank;
  dynamic payToBankCountry;
  dynamic payToBankCode;
  dynamic payToBankAccountNo;
  dynamic payToBankBranch;
  dynamic bplIdAssignedToInvoice;
  int? downPayment;
  String? reserveInvoice;
  int? languageCode;
  dynamic trackingNumber;
  dynamic pickRemark;
  dynamic closingDate;
  dynamic sequenceCode;
  dynamic sequenceSerial;
  dynamic seriesString;
  dynamic subSeriesString;
  String? sequenceModel;
  String? useCorrectionVatGroup;
  int? totalDiscount;
  int? downPaymentAmount;
  int? downPaymentPercentage;
  String? downPaymentType;
  int? downPaymentAmountSc;
  int? downPaymentAmountFc;
  int? vatPercent;
  int? serviceGrossProfitPercent;
  dynamic openingRemarks;
  dynamic closingRemarks;
  // int roundingDiffAmount;
  // int roundingDiffAmountFc;
  // int roundingDiffAmountSc;
  String? cancelled;
  dynamic signatureInputMessage;
  dynamic signatureDigest;
  dynamic certificationNumber;
  dynamic privateKeyVersion;
  String? controlAccount;
  String? insuranceOperation347;
  String? archiveNonremovableSalesQuotation;
  dynamic gtsChecker;
  dynamic gtsPayee;
  int? extraMonth;
  int? extraDays;
  int? cashDiscountDateOffset;
  String? startFrom;
  String? ntsApproved;
  dynamic eTaxWebSite;
  dynamic eTaxNumber;
  dynamic ntsApprovedNumber;
  String? eDocGenerationType;
  dynamic eDocSeries;
  dynamic eDocNum;
  dynamic eDocExportFormat;
  String? eDocStatus;
  dynamic eDocErrorCode;
  dynamic eDocErrorMessage;
  String? downPaymentStatus;
  dynamic groupSeries;
  dynamic groupNumber;
  String? groupHandWritten;
  dynamic reopenOriginalDocument;
  dynamic reopenManuallyClosedOrCanceledDocument;
  String? createOnlineQuotation;
  dynamic posEquipmentNumber;
  dynamic posManufacturerSerialNumber;
  dynamic posCashierNumber;
  String? applyCurrentVatRatesForDownPaymentsToDraw;
  String? closingOption;
  dynamic specifiedClosingDate;
  String? openForLandedCosts;
  String? authorizationStatus;
  int? totalDiscountFc;
  int? totalDiscountSc;
  String? relevantToGts;
  dynamic bplName;
  dynamic vatRegNum;
  dynamic annualInvoiceDeclarationReference;
  dynamic supplier;
  dynamic releaser;
  dynamic receiver;
  dynamic blanketAgreementNumber;
  String? isAlteration;
  String? cancelStatus;
  dynamic assetValueDate;
  String? documentDelivery;
  dynamic authorizationCode;
  dynamic startDeliveryDate;
  dynamic startDeliveryTime;
  dynamic endDeliveryDate;
  dynamic endDeliveryTime;
  dynamic vehiclePlate;
  dynamic atDocumentType;
  dynamic elecCommStatus;
  dynamic elecCommMessage;
  String? reuseDocumentNum;
  String? reuseNotaFiscalNum;
  String? printSepaDirect;
  dynamic fiscalDocNum;
  dynamic posDailySummaryNo;
  dynamic posReceiptNo;
  dynamic pointOfIssueCode;
  dynamic letter;
  dynamic folioNumberFrom;
  dynamic folioNumberTo;
  String? interimType;
  int? relatedType;
  dynamic relatedEntry;
  dynamic sapPassport;
  dynamic documentTaxId;
  dynamic dateOfReportingControlStatementVat;
  dynamic reportingSectionControlStatementVat;
  String? excludeFromTaxReportControlStatementVat;
  dynamic posCashRegister;
  String? updateTime;
  dynamic createQrCodeFrom;
  dynamic priceMode;
  String? shipFrom;
  String? commissionTrade;
  String? commissionTradeReturn;
  String? useBillToAddrToDetermineTax;
  dynamic cig;
  dynamic cup;
  dynamic fatherCard;
  String? fatherType;
  dynamic shipState;
  dynamic shipPlace;
  dynamic custOffice;
  dynamic fci;
  dynamic addLegIn;
  dynamic legTextF;
  dynamic danfeLgTxt;
  String? indFinal;
  int? dataVersion;
  dynamic lastPageFolioNumber;
  String? inventoryStatus;
  String? plasticPackagingTaxRelevant;
  String? notRelevantForMonthlyInvoice;
  String? uPurchaseType;
  String? uApApprove;
  String? uFinalDel;
  dynamic uIncoTerms;
  dynamic uSourceDest;
  dynamic uTransNo;
  dynamic uVehicleNo;
  dynamic uSupplierDt;
  dynamic uQuotNo;
  dynamic uQuotDate;
  String? uGovPermit;
  dynamic uGovPermitdt;
  dynamic uCheckNo;
  dynamic uCheckDate;
  dynamic uApprovalDate;
  dynamic uOrderNoRecd;
  String? uOrderDate;
  dynamic uClearingAgent;
  dynamic uDateSubAgent;
  dynamic uIdfno;
  dynamic uIdfDate;
  dynamic uInspectionNo;
  dynamic uEta;
  dynamic uAirwayBillNo;
  dynamic uBol;
  dynamic uCotecna;
  dynamic uArrivalDate;
  int? uDahacoAgentFees;
  int? uPortCharges;
  int? uOtherExp;
  int? uClearCharges;
  int? uHiddenChrges;
  dynamic uGoodsInspBy;
  dynamic uGoodsReport;
  dynamic uPymtStatus;
  dynamic uPymtType;
  dynamic uTtCopyImage;
  dynamic uPfiImage;
  dynamic uSupplierImage;
  dynamic uBolImage;
  dynamic uOrderType;
  String? uTruckInternal;
  String? uGpApproval;
  dynamic uSupplierName;
  dynamic uVatNumber;
  String? uTransferType;
  dynamic uSalesOrder;
  String? uReceived;
  dynamic uDriverName;
  dynamic uReserveInvoice;
  dynamic uRefSeries;
  String? uReceivedTime;
  dynamic uSkuBatchNo;
  dynamic uInwardNo;
  dynamic uDispatchTime;
  dynamic uReceivedDate;
  dynamic uExpiryDate;
  String? uCnType;
  dynamic uTinNo;
  dynamic uLpoNo;
  double? uOrderQty;
  dynamic uDispatchDate;
  dynamic uBranch;
  dynamic uSalAppEntry;
  int? uDocType;
  dynamic uIntKey;
  dynamic uQrFileLoc;
  dynamic uRctCde;
  dynamic uZno;
  dynamic uVfdIn;
  dynamic uQrPath;
  dynamic uQrValue;
  dynamic uIdate;
  dynamic uItime;
  String? uDeviceCode;
  String? uDeviceTransId;
  dynamic uRvc;
  dynamic uVrn;
  String? uLongitude;
  dynamic uLatitude;
  dynamic uAuditJobGroup;
  dynamic uAuditName;
  dynamic uRequest;
  dynamic uPdcNo;
  dynamic uLineId;
  dynamic uGatePassNo;
  dynamic uRvt;
  dynamic uReqWhs;
  List<dynamic>? documentApprovalRequests;
  List<DocumentOrderLine>? documentLines;
  List<dynamic>? electronicProtocols;
  List<dynamic>? documentAdditionalExpenses;
  List<dynamic>? withholdingTaxDataWtxCollection;
  List<dynamic>? withholdingTaxDataCollection;
  List<dynamic>? documentSpecialLines;
  TaxExtension? taxExtension;
  AddressExtension? addressExtension;
  List<dynamic>? documentReferences;

  GetOrderDetails({
    this.statusCode,
    this.error,
    this.odataMetadata,
    this.odataEtag,
    this.docEntry,
    this.docNum,
    this.docType,
    this.handWritten,
    this.printed,
    this.docDate,
    this.docDueDate,
    this.cardCode,
    this.cardName,
    this.address,
    this.numAtCard,
    this.docTotal,
    this.attachmentEntry,
    this.docCurrency,
    this.docRate,
    this.reference1,
    this.reference2,
    this.comments,
    this.journalMemo,
    this.paymentGroupCode,
    this.docTime,
    this.salesPersonCode,
    this.transportationCode,
    this.confirmed,
    this.importFileNum,
    this.summeryType,
    this.contactPersonCode,
    this.showScn,
    this.series,
    this.taxDate,
    this.partialSupply,
    this.docObjectCode,
    this.shipToCode,
    this.indicator,
    this.federalTaxId,
    this.discountPercent,
    this.paymentReference,
    this.creationDate,
    this.updateDate,
    this.financialPeriod,
    this.userSign,
    this.transNum,
    this.vatSum,
    this.vatSumSys,
    this.vatSumFc,
    this.netProcedure,
    this.docTotalFc,
    this.docTotalSys,
    this.form1099,
    this.box1099,
    this.revisionPo,
    this.requriedDate,
    this.cancelDate,
    this.blockDunning,
    this.submitted,
    this.segment,
    this.pickStatus,
    this.pick,
    this.paymentMethod,
    this.paymentBlock,
    this.paymentBlockEntry,
    this.centralBankIndicator,
    this.maximumCashDiscount,
    this.reserve,
    this.project,
    this.exemptionValidityDateFrom,
    this.exemptionValidityDateTo,
    this.wareHouseUpdateType,
    this.rounding,
    this.externalCorrectedDocNum,
    this.internalCorrectedDocNum,
    this.nextCorrectingDocument,
    this.deferredTax,
    this.taxExemptionLetterNum,
    this.wtApplied,
    this.wtAppliedFc,
    this.billOfExchangeReserved,
    this.agentCode,
    this.wtAppliedSc,
    this.totalEqualizationTax,
    this.totalEqualizationTaxFc,
    this.totalEqualizationTaxSc,
    this.numberOfInstallments,
    this.applyTaxOnFirstInstallment,
    this.taxOnInstallments,
    this.wtNonSubjectAmount,
    this.wtNonSubjectAmountSc,
    this.wtNonSubjectAmountFc,
    this.wtExemptedAmount,
    this.wtExemptedAmountSc,
    this.wtExemptedAmountFc,
    this.baseAmount,
    this.baseAmountSc,
    this.baseAmountFc,
    this.wtAmount,
    this.wtAmountSc,
    this.wtAmountFc,
    this.vatDate,
    this.documentsOwner,
    this.folioPrefixString,
    this.folioNumber,
    this.documentSubType,
    this.bpChannelCode,
    this.bpChannelContact,
    this.address2,
    this.documentStatus,
    this.periodIndicator,
    this.payToCode,
    this.manualNumber,
    this.useShpdGoodsAct,
    this.isPayToBank,
    this.payToBankCountry,
    this.payToBankCode,
    this.payToBankAccountNo,
    this.payToBankBranch,
    this.bplIdAssignedToInvoice,
    this.downPayment,
    this.reserveInvoice,
    this.languageCode,
    this.trackingNumber,
    this.pickRemark,
    this.closingDate,
    this.sequenceCode,
    this.sequenceSerial,
    this.seriesString,
    this.subSeriesString,
    this.sequenceModel,
    this.useCorrectionVatGroup,
    this.totalDiscount,
    this.downPaymentAmount,
    this.downPaymentPercentage,
    this.downPaymentType,
    this.downPaymentAmountSc,
    this.downPaymentAmountFc,
    this.vatPercent,
    this.serviceGrossProfitPercent,
    this.openingRemarks,
    this.closingRemarks,
    // this.roundingDiffAmount,
    // this.roundingDiffAmountFc,
    // this.roundingDiffAmountSc,
    this.cancelled,
    this.signatureInputMessage,
    this.signatureDigest,
    this.certificationNumber,
    this.privateKeyVersion,
    this.controlAccount,
    this.insuranceOperation347,
    this.archiveNonremovableSalesQuotation,
    this.gtsChecker,
    this.gtsPayee,
    this.extraMonth,
    this.extraDays,
    this.cashDiscountDateOffset,
    this.startFrom,
    this.ntsApproved,
    this.eTaxWebSite,
    this.eTaxNumber,
    this.ntsApprovedNumber,
    this.eDocGenerationType,
    this.eDocSeries,
    this.eDocNum,
    this.eDocExportFormat,
    this.eDocStatus,
    this.eDocErrorCode,
    this.eDocErrorMessage,
    this.downPaymentStatus,
    this.groupSeries,
    this.groupNumber,
    this.groupHandWritten,
    this.reopenOriginalDocument,
    this.reopenManuallyClosedOrCanceledDocument,
    this.createOnlineQuotation,
    this.posEquipmentNumber,
    this.posManufacturerSerialNumber,
    this.posCashierNumber,
    this.applyCurrentVatRatesForDownPaymentsToDraw,
    this.closingOption,
    this.specifiedClosingDate,
    this.openForLandedCosts,
    this.authorizationStatus,
    this.totalDiscountFc,
    this.totalDiscountSc,
    this.relevantToGts,
    this.bplName,
    this.vatRegNum,
    this.annualInvoiceDeclarationReference,
    this.supplier,
    this.releaser,
    this.receiver,
    this.blanketAgreementNumber,
    this.isAlteration,
    this.cancelStatus,
    this.assetValueDate,
    this.documentDelivery,
    this.authorizationCode,
    this.startDeliveryDate,
    this.startDeliveryTime,
    this.endDeliveryDate,
    this.endDeliveryTime,
    this.vehiclePlate,
    this.atDocumentType,
    this.elecCommStatus,
    this.elecCommMessage,
    this.reuseDocumentNum,
    this.reuseNotaFiscalNum,
    this.printSepaDirect,
    this.fiscalDocNum,
    this.posDailySummaryNo,
    this.posReceiptNo,
    this.pointOfIssueCode,
    this.letter,
    this.folioNumberFrom,
    this.folioNumberTo,
    this.interimType,
    this.relatedType,
    this.relatedEntry,
    this.sapPassport,
    this.documentTaxId,
    this.dateOfReportingControlStatementVat,
    this.reportingSectionControlStatementVat,
    this.excludeFromTaxReportControlStatementVat,
    this.posCashRegister,
    this.updateTime,
    this.createQrCodeFrom,
    this.priceMode,
    this.shipFrom,
    this.commissionTrade,
    this.commissionTradeReturn,
    this.useBillToAddrToDetermineTax,
    this.cig,
    this.cup,
    this.fatherCard,
    this.fatherType,
    this.shipState,
    this.shipPlace,
    this.custOffice,
    this.fci,
    this.addLegIn,
    this.legTextF,
    this.danfeLgTxt,
    this.indFinal,
    this.dataVersion,
    this.lastPageFolioNumber,
    this.inventoryStatus,
    this.plasticPackagingTaxRelevant,
    this.notRelevantForMonthlyInvoice,
    this.uPurchaseType,
    this.uApApprove,
    this.uFinalDel,
    this.uIncoTerms,
    this.uSourceDest,
    this.uTransNo,
    this.uVehicleNo,
    this.uSupplierDt,
    this.uQuotNo,
    this.uQuotDate,
    this.uGovPermit,
    this.uGovPermitdt,
    this.uCheckNo,
    this.uCheckDate,
    this.uApprovalDate,
    this.uOrderNoRecd,
    this.uOrderDate,
    this.uClearingAgent,
    this.uDateSubAgent,
    this.uIdfno,
    this.uIdfDate,
    this.uInspectionNo,
    this.uEta,
    this.uAirwayBillNo,
    this.uBol,
    this.uCotecna,
    this.uArrivalDate,
    this.uDahacoAgentFees,
    this.uPortCharges,
    this.uOtherExp,
    this.uClearCharges,
    this.uHiddenChrges,
    this.uGoodsInspBy,
    this.uGoodsReport,
    this.uPymtStatus,
    this.uPymtType,
    this.uTtCopyImage,
    this.uPfiImage,
    this.uSupplierImage,
    this.uBolImage,
    this.uOrderType,
    this.uTruckInternal,
    this.uGpApproval,
    this.uSupplierName,
    this.uVatNumber,
    this.uTransferType,
    this.uSalesOrder,
    this.uReceived,
    this.uDriverName,
    this.uReserveInvoice,
    this.uRefSeries,
    this.uReceivedTime,
    this.uSkuBatchNo,
    this.uInwardNo,
    this.uDispatchTime,
    this.uReceivedDate,
    this.uExpiryDate,
    this.uCnType,
    this.uTinNo,
    this.uLpoNo,
    this.uOrderQty,
    this.uDispatchDate,
    this.uBranch,
    this.uSalAppEntry,
    this.uDocType,
    this.uIntKey,
    this.uQrFileLoc,
    this.uRctCde,
    this.uZno,
    this.uVfdIn,
    this.uQrPath,
    this.uQrValue,
    this.uIdate,
    this.uItime,
    this.uDeviceCode,
    this.uDeviceTransId,
    this.uRvc,
    this.uVrn,
    this.uLongitude,
    this.uLatitude,
    this.uAuditJobGroup,
    this.uAuditName,
    this.uRequest,
    this.uPdcNo,
    this.uLineId,
    this.uGatePassNo,
    this.uRvt,
    this.uReqWhs,
    this.documentApprovalRequests,
    this.documentLines,
    this.electronicProtocols,
    this.documentAdditionalExpenses,
    this.withholdingTaxDataWtxCollection,
    this.withholdingTaxDataCollection,
    this.documentSpecialLines,
    this.taxExtension,
    this.addressExtension,
    this.documentReferences,
  });

  factory GetOrderDetails.fromJson(Map<String, dynamic> json, int statusCode) =>
      GetOrderDetails(
        statusCode: statusCode,
        odataMetadata: json["odata.metadata"],
        odataEtag: json["odata.etag"],
        docEntry: json["DocEntry"],
        docNum: json["DocNum"],
        docType: json["DocType"],
        handWritten: json["HandWritten"],
        printed: json["Printed"],
        docDate: DateTime.parse(json["DocDate"]),
        docDueDate: DateTime.parse(json["DocDueDate"]),
        cardCode: json["CardCode"],
        cardName: json["CardName"],
        address: json["Address"],
        numAtCard: json["NumAtCard"],
        docTotal: json["DocTotal"]?.toDouble(),
        attachmentEntry: json["AttachmentEntry"],
        docCurrency: json["DocCurrency"],
        docRate: json["DocRate"],
        reference1: json["Reference1"],
        reference2: json["Reference2"],
        comments: json["Comments"],
        journalMemo: json["JournalMemo"],
        paymentGroupCode: json["PaymentGroupCode"],
        docTime: json["DocTime"],
        salesPersonCode: json["SalesPersonCode"],
        transportationCode: json["TransportationCode"],
        confirmed: json["Confirmed"],
        importFileNum: json["ImportFileNum"],
        summeryType: json["SummeryType"],
        contactPersonCode: json["ContactPersonCode"],
        showScn: json["ShowSCN"],
        series: json["Series"],
        taxDate: json["TaxDate"].toString(),
        partialSupply: json["PartialSupply"],
        docObjectCode: json["DocObjectCode"],
        shipToCode: json["ShipToCode"],
        indicator: json["Indicator"],
        federalTaxId: json["FederalTaxID"],
        discountPercent: json["DiscountPercent"],
        paymentReference: json["PaymentReference"],
        creationDate: (json["CreationDate"]),
        updateDate: (json["UpdateDate"]),
        financialPeriod: json["FinancialPeriod"],
        userSign: json["UserSign"],
        transNum: json["TransNum"],
        vatSum: json["VatSum"]?.toDouble(),
        vatSumSys: json["VatSumSys"]?.toDouble(),
        vatSumFc: json["VatSumFc"],
        netProcedure: json["NetProcedure"],
        docTotalFc: json["DocTotalFc"],
        docTotalSys: json["DocTotalSys"]?.toDouble(),
        form1099: json["Form1099"],
        box1099: json["Box1099"],
        revisionPo: json["RevisionPo"],
        requriedDate: json["RequriedDate"].toString(),
        cancelDate: json["CancelDate"].toString(),
        blockDunning: json["BlockDunning"],
        submitted: json["Submitted"],
        segment: json["Segment"],
        pickStatus: json["PickStatus"],
        pick: json["Pick"],
        paymentMethod: json["PaymentMethod"],
        paymentBlock: json["PaymentBlock"],
        paymentBlockEntry: json["PaymentBlockEntry"],
        centralBankIndicator: json["CentralBankIndicator"],
        maximumCashDiscount: json["MaximumCashDiscount"],
        reserve: json["Reserve"],
        project: json["Project"],
        exemptionValidityDateFrom: json["ExemptionValidityDateFrom"],
        exemptionValidityDateTo: json["ExemptionValidityDateTo"],
        wareHouseUpdateType: json["WareHouseUpdateType"],
        rounding: json["Rounding"],
        externalCorrectedDocNum: json["ExternalCorrectedDocNum"],
        internalCorrectedDocNum: json["InternalCorrectedDocNum"],
        nextCorrectingDocument: json["NextCorrectingDocument"],
        deferredTax: json["DeferredTax"],
        taxExemptionLetterNum: json["TaxExemptionLetterNum"],
        wtApplied: json["WTApplied"],
        wtAppliedFc: json["WTAppliedFC"],
        billOfExchangeReserved: json["BillOfExchangeReserved"],
        agentCode: json["AgentCode"],
        wtAppliedSc: json["WTAppliedSC"],
        totalEqualizationTax: json["TotalEqualizationTax"],
        totalEqualizationTaxFc: json["TotalEqualizationTaxFC"],
        totalEqualizationTaxSc: json["TotalEqualizationTaxSC"],
        numberOfInstallments: json["NumberOfInstallments"],
        applyTaxOnFirstInstallment: json["ApplyTaxOnFirstInstallment"],
        taxOnInstallments: json["TaxOnInstallments"],
        wtNonSubjectAmount: json["WTNonSubjectAmount"],
        wtNonSubjectAmountSc: json["WTNonSubjectAmountSC"],
        wtNonSubjectAmountFc: json["WTNonSubjectAmountFC"],
        wtExemptedAmount: json["WTExemptedAmount"],
        wtExemptedAmountSc: json["WTExemptedAmountSC"],
        wtExemptedAmountFc: json["WTExemptedAmountFC"],
        baseAmount: json["BaseAmount"],
        baseAmountSc: json["BaseAmountSC"],
        baseAmountFc: json["BaseAmountFC"],
        wtAmount: json["WTAmount"],
        wtAmountSc: json["WTAmountSC"],
        wtAmountFc: json["WTAmountFC"],
        vatDate: json["VatDate"],
        documentsOwner: json["DocumentsOwner"],
        folioPrefixString: json["FolioPrefixString"],
        folioNumber: json["FolioNumber"],
        documentSubType: json["DocumentSubType"],
        bpChannelCode: json["BPChannelCode"],
        bpChannelContact: json["BPChannelContact"],
        address2: json["Address2"],
        documentStatus: json["DocumentStatus"],
        periodIndicator: json["PeriodIndicator"],
        payToCode: json["PayToCode"],
        manualNumber: json["ManualNumber"],
        useShpdGoodsAct: json["UseShpdGoodsAct"],
        isPayToBank: json["IsPayToBank"],
        payToBankCountry: json["PayToBankCountry"],
        payToBankCode: json["PayToBankCode"],
        payToBankAccountNo: json["PayToBankAccountNo"],
        payToBankBranch: json["PayToBankBranch"],
        bplIdAssignedToInvoice: json["BPL_IDAssignedToInvoice"],
        downPayment: json["DownPayment"],
        reserveInvoice: json["ReserveInvoice"],
        languageCode: json["LanguageCode"],
        trackingNumber: json["TrackingNumber"],
        pickRemark: json["PickRemark"],
        closingDate: json["ClosingDate"],
        sequenceCode: json["SequenceCode"],
        sequenceSerial: json["SequenceSerial"],
        seriesString: json["SeriesString"],
        subSeriesString: json["SubSeriesString"],
        sequenceModel: json["SequenceModel"],
        useCorrectionVatGroup: json["UseCorrectionVATGroup"],
        totalDiscount: json["TotalDiscount"],
        downPaymentAmount: json["DownPaymentAmount"],
        downPaymentPercentage: json["DownPaymentPercentage"],
        downPaymentType: json["DownPaymentType"],
        downPaymentAmountSc: json["DownPaymentAmountSC"],
        downPaymentAmountFc: json["DownPaymentAmountFC"],
        vatPercent: json["VatPercent"],
        serviceGrossProfitPercent: json["ServiceGrossProfitPercent"],
        openingRemarks: json["OpeningRemarks"],
        closingRemarks: json["ClosingRemarks"],
        // roundingDiffAmount: json["RoundingDiffAmount"],
        // roundingDiffAmountFc: json["RoundingDiffAmountFC"],
        // roundingDiffAmountSc: json["RoundingDiffAmountSC"],
        cancelled: json["Cancelled"],
        signatureInputMessage: json["SignatureInputMessage"],
        signatureDigest: json["SignatureDigest"],
        certificationNumber: json["CertificationNumber"],
        privateKeyVersion: json["PrivateKeyVersion"],
        controlAccount: json["ControlAccount"],
        insuranceOperation347: json["InsuranceOperation347"],
        archiveNonremovableSalesQuotation:
            json["ArchiveNonremovableSalesQuotation"],
        gtsChecker: json["GTSChecker"],
        gtsPayee: json["GTSPayee"],
        extraMonth: json["ExtraMonth"],
        extraDays: json["ExtraDays"],
        cashDiscountDateOffset: json["CashDiscountDateOffset"],
        startFrom: json["StartFrom"],
        ntsApproved: json["NTSApproved"],
        eTaxWebSite: json["ETaxWebSite"],
        eTaxNumber: json["ETaxNumber"],
        ntsApprovedNumber: json["NTSApprovedNumber"],
        eDocGenerationType: json["EDocGenerationType"],
        eDocSeries: json["EDocSeries"],
        eDocNum: json["EDocNum"],
        eDocExportFormat: json["EDocExportFormat"],
        eDocStatus: json["EDocStatus"],
        eDocErrorCode: json["EDocErrorCode"],
        eDocErrorMessage: json["EDocErrorMessage"],
        downPaymentStatus: json["DownPaymentStatus"],
        groupSeries: json["GroupSeries"],
        groupNumber: json["GroupNumber"],
        groupHandWritten: json["GroupHandWritten"],
        reopenOriginalDocument: json["ReopenOriginalDocument"],
        reopenManuallyClosedOrCanceledDocument:
            json["ReopenManuallyClosedOrCanceledDocument"],
        createOnlineQuotation: json["CreateOnlineQuotation"],
        posEquipmentNumber: json["POSEquipmentNumber"],
        posManufacturerSerialNumber: json["POSManufacturerSerialNumber"],
        posCashierNumber: json["POSCashierNumber"],
        applyCurrentVatRatesForDownPaymentsToDraw:
            json["ApplyCurrentVATRatesForDownPaymentsToDraw"],
        closingOption: json["ClosingOption"],
        specifiedClosingDate: json["SpecifiedClosingDate"],
        openForLandedCosts: json["OpenForLandedCosts"],
        authorizationStatus: json["AuthorizationStatus"],
        totalDiscountFc: json["TotalDiscountFC"],
        totalDiscountSc: json["TotalDiscountSC"],
        relevantToGts: json["RelevantToGTS"],
        bplName: json["BPLName"],
        vatRegNum: json["VATRegNum"],
        annualInvoiceDeclarationReference:
            json["AnnualInvoiceDeclarationReference"],
        supplier: json["Supplier"],
        releaser: json["Releaser"],
        receiver: json["Receiver"],
        blanketAgreementNumber: json["BlanketAgreementNumber"],
        isAlteration: json["IsAlteration"],
        cancelStatus: json["CancelStatus"],
        assetValueDate: json["AssetValueDate"],
        documentDelivery: json["DocumentDelivery"],
        authorizationCode: json["AuthorizationCode"],
        startDeliveryDate: json["StartDeliveryDate"],
        startDeliveryTime: json["StartDeliveryTime"],
        endDeliveryDate: json["EndDeliveryDate"],
        endDeliveryTime: json["EndDeliveryTime"],
        vehiclePlate: json["VehiclePlate"],
        atDocumentType: json["ATDocumentType"],
        elecCommStatus: json["ElecCommStatus"],
        elecCommMessage: json["ElecCommMessage"],
        reuseDocumentNum: json["ReuseDocumentNum"],
        reuseNotaFiscalNum: json["ReuseNotaFiscalNum"],
        printSepaDirect: json["PrintSEPADirect"],
        fiscalDocNum: json["FiscalDocNum"],
        posDailySummaryNo: json["POSDailySummaryNo"],
        posReceiptNo: json["POSReceiptNo"],
        pointOfIssueCode: json["PointOfIssueCode"],
        letter: json["Letter"],
        folioNumberFrom: json["FolioNumberFrom"],
        folioNumberTo: json["FolioNumberTo"],
        interimType: json["InterimType"],
        relatedType: json["RelatedType"],
        relatedEntry: json["RelatedEntry"],
        sapPassport: json["SAPPassport"],
        documentTaxId: json["DocumentTaxID"],
        dateOfReportingControlStatementVat:
            json["DateOfReportingControlStatementVAT"],
        reportingSectionControlStatementVat:
            json["ReportingSectionControlStatementVAT"],
        excludeFromTaxReportControlStatementVat:
            json["ExcludeFromTaxReportControlStatementVAT"],
        posCashRegister: json["POS_CashRegister"],
        updateTime: json["UpdateTime"],
        createQrCodeFrom: json["CreateQRCodeFrom"],
        priceMode: json["PriceMode"],
        shipFrom: json["ShipFrom"],
        commissionTrade: json["CommissionTrade"],
        commissionTradeReturn: json["CommissionTradeReturn"],
        useBillToAddrToDetermineTax: json["UseBillToAddrToDetermineTax"],
        cig: json["Cig"],
        cup: json["Cup"],
        fatherCard: json["FatherCard"],
        fatherType: json["FatherType"],
        shipState: json["ShipState"],
        shipPlace: json["ShipPlace"],
        custOffice: json["CustOffice"],
        fci: json["FCI"],
        addLegIn: json["AddLegIn"],
        legTextF: json["LegTextF"],
        danfeLgTxt: json["DANFELgTxt"],
        indFinal: json["IndFinal"],
        dataVersion: json["DataVersion"],
        lastPageFolioNumber: json["LastPageFolioNumber"],
        inventoryStatus: json["InventoryStatus"],
        plasticPackagingTaxRelevant: json["PlasticPackagingTaxRelevant"],
        notRelevantForMonthlyInvoice: json["NotRelevantForMonthlyInvoice"],
        uPurchaseType: json["U_Purchase_Type"],
        uApApprove: json["U_AP_Approve"],
        uFinalDel: json["U_Final_Del"],
        uIncoTerms: json["U_Inco_Terms"],
        uSourceDest: json["U_Source_Dest"],
        uTransNo: json["U_Trans_NO"],
        uVehicleNo: json["U_Vehicle_NO"],
        uSupplierDt: json["U_Supplier_DT"],
        uQuotNo: json["U_QuotNo"],
        uQuotDate: json["U_QuotDate"],
        uGovPermit: json["U_GovPermit"],
        uGovPermitdt: json["U_GovPermitdt"],
        uCheckNo: json["U_CheckNo"],
        uCheckDate: json["U_CheckDate"],
        uApprovalDate: json["U_ApprovalDate"],
        uOrderNoRecd: json["U_OrderNoRecd"],
        uOrderDate: json["U_OrderDate"].toString(),
        uClearingAgent: json["U_ClearingAgent"],
        uDateSubAgent: json["U_DateSubAgent"],
        uIdfno: json["U_IDFNO"],
        uIdfDate: json["U_IDFDate"],
        uInspectionNo: json["U_InspectionNo"],
        uEta: json["U_ETA"],
        uAirwayBillNo: json["U_AirwayBillNo"],
        uBol: json["U_BOL"],
        uCotecna: json["U_Cotecna"],
        uArrivalDate: json["U_ArrivalDate"],
        uDahacoAgentFees: json["U_DahacoAgentFees"],
        uPortCharges: json["U_PortCharges"],
        uOtherExp: json["U_OtherExp"],
        uClearCharges: json["U_ClearCharges"],
        uHiddenChrges: json["U_HiddenChrges"],
        uGoodsInspBy: json["U_GoodsInspBy"],
        uGoodsReport: json["U_GoodsReport"],
        uPymtStatus: json["U_PymtStatus"],
        uPymtType: json["U_PymtType"],
        uTtCopyImage: json["U_TTCopyImage"],
        uPfiImage: json["U_PFI_Image"],
        uSupplierImage: json["U_Supplier_Image"],
        uBolImage: json["U_BOL_Image"],
        uOrderType: json["U_Order_Type"],
        uTruckInternal: json["U_Truck_Internal"],
        uGpApproval: json["U_GP_Approval"],
        uSupplierName: json["U_SUPPLIER_NAME"],
        uVatNumber: json["U_VAT_NUMBER"],
        uTransferType: json["U_Transfer_Type"],
        uSalesOrder: json["U_Sales_Order"],
        uReceived: json["U_Received"],
        uDriverName: json["U_Driver_Name"],
        uReserveInvoice: json["U_Reserve_Invoice"],
        uRefSeries: json["U_Ref_Series"],
        uReceivedTime: json["U_Received_Time"],
        uSkuBatchNo: json["U_SKU_Batch_No"],
        uInwardNo: json["U_Inward_No"],
        uDispatchTime: json["U_Dispatch_Time"],
        uReceivedDate: json["U_Received_Date"],
        uExpiryDate: json["U_Expiry_Date"],
        uCnType: json["U_CN_Type"],
        uTinNo: json["U_TinNO"],
        uLpoNo: json["U_LPONo"],
        uOrderQty: json["U_OrderQty"]?.toDouble(),
        uDispatchDate: json["U_Dispatch_Date"],
        uBranch: json["U_Branch"],
        uSalAppEntry: json["U_SalAppEntry"],
        uDocType: json["U_DocType"],
        uIntKey: json["U_IntKey"],
        uQrFileLoc: json["U_QRFileLoc"],
        uRctCde: json["U_rctCde"],
        uZno: json["U_Zno"],
        uVfdIn: json["U_VfdIn"],
        uQrPath: json["U_QRPath"],
        uQrValue: json["U_QRValue"],
        uIdate: json["U_idate"],
        uItime: json["U_itime"],
        uDeviceCode: json["U_DeviceCode"],
        uDeviceTransId: json["U_DeviceTransID"],
        uRvc: json["U_RVC"],
        uVrn: json["U_VRN"],
        uLongitude: json["U_longitude"],
        uLatitude: json["U_latitude"],
        uAuditJobGroup: json["U_AUDIT_JOB_GROUP"],
        uAuditName: json["U_AUDIT_NAME"],
        uRequest: json["U_Request"],
        uPdcNo: json["U_PDCNo"],
        uLineId: json["U_LineID"],
        uGatePassNo: json["U_GatePassNo"],
        uRvt: json["U_RVT"],
        uReqWhs: json["U_ReqWhs"],
        documentApprovalRequests:
            List<dynamic>.from(json["Document_ApprovalRequests"].map((x) => x)),
        documentLines: List<DocumentOrderLine>.from(
            json["DocumentLines"].map((x) => DocumentOrderLine.fromJson(x))),
        electronicProtocols:
            List<dynamic>.from(json["ElectronicProtocols"].map((x) => x)),
        documentAdditionalExpenses: List<dynamic>.from(
            json["DocumentAdditionalExpenses"].map((x) => x)),
        withholdingTaxDataWtxCollection: List<dynamic>.from(
            json["WithholdingTaxDataWTXCollection"].map((x) => x)),
        withholdingTaxDataCollection: List<dynamic>.from(
            json["WithholdingTaxDataCollection"].map((x) => x)),
        documentSpecialLines:
            List<dynamic>.from(json["DocumentSpecialLines"].map((x) => x)),
        taxExtension: TaxExtension.fromJson(json["TaxExtension"]),
        addressExtension: AddressExtension.fromJson(json["AddressExtension"]),
        documentReferences:
            List<dynamic>.from(json["DocumentReferences"].map((x) => x)),
      );
  factory GetOrderDetails.issue(String e, int statusCode) {
    return GetOrderDetails(
      error: e,
    );
  }
  Map<String, dynamic> toJson() => {
        "odata.metadata": odataMetadata,
        "odata.etag": odataEtag,
        "DocEntry": docEntry,
        "DocNum": docNum,
        "DocType": docType,
        "HandWritten": handWritten,
        "Printed": printed,
        "DocDate": docDate.toString(),
        "DocDueDate": docDueDate.toString(),
        "CardCode": cardCode,
        "CardName": cardName,
        "Address": address,
        "NumAtCard": numAtCard,
        "DocTotal": docTotal,
        "AttachmentEntry": attachmentEntry,
        "DocCurrency": docCurrency,
        "DocRate": docRate,
        "Reference1": reference1,
        "Reference2": reference2,
        "Comments": comments,
        "JournalMemo": journalMemo,
        "PaymentGroupCode": paymentGroupCode,
        "DocTime": docTime,
        "SalesPersonCode": salesPersonCode,
        "TransportationCode": transportationCode,
        "Confirmed": confirmed,
        "ImportFileNum": importFileNum,
        "SummeryType": summeryType,
        "ContactPersonCode": contactPersonCode,
        "ShowSCN": showScn,
        "Series": series,
        "TaxDate": taxDate.toString(),
        "PartialSupply": partialSupply,
        "DocObjectCode": docObjectCode,
        "ShipToCode": shipToCode,
        "Indicator": indicator,
        "FederalTaxID": federalTaxId,
        "DiscountPercent": discountPercent,
        "PaymentReference": paymentReference,
        "CreationDate": creationDate.toString(),
        "UpdateDate": updateDate.toString(),
        "FinancialPeriod": financialPeriod,
        "UserSign": userSign,
        "TransNum": transNum,
        "VatSum": vatSum,
        "VatSumSys": vatSumSys,
        "VatSumFc": vatSumFc,
        "NetProcedure": netProcedure,
        "DocTotalFc": docTotalFc,
        "DocTotalSys": docTotalSys,
        "Form1099": form1099,
        "Box1099": box1099,
        "RevisionPo": revisionPo,
        "RequriedDate": requriedDate!,
        "CancelDate": cancelDate,
        "BlockDunning": blockDunning,
        "Submitted": submitted,
        "Segment": segment,
        "PickStatus": pickStatus,
        "Pick": pick,
        "PaymentMethod": paymentMethod,
        "PaymentBlock": paymentBlock,
        "PaymentBlockEntry": paymentBlockEntry,
        "CentralBankIndicator": centralBankIndicator,
        "MaximumCashDiscount": maximumCashDiscount,
        "Reserve": reserve,
        "Project": project,
        "ExemptionValidityDateFrom": exemptionValidityDateFrom,
        "ExemptionValidityDateTo": exemptionValidityDateTo,
        "WareHouseUpdateType": wareHouseUpdateType,
        "Rounding": rounding,
        "ExternalCorrectedDocNum": externalCorrectedDocNum,
        "InternalCorrectedDocNum": internalCorrectedDocNum,
        "NextCorrectingDocument": nextCorrectingDocument,
        "DeferredTax": deferredTax,
        "TaxExemptionLetterNum": taxExemptionLetterNum,
        "WTApplied": wtApplied,
        "WTAppliedFC": wtAppliedFc,
        "BillOfExchangeReserved": billOfExchangeReserved,
        "AgentCode": agentCode,
        "WTAppliedSC": wtAppliedSc,
        "TotalEqualizationTax": totalEqualizationTax,
        "TotalEqualizationTaxFC": totalEqualizationTaxFc,
        "TotalEqualizationTaxSC": totalEqualizationTaxSc,
        "NumberOfInstallments": numberOfInstallments,
        "ApplyTaxOnFirstInstallment": applyTaxOnFirstInstallment,
        "TaxOnInstallments": taxOnInstallments,
        "WTNonSubjectAmount": wtNonSubjectAmount,
        "WTNonSubjectAmountSC": wtNonSubjectAmountSc,
        "WTNonSubjectAmountFC": wtNonSubjectAmountFc,
        "WTExemptedAmount": wtExemptedAmount,
        "WTExemptedAmountSC": wtExemptedAmountSc,
        "WTExemptedAmountFC": wtExemptedAmountFc,
        "BaseAmount": baseAmount,
        "BaseAmountSC": baseAmountSc,
        "BaseAmountFC": baseAmountFc,
        "WTAmount": wtAmount,
        "WTAmountSC": wtAmountSc,
        "WTAmountFC": wtAmountFc,
        "VatDate": vatDate,
        "DocumentsOwner": documentsOwner,
        "FolioPrefixString": folioPrefixString,
        "FolioNumber": folioNumber,
        "DocumentSubType": documentSubType,
        "BPChannelCode": bpChannelCode,
        "BPChannelContact": bpChannelContact,
        "Address2": address2,
        "DocumentStatus": documentStatus,
        "PeriodIndicator": periodIndicator,
        "PayToCode": payToCode,
        "ManualNumber": manualNumber,
        "UseShpdGoodsAct": useShpdGoodsAct,
        "IsPayToBank": isPayToBank,
        "PayToBankCountry": payToBankCountry,
        "PayToBankCode": payToBankCode,
        "PayToBankAccountNo": payToBankAccountNo,
        "PayToBankBranch": payToBankBranch,
        "BPL_IDAssignedToInvoice": bplIdAssignedToInvoice,
        "DownPayment": downPayment,
        "ReserveInvoice": reserveInvoice,
        "LanguageCode": languageCode,
        "TrackingNumber": trackingNumber,
        "PickRemark": pickRemark,
        "ClosingDate": closingDate,
        "SequenceCode": sequenceCode,
        "SequenceSerial": sequenceSerial,
        "SeriesString": seriesString,
        "SubSeriesString": subSeriesString,
        "SequenceModel": sequenceModel,
        "UseCorrectionVATGroup": useCorrectionVatGroup,
        "TotalDiscount": totalDiscount,
        "DownPaymentAmount": downPaymentAmount,
        "DownPaymentPercentage": downPaymentPercentage,
        "DownPaymentType": downPaymentType,
        "DownPaymentAmountSC": downPaymentAmountSc,
        "DownPaymentAmountFC": downPaymentAmountFc,
        "VatPercent": vatPercent,
        "ServiceGrossProfitPercent": serviceGrossProfitPercent,
        "OpeningRemarks": openingRemarks,
        "ClosingRemarks": closingRemarks,
        // "RoundingDiffAmount": roundingDiffAmount,
        // "RoundingDiffAmountFC": roundingDiffAmountFc,
        // "RoundingDiffAmountSC": roundingDiffAmountSc,
        "Cancelled": cancelled,
        "SignatureInputMessage": signatureInputMessage,
        "SignatureDigest": signatureDigest,
        "CertificationNumber": certificationNumber,
        "PrivateKeyVersion": privateKeyVersion,
        "ControlAccount": controlAccount,
        "InsuranceOperation347": insuranceOperation347,
        "ArchiveNonremovableSalesQuotation": archiveNonremovableSalesQuotation,
        "GTSChecker": gtsChecker,
        "GTSPayee": gtsPayee,
        "ExtraMonth": extraMonth,
        "ExtraDays": extraDays,
        "CashDiscountDateOffset": cashDiscountDateOffset,
        "StartFrom": startFrom,
        "NTSApproved": ntsApproved,
        "ETaxWebSite": eTaxWebSite,
        "ETaxNumber": eTaxNumber,
        "NTSApprovedNumber": ntsApprovedNumber,
        "EDocGenerationType": eDocGenerationType,
        "EDocSeries": eDocSeries,
        "EDocNum": eDocNum,
        "EDocExportFormat": eDocExportFormat,
        "EDocStatus": eDocStatus,
        "EDocErrorCode": eDocErrorCode,
        "EDocErrorMessage": eDocErrorMessage,
        "DownPaymentStatus": downPaymentStatus,
        "GroupSeries": groupSeries,
        "GroupNumber": groupNumber,
        "GroupHandWritten": groupHandWritten,
        "ReopenOriginalDocument": reopenOriginalDocument,
        "ReopenManuallyClosedOrCanceledDocument":
            reopenManuallyClosedOrCanceledDocument,
        "CreateOnlineQuotation": createOnlineQuotation,
        "POSEquipmentNumber": posEquipmentNumber,
        "POSManufacturerSerialNumber": posManufacturerSerialNumber,
        "POSCashierNumber": posCashierNumber,
        "ApplyCurrentVATRatesForDownPaymentsToDraw":
            applyCurrentVatRatesForDownPaymentsToDraw,
        "ClosingOption": closingOption,
        "SpecifiedClosingDate": specifiedClosingDate,
        "OpenForLandedCosts": openForLandedCosts,
        "AuthorizationStatus": authorizationStatus,
        "TotalDiscountFC": totalDiscountFc,
        "TotalDiscountSC": totalDiscountSc,
        "RelevantToGTS": relevantToGts,
        "BPLName": bplName,
        "VATRegNum": vatRegNum,
        "AnnualInvoiceDeclarationReference": annualInvoiceDeclarationReference,
        "Supplier": supplier,
        "Releaser": releaser,
        "Receiver": receiver,
        "BlanketAgreementNumber": blanketAgreementNumber,
        "IsAlteration": isAlteration,
        "CancelStatus": cancelStatus,
        "AssetValueDate": assetValueDate,
        "DocumentDelivery": documentDelivery,
        "AuthorizationCode": authorizationCode,
        "StartDeliveryDate": startDeliveryDate,
        "StartDeliveryTime": startDeliveryTime,
        "EndDeliveryDate": endDeliveryDate,
        "EndDeliveryTime": endDeliveryTime,
        "VehiclePlate": vehiclePlate,
        "ATDocumentType": atDocumentType,
        "ElecCommStatus": elecCommStatus,
        "ElecCommMessage": elecCommMessage,
        "ReuseDocumentNum": reuseDocumentNum,
        "ReuseNotaFiscalNum": reuseNotaFiscalNum,
        "PrintSEPADirect": printSepaDirect,
        "FiscalDocNum": fiscalDocNum,
        "POSDailySummaryNo": posDailySummaryNo,
        "POSReceiptNo": posReceiptNo,
        "PointOfIssueCode": pointOfIssueCode,
        "Letter": letter,
        "FolioNumberFrom": folioNumberFrom,
        "FolioNumberTo": folioNumberTo,
        "InterimType": interimType,
        "RelatedType": relatedType,
        "RelatedEntry": relatedEntry,
        "SAPPassport": sapPassport,
        "DocumentTaxID": documentTaxId,
        "DateOfReportingControlStatementVAT":
            dateOfReportingControlStatementVat,
        "ReportingSectionControlStatementVAT":
            reportingSectionControlStatementVat,
        "ExcludeFromTaxReportControlStatementVAT":
            excludeFromTaxReportControlStatementVat,
        "POS_CashRegister": posCashRegister,
        "UpdateTime": updateTime,
        "CreateQRCodeFrom": createQrCodeFrom,
        "PriceMode": priceMode,
        "ShipFrom": shipFrom,
        "CommissionTrade": commissionTrade,
        "CommissionTradeReturn": commissionTradeReturn,
        "UseBillToAddrToDetermineTax": useBillToAddrToDetermineTax,
        "Cig": cig,
        "Cup": cup,
        "FatherCard": fatherCard,
        "FatherType": fatherType,
        "ShipState": shipState,
        "ShipPlace": shipPlace,
        "CustOffice": custOffice,
        "FCI": fci,
        "AddLegIn": addLegIn,
        "LegTextF": legTextF,
        "DANFELgTxt": danfeLgTxt,
        "IndFinal": indFinal,
        "DataVersion": dataVersion,
        "LastPageFolioNumber": lastPageFolioNumber,
        "InventoryStatus": inventoryStatus,
        "PlasticPackagingTaxRelevant": plasticPackagingTaxRelevant,
        "NotRelevantForMonthlyInvoice": notRelevantForMonthlyInvoice,
        "U_Purchase_Type": uPurchaseType,
        "U_AP_Approve": uApApprove,
        "U_Final_Del": uFinalDel,
        "U_Inco_Terms": uIncoTerms,
        "U_Source_Dest": uSourceDest,
        "U_Trans_NO": uTransNo,
        "U_Vehicle_NO": uVehicleNo,
        "U_Supplier_DT": uSupplierDt,
        "U_QuotNo": uQuotNo,
        "U_QuotDate": uQuotDate,
        "U_GovPermit": uGovPermit,
        "U_GovPermitdt": uGovPermitdt,
        "U_CheckNo": uCheckNo,
        "U_CheckDate": uCheckDate,
        "U_ApprovalDate": uApprovalDate,
        "U_OrderNoRecd": uOrderNoRecd,
        "U_OrderDate": uOrderDate.toString(),
        "U_ClearingAgent": uClearingAgent,
        "U_DateSubAgent": uDateSubAgent,
        "U_IDFNO": uIdfno,
        "U_IDFDate": uIdfDate,
        "U_InspectionNo": uInspectionNo,
        "U_ETA": uEta,
        "U_AirwayBillNo": uAirwayBillNo,
        "U_BOL": uBol,
        "U_Cotecna": uCotecna,
        "U_ArrivalDate": uArrivalDate,
        "U_DahacoAgentFees": uDahacoAgentFees,
        "U_PortCharges": uPortCharges,
        "U_OtherExp": uOtherExp,
        "U_ClearCharges": uClearCharges,
        "U_HiddenChrges": uHiddenChrges,
        "U_GoodsInspBy": uGoodsInspBy,
        "U_GoodsReport": uGoodsReport,
        "U_PymtStatus": uPymtStatus,
        "U_PymtType": uPymtType,
        "U_TTCopyImage": uTtCopyImage,
        "U_PFI_Image": uPfiImage,
        "U_Supplier_Image": uSupplierImage,
        "U_BOL_Image": uBolImage,
        "U_Order_Type": uOrderType,
        "U_Truck_Internal": uTruckInternal,
        "U_GP_Approval": uGpApproval,
        "U_SUPPLIER_NAME": uSupplierName,
        "U_VAT_NUMBER": uVatNumber,
        "U_Transfer_Type": uTransferType,
        "U_Sales_Order": uSalesOrder,
        "U_Received": uReceived,
        "U_Driver_Name": uDriverName,
        "U_Reserve_Invoice": uReserveInvoice,
        "U_Ref_Series": uRefSeries,
        "U_Received_Time": uReceivedTime,
        "U_SKU_Batch_No": uSkuBatchNo,
        "U_Inward_No": uInwardNo,
        "U_Dispatch_Time": uDispatchTime,
        "U_Received_Date": uReceivedDate,
        "U_Expiry_Date": uExpiryDate,
        "U_CN_Type": uCnType,
        "U_TinNO": uTinNo,
        "U_LPONo": uLpoNo,
        "U_OrderQty": uOrderQty,
        "U_Dispatch_Date": uDispatchDate,
        "U_Branch": uBranch,
        "U_SalAppEntry": uSalAppEntry,
        "U_DocType": uDocType,
        "U_IntKey": uIntKey,
        "U_QRFileLoc": uQrFileLoc,
        "U_rctCde": uRctCde,
        "U_Zno": uZno,
        "U_VfdIn": uVfdIn,
        "U_QRPath": uQrPath,
        "U_QRValue": uQrValue,
        "U_idate": uIdate,
        "U_itime": uItime,
        "U_DeviceCode": uDeviceCode,
        "U_DeviceTransID": uDeviceTransId,
        "U_RVC": uRvc,
        "U_VRN": uVrn,
        "U_longitude": uLongitude,
        "U_latitude": uLatitude,
        "U_AUDIT_JOB_GROUP": uAuditJobGroup,
        "U_AUDIT_NAME": uAuditName,
        "U_Request": uRequest,
        "U_PDCNo": uPdcNo,
        "U_LineID": uLineId,
        "U_GatePassNo": uGatePassNo,
        "U_RVT": uRvt,
        "U_ReqWhs": uReqWhs,
        "Document_ApprovalRequests":
            List<dynamic>.from(documentApprovalRequests!.map((x) => x)),
        "DocumentLines":
            List<dynamic>.from(documentLines!.map((x) => x.toJson())),
        "ElectronicProtocols":
            List<dynamic>.from(electronicProtocols!.map((x) => x)),
        "DocumentAdditionalExpenses":
            List<dynamic>.from(documentAdditionalExpenses!.map((x) => x)),
        "WithholdingTaxDataWTXCollection":
            List<dynamic>.from(withholdingTaxDataWtxCollection!.map((x) => x)),
        "WithholdingTaxDataCollection":
            List<dynamic>.from(withholdingTaxDataCollection!.map((x) => x)),
        "DocumentSpecialLines":
            List<dynamic>.from(documentSpecialLines!.map((x) => x)),
        "TaxExtension": taxExtension!.toJson(),
        "AddressExtension": addressExtension!.toJson(),
        "DocumentReferences":
            List<dynamic>.from(documentReferences!.map((x) => x)),
      };
}

class AddressExtension {
  dynamic shipToStreet;
  dynamic shipToStreetNo;
  dynamic shipToBlock;
  String shipToBuilding;
  dynamic shipToCity;
  dynamic shipToZipCode;
  dynamic shipToCounty;
  dynamic shipToState;
  String shipToCountry;
  dynamic shipToAddressType;
  String billToStreet;
  dynamic billToStreetNo;
  dynamic billToBlock;
  String billToBuilding;
  String billToCity;
  dynamic billToZipCode;
  dynamic billToCounty;
  dynamic billToState;
  String billToCountry;
  dynamic billToAddressType;
  dynamic shipToGlobalLocationNumber;
  dynamic billToGlobalLocationNumber;
  dynamic shipToAddress2;
  dynamic shipToAddress3;
  dynamic billToAddress2;
  dynamic billToAddress3;
  dynamic placeOfSupply;
  dynamic purchasePlaceOfSupply;
  int docEntry;
  dynamic goodsIssuePlaceBp;
  dynamic goodsIssuePlaceCnpj;
  dynamic goodsIssuePlaceCpf;
  dynamic goodsIssuePlaceStreet;
  dynamic goodsIssuePlaceStreetNo;
  dynamic goodsIssuePlaceBuilding;
  dynamic goodsIssuePlaceZip;
  dynamic goodsIssuePlaceBlock;
  dynamic goodsIssuePlaceCity;
  dynamic goodsIssuePlaceCounty;
  dynamic goodsIssuePlaceState;
  dynamic goodsIssuePlaceCountry;
  dynamic goodsIssuePlacePhone;
  dynamic goodsIssuePlaceEMail;
  dynamic goodsIssuePlaceDepartureDate;
  dynamic deliveryPlaceBp;
  dynamic deliveryPlaceCnpj;
  dynamic deliveryPlaceCpf;
  dynamic deliveryPlaceStreet;
  dynamic deliveryPlaceStreetNo;
  dynamic deliveryPlaceBuilding;
  dynamic deliveryPlaceZip;
  dynamic deliveryPlaceBlock;
  dynamic deliveryPlaceCity;
  dynamic deliveryPlaceCounty;
  dynamic deliveryPlaceState;
  dynamic deliveryPlaceCountry;
  dynamic deliveryPlacePhone;
  dynamic deliveryPlaceEMail;
  dynamic deliveryPlaceDepartureDate;

  AddressExtension({
    required this.shipToStreet,
    required this.shipToStreetNo,
    required this.shipToBlock,
    required this.shipToBuilding,
    required this.shipToCity,
    required this.shipToZipCode,
    required this.shipToCounty,
    required this.shipToState,
    required this.shipToCountry,
    required this.shipToAddressType,
    required this.billToStreet,
    required this.billToStreetNo,
    required this.billToBlock,
    required this.billToBuilding,
    required this.billToCity,
    required this.billToZipCode,
    required this.billToCounty,
    required this.billToState,
    required this.billToCountry,
    required this.billToAddressType,
    required this.shipToGlobalLocationNumber,
    required this.billToGlobalLocationNumber,
    required this.shipToAddress2,
    required this.shipToAddress3,
    required this.billToAddress2,
    required this.billToAddress3,
    required this.placeOfSupply,
    required this.purchasePlaceOfSupply,
    required this.docEntry,
    required this.goodsIssuePlaceBp,
    required this.goodsIssuePlaceCnpj,
    required this.goodsIssuePlaceCpf,
    required this.goodsIssuePlaceStreet,
    required this.goodsIssuePlaceStreetNo,
    required this.goodsIssuePlaceBuilding,
    required this.goodsIssuePlaceZip,
    required this.goodsIssuePlaceBlock,
    required this.goodsIssuePlaceCity,
    required this.goodsIssuePlaceCounty,
    required this.goodsIssuePlaceState,
    required this.goodsIssuePlaceCountry,
    required this.goodsIssuePlacePhone,
    required this.goodsIssuePlaceEMail,
    required this.goodsIssuePlaceDepartureDate,
    required this.deliveryPlaceBp,
    required this.deliveryPlaceCnpj,
    required this.deliveryPlaceCpf,
    required this.deliveryPlaceStreet,
    required this.deliveryPlaceStreetNo,
    required this.deliveryPlaceBuilding,
    required this.deliveryPlaceZip,
    required this.deliveryPlaceBlock,
    required this.deliveryPlaceCity,
    required this.deliveryPlaceCounty,
    required this.deliveryPlaceState,
    required this.deliveryPlaceCountry,
    required this.deliveryPlacePhone,
    required this.deliveryPlaceEMail,
    required this.deliveryPlaceDepartureDate,
  });

  factory AddressExtension.fromJson(Map<String, dynamic> json) =>
      AddressExtension(
        shipToStreet: json["ShipToStreet"],
        shipToStreetNo: json["ShipToStreetNo"],
        shipToBlock: json["ShipToBlock"],
        shipToBuilding: json["ShipToBuilding"],
        shipToCity: json["ShipToCity"],
        shipToZipCode: json["ShipToZipCode"],
        shipToCounty: json["ShipToCounty"],
        shipToState: json["ShipToState"],
        shipToCountry: json["ShipToCountry"],
        shipToAddressType: json["ShipToAddressType"],
        billToStreet: json["BillToStreet"],
        billToStreetNo: json["BillToStreetNo"],
        billToBlock: json["BillToBlock"],
        billToBuilding: json["BillToBuilding"],
        billToCity: json["BillToCity"],
        billToZipCode: json["BillToZipCode"],
        billToCounty: json["BillToCounty"],
        billToState: json["BillToState"],
        billToCountry: json["BillToCountry"],
        billToAddressType: json["BillToAddressType"],
        shipToGlobalLocationNumber: json["ShipToGlobalLocationNumber"],
        billToGlobalLocationNumber: json["BillToGlobalLocationNumber"],
        shipToAddress2: json["ShipToAddress2"],
        shipToAddress3: json["ShipToAddress3"],
        billToAddress2: json["BillToAddress2"],
        billToAddress3: json["BillToAddress3"],
        placeOfSupply: json["PlaceOfSupply"],
        purchasePlaceOfSupply: json["PurchasePlaceOfSupply"],
        docEntry: json["DocEntry"],
        goodsIssuePlaceBp: json["GoodsIssuePlaceBP"],
        goodsIssuePlaceCnpj: json["GoodsIssuePlaceCNPJ"],
        goodsIssuePlaceCpf: json["GoodsIssuePlaceCPF"],
        goodsIssuePlaceStreet: json["GoodsIssuePlaceStreet"],
        goodsIssuePlaceStreetNo: json["GoodsIssuePlaceStreetNo"],
        goodsIssuePlaceBuilding: json["GoodsIssuePlaceBuilding"],
        goodsIssuePlaceZip: json["GoodsIssuePlaceZip"],
        goodsIssuePlaceBlock: json["GoodsIssuePlaceBlock"],
        goodsIssuePlaceCity: json["GoodsIssuePlaceCity"],
        goodsIssuePlaceCounty: json["GoodsIssuePlaceCounty"],
        goodsIssuePlaceState: json["GoodsIssuePlaceState"],
        goodsIssuePlaceCountry: json["GoodsIssuePlaceCountry"],
        goodsIssuePlacePhone: json["GoodsIssuePlacePhone"],
        goodsIssuePlaceEMail: json["GoodsIssuePlaceEMail"],
        goodsIssuePlaceDepartureDate: json["GoodsIssuePlaceDepartureDate"],
        deliveryPlaceBp: json["DeliveryPlaceBP"],
        deliveryPlaceCnpj: json["DeliveryPlaceCNPJ"],
        deliveryPlaceCpf: json["DeliveryPlaceCPF"],
        deliveryPlaceStreet: json["DeliveryPlaceStreet"],
        deliveryPlaceStreetNo: json["DeliveryPlaceStreetNo"],
        deliveryPlaceBuilding: json["DeliveryPlaceBuilding"],
        deliveryPlaceZip: json["DeliveryPlaceZip"],
        deliveryPlaceBlock: json["DeliveryPlaceBlock"],
        deliveryPlaceCity: json["DeliveryPlaceCity"],
        deliveryPlaceCounty: json["DeliveryPlaceCounty"],
        deliveryPlaceState: json["DeliveryPlaceState"],
        deliveryPlaceCountry: json["DeliveryPlaceCountry"],
        deliveryPlacePhone: json["DeliveryPlacePhone"],
        deliveryPlaceEMail: json["DeliveryPlaceEMail"],
        deliveryPlaceDepartureDate: json["DeliveryPlaceDepartureDate"],
      );

  Map<String, dynamic> toJson() => {
        "ShipToStreet": shipToStreet,
        "ShipToStreetNo": shipToStreetNo,
        "ShipToBlock": shipToBlock,
        "ShipToBuilding": shipToBuilding,
        "ShipToCity": shipToCity,
        "ShipToZipCode": shipToZipCode,
        "ShipToCounty": shipToCounty,
        "ShipToState": shipToState,
        "ShipToCountry": shipToCountry,
        "ShipToAddressType": shipToAddressType,
        "BillToStreet": billToStreet,
        "BillToStreetNo": billToStreetNo,
        "BillToBlock": billToBlock,
        "BillToBuilding": billToBuilding,
        "BillToCity": billToCity,
        "BillToZipCode": billToZipCode,
        "BillToCounty": billToCounty,
        "BillToState": billToState,
        "BillToCountry": billToCountry,
        "BillToAddressType": billToAddressType,
        "ShipToGlobalLocationNumber": shipToGlobalLocationNumber,
        "BillToGlobalLocationNumber": billToGlobalLocationNumber,
        "ShipToAddress2": shipToAddress2,
        "ShipToAddress3": shipToAddress3,
        "BillToAddress2": billToAddress2,
        "BillToAddress3": billToAddress3,
        "PlaceOfSupply": placeOfSupply,
        "PurchasePlaceOfSupply": purchasePlaceOfSupply,
        "DocEntry": docEntry,
        "GoodsIssuePlaceBP": goodsIssuePlaceBp,
        "GoodsIssuePlaceCNPJ": goodsIssuePlaceCnpj,
        "GoodsIssuePlaceCPF": goodsIssuePlaceCpf,
        "GoodsIssuePlaceStreet": goodsIssuePlaceStreet,
        "GoodsIssuePlaceStreetNo": goodsIssuePlaceStreetNo,
        "GoodsIssuePlaceBuilding": goodsIssuePlaceBuilding,
        "GoodsIssuePlaceZip": goodsIssuePlaceZip,
        "GoodsIssuePlaceBlock": goodsIssuePlaceBlock,
        "GoodsIssuePlaceCity": goodsIssuePlaceCity,
        "GoodsIssuePlaceCounty": goodsIssuePlaceCounty,
        "GoodsIssuePlaceState": goodsIssuePlaceState,
        "GoodsIssuePlaceCountry": goodsIssuePlaceCountry,
        "GoodsIssuePlacePhone": goodsIssuePlacePhone,
        "GoodsIssuePlaceEMail": goodsIssuePlaceEMail,
        "GoodsIssuePlaceDepartureDate": goodsIssuePlaceDepartureDate,
        "DeliveryPlaceBP": deliveryPlaceBp,
        "DeliveryPlaceCNPJ": deliveryPlaceCnpj,
        "DeliveryPlaceCPF": deliveryPlaceCpf,
        "DeliveryPlaceStreet": deliveryPlaceStreet,
        "DeliveryPlaceStreetNo": deliveryPlaceStreetNo,
        "DeliveryPlaceBuilding": deliveryPlaceBuilding,
        "DeliveryPlaceZip": deliveryPlaceZip,
        "DeliveryPlaceBlock": deliveryPlaceBlock,
        "DeliveryPlaceCity": deliveryPlaceCity,
        "DeliveryPlaceCounty": deliveryPlaceCounty,
        "DeliveryPlaceState": deliveryPlaceState,
        "DeliveryPlaceCountry": deliveryPlaceCountry,
        "DeliveryPlacePhone": deliveryPlacePhone,
        "DeliveryPlaceEMail": deliveryPlaceEMail,
        "DeliveryPlaceDepartureDate": deliveryPlaceDepartureDate,
      };
}

class DocumentOrderLine {
  int lineNum;
  String itemCode;
  String itemDescription;
  double quantity;
  DateTime shipDate;
  double price;
  double priceAfterVat;
  String currency;
  int rate;
  double discountPercent;
  dynamic vendorNum;
  dynamic serialNum;
  String warehouseCode;
  int salesPersonCode;
  int commisionPercent;
  String treeType;
  String accountCode;
  String useBaseUnits;
  dynamic supplierCatNum;
  String costingCode;
  String projectCode;
  dynamic barCode;
  String vatGroup;
  int height1;
  dynamic hight1Unit;
  int height2;
  dynamic height2Unit;
  int lengh1;
  dynamic lengh1Unit;
  int lengh2;
  dynamic lengh2Unit;
  int weight1;
  dynamic weight1Unit;
  int weight2;
  dynamic weight2Unit;
  int factor1;
  int factor2;
  int factor3;
  int factor4;
  int baseType;
  dynamic baseEntry;
  dynamic baseLine;
  int volume;
  int volumeUnit;
  int width1;
  dynamic width1Unit;
  int width2;
  dynamic width2Unit;
  String address;
  String taxCode;
  String taxType;
  String taxLiable;
  String pickStatus;
  int pickQuantity;
  dynamic pickListIdNumber;
  dynamic originalItem;
  String backOrder;
  dynamic freeText;
  int shippingMethod;
  dynamic poTargetNum;
  dynamic poTargetEntry;
  dynamic poTargetRowNum;
  String correctionInvoiceItem;
  int corrInvAmountToStock;
  int corrInvAmountToDiffAcct;
  int appliedTax;
  int appliedTaxFc;
  int appliedTaxSc;
  String wtLiable;
  String deferredTax;
  int equalizationTaxPercent;
  int totalEqualizationTax;
  int totalEqualizationTaxFc;
  int totalEqualizationTaxSc;
  double netTaxAmount;
  int netTaxAmountFc;
  double netTaxAmountSc;
  String measureUnit;
  int unitsOfMeasurment;
  double lineTotal;
  int taxPercentagePerRow;
  double taxTotal;
  String consumerSalesForecast;
  int exciseAmount;
  int taxPerUnit;
  int totalInclTax;
  dynamic countryOrg;
  dynamic sww;
  dynamic transactionType;
  String distributeExpense;
  int rowTotalFc;
  double rowTotalSc;
  int lastBuyInmPrice;
  int lastBuyDistributeSumFc;
  int lastBuyDistributeSumSc;
  int lastBuyDistributeSum;
  int stockDistributesumForeign;
  int stockDistributesumSystem;
  int stockDistributesum;
  int stockInmPrice;
  String pickStatusEx;
  int taxBeforeDpm;
  int taxBeforeDpmfc;
  int taxBeforeDpmsc;
  dynamic cfopCode;
  dynamic cstCode;
  dynamic usage;
  String taxOnly;
  int visualOrder;
  int baseOpenQuantity;
  double unitPrice;
  String lineStatus;
  int packageQuantity;
  dynamic text;
  String lineType;
  String cogsCostingCode;
  String cogsAccountCode;
  String changeAssemlyBoMWarehouse;
  int grossBuyPrice;
  int grossBase;
  int grossProfitTotalBasePrice;
  dynamic costingCode2;
  dynamic costingCode3;
  dynamic costingCode4;
  dynamic costingCode5;
  dynamic itemDetails;
  dynamic locationCode;
  dynamic actualDeliveryDate;
  double remainingOpenQuantity;
  double openAmount;
  int openAmountFc;
  double openAmountSc;
  dynamic exLineNo;
  dynamic requiredDate;
  int requiredQuantity;
  dynamic cogsCostingCode2;
  dynamic cogsCostingCode3;
  dynamic cogsCostingCode4;
  dynamic cogsCostingCode5;
  dynamic csTforIpi;
  dynamic csTforPis;
  dynamic csTforCofins;
  dynamic creditOriginCode;
  String withoutInventoryMovement;
  dynamic agreementNo;
  dynamic agreementRowNumber;
  dynamic actualBaseEntry;
  dynamic actualBaseLine;
  int docEntry;
  int surpluses;
  int defectAndBreakup;
  int shortages;
  String considerQuantity;
  String partialRetirement;
  int retirementQuantity;
  int retirementApc;
  String thirdParty;
  dynamic poNum;
  dynamic poItmNum;
  dynamic expenseType;
  dynamic receiptNumber;
  dynamic expenseOperationType;
  dynamic federalTaxId;
  double grossProfit;
  int grossProfitFc;
  double grossProfitSc;
  String priceSource;
  dynamic stgSeqNum;
  dynamic stgEntry;
  dynamic stgDesc;
  int uoMEntry;
  String uoMCode;
  double inventoryQuantity;
  double remainingOpenInventoryQuantity;
  dynamic parentLineNum;
  int incoterms;
  int transportMode;
  dynamic natureOfTransaction;
  dynamic destinationCountryForImport;
  dynamic destinationRegionForImport;
  dynamic originCountryForExport;
  dynamic originRegionForExport;
  String itemType;
  String changeInventoryQuantityIndependently;
  String freeOfChargeBp;
  dynamic sacEntry;
  dynamic hsnEntry;
  double grossPrice;
  double grossTotal;
  int grossTotalFc;
  double grossTotalSc;
  int ncmCode;
  dynamic nveCode;
  String indEscala;
  int ctrSealQty;
  dynamic cnjpMan;
  dynamic cestCode;
  dynamic ufFiscalBenefitCode;
  String reverseCharge;
  String shipToCode;
  String shipToDescription;
  dynamic ownerCode;
  int externalCalcTaxRate;
  int externalCalcTaxAmount;
  int externalCalcTaxAmountFc;
  int externalCalcTaxAmountSc;
  int standardItemIdentification;
  int commodityClassification;
  int weightOfRecycledPlastic;
  dynamic plasticPackageExemptionReason;
  dynamic legalText;
  dynamic cig;
  dynamic cup;
  dynamic unencumberedReason;
  String cuSplit;
  dynamic listNum;
  dynamic recognizedTaxCode;
  int uQtyOrdered;
  int uOpenQty;
  int uTonnage;
  int uPackSize;
  dynamic uProfitCentre;
  int uNumberDrums;
  dynamic uDrumSize;
  int uPails;
  int uCartons;
  int uLooseTins;
  int uNettWt;
  int uGrossWt;
  dynamic uAppLinId;
  int uMuQty;
  dynamic uRvc;
  dynamic uVrn;
  dynamic uIdentifier;
  dynamic uItemPrice;
  dynamic uBaseLine;
  dynamic uBaseEntry;
  List<dynamic> lineTaxJurisdictions;
  List<dynamic> documentLineAdditionalExpenses;
  List<dynamic> withholdingTaxLines;
  List<dynamic> serialNumbers;
  List<dynamic> batchNumbers;
  List<dynamic> documentLinesBinAllocations;

  DocumentOrderLine({
    required this.lineNum,
    required this.itemCode,
    required this.itemDescription,
    required this.quantity,
    required this.shipDate,
    required this.price,
    required this.priceAfterVat,
    required this.currency,
    required this.rate,
    required this.discountPercent,
    required this.vendorNum,
    required this.serialNum,
    required this.warehouseCode,
    required this.salesPersonCode,
    required this.commisionPercent,
    required this.treeType,
    required this.accountCode,
    required this.useBaseUnits,
    required this.supplierCatNum,
    required this.costingCode,
    required this.projectCode,
    required this.barCode,
    required this.vatGroup,
    required this.height1,
    required this.hight1Unit,
    required this.height2,
    required this.height2Unit,
    required this.lengh1,
    required this.lengh1Unit,
    required this.lengh2,
    required this.lengh2Unit,
    required this.weight1,
    required this.weight1Unit,
    required this.weight2,
    required this.weight2Unit,
    required this.factor1,
    required this.factor2,
    required this.factor3,
    required this.factor4,
    required this.baseType,
    required this.baseEntry,
    required this.baseLine,
    required this.volume,
    required this.volumeUnit,
    required this.width1,
    required this.width1Unit,
    required this.width2,
    required this.width2Unit,
    required this.address,
    required this.taxCode,
    required this.taxType,
    required this.taxLiable,
    required this.pickStatus,
    required this.pickQuantity,
    required this.pickListIdNumber,
    required this.originalItem,
    required this.backOrder,
    required this.freeText,
    required this.shippingMethod,
    required this.poTargetNum,
    required this.poTargetEntry,
    required this.poTargetRowNum,
    required this.correctionInvoiceItem,
    required this.corrInvAmountToStock,
    required this.corrInvAmountToDiffAcct,
    required this.appliedTax,
    required this.appliedTaxFc,
    required this.appliedTaxSc,
    required this.wtLiable,
    required this.deferredTax,
    required this.equalizationTaxPercent,
    required this.totalEqualizationTax,
    required this.totalEqualizationTaxFc,
    required this.totalEqualizationTaxSc,
    required this.netTaxAmount,
    required this.netTaxAmountFc,
    required this.netTaxAmountSc,
    required this.measureUnit,
    required this.unitsOfMeasurment,
    required this.lineTotal,
    required this.taxPercentagePerRow,
    required this.taxTotal,
    required this.consumerSalesForecast,
    required this.exciseAmount,
    required this.taxPerUnit,
    required this.totalInclTax,
    required this.countryOrg,
    required this.sww,
    required this.transactionType,
    required this.distributeExpense,
    required this.rowTotalFc,
    required this.rowTotalSc,
    required this.lastBuyInmPrice,
    required this.lastBuyDistributeSumFc,
    required this.lastBuyDistributeSumSc,
    required this.lastBuyDistributeSum,
    required this.stockDistributesumForeign,
    required this.stockDistributesumSystem,
    required this.stockDistributesum,
    required this.stockInmPrice,
    required this.pickStatusEx,
    required this.taxBeforeDpm,
    required this.taxBeforeDpmfc,
    required this.taxBeforeDpmsc,
    required this.cfopCode,
    required this.cstCode,
    required this.usage,
    required this.taxOnly,
    required this.visualOrder,
    required this.baseOpenQuantity,
    required this.unitPrice,
    required this.lineStatus,
    required this.packageQuantity,
    required this.text,
    required this.lineType,
    required this.cogsCostingCode,
    required this.cogsAccountCode,
    required this.changeAssemlyBoMWarehouse,
    required this.grossBuyPrice,
    required this.grossBase,
    required this.grossProfitTotalBasePrice,
    required this.costingCode2,
    required this.costingCode3,
    required this.costingCode4,
    required this.costingCode5,
    required this.itemDetails,
    required this.locationCode,
    required this.actualDeliveryDate,
    required this.remainingOpenQuantity,
    required this.openAmount,
    required this.openAmountFc,
    required this.openAmountSc,
    required this.exLineNo,
    required this.requiredDate,
    required this.requiredQuantity,
    required this.cogsCostingCode2,
    required this.cogsCostingCode3,
    required this.cogsCostingCode4,
    required this.cogsCostingCode5,
    required this.csTforIpi,
    required this.csTforPis,
    required this.csTforCofins,
    required this.creditOriginCode,
    required this.withoutInventoryMovement,
    required this.agreementNo,
    required this.agreementRowNumber,
    required this.actualBaseEntry,
    required this.actualBaseLine,
    required this.docEntry,
    required this.surpluses,
    required this.defectAndBreakup,
    required this.shortages,
    required this.considerQuantity,
    required this.partialRetirement,
    required this.retirementQuantity,
    required this.retirementApc,
    required this.thirdParty,
    required this.poNum,
    required this.poItmNum,
    required this.expenseType,
    required this.receiptNumber,
    required this.expenseOperationType,
    required this.federalTaxId,
    required this.grossProfit,
    required this.grossProfitFc,
    required this.grossProfitSc,
    required this.priceSource,
    required this.stgSeqNum,
    required this.stgEntry,
    required this.stgDesc,
    required this.uoMEntry,
    required this.uoMCode,
    required this.inventoryQuantity,
    required this.remainingOpenInventoryQuantity,
    required this.parentLineNum,
    required this.incoterms,
    required this.transportMode,
    required this.natureOfTransaction,
    required this.destinationCountryForImport,
    required this.destinationRegionForImport,
    required this.originCountryForExport,
    required this.originRegionForExport,
    required this.itemType,
    required this.changeInventoryQuantityIndependently,
    required this.freeOfChargeBp,
    required this.sacEntry,
    required this.hsnEntry,
    required this.grossPrice,
    required this.grossTotal,
    required this.grossTotalFc,
    required this.grossTotalSc,
    required this.ncmCode,
    required this.nveCode,
    required this.indEscala,
    required this.ctrSealQty,
    required this.cnjpMan,
    required this.cestCode,
    required this.ufFiscalBenefitCode,
    required this.reverseCharge,
    required this.shipToCode,
    required this.shipToDescription,
    required this.ownerCode,
    required this.externalCalcTaxRate,
    required this.externalCalcTaxAmount,
    required this.externalCalcTaxAmountFc,
    required this.externalCalcTaxAmountSc,
    required this.standardItemIdentification,
    required this.commodityClassification,
    required this.weightOfRecycledPlastic,
    required this.plasticPackageExemptionReason,
    required this.legalText,
    required this.cig,
    required this.cup,
    required this.unencumberedReason,
    required this.cuSplit,
    required this.listNum,
    required this.recognizedTaxCode,
    required this.uQtyOrdered,
    required this.uOpenQty,
    required this.uTonnage,
    required this.uPackSize,
    required this.uProfitCentre,
    required this.uNumberDrums,
    required this.uDrumSize,
    required this.uPails,
    required this.uCartons,
    required this.uLooseTins,
    required this.uNettWt,
    required this.uGrossWt,
    required this.uAppLinId,
    required this.uMuQty,
    required this.uRvc,
    required this.uVrn,
    required this.uIdentifier,
    required this.uItemPrice,
    required this.uBaseLine,
    required this.uBaseEntry,
    required this.lineTaxJurisdictions,
    required this.documentLineAdditionalExpenses,
    required this.withholdingTaxLines,
    required this.serialNumbers,
    required this.batchNumbers,
    required this.documentLinesBinAllocations,
  });

  factory DocumentOrderLine.fromJson(Map<String, dynamic> json) =>
      DocumentOrderLine(
        lineNum: json["LineNum"],
        itemCode: json["ItemCode"],
        itemDescription: json["ItemDescription"],
        quantity: json["Quantity"]?.toDouble(),
        shipDate: DateTime.parse(json["ShipDate"]),
        price: json["Price"]?.toDouble(),
        priceAfterVat: json["PriceAfterVAT"]?.toDouble(),
        currency: json["Currency"],
        rate: json["Rate"],
        discountPercent: json["DiscountPercent"]?.toDouble(),
        vendorNum: json["VendorNum"],
        serialNum: json["SerialNum"],
        warehouseCode: json["WarehouseCode"],
        salesPersonCode: json["SalesPersonCode"],
        commisionPercent: json["CommisionPercent"],
        treeType: json["TreeType"],
        accountCode: json["AccountCode"],
        useBaseUnits: json["UseBaseUnits"],
        supplierCatNum: json["SupplierCatNum"],
        costingCode: json["CostingCode"],
        projectCode: json["ProjectCode"],
        barCode: json["BarCode"],
        vatGroup: json["VatGroup"],
        height1: json["Height1"],
        hight1Unit: json["Hight1Unit"],
        height2: json["Height2"],
        height2Unit: json["Height2Unit"],
        lengh1: json["Lengh1"],
        lengh1Unit: json["Lengh1Unit"],
        lengh2: json["Lengh2"],
        lengh2Unit: json["Lengh2Unit"],
        weight1: json["Weight1"],
        weight1Unit: json["Weight1Unit"],
        weight2: json["Weight2"],
        weight2Unit: json["Weight2Unit"],
        factor1: json["Factor1"],
        factor2: json["Factor2"],
        factor3: json["Factor3"],
        factor4: json["Factor4"],
        baseType: json["BaseType"],
        baseEntry: json["BaseEntry"],
        baseLine: json["BaseLine"],
        volume: json["Volume"],
        volumeUnit: json["VolumeUnit"],
        width1: json["Width1"],
        width1Unit: json["Width1Unit"],
        width2: json["Width2"],
        width2Unit: json["Width2Unit"],
        address: json["Address"],
        taxCode: json["TaxCode"],
        taxType: json["TaxType"],
        taxLiable: json["TaxLiable"],
        pickStatus: json["PickStatus"],
        pickQuantity: json["PickQuantity"],
        pickListIdNumber: json["PickListIdNumber"],
        originalItem: json["OriginalItem"],
        backOrder: json["BackOrder"],
        freeText: json["FreeText"],
        shippingMethod: json["ShippingMethod"],
        poTargetNum: json["POTargetNum"],
        poTargetEntry: json["POTargetEntry"],
        poTargetRowNum: json["POTargetRowNum"],
        correctionInvoiceItem: json["CorrectionInvoiceItem"],
        corrInvAmountToStock: json["CorrInvAmountToStock"],
        corrInvAmountToDiffAcct: json["CorrInvAmountToDiffAcct"],
        appliedTax: json["AppliedTax"],
        appliedTaxFc: json["AppliedTaxFC"],
        appliedTaxSc: json["AppliedTaxSC"],
        wtLiable: json["WTLiable"],
        deferredTax: json["DeferredTax"],
        equalizationTaxPercent: json["EqualizationTaxPercent"],
        totalEqualizationTax: json["TotalEqualizationTax"],
        totalEqualizationTaxFc: json["TotalEqualizationTaxFC"],
        totalEqualizationTaxSc: json["TotalEqualizationTaxSC"],
        netTaxAmount: json["NetTaxAmount"]?.toDouble(),
        netTaxAmountFc: json["NetTaxAmountFC"],
        netTaxAmountSc: json["NetTaxAmountSC"]?.toDouble(),
        measureUnit: json["MeasureUnit"],
        unitsOfMeasurment: json["UnitsOfMeasurment"],
        lineTotal: json["LineTotal"]?.toDouble(),
        taxPercentagePerRow: json["TaxPercentagePerRow"],
        taxTotal: json["TaxTotal"]?.toDouble(),
        consumerSalesForecast: json["ConsumerSalesForecast"],
        exciseAmount: json["ExciseAmount"],
        taxPerUnit: json["TaxPerUnit"],
        totalInclTax: json["TotalInclTax"],
        countryOrg: json["CountryOrg"],
        sww: json["SWW"],
        transactionType: json["TransactionType"],
        distributeExpense: json["DistributeExpense"],
        rowTotalFc: json["RowTotalFC"],
        rowTotalSc: json["RowTotalSC"]?.toDouble(),
        lastBuyInmPrice: json["LastBuyInmPrice"],
        lastBuyDistributeSumFc: json["LastBuyDistributeSumFc"],
        lastBuyDistributeSumSc: json["LastBuyDistributeSumSc"],
        lastBuyDistributeSum: json["LastBuyDistributeSum"],
        stockDistributesumForeign: json["StockDistributesumForeign"],
        stockDistributesumSystem: json["StockDistributesumSystem"],
        stockDistributesum: json["StockDistributesum"],
        stockInmPrice: json["StockInmPrice"],
        pickStatusEx: json["PickStatusEx"],
        taxBeforeDpm: json["TaxBeforeDPM"],
        taxBeforeDpmfc: json["TaxBeforeDPMFC"],
        taxBeforeDpmsc: json["TaxBeforeDPMSC"],
        cfopCode: json["CFOPCode"],
        cstCode: json["CSTCode"],
        usage: json["Usage"],
        taxOnly: json["TaxOnly"],
        visualOrder: json["VisualOrder"],
        baseOpenQuantity: json["BaseOpenQuantity"],
        unitPrice: json["UnitPrice"],
        lineStatus: json["LineStatus"],
        packageQuantity: json["PackageQuantity"],
        text: json["Text"],
        lineType: json["LineType"],
        cogsCostingCode: json["COGSCostingCode"],
        cogsAccountCode: json["COGSAccountCode"],
        changeAssemlyBoMWarehouse: json["ChangeAssemlyBoMWarehouse"],
        grossBuyPrice: json["GrossBuyPrice"],
        grossBase: json["GrossBase"],
        grossProfitTotalBasePrice: json["GrossProfitTotalBasePrice"],
        costingCode2: json["CostingCode2"],
        costingCode3: json["CostingCode3"],
        costingCode4: json["CostingCode4"],
        costingCode5: json["CostingCode5"],
        itemDetails: json["ItemDetails"],
        locationCode: json["LocationCode"],
        actualDeliveryDate: json["ActualDeliveryDate"],
        remainingOpenQuantity: json["RemainingOpenQuantity"]?.toDouble(),
        openAmount: json["OpenAmount"]?.toDouble(),
        openAmountFc: json["OpenAmountFC"],
        openAmountSc: json["OpenAmountSC"]?.toDouble(),
        exLineNo: json["ExLineNo"],
        requiredDate: json["RequiredDate"],
        requiredQuantity: json["RequiredQuantity"],
        cogsCostingCode2: json["COGSCostingCode2"],
        cogsCostingCode3: json["COGSCostingCode3"],
        cogsCostingCode4: json["COGSCostingCode4"],
        cogsCostingCode5: json["COGSCostingCode5"],
        csTforIpi: json["CSTforIPI"],
        csTforPis: json["CSTforPIS"],
        csTforCofins: json["CSTforCOFINS"],
        creditOriginCode: json["CreditOriginCode"],
        withoutInventoryMovement: json["WithoutInventoryMovement"],
        agreementNo: json["AgreementNo"],
        agreementRowNumber: json["AgreementRowNumber"],
        actualBaseEntry: json["ActualBaseEntry"],
        actualBaseLine: json["ActualBaseLine"],
        docEntry: json["DocEntry"],
        surpluses: json["Surpluses"],
        defectAndBreakup: json["DefectAndBreakup"],
        shortages: json["Shortages"],
        considerQuantity: json["ConsiderQuantity"],
        partialRetirement: json["PartialRetirement"],
        retirementQuantity: json["RetirementQuantity"],
        retirementApc: json["RetirementAPC"],
        thirdParty: json["ThirdParty"],
        poNum: json["PoNum"],
        poItmNum: json["PoItmNum"],
        expenseType: json["ExpenseType"],
        receiptNumber: json["ReceiptNumber"],
        expenseOperationType: json["ExpenseOperationType"],
        federalTaxId: json["FederalTaxID"],
        grossProfit: json["GrossProfit"]?.toDouble(),
        grossProfitFc: json["GrossProfitFC"],
        grossProfitSc: json["GrossProfitSC"]?.toDouble(),
        priceSource: json["PriceSource"],
        stgSeqNum: json["StgSeqNum"],
        stgEntry: json["StgEntry"],
        stgDesc: json["StgDesc"],
        uoMEntry: json["UoMEntry"],
        uoMCode: json["UoMCode"],
        inventoryQuantity: json["InventoryQuantity"]?.toDouble(),
        remainingOpenInventoryQuantity:
            json["RemainingOpenInventoryQuantity"]?.toDouble(),
        parentLineNum: json["ParentLineNum"],
        incoterms: json["Incoterms"],
        transportMode: json["TransportMode"],
        natureOfTransaction: json["NatureOfTransaction"],
        destinationCountryForImport: json["DestinationCountryForImport"],
        destinationRegionForImport: json["DestinationRegionForImport"],
        originCountryForExport: json["OriginCountryForExport"],
        originRegionForExport: json["OriginRegionForExport"],
        itemType: json["ItemType"],
        changeInventoryQuantityIndependently:
            json["ChangeInventoryQuantityIndependently"],
        freeOfChargeBp: json["FreeOfChargeBP"],
        sacEntry: json["SACEntry"],
        hsnEntry: json["HSNEntry"],
        grossPrice: json["GrossPrice"]?.toDouble(),
        grossTotal: json["GrossTotal"]?.toDouble(),
        grossTotalFc: json["GrossTotalFC"],
        grossTotalSc: json["GrossTotalSC"]?.toDouble(),
        ncmCode: json["NCMCode"],
        nveCode: json["NVECode"],
        indEscala: json["IndEscala"],
        ctrSealQty: json["CtrSealQty"],
        cnjpMan: json["CNJPMan"],
        cestCode: json["CESTCode"],
        ufFiscalBenefitCode: json["UFFiscalBenefitCode"],
        reverseCharge: json["ReverseCharge"],
        shipToCode: json["ShipToCode"],
        shipToDescription: json["ShipToDescription"],
        ownerCode: json["OwnerCode"],
        externalCalcTaxRate: json["ExternalCalcTaxRate"],
        externalCalcTaxAmount: json["ExternalCalcTaxAmount"],
        externalCalcTaxAmountFc: json["ExternalCalcTaxAmountFC"],
        externalCalcTaxAmountSc: json["ExternalCalcTaxAmountSC"],
        standardItemIdentification: json["StandardItemIdentification"],
        commodityClassification: json["CommodityClassification"],
        weightOfRecycledPlastic: json["WeightOfRecycledPlastic"],
        plasticPackageExemptionReason: json["PlasticPackageExemptionReason"],
        legalText: json["LegalText"],
        cig: json["Cig"],
        cup: json["Cup"],
        unencumberedReason: json["UnencumberedReason"],
        cuSplit: json["CUSplit"],
        listNum: json["ListNum"],
        recognizedTaxCode: json["RecognizedTaxCode"],
        uQtyOrdered: json["U_Qty_Ordered"],
        uOpenQty: json["U_Open_Qty"],
        uTonnage: json["U_Tonnage"],
        uPackSize: json["U_PackSize"],
        uProfitCentre: json["U_Profit_Centre"],
        uNumberDrums: json["U_Number_Drums"],
        uDrumSize: json["U_Drum_Size"],
        uPails: json["U_Pails"],
        uCartons: json["U_Cartons"],
        uLooseTins: json["U_Loose_Tins"],
        uNettWt: json["U_Nett_Wt"],
        uGrossWt: json["U_Gross_Wt"],
        uAppLinId: json["U_AppLinId"],
        uMuQty: json["U_MUQty"],
        uRvc: json["U_RVC"],
        uVrn: json["U_VRN"],
        uIdentifier: json["U_Identifier"],
        uItemPrice: json["U_ItemPrice"],
        uBaseLine: json["U_BaseLine"],
        uBaseEntry: json["U_BaseEntry"],
        lineTaxJurisdictions:
            List<dynamic>.from(json["LineTaxJurisdictions"].map((x) => x)),
        documentLineAdditionalExpenses: List<dynamic>.from(
            json["DocumentLineAdditionalExpenses"].map((x) => x)),
        withholdingTaxLines:
            List<dynamic>.from(json["WithholdingTaxLines"].map((x) => x)),
        serialNumbers: List<dynamic>.from(json["SerialNumbers"].map((x) => x)),
        batchNumbers: List<dynamic>.from(json["BatchNumbers"].map((x) => x)),
        documentLinesBinAllocations: List<dynamic>.from(
            json["DocumentLinesBinAllocations"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "LineNum": lineNum,
        "ItemCode": itemCode,
        "ItemDescription": itemDescription,
        "Quantity": quantity,
        "ShipDate": shipDate.toIso8601String(),
        "Price": price,
        "PriceAfterVAT": priceAfterVat,
        "Currency": currency,
        "Rate": rate,
        "DiscountPercent": discountPercent,
        "VendorNum": vendorNum,
        "SerialNum": serialNum,
        "WarehouseCode": warehouseCode,
        "SalesPersonCode": salesPersonCode,
        "CommisionPercent": commisionPercent,
        "TreeType": treeType,
        "AccountCode": accountCode,
        "UseBaseUnits": useBaseUnits,
        "SupplierCatNum": supplierCatNum,
        "CostingCode": costingCode,
        "ProjectCode": projectCode,
        "BarCode": barCode,
        "VatGroup": vatGroup,
        "Height1": height1,
        "Hight1Unit": hight1Unit,
        "Height2": height2,
        "Height2Unit": height2Unit,
        "Lengh1": lengh1,
        "Lengh1Unit": lengh1Unit,
        "Lengh2": lengh2,
        "Lengh2Unit": lengh2Unit,
        "Weight1": weight1,
        "Weight1Unit": weight1Unit,
        "Weight2": weight2,
        "Weight2Unit": weight2Unit,
        "Factor1": factor1,
        "Factor2": factor2,
        "Factor3": factor3,
        "Factor4": factor4,
        "BaseType": baseType,
        "BaseEntry": baseEntry,
        "BaseLine": baseLine,
        "Volume": volume,
        "VolumeUnit": volumeUnit,
        "Width1": width1,
        "Width1Unit": width1Unit,
        "Width2": width2,
        "Width2Unit": width2Unit,
        "Address": address,
        "TaxCode": taxCode,
        "TaxType": taxType,
        "TaxLiable": taxLiable,
        "PickStatus": pickStatus,
        "PickQuantity": pickQuantity,
        "PickListIdNumber": pickListIdNumber,
        "OriginalItem": originalItem,
        "BackOrder": backOrder,
        "FreeText": freeText,
        "ShippingMethod": shippingMethod,
        "POTargetNum": poTargetNum,
        "POTargetEntry": poTargetEntry,
        "POTargetRowNum": poTargetRowNum,
        "CorrectionInvoiceItem": correctionInvoiceItem,
        "CorrInvAmountToStock": corrInvAmountToStock,
        "CorrInvAmountToDiffAcct": corrInvAmountToDiffAcct,
        "AppliedTax": appliedTax,
        "AppliedTaxFC": appliedTaxFc,
        "AppliedTaxSC": appliedTaxSc,
        "WTLiable": wtLiable,
        "DeferredTax": deferredTax,
        "EqualizationTaxPercent": equalizationTaxPercent,
        "TotalEqualizationTax": totalEqualizationTax,
        "TotalEqualizationTaxFC": totalEqualizationTaxFc,
        "TotalEqualizationTaxSC": totalEqualizationTaxSc,
        "NetTaxAmount": netTaxAmount,
        "NetTaxAmountFC": netTaxAmountFc,
        "NetTaxAmountSC": netTaxAmountSc,
        "MeasureUnit": measureUnit,
        "UnitsOfMeasurment": unitsOfMeasurment,
        "LineTotal": lineTotal,
        "TaxPercentagePerRow": taxPercentagePerRow,
        "TaxTotal": taxTotal,
        "ConsumerSalesForecast": consumerSalesForecast,
        "ExciseAmount": exciseAmount,
        "TaxPerUnit": taxPerUnit,
        "TotalInclTax": totalInclTax,
        "CountryOrg": countryOrg,
        "SWW": sww,
        "TransactionType": transactionType,
        "DistributeExpense": distributeExpense,
        "RowTotalFC": rowTotalFc,
        "RowTotalSC": rowTotalSc,
        "LastBuyInmPrice": lastBuyInmPrice,
        "LastBuyDistributeSumFc": lastBuyDistributeSumFc,
        "LastBuyDistributeSumSc": lastBuyDistributeSumSc,
        "LastBuyDistributeSum": lastBuyDistributeSum,
        "StockDistributesumForeign": stockDistributesumForeign,
        "StockDistributesumSystem": stockDistributesumSystem,
        "StockDistributesum": stockDistributesum,
        "StockInmPrice": stockInmPrice,
        "PickStatusEx": pickStatusEx,
        "TaxBeforeDPM": taxBeforeDpm,
        "TaxBeforeDPMFC": taxBeforeDpmfc,
        "TaxBeforeDPMSC": taxBeforeDpmsc,
        "CFOPCode": cfopCode,
        "CSTCode": cstCode,
        "Usage": usage,
        "TaxOnly": taxOnly,
        "VisualOrder": visualOrder,
        "BaseOpenQuantity": baseOpenQuantity,
        "UnitPrice": unitPrice,
        "LineStatus": lineStatus,
        "PackageQuantity": packageQuantity,
        "Text": text,
        "LineType": lineType,
        "COGSCostingCode": cogsCostingCode,
        "COGSAccountCode": cogsAccountCode,
        "ChangeAssemlyBoMWarehouse": changeAssemlyBoMWarehouse,
        "GrossBuyPrice": grossBuyPrice,
        "GrossBase": grossBase,
        "GrossProfitTotalBasePrice": grossProfitTotalBasePrice,
        "CostingCode2": costingCode2,
        "CostingCode3": costingCode3,
        "CostingCode4": costingCode4,
        "CostingCode5": costingCode5,
        "ItemDetails": itemDetails,
        "LocationCode": locationCode,
        "ActualDeliveryDate": actualDeliveryDate,
        "RemainingOpenQuantity": remainingOpenQuantity,
        "OpenAmount": openAmount,
        "OpenAmountFC": openAmountFc,
        "OpenAmountSC": openAmountSc,
        "ExLineNo": exLineNo,
        "RequiredDate": requiredDate,
        "RequiredQuantity": requiredQuantity,
        "COGSCostingCode2": cogsCostingCode2,
        "COGSCostingCode3": cogsCostingCode3,
        "COGSCostingCode4": cogsCostingCode4,
        "COGSCostingCode5": cogsCostingCode5,
        "CSTforIPI": csTforIpi,
        "CSTforPIS": csTforPis,
        "CSTforCOFINS": csTforCofins,
        "CreditOriginCode": creditOriginCode,
        "WithoutInventoryMovement": withoutInventoryMovement,
        "AgreementNo": agreementNo,
        "AgreementRowNumber": agreementRowNumber,
        "ActualBaseEntry": actualBaseEntry,
        "ActualBaseLine": actualBaseLine,
        "DocEntry": docEntry,
        "Surpluses": surpluses,
        "DefectAndBreakup": defectAndBreakup,
        "Shortages": shortages,
        "ConsiderQuantity": considerQuantity,
        "PartialRetirement": partialRetirement,
        "RetirementQuantity": retirementQuantity,
        "RetirementAPC": retirementApc,
        "ThirdParty": thirdParty,
        "PoNum": poNum,
        "PoItmNum": poItmNum,
        "ExpenseType": expenseType,
        "ReceiptNumber": receiptNumber,
        "ExpenseOperationType": expenseOperationType,
        "FederalTaxID": federalTaxId,
        "GrossProfit": grossProfit,
        "GrossProfitFC": grossProfitFc,
        "GrossProfitSC": grossProfitSc,
        "PriceSource": priceSource,
        "StgSeqNum": stgSeqNum,
        "StgEntry": stgEntry,
        "StgDesc": stgDesc,
        "UoMEntry": uoMEntry,
        "UoMCode": uoMCode,
        "InventoryQuantity": inventoryQuantity,
        "RemainingOpenInventoryQuantity": remainingOpenInventoryQuantity,
        "ParentLineNum": parentLineNum,
        "Incoterms": incoterms,
        "TransportMode": transportMode,
        "NatureOfTransaction": natureOfTransaction,
        "DestinationCountryForImport": destinationCountryForImport,
        "DestinationRegionForImport": destinationRegionForImport,
        "OriginCountryForExport": originCountryForExport,
        "OriginRegionForExport": originRegionForExport,
        "ItemType": itemType,
        "ChangeInventoryQuantityIndependently":
            changeInventoryQuantityIndependently,
        "FreeOfChargeBP": freeOfChargeBp,
        "SACEntry": sacEntry,
        "HSNEntry": hsnEntry,
        "GrossPrice": grossPrice,
        "GrossTotal": grossTotal,
        "GrossTotalFC": grossTotalFc,
        "GrossTotalSC": grossTotalSc,
        "NCMCode": ncmCode,
        "NVECode": nveCode,
        "IndEscala": indEscala,
        "CtrSealQty": ctrSealQty,
        "CNJPMan": cnjpMan,
        "CESTCode": cestCode,
        "UFFiscalBenefitCode": ufFiscalBenefitCode,
        "ReverseCharge": reverseCharge,
        "ShipToCode": shipToCode,
        "ShipToDescription": shipToDescription,
        "OwnerCode": ownerCode,
        "ExternalCalcTaxRate": externalCalcTaxRate,
        "ExternalCalcTaxAmount": externalCalcTaxAmount,
        "ExternalCalcTaxAmountFC": externalCalcTaxAmountFc,
        "ExternalCalcTaxAmountSC": externalCalcTaxAmountSc,
        "StandardItemIdentification": standardItemIdentification,
        "CommodityClassification": commodityClassification,
        "WeightOfRecycledPlastic": weightOfRecycledPlastic,
        "PlasticPackageExemptionReason": plasticPackageExemptionReason,
        "LegalText": legalText,
        "Cig": cig,
        "Cup": cup,
        "UnencumberedReason": unencumberedReason,
        "CUSplit": cuSplit,
        "ListNum": listNum,
        "RecognizedTaxCode": recognizedTaxCode,
        "U_Qty_Ordered": uQtyOrdered,
        "U_Open_Qty": uOpenQty,
        "U_Tonnage": uTonnage,
        "U_PackSize": uPackSize,
        "U_Profit_Centre": uProfitCentre,
        "U_Number_Drums": uNumberDrums,
        "U_Drum_Size": uDrumSize,
        "U_Pails": uPails,
        "U_Cartons": uCartons,
        "U_Loose_Tins": uLooseTins,
        "U_Nett_Wt": uNettWt,
        "U_Gross_Wt": uGrossWt,
        "U_AppLinId": uAppLinId,
        "U_MUQty": uMuQty,
        "U_RVC": uRvc,
        "U_VRN": uVrn,
        "U_Identifier": uIdentifier,
        "U_ItemPrice": uItemPrice,
        "U_BaseLine": uBaseLine,
        "U_BaseEntry": uBaseEntry,
        "LineTaxJurisdictions":
            List<dynamic>.from(lineTaxJurisdictions.map((x) => x)),
        "DocumentLineAdditionalExpenses":
            List<dynamic>.from(documentLineAdditionalExpenses.map((x) => x)),
        "WithholdingTaxLines":
            List<dynamic>.from(withholdingTaxLines.map((x) => x)),
        "SerialNumbers": List<dynamic>.from(serialNumbers.map((x) => x)),
        "BatchNumbers": List<dynamic>.from(batchNumbers.map((x) => x)),
        "DocumentLinesBinAllocations":
            List<dynamic>.from(documentLinesBinAllocations.map((x) => x)),
      };
}

class TaxExtension {
  dynamic taxId0;
  dynamic taxId1;
  dynamic taxId2;
  dynamic taxId3;
  dynamic taxId4;
  dynamic taxId5;
  dynamic taxId6;
  dynamic taxId7;
  dynamic taxId8;
  dynamic taxId9;
  dynamic state;
  dynamic county;
  dynamic incoterms;
  dynamic vehicle;
  dynamic vehicleState;
  dynamic nfRef;
  dynamic carrier;
  dynamic packQuantity;
  dynamic packDescription;
  dynamic brand;
  dynamic shipUnitNo;
  int netWeight;
  int grossWeight;
  dynamic streetS;
  dynamic blockS;
  String buildingS;
  dynamic cityS;
  dynamic zipCodeS;
  dynamic countyS;
  dynamic stateS;
  String countryS;
  String streetB;
  dynamic blockB;
  String buildingB;
  String cityB;
  dynamic zipCodeB;
  dynamic countyB;
  dynamic stateB;
  String countryB;
  dynamic importOrExport;
  dynamic mainUsage;
  dynamic globalLocationNumberS;
  dynamic globalLocationNumberB;
  dynamic taxId12;
  dynamic taxId13;
  dynamic billOfEntryNo;
  dynamic billOfEntryDate;
  dynamic originalBillOfEntryNo;
  dynamic originalBillOfEntryDate;
  String importOrExportType;
  dynamic portCode;
  int docEntry;
  int boEValue;
  dynamic claimRefund;
  dynamic differentialOfTaxRate;
  dynamic isIgstAccount;
  dynamic taxId14;

  TaxExtension({
    required this.taxId0,
    required this.taxId1,
    required this.taxId2,
    required this.taxId3,
    required this.taxId4,
    required this.taxId5,
    required this.taxId6,
    required this.taxId7,
    required this.taxId8,
    required this.taxId9,
    required this.state,
    required this.county,
    required this.incoterms,
    required this.vehicle,
    required this.vehicleState,
    required this.nfRef,
    required this.carrier,
    required this.packQuantity,
    required this.packDescription,
    required this.brand,
    required this.shipUnitNo,
    required this.netWeight,
    required this.grossWeight,
    required this.streetS,
    required this.blockS,
    required this.buildingS,
    required this.cityS,
    required this.zipCodeS,
    required this.countyS,
    required this.stateS,
    required this.countryS,
    required this.streetB,
    required this.blockB,
    required this.buildingB,
    required this.cityB,
    required this.zipCodeB,
    required this.countyB,
    required this.stateB,
    required this.countryB,
    required this.importOrExport,
    required this.mainUsage,
    required this.globalLocationNumberS,
    required this.globalLocationNumberB,
    required this.taxId12,
    required this.taxId13,
    required this.billOfEntryNo,
    required this.billOfEntryDate,
    required this.originalBillOfEntryNo,
    required this.originalBillOfEntryDate,
    required this.importOrExportType,
    required this.portCode,
    required this.docEntry,
    required this.boEValue,
    required this.claimRefund,
    required this.differentialOfTaxRate,
    required this.isIgstAccount,
    required this.taxId14,
  });

  factory TaxExtension.fromJson(Map<String, dynamic> json) => TaxExtension(
        taxId0: json["TaxId0"],
        taxId1: json["TaxId1"],
        taxId2: json["TaxId2"],
        taxId3: json["TaxId3"],
        taxId4: json["TaxId4"],
        taxId5: json["TaxId5"],
        taxId6: json["TaxId6"],
        taxId7: json["TaxId7"],
        taxId8: json["TaxId8"],
        taxId9: json["TaxId9"],
        state: json["State"],
        county: json["County"],
        incoterms: json["Incoterms"],
        vehicle: json["Vehicle"],
        vehicleState: json["VehicleState"],
        nfRef: json["NFRef"],
        carrier: json["Carrier"],
        packQuantity: json["PackQuantity"],
        packDescription: json["PackDescription"],
        brand: json["Brand"],
        shipUnitNo: json["ShipUnitNo"],
        netWeight: json["NetWeight"],
        grossWeight: json["GrossWeight"],
        streetS: json["StreetS"],
        blockS: json["BlockS"],
        buildingS: json["BuildingS"],
        cityS: json["CityS"],
        zipCodeS: json["ZipCodeS"],
        countyS: json["CountyS"],
        stateS: json["StateS"],
        countryS: json["CountryS"],
        streetB: json["StreetB"],
        blockB: json["BlockB"],
        buildingB: json["BuildingB"],
        cityB: json["CityB"],
        zipCodeB: json["ZipCodeB"],
        countyB: json["CountyB"],
        stateB: json["StateB"],
        countryB: json["CountryB"],
        importOrExport: json["ImportOrExport"],
        mainUsage: json["MainUsage"],
        globalLocationNumberS: json["GlobalLocationNumberS"],
        globalLocationNumberB: json["GlobalLocationNumberB"],
        taxId12: json["TaxId12"],
        taxId13: json["TaxId13"],
        billOfEntryNo: json["BillOfEntryNo"],
        billOfEntryDate: json["BillOfEntryDate"],
        originalBillOfEntryNo: json["OriginalBillOfEntryNo"],
        originalBillOfEntryDate: json["OriginalBillOfEntryDate"],
        importOrExportType: json["ImportOrExportType"],
        portCode: json["PortCode"],
        docEntry: json["DocEntry"],
        boEValue: json["BoEValue"],
        claimRefund: json["ClaimRefund"],
        differentialOfTaxRate: json["DifferentialOfTaxRate"],
        isIgstAccount: json["IsIGSTAccount"],
        taxId14: json["TaxId14"],
      );

  Map<String, dynamic> toJson() => {
        "TaxId0": taxId0,
        "TaxId1": taxId1,
        "TaxId2": taxId2,
        "TaxId3": taxId3,
        "TaxId4": taxId4,
        "TaxId5": taxId5,
        "TaxId6": taxId6,
        "TaxId7": taxId7,
        "TaxId8": taxId8,
        "TaxId9": taxId9,
        "State": state,
        "County": county,
        "Incoterms": incoterms,
        "Vehicle": vehicle,
        "VehicleState": vehicleState,
        "NFRef": nfRef,
        "Carrier": carrier,
        "PackQuantity": packQuantity,
        "PackDescription": packDescription,
        "Brand": brand,
        "ShipUnitNo": shipUnitNo,
        "NetWeight": netWeight,
        "GrossWeight": grossWeight,
        "StreetS": streetS,
        "BlockS": blockS,
        "BuildingS": buildingS,
        "CityS": cityS,
        "ZipCodeS": zipCodeS,
        "CountyS": countyS,
        "StateS": stateS,
        "CountryS": countryS,
        "StreetB": streetB,
        "BlockB": blockB,
        "BuildingB": buildingB,
        "CityB": cityB,
        "ZipCodeB": zipCodeB,
        "CountyB": countyB,
        "StateB": stateB,
        "CountryB": countryB,
        "ImportOrExport": importOrExport,
        "MainUsage": mainUsage,
        "GlobalLocationNumberS": globalLocationNumberS,
        "GlobalLocationNumberB": globalLocationNumberB,
        "TaxId12": taxId12,
        "TaxId13": taxId13,
        "BillOfEntryNo": billOfEntryNo,
        "BillOfEntryDate": billOfEntryDate,
        "OriginalBillOfEntryNo": originalBillOfEntryNo,
        "OriginalBillOfEntryDate": originalBillOfEntryDate,
        "ImportOrExportType": importOrExportType,
        "PortCode": portCode,
        "DocEntry": docEntry,
        "BoEValue": boEValue,
        "ClaimRefund": claimRefund,
        "DifferentialOfTaxRate": differentialOfTaxRate,
        "IsIGSTAccount": isIgstAccount,
        "TaxId14": taxId14,
      };
}
