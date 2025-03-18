import 'dart:async';
import 'package:posproject/DBModel/HSNDBModel.dart';
import 'package:posproject/DBModel/SalesHeader.dart';
import 'package:posproject/DBModel/SalesQuotationLine.dart';
import 'package:posproject/DBModel/SalesReturnLineT.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../DBModel/Branch.dart';
import '../DBModel/BrandDBModel.dart';
import '../DBModel/CategoryDBModel.dart';
import '../DBModel/CountryDBModel.dart';
import '../DBModel/CouponDetailsDBModel.dart';
import '../DBModel/CurrencyDBModel.dart';
import '../DBModel/CustomerMaster.dart';
import '../DBModel/CustomerMasterAddress.dart';
import '../DBModel/CustomerTrans.dart';
import '../DBModel/DocumentNumberingDbModel.dart';
import '../DBModel/ExpenseDBModel.dart';
import '../DBModel/ExpenseMaster.dart';
import '../DBModel/ItemMaster.dart';
import '../DBModel/NotificationModel.dart';
import '../DBModel/NumberingSeries.dart';
import '../DBModel/PriceMaster.dart';
import '../DBModel/Receipt.dart';
import '../DBModel/ReceiptLine2.dart';
import '../DBModel/RecieptLine1.dart';
import '../DBModel/RefundLine.dart';
import '../DBModel/RefundPayment.dart';
import '../DBModel/Refundheader.dart';
import '../DBModel/SalesLineDBModel.dart';
import '../DBModel/SalesOrderHeader.dart';
import '../DBModel/SalesOrderLineDB.dart';
import '../DBModel/SalesOrderPay.dart';
import '../DBModel/SalesPay.dart';
import '../DBModel/SalesQuotationHead.dart';
import '../DBModel/SalesReturnHeadT.dart';
import '../DBModel/SalesReturnPayT.dart';
import '../DBModel/SetUpPriceMaster.dart';

import '../DBModel/SettlementHeader.dart';
import '../DBModel/SettlementLineDBModel.dart';
import '../DBModel/StateDBModel.dart';
import '../DBModel/StockInwardBatchModel.dart';
import '../DBModel/StockOutwardBatchModel.dart';
import '../DBModel/StockOutwardHeader.dart';
import '../DBModel/StockOutwardLineData.dart';
import '../DBModel/StockReqLine.dart';
import '../DBModel/StockRequestHD.dart';
import '../DBModel/StockSnap.dart';
import '../DBModel/StockTrans.dart';
import '../DBModel/StockinwardHeader.dart';
import '../DBModel/StockinwardLineData.dart';
import '../DBModel/SubCategoryDBModel.dart';
import '../DBModel/UserDBModel.dart';
import '../DBModel/paidfromModel.dart';

class DBHelper {
  static Database? _db;

  DBHelper._() {}

  static Future<Database?> getInstance() async {
    String path = await getDatabasesPath();
    if (_db == null) {
      _db = await openDatabase(join(path, 'PosDBV2.db'),
          version: 1, onCreate: createTable);
    }
    return _db;
  }

