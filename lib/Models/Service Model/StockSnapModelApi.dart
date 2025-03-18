import 'dart:convert';

import '../../../DBModel/DBmodel.dart';

class StocksnapModel {
  List<StocksnapModelData>? stocksnapitemdata;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  StocksnapModel(
      {required this.stocksnapitemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory StocksnapModel.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["data"] != null) {
      var list = jsonDecode(jsons["data"]) as List;
      // log("LL::$list");

      List<StocksnapModelData> dataList =
          list.map((data) => StocksnapModelData.fromJson(data)).toList();
      return StocksnapModel(
          stocksnapitemdata: dataList,
          //
          message: jsons["message"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    } else {
      return StocksnapModel(
          stocksnapitemdata: null,
          //
          message: jsons["message"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    }
  }

  factory StocksnapModel.error(String jsons, int stcode) {
    return StocksnapModel(
        //
        stocksnapitemdata: null,
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class StocksnapModelData {
  StocksnapModelData(
      {this.basic,
      this.checkBClr,
      this.inStockQty,
      this.invoiceClr,
      this.lineStatus,
      this.discount,
      this.priceAfDiscBasic,
      this.priceAftDiscVal,
      this.taxvalue,
      this.netvalue,
      this.taxable,
      this.baselineid,
      this.basedocentry,
      this.baseType,
      this.sapbasedocentry,
      this.pails,
      this.cartons,
      this.looseTins,
      this.tonnage,
      this.totalPack,
      this.maxdiscount,
      this.taxCode,
      this.taxType,
      this.docentry,
      this.discountper,
      this.transID,
      required this.branch,
      required this.itemCode,
      this.shipDate,
      required this.itemName,
      this.itemnamelong,
      this.itemnameshort,
      this.searchString,
      this.subcategory,
      required this.serialBatch,
      this.openQty,
      this.qty,
      this.specialprice,
      this.purchasedate,
      this.createdateTime,
      this.snapdatetime,
      this.updatedDatetime,
      this.createdUserID,
      this.lastupdateIp,
      this.updateduserid,
      this.inDate,
      this.inType,
      this.displayQty,
      this.maximumQty,
      required this.mrp,
      required this.sellPrice,
      this.cost,
      this.taxRate,
      this.minimumQty,
      this.invoiceNo,
      this.uPackSize,
      this.uTINSPERBOX,
      this.uSpecificGravity,
      this.uPackSizeuom,
      this.weight,
      this.category,
      this.hsnsac,
      this.isActive,
      this.isfreeby,
      this.openRetQty,
      this.isinventory,
      this.issellpricebyscrbat,
      this.skuCode,
      this.liter});

  int? invoiceClr;
  bool? checkBClr;
  double? basic;
  double? priceAfDiscBasic;
  int? sapbasedocentry;
  double? pails;
  int? cartons;
  double? looseTins;
  double? inStockQty;

  double? tonnage;
  double? totalPack;
  double? uPackSize;
  int? uTINSPERBOX;
  String? uPackSizeuom;
  double? uSpecificGravity;
  String? docentry;
  String? shipDate;
  String? taxCode;
  double? taxable;
  String? taxType;
  double? discount;
  double? priceAftDiscVal;
  double? taxvalue;
  double? netvalue;
  double? discountper;
  String? basedocentry;
  int? baseType;
  String? lineStatus;

  String? baselineid;
  int? transID;
  // {\"itemname\":\"RED OXIDE PRIMER - 5LTR\",\"itemcode\":\"1000002C\",\"WhsCode\":\"HOFG\",\"serialbatch\":\"OB\",\"quantity\":23,\"maximumQty\":\"10\",\"minimumQty\":\"0\",\"displayQty\":\"10\",\"searchString\":\"1000002C,RED OXIDE PRIMER - 5LTR,RED OXIDE PRIMER - 5LTR,CORAL\",\"category\":\"\",\"liter\":5.000000,\"category1\":\"\",\"weight\":0.000000,\"hsnsac\":\"\",\"isActive\":\"N\",\"isfreeby\":\"FALSE\",\"isinventory\":\"TRUE\",\"issellpricebyscrbat\":\"FALSE\",\"itemnamelong\":\"1000002C,RED OXIDE PRIMER - 5LTR,RED OXIDE PRIMER - 5LTR,CORAL\",\"itemnameshort\":\"RED OXIDE PRIMER - 5LTR\",\"skucode\":\"1000002C\",\"subcategory\":\"\",\"sellprice\":23500.000000,\"mrpprice\":23500.000000,\"specialprice\":23500.000000,\"maxdiscount\":\"50\",\"taxrate\":18.000000,\"snapdatetime\":\"2024-09-16T13:35:10.597\",\"purchasedate\":\"2024-09-16T13:35:10.597\",\"createdateTime\":\"2024-09-16T13:35:10.597\",\"updatedDatetime\":\"2024-09-16T13:35:10.597\",\"createdUserID\":\"1\",\"updateduserid\":\"1\",\"lastupdateIp\":\"\",\"U_Pack_Size\":5.000000,\"U_TINS_PER_BOX\":4,\"U_Specific_Gravity\":1.252600,\"U_Pack_Size_uom\":\"L\"}
  String? hsnsac;
  String? category;
  String? isActive;
  String? isfreeby;
  String? isinventory;
  String? branch;
  String? itemCode;
  String? itemName;
  String? itemnamelong;
  String? itemnameshort;
  String? searchString;
  String? subcategory;
  String? serialBatch;
  String? maxdiscount;
  double? qty;
  double? mrp;
  double? sellPrice;
  double? specialprice;
  double? taxRate;
  double? weight;
  double? liter;
  String? purchasedate;
  String? snapdatetime;
  String? createdateTime;
  String? updatedDatetime;
  String? createdUserID;
  String? updateduserid;
  String? lastupdateIp;
  int? cost;
  String? inDate;
  double? openQty;
  String? inType;
  String? maximumQty;
  String? displayQty;
  String? minimumQty;
  String? invoiceNo;
  String? issellpricebyscrbat;
  String? skuCode;
  double? openRetQty;

  factory StocksnapModelData.fromJson(Map<String, dynamic> json) =>
      StocksnapModelData(
          itemCode: json['itemcode'].toString(),
          shipDate: json['shipDate'].toString(),
          itemName: json['itemname'].toString(),
          serialBatch: json['serialbatch'].toString(),
          branch: json['WhsCode'].toString(),
          mrp: json['mrpprice'],
          sellPrice: json['sellprice'],
          qty: double.parse(json['quantity'].toString()),
          createdUserID: json['createdUserID'].toString(),
          createdateTime: json['createdateTime'].toString(),
          lastupdateIp: json['lastupdateIp'].toString(),
          purchasedate: json['purchasedate'].toString(),
          snapdatetime: json['snapdatetime'].toString(),
          specialprice: json['specialprice'],
          updatedDatetime: json['updatedDatetime'].toString(),
          updateduserid: json['updateduserid'].toString(),
          taxRate: json['taxrate'],
          maxdiscount: json['maxdiscount'].toString(),
          weight: json['weight'],
          liter: json['liter'],
          maximumQty: json['maximumQty'].toString(),
          displayQty: json['displayQty'].toString(),
          minimumQty: json['minimumQty'].toString(),
          uPackSize: json['U_Pack_Size'],
          uTINSPERBOX: json['U_TINS_PER_BOX'],
          uSpecificGravity: json['U_Specific_Gravity'],
          uPackSizeuom: json['U_Pack_Size_uom'].toString(),
          hsnsac: json['hsnsac'].toString(),
          category: json['category'].toString(),
          isActive: json['isActive'].toString(),
          isfreeby: json['isfreeby'].toString(),
          isinventory: json['isinventory'].toString(),
          itemnamelong: json['itemnamelong'].toString(),
          itemnameshort: json['itemnameshort'].toString(),
          searchString: json['searchString'].toString(),
          subcategory: json['subcategory'].toString(),
          issellpricebyscrbat: json['issellpricebyscrbat'].toString(),
          skuCode: json['skuCode'].toString());

  Map<String, Object?> toMap() => {
        PosColumn.branch: branch,
        PosColumn.itemCode: itemCode,
        PosColumn.itemName: itemName,
        PosColumn.transId: transID,
        PosColumn.serialBatch: serialBatch,
        PosColumn.qty: qty,
        PosColumn.openQty: openQty,
        PosColumn.displayQty: displayQty,
        PosColumn.minimumQty: minimumQty,
        PosColumn.inDate: branch,
        PosColumn.inType: itemCode,
        PosColumn.sellPrice: sellPrice,
        PosColumn.mrp: mrp,
        PosColumn.cost: cost,
        PosColumn.taxRate: taxRate,
        PosColumn.maximumQty: maximumQty,
      };
}

class AddItem2 {
  int? transID;

  int? lineNumm;
  String? itemCode;
  String? itemDescription;
  double? quantity;
  dynamic shipDate;
  double? price;
  double? priceAfterVat;
  String? currency;
  double? rate;
  double? discountPercent;
  String? vendorNum;
  dynamic serialNum;
  String? warehouseCode;
  int? salesPersonCode;
  double? commisionPercent;
  String? treeType;
  String? accountCode;
  String? useBaseUnits;
  String? supplierCatNum;
  String? costingCode;
  dynamic projectCode;
  dynamic barCode;
  String? vatGroup;
  double? height1;
  dynamic hight1Unit;
  double? height2;
  dynamic height2Unit;
  double? lengh1;
  dynamic lengh1Unit;
  double? lengh2;
  dynamic lengh2Unit;
  double? weight1;
  dynamic weight1Unit;
  double? weight2;
  dynamic weight2Unit;
  double? factor1;
  double? factor2;
  double? factor3;
  double? factor4;
  int? baseType;
  dynamic baseEntry;
  dynamic baseLine;
  double? volume;
  int? volumeUnit;
  double? width1;
  dynamic width1Unit;
  double? width2;
  dynamic width2Unit;
  String? address;
  dynamic taxCode;
  String? taxType;
  String? taxLiable;
  String? pickStatus;
  double? pickQuantity;
  dynamic pickListIdNumber;
  dynamic originalItem;
  dynamic backOrder;
  String? freeText;
  int? shippingMethod;
  dynamic poTargetNum;
  String? poTargetEntry;
  dynamic poTargetRowNum;
  String? correctionInvoiceItem;
  double? corrInvAmountToStock;
  double? corrInvAmountToDiffAcct;
  double? appliedTax;
  double? appliedTaxFc;
  double? appliedTaxSc;
  String? wtLiable;
  String? deferredTax;
  double? equalizationTaxPercent;
  double? totalEqualizationTax;
  double? totalEqualizationTaxFc;
  double? totalEqualizationTaxSc;
  double? netTaxAmount;
  double? netTaxAmountFc;
  double? netTaxAmountSc;
  String? measureUnit;
  double? unitsOfMeasurment;
  double? lineTotal;
  double? taxPercentagePerRow;
  double? taxTotal;
  String? consumerSalesForecast;
  double? exciseAmount;
  double? taxPerUnit;
  double? totalInclTax;
  dynamic countryOrg;
  String? sww;
  dynamic transactionType;
  String? distributeExpense;
  double? rowTotalFc;
  double? rowTotalSc;
  double? lastBuyInmPrice;
  double? lastBuyDistributeSumFc;
  double? lastBuyDistributeSumSc;
  double? lastBuyDistributeSum;
  double? stockDistributesumForeign;
  double? stockDistributesumSystem;
  double? stockDistributesum;
  double? stockInmPrice;
  String? pickStatusEx;
  double? taxBeforeDpm;
  double? taxBeforeDpmfc;
  double? taxBeforeDpmsc;
  dynamic cfopCode;
  dynamic cstCode;
  dynamic usage;
  String? taxOnly;
  int? visualOrder;
  double? baseOpenQuantity;
  double? unitPrice;
  String? lineStatus;
  double? packageQuantity;
  String? text;
  String? lineType;
  String? cogsCostingCode;
  String? cogsAccountCode;
  String? changeAssemlyBoMWarehouse;
  double? grossBuyPrice;
  int? grossBase;
  double? grossProfitTotalBasePrice;
  dynamic costingCode2;
  dynamic costingCode3;
  dynamic costingCode4;
  dynamic costingCode5;
  dynamic itemDetails;
  dynamic locationCode;
  dynamic actualDeliveryDate;
  double? remainingOpenQuantity;
  double? openAmount;
  double? openAmountFc;
  double? openAmountSc;
  dynamic exLineNo;
  dynamic Date;
  double? Quantity;
  dynamic cogsCostingCode2;
  dynamic cogsCostingCode3;
  dynamic cogsCostingCode4;
  dynamic cogsCostingCode5;
  dynamic csTforIpi;
  dynamic csTforPis;
  dynamic csTforCofins;
  dynamic creditOriginCode;
  String? withoutInventoryMovement;
  dynamic agreementNo;
  dynamic agreementRowNumber;
  dynamic actualBaseEntry;
  dynamic actualBaseLine;
  int? docEntry;
  double? surpluses;
  double? defectAndBreakup;
  double? shortages;
  String? considerQuantity;
  String? partialRetirement;
  double? retirementQuantity;
  double? retirementApc;
  String? thirdParty;
  dynamic poNum;
  dynamic poItmNum;
  dynamic expenseType;
  dynamic receiptNumber;
  dynamic expenseOperationType;
  dynamic federalTaxId;
  double? grossProfit;
  double? grossProfitFc;
  double? grossProfitSc;
  String? priceSource;
  dynamic stgSeqNum;
  dynamic stgEntry;
  dynamic stgDesc;
  int? uoMEntry;
  String? uoMCode;
  double? inventoryQuantity;
  double? remainingOpenInventoryQuantity;
  dynamic parentLineNum;
  int? incoterms;
  int? transportMode;
  dynamic natureOfTransaction;
  dynamic destinationCountryForImport;
  dynamic destinationRegionForImport;
  dynamic originCountryForExport;
  dynamic originRegionForExport;
  String? itemType;
  String? changeInventoryQuantityIndependently;
  String? freeOfChargeBp;
  dynamic sacEntry;
  dynamic hsnEntry;
  double? grossPrice;
  double? grossTotal;
  double? grossTotalFc;
  double? grossTotalSc;
  int? ncmCode;
  dynamic nveCode;
  String? indEscala;
  double? ctrSealQty;
  dynamic cnjpMan;
  int? cestCode;
  dynamic ufFiscalBenefitCode;
  String? shipToCode;
  String? shipToDescription;
  double? externalCalcTaxRate;
  double? externalCalcTaxAmount;
  double? externalCalcTaxAmountFc;
  double? externalCalcTaxAmountSc;
  int? standardItemIdentification;
  int? commodityClassification;
  dynamic unencumberedReason;
  String? cuSplit;
  dynamic uQtyOrdered;
  dynamic uOpenQty;
  dynamic uTonnage;
  dynamic uPackSize;
  dynamic uProfitCentre;
  dynamic uNumberDrums;
  dynamic uDrumSize;
  dynamic uPails;
  dynamic uCartons;
  dynamic uLooseTins;
  dynamic uNettWt;
  dynamic uGrossWt;
  dynamic uAppLinId;
  dynamic uMuQty;
  dynamic uRvc;
  dynamic uVrn;
  dynamic uIdentifier;
  String? itemName;
  double? qty;
  double? discount;
  double? total;
  double? tax;
  double? taxPer;
  String? valuechoosed;
  double? discounpercent;
  String? warehouse;
  double? valueAF;
  int? carton;
  int? lineNoo;
  double? U_Pack_Size;
  int? U_Tins_Per_Box;
  // List<dynamic> lineTaxJurisdictions;
  // List<dynamic> documentLineAdditionalExpenses;

  AddItem2(
      {this.lineNumm,
      this.transID,
      this.itemCode,
      this.itemDescription,
      this.quantity,
      this.shipDate,
      this.price,
      this.priceAfterVat,
      this.currency,
      this.rate,
      this.discountPercent,
      this.vendorNum,
      this.serialNum,
      this.warehouseCode,
      this.salesPersonCode,
      this.commisionPercent,
      this.treeType,
      this.accountCode,
      this.useBaseUnits,
      this.supplierCatNum,
      this.costingCode,
      this.projectCode,
      this.barCode,
      this.vatGroup,
      this.height1,
      this.hight1Unit,
      this.height2,
      this.height2Unit,
      this.lengh1,
      this.lengh1Unit,
      this.lengh2,
      this.lengh2Unit,
      this.weight1,
      this.weight1Unit,
      this.weight2,
      this.weight2Unit,
      this.factor1,
      this.factor2,
      this.factor3,
      this.factor4,
      this.baseType,
      this.baseEntry,
      this.baseLine,
      this.volume,
      this.volumeUnit,
      this.width1,
      this.width1Unit,
      this.width2,
      this.width2Unit,
      this.address,
      required this.taxCode,
      this.taxType,
      this.taxLiable,
      this.pickStatus,
      this.pickQuantity,
      this.pickListIdNumber,
      this.originalItem,
      this.backOrder,
      this.freeText,
      this.shippingMethod,
      this.poTargetNum,
      this.poTargetEntry,
      this.poTargetRowNum,
      this.correctionInvoiceItem,
      this.corrInvAmountToStock,
      this.corrInvAmountToDiffAcct,
      this.appliedTax,
      this.appliedTaxFc,
      this.appliedTaxSc,
      this.wtLiable,
      this.deferredTax,
      this.equalizationTaxPercent,
      this.totalEqualizationTax,
      this.totalEqualizationTaxFc,
      this.totalEqualizationTaxSc,
      this.netTaxAmount,
      this.netTaxAmountFc,
      this.netTaxAmountSc,
      this.measureUnit,
      this.unitsOfMeasurment,
      this.lineTotal,
      this.taxPercentagePerRow,
      this.taxTotal,
      this.consumerSalesForecast,
      this.exciseAmount,
      this.taxPerUnit,
      this.totalInclTax,
      this.countryOrg,
      this.sww,
      this.transactionType,
      this.distributeExpense,
      this.rowTotalFc,
      this.rowTotalSc,
      this.lastBuyInmPrice,
      this.lastBuyDistributeSumFc,
      this.lastBuyDistributeSumSc,
      this.lastBuyDistributeSum,
      this.stockDistributesumForeign,
      this.stockDistributesumSystem,
      this.stockDistributesum,
      this.stockInmPrice,
      this.pickStatusEx,
      this.taxBeforeDpm,
      this.taxBeforeDpmfc,
      this.taxBeforeDpmsc,
      this.cfopCode,
      this.cstCode,
      this.usage,
      this.taxOnly,
      this.visualOrder,
      this.baseOpenQuantity,
      this.unitPrice,
      this.lineStatus,
      this.packageQuantity,
      this.text,
      this.lineType,
      this.cogsCostingCode,
      this.cogsAccountCode,
      this.changeAssemlyBoMWarehouse,
      this.grossBuyPrice,
      this.grossBase,
      this.grossProfitTotalBasePrice,
      this.costingCode2,
      this.costingCode3,
      this.costingCode4,
      this.costingCode5,
      this.itemDetails,
      this.locationCode,
      this.actualDeliveryDate,
      this.remainingOpenQuantity,
      this.openAmount,
      this.openAmountFc,
      this.openAmountSc,
      this.exLineNo,
      this.Date,
      this.Quantity,
      this.cogsCostingCode2,
      this.cogsCostingCode3,
      this.cogsCostingCode4,
      this.cogsCostingCode5,
      this.csTforIpi,
      this.csTforPis,
      this.csTforCofins,
      this.creditOriginCode,
      this.withoutInventoryMovement,
      this.agreementNo,
      this.agreementRowNumber,
      this.actualBaseEntry,
      this.actualBaseLine,
      this.docEntry,
      this.surpluses,
      this.defectAndBreakup,
      this.shortages,
      this.considerQuantity,
      this.partialRetirement,
      this.retirementQuantity,
      this.retirementApc,
      this.thirdParty,
      this.poNum,
      this.poItmNum,
      this.expenseType,
      this.receiptNumber,
      this.expenseOperationType,
      this.federalTaxId,
      this.grossProfit,
      this.grossProfitFc,
      this.grossProfitSc,
      this.priceSource,
      this.stgSeqNum,
      this.stgEntry,
      this.stgDesc,
      this.uoMEntry,
      this.uoMCode,
      this.inventoryQuantity,
      this.remainingOpenInventoryQuantity,
      this.parentLineNum,
      this.incoterms,
      this.transportMode,
      this.natureOfTransaction,
      this.destinationCountryForImport,
      this.destinationRegionForImport,
      this.originCountryForExport,
      this.originRegionForExport,
      this.itemType,
      this.changeInventoryQuantityIndependently,
      this.freeOfChargeBp,
      this.sacEntry,
      this.hsnEntry,
      this.grossPrice,
      this.grossTotal,
      this.grossTotalFc,
      this.grossTotalSc,
      this.ncmCode,
      this.nveCode,
      this.indEscala,
      this.ctrSealQty,
      this.cnjpMan,
      this.cestCode,
      this.ufFiscalBenefitCode,
      this.shipToCode,
      this.shipToDescription,
      this.externalCalcTaxRate,
      this.externalCalcTaxAmount,
      this.externalCalcTaxAmountFc,
      this.externalCalcTaxAmountSc,
      this.standardItemIdentification,
      this.commodityClassification,
      this.unencumberedReason,
      this.cuSplit,
      this.uQtyOrdered,
      this.uOpenQty,
      this.uTonnage,
      this.uPackSize,
      this.uProfitCentre,
      this.uNumberDrums,
      this.uDrumSize,
      this.uPails,
      this.uCartons,
      this.uLooseTins,
      this.uNettWt,
      this.uGrossWt,
      this.uAppLinId,
      this.uMuQty,
      this.uRvc,
      this.uVrn,
      this.uIdentifier,
      this.warehouse,
      this.itemName,
      this.discount,
      this.qty,
      this.total,
      this.tax,
      this.valuechoosed,
      this.discounpercent,
      this.taxPer,
      this.valueAF,
      this.lineNoo,
      this.carton,
      this.U_Pack_Size,
      this.U_Tins_Per_Box
      //  this.lineTaxJurisdictions,
      //  this.documentLineAdditionalExpenses,
      });

  Map<String, dynamic> toJson() => {
        'LineNum': lineNumm,
        'ItemCode': itemCode,
        'ItemDescription': itemDescription,
        'Quantity': quantity,
        'ShipDate': shipDate,
        'Price': price,
        'PriceAfterVAT': priceAfterVat,
        'Currency': currency,
        'Rate': rate,
        'DiscountPercent': discountPercent,
        'VendorNum': vendorNum,
        'SerialNum': serialNum,
        'WarehouseCode': warehouseCode,
        'SalesPersonCode': salesPersonCode,
        'CommisionPercent': commisionPercent,
        'TreeType': treeType,
        'AccountCode': accountCode,
        'UseBaseUnits': useBaseUnits,
        'SupplierCatNum': supplierCatNum,
        'CostingCode': costingCode,
        'ProjectCode': projectCode,
        'BarCode': barCode,
        'VatGroup': vatGroup,
        'Height1': height1,
        'Hight1Unit': hight1Unit,
        'Height2': height2,
        'Height2Unit': height2Unit,
        'Lengh1': lengh1,
        'Lengh1Unit': lengh1Unit,
        'Lengh2': lengh2,
        'Lengh2Unit': lengh2Unit,
        'Weight1': weight1,
        'Weight1Unit': weight1Unit,
        'Weight2': weight2,
        'Weight2Unit': weight2Unit,
        'Factor1': factor1,
        'Factor2': factor2,
        'Factor3': factor3,
        'Factor4': factor4,
        'BaseType': baseType,
        'BaseEntry': baseEntry,
        'BaseLine': baseLine,
        'Volume': volume,
        'VolumeUnit': volumeUnit,
        'Width1': width1,
        'Width1Unit': width1Unit,
        'Width2': width2,
        'Width2Unit': width2Unit,
        'Address': address,
        'TaxCode': taxCode,
        'TaxType': taxType,
        'TaxLiable': taxLiable,
        'PickStatus': pickStatus,
        'PickQuantity': pickQuantity,
        'PickListIdNumber': pickListIdNumber,
        'OriginalItem': originalItem,
        'BackOrder': backOrder,
        'FreeText': freeText,
        'ShippingMethod': shippingMethod,
        'POTargetNum': poTargetNum,
        'POTargetEntry': poTargetEntry,
        'POTargetRowNum': poTargetRowNum,
        'CorrectionInvoiceItem': correctionInvoiceItem,
        'CorrInvAmountToStock': corrInvAmountToStock,
        'CorrInvAmountToDiffAcct': corrInvAmountToDiffAcct,
        'AppliedTax': appliedTax,
        'AppliedTaxFC': appliedTaxFc,
        'AppliedTaxSC': appliedTaxSc,
        'WTLiable': wtLiable,
        'DeferredTax': deferredTax,
        'EqualizationTaxPercent': equalizationTaxPercent,
        'TotalEqualizationTax': totalEqualizationTax,
        'TotalEqualizationTaxFC': totalEqualizationTaxFc,
        'TotalEqualizationTaxSC': totalEqualizationTaxSc,
        'NetTaxAmount': netTaxAmount,
        'NetTaxAmountFC': netTaxAmountFc,
        'NetTaxAmountSC': netTaxAmountSc,
        'MeasureUnit': measureUnit,
        'UnitsOfMeasurment': unitsOfMeasurment,
        'LineTotal': lineTotal,
        'TaxPercentagePerRow': taxPercentagePerRow,
        'TaxTotal': taxTotal,
        'ConsumerSalesForecast': consumerSalesForecast,
        'ExciseAmount': exciseAmount,
        'TaxPerUnit': taxPerUnit,
        'TotalInclTax': totalInclTax,
        'CountryOrg': countryOrg,
        'SWW': sww,
        'TransactionType': transactionType,
        'DistributeExpense': distributeExpense,
        'RowTotalFC': rowTotalFc,
        'RowTotalSC': rowTotalSc,
        'LastBuyInmPrice': lastBuyInmPrice,
        'LastBuyDistributeSumFc': lastBuyDistributeSumFc,
        'LastBuyDistributeSumSc': lastBuyDistributeSumSc,
        'LastBuyDistributeSum': lastBuyDistributeSum,
        'StockDistributesumForeign': stockDistributesumForeign,
        'StockDistributesumSystem': stockDistributesumSystem,
        'StockDistributesum': stockDistributesum,
        'StockInmPrice': stockInmPrice,
        'PickStatusEx': pickStatusEx,
        'TaxBeforeDPM': taxBeforeDpm,
        'TaxBeforeDPMFC': taxBeforeDpmfc,
        'TaxBeforeDPMSC': taxBeforeDpmsc,
        'CFOPCode': cfopCode,
        'CSTCode': cstCode,
        'Usage': usage,
        'TaxOnly': taxOnly,
        'VisualOrder': visualOrder,
        'BaseOpenQuantity': baseOpenQuantity,
        'UnitPrice': unitPrice,
        'LineStatus': lineStatus,
        'PackageQuantity': packageQuantity,
        'Text': text,
        'LineType': lineType,
        'COGSCostingCode': cogsCostingCode,
        'COGSAccountCode': cogsAccountCode,
        'ChangeAssemlyBoMWarehouse': changeAssemlyBoMWarehouse,
        'GrossBuyPrice': grossBuyPrice,
        'GrossBase': grossBase,
        'GrossProfitTotalBasePrice': grossProfitTotalBasePrice,
        'CostingCode2': costingCode2,
        'CostingCode3': costingCode3,
        'CostingCode4': costingCode4,
        'CostingCode5': costingCode5,
        'ItemDetails': itemDetails,
        'LocationCode': locationCode,
        'ActualDeliveryDate': actualDeliveryDate,
        'RemainingOpenQuantity': remainingOpenQuantity,
        'OpenAmount': openAmount,
        'OpenAmountFC': openAmountFc,
        'OpenAmountSC': openAmountSc,
        'ExLineNo': exLineNo,
        ' Date': Date,
        ' Quantity': Quantity,
        'COGSCostingCode2': cogsCostingCode2,
        'COGSCostingCode3': cogsCostingCode3,
        'COGSCostingCode4': cogsCostingCode4,
        'COGSCostingCode5': cogsCostingCode5,
        'CSTforIPI': csTforIpi,
        'CSTforPIS': csTforPis,
        'CSTforCOFINS': csTforCofins,
        'CreditOriginCode': creditOriginCode,
        'WithoutInventoryMovement': withoutInventoryMovement,
        'AgreementNo': agreementNo,
        'AgreementRowNumber': agreementRowNumber,
        'ActualBaseEntry': actualBaseEntry,
        'ActualBaseLine': actualBaseLine,
        'DocEntry': docEntry,
        'Surpluses': surpluses,
        'DefectAndBreakup': defectAndBreakup,
        'Shortages': shortages,
        'ConsiderQuantity': considerQuantity,
        'PartialRetirement': partialRetirement,
        'RetirementQuantity': retirementQuantity,
        'RetirementAPC': retirementApc,
        'ThirdParty': thirdParty,
        'PoNum': poNum,
        'PoItmNum': poItmNum,
        'ExpenseType': expenseType,
        'ReceiptNumber': receiptNumber,
        'ExpenseOperationType': expenseOperationType,
        'FederalTaxID': federalTaxId,
        'GrossProfit': grossProfit,
        'GrossProfitFC': grossProfitFc,
        'GrossProfitSC': grossProfitSc,
        'PriceSource': priceSource,
        'StgSeqNum': stgSeqNum,
        'StgEntry': stgEntry,
        'StgDesc': stgDesc,
        'UoMEntry': uoMEntry,
        'UoMCode': uoMCode,
        'InventoryQuantity': inventoryQuantity,
        'RemainingOpenInventoryQuantity': remainingOpenInventoryQuantity,
        'ParentLineNum': parentLineNum,
        'Incoterms': incoterms,
        'TransportMode': transportMode,
        'NatureOfTransaction': natureOfTransaction,
        'DestinationCountryForImport': destinationCountryForImport,
        'DestinationRegionForImport': destinationRegionForImport,
        'OriginCountryForExport': originCountryForExport,
        'OriginRegionForExport': originRegionForExport,
        'ItemType': itemType,
        'ChangeInventoryQuantityIndependently':
            changeInventoryQuantityIndependently,
        'FreeOfChargeBP': freeOfChargeBp,
        'SACEntry': sacEntry,
        'HSNEntry': hsnEntry,
        'GrossPrice': grossPrice,
        'GrossTotal': grossTotal,
        'GrossTotalFC': grossTotalFc,
        'GrossTotalSC': grossTotalSc,
        'NCMCode': ncmCode,
        'NVECode': nveCode,
        'IndEscala': indEscala,
        'CtrSealQty': ctrSealQty,
        'CNJPMan': cnjpMan,
        'CESTCode': cestCode,
        'UFFiscalBenefitCode': ufFiscalBenefitCode,
        'ShipToCode': shipToCode,
        'ShipToDescription': shipToDescription,
        'ExternalCalcTaxRate': externalCalcTaxRate,
        'ExternalCalcTaxAmount': externalCalcTaxAmount,
        'ExternalCalcTaxAmountFC': externalCalcTaxAmountFc,
        'ExternalCalcTaxAmountSC': externalCalcTaxAmountSc,
        'StandardItemIdentification': standardItemIdentification,
        'CommodityClassification': commodityClassification,
        'UnencumberedReason': unencumberedReason,
        'CUSplit': cuSplit,
        'U_Qty_Ordered': uQtyOrdered,
        'U_Open_Qty': uOpenQty,
        'U_Tonnage': uTonnage,
        'U_PackSize': uPackSize,
        'U_Profit_Centre': uProfitCentre,
        'U_Number_Drums': uNumberDrums,
        'U_Drum_Size': uDrumSize,
        'U_Pails': uPails,
        'U_Cartons': uCartons,
        'U_Loose_Tins': uLooseTins,
        'U_Nett_Wt': uNettWt,
        'U_Gross_Wt': uGrossWt,
        'U_AppLinId': uAppLinId,
        'U_MUQty': uMuQty,
        'U_RVC': uRvc,
        'U_VRN': uVrn,
        'U_Identifier': uIdentifier,
        // 'LineTaxJurisdictions': List<dynamic>.from(lineTaxJurisdictions.map((x) => x)),
        // 'DocumentLineAdditionalExpenses': List<dynamic>.from(documentLineAdditionalExpenses.map((x) => x)),
      };
}