  static void createTable(Database database, int version) async {
//     await database.execute('''
//  create table $tableItemMaster(
//  ${ItemMasterT.autoId} integer ,
//  ${ItemMasterT.quantity} integer ,
//  ${ItemMasterT.isselected} integer ,
//  ${ItemMasterT.itemcode} varchar(100) not null,
//  ${ItemMasterT.itemnamelong} varchar(300) not null,
//  ${ItemMasterT.itemnameshort} varchar(50) ,
//  ${ItemMasterT.skucode} varchar(100) ,
//  ${ItemMasterT.brand} varchar(100) ,
//  ${ItemMasterT.category}  varchar(100) ,
//  ${ItemMasterT.subcategory} varchar(100) ,
//  ${ItemMasterT.sellprice}  varchar(100) ,
//  ${ItemMasterT.mrpprice} varchar(100) ,
//  ${ItemMasterT.hsnsac} varchar(20) ,
//  ${ItemMasterT.taxrate} NUMERIC ,
//  ${ItemMasterT.isinventory}  varchar(1) ,
//  ${ItemMasterT.isfreeby}  varchar(1) ,
//  ${ItemMasterT.isActive} varchar(1) ,
//  ${ItemMasterT.isserialBatch} varchar(1) ,
//  ${ItemMasterT.issellpricebyscrbat} varchar(1) ,
//  ${ItemMasterT.maxdiscount} NUMERIC ,
//  ${ItemMasterT.createdateTime}  datetime ,
//  ${ItemMasterT.updatedDatetime} datetime,
//  ${ItemMasterT.createdUserID}  integer ,
//  ${ItemMasterT.updateduserid} integer,
//  ${ItemMasterT.lastupdateIp} varchar,
//  ${ItemMasterT.maximumQty} integer ,
//  ${ItemMasterT.minimumQty} integer ,
//  ${ItemMasterT.displayQty} integer ,
//  ${ItemMasterT.weight} NUMERIC ,
//  ${ItemMasterT.liter} NUMERIC ,
//  ${ItemMasterT.uPackSizeuom} varchar,
//  ${ItemMasterT.uPackSize} varchar,
//  ${ItemMasterT.uTINSPERBOX} NUMERIC,
//  ${ItemMasterT.uSpecificGravity} varchar,
//  ${ItemMasterT.searchString} varchar
//  )  ''');

    await database.execute('''
 create table $tableItemMaster(

${ItemMasterT.itemname} varchar,
${ItemMasterT.itemcode} varchar,
${ItemMasterT.maximumQty} varchar,
${ItemMasterT.minimumQty} varchar,
${ItemMasterT.displayQty} varchar,
${ItemMasterT.searchString} varchar,
${ItemMasterT.category} varchar,
${ItemMasterT.BRAND} varchar,
${ItemMasterT.liter} varchar,
${ItemMasterT.category1} varchar,
${ItemMasterT.BRAND1} varchar,
${ItemMasterT.weight} varchar,
${ItemMasterT.hsnsac} varchar,
${ItemMasterT.isActive} varchar,
${ItemMasterT.isfreeby} varchar,
${ItemMasterT.isinventory} varchar,
${ItemMasterT.issellpricebyscrbat} varchar,
${ItemMasterT.itemnamelong} varchar,
${ItemMasterT.taxrate} varchar,
${ItemMasterT.itemnameshort} varchar,
${ItemMasterT.skucode} varchar,
${ItemMasterT.subcategory} varchar,
${ItemMasterT.sellprice} varchar,
${ItemMasterT.mrpprice} varchar,
${ItemMasterT.specialprice} varchar,
${ItemMasterT.maxdiscount} varchar,
${ItemMasterT.snapdatetime} varchar,
${ItemMasterT.purchasedate} varchar,
${ItemMasterT.createdateTime} varchar,
${ItemMasterT.updatedDatetime} varchar,
${ItemMasterT.createdUserID} varchar,
${ItemMasterT.updateduserid} varchar,
${ItemMasterT.lastupdateIp} varchar,
${ItemMasterT.U_Pack_Size} varchar,
${ItemMasterT.U_TINS_PER_BOX} varchar,
${ItemMasterT.U_Specific_Gravity} varchar,
${ItemMasterT.U_Pack_Size_uom} varchar,
AutoId INTEGER primary key AUTOINCREMENT
 )  ''');

    await database.execute('''
 create table $tablePriceMaster(
 ${PriceMasterT.itemcode} varchar(100) not null,
 ${PriceMasterT.pricelistID} integer ,
 ${PriceMasterT.currencycode} integer ,
 ${PriceMasterT.price}  NUMERIC ,
 ${PriceMasterT.createdateTime}  datetime ,
 ${PriceMasterT.updatedDatetime} datetime,
 ${PriceMasterT.createdUserID}  integer ,
 ${PriceMasterT.updateduserid} integer,
 ${PriceMasterT.lastupdateIp} varchar 
 )''');

//     await database.execute('''
//  create table $tableCustomerMaster(
//   ${CustomerMasterT.autoid}  INTEGER primary key AUTOINCREMENT,
//  ${CustomerMasterT.customerCode} varchar(50) ,
//  ${CustomerMasterT.customername} varchar(200) ,
//  ${CustomerMasterT.premiumid} varchar(50) ,
//  ${CustomerMasterT.customertype}  varchar(50) ,
//  ${CustomerMasterT.taxno} varchar(15) ,
//  ${CustomerMasterT.taxCode} varchar(15) ,
//  ${CustomerMasterT.createdbybranch} varchar(50) ,
//  ${CustomerMasterT.balance} NUMERIC,
//  ${CustomerMasterT.points}  NUMERIC ,
//  ${CustomerMasterT.snapdatetime} datetime ,
//  ${CustomerMasterT.phoneno1} varchar(50) ,
//  ${CustomerMasterT.phoneno2}  varchar(50) ,
//  ${CustomerMasterT.emalid} varchar(100) ,
//  ${CustomerMasterT.tinNo} varchar(100) ,
//  ${CustomerMasterT.vatregno} varchar(100) ,
//  ${CustomerMasterT.terminal} varchar(100) ,
//  ${CustomerMasterT.createdateTime}  datetime ,
//  ${CustomerMasterT.updatedDatetime} datetime,
//  ${CustomerMasterT.createdUserID}  integer ,
//  ${CustomerMasterT.updateduserid} integer,
//  ${CustomerMasterT.lastupdateIp} varchar
//  ) ''');

// customerCode	customername	premiumid	customertype	taxno	createdbybranch	balance	points	snapdatetime	phoneno1
// 	phoneno2	emalid	createdateTime	updatedDatetime	createdUserID	updateduserid	lastupdateIp	TaxCode	U_CASHCUST
    await database.execute('''
 create table $tableCustomerMaster(
 ${CustomerMasterT.customerCode} varchar,
 ${CustomerMasterT.customername} varchar,
 ${CustomerMasterT.premiumid} varchar,
 ${CustomerMasterT.customertype} varchar,
 ${CustomerMasterT.taxno} varchar,
 ${CustomerMasterT.createdbybranch} varchar,
 ${CustomerMasterT.balance} varchar,
 ${CustomerMasterT.points} varchar,
 ${CustomerMasterT.snapdatetime} varchar,
 ${CustomerMasterT.phoneno1} varchar,
 ${CustomerMasterT.phoneno2} varchar,
 ${CustomerMasterT.emalid} varchar,
 ${CustomerMasterT.createdateTime} varchar,
 ${CustomerMasterT.updatedDatetime} varchar,
 ${CustomerMasterT.createdUserID} varchar,
 ${CustomerMasterT.updateduserid} varchar,
 ${CustomerMasterT.lastupdateIp} varchar,
 ${CustomerMasterT.TaxCode} varchar,
 ${CustomerMasterT.uCashCust} varchar,
  autoid INTEGER primary key AUTOINCREMENT
 ) ''');
    //

    await database.execute('''
 create table $tableCustomerMasterAdress(
 ${CustomerMasterAddressT.autoid}  INTEGER primary key AUTOINCREMENT,
 ${CustomerMasterAddressT.custcode}  varchar(50),
 ${CustomerMasterAddressT.addresstype}  varchar(10),
 ${CustomerMasterAddressT.address1} varchar(300),
 ${CustomerMasterAddressT.address2} varchar(300),
 ${CustomerMasterAddressT.address3} varchar(300),
 ${CustomerMasterAddressT.city} varchar(100),
 ${CustomerMasterAddressT.statecode} varchar(50) ,
  ${CustomerMasterAddressT.pincode} varchar(50) ,
 ${CustomerMasterAddressT.countrycode} varchar(50) ,
 ${CustomerMasterAddressT.geolocation1} varchar(300) ,
 ${CustomerMasterAddressT.geolocation2}  varchar(300) ,
 ${CustomerMasterAddressT.branch} varchar(300) ,
 ${CustomerMasterAddressT.terminal} varchar(300) ,
 ${CustomerMasterAddressT.createdateTime}  datetime ,
 ${CustomerMasterAddressT.updatedDatetime} datetime,
 ${CustomerMasterAddressT.createdUserID}  integer ,
 ${CustomerMasterAddressT.updateduserid} integer ,
 ${CustomerMasterAddressT.lastupdateIp} varchar 
 )''');

    await database.execute('''
 create table $tableUsers(
 ${UsersT.autoId}  INTEGER primary key AUTOINCREMENT,
 ${UsersT.usercode}  varchar(50)  not null ,
 ${UsersT.userName} varchar(100) ,
 ${UsersT.password} varchar(100) ,
 ${UsersT.lockpin} integer,
 ${UsersT.branch} varchar(50) ,
 ${UsersT.terminal} varchar(50) ,
 ${UsersT.userstatus} varchar(1) ,
 ${UsersT.usertype} varchar(50) ,
 ${UsersT.licensekey}  varchar(500) ,
 ${UsersT.lastpasswordchanged}  DATETIME,
 ${UsersT.createdateTime}  DATETIME,
 ${UsersT.updatedDatetime} DATETIME,
 ${UsersT.createdUserID}  integer ,
 ${UsersT.updateduserid} integer ,
 ${UsersT.lastupdateIp} varchar 
 )''');

    await database.execute('''
 create table $tableBranch(
 ${BranchT.whsCode} varchar(50) ,
 ${BranchT.whsName} varchar(200) ,
 ${BranchT.gitWhs}  varchar(200),
 ${BranchT.cashAccount}  varchar(200),
 ${BranchT.walletAccount} varchar(200) ,
 ${BranchT.creditAccount} varchar(100) ,
 ${BranchT.chequeAccount} varchar(5) ,
 ${BranchT.transFerAccount} varchar(5),
 ${BranchT.location} varchar(200) ,
 ${BranchT.companyName} varchar(300) ,
 ${BranchT.companyHeader} varchar(100) ,
 ${BranchT.e_Mail} varchar(500) 
 )''');
//  ${BranchT.customerAcct} varchar(20) ,
// ${BranchT.disAcct1} varchar(200) ,
//  ${BranchT.disAcct2} varchar(100) ,
//  ${BranchT.creditCard} varchar(200) ,
//  ${BranchT.stateCode} varchar(50) ,
//  ${BranchT.gSTNo} varchar(50) ,

//  ${BranchT.pAN}   varchar(50) ,
//  ${BranchT.address1} varchar(50) ,
//  ${BranchT.address2}  varchar(50) ,
//  ${BranchT.pincode}  varchar(50) ,
// ${BranchT.city} varchar(50)
    await database.execute('''
 create table $tableState(
 ${StateT.stateCode} varchar(5) ,
 ${StateT.countrycode} varchar(5) ,
 ${StateT.statename}  varchar(100),
 ${StateT.taxstatecode} varchar(10) ,
 ${StateT.createdateTime}  datetime ,
 ${StateT.updatedDatetime} datetime,
 ${StateT.createdUserID}  integer ,
 ${StateT.updateduserid} integer ,
 ${StateT.lastupdateIp} varchar 
 )''');

    await database.execute('''
 create table $tableCountry(
 ${CountryT.countrycode} varchar(5) ,
 ${CountryT.countryname} varchar(200) ,
 ${CountryT.createdateTime}  datetime ,
 ${CountryT.updatedDatetime} datetime,
 ${CountryT.createdUserID}  integer ,
 ${CountryT.updateduserid} integer ,
 ${CountryT.lastupdateIp} varchar 
 )''');

    await database.execute('''
 create table $tableBrand(
 ${BrandT.brandname} varchar(100) ,
 ${BrandT.createdateTime}  datetime ,
 ${BrandT.updatedDatetime} datetime,
 ${BrandT.createdUserID}  integer ,
 ${BrandT.updateduserid} integer ,
 ${BrandT.lastupdateIp} varchar 
 )''');

    await database.execute('''
 create table $tableCategory(
 ${CategoryT.categoryname} varchar(100) ,
 ${CategoryT.createdateTime}  datetime ,
 ${CategoryT.updatedDatetime} datetime,
 ${CategoryT.createdUserID}  integer ,
 ${CategoryT.updateduserid} integer ,
 ${CategoryT.lastupdateIp} varchar 
 )''');

    await database.execute('''
 create table $tableSubCategory(
 ${SubCategoryT.subcategoryname} varchar(100) ,
 ${SubCategoryT.createdateTime}  datetime ,
 ${SubCategoryT.updatedDatetime} datetime,
 ${SubCategoryT.createdUserID}  integer ,
 ${SubCategoryT.updateduserid} integer ,
 ${SubCategoryT.lastupdateIp} varchar 
 )''');

    await database.execute('''
 create table $tableHSNMaster(
  ${HSNMasterT.hsncode} varchar(20) ,
  ${HSNMasterT.taxrate} NUMERIC,
  ${HSNMasterT.createdateTime}  datetime ,
  ${HSNMasterT.updatedDatetime} datetime,
  ${HSNMasterT.createdUserID}  integer ,
  ${HSNMasterT.updateduserid} integer ,
  ${HSNMasterT.lastupdateIp} varchar 
 )''');

    await database.execute('''
 create table $tableCurrency(
  ${CurrencyT.currencycode} varchar(50) ,
  ${CurrencyT.currencyname} varchar(200),
  ${CurrencyT.currencysymbol} varchar(3),
  ${CurrencyT.createdateTime}  datetime ,
  ${CurrencyT.updatedDatetime} datetime,
  ${CurrencyT.createdUserID}  integer ,
  ${CurrencyT.updateduserid} integer ,
  ${CurrencyT.lastupdateIp} varchar 
 )''');

    await database.execute('''
 create table $tableSetUPPriceMaster(
  ${PriceMasterSetUPT.pricelistid} INTEGER primary key AUTOINCREMENT ,
  ${PriceMasterSetUPT.pricelistname} varchar(100),
  ${PriceMasterSetUPT.createdateTime}  datetime ,
  ${PriceMasterSetUPT.updatedDatetime} datetime,
  ${PriceMasterSetUPT.createdUserID}  integer ,
  ${PriceMasterSetUPT.updateduserid} integer ,
  ${PriceMasterSetUPT.lastupdateIp} varchar 
 )''');

    await database.execute('''
 create table $tableDmtNum(
  ${DocNumT.seriesid} INTEGER,
  ${DocNumT.seriesname} varchar(20),
  ${DocNumT.transactiontype} INTEGER,
  ${DocNumT.branch} varchar(100),
  ${DocNumT.user} varchar(100),
  ${DocNumT.fromdate} datetime,
  ${DocNumT.todate} datetime,
  ${DocNumT.startno} INTEGER,
  ${DocNumT.endno} INTEGER,
  ${DocNumT.nextno} INTEGER,
  ${DocNumT.prefix} varchar(100),
  ${DocNumT.status} varchar(1),
  ${DocNumT.createdateTime}  datetime ,
  ${DocNumT.updatedDatetime} datetime,
  ${DocNumT.createdUserID}  integer ,
  ${DocNumT.updateduserid} integer ,
  ${DocNumT.lastupdateIp} varchar 
 )''');

    await database.execute('''
 create table $tableStockSnap(
   ${StockSnapT.itemname} varchar(100),
  ${StockSnapT.itemcode} varchar(100),
   ${StockSnapT.branch} varchar(50),
    ${StockSnapT.terminal} varchar(50),
 ${StockSnapT.serialbatch} varchar(200),
  ${StockSnapT.quantity} NUMERIC,
  ${StockSnapT.sellprice} NUMERIC,
  ${StockSnapT.mrpprice} NUMERIC,
  ${StockSnapT.specialprice} NUMERIC,
  ${StockSnapT.maxdiscount} NUMERIC,
    ${StockSnapT.liter} NUMERIC,
  ${StockSnapT.weight} NUMERIC,
   ${StockSnapT.uPackSizeuom} varchar,
   ${StockSnapT.uPackSize} varchar,
    ${StockSnapT.uTINSPERBOX} NUMERIC,
     ${StockSnapT.uSpecificGravity} varchar,
     ${StockSnapT.taxCode} varchar,
    ${StockSnapT.taxrate} NUMERIC,
  ${StockSnapT.snapdatetime} datetime,
  ${StockSnapT.purchasedate} datetime,
  ${StockSnapT.createdateTime}  datetime ,
  ${StockSnapT.updatedDatetime} datetime,
  ${StockSnapT.createdUserID}  integer ,
  ${StockSnapT.updateduserid} integer ,
  ${StockSnapT.lastupdateIp} varchar 
 )''');

    await database.execute('''
 create table $tableStockTrans(
  ${StockTransT.itemcode} varchar(100),
  ${StockTransT.branchcode} varchar(50),
  ${StockTransT.serialbatch} varchar(200),
  ${StockTransT.quantity} NUMERIC,
  ${StockTransT.sellprice} NUMERIC,
  ${StockTransT.mrpprice} NUMERIC,
  ${StockTransT.specialprice} NUMERIC,
  ${StockTransT.maxdiscount} NUMERIC,
  ${StockTransT.snapdatetime} datetime,
  ${StockTransT.purchasedate} datetime,
  ${StockTransT.transdatetime} datetime,
  ${StockTransT.transentry} integer,
  ${StockTransT.translineid} integer,
  ${StockTransT.transno} integer,
  ${StockTransT.transtype} integer,
  ${StockTransT.pushstatus} varchar(1),
  ${StockTransT.createdateTime}  datetime ,
  ${StockTransT.updatedDatetime} datetime,
  ${StockTransT.createdUserID}  integer ,
  ${StockTransT.updateduserid} integer ,
  ${StockTransT.lastupdateIp} varchar 
 )''');

    await database.execute('''
 create table $tableCustomerTrans(
  ${CustomerTransT.customercode} varchar(50),
  ${CustomerTransT.currencycode} varchar(50),
  ${CustomerTransT.branch} varchar(100),
  ${CustomerTransT.value}  varchar,
  ${CustomerTransT.transtype} integer,
  ${CustomerTransT.tranentry} integer,
  ${CustomerTransT.tranno} integer,
  ${CustomerTransT.transdatetime} datetime,
  ${CustomerTransT.createdateTime}  datetime ,
  ${CustomerTransT.updatedDatetime} datetime,
  ${CustomerTransT.createdUserID}  integer ,
  ${CustomerTransT.updateduserid} integer ,
  ${CustomerTransT.lastupdateIp} varchar 
 )''');

    await database.execute('''
 create table $tableSalesHeader(
  ${SalesHeaderT.docentry} integer ,
    ${SalesHeaderT.doctype} varchar,  
    ${SalesHeaderT.objtype} varchar,  
    ${SalesHeaderT.objname} varchar,
    ${SalesHeaderT.tinNo} varchar,
    ${SalesHeaderT.vatNo} varchar,

     ${SalesHeaderT.basedocentry} integer ,
  ${SalesHeaderT.branch} varchar(100),
 ${SalesHeaderT.terminal} varchar, 
  ${SalesHeaderT.sodocno} varchar,
  ${SalesHeaderT.sodocseries} varchar,
  ${SalesHeaderT.sodocseriesno}  varchar,
  ${SalesHeaderT.sotransdate} varchar,
  ${SalesHeaderT.sodoctime} varchar,
  ${SalesHeaderT.sosystime} varchar,
  ${SalesHeaderT.documentno} varchar,
  ${SalesHeaderT.seresid} varchar ,
  ${SalesHeaderT.seriesnum} varchar ,
  ${SalesHeaderT.transactiondate}  varchar ,
  ${SalesHeaderT.transtime} varchar ,
  ${SalesHeaderT.sysdatetime} datetime,
 ${SalesHeaderT.customerSeriesNum}  varchar ,
  ${SalesHeaderT.customercode}  varchar ,
  ${SalesHeaderT.customername}  varchar ,
  ${SalesHeaderT.premiumid}  varchar ,
  ${SalesHeaderT.customertype} varchar,
  ${SalesHeaderT.taxno} varchar,
  ${SalesHeaderT.billaddressid} varchar,
  ${SalesHeaderT.shipaddresid} varchar,
  ${SalesHeaderT.billtype}  varchar,
  ${SalesHeaderT.docbasic} varchar ,
  ${SalesHeaderT.taxamount}  varchar ,
  ${SalesHeaderT.docdiscuntpercen} varchar,
  ${SalesHeaderT.docdiscamt} varchar,
  ${SalesHeaderT.doctotal} varchar,
  ${SalesHeaderT.baltopay} varchar,
  ${SalesHeaderT.remarks} varchar,
  ${SalesHeaderT.createdbyuser} varchar,
  ${SalesHeaderT.docstatus}  varchar,
  ${SalesHeaderT.paystatus} varchar,
  ${SalesHeaderT.amtpaid} varchar(50),
  ${SalesHeaderT.salesexec}  integer , 
  ${SalesHeaderT.createdateTime}  datetime ,
  ${SalesHeaderT.updatedDatetime} datetime,
  ${SalesHeaderT.createdUserID}  integer ,
  ${SalesHeaderT.updateduserid} integer ,
  ${SalesHeaderT.lastupdateIp} varchar,
 ${SalesHeaderT.customerphono}  varchar ,
  ${SalesHeaderT.customeraccbal}  varchar ,
  ${SalesHeaderT.customerpoint}  varchar ,
  ${SalesHeaderT.customeremail}  varchar ,
  ${SalesHeaderT.country}  varchar ,
 ${SalesHeaderT.city}  varchar ,
   ${SalesHeaderT.state}  varchar ,
   ${SalesHeaderT.pinno}  varchar ,
    ${SalesHeaderT.gst}  varchar,
     ${SalesHeaderT.totalltr}  NUMERIC ,
    ${SalesHeaderT.totalweight}  NUMERIC,
     ${SalesHeaderT.sapDocentry} integer,
  ${SalesHeaderT.sapDocNo} integer,
  ${SalesHeaderT.qStatus} varchar
 )''');
//  ${SalesHeaderT.street} varchar,
    // ${SalesHeaderT.block} varchar,
    // ${SalesHeaderT.addressName1} varchar,
    await database.execute('''
 create table $tableSalesLine(
  ${SalesLineT.docentry} integer,
  ${SalesLineT.lineID} NUMERIC ,
  ${SalesLineT.itemcode} varchar,
  ${SalesLineT.itemname} varchar,
${SalesLineT.serialbatch}  varchar ,
  ${SalesLineT.quantity} NUMERIC,
    ${SalesLineT.balqty} NUMERIC,
  ${SalesLineT.price} NUMERIC ,
  ${SalesLineT.linetotal} NUMERIC ,
  ${SalesLineT.taxrate}  NUMERIC ,
  ${SalesLineT.discperc} varchar,
  ${SalesLineT.discperunit} varchar,
    ${SalesLineT.maxdiscount} varchar,
  ${SalesLineT.basic} varchar,
  ${SalesLineT.taxtotal}  NUMERIC ,
  ${SalesLineT.discamt}  NUMERIC,
  ${SalesLineT.netlinetotal}  NUMERIC ,
   ${SalesLineT.basedocentry} integer,
  ${SalesLineT.baselineID} NUMERIC ,
  ${SalesLineT.pails} integer ,
  ${SalesLineT.cartons} integer ,
  ${SalesLineT.looseTins} varchar ,
  ${SalesLineT.tonnage} NUMERIC ,
  ${SalesLineT.totalPack} NUMERIC ,
  ${SalesLineT.branch} varchar(100),
  ${SalesLineT.terminal}  varchar ,
  ${SalesLineT.createdUser} varchar,
  ${SalesLineT.createdateTime}  datetime ,
  ${SalesLineT.updatedDatetime} datetime,
  ${SalesLineT.createdUserID}  integer ,
  ${SalesLineT.updateduserid} integer ,
  ${SalesLineT.lastupdateIp} varchar 
 )''');

    await database.execute('''
 create table $tableSalesPay(
  ${SalesPayT.docentry} integer,
  ${SalesPayT.lineid} integer,
  ${SalesPayT.rcamount} NUMERIC ,
  ${SalesPayT.rcdatetime} datetime,
  ${SalesPayT.rcdocentry} integer,
  ${SalesPayT.rcmode} varchar,
  ${SalesPayT.rcnumber}  varchar,
  ${SalesPayT.branch}  varchar,
  ${SalesPayT.terminal}  varchar ,
  ${SalesPayT.createdateTime}  datetime ,
  ${SalesPayT.updatedDatetime} datetime,
  ${SalesPayT.createdUserID}  integer ,
  ${SalesPayT.updateduserid} integer ,
  ${SalesPayT.amt}  varchar ,
  ${SalesPayT.availablept}  varchar ,
  ${SalesPayT.cardApprno}  varchar ,
  ${SalesPayT.cardref}  varchar ,
  ${SalesPayT.cardterminal}  varchar ,
  ${SalesPayT.chequedate}  datetime ,
  ${SalesPayT.chequeno}  varchar ,
  ${SalesPayT.couponcode}  varchar ,
  ${SalesPayT.coupontype}  varchar ,
  ${SalesPayT.creditref}  varchar ,
  ${SalesPayT.discountcode}  varchar ,
  ${SalesPayT.discounttype}  varchar ,
  ${SalesPayT.recoverydate}  varchar ,
  ${SalesPayT.transref}  varchar ,
 ${SalesPayT.transtype}  varchar ,
  ${SalesPayT.walletid}  varchar ,
 ${SalesPayT.walletref}  varchar ,
  ${SalesPayT.wallettype}  varchar ,
  ${SalesPayT.redeempoint}  varchar ,
 ${SalesPayT.remarks}  varchar ,
 ${SalesPayT.reference}  varchar ,
${SalesPayT.lastupdateIp} varchar 
 )''');

    // sales order table

    await database.execute('''
 create table $tableSalesOrderHeader(
  ${SalesOrderHeaderT.docentry} integer ,
   ${SalesOrderHeaderT.basedocentry} integer,
    ${SalesOrderHeaderT.doctype} varchar,  
    ${SalesOrderHeaderT.objtype} varchar,  
    ${SalesOrderHeaderT.objname} varchar,
    ${SalesOrderHeaderT.vatno} varchar,
    ${SalesOrderHeaderT.tinNo} varchar,
    ${SalesOrderHeaderT.editType} varchar,
  ${SalesOrderHeaderT.branch} varchar(100),
 ${SalesOrderHeaderT.terminal} varchar, 
  ${SalesOrderHeaderT.sodocno} varchar,
  ${SalesOrderHeaderT.sodocseries} varchar,
  ${SalesOrderHeaderT.sodocseriesno}  varchar,
  ${SalesOrderHeaderT.sotransdate} varchar,
  ${SalesOrderHeaderT.sodoctime} varchar,
  ${SalesOrderHeaderT.sosystime} varchar,
  ${SalesOrderHeaderT.documentno} varchar,
  ${SalesOrderHeaderT.seresid} varchar ,
  ${SalesOrderHeaderT.seriesnum} varchar ,
  ${SalesOrderHeaderT.transactiondate}  varchar ,
  ${SalesOrderHeaderT.transtime} varchar ,
  ${SalesOrderHeaderT.sysdatetime} datetime,
 ${SalesOrderHeaderT.customerSeriesNum}  varchar ,
  ${SalesOrderHeaderT.customercode}  varchar ,
  ${SalesOrderHeaderT.customername}  varchar ,
  ${SalesOrderHeaderT.premiumid}  varchar ,
  ${SalesOrderHeaderT.customertype} varchar,
  ${SalesOrderHeaderT.taxno} varchar,
  ${SalesOrderHeaderT.billaddressid} varchar,
  ${SalesOrderHeaderT.shipaddresid} varchar,
  ${SalesOrderHeaderT.billtype}  varchar,
  ${SalesOrderHeaderT.docbasic} varchar ,
  ${SalesOrderHeaderT.taxamount}  varchar ,
  ${SalesOrderHeaderT.docdiscuntpercen} varchar,
  ${SalesOrderHeaderT.docdiscamt} varchar,
  ${SalesOrderHeaderT.doctotal} varchar,
  ${SalesOrderHeaderT.baltopay} varchar,
  ${SalesOrderHeaderT.remarks} varchar,
  ${SalesOrderHeaderT.createdbyuser} varchar,
  ${SalesOrderHeaderT.docstatus}  varchar,
  ${SalesOrderHeaderT.paystatus} varchar,
  ${SalesOrderHeaderT.amtpaid} varchar(50),
  ${SalesOrderHeaderT.salesexec}  integer , 
  ${SalesOrderHeaderT.createdateTime}  datetime ,
  ${SalesOrderHeaderT.updatedDatetime} datetime,
  ${SalesOrderHeaderT.createdUserID}  integer ,
  ${SalesOrderHeaderT.updateduserid} integer ,
  ${SalesOrderHeaderT.lastupdateIp} varchar,
 ${SalesOrderHeaderT.customerphono}  varchar ,
  ${SalesOrderHeaderT.customeraccbal}  varchar ,
  ${SalesOrderHeaderT.customerpoint}  varchar ,
  ${SalesOrderHeaderT.customeremail}  varchar ,
  ${SalesOrderHeaderT.country}  varchar ,
 ${SalesOrderHeaderT.city}  varchar ,
   ${SalesOrderHeaderT.state}  varchar ,
   ${SalesOrderHeaderT.pinno}  varchar ,
    ${SalesOrderHeaderT.gst}  varchar,
     ${SalesOrderHeaderT.totalltr}  NUMERIC ,
    ${SalesOrderHeaderT.totalweight}  NUMERIC,
    ${SalesOrderHeaderT.custRefNo}  varchar ,
    ${SalesOrderHeaderT.uDeviceId}  varchar ,
    ${SalesOrderHeaderT.uOrderDate}  varchar ,
    ${SalesOrderHeaderT.uOrderType}  varchar ,
    ${SalesOrderHeaderT.uGPApproval}  varchar ,
    ${SalesOrderHeaderT.uReceivedTime}  varchar ,
     ${SalesOrderHeaderT.sapDocentry} integer,
  ${SalesOrderHeaderT.sapDocNo} integer,
  ${SalesOrderHeaderT.qStatus} varchar
 )''');
//  ${SalesOrderHeaderT.street} varchar,uDeviceId
    // ${SalesOrderHeaderT.block} varchar,
    // ${SalesOrderHeaderT.addressName1} varchar,
    await database.execute('''
 create table $tableSalesOrderLine(
  ${SalesOrderLineT.docentry} integer,
  ${SalesOrderLineT.lineID} NUMERIC ,
   ${SalesOrderLineT.basedocentry} integer,
  ${SalesOrderLineT.baselineID} NUMERIC ,
  ${SalesOrderLineT.baseType} varchar,
  ${SalesOrderLineT.itemcode} varchar,
  ${SalesOrderLineT.itemname} varchar,
${SalesOrderLineT.serialbatch}  varchar ,
  ${SalesOrderLineT.quantity} NUMERIC,
    ${SalesOrderLineT.balqty} NUMERIC,
  ${SalesOrderLineT.price} NUMERIC ,
  ${SalesOrderLineT.linetotal} NUMERIC ,
  ${SalesOrderLineT.taxrate}  NUMERIC ,
  ${SalesOrderLineT.discperc} varchar,
  ${SalesOrderLineT.discperunit} varchar,
    ${SalesOrderLineT.maxdiscount} varchar,
  ${SalesOrderLineT.basic} varchar,
  ${SalesOrderLineT.taxtotal}  NUMERIC ,
  ${SalesOrderLineT.discamt}  NUMERIC,
  ${SalesOrderLineT.netlinetotal}  NUMERIC ,
  ${SalesOrderLineT.branch} varchar(100),
  ${SalesOrderLineT.terminal}  varchar(100),
  ${SalesOrderLineT.shipDate} varchar(100),
  ${SalesOrderLineT.createdUser} varchar,
  ${SalesOrderLineT.createdateTime}  datetime ,
  ${SalesOrderLineT.updatedDatetime} datetime,
  ${SalesOrderLineT.createdUserID}  integer ,
  ${SalesOrderLineT.updateduserid} integer ,
  ${SalesOrderLineT.lastupdateIp} varchar 
 )''');

    await database.execute('''
 create table $tableSalesOrderPay(
  ${SalesOrderPayT.docentry} integer,
   ${SalesOrderPayT.lineid} integer,
  ${SalesOrderPayT.rcamount} NUMERIC ,
  ${SalesOrderPayT.rcdatetime} datetime,
  ${SalesOrderPayT.rcdocentry} integer,
  ${SalesOrderPayT.rcmode} varchar,
  ${SalesOrderPayT.rcnumber}  varchar ,
  ${SalesOrderPayT.branch}  varchar ,
  ${SalesOrderPayT.terminal}  varchar ,
  ${SalesOrderPayT.createdateTime}  datetime ,
  ${SalesOrderPayT.updatedDatetime} datetime,
  ${SalesOrderPayT.createdUserID}  integer ,
  ${SalesOrderPayT.updateduserid} integer ,
 ${SalesOrderPayT.amt}  varchar ,
  ${SalesOrderPayT.availablept}  varchar ,
  ${SalesOrderPayT.cardApprno}  varchar ,
  ${SalesOrderPayT.cardref}  varchar ,
  ${SalesOrderPayT.cardterminal}  varchar ,
  ${SalesOrderPayT.chequedate}  datetime ,
  ${SalesOrderPayT.chequeno}  varchar ,
  ${SalesOrderPayT.couponcode}  varchar ,
  ${SalesOrderPayT.coupontype}  varchar ,
  ${SalesOrderPayT.creditref}  varchar ,
  ${SalesOrderPayT.discountcode}  varchar ,
  ${SalesOrderPayT.discounttype}  varchar ,
  ${SalesOrderPayT.recoverydate}  varchar ,
  ${SalesOrderPayT.transref}  varchar ,
 ${SalesOrderPayT.transtype}  varchar ,
  ${SalesOrderPayT.walletid}  varchar ,
 ${SalesOrderPayT.walletref}  varchar ,
  ${SalesOrderPayT.wallettype}  varchar ,
  ${SalesOrderPayT.redeempoint}  varchar ,
 ${SalesOrderPayT.remarks}  varchar ,
 ${SalesOrderPayT.reference}  varchar ,
${SalesOrderPayT.lastupdateIp} varchar 
 )''');
    await database.execute('''
 create table $tableSalesQuotationHeader(
  ${SalesQuotationHeaderT.docentry} integer ,
    ${SalesQuotationHeaderT.doctype} varchar,  
    ${SalesQuotationHeaderT.objtype} varchar,  
    ${SalesQuotationHeaderT.objname} varchar,
    ${SalesQuotationHeaderT.tinNo} varchar,
    ${SalesQuotationHeaderT.vatno} varchar,
    ${SalesQuotationHeaderT.editType} varchar,
  ${SalesQuotationHeaderT.branch} varchar(100),
 ${SalesQuotationHeaderT.terminal} varchar, 
  ${SalesQuotationHeaderT.sodocno} varchar,
  ${SalesQuotationHeaderT.sodocseries} varchar,
  ${SalesQuotationHeaderT.sodocseriesno}  varchar,
  ${SalesQuotationHeaderT.sotransdate} varchar,
  ${SalesQuotationHeaderT.sodoctime} varchar,
  ${SalesQuotationHeaderT.sosystime} varchar,
  ${SalesQuotationHeaderT.documentno} varchar,
  ${SalesQuotationHeaderT.seresid} varchar ,
  ${SalesQuotationHeaderT.seriesnum} varchar ,
  ${SalesQuotationHeaderT.transactiondate}  varchar ,
  ${SalesQuotationHeaderT.transtime} varchar ,
  ${SalesQuotationHeaderT.sysdatetime} datetime,
  ${SalesQuotationHeaderT.customerSeriesNum} varchar ,
  ${SalesQuotationHeaderT.customercode}  varchar ,
  ${SalesQuotationHeaderT.customername}  varchar ,
  ${SalesQuotationHeaderT.premiumid}  varchar ,
  ${SalesQuotationHeaderT.customertype} varchar,
  ${SalesQuotationHeaderT.taxno} varchar,
  ${SalesQuotationHeaderT.billaddressid} varchar,
  ${SalesQuotationHeaderT.shipaddresid} varchar,
  ${SalesQuotationHeaderT.billtype}  varchar,
  ${SalesQuotationHeaderT.docbasic} varchar ,
  ${SalesQuotationHeaderT.taxamount}  varchar ,
  ${SalesQuotationHeaderT.docdiscuntpercen} varchar,
  ${SalesQuotationHeaderT.docdiscamt} varchar,
  ${SalesQuotationHeaderT.doctotal} varchar,
  ${SalesQuotationHeaderT.baltopay} varchar,
  ${SalesQuotationHeaderT.remarks} varchar,
  ${SalesQuotationHeaderT.createdbyuser} varchar,
  ${SalesQuotationHeaderT.docstatus}  varchar,
  ${SalesQuotationHeaderT.paystatus} varchar,
  ${SalesQuotationHeaderT.amtpaid} varchar(50),
  ${SalesQuotationHeaderT.salesexec}  integer , 
  ${SalesQuotationHeaderT.createdateTime}  datetime ,
  ${SalesQuotationHeaderT.updatedDatetime} datetime,
  ${SalesQuotationHeaderT.createdUserID}  integer ,
  ${SalesQuotationHeaderT.updateduserid} integer ,
  ${SalesQuotationHeaderT.lastupdateIp} varchar,
 ${SalesQuotationHeaderT.customerphono}  varchar ,
  ${SalesQuotationHeaderT.customeraccbal}  varchar ,
  ${SalesQuotationHeaderT.customerpoint}  varchar ,
  ${SalesQuotationHeaderT.customeremail}  varchar ,
  ${SalesQuotationHeaderT.country}  varchar ,
 ${SalesQuotationHeaderT.city}  varchar ,
   ${SalesQuotationHeaderT.state}  varchar ,
   ${SalesQuotationHeaderT.pinno}  varchar ,
    ${SalesQuotationHeaderT.gst}  varchar,
     ${SalesQuotationHeaderT.totalltr}  NUMERIC ,
    ${SalesQuotationHeaderT.totalweight}  NUMERIC,
     ${SalesQuotationHeaderT.sapDocentry} integer,
  ${SalesQuotationHeaderT.sapDocNo} integer,
  ${SalesQuotationHeaderT.qStatus} varchar
 )''');

    await database.execute('''
 create table $tableSalesQuotationLine(
  ${SalesQuotationLineT.docentry} integer,
  ${SalesQuotationLineT.sapDocentry} integer,
  ${SalesQuotationLineT.lineID} NUMERIC ,
  ${SalesQuotationLineT.itemcode} varchar,
  ${SalesQuotationLineT.itemname} varchar,
${SalesQuotationLineT.serialbatch}  varchar ,
  ${SalesQuotationLineT.quantity} NUMERIC,
    ${SalesQuotationLineT.balqty} NUMERIC,
  ${SalesQuotationLineT.price} NUMERIC ,
  ${SalesQuotationLineT.linetotal} NUMERIC ,
  ${SalesQuotationLineT.taxrate}  NUMERIC ,
  ${SalesQuotationLineT.discperc} varchar,
  ${SalesQuotationLineT.discperunit} varchar,
    ${SalesQuotationLineT.maxdiscount} varchar,
  ${SalesQuotationLineT.basic} varchar,
  ${SalesQuotationLineT.taxtotal}  NUMERIC ,
  ${SalesQuotationLineT.discamt}  NUMERIC,
  ${SalesQuotationLineT.netlinetotal}  NUMERIC ,
  ${SalesQuotationLineT.branch} varchar(100),
  ${SalesQuotationLineT.terminal}  varchar ,
  ${SalesQuotationLineT.createdUser} varchar,
  ${SalesQuotationLineT.createdateTime}  datetime ,
  ${SalesQuotationLineT.updatedDatetime} datetime,
  ${SalesQuotationLineT.createdUserID}  integer ,
  ${SalesQuotationLineT.updateduserid} integer ,
  ${SalesQuotationLineT.lastupdateIp} varchar 
 )''');

    await database.execute('''
 create table $tableReceiptHeader(
  ${ReceiptHeaderT.docentry} integer,
   ${ReceiptHeaderT.doctype} varchar,
      ${ReceiptHeaderT.remarks} varchar,
 ${ReceiptHeaderT.docstatus} varchar,
   ${ReceiptHeaderT.branch} varchar,
 ${ReceiptHeaderT.terminal} varchar,
  ${ReceiptHeaderT.docnumber} varchar,
 ${ReceiptHeaderT.sapDocentry} varchar,
  ${ReceiptHeaderT.sapDocNo} varchar,
  ${ReceiptHeaderT.qStatus} varchar,
    ${ReceiptHeaderT.sapInvoicedocentry} varchar,
  ${ReceiptHeaderT.sapInvoicedocnum} varchar,
  ${ReceiptHeaderT.series} varchar,
  ${ReceiptHeaderT.seriesnumber} varchar,
  ${ReceiptHeaderT.transdocentry} varchar,
  ${ReceiptHeaderT.transdocnum} varchar,
 ${ReceiptHeaderT.transdate}  varchar ,
  ${ReceiptHeaderT.transtime}  varchar ,
  ${ReceiptHeaderT.sysdate}  datetime ,
  ${ReceiptHeaderT.customer} varchar,
  ${ReceiptHeaderT.customerSeriesNum} varchar ,
  ${ReceiptHeaderT.totalamount}  NUMERIC ,
  ${ReceiptHeaderT.createdateTime}  datetime ,
  ${ReceiptHeaderT.updatedDatetime} datetime,
  ${ReceiptHeaderT.createdUserID}  integer ,
  ${ReceiptHeaderT.updateduserid} integer ,
  ${ReceiptHeaderT.lastupdateIp} varchar 
 )''');
// transdocentry
    await database.execute('''
 create table $tableReceiptLine1(
  ${ReceiptLineT.docentry} integer,
  ${ReceiptLineT.sapDocentry} varchar,
  ${ReceiptLineT.sapDocNo} varchar,
  ${ReceiptLineT.qStatus} varchar,
  ${ReceiptLineT.rcEntry} integer,
  ${ReceiptLineT.transType} varchar,
  ${ReceiptLineT.transDocEnty} integer,
  ${ReceiptLineT.transDocDate} datetime ,
  ${ReceiptLineT.transDocNum} varchar ,
  ${ReceiptLineT.transAmount} NUMERIC ,
   ${ReceiptLineT.branch} varchar ,
  ${ReceiptLineT.terminal} varchar ,
  ${ReceiptLineT.createdateTime} datetime ,
  ${ReceiptLineT.updatedDatetime} datetime,
  ${ReceiptLineT.createdUserID} integer ,
  ${ReceiptLineT.updateduserid} integer ,
  ${ReceiptLineT.lastupdateIp} varchar 
 )''');

    await database.execute('''
 create table $tableReceiptLine2(
  ${ReceiptLine2T.docentry} integer,
  ${ReceiptLine2T.lineId} integer,
${ReceiptLine2T.rcamount} NUMERIC ,
  ${ReceiptLine2T.rcdatetime} datetime,
  ${ReceiptLine2T.rcdocentry} integer,
    ${ReceiptLine2T.branch}  varchar ,
  ${ReceiptLine2T.terminal}  varchar ,
  ${ReceiptLine2T.rcmode} varchar,
  ${ReceiptLine2T.rcnumber}  varchar ,
  ${ReceiptLine2T.createdateTime}  datetime ,
  ${ReceiptLine2T.updatedDatetime} datetime,
  ${ReceiptLine2T.createdUserID}  integer ,
  ${ReceiptLine2T.updateduserid} integer ,
 ${ReceiptLine2T.amt}  varchar ,
  ${ReceiptLine2T.availablept}  varchar ,
  ${ReceiptLine2T.cardApprno}  varchar ,
  ${ReceiptLine2T.cardterminal}  varchar ,
  ${ReceiptLine2T.chequedate}  datetime ,
  ${ReceiptLine2T.chequeno}  varchar ,
  ${ReceiptLine2T.couponcode}  varchar ,
  ${ReceiptLine2T.coupontype}  varchar ,
  ${ReceiptLine2T.discountcode}  varchar ,
  ${ReceiptLine2T.discounttype}  varchar ,
  ${ReceiptLine2T.recoverydate}  varchar ,
  ${ReceiptLine2T.transtype}  varchar ,
  ${ReceiptLine2T.walletid}  varchar ,
 ${ReceiptLine2T.wallettype}  varchar ,
  ${ReceiptLine2T.redeempoint}  varchar ,
 ${ReceiptLine2T.remarks}  varchar ,
 ${ReceiptLine2T.reference}  varchar ,
${ReceiptLine2T.lastupdateIp} varchar,
  ${ReceiptLine2T.Ref2} varchar ,
  ${ReceiptLine2T.Ref3} varchar ,
  ${ReceiptLine2T.Ref4}  varchar ,
  ${ReceiptLine2T.Ref5} varchar,
  ${ReceiptLine2T.VouchCode}  varchar ,
  ${ReceiptLine2T.VouchCode2}  varchar
)''');
    await database.execute('''
 create table $tableStockReqHDT(
  ${StockReqHDT.docentry}  integer ,
    ${StockReqHDT.doctype} varchar,
       ${StockReqHDT.cardCode} varchar,
     ${StockReqHDT.cardName} varchar,
   ${StockReqHDT.terminal} varchar,
     ${StockReqHDT.remarks} varchar,
  ${StockReqHDT.branch} varchar,
  ${StockReqHDT.documentno} integer ,
  ${StockReqHDT.docstatus} varchar,
  ${StockReqHDT.isagainstorder} varchar ,
  ${StockReqHDT.isagainststock}  varchar ,
  ${StockReqHDT.reqdocno}  integer ,
  ${StockReqHDT.reqdocseries}  varchar,
  ${StockReqHDT.reqdocseriesno} integer,
  ${StockReqHDT.reqdoctime}  varchar ,
  ${StockReqHDT.reqfromWhs} varchar,
  ${StockReqHDT.reqsystime} varchar,
  ${StockReqHDT.reqtoWhs} varchar,
  ${StockReqHDT.reqtransdate} varchar,
  ${StockReqHDT.salesexec} varchar,
  ${StockReqHDT.seresid} integer,
  ${StockReqHDT.seriesnum} integer,
  ${StockReqHDT.sysdatetime} varchar,
  ${StockReqHDT.totalitems} NUMERIC,
  ${StockReqHDT.totalltr} NUMERIC,
  ${StockReqHDT.totalqty} NUMERIC,
  ${StockReqHDT.totalweight} NUMERIC,
  ${StockReqHDT.transactiondate} varchar,
  ${StockReqHDT.transtime} varchar,
  ${StockReqHDT.createdateTime}  datetime ,
  ${StockReqHDT.updatedDatetime} datetime,
  ${StockReqHDT.createdUserID}  integer ,
  ${StockReqHDT.updateduserid} integer ,
  ${StockReqHDT.lastupdateIp} varchar,
   ${StockReqHDT.sapDocentry} integer,
  ${StockReqHDT.sapDocNo} integer,
  ${StockReqHDT.qStatus} varchar 
  
 )''');

    await database.execute('''
 create table $tableStockReqLineT(
  ${StockReqLineT.docentry} integer,
   ${StockReqLineT.terminal} varchar,
  ${StockReqLineT.branch} varchar,
  ${StockReqLineT.lineNo}  integer ,
  ${StockReqLineT.itemcode} varchar,
  ${StockReqLineT.dscription} varchar,
  ${StockReqLineT.price} NUMERIC,
  ${StockReqLineT.taxRate} NUMERIC,
  ${StockReqLineT.taxType} varchar,
  ${StockReqLineT.serialBatch} varchar,
  ${StockReqLineT.quantity} NUMERIC,
  ${StockReqLineT.status} varchar,
  ${StockReqLineT.createdateTime}  datetime ,
  ${StockReqLineT.updatedDatetime} datetime,
  ${StockReqLineT.createdUserID}  integer ,
  ${StockReqLineT.updateduserid} integer ,
  ${StockReqLineT.lastupdateIp} varchar 
 )''');

    await database.execute('''
 create table $tableSalesRetHeader(
  ${SalesReturnHeaderT.docentry} integer,
    ${SalesReturnHeaderT.doctype} varchar,  
    ${SalesReturnHeaderT.objtype} varchar,  
    ${SalesReturnHeaderT.objname} varchar,
     ${SalesReturnHeaderT.terminal} varchar,
  ${SalesReturnHeaderT.basedocentry} varchar,
  ${SalesReturnHeaderT.basedocnum} varchar,
${SalesReturnHeaderT.branch} varchar(100),
  ${SalesReturnHeaderT.sodocno} varchar,
  ${SalesReturnHeaderT.sodocseries} varchar,
  ${SalesReturnHeaderT.sodocseriesno}  varchar,
  ${SalesReturnHeaderT.sotransdate} varchar,
  ${SalesReturnHeaderT.sodoctime} varchar,
  ${SalesReturnHeaderT.sosystime} varchar,
  ${SalesReturnHeaderT.documentno} varchar,
  ${SalesReturnHeaderT.seresid} varchar ,
  ${SalesReturnHeaderT.seriesnum} varchar ,
  ${SalesReturnHeaderT.transactiondate}  varchar ,
  ${SalesReturnHeaderT.transtime} varchar ,
  ${SalesReturnHeaderT.sysdatetime} datetime,
  ${SalesReturnHeaderT.customercode}  varchar ,
  ${SalesReturnHeaderT.customername}  varchar ,
  ${SalesReturnHeaderT.premiumid}  varchar ,
  ${SalesReturnHeaderT.customertype} varchar,
  ${SalesReturnHeaderT.taxno} varchar,
  ${SalesReturnHeaderT.billaddressid} varchar,
  ${SalesReturnHeaderT.shipaddresid} varchar,
  ${SalesReturnHeaderT.billtype}  varchar,
  ${SalesReturnHeaderT.docbasic} varchar ,
  ${SalesReturnHeaderT.taxamount}  varchar ,
  ${SalesReturnHeaderT.docdiscuntpercen} varchar,
  ${SalesReturnHeaderT.docdiscamt} varchar,
  ${SalesReturnHeaderT.doctotal} varchar,
  ${SalesReturnHeaderT.baltopay} varchar,
  ${SalesReturnHeaderT.remarks} varchar,
  ${SalesReturnHeaderT.createdbyuser} varchar,
  ${SalesReturnHeaderT.docstatus}  varchar,
  ${SalesReturnHeaderT.paystatus} varchar,
  ${SalesReturnHeaderT.amtpaid} varchar(50),
  ${SalesReturnHeaderT.salesexec}  integer , 
  ${SalesReturnHeaderT.createdateTime}  datetime ,
  ${SalesReturnHeaderT.updatedDatetime} datetime,
  ${SalesReturnHeaderT.createdUserID}  integer ,
  ${SalesReturnHeaderT.updateduserid} integer ,
  ${SalesReturnHeaderT.lastupdateIp} varchar,
 ${SalesReturnHeaderT.customerphono}  varchar ,
  ${SalesReturnHeaderT.customeraccbal}  varchar ,
  ${SalesReturnHeaderT.customerpoint}  varchar ,
  ${SalesReturnHeaderT.customeremail}  varchar ,
  ${SalesReturnHeaderT.country}  varchar ,
 ${SalesReturnHeaderT.city}  varchar ,
   ${SalesReturnHeaderT.state}  varchar ,
   ${SalesReturnHeaderT.pinno}  varchar ,
    ${SalesReturnHeaderT.gst}  varchar,
      ${SalesReturnHeaderT.totalltr}  NUMERIC ,
    ${SalesReturnHeaderT.totalweight}  NUMERIC,
    ${SalesReturnHeaderT.sapInvoicedocentry} integer,
  ${SalesReturnHeaderT.sapInvoicedocnum} integer,
    ${SalesReturnHeaderT.sapDocentry}  varchar,
    ${SalesReturnHeaderT.sapDocNo}  varchar,
    ${SalesReturnHeaderT.uDeviceId}  varchar,
    ${SalesReturnHeaderT.qStatus}  varchar
 )''');

    await database.execute('''
 create table $tableSalesReturnLine(
${SalesReturnLineT.docentry} integer,
 ${SalesReturnLineT.baselineID} varchar,
${SalesReturnLineT.basedocentry} varchar,
  ${SalesReturnLineT.lineID} NUMERIC ,
  ${SalesReturnLineT.itemcode} varchar,
  ${SalesReturnLineT.itemname} varchar,
  ${SalesReturnLineT.serialbatch}  varchar ,
  ${SalesReturnLineT.quantity} NUMERIC,
  ${SalesReturnLineT.price} NUMERIC ,
  ${SalesReturnLineT.linetotal} NUMERIC ,
  ${SalesReturnLineT.taxrate}  NUMERIC ,
  ${SalesReturnLineT.discperc} varchar,
  ${SalesReturnLineT.discperunit} varchar,
  ${SalesReturnLineT.basic} varchar,
  ${SalesReturnLineT.taxtotal}  NUMERIC ,
  ${SalesReturnLineT.discamt}  NUMERIC,
  ${SalesReturnLineT.netlinetotal}  NUMERIC ,
  ${SalesReturnLineT.branch} varchar(100),
  ${SalesReturnLineT.terminal} varchar(100),
  ${SalesReturnLineT.createdUser} varchar,
  ${SalesReturnLineT.createdateTime}  datetime ,
  ${SalesReturnLineT.updatedDatetime} datetime,
  ${SalesReturnLineT.createdUserID}  integer ,
  ${SalesReturnLineT.updateduserid} integer ,
  ${SalesReturnLineT.lastupdateIp} varchar
  
 )''');

    await database.execute('''
 create table $tableSalesReturnPay(

  ${SalesReturnPayT.docentry} integer,
  ${SalesReturnPayT.lineId} integer,
  ${SalesReturnPayT.rcamount} NUMERIC ,
  ${SalesReturnPayT.rcdatetime} datetime,
  ${SalesReturnPayT.rcdocentry} integer,
  ${SalesReturnPayT.rcmode} varchar,
  ${SalesReturnPayT.amt} varchar,
  ${SalesReturnPayT.rcnumber}  varchar ,
   ${SalesReturnPayT.branch} varchar(100),
  ${SalesReturnPayT.terminal} varchar(100),
  ${SalesReturnPayT.createdateTime}  datetime ,
  ${SalesReturnPayT.updatedDatetime} datetime,
  ${SalesReturnPayT.createdUserID}  integer ,
  ${SalesReturnPayT.updateduserid} integer ,
  ${SalesReturnPayT.chequedate}  datetime ,
  ${SalesReturnPayT.chequeno}  varchar ,
  ${SalesReturnPayT.couponcode}  varchar ,
  ${SalesReturnPayT.coupontype}  varchar ,
 ${SalesReturnPayT.remarks}  varchar ,
 ${SalesReturnPayT.reference}  varchar ,
  ${SalesReturnPayT.lastupdateIp} varchar
 )''');
    await database.execute('''
 create table $tableStockOutHeaderDataDB(
   ${StockOutHeaderData.docentry} integer ,
    ${StockOutHeaderData.documentno} varchar(100),
        ${StockOutHeaderData.cardCode} varchar(100),
    ${StockOutHeaderData.cardName} varchar(100),
    ${StockOutHeaderData.terminal} varchar(100),
    ${StockOutHeaderData.branch} varchar(100),
    ${StockOutHeaderData.createdUserID} varchar,
    ${StockOutHeaderData.remarks} varchar,
      ${StockOutHeaderData.totalweight} varchar,
       ${StockOutHeaderData.createdateTime} datetime,
        ${StockOutHeaderData.baseDocentry} varchar,
        ${StockOutHeaderData.docstatus} varchar,
        ${StockOutHeaderData.lastupdateIp} varchar,
        ${StockOutHeaderData.reqdocno} integer,
        ${StockOutHeaderData.docseries} varchar,
        ${StockOutHeaderData.docseriesno} integer,
        ${StockOutHeaderData.doctime} datetime,
        ${StockOutHeaderData.reqfromWhs} varchar,
        ${StockOutHeaderData.systime} datetime,
        ${StockOutHeaderData.reqtoWhs} varchar,
        ${StockOutHeaderData.transdate} datetime,
        ${StockOutHeaderData.salesexec} varchar,
        ${StockOutHeaderData.totalitems} NUMERIC,
        ${StockOutHeaderData.totalltr} NUMERIC,
        ${StockOutHeaderData.totalqty} NUMERIC,
        ${StockOutHeaderData.updatedDatetime} datetime,
        ${StockOutHeaderData.updateduserid} varchar,
         ${StockOutHeaderData.sapStockReqdocentry} integer,
        ${StockOutHeaderData.sapStockReqdocnum} integer,
        ${StockOutHeaderData.sapDocentry} integer,
        ${StockOutHeaderData.sapDocNo} integer,
        ${StockOutHeaderData.qStatus} varchar
 )''');
    await database.execute('''
 create table $tableStockInHeaderDB(
     ${StockInHeaderData.docentry} integer,
     ${StockInHeaderData.documentno} varchar(100),
     ${StockInHeaderData.terminal} varchar(100),
         ${StockInHeaderData.cardCode} varchar(100),
     ${StockInHeaderData.cardName} varchar(100),
     ${StockInHeaderData.branch} varchar(100),
      ${StockInHeaderData.baseDocentry} varchar,
      ${StockInHeaderData.remarks} varchar,
       ${StockInHeaderData.createdUserID} varchar,
       ${StockInHeaderData.createdateTime} datetime,
        ${StockInHeaderData.docstatus} varchar,
        ${StockInHeaderData.lastupdateIp} varchar,
        ${StockInHeaderData.reqdocno} integer,
        ${StockInHeaderData.docseries} varchar,
        ${StockInHeaderData.docseriesno} integer,
        ${StockInHeaderData.doctime} datetime,
        ${StockInHeaderData.reqfromWhs} varchar,
        ${StockInHeaderData.systime} datetime,
        ${StockInHeaderData.reqtoWhs} varchar,
        ${StockInHeaderData.transdate} datetime,
        ${StockInHeaderData.salesexec} varchar,
        ${StockInHeaderData.totalitems} NUMERIC,
        ${StockInHeaderData.totalltr} NUMERIC,
        ${StockInHeaderData.totalqty} NUMERIC,
        ${StockInHeaderData.updatedDatetime} datetime,
        ${StockInHeaderData.updateduserid} varchar,
        ${StockInHeaderData.sapStockReqdocentry} integer,
     ${StockInHeaderData.sapStockReqdocnum} integer,
     ${StockInHeaderData.sapDocentry} integer,
     ${StockInHeaderData.sapDocNo} integer,
     ${StockInHeaderData.qStatus} varchar
 )''');
    await database.execute('''
 create table $tableStockOutLineDB(
     ${StockOutLineData.baseDocentry} integer,
        
 ${StockOutLineData.terminal} varchar(100),

     ${StockOutLineData.branch} varchar(100),
       ${StockOutLineData.baseDocline} integer,
       ${StockOutLineData.description} varchar,
         ${StockOutLineData.docentry} integer,
        ${StockOutLineData.itemcode} varchar,
        ${StockOutLineData.lineno} integer,
        ${StockOutLineData.quantity} integer,
        ${StockOutLineData.inStkQty} varchar,

        ${StockOutLineData.transferQty} integer,
        ${StockOutLineData.scannedQty} integer,
        ${StockOutLineData.serialBatch} varchar,
        ${StockOutLineData.status} varchar
      
 )''');
    await database.execute('''
 create table $tableStockInLineDB(
  
     ${StockInLineData.baseDocentry} integer,
      ${StockInLineData.terminal} varchar(100),

     ${StockInLineData.branch} varchar(100),
       ${StockInLineData.baseDocline} integer,
       ${StockInLineData.description} varchar,
         ${StockInLineData.docentry} integer,
        ${StockInLineData.itemcode} varchar,
        ${StockInLineData.lineno} integer,
        ${StockInLineData.quantity} integer,
        ${StockInLineData.transferQty} integer,
        ${StockInLineData.scannedQty} integer,
        ${StockInLineData.serialBatch} varchar,
        ${StockInLineData.status} varchar
      
 )''');
    await database.execute('''
 create table $tableStockOutBatchDB(
        ${StockOutBatchData.docentry} integer,
        ${StockOutBatchData.baseDocentry} integer,
        ${StockOutBatchData.itemcode} varchar,
        ${StockOutBatchData.lineno} integer,
        ${StockOutBatchData.qty} integer,
        ${StockOutBatchData.seialBatch} varchar,
        ${StockOutBatchData.docstatus} varchar
      
 )''');

    await database.execute('''
 create table $tableStockInBatchDB(
        ${StockInBatchData.baseDocentry} integer,
        ${StockInBatchData.docentry} integer,
        ${StockInBatchData.itemcode} varchar,
        ${StockInBatchData.lineno} integer,
        ${StockInBatchData.qty} integer,
        ${StockInBatchData.seialBatch} varchar,
        ${StockInBatchData.docstatus} varchar

 )''');

    await database.execute('''
create table $tableDepositHeader(
  ${DepositHeaderT.docentry} integer,
  ${DepositHeaderT.doctype} varchar,
  ${DepositHeaderT.terminal} varchar,
  ${DepositHeaderT.docdate} varchar,
  ${DepositHeaderT.docnumber} varchar,
   ${DepositHeaderT.sapDocentry} varchar,
  ${DepositHeaderT.sapDocNo} varchar,
  ${DepositHeaderT.qStatus} varchar,
  ${DepositHeaderT.series} varchar,
  ${DepositHeaderT.seriesnumber} varchar,
  ${DepositHeaderT.transdate} varchar,
  ${DepositHeaderT.transtime} varchar,
  ${DepositHeaderT.sysdatetime} datetime,
  ${DepositHeaderT.typedeposit} varchar,
  ${DepositHeaderT.fromaccountcode} varchar,
  ${DepositHeaderT.toaccountcode} varchar,
  ${DepositHeaderT.amountsettled} varchar,
  ${DepositHeaderT.remarks} varchar,
  ${DepositHeaderT.createdatetime} datetime,
  ${DepositHeaderT.updatedDatetime} datetime,
  ${DepositHeaderT.createduserid} integer,
  ${DepositHeaderT.updateduserid} integer,
  ${DepositHeaderT.lastupdateip} varchar,
  ${DepositHeaderT.branch} varchar
   
 )''');
    await database.execute('''
create table $tableDepositLine(
  ${DepositLineT.docentry} integer ,
  ${DepositLineT.basedocentry} integer,
  ${DepositLineT.basedoctype} varchar,
  ${DepositLineT.baselineid} integer,
  ${DepositLineT.linenumber} varchar ,
    ${DepositLineT.rcDocentry} varchar ,
      ${DepositLineT.rcDocnum} varchar ,
  ${DepositLineT.transactionRefno} varchar,
  ${DepositLineT.instrumentno} varchar,
  ${DepositLineT.paymodetype} varchar,
  ${DepositLineT.payentry} varchar,
  ${DepositLineT.paylineno} integer,
  ${DepositLineT.payamount} NUMERIC,
  ${DepositLineT.ref1} varchar,
  ${DepositLineT.ref2} varchar,
  ${DepositLineT.ref3} varchar,
  ${DepositLineT.paytransdate} varchar,
  ${DepositLineT.commissionamount} NUMERIC,
  ${DepositLineT.nettosettle} varchar,
  ${DepositLineT.createdatetime} datetime,
  ${DepositLineT.updatedDatetime} datetime,
  ${DepositLineT.createduserid} integer,
  ${DepositLineT.updateduserid} integer,
  ${DepositLineT.lastupdateip} varchar,
  ${DepositLineT.branch} varchar,
  ${DepositLineT.terminal} varchar,
    ${DepositLineT.jurnelRemarks} varchar,
   ${DepositLineT.transactionID} varchar
  )''');

    await database.execute('''
create table $tableExpense(
  ${ExpenseT.docentry} integer ,
  ${ExpenseT.documentno} integer,
  ${ExpenseT.lineid} integer,
  ${ExpenseT.terminal} varchar,
  ${ExpenseT.remarks} varchar,
  ${ExpenseT.attachment} varchar,
  ${ExpenseT.uDeviceId} varchar,
  ${ExpenseT.expensecode} integer,
  ${ExpenseT.reference} varchar,
  ${ExpenseT.rcamount} integer,
  ${ExpenseT.paidto} varchar,
  ${ExpenseT.docstatus} varchar,
  ${ExpenseT.paidfrom} varchar,
  ${ExpenseT.doctype} varchar,
  ${ExpenseT.createdateTime} datetime,
  ${ExpenseT.rcmode} varchar,
  ${ExpenseT.branch} varchar,
  ${ExpenseT.sapDocentry} varchar,
  ${ExpenseT.sapDocNo} varchar,
  ${ExpenseT.taxCode} varchar,
  ${ExpenseT.uRVC} varchar,
  ${ExpenseT.distRule} varchar,
  ${ExpenseT.projectCode} varchar,
  ${ExpenseT.qStatus} varchar
)''');
    await database.execute('''
create table $ExpensecodeMaster(
  ${ExpenseMasterT.docentry} integer primary key AUTOINCREMENT ,
  ${ExpenseMasterT.expensecode} varchar,
  ${ExpenseMasterT.expensename} varchar,
  ${ExpenseMasterT.debit} varchar,
  ${ExpenseMasterT.credit} varchar,
  ${ExpenseMasterT.limitval} varchar
)''');

    await database.execute('''
create table $tableExpensepaidfrom(
   ${expensepaidfromT.docentry} integer primary key AUTOINCREMENT ,
  ${expensepaidfromT.accountcode} varchar,
  ${expensepaidfromT.accountname} varchar,
  ${expensepaidfromT.balance} varchar
  )''');
    await database.execute('''
create table $couponDetailsMaster(
   ${CouponDetailT.docentry} integer primary key AUTOINCREMENT,
  ${CouponDetailT.coupontype} varchar,
  ${CouponDetailT.couponno} varchar,
  ${CouponDetailT.status} varchar,
  ${CouponDetailT.cardcode} varchar,
  ${CouponDetailT.doctype} varchar,
 ${CouponDetailT.couponamt} varchar
  )''');

//Refund
    await database.execute('''
 create table $tableRefundHeader(
  ${RefundHeaderT.docentry} integer,
   ${RefundHeaderT.doctype} varchar,
      ${RefundHeaderT.remarks} varchar,
 ${RefundHeaderT.docstatus} varchar,
   ${RefundHeaderT.branch} varchar,
 ${RefundHeaderT.terminal} varchar,
  ${RefundHeaderT.docnumber} varchar,
 ${RefundHeaderT.sapDocentry} varchar,
  ${RefundHeaderT.sapDocNo} varchar,
  ${RefundHeaderT.qStatus} varchar,
    ${RefundHeaderT.sapInvoicedocentry} varchar,
  ${RefundHeaderT.sapInvoicedocnum} varchar,
  ${RefundHeaderT.series} varchar,
  ${RefundHeaderT.seriesnumber} varchar,
  ${RefundHeaderT.transdocentry} varchar,
  ${RefundHeaderT.transdocnum} varchar,
 ${RefundHeaderT.transdate}  varchar ,
  ${RefundHeaderT.transtime}  varchar ,
  ${RefundHeaderT.sysdate}  datetime ,
  ${RefundHeaderT.customer} varchar , 
  ${RefundHeaderT.totalamount}  NUMERIC ,
  ${RefundHeaderT.createdateTime}  datetime ,
  ${RefundHeaderT.updatedDatetime} datetime,
  ${RefundHeaderT.createdUserID}  integer ,
  ${RefundHeaderT.updateduserid} integer ,
  ${RefundHeaderT.lastupdateIp} varchar 
 )''');
// transdocentry
    await database.execute('''
 create table $tableRefundLine1(
  ${RefundLineT.docentry} integer,
  ${RefundLineT.sapDocentry} varchar,
  ${RefundLineT.sapDocNo} varchar,
  ${RefundLineT.qStatus} varchar,
  ${RefundLineT.rc_entry} integer,
  ${RefundLineT.transType} varchar,
  ${RefundLineT.transDocEnty} integer,
  ${RefundLineT.TransDocDate} datetime ,
  ${RefundLineT.TransDocNum} varchar ,
  ${RefundLineT.TransAmount} NUMERIC ,
   ${RefundLineT.branch} varchar ,
  ${RefundLineT.terminal} varchar ,
  ${RefundLineT.createdateTime} datetime ,
  ${RefundLineT.updatedDatetime} datetime,
  ${RefundLineT.createdUserID} integer ,
  ${RefundLineT.updateduserid} integer ,
  ${RefundLineT.lastupdateIp} varchar 
 )''');

    await database.execute('''
 create table $tableRefundPay(
  ${RefundPayT.docentry} integer,
  ${RefundPayT.lineId} integer,
${RefundPayT.rcamount} NUMERIC ,
  ${RefundPayT.rcdatetime} datetime,
  ${RefundPayT.rcdocentry} integer,
    ${RefundPayT.branch}  varchar ,
  ${RefundPayT.terminal}  varchar ,
  ${RefundPayT.rcmode} varchar,
  ${RefundPayT.rcnumber}  varchar ,
  ${RefundPayT.createdateTime}  datetime ,
  ${RefundPayT.updatedDatetime} datetime,
  ${RefundPayT.createdUserID}  integer ,
  ${RefundPayT.updateduserid} integer ,
 ${RefundPayT.amt}  varchar ,
  ${RefundPayT.availablept}  varchar ,
  ${RefundPayT.cardApprno}  varchar ,
  ${RefundPayT.cardterminal}  varchar ,
  ${RefundPayT.chequedate}  datetime ,
  ${RefundPayT.chequeno}  varchar ,
  ${RefundPayT.couponcode}  varchar ,
  ${RefundPayT.coupontype}  varchar ,
  ${RefundPayT.discountcode}  varchar ,
  ${RefundPayT.discounttype}  varchar ,
  ${RefundPayT.recoverydate}  varchar ,
  ${RefundPayT.transtype}  varchar ,
  ${RefundPayT.walletid}  varchar ,
 ${RefundPayT.wallettype}  varchar ,
  ${RefundPayT.redeempoint}  varchar ,
 ${RefundPayT.remarks}  varchar ,
 ${RefundPayT.reference}  varchar ,
${RefundPayT.lastupdateIp} varchar,
  ${RefundPayT.Ref2} varchar ,
  ${RefundPayT.Ref3} varchar ,
  ${RefundPayT.Ref4}  varchar ,
  ${RefundPayT.Ref5} varchar,
  ${RefundPayT.VouchCode}  varchar ,
  ${RefundPayT.VouchCode2}  varchar
)''');

    await database.execute('''
 create table $tableNS(
 ${NumberingSriesT.id} interger,
 ${NumberingSriesT.docID} interger,
  ${NumberingSriesT.docName} varchar ,
 ${NumberingSriesT.firstNo} interger ,
 ${NumberingSriesT.nextNo}  interger ,
 ${NumberingSriesT.lastNo} interger ,
 ${NumberingSriesT.prefix} varchar ,
 ${NumberingSriesT.terminal} varchar,
 ${NumberingSriesT.wareHouse}  varchar ,
 ${NumberingSriesT.fromDate} datetime ,
 ${NumberingSriesT.toDate} datetime
 ) ''');

    await database.execute('''
           create table $tableNotification(
             NId integer primary key autoincrement,
             ${Notification.docEntry} int not null,
             ${Notification.title} varchar not null,
             ${Notification.imgurl} varchar not null,
             ${Notification.description} varchar not null,
             ${Notification.receiveTime} varchar not null,
             ${Notification.seenTime} varchar not null,
             ${Notification.naviScn} varchar not null
             )
        ''');
    //
    await database.execute('''
 CREATE TRIGGER reduceQtyInStockSales 
   AFTER INSERT ON SalesLine
BEGIN
update StockSnap set quantity = quantity - new.quantity where itemcode = new.itemcode and serialbatch = new.serialbatch and 
branch = new.branch;
END;
''');

    await database.execute('''
CREATE TRIGGER increaseQtyInStockSalesRet 
   AFTER INSERT ON SalesReturnLine
BEGIN
update StockSnap set quantity = quantity + new.quantity where itemcode = new.itemcode and serialbatch = new.serialbatch and 
branch = new.branch;
END;

''');
  }
}
