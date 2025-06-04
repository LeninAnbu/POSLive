import 'dart:developer';
import 'package:posproject/DBModel/ReceiptHeader.dart';
import 'package:posproject/DBModel/SalesReturnLineT.dart';
import 'package:posproject/DBModel/StockReqLine.dart';
import 'package:sqflite/sqflite.dart';
import '../DBModel/Branch.dart';
import '../DBModel/CouponDetailsDBModel.dart';
import '../DBModel/CustomerMaster.dart';
import '../DBModel/CustomerMasterAddress.dart';
import '../DBModel/ExpenseDBModel.dart';
import '../DBModel/ExpenseMaster.dart';
import '../DBModel/ItemMaster.dart';
import '../DBModel/NotificationModel.dart';
import '../DBModel/NumberingSeries.dart';
import '../DBModel/ReceiptLine2.dart';
import '../DBModel/RecieptLine1.dart';
import '../DBModel/RefundLine.dart';
import '../DBModel/RefundPayment.dart';
import '../DBModel/Refundheader.dart';
import '../DBModel/SalesHeader.dart';
import '../DBModel/SalesLineDBModel.dart';
import '../DBModel/SalesOrderHeader.dart';
import '../DBModel/SalesOrderLineDB.dart';
import '../DBModel/SalesOrderPay.dart';
import '../DBModel/SalesPay.dart';
import '../DBModel/SalesQuotationHead.dart';
import '../DBModel/SalesQuotationLine.dart';
import '../DBModel/SalesReturnHeadT.dart';
import '../DBModel/SalesReturnPayT.dart';
import '../DBModel/SettlementHeader.dart';
import '../DBModel/SettlementLineDBModel.dart';
import '../DBModel/StockInwardBatchModel.dart';
import '../DBModel/StockOutwardBatchModel.dart';
import '../DBModel/StockOutwardHeader.dart';
import '../DBModel/StockOutwardLineData.dart';
import '../DBModel/StockRequestHD.dart';
import '../DBModel/StockSnap.dart';
import '../DBModel/StockinwardHeader.dart';
import '../DBModel/StockinwardLineData.dart';
import '../DBModel/UserDBModel.dart';
import '../DBModel/paidfromModel.dart';
import '../Models/DataModel/CustomerModel/CustomerModel.dart';

class DBOperation {
  static Future<List<Map<String, Object?>>> getCstmMasDatabyautoid(
      Database db, String customercode) async {
//log("customercodecustomercode::" + customercode.toString());
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  CustomerMaster where customerCode ="$customercode" ''');
    log("CustomerMaster Len55: $result");
    return result;
  }

  static Future<List<Map<String, Object?>>> getCstmMasDatabyupdate(
      Database db, String autoid) async {
//log("customercodecustomercode::" + autoid.toString());
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  CustomerMaster where autoid ="$autoid" ''');
    // log("CustomerMaster Len55: " + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getSalesOrderHeadHoldvalueDB(
    Database db,
  ) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  SalesOrderHeader where docstatus = "1"''');
    log("SalesOrderHeadHoldvalueDB:" + result.toString());
    return result;
  }

  static Future<int?> getStockSnap(Database db) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    select count(itemcode) from StockSnap
     ''');
    //log('');
    //log(result.toList().toString());
    int? count = Sqflite.firstIntValue(result);
    return count;
  }

  static Future<int?> getItemMaster(Database db) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    select count(itemcode) from ItemMaster
     ''');
    //log('');
    //log(result.toList().toString());
    int? count = Sqflite.firstIntValue(result);
    return count;
  }

  static Future insertnumbering(
      Database db, List<NumberingSriesTDB> values) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("NumberingSeries", es);
    });
    await batch.commit();
  }

  static Future<int?> getcountofTable(
      Database db, String colName, tableName) async {
    // select max ((documentno) +1 )from StockReqHDT select documentno from StockReqHDT
    List<Map<String, Object?>> result = await db.rawQuery('''
    select count($colName) as count from $tableName
     ''');
//log("result:: " + result.toString());
    int? count = Sqflite.firstIntValue(result);
    //log("count:: " + count.toString());

    return count;
  }

  static Future insertStockSnap(
      Database db, List<StockSnapTModelDB> values) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("StockSnap", es);
    });
    await batch.commit();
  }

  static Future updateStkSnap(
    Database db,
    List<StockSnapTModelDB> values,
    int i,
  ) async {
//log("message::" + values[i].quantity.toString());
    final List<Map<String, Object?>> result =
        await db.rawQuery(''' UPDATE StockSnap SET

 quantity = "${values[i].quantity}"

    where serialbatch='${values[i].serialbatch}' and itemcode='${values[i].itemcode}'
     ''');
    // final List<Map<String, Object?>> result2 = await db.rawQuery(
    //     '''SELECT * FROM  StockSnap where  serialbatch='${values[i].serialbatch}' and itemcode="${values[i].itemcode}"''');
//log("Up StockSnap result:" + result2.toString());
    return result;
  }

  static Future<int?> updatenextno(Database db, int id, int value) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    UPDATE NumberingSeries SET nextno=$value WHERE id = $id
     ''');
    // List<Map<String, Object?>> result2 = await db.rawQuery('''
    // select * from NumberingSeries where id = $id
    //  ''');
    // log("result UPDATE NumberingSeries:: " + result2.toString());
    int? count = Sqflite.firstIntValue(result);
    return count;
  }

  static Future<int?> updatefirstno(Database db, int id, int value) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    UPDATE NumberingSeries SET FirstNo=$value WHERE id = $id
     ''');

//log("result UPDATE NumberingSeries:: " + result2.toString());
    int? count = Sqflite.firstIntValue(result);
    return count;
  }

  static Future<int?> updatelastno(Database db, int id, int value) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    UPDATE NumberingSeries SET LastNo=$value WHERE id = $id
     ''');

//log("result UPDATE NumberingSeries:: " + result2.toString());
    int? count = Sqflite.firstIntValue(result);
    return count;
  }

  static Future<int?> updateprefixno(Database db, int id, String value) async {
    // select max ((documentno) +1 )from StockReqHDT select documentno from StockReqHDT
    List<Map<String, Object?>> result = await db.rawQuery('''
    UPDATE NumberingSeries SET Prefix='$value' WHERE id = $id
     ''');
    // List<Map<String, Object?>> result2 = await db.rawQuery('''
    // select * from NumberingSeries where id = $id
    //  ''');
//log("result UPDATE NumberingSeries:: " + result2.toString());
    int? count = Sqflite.firstIntValue(result);
    return count;
  }

  static Future<int?> updatefromdate(Database db, int id, String value) async {
    // select max ((documentno) +1 )from StockReqHDT select documentno from StockReqHDT
    List<Map<String, Object?>> result = await db.rawQuery('''
    UPDATE NumberingSeries SET FromDate='$value' WHERE id = $id
     ''');
    // List<Map<String, Object?>> result2 = await db.rawQuery('''
    // select * from NumberingSeries where id = $id
    //  ''');
//log("result UPDATE NumberingSeries:: " + result2.toString());
    int? count = Sqflite.firstIntValue(result);
    //log("count:: " + count.toString());
    return count;
  }

  static Future<int?> updatetodate(Database db, int id, String value) async {
    // select max ((documentno) +1 )from StockReqHDT select documentno from StockReqHDT
    List<Map<String, Object?>> result = await db.rawQuery('''
    UPDATE NumberingSeries SET ToDate='$value' WHERE id = $id
     ''');
//log("result UPDATE NumberingSeries:: " + result2.toString());
    int? count = Sqflite.firstIntValue(result);
    //log("count:: " + count.toString());
    return count;
  }

  static Future<String?> getnumbSeriesvlue(Database db, int id) async {
    // select max ((documentno) +1 )from StockReqHDT select documentno from StockReqHDT
    List<Map<String, Object?>> result = await db.rawQuery('''
         select prefix as docnum from NumberingSeries where id = $id
     ''');
    String data = result[0]['docnum'].toString();

    return data;
  }

  static Future<List<Map<String, Object?>>> geteriesvlue(
    Database db,
  ) async {
    // select max ((documentno) +1 )from StockReqHDT select documentno from StockReqHDT
    List<Map<String, Object?>> result = await db.rawQuery('''
         select * from NumberingSeries
     ''');
    // log("NumberingSeries:: " + result.toString());
    // String data = result[0]['docnum'].toString();
    return result;
  }

  static Future<List<Map<String, Object?>>> getNumberSeries(Database db) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
         SELECT * FROM NumberingSeries 
     ''');
//log('kk::' + result.toString());
    return result;
  }

  static Future<String?> getStockReqWhsCode(Database db, int docentry) async {
    // select max ((documentno) +1 )from StockReqHDT select documentno from StockReqHDT
    List<Map<String, Object?>> result = await db.rawQuery('''
         SELECT reqtoWhs FROM StockReqHDT WHERE docentry='$docentry'
     ''');
    //log("result:: " + result.toString());
    String data = result[0]['reqtoWhs'].toString();
    return data;
  }

  static Future<int?> getnumbSer(
      Database db, String colName, tableName, int id) async {
    // select max ((documentno) +1 )from StockReqHDT select documentno from StockReqHDT
    List<Map<String, Object?>> result = await db.rawQuery('''
    select IFNULL(MAX($colName)+1,1) as docno from $tableName where id = $id
     ''');
//log("getnumbSer result:: " + result.toString());
    int? count = Sqflite.firstIntValue(result);
    //log("count:: " + count.toString());
    return count;
  }

  // static Future insertItemter(
  //     Database db, List<ItemMasterModelDB> values) async {
  //   var data = values.map((e) => e.toMap()).toList();
  //   var batch = db.batch();
  //   data.forEach((es) async {
  //     batch.insert("ItemMaster", es);
  //   });
  //   await batch.commit();
  //   List<Map<String, Object?>> result = await db.rawQuery('''
  //   select * from ItemMaster
  //    ''');
  // }

  static Future insertItemMaster(Database db, List<dynamic> data) async {
    for (var map in data) {
      await db.insert(
        'ItemMaster',
        map,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    List<Map<String, Object?>> result = await db.rawQuery('''
    select * from ItemMaster
     ''');
    log('result itemmaster::${result.length}');
  }

  // static Future<List<Map<String, Object?>>> checkBatchAvailRNot(
  //   Database db,
  //   String batch,
  // ) async {
  //   List<Map<String, Object?>> result = await db.rawQuery('''
  //    select * from StockSnap where serialbatch = "$batch"
  //    ''');

  //   //log(result.toList().toString());
  //   return result;
  // }

  static Future<List<ItemMasterModelDB>> getItemMasData2(
      Database db, String sbatch) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  StockSnap WHERE serialbatch="$sbatch"''');
    //log("StockSnap Len: " + result.length.toString());
    return List.generate(result.length, (i) {
      return ItemMasterModelDB(
          isselected: result[i]['IsSelected'] == null
              ? 0
              : int.parse(result[i]['IsSelected'].toString()),
          autoId: int.parse(result[i]['AutoId'].toString()),
          quantity: double.parse(result[i]['quantity'].toString()),
          maximumQty: result[i]['maximumQty'].toString(),
          minimumQty: result[i]['minimumQty'].toString(),
          weight: double.parse(result[i]['weight'].toString()),
          liter: double.parse(result[i]['liter'].toString()),
          displayQty: result[i]['displayQty'].toString(),
          searchString: result[i]['searchString'].toString(),
          brand: result[i]['brand'].toString(),
          category: result[i]['category'].toString(),
          createdUserID: result[i]['createdUserID'].toString(),
          createdateTime: result[i]['createdateTime'].toString(),
          hsnsac: result[i]['hsn_sac'].toString(),
          isActive: result[i]['is_Active'].toString(),
          isfreeby: result[i]['is_freeby'].toString(),
          isinventory: result[i]['is_inventory'].toString(),
          issellpricebyscrbat: result[i]['is_sellpricebyscrbat'].toString(),
          isserialBatch: result[i]['is_serialBatch'].toString(),
          itemcode: result[i]['Itemcode'].toString(),
          itemnamelong: result[i]['itemname_long'].toString(),
          itemnameshort: result[i]['itemname_short'].toString(),
          lastupdateIp: result[i]['lastupdateIp'].toString(),
          maxdiscount: double.parse(result[i]['maxdiscount'].toString()),
          skucode: result[i]['skucode'].toString(),
          subcategory: result[i]['subcategory'].toString(),
          taxrate: result[i]['taxrate'].toString(),
          updatedDatetime: result[i]['UpdatedDatetime'].toString(),
          updateduserid: result[i]['updateduserid'].toString(),
          mrpprice: result[i]['mrpprice'].toString(),
          uPackSize: result[i]['UPackSize'].toString(),
          uTINSPERBOX: int.parse(result[i]['UTINSPERBOX'].toString()),
          uSpecificGravity: result[i]['USpecificGravity'].toString(),
          uPackSizeuom: result[i]['UPackSizeUom'].toString(),
          managedBy: result[i]['ManageBy'].toString(),
          sellprice: result[i]['sellprice'].toString());
    });
  }

  static Future<List<StockSnapTModelDB>> getItemMasData(
      Database db, String sbatch) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  StockSnap WHERE serialbatch="$sbatch"''');
    // log("StockSnap: " + result.toString());
    return List.generate(result.length, (i) {
      return StockSnapTModelDB(
        terminal: result[i]['terminal'].toString(),
        branchcode: result[i]['branchcode'].toString(),
        createdUserID: int.parse(result[i]['createdUserID'].toString()),
        createdateTime: result[i]['createdateTime'].toString(),
        itemcode: result[i]['itemcode'].toString(),
        lastupdateIp: result[i]['lastupdateIp'].toString(),
        maxdiscount: result[i]['maxdiscount'].toString(),
        mrpprice: result[i]['mrpprice'].toString(),
        purchasedate: result[i]['purchasedate'].toString(),
        quantity: result[i]['quantity'].toString(),
        sellprice: result[i]['sellprice'].toString(),
        liter: result[i]['liter'] == null
            ? 0.0
            : double.parse(result[i]['liter'].toString()),
        weight: result[i]['weight'] == null
            ? 0.0
            : double.parse(result[i]['weight'].toString()),
        serialbatch: result[i]['serialbatch'].toString(),
        snapdatetime: result[i]['snapdatetime'].toString(),
        specialprice: result[i]['specialprice'].toString(),
        updatedDatetime: result[i]['UpdatedDatetime'].toString(),
        updateduserid: int.parse(result[i]['updateduserid'].toString()),
        itemname: result[i]['itemname'].toString(),
        taxrate: result[i]['taxrate'].toString(),
        taxCode: result[i]['taxCode'].toString(),
        branch: result[i]['branch'].toString(),
        uPackSize: result[i]['UPackSize'].toString(),
        uTINSPERBOX: int.parse(result[i]['UTINSPERBOX'].toString()),
        uSpecificGravity: result[i]['USpecificGravity'].toString(),
        uPackSizeuom: result[i]['UPackSizeUom'].toString(),
      );
    });
  }

//
  static Future<List<StockSnapTModelDB>> getItemMasDataItemcd(
      Database db, String sbatch, String itemcodee) async {
    log('message::$sbatch ::: $itemcodee');
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  StockSnap WHERE serialbatch="$sbatch" 
     and itemcode="$itemcodee"
        ''');
    //
    log("StockSnap: $result");
    return List.generate(result.length, (i) {
      return StockSnapTModelDB(
        terminal: result[i]['terminal'].toString(),
        branchcode: result[i]['branchcode'].toString(),
        createdUserID: int.parse(result[i]['createdUserID'].toString()),
        createdateTime: result[i]['createdateTime'].toString(),
        itemcode: result[i]['itemcode'].toString(),
        lastupdateIp: result[i]['lastupdateIp'].toString(),
        maxdiscount: result[i]['maxdiscount'].toString(),
        taxCode: result[i]['taxCode'].toString(),
        mrpprice: result[i]['mrpprice'].toString(),
        purchasedate: result[i]['purchasedate'].toString(),
        quantity: result[i]['quantity'].toString(),
        sellprice: result[i]['sellprice'].toString(),
        liter: result[i]['liter'] == null
            ? 0.0
            : double.parse(result[i]['liter'].toString()),
        weight: result[i]['weight'] == null
            ? 0.0
            : double.parse(result[i]['weight'].toString()),
        serialbatch: result[i]['serialbatch'].toString(),
        snapdatetime: result[i]['snapdatetime'].toString(),
        specialprice: result[i]['specialprice'].toString(),
        updatedDatetime: result[i]['UpdatedDatetime'].toString(),
        updateduserid: int.parse(result[i]['updateduserid'].toString()),
        itemname: result[i]['itemname'].toString(),
        taxrate: result[i]['taxrate'].toString(),
        branch: result[i]['branch'].toString(),
        uPackSize: result[i]['UPackSize'].toString(),
        uTINSPERBOX: int.parse(result[i]['UTINSPERBOX'].toString()),
        uSpecificGravity: result[i]['USpecificGravity'].toString(),
        uPackSizeuom: result[i]['UPackSizeUom'].toString(),
      );
    });
  }

  static Future<int?> getExpensecodecount(Database db) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    select count(expensecode) from ExpenseMaster
     ''');
    //log("Expcode length" + result.toList().toString());
    int? count = Sqflite.firstIntValue(result);
    return count;
  }

  static Future<int?> getExpaidfromcount(Database db) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    select count(accountname) from expensepaidfrom
     ''');
    //log("exp paidfrom len" + result.toList().toString());
    int? count = Sqflite.firstIntValue(result);
    return count;
  }
  // StockSnapTModelDB

  // customer insert

  // static Future insertCustomer(
  //     Database db, List<CustomerModelDB> values) async {
  //   var data = values.map((e) => e.toMap()).toList();
  //   var batch = db.batch();
  //   data.forEach((es) async {
  //     batch.insert("CustomerMaster", es);
  //   });
  //   await batch.commit();
  //   // List<Map<String, Object?>> result =
  //   //     await db.rawQuery("select * from CustomerMaster");
  //   // log("CustomerMaster RRSS" + result.toList().toString());
  // }

  static Future insertCustomer(Database db, List<dynamic> data) async {
    for (var mapdata in data) {
      await db.insert(
        'CustomerMaster',
        mapdata,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    List<Map<String, Object?>> result = await db.rawQuery('''
    select * from CustomerMaster
     ''');
    log('result CustomerMaster::${result.length}');
  }

//
  // static Future<List<StockSnapTModelDB>> getSearchedStockList(
  //     Database db, String name) async {
  //   List<Map<String, Object?>> result = await db.rawQuery('''
  //   select * from StockSnap where itemcode like '%$name%'or itemname like '%$name%'
  //    ''');

  //   print(
  //       "Query:  select * from StockSnap where itemcode like '%$name%'or itemname like '%$name%'");

  //   //log("res:$result");

  //   return List.generate(result.length, (i) {
  //     return StockSnapTModelDB(
  //       terminal: result[i]['terminal'].toString(),
  //       branchcode: result[i]['branchcode'].toString(),
  //       createdUserID: int.parse(result[i]['createdUserID'].toString()),
  //       createdateTime: result[i]['createdateTime'].toString(),
  //       itemcode: result[i]['itemcode'].toString(),
  //       lastupdateIp: result[i]['lastupdateIp'].toString(),
  //       maxdiscount: result[i]['maxdiscount'].toString(),
  //       mrpprice: result[i]['mrpprice'].toString(),
  //       purchasedate: result[i]['purchasedate'].toString(),
  //       quantity: result[i]['quantity'].toString(),
  //       sellprice: result[i]['sellprice'].toString(),
  //       serialbatch: result[i]['serialbatch'].toString(),
  //       snapdatetime: result[i]['snapdatetime'].toString(),
  //       specialprice: result[i]['specialprice'].toString(),
  //       updatedDatetime: result[i]['UpdatedDatetime'].toString(),
  //       updateduserid: int.parse(result[i]['updateduserid'].toString()),
  //       itemname: result[i]['itemname'].toString(),
  //       taxrate: result[i]['taxrate'].toString(),
  //       branch: result[i]['branch'].toString(),
  //     );
  //   });
  // }
  // sales order functions

  static Future<int?> insertSaleOrderheader(
      Database db, List<SalesOrderHeaderModelDB> values) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("SalesOrderHeader", es);
    });
    await batch.commit();

    // final List<Map<String, Object?>> result1 =
    //     await db.rawQuery('''SELECT * FROM  SalesOrderHeader''');
    //log("SalesOrderHeader:" + result1.toString());

    List<Map<String, Object?>> result = await db.rawQuery('''
     SELECT docentry FROM SalesOrderHeader  ORDER BY docentry DESC limit 1
     ''');
    //log("SalesOrderHeader result:: " + result.toString());
    int? count = Sqflite.firstIntValue(result);
    //log("SalesOrderHeader count:: " + count.toString());
    return count ?? 0;
  }

  static Future insertSalesOrderPay(
      Database db, List<SalesOrderPayTDB> values, int? docEntry) async {
    var data = values.map((e) => e.toMap(docEntry)).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("SalesOrderPay", es);
    });
    await batch.commit();
    // final List<Map<String, Object?>> result1 =
    //     await db.rawQuery('''SELECT * FROM  SalesOrderPay''');
    //log("SalesOrderPay Table:" + result1.toString());
  }

  static Future insertSalesOrderLine(
      Database db, List<SalesOrderLineTDB> values, int docEntry) async {
    var data = values.map((e) => e.toMap(docEntry)).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("SalesOrderLine", es);
    });
    await batch.commit();
    final List<Map<String, Object?>> result1 =
        await db.rawQuery('''SELECT * FROM  SalesOrderLine''');
    log("SalesOrderLine:${result1.length}");
  }

  static Future<List<Map<String, Object?>>> getSalesOrderHeaderDB(
      Database db, int docentry) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  SalesOrderHeader where docentry="$docentry"''');
    // print("SalesOrderHeaderrr::" + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getRabitMqStOutDetails(
      Database db, String docentry) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        ''' SELECT reqfromWhs,baseDocentry FROM StockOutHeaderDataDB WHERE docentry='$docentry' ''');
//log("StockOutHeader baseDocentry:;$result");
    return result;
  }

  static Future<List<Map<String, Object?>>> getRabitMqStInDetails(
      Database db, int docentry) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        ''' SELECT reqtoWhs,baseDocentry FROM StockInHeaderDB WHERE docentry='$docentry' ''');
//log("StockInwardHeader baseDocentry:;$result");

    return result;
  }

  static Future<List<Map<String, Object?>>> getdSalesOrderPayDB(
      Database db, int docentry) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  SalesOrderPay where docentry=$docentry''');
    // log("SalesOrderPay result:" + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getSalesOrderLineDB(
      Database db, int docentry) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  SalesOrderLine where docentry=$docentry''');
    //log("docentrydocentrydocentry:" + docentry.toString());
    log("SalesOrderLine result:$result");
    return result;
  }

  static Future<List<Map<String, Object?>>> getDocEntrySalesOrderHeaderDB(
      Database db, int docentry) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  SalesOrderHeader where docentry=$docentry''');
    //log("docentrydocentrydocentry:" + docentry.toString());
    log("SalesOrderLine result:$result");
    return result;
  }

  static Future<void> deleteHoldMaped(Database db, String docentry) async {
    await db.rawQuery('''
delete FROM  SalesOrderPay where docentry=$docentry''');
    await db
        .rawQuery('''delete FROM  SalesOrderLine where docentry=$docentry''');
    await db.rawQuery('''
delete FROM  SalesOrderHeader where docentry=$docentry''');
  }

  static Future<int?> insertSaleQuoheader(
      Database db, List<SalesQuotationHeaderModelDB> values) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("SalesQuotationHeader", es);
    });
    await batch.commit();

//log("SalesQuotationHeader:" + result1.toString());

    List<Map<String, Object?>> result = await db.rawQuery('''
     SELECT docentry FROM SalesQuotationHeader  ORDER BY docentry DESC limit 1
     ''');
    int? count = Sqflite.firstIntValue(result);
    return count ?? 0;
  }

  static Future insertSalesQuoLine(
      Database db, List<SalesQuotationLineTDB> values, int docEntry) async {
    var data = values.map((e) => e.toMap(docEntry)).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("SalesQuotationLine", es);
    });
    await batch.commit();
    // log("SalesQuotationLine:" + result1.toString());
  }

  static Future updateSaleQuoheader(
      Database db,
      SalesQuotationHeaderModelDB values,
      String docentry,
      String documentno) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery(''' UPDATE SalesQuotationHeader SET
 objtype ="${values.objtype}",
 objname ="${values.objname}",
 terminal = "${values.terminal}",
 branch = "${values.branch}",
 sodocno = "${values.sodocno}",
 sodocseries ="${values.sodocseries}",
 sodocseriesno = "${values.sodocseriesno}",
 sotransdate = "${values.sotransdate}",
 sodoctime = "${values.sodoctime}",
 sosystime = "${values.sosystime}",
 documentno ="${values.documentno}" ,
 seresid          = "${values.seresid}",
 seriesnum        = "${values.seriesnum}",
customerSeriesNum = "${values.customerSeriesNum}",
 transactiondate  = "${values.transactiondate}",
 transtime     ="${values.transtime}" ,
 sysdatetime   ="${values.sysdatetime}"  ,
 customercode  ="${values.customercode}" ,
 customername  ="${values.customername}" ,
 customerphono ="${values.customerphono}",
 customeremail ="${values.customeremail}",
 customeraccbal="${values.customeraccbal}",
 customerpoint ="${values.customerpoint}",
 premiumid     ="${values.premiumid}",
 customertype  ="${values.customertype}",
 taxno         ="${values.taxno}",
 city          ="${values.city}",
 state         ="${values.state}",
 pinno         ="${values.pinno}",
 gst           ="${values.gst}",
 country       ="${values.country}",
 shipaddresid  ="${values.shipaddresid}",
 billaddressid ="${values.billaddressid}",
 billtype      ="${values.billtype}",
 docbasic      ="${values.docbasic}",
 taxamount     ="${values.taxamount}",
 docdiscuntpercen="${values.docdiscuntpercen}",
 docdiscamt    ="${values.docdiscamt}",
 doctotal      ="${values.doctotal}",
 baltopay      ="${values.baltopay}",
 remarks       ="${values.remarks}",
 createdbyuser ="${values.createdbyuser}",
 docstatus     ="${values.docstatus}",
 paystatus     ="${values.paystatus}",
 amtpaid       ="${values.amtpaid}",
 salesexec     ="${values.salesexec}",
 createdateTime="${values.createdateTime}",
 UpdatedDatetime="${values.updatedDatetime}",
 createdUserID ="${values.createdUserID}",
 updateduserid ="${values.updateduserid}",
 lastupdateIp  ="${values.lastupdateIp}",
 sapDocentry   ="${values.sapDocentry}",
 sapDocNo      ="${values.sapDocNo}",
 qStatus       ="${values.qStatus}",
 editType    ="${values.editType}",
 totalltr      ="${values.totalltr}",
 totalweight   ="${values.totalweight}"
 where  docentry="$docentry" and documentno="$documentno"
 ''');
    // final List<Map<String, Object?>> result2 = await db.rawQuery('''SELECT * FROM  SalesQuotationHeader where docentry="$docentry" ''');
    // log("Up SalesQuotaionHeaderrr::" + result2.toString());
    return result;
  }

  static Future updateSapDocSalesQuoLine(
      Database db, sapdcentry, String docEntry) async {
    await db.rawQuery(''' UPDATE SalesQuotationLine SET
 sapDocentry = "$sapdcentry" where docentry='$docEntry'
     ''');
    await db.rawQuery(
        ''' select * from SalesQuotationLine  where docentry='$docEntry'
     ''');
  }

  static Future updateSalesQuoLine(Database db,
      List<SalesQuotationLineTDB> values, int i, String docEntry) async {
//log("message::" + values[i].toString());

//log("IIIIII:::$i");
    final List<Map<String, Object?>> result =
        await db.rawQuery(''' UPDATE SalesQuotationLine SET
 itemcode = "${values[i].itemcode}",
 itemname = "${values[i].itemname}",
 serialbatch = "${values[i].serialbatch}",
 quantity = "${values[i].quantity}",
 price = "${values[i].price}",
 linetotal = "${values[i].linetotal}",
 taxrate = "${values[i].taxrate}",
 discperc ="${values[i].discperc}",
 discperunit = "${values[i].discperunit}",
 maxdiscount = "${values[i].maxdiscount}",
 basic = "${values[i].basic}",
 taxtotal = "${values[i].taxtotal}",
 discamt = "${values[i].discamt}",
 netlinetotal = "${values[i].netlinetotal}",
 branch = "${values[i].branch}",
 terminal = "${values[i].terminal}",
 createdUser ="${values[i].createdUser}",
 createdateTime ="${values[i].createdateTime}",
 UpdatedDatetime = "${values[i].updatedDatetime}",
 createdUserID = "${values[i].createdUserID}",
 updateduserid = "${values[i].updateduserid}",
 lastupdateIp = "${values[i].lastupdateIp}"
    where docentry='$docEntry' and lineID='$i'
     ''');
    // log("Up SalesQuotationLine result:" + result2.toString());
    return result;
  }

  static Future updateSaleOrderheader(
      Database db,
      SalesOrderHeaderModelDB values,
      String docentry,
      String documentno) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery(''' UPDATE SalesOrderHeader SET
 objtype ="${values.objtype}",
 objname ="${values.objname}",
 terminal = "${values.terminal}",
 branch = "${values.branch}",
 sodocno = "${values.sodocno}",
 sodocseries ="${values.sodocseries}",
 sodocseriesno = "${values.sodocseriesno}",
 sotransdate = "${values.sotransdate}",
 sodoctime = "${values.sodoctime}",
 sosystime = "${values.sosystime}",
 documentno ="${values.documentno}" ,
 seresid          = "${values.seresid}",
 seriesnum        = "${values.seriesnum}",
customerSeriesNum = "${values.customerSeriesNum}",
 transactiondate  = "${values.transactiondate}",
 transtime     ="${values.transtime}" ,
 sysdatetime   ="${values.sysdatetime}"  ,
 customercode  ="${values.customercode}" ,
 customername  ="${values.customername}" ,
 customerphono ="${values.customerphono}",
 customeremail ="${values.customeremail}",
 customeraccbal="${values.customeraccbal}",
 customerpoint ="${values.customerpoint}",
 premiumid     ="${values.premiumid}",
 customertype  ="${values.customertype}",
 taxno         ="${values.taxno}",
 city          ="${values.city}",
 state         ="${values.state}",
 pinno         ="${values.pinno}",
 gst           ="${values.gst}",
 country       ="${values.country}",
 shipaddresid  ="${values.shipaddresid}",
 billaddressid ="${values.billaddressid}",
 billtype      ="${values.billtype}",
 docbasic      ="${values.docbasic}",
 taxamount     ="${values.taxamount}",
 docdiscuntpercen="${values.docdiscuntpercen}",
 docdiscamt    ="${values.docdiscamt}",
 doctotal      ="${values.doctotal}",
 baltopay      ="${values.baltopay}",
 remarks       ="${values.remarks}",
 createdbyuser ="${values.createdbyuser}",
 docstatus     ="${values.docstatus}",
 paystatus     ="${values.paystatus}",
 amtpaid       ="${values.amtpaid}",
 salesexec     ="${values.salesexec}",
 createdateTime="${values.createdateTime}",
 UpdatedDatetime="${values.updatedDatetime}",
 createdUserID ="${values.createdUserID}",
 updateduserid ="${values.updateduserid}",
 lastupdateIp  ="${values.lastupdateIp}",
 sapDocentry   ="${values.sapDocentry}",
 sapDocNo      ="${values.sapDocNo}",
 qStatus       ="${values.qStatus}",
 totalltr      ="${values.totalltr}",
 editType    ="${values.editType}",
 totalweight   ="${values.totalweight}"
 where docentry="$docentry" and documentno="$documentno"
 ''');
    // final List<Map<String, Object?>> result2 = await db.rawQuery('''SELECT * FROM  SalesOrderHeader where docentry="$docentry" ''');
    // log("Updt SalesOrderHeader::" + result2.toString());
    // log("result2result2 length::${result2.length}");
    return result;
  }

  static Future updateSalesOrderLine(Database db,
      List<SalesOrderLineTDB> values, int i, String docEntry) async {
//log("IIIIII:::$i");
    final List<Map<String, Object?>> result =
        await db.rawQuery(''' UPDATE SalesOrderLine SET
 itemcode = "${values[i].itemcode}",
 itemname = "${values[i].itemname}",
 serialbatch = "${values[i].serialbatch}",
 quantity = "${values[i].quantity}",
 price = "${values[i].price}",
 linetotal = "${values[i].linetotal}",
 taxrate = "${values[i].taxrate}",
 discperc= "${values[i].discperc}",
 discperunit = "${values[i].discperunit}",
 maxdiscount = "${values[i].maxdiscount}",
 basic = "${values[i].basic}",
 taxtotal = "${values[i].taxtotal}",
 discamt = "${values[i].discamt}",
 netlinetotal = "${values[i].netlinetotal}",
 branch = "${values[i].branch}",
 terminal = "${values[i].terminal}",
 createdUser ="${values[i].createdUser}",
 createdateTime ="${values[i].createdateTime}",
 UpdatedDatetime = "${values[i].updatedDatetime}",
 createdUserID = "${values[i].createdUserID}",
 updateduserid = "${values[i].updateduserid}",
 lastupdateIp = "${values[i].lastupdateIp}"
    where docentry='$docEntry' and lineID=$i
     ''');
//log("Up SalesOrderLine result:" + result2.toString());
    return result;
  }

  static Future updateSalesOrderPay(Database db, List<SalesOrderPayTDB> values,
      int i, String docEntry) async {
//log("IIIIII:::$i");
    final List<Map<String, Object?>> result =
        await db.rawQuery(''' UPDATE SalesOrderPay SET
 docentry  = "${values[i].docentry}";
  lineid  = "${values[i].lineid}";
  rcdocentry  = "${values[i].rcdocentry}";
  rcnumber  = "${values[i].rcnumber}";
  rcdatetime  = "${values[i].rcdatetime}";
  rcmode  = "${values[i].rcmode}";
  rcamount  = "${values[i].rcamount}";
  reference   = "${values[i].reference}";
  chequeno   = "${values[i].chequeno}";
  chequedate   = "${values[i].chequedate}";
  remarks   = "${values[i].remarks}";
  amt   = "${values[i].amt}";
  cardterminal   = "${values[i].cardterminal}";
  cardApprno   = "${values[i].cardApprno}";
  cardref   = "${values[i].cardref}";
  wallettype   = "${values[i].wallettype}";
  walletid   = "${values[i].walletid}";
  walletref   = "${values[i].walletref}";
  transtype   = "${values[i].transtype}";
  transref   = "${values[i].transref}";
  coupontype   = "${values[i].coupontype}";
  couponcode   = "${values[i].couponcode}";
  availablept   = "${values[i].availablept}";
  redeempoint   = "${values[i].redeempoint}";
  discounttype   = "${values[i].discounttype}";
  discountcode   = "${values[i].discountcode}";
  creditref   = "${values[i].creditref}";
  recoverydate   = "${values[i].recoverydate}";
  branch  = "${values[i].branch}";
  terminal  = "${values[i].terminal}";
  createdateTime   = "${values[i].createdateTime}";
  updatedDatetime  = "${values[i].updatedDatetime}";
  createdUserID  = "${values[i].createdUserID}";
  updateduserid  = "${values[i].updateduserid}";
  lastupdateIp  = "${values[i].lastupdateIp}";
    where docentry='$docEntry' and lineID=$i
     ''');
//log("Up SalesOrderPay result:" + result2.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getSalesQuoHeadHoldvalueDB(
    Database db,
  ) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  SalesQuotationHeader where docstatus = "1"''');
    log("SalesOrderHeadHoldvalueDB:" + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getSaleQuorHeaderDB(
      Database db, int docentry) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  SalesQuotationHeader where docentry="$docentry" ''');
//log("SalesQuotaionHeaderrr::" + result.toString());
//log("SalesQuotaionHeaderrr length::" + result.length.toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getSaleQuorQstatusDB(
    Database db,
  ) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  SalesQuotationHeader where qStatus='C' and doctatus="3"''');
    // log("SalesOrderHeaderrr::" + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getSalesQuoLineDB(
      Database db, int docentry) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  SalesQuotationLine where docentry=$docentry''');
    // log("SalesQuotationLine result:" + result.toString());
    // print("SalesQuotationLine result length:" + result.length.toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getSalesQuoLineDBbySapDocentry(
      Database db, int sapdocentry) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  SalesQuotationLine where sapDocentry=$sapdocentry''');
    // log("SalesQuotationLine result:$result");
    final List<Map<String, Object?>> result2 =
        await db.rawQuery('''SELECT * FROM  SalesQuotationLine ''');
    // log("SalesQuotationLine result:$result2");

    print("SalesQuotationLine result length:" + result2.length.toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getSalesQuotationvalueDB(
      Database db, String cardcode) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
select distinct soh.docentry,soh.documentno,
    soh.createdateTime,soh.baltopay, soh.city,soh.state,soh.pinno,soh.gst,soh.country,soh.billaddressid,
    soh.customerphono,soh.customeremail, soh.customername,soh.taxno,soh.customerpoint,
    soh.customercode,soh.sapDocNo,soh.sapDocentry,soh.customeraccbal,soh.doctotal
FROM  SalesQuotationHeader soh Inner Join SalesQuotationLine s on  
s.docentry=soh.docentry 
LEFT JOIN SalesOrderLine sl on sl.basedocentry=s.docentry and sl.baselineid=s.lineid
where s.quantity > ifnull(sl.quantity,0) and soh.docstatus='3' and soh.sapDocNo IS NOT NULL and soh.customercode='$cardcode'
group by soh.docentry,soh.documentno,soh.createdateTime,soh.baltopay,
        soh.city,soh.state,soh.pinno,soh.gst,soh.country,soh.billaddressid,soh.customerphono,soh.customeremail,
 soh.customername,soh.taxno,soh.customerpoint,soh.customercode,soh.customeraccbal,soh.doctotal,s.discperc

''');
    log("SalesquorHeadHoldvalueDB:$result");
    //SalesQuotationLine

    return result;
  }
// oldQuery
  // static Future<List<Map<String, Object?>>> getSalesQuotationvalueDB(Database db, String cardcode) async {
  //   final List<Map<String, Object?>> result = await db.rawQuery(''' SELECT soh.docentry,soh.documentno,
//     soh.createdateTime,soh.baltopay, soh.city,soh.state,soh.pinno,soh.gst,soh.country,soh.billaddressid,
//     soh.customerphono,soh.customeremail,soh.sapDocentry, soh.customername,soh.taxno,soh.customerpoint,
//     soh.customercode,soh.sapDocNo,soh.sapDocentry,soh.customeraccbal,soh.doctotal,s.lineid,s.itemcode,
// s.itemname,s.serialbatch,s.quantity,s.price,s.taxrate,s.discperc,s.maxdiscount,
// s.createdateTime,s.quantity-ifnull(sum(sl.quantity),0) Balanceqty
// FROM  SalesQuotationHeader soh Inner Join SalesQuotationLine s on
// s.docentry=soh.docentry
// LEFT JOIN SalesOrderLine sl on sl.basedocentry=s.docentry and sl.baselineid=s.lineid
// where s.quantity > ifnull(sl.quantity,0) and soh.docstatus='3' and soh.sapDocNo IS NOT NULL and soh.customercode='$cardcode'
// group by soh.docentry,soh.documentno,soh.createdateTime,soh.baltopay,
//         soh.city,soh.state,soh.pinno,soh.gst,soh.country,soh.billaddressid,soh.customerphono,soh.customeremail,
//  soh.customername,soh.taxno,soh.customerpoint,soh.customercode,soh.customeraccbal,soh.doctotal,s.discperc
// ''');
//     print("SalesquorHeadHoldvalueDB:" + result.toString());
//     print("SalesOrderHeadHoldvalueDB length:" + result.length.toString()); //SalesQuotationLine

//     return result;
//   }

  static Future<void> deleteHoldSalesQuoMaped(
      Database db, String docentry) async {
    await db.rawQuery(
        '''delete FROM  SalesQuotationLine where docentry=$docentry''');
    await db.rawQuery('''
delete FROM  SalesQuotationHeader where docentry=$docentry''');
  }

  static Future<List<Map<String, Object?>>> getSalesQuotationLinevalueDB(
      Database db, String docentry) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT s.docentry,s.lineid,s.itemcode,s.itemname,s.serialbatch,s.quantity,s.price,s.taxrate,s.discperc,s.maxdiscount,
s.createdateTime,s.quantity-sum(sl.quantity) Balanceqty FROM  SalesQuotationLine s
LEFT JOIN (Select sl.basedocentry, sl.baselineID,sl.quantity from SalesOrderLine sl
                    inner join SalesOrderHeader T3 on sl.docentry=T3.docentry
					Where t3.docstatus=3 and t3.qStatus='C')  sl on sl.basedocentry=s.docentry and sl.baselineid=s.lineid
where s.docentry in ($docentry)
group by s.docentry,s.lineid,s.itemcode,s.itemname,s.serialbatch,s.quantity,s.price,s.taxrate,s.discperc,s.maxdiscount,
s.createdateTime
''');
//log("SalesOrderLinevalueDB:" + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getSalesquoDateWise(
    Database db,
    String fromdate,
    String toDate,
  ) async {
//log('fromdate::${fromdate}::toDate::${toDate}');
    List<Map<String, Object?>> result = await db.rawQuery('''
  select * from SalesQuotationHeader WHERE substr(createdateTime,1,10) BETWEEN '$fromdate' AND '$toDate' AND docstatus='3'AND qStatus='C'
     ''');

    return result;
  }

  static Future<int?> getCustomercount(Database db) async {
    List<Map<String, Object?>> result = await db.rawQuery('''

    select count(customercode) from CustomerMaster
     ''');
    //log(result.toList().toString());
    int? count = Sqflite.firstIntValue(result);
    return count;
  }

  static Future<int?> getBranchMastercount(Database db) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    select count(WhsCode) from BranchMaster
     ''');
    //log("BranchMaster: " + result.toList().toString());
    int? count = Sqflite.firstIntValue(result);
    return count;
  }

  static Future insertBranchTable(
      Database db, List<BranchTModelDB> values) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("BranchMaster", es);
    });
    await batch.commit();
    // final List<Map<String, Object?>> result =
    //     await db.rawQuery('''SELECT * FROM  BranchMaster ''');
    // log('message::$result');
  }

  static Future<List<Map<String, Object?>>> getSaleHeadSapDet(
      Database db, int sapdocen, String table) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''SELECT * FROM  $table where docentry=$sapdocen''');
//log("sapdoc datails: " + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getChartData(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''select  substr('JanFebMarAprMayJunJulAugSepOctNovDec', 1 + 3*strftime('%m', substr(createdatetime,1,10)), -3) as createdatetime ,sum(amtpaid) as amtpaid , 
count(substr(createdatetime,1,10)) as count from SalesHeader 
where  substr(createdatetime,1,10) > DATE(datetime('now'), '-6 month') and docstatus='3'
group by substr('JanFebMarAprMayJunJulAugSepOctNovDec', 1 + 3*strftime('%m', substr(createdatetime,1,10)), -3)''');

//log("Chart datails: " + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getNoSalesData(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''select sum(amtpaid) as amtpaid , count(substr(createdatetime,1,10)) noofsales from SalesHeader 
WHERE substr(createdatetime,1,10) = substr(datetime('now'),1,10) and docstatus="3"''');

//log("getNoSalesData datails: " + result.toString());
    return result;
  }

  static Future<List<ItemMasterModelDB>> getSearchData(
      String data, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
Select * from ItemMaster where (Itemcode || ' - ' || itemname_short) Like '%$data%';
''');

//log("Search data: " + result.toList().toString());
    // log("Saved AllocATE length: " + result.length.toString());

    return List.generate(result.length, (i) {
      return ItemMasterModelDB(
          isselected: int.parse(result[i]['IsSelected'].toString()),
          managedBy: result[i]['ManageBy'].toString(),
          autoId: int.parse(result[i]["AutoId"].toString()),
          itemcode: result[i]["Itemcode"].toString(),
          itemnamelong: result[i]["itemname_long"].toString(),
          itemnameshort: result[i]["itemname_short"].toString(),
          skucode: result[i]["skucode"].toString(),
          brand: result[i]["brand"].toString(),
          category: result[i]["category"].toString(),
          subcategory: result[i]["subcategory"].toString(),
          hsnsac: result[i]["hsn_sac"].toString(),
          taxrate: result[i]["taxrate"].toString(),
          isinventory: result[i]["is_inventory"].toString(),
          isfreeby: result[i]["is_freeby"].toString(),
          isActive: result[i]["is_Active"].toString(),
          createdateTime: result[i]["createdateTime"].toString(),
          updatedDatetime: result[i]["UpdatedDatetime"].toString(),
          createdUserID: result[i]["createdUserID"].toString(),
          updateduserid: result[i]["updateduserid"].toString(),
          lastupdateIp: result[i]["lastupdateIp"].toString(),
          isserialBatch: result[i]["is_serialBatch"].toString(),
          issellpricebyscrbat: result[i]["is_sellpricebyscrbat"].toString(),
          maxdiscount: double.parse(result[i]["maxdiscount"].toString()),
          quantity: double.parse(result[i]["quantity"].toString()),
          minimumQty: result[i]["minimumQty"].toString(),
          maximumQty: result[i]["maximumQty"].toString(),
          weight: double.parse(result[i]["weight"].toString()),
          liter: double.parse(result[i]["liter"].toString()),
          displayQty: result[i]["displayQty"].toString(),
          searchString: result[i]["searchString"].toString(),
          sellprice: result[i]["sellprice"].toString(),
          uPackSize: result[i]['UPackSize'].toString(),
          uTINSPERBOX: int.parse(result[i]['UTINSPERBOX'].toString()),
          uSpecificGravity: result[i]['USpecificGravity'].toString(),
          uPackSizeuom: result[i]['UPackSizeUom'].toString(),
          mrpprice: result[i]["mrpprice"].toString());
    });
  }

  static Future<List<Map<String, Object?>>> getItemMasterData2(
      Database db) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''Select * from ItemMaster''');
    log("SeItemMasterarch data: " + result.length.toString());

    return result;
  }

  static Future<List<ItemMasterModelDB>> getItemMasterData(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
Select * from ItemMaster''');

    log("SeItemMasterarch data: " + result.length.toString());
    // log("Saved AllocATE length: " + result.length.toString());

    return List.generate(result.length, (i) {
      return ItemMasterModelDB(
          isselected: result[i]['IsSelected'] != null
              ? int.parse(result[i]['IsSelected'].toString())
              : 0,
          managedBy: result[i]['ManageBy'].toString(),
          autoId: int.parse(result[i]["AutoId"].toString()),
          itemcode: result[i]["Itemcode"].toString(),
          itemnamelong: result[i]["itemname_long"].toString(),
          itemnameshort: result[i]["itemname_short"].toString(),
          skucode: result[i]["skucode"].toString(),
          brand: result[i]["brand"].toString(),
          category: result[i]["category"].toString(),
          subcategory: result[i]["subcategory"].toString(),
          hsnsac: result[i]["hsn_sac"].toString(),
          taxrate: result[i]["taxrate"].toString(),
          isinventory: result[i]["is_inventory"].toString(),
          isfreeby: result[i]["is_freeby"].toString(),
          isActive: result[i]["is_Active"].toString(),
          createdateTime: result[i]["createdateTime"].toString(),
          updatedDatetime: result[i]["UpdatedDatetime"].toString(),
          createdUserID: result[i]["createdUserID"].toString(),
          updateduserid: result[i]["updateduserid"].toString(),
          lastupdateIp: result[i]["lastupdateIp"].toString(),
          isserialBatch: result[i]["is_serialBatch"].toString(),
          issellpricebyscrbat: result[i]["is_sellpricebyscrbat"].toString(),
          maxdiscount: double.parse(result[i]["maxdiscount"].toString()),
          quantity: double.parse(result[i]["quantity"].toString()),
          minimumQty: result[i]["minimumQty"].toString(),
          maximumQty: result[i]["maximumQty"].toString(),
          weight: double.parse(result[i]["weight"].toString()),
          liter: double.parse(result[i]["liter"].toString()),
          displayQty: result[i]["displayQty"].toString(),
          searchString: result[i]["searchString"].toString(),
          sellprice: result[i]["sellprice"].toString(),
          uPackSize: result[i]['UPackSize'].toString(),
          uTINSPERBOX: int.parse(result[i]['UTINSPERBOX'].toString()),
          uSpecificGravity: result[i]['USpecificGravity'].toString(),
          uPackSizeuom: result[i]['UPackSizeUom'].toString(),
          mrpprice: result[i]["mrpprice"].toString());
    });
  }

  static Future<List<ItemMasterModelDB>> onFieldSeleted(
      String brand,
      String category,
      String segment,
      String isselectedBrand,
      String isSelectedCate,
      String isSelectedsegment,
      String fromAmt,
      String toAmount,
      Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery("""
 SELECT * From ItemMaster A
      Where 
      A.brand <> 'null' and coalesce(A.brand,'') <> '' AND
      A.itemname_short <> 'null' and coalesce(A.itemname_short,'') <> '' AND 
      A.Itemcode <> 'null' and coalesce(A.Itemcode,'') <> '' AND 
      ('$isselectedBrand' = '' OR A.brand in ($brand)) 
      AND ('$isSelectedCate' = '' OR A.Itemcode in ($category)) 
      AND ('$isSelectedsegment' = '' OR A.itemname_short in ($segment)) 
""");

    // log("Saved AllocATE: " + result.toList().toString());
//log("Saved AllocATE length: " + result.length.toString());

    ///

//log(data.toString());

    return List.generate(result.length, (i) {
      return ItemMasterModelDB(
          autoId: int.parse(result[i]["AutoId"].toString()),
          itemcode: result[i]["Itemcode"].toString(),
          itemnamelong: result[i]["itemname_long"].toString(),
          itemnameshort: result[i]["itemname_short"].toString(),
          skucode: result[i]["skucode"].toString(),
          managedBy: result[i]['ManageBy'].toString(),
          brand: result[i]["brand"].toString(),
          category: result[i]["category"].toString(),
          subcategory: result[i]["subcategory"].toString(),
          hsnsac: result[i]["hsn_sac"].toString(),
          taxrate: result[i]["taxrate"].toString(),
          isselected: int.parse(result[i]['IsSelected'].toString()),
          isinventory: result[i]["is_inventory"].toString(),
          isfreeby: result[i]["is_freeby"].toString(),
          isActive: result[i]["is_Active"].toString(),
          createdateTime: result[i]["createdateTime"].toString(),
          updatedDatetime: result[i]["UpdatedDatetime"].toString(),
          createdUserID: result[i]["createdUserID"].toString(),
          updateduserid: result[i]["updateduserid"].toString(),
          lastupdateIp: result[i]["lastupdateIp"].toString(),
          isserialBatch: result[i]["is_serialBatch"].toString(),
          issellpricebyscrbat: result[i]["is_sellpricebyscrbat"].toString(),
          maxdiscount: double.parse(result[i]["maxdiscount"].toString()),
          quantity: double.parse(result[i]["quantity"].toString()),
          minimumQty: result[i]["minimumQty"].toString(),
          maximumQty: result[i]["maximumQty"].toString(),
          weight: double.parse(result[i]["weight"].toString()),
          liter: double.parse(result[i]["liter"].toString()),
          displayQty: result[i]["displayQty"].toString(),
          searchString: result[i]["searchString"].toString(),
          sellprice: result[i]["sellprice"].toString(),
          uPackSize: result[i]['UPackSize'].toString(),
          uTINSPERBOX: int.parse(result[i]['UTINSPERBOX'].toString()),
          uSpecificGravity: result[i]['USpecificGravity'].toString(),
          uPackSizeuom: result[i]['UPackSizeUom'].toString(),
          mrpprice: result[i]["mrpprice"].toString());
    });
  }

  static Future<List<ItemMasterModelDB>> getViewAllData(
      String data, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT DISTINCT $data,IsSelected
 FROM ItemMaster
WHERE $data IS NOT '';
''');

    // log("Saved AllocATE: " + result.toList().toString());
//log("Saved AllocATE length: " + result.length.toString());

    return List.generate(result.length, (i) {
      return ItemMasterModelDB(
          autoId: result[i]["AutoId"] == null
              ? 0
              : int.parse(result[i]["AutoId"].toString()),
          itemcode: result[i]["Itemcode"].toString(),
          itemnamelong: result[i]["itemname_long"].toString(),
          itemnameshort: result[i]["itemname_short"].toString(),
          skucode: result[i]["skucode"].toString(),
          brand: result[i]["brand"].toString(),
          category: result[i]["category"].toString(),
          subcategory: result[i]["subcategory"].toString(),
          hsnsac: result[i]["hsn_sac"].toString(),
          taxrate: result[i]["taxrate"].toString(),
          managedBy: result[i]['ManageBy'].toString(),
          isselected: int.parse(result[i]['IsSelected'].toString()),
          isinventory: result[i]["is_inventory"].toString(),
          isfreeby: result[i]["is_freeby"].toString(),
          isActive: result[i]["is_Active"].toString(),
          createdateTime: result[i]["createdateTime"].toString(),
          updatedDatetime: result[i]["UpdatedDatetime"].toString(),
          createdUserID: result[i]["createdUserID"].toString(),
          updateduserid: result[i]["updateduserid"].toString(),
          lastupdateIp: result[i]["lastupdateIp"].toString(),
          isserialBatch: result[i]["is_serialBatch"].toString(),
          issellpricebyscrbat: result[i]["is_sellpricebyscrbat"].toString(),
          maxdiscount: result[i]["maxdiscount"] == null
              ? 0.0
              : double.parse(result[i]["maxdiscount"].toString()),
          quantity: result[i]["quantity"] == null
              ? 0
              : double.parse(result[i]["quantity"].toString()),
          minimumQty: result[i]["minimumQty"] == null
              ? '0'
              : result[i]["minimumQty"].toString(),
          maximumQty: result[i]["maximumQty"] == null
              ? '0'
              : result[i]["maximumQty"].toString(),
          weight: result[i]["weight"] == null
              ? 0.0
              : double.parse(result[i]["weight"].toString()),
          liter: result[i]["liter"] == null
              ? 0.0
              : double.parse(result[i]["liter"].toString()),
          displayQty: result[i]["displayQty"] == null
              ? '0'
              : result[i]["displayQty"].toString(),
          searchString: result[i]["searchString"].toString(),
          sellprice: result[i]["sellprice"].toString(),
          uPackSize: result[i]['UPackSize'].toString(),
          uTINSPERBOX: int.parse(result[i]['UTINSPERBOX'].toString()),
          uSpecificGravity: result[i]['USpecificGravity'].toString(),
          uPackSizeuom: result[i]['UPackSizeUom'].toString(),
          mrpprice: result[i]["mrpprice"].toString());
    });
  }

  static Future<List<ItemMasterModelDB>> getFavData(
      String fav, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT DISTINCT $fav,IsSelected FROM ItemMaster WHERE $fav IS NOT '' ;
''');

    // log("Saved AllocATE: " + result.toList().toString());
//log("Saved AllocATE length: " + result.length.toString());

    return List.generate(result.length, (i) {
      return ItemMasterModelDB(
        autoId: result[i]["AutoId"] == null
            ? 0
            : int.parse(result[i]["AutoId"].toString()),
        itemcode: result[i]["Itemcode"].toString(),
        isselected: int.parse(result[i]['IsSelected'].toString()),
        itemnamelong: result[i]["itemname_long"].toString(),
        managedBy: result[i]['ManageBy'].toString(),

        itemnameshort: result[i]["itemname_short"].toString(),
        skucode: result[i]["skucode"].toString(),
        brand: result[i]["brand"].toString(),
        category: result[i]["category"].toString(),
        subcategory: result[i]["subcategory"].toString(),
        hsnsac: result[i]["hsn_sac"].toString(),
        taxrate: result[i]["taxrate"].toString(),
        isinventory: result[i]["is_inventory"].toString(),
        isfreeby: result[i]["is_freeby"].toString(),
        isActive: result[i]["is_Active"].toString(),
        createdateTime: result[i]["createdateTime"].toString(),
        updatedDatetime: result[i]["UpdatedDatetime"].toString(),
        createdUserID: result[i]["createdUserID"].toString(),
        updateduserid: result[i]["updateduserid"].toString(),
        lastupdateIp: result[i]["lastupdateIp"].toString(),
        isserialBatch: result[i]["is_serialBatch"].toString(),
        issellpricebyscrbat: result[i]["is_sellpricebyscrbat"].toString(),
        maxdiscount: result[i]["maxdiscount"] == null
            ? 0.0
            : double.parse(result[i]["maxdiscount"].toString()),
        quantity: result[i]["quantity"] == null
            ? 0
            : double.parse(result[i]["quantity"].toString()),
        minimumQty: result[i]["minimumQty"] == null
            ? '0'
            : result[i]["minimumQty"].toString(),
        maximumQty: result[i]["maximumQty"] == null
            ? '0'
            : result[i]["maximumQty"].toString(),
        weight: result[i]["weight"] == null
            ? 0.0
            : double.parse(result[i]["weight"].toString()),
        liter: result[i]["liter"] == null
            ? 0.0
            : double.parse(result[i]["liter"].toString()),
        displayQty: result[i]["displayQty"] == null
            ? '0'
            : result[i]["displayQty"].toString(),
        searchString: result[i]["searchString"].toString(),
        sellprice: result[i]["sellprice"].toString(),
        mrpprice: result[i]["mrpprice"].toString(),
        uPackSize: result[i]['UPackSize'].toString(),
        // uTINSPERBOX: int.parse(result[i]['UTINSPERBOX'].toString()),
        uSpecificGravity: result[i]['USpecificGravity'].toString(),
        uPackSizeuom: result[i]['UPackSizeUom'].toString(),
      );
    });
  }

  static Future<List<Map<String, Object?>>> getNoSalesOrderData(
      Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''select sum(doctotal) as doctotal , count(substr(createdatetime,1,10)) noofsales from SalesOrderHeader 
WHERE  substr(createdatetime,1,10) = substr(datetime('now'),1,10)''');

    //log("getNoSalesOrderData datails: " + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getSynceData(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT	sapDocNo,qStatus,docentry,basedocentry,documentno,editType,createdateTime,UpdatedDatetime,doctype,customername from SalesOrderHeader where docstatus='3' and qStatus='C'
UNION ALL
SELECT	sapDocNo,qStatus,docentry,'',documentno, editType,createdateTime,UpdatedDatetime,doctype,customername from SalesQuotationHeader  where docstatus='3'and qStatus='C'
UNION ALL
SELECT	sapDocNo,qStatus,docentry,basedocentry,documentno,"",createdateTime,UpdatedDatetime,doctype,customername from SalesHeader  where docstatus='3'and qStatus='C'
UNION ALL
Select  sapDocNo,qStatus,docentry,basedocentry,documentno,"",createdateTime,UpdatedDatetime,doctype,customername from SalesReturnHeader where docstatus='3'and qStatus='C'
 UNION ALL
 Select  sapDocNo,qStatus,docentry,'',documentno,"",createdateTime,UpdatedDatetime,doctype,customer from ReceiptHeader where docstatus='3'and qStatus='C'
UNION ALL
Select  sapDocNo,qStatus,docentry,'',documentno,"",createdateTime,UpdatedDatetime,doctype,reqtoWhs from StockReqHDT where docstatus='3' and qStatus='C'
UNION ALL
SELECT  sapDocNo,qStatus,docentry,'',documentno,"",createdateTime,UpdatedDatetime,'Stock Outward',reqtoWhs from StockOutHeaderDataDB where docstatus='3'and qStatus='C'
UNION ALL
SELECT  sapDocNo,qStatus,docentry,'',documentno,"",createdateTime,UpdatedDatetime,'Stock Inward',reqtoWhs from StockInHeaderDB where docstatus='3'and qStatus='C'
UNION ALL
SELECT	sapDocNo,qStatus,docentry,'',documentno,"",createdateTime,'',doctype,expencecode from Expense where docstatus='2'and qStatus='C'
UNION ALL
SELECT	sapDocNo,qStatus,docentry,'',documentno,"",createdateTime,UpdatedDatetime,doctype,typedeposit from tableDepositHeader where doctype='Deposit'and qStatus='C'
''');

    // log("getSynceData datails: " + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getQstatusData(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        ''' SELECT	sapDocentry,sapDocNo,qStatus,docentry,basedocentry,"",doctype,UpdatedDatetime from SalesHeader where qStatus !='C' 
UNION ALL
SELECT	sapDocentry,sapDocNo,qStatus,docentry,1,"",doctype,UpdatedDatetime from SalesQuotationHeader where qStatus !='C' 
UNION ALL
Select  sapDocentry,sapDocNo,qStatus,docentry,1,"",doctype,UpdatedDatetime from StockReqHDT where qStatus !='C' 
UNION ALL
Select  sapDocentry,sapDocNo,qStatus,docentry,basedocentry,"",doctype,UpdatedDatetime from SalesReturnHeader where qStatus !='C' 
 UNION ALL
Select  sapDocentry,sapDocNo,qStatus,docentry,1,"",doctype,UpdatedDatetime from ReceiptHeader where qStatus !='C' 
UNION ALL
SELECT	sapDocentry,sapDocNo,qStatus,docentry,basedocentry,"",doctype,UpdatedDatetime from SalesOrderHeader where qStatus !='C' 
UNION ALL
SELECT sapDocentry,sapDocNo,qStatus,docentry,baseDocentry,"",'Stock Outward',UpdatedDatetime from StockOutHeaderDataDB where qStatus !='C' 
UNION ALL
SELECT  sapDocentry,sapDocNo,qStatus,docentry,baseDocentry,"",'Stock Inward',UpdatedDatetime from StockInHeaderDB where qStatus !='C' 
UNION ALL
SELECT sapDocentry,sapDocNo,qStatus,docentry,1,"",doctype,"", FROM Expense where qStatus !='C' 
UNION ALL
SELECT sapDocentry,sapDocNo,qStatus,docentry,1,"",doctype,"", FROM tableDepositHeader where qStatus !='C' 
UNION ALL
SELECT sapDocentry,sapDocNo,qStatus,docentry,1,"",doctype,"", FROM RefundHeader where qStatus !='C' 
''');
    return result;
  }

  static Future<List<Map<String, Object?>>> getQstatusData22(
      Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        ''' SELECT	sapDocentry,sapDocNo,qStatus,docentry,basedocentry,"",doctype from SalesHeader where qStatus =='Y' 
UNION ALL
SELECT	sapDocentry,sapDocNo,qStatus,docentry,1,"",doctype from SalesQuotationHeader where qStatus =='Y' 
UNION ALL
Select  sapDocentry,sapDocNo,qStatus,docentry,1,"",doctype from StockReqHDT where qStatus =='Y' 
UNION ALL
Select  sapDocentry,sapDocNo,qStatus,docentry,basedocentry,"",doctype from SalesReturnHeader where qStatus =='Y' 
 UNION ALL
Select  sapDocentry,sapDocNo,qStatus,docentry,1,"",doctype from ReceiptHeader where qStatus =='Y' 
UNION ALL
SELECT	sapDocentry,sapDocNo,qStatus,docentry,basedocentry,"",doctype from SalesOrderHeader where qStatus =='Y' 
UNION ALL
SELECT sapDocentry,sapDocNo,qStatus,docentry,baseDocentry,"",'Stock Outward' from StockOutHeaderDataDB where qStatus =='Y' 
UNION ALL
SELECT  sapDocentry,sapDocNo,qStatus,docentry,baseDocentry,"",'Stock Inward' from StockInHeaderDB where qStatus =='Y' 
UNION ALL
SELECT sapDocentry,sapDocNo,qStatus,docentry,1,"",doctype FROM Expense where qStatus =='Y' 
UNION ALL
SELECT sapDocentry,sapDocNo,qStatus,docentry,1,"",doctype FROM tableDepositHeader where qStatus =='Y' 
UNION ALL
SELECT sapDocentry,sapDocNo,qStatus,docentry,1,"",doctype FROM RefundHeader where qStatus =='Y' 
''');
//log("get_QstatusData datails22: " + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getQstatusData33(
      Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        ''' SELECT	sapDocentry,sapDocNo,qStatus,docentry,basedocentry,"",doctype,createdateTime from SalesHeader where qStatus =='C'
UNION ALL
SELECT	sapDocentry,sapDocNo,qStatus,docentry,1,"",doctype,createdateTime from SalesQuotationHeader where qStatus =='C' 
UNION ALL
Select  sapDocentry,sapDocNo,qStatus,docentry,1,"",doctype,createdateTime from StockReqHDT where qStatus =='C' 
UNION ALL
Select  sapDocentry,sapDocNo,qStatus,docentry,basedocentry,"",doctype,createdateTime from SalesReturnHeader where qStatus =='C' 
 UNION ALL
Select  sapDocentry,sapDocNo,qStatus,docentry,1,"",doctype,createdateTime from ReceiptHeader where qStatus =='C' 
UNION ALL
SELECT	sapDocentry,sapDocNo,qStatus,docentry,basedocentry,"",doctype,createdateTime from SalesOrderHeader where qStatus =='C' 
UNION ALL
SELECT sapDocentry,sapDocNo,qStatus,docentry,baseDocentry,"",'Stock Outward',createdateTime from StockOutHeaderDataDB where qStatus =='C' 
UNION ALL
SELECT  sapDocentry,sapDocNo,qStatus,docentry,baseDocentry,"",'Stock Inward',createdateTime from StockInHeaderDB where qStatus =='C' 
UNION ALL
SELECT sapDocentry,sapDocNo,qStatus,docentry,1,"",doctype,"" FROM Expense where qStatus =='C' 
UNION ALL
SELECT sapDocentry,sapDocNo,qStatus,docentry,1,"",doctype,"" FROM tableDepositHeader where qStatus =='C' 
UNION ALL
SELECT sapDocentry,sapDocNo,qStatus,docentry,1,"",doctype,"" FROM RefundHeader where qStatus =='C' 
''');
//log("get_QstatusData datails22: " + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getoutofDataData(
      Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        ''' select T1.ItemCode,t1.itemnameshort, t1.minimumQty, sum(T2.quantity) as qty ,t1.minimumQty- sum(T2.quantity) shortageQty
from ItemMaster T1 
INNER JOIN StockSnap T2 on T1.itemcode = T2.itemcode 
GROUP by T1.ItemCode,t1.itemnameshort, t1.minimumQty 
HAVING  T1.minimumQty >= sum(T2.quantity)
 ''');

//     final List<Map<String, Object?>> ItemMaster =
//         await db.rawQuery(''' select * from ItemMaster
//  ''');
//     final List<Map<String, Object?>> StockSnap =
//         await db.rawQuery(''' select * from StockSnap
//  ''');
    //log("ItemMaster==: " + ItemMaster.length.toString());
    //log("StockSnap==: " + StockSnap.length.toString());

    //log("getoutofDataData datails: " + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getExpensHeaderData(
      Database db, int docentry) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  Expense where docentry=$docentry''');
    //log("'SELECT * FROM  Expense where docentry=$docentry'" +
    // result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getCouponsCount(Database db) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''select count(*) as count FROM CouponDetailsT 
 ''');
    //log("select count(*) as count FROM CouponDetailsT " + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getCouponsUsedCount(
      Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''select count(*) as count FROM CouponDetailsT WHERE status = 'Used'
 ''');
    //log("select count(*) as count FROM CouponDetailsT WHERE status = 'Used' " +
    // result.toString());
    return result;
  }

//UserTable insert
  static Future insertUsers(Database db, List<UserModelDB> values) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("Users", es);
    });

    await batch.commit();
    getusers(db);
  }

  static Future<List<Map<String, Object?>>> getusers(
    Database db,
  ) async {
    List<Map<String, Object?>> result =
        await db.rawQuery("select * from Users");
    log("Users RRSS" + result.toList().toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getusersvaldata(
      Database db, String userssName) async {
    log("userNameuserName" + userssName.toString());
    List<Map<String, Object?>> result = await db.rawQuery(
        "select * from Users where Lower(userName)=Lower('$userssName')");
    // log("Users RRSS" + result.toList().toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> checkUSerAvail(
    Database db,
    String usn,
    pass,
    branch,
  ) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
     select * from Users where userName = "$usn" and password = "$pass" and branch = "$branch" and userstatus = "Y"
     ''');
    //log(' select * from Users where userName = "$usn" and password = "$pass" and branch = "$branch" and userstatus = "Y"');
////log('select count(autoId) * from Users where userName = "$usn" and password = "$pass" and branch = "$branch" and userstatus = "N"');
    //log(result.toList().toString());
//int? count = Sqflite.firstIntValue(result);
////log("count: "+count.toString());
    // return count;

    return result;
  }

  // customer address insert
  static Future insertCustomerAddress(
      Database db, List<CustomerAddressModelDB> values) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("CustomerMasterAddress", es);
    });
    // log("CustomerMasterAddress::" + result2.toList().toString());
    await batch.commit();
  }

  static Future<int?> getCustomerAddress(Database db) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    select count(custcode) from CustomerMasterAddress
     ''');
    //log(result.toList().toString());
    int? count = Sqflite.firstIntValue(result);
    return count;
  }

  static Future<int?> getItemMasterCount(Database db) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    select count(*) from StockSnap
     ''');
//log(result.toList().toString());
    int? count = Sqflite.firstIntValue(result);
    return count;
  }

  static Future<int?> getProductMasterCount(Database db) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    select count(*) from ItemMaster
     ''');
//log(result.toList().toString());
    int? count = Sqflite.firstIntValue(result);
    return count;
  }

  static Future<int?> getBranchMasterCount(Database db) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    select count(*) from BranchMaster
     ''');
//log(result.toList().toString());
    int? count = Sqflite.firstIntValue(result);
    return count;
  }

  static Future<int?> getCustomerMasterCount(Database db) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    select count(*) from CustomerMaster
     ''');
    log(result.toList().toString());
    int? count = Sqflite.firstIntValue(result);
    return count;
  }

  static Future<int?> getCustomerAddressMasterCount(Database db) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    select count(*) from CustomerMasterAddress
     ''');
//log("CustomerMasterAddress" + result.toList().toString());
    int? count = Sqflite.firstIntValue(result);
    return count;
  }

  static Future<void> getdata(Database db) async {
    // log("CustomerMaster RRSS" + result.toList().toString());

    // log("CustomerMasterAddress RRSS" + result2.toList().toString());
    // log(result.length.toString());
  }

  static Future<List<CustomerModelDB>> getCstmMasDB(
    Database db,
  ) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''SELECT * FROM  CustomerMaster''');
    log("CustomerMaster Len: " + result.length.toString());
    return List.generate(result.length, (i) {
      return CustomerModelDB(
        autoid: result[i]['autoid'].toString(),
        customerCode: result[i]['customerCode'].toString(),
        uCashCust: result[i]['U_CASHCUST'].toString(),

        createdUserID: result[i]['createdUserID'].toString(),
        createdateTime: result[i]['createdateTime'].toString(),
        lastupdateIp: result[i]['lastupdateIp'].toString(),
        updatedDatetime: result[i]['UpdatedDatetime'].toString(),
        updateduserid: int.parse(result[i]['updateduserid'].toString()),
        balance: double.parse(result[i]['balance'].toString()),
        createdbybranch: result[i]['createdbybranch'].toString(),
        customername: result[i]['customername'].toString(),
        customertype: result[i]['customertype'].toString(),
        emalid: result[i]['emalid'].toString(),
        phoneno1: result[i]['phoneno1'].toString(),
        phoneno2: result[i]['phoneno2'].toString(),
        points: double.parse(result[i]['points'].toString()),
        premiumid: result[i]['premiumid'].toString(),
        snapdatetime: result[i]['snapdatetime'].toString(),
        taxno: result[i]['taxno'].toString(),
        taxCode: result[i]['TaxCode'].toString(),
        // terminal: result[i]['terminal'].toString(),
        // tinNo: result[i]['tinNo'].toString(),
        // vatregno: result[i]['vatregno'].toString()
      );
    });
  }

  static Future<List<CustomerModelDB>> getNewApiCstmMasDB(
    Database db,
  ) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''SELECT * FROM  CustomerMaster''');
    // log("CustomerMaster Len: " + result.toString());
    return List.generate(result.length, (i) {
      return CustomerModelDB(
        autoid: result[i]['autoid'].toString(),
        customerCode: result[i]['customerCode'].toString(),
        createdUserID: result[i]['createdUserID'].toString(),
        createdateTime: result[i]['createdateTime'].toString(),
        lastupdateIp: result[i]['lastupdateIp'].toString(),
        uCashCust: result[i]['U_CASHCUST'].toString(),

        updatedDatetime: result[i]['updatedDatetime'].toString(),
        updateduserid: int.parse(result[i]['updateduserid'].toString()),
        balance: double.parse(result[i]['balance'].toString()),
        createdbybranch: result[i]['createdbybranch'].toString(),
        customername: result[i]['customername'].toString(),
        customertype: result[i]['customertype'].toString(),
        emalid: result[i]['emalid'].toString(),
        phoneno1: result[i]['phoneno1'].toString(),
        phoneno2: result[i]['phoneno2'].toString(),
        points: double.parse(result[i]['points'].toString()),
        premiumid: result[i]['premiumid'].toString(),
        snapdatetime: result[i]['snapdatetime'].toString(),
        taxno: result[i]['taxno'].toString(),
        taxCode: result[i]['TaxCode'].toString(),
        // terminal: result[i]['terminal'].toString(),
        // tinNo: result[i]['tinNo'].toString(),
        // vatregno: result[i]['vatregno'].toString()
      );
    });
  }

  static Future<List<CustomerAddressModelDB>> getCstmMasAddDB(
    Database db,
  ) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''SELECT * FROM  CustomerMasterAddress''');
    // log("CustomerAddress addresstype Len: " + result.length.toString());
    return List.generate(result.length, (i) {
      return CustomerAddressModelDB(
        autoid: result[i]['autoid'].toString(),
        createdUserID: result[i]['createdUserID'].toString(),
        createdateTime: result[i]['createdateTime'].toString(),
        lastupdateIp: result[i]['lastupdateIp'].toString(),
        updatedDatetime: result[i]['UpdatedDatetime'].toString(),
        updateduserid: result[i]['updateduserid'].toString(),
        address1: result[i]['address1'].toString(),
        address2: result[i]['address2'].toString(),
        address3: result[i]['address3'].toString(),
        city: result[i]['city'].toString(),
        countrycode: result[i]['countrycode'].toString(),
        custcode: result[i]['custcode'].toString(),
        geolocation1: result[i]['geolocation1'].toString(),
        geolocation2: result[i]['geolocation2'].toString(),
        statecode: result[i]['statecode'].toString(),
        pincode: result[i]['pincode'].toString(),
        terminal: result[i]['terminal'].toString(),
        branch: result[i]['branch'].toString(),
        addresstype: result[i]['addresstype'].toString(),
      );
    });
  }

  static Future<List<CustomerAddressModelDB>> getCstmMasAddDBCardCode(
      Database db, String custCode) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  CustomerMasterAddress where custcode = "$custCode"''');
    // log("CustomerAddress addresstype Len: " + result.length.toString());
    return List.generate(result.length, (i) {
      log('message addresstype::${result[i]['addresstype'].toString()}');
      return CustomerAddressModelDB(
        autoid: result[i]['autoid'].toString(),
        createdUserID: result[i]['createdUserID'].toString(),
        createdateTime: result[i]['createdateTime'].toString(),
        lastupdateIp: result[i]['lastupdateIp'].toString(),
        updatedDatetime: result[i]['UpdatedDatetime'].toString(),
        updateduserid: result[i]['updateduserid'].toString(),
        address1: result[i]['address1'].toString(),
        address2: result[i]['address2'].toString(),
        address3: result[i]['address3'].toString(),
        city: result[i]['city'].toString(),
        countrycode: result[i]['countrycode'].toString(),
        custcode: result[i]['custcode'].toString(),
        geolocation1: result[i]['geolocation1'].toString(),
        geolocation2: result[i]['geolocation2'].toString(),
        statecode: result[i]['statecode'].toString(),
        pincode: result[i]['pincode'].toString(),
        terminal: result[i]['terminal'].toString(),
        branch: result[i]['branch'].toString(),
        addresstype: result[i]['addresstype'].toString(),
      );
    });
  }

  static Future<List<Map<String, Object?>>> addgetCstmMasAddDB(
      Database db, String custCode) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  CustomerMasterAddress where custcode = "$custCode"''');
    // log("SELECT * FROM  CustomerMasterAddress where autoid = $autoid");
    // log("CustomerMasterAddress: $result");
    return result;
  }

  static Future<List<CustomerAddressModelDB>> createNewgetCstmMasAddDB(
      Database db, String cardCode) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  CustomerMasterAddress WHERE custcode="$cardCode"''');
    //log("Len1111: " + result.length.toString());
//log("Result of custadd: " + result.toString());
    return List.generate(result.length, (i) {
      return CustomerAddressModelDB(
        autoid: result[i]['autoid'].toString(),
        createdUserID: result[i]['createdUserID'].toString(),
        createdateTime: result[i]['createdateTime'].toString(),
        lastupdateIp: result[i]['lastupdateIp'].toString(),
        updatedDatetime: result[i]['UpdatedDatetime'].toString(),
        updateduserid: result[i]['updateduserid'].toString(),
        addresstype: result[i]['addresstype'].toString(),
        address1: result[i]['address1'].toString(),
        address2: result[i]['address2'].toString(),
        address3: result[i]['address3'].toString(),
        city: result[i]['city'].toString(),
        countrycode: result[i]['countrycode'].toString(),
        custcode: result[i]['custcode'].toString(),
        geolocation1: result[i]['geolocation1'].toString(),
        geolocation2: result[i]['geolocation2'].toString(),
        statecode: result[i]['statecode'].toString(),
        pincode: result[i]['pincode'].toString(),
        terminal: result[i]['terminal'].toString(),
        branch: result[i]['branch'].toString(),
      );
    });
  }

  static Future updateAddressDetails(
      Database db, int i, CustomerDetals selectedcust, String autoid) async {
    // log('Add autoidautoid::' + autoid.toString());String custcode,String custcode,

    // log('Add custcodecustcodecustcode::' + custcode.toString());
    // log('selectedcust.address![i].address1::' +
    //     selectedcust.address![i].address1.toString());
    // log('selectedcust.address![i].address2::' +
    //     selectedcust.address![i].address2.toString());
    // log('selectedcust.address![i].address3::' +
    //     selectedcust.address![i].address3.toString());
    // log('selectedcust.address![i].billCity::' +
    //     selectedcust.address![i].billCity.toString());
    final List<Map<String, Object?>> result =
        await db.rawQuery(''' UPDATE CustomerMasterAddress SET
        address1="${selectedcust.address![i].address1}",
        address2="${selectedcust.address![i].address2}",
        address3="${selectedcust.address![i].address3}",
        city="${selectedcust.address![i].billCity}",
        countrycode="${selectedcust.address![i].billCountry}",
        pincode="${selectedcust.address![i].billPincode}",
        statecode="${selectedcust.address![i].billstate}"
 WHERE addresstype="B" and autoid=$autoid ''');

//log("Update Address Detailsbb" + result.toString());
    return result;
  }

// String custcode,custcode ="$custcode" and
  static Future updateShipAddressDetails(
      Database db, int ij, CustomerDetals selectedcust55, String autoid) async {
//log('Add autoidautoidautoid::' + autoid.toString());

//log('selectedcust55.address![ij].address1::' +
    // selectedcust55.address![ij].address1.toString());
//log('selected/cust55.address![ij].address2::' +
    // selectedcust55.address![ij].address2.toString());
//log('selectedcust55.address![i].address3::' +
    // selectedcust55.address![ij].address3.toString());
//log('selectedcust55.address![ij].billCity::' +
    // selectedcust55.address![ij].billCity.toString());
    final List<Map<String, Object?>> result =
        await db.rawQuery(''' UPDATE CustomerMasterAddress SET
        address1="${selectedcust55.address![ij].address1}",
        address2="${selectedcust55.address![ij].address2}",
        address3="${selectedcust55.address![ij].address3}",
        city="${selectedcust55.address![ij].billCity}",
        countrycode="${selectedcust55.address![ij].billCountry}",
        pincode="${selectedcust55.address![ij].billPincode}",
        statecode="${selectedcust55.address![ij].billstate}"
 WHERE addresstype="S" and autoid=$autoid ''');
    // final List<Map<String, Object?>> result2 = await db.rawQuery(
    //     '''SELECT * FROM  CustomerMasterAddress  WHERE custcode ="$custcode" and addresstype="S" and autoid="$autoid"''');

//log("selectedcust55 Update Address Det" + result.toString());
    return result;
  }

  static Future updateCustomerAccBal(
      Database db, String cardCode, CustomerDetals selectedcust) async {
//log("cardCodecardCodecardCode::" + selectedcust.cardCode.toString());
//log("selectedcust.accBalance::" + selectedcust.accBalance.toString());

//log("Update Customer Details" + result2.toString());
    // return result;
  }

  static Future updateCustomerDetails(
      Database db, String autoid, CustomerDetals selectedcust) async {
    // log("cardCodecardCodecardCode::" + selectedcust.cardCode.toString());
    // log("selectedcust.accBalance::" + selectedcust.accBalance.toString());
    // log("selectedcust.name::" + selectedcust.name.toString());
    // log("selectedcust.email::" + selectedcust.email.toString());
//log("selectedcust.phNo::" + selectedcust.phNo.toString());

    final List<Map<String, Object?>> result =
        await db.rawQuery(''' UPDATE CustomerMaster SET 
        balance ="${selectedcust.accBalance}",
         customername="${selectedcust.name}",
        emalid="${selectedcust.email}",
phoneno1="${selectedcust.phNo}",
phoneno2="${selectedcust.phNo}",
points="${selectedcust.point}",
taxno="${selectedcust.tarNo}" WHERE autoid="$autoid" 
''');
    // final List<Map<String, Object?>> result2 = await db
    //     .rawQuery('''SELECT * FROM CustomerMaster WHERE autoid="$autoid"''');
    return result;
  }
// {customercode: A1B2, customername: ASDFGHI, premiumid: , customertype: , taxno: Gst, createdbybranch: HOFG, balance: 0, points: 0, snapdatetime: 2023-08-08 15:09:17, phoneno1: 1236547890, phoneno2: , emalid: assdddd@gmail.com, terminal: T1, createdateTime: 2023-08-08 15:09:17, UpdatedDatetime: 2023-08-08 15:09:17, createdUserID: 1, updateduserid: 1, lastupdateIp: 192.198.182.1}]

  static Future updateCustomerDetailstocrdcode(
      Database db, String cardcode, String autoid) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery(''' UPDATE CustomerMaster SET 
        customerCode ="$cardcode"
        WHERE autoid="$autoid" 
''');
    // final List<Map<String, Object?>> result2 = await db
    //     .rawQuery('''SELECT * FROM CustomerMaster WHERE autoid="$autoid"''');
    log('message::${result.length}');
    return result;
  }

  static Future updateCustAddrsscrdcode(
      Database db, String cardcode, String autoid) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery(''' UPDATE CustomerMasterAddress SET 
        custcode ="$cardcode"
        WHERE autoid="$autoid" 
''');
    // final List<Map<String, Object?>> result2 = await db.rawQuery(
    //     '''SELECT * FROM CustomerMasterAddress WHERE autoid="$autoid"''');
    return result;
  }

  static Future updateCustomercrdcodefrmsap(
    Database db,
    String sapcardcode,
  ) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery(''' UPDATE CustomerMaster SET 
        customercode ="$sapcardcode"
        WHERE autoid=customercode
''');
//log("Update Customer Details" + result2.toString());
    return result;
  }

  static Future<List<UserModelDB>> userValues(
      Database db, String usercode) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  Users where usercode="$usercode" ''');
    //log("Users Len: " + result.length.toString());
    //log("User Tables Values:" + result.toList().toString());
    return List.generate(result.length, (i) {
      return UserModelDB(
        autoId: int.parse(result[i]["autoId"].toString()),
        branch: result[i]["branch"].toString(),
        terminal: result[i]["terminal"].toString(),
        createdUserID: result[i]["createdUserID"].toString(),
        createdateTime: result[i]["createdateTime"].toString(),
        lastpasswordchanged: result[i]["lastpasswordchanged"].toString(),
        lastupdateIp: result[i]["lastupdateIp"].toString(),
        licensekey: result[i]["licensekey"].toString(),
        lockpin: result[i]["lockpin"].toString(),
        password: result[i]["password"].toString(),
        updatedDatetime: result[i]["UpdatedDatetime"].toString(),
        updateduserid: int.parse(result[i]["updateduserid"].toString()),
        userName: result[i]["userName"].toString(),
        usercode: result[i]["usercode"].toString(),
        userstatus: result[i]["userstatus"].toString(),
        usertype: result[i]["usertype"].toString(),
      );
    });
  }

  static Future<int?> insertSaleheader(
      Database db, List<SalesHeaderTModelDB> values) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("SalesHeader", es);
    });
    await batch.commit();

    //log("SalesHeader:" + result1.toString());

    List<Map<String, Object?>> result = await db.rawQuery('''
     SELECT docentry FROM SalesHeader  ORDER BY docentry DESC limit 1
     ''');
    //log("SalesHeader result:: " + result.toString());
    int? count = Sqflite.firstIntValue(result);
    //log("SalesHeader count:: " + count.toString());
    return count ?? 0;
  }

  static Future<int?> getDocNO(Database db, String colName, tableName) async {
    // select max ((documentno) +1 )from StockReqHDT select documentno from StockReqHDT
    List<Map<String, Object?>> result = await db.rawQuery('''
    select IFNULL(MAX($colName)+1,1) as docno from $tableName
     ''');
    //log("result:: " + result.toString());
    int? count = Sqflite.firstIntValue(result);
    //log("count:: " + count.toString());

    return count;
  }

  static Future insertSalesPay(
      Database db, List<SalesPayTDB> values, int? docEntry) async {
    var data = values.map((e) => e.toMap(docEntry)).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("SalesPay", es);
    });
    await batch.commit();
    //log("SalesPay Table:" + result1.toString());
  }

  static Future insertSalesLine(
      Database db, List<SalesLineTDB> values, int docEntry) async {
    var data = values.map((e) => e.toMap(docEntry)).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("SalesLine", es);
    });
    await batch.commit();
    // final List<Map<String, Object?>> result1 =
    //     await db.rawQuery('''SELECT * FROM  SalesLine''');
    //log("SalesLine:" + result1.toString());
  }

  static Future<List<Map<String, Object?>>> getSalesHeadHoldvalueDB(
    Database db,
  ) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  SalesHeader where docstatus = "1"''');
    // log("getSalesHeadHoldvalueDB length:" + result.length.toString());

    log("getSalesHeadHoldvalueDB:" + result.toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getSalesHeadHoldvalueddDB(
      Database db, String docentry) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  SalesHeader where docstatus = '1'and docentry = "$docentry"''');
    // log("getSalesHeadHoldvalueDB length:" + result.length.toString());

    // log("getSalesHeadHoldvalueDB:" + result.toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getSalesHeaderDB(
      Database db, int docentry) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  SalesHeader where docentry=$docentry''');
//log("getSalesHeadHoldvaluessDB:" + result.toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> checkItemCode(
      Database db, String itemcode) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery(''' select * from StockSnap where itemcode = "$itemcode"''');
    log('itemcode result:::$result');
    return result;
  }

  static Future<List<Map<String, Object?>>> serialBatchCheck(
      Database db, String serialBatch, String itemcode) async {
    log('''
     SELECT * from StockSnap WHERE itemcode="$itemcode" or serialbatch="$serialBatch"
     ''');
    List<Map<String, Object?>> result = await db.rawQuery('''
     SELECT * from StockSnap WHERE itemcode="$itemcode" 
     ''');
    //or serialbatch="$serialBatch"
    // log('"SELECT * from StockSnap :::' + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> cfoserialBatchCheck(
      Database db, String itemcode) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
     SELECT * from StockSnap WHERE itemcode="$itemcode"
     ''');
    // log('"SELECT * from StockSnap WHERE itemcode="$itemcode" :::' +
    // result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> itemcodeserialbatch(
      Database db, String serialbatch) async {
    final List<Map<String, Object?>> result1 = await db.rawQuery(
        ''' select * from StockSnap where  serialbatch = "$serialbatch"''');
    final List<Map<String, Object?>> result2 = await db
        .rawQuery(''' select serialbatch, itemcode from StockSnap Limit 15''');
    log('result2result2result2::$result2');
    return result1;
  }

  // static Future<List<Map<String, Object?>>> ItemcodeserialItembatch(Database db, String itemcode, String serialbatch) async {
  //   final List<Map<String, Object?>> result1 = await db.rawQuery(''' select * from StockSnap where itemcode="$itemcode" and serialbatch = "$serialbatch"''');
  //   print("ItemCode:" + result1.toString());
  //   return result1;
  // }

  static Future<List<Map<String, Object?>>> getTopCuslist(Database db) async {
    final List<Map<String, Object?>> result1 = await db.rawQuery(
        ''' SELECT customerCode, customername, count(customerCode) from SalesHeader WHERE docstatus='3' GROUP by customercode ORDER by  count(customercode) DESC LIMIT 10 ''');
    // log("getTopCuslist1:::" + ßresult1.length.toString());
    return result1;
  }

// LED-150K-250K-2Yr
  static Future<List<Map<String, Object?>>> getHoldSalesPayDB(
      Database db, int docentry) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  SalesPay where docentry=$docentry''');
    return result;
  }

  static Future<List<Map<String, Object?>>> holdSalesLineDB(
      Database db, int docentry) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  SalesLine where docentry=$docentry''');
    //log("docentrydocentrydocentry:" + docentry.toString());
    // log("SalesLine result:" + result.toString());
    return result;
  }

  static Future deleteInvoicewholedata(
    Database db,
  ) async {
    //log('deleted doc entry no:' + docEntry.toString());

    await db.rawQuery('''
    delete from SalesPay
     ''');
    await db.rawQuery('''
    delete from SalesLine
     ''');
    await db.rawQuery('''
    delete from SalesHeader
     ''');

    // //log("Branch *: "+result3.toList().toString());
    //log("SH2" + sh2.toString());
  }

  static Future deleteHold(Database db, String docEntry) async {
    //log('deleted doc entry no:' + docEntry.toString());

    await db.rawQuery('''
    delete from SalesPay where docentry = $docEntry
     ''');
    await db.rawQuery('''
    delete from SalesLine where docentry = $docEntry
     ''');
    await db.rawQuery('''
    delete from SalesHeader where docentry = $docEntry
     ''');

    // //log("Branch *: "+result3.toList().toString());
    //log("SH2" + sh2.toString());
  }

  static Future deleteOrderHold(Database db, String docEntry) async {
    //log('deleted doc entry no:' + docEntry.toString());
    await db.rawQuery('''
    delete from SalesOrderHeader where docentry = $docEntry
     ''');
    await db.rawQuery('''
    delete from SalesOrderPay where docentry = $docEntry
     ''');
    await db.rawQuery('''
    delete from SalesOrderLine where docentry = $docEntry
     ''');

    // //log("Branch *: "+result3.toList().toString());
    //log("SH2" + sh2.toString());
  }

  static Future deleteSalesOrder(
    Database db,
  ) async {
    //log('deleted doc entry no:' + docEntry.toString());
    await db.rawQuery('''
    delete from SalesOrderHeader 
     ''');
    await db.rawQuery('''
    delete from SalesOrderPay
     ''');
    await db.rawQuery('''
    delete from SalesOrderLine 
     ''');
  }

  static Future deleteSalesQuot(Database db) async {
    //log('deleted doc entry no:' + docEntry.toString());
    await db.rawQuery('''
    delete from SalesQuotationHeader
     ''');

    await db.rawQuery('''
    delete from SalesQuotationLine
     ''');

    // //log("Branch *: "+result3.toList().toString());
    // List<Map<String, Object?>> sh2 = await db.rawQuery('''
    // select *from SalesHeader
    //  ''');
    //log("SH2" + sh2.toString());
  }

  static Future deleteHeaderSettle(Database db, String docEntry) async {
    // List<Map<String, Object?>> sh = await db.rawQuery('''
    // select *from SalesHeader
    //  ''');
    // //log('deleted doc entry no:' + docEntry.toString());
    await db.rawQuery('''
    delete from SalesHeader where docentry = $docEntry
     ''');
  }

  //stockreq

  // stock request operation
  static Future<int?> getreqDocNO(
      Database db, String colName, tableName) async {
    //log("result ");
    // select max ((documentno) +1 )from StockReqHDT select documentno from StockReqHDT
    List<Map<String, Object?>> result = await db.rawQuery('''
    select IFNULL(MAX($colName)+1,1) as docno   from $tableName
     ''');
    //log("result:: " + result.toString());
    int? count = Sqflite.firstIntValue(result);
    //log("count:: " + count.toString());

    return count;
  }

  static Future<int> insertStkReq(
      Database db, List<StockReqHDTDB> values) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("StockReqHDT", es);
    });
    await batch.commit();

    List<Map<String, Object?>> result = await db.rawQuery('''
     SELECT docentry FROM StockReqHDT  ORDER BY docentry DESC limit 1
     ''');
    // List<Map<String, Object?>> result2 = await db.rawQuery('''
    // select * from StockReqHDT
    //  ''');
    int? count = Sqflite.firstIntValue(result);
    return count ?? 0;
  }

  static Future insertStkReqLin(
      Database db, List<StockReqLineTDB> values, int docEntry) async {
    var data = values.map((e) => e.toMap(docEntry)).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("StockReqLineT", es);
    });
    await batch.commit();
    // List<Map<String, Object?>> result = await db.rawQuery('''
    // select * from StockReqLineT
    //  ''');
//log("result:: " + result.toList().toString());
  }

  static Future<List<Map<String, Object?>>> getStockHDReqHold(
      Database db) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    select * from StockReqHDT where docstatus = "1"
     ''');
    // log("StockReqHDT hold:: " + result.toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getLastdaySoldData(
      Database db) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    SELECT * FROM SalesLine WHERE JULIANDAY( date('now')) - JULIANDAY(substr(createdateTime,1,10)) =1
     ''');
    //log("SalesLine WHERE JULIANDAY:: " + result.toList().toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getShelfReqData(Database db) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
select T1.ItemCode,t1.itemname_short, t1.displayQty, sum(T2.quantity) as qty ,t1.displayQty- sum(T2.quantity) shortageQty
from ItemMaster T1 
INNER JOIN StockSnap T2 on T1.itemcode = T2.itemcode 
GROUP by T1.ItemCode,t1.itemname_short, t1.displayQty 
HAVING  T1.displayQty >= sum(T2.quantity)  ''');
    //log("SalesLine WHERE JULIANDAY:: " + result.toList().toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getStockLReqHold(
      Database db, int docID) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    select * from StockReqLineT where docentry = $docID
     ''');
    //    //log("StockReqLineT hold:: "+result.toList().toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getStockHDReq2(
      Database db, int docentry) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    select * from StockReqHDT 
     ''');
//log("StockReqHDT :: " + result.toList().toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getStockHDReq(
      Database db, int docentry) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    select * from StockReqHDT where docentry = "$docentry"
     ''');
//log("StockReqHDT ZZZZZ:: " + result.toList().toString());

    return result;
  }

  static Future deletereqHold(Database db, String docEntry) async {
    await db.rawQuery('''
    delete from StockReqHDT where docentry = '$docEntry'
     ''');

    await db.rawQuery('''
    delete from StockReqLineT where docentry = $docEntry
     ''');
  }

  static Future deleteStockreq(Database db) async {
    await db.rawQuery('''
    delete from StockReqHDT
     ''');

    await db.rawQuery('''
    delete from StockReqLineT
     ''');
  }

  static Future<List<ItemMasterModelDB>> getSearchedStockList(
      Database db, String name) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    select * from ItemMaster where itemcode like '%$name%'or itemname like '%$name%'
     ''');
    // log('resultresult::${result.length}');
    return List.generate(result.length, (i) {
      // log("utinesperbox:::${result[i]['U_TINS_PER_BOX'].toString().isNotEmpty}");
      return ItemMasterModelDB(
          isselected: result[i]['IsSelected'] == null
              ? 0
              : int.parse(result[i]['IsSelected'].toString()),
          managedBy: result[i]['ManageBy'].toString(),
          autoId: int.parse(result[i]['AutoId'].toString()),
          // quantity: int.parse(result[i]['maximumQty'].toString()),
          maximumQty: result[i]['maximumQty'].toString(),
          minimumQty: result[i]['minimumQty'].toString(),
          weight: double.parse(result[i]['weight'].toString()),
          liter: double.parse(result[i]['liter'].toString()),
          displayQty: result[i]['displayQty'].toString(),
          searchString: result[i]['searchString'].toString(),
          brand: result[i]['brand'].toString(),
          category: result[i]['category'].toString(),
          createdUserID: result[i]['createdUserID'].toString(),
          createdateTime: result[i]['createdateTime'].toString(),
          hsnsac: result[i]['hsnsac'].toString(),
          isActive: result[i]['isActive'].toString(),
          isfreeby: result[i]['isfreeby'].toString(),
          isinventory: result[i]['isinventory'].toString(),
          issellpricebyscrbat: result[i]['is_sellpricebyscrbat'].toString(),
          // isserialBatch: result[i]['is_serialBatch'].toString(),
          itemcode: result[i]['itemcode'].toString(),
          itemnamelong: result[i]['itemnamelong'].toString(),
          itemnameshort: result[i]['itemnameshort'].toString(),
          lastupdateIp: result[i]['lastupdateIp'].toString(),
          maxdiscount: double.parse(result[i]['maxdiscount'].toString()),
          skucode: result[i]['skucode'].toString(),
          subcategory: result[i]['subcategory'].toString(),
          taxrate: result[i]['taxrate'].toString(),
          updatedDatetime: result[i]['UpdatedDatetime'].toString(),
          updateduserid: result[i]['updateduserid'].toString(),
          mrpprice: result[i]['mrpprice'].toString(),
          uPackSize: result[i]['U_Pack_Size'].toString(),
          uTINSPERBOX: result[i]['U_TINS_PER_BOX'].toString().isEmpty ||
                  result[i]['U_TINS_PER_BOX'] == null
              ? 0
              : int.parse(result[i]['U_TINS_PER_BOX'].toString()),
          uSpecificGravity: result[i]['U_Specific_Gravity'].toString(),
          uPackSizeuom: result[i]['U_Pack_Size_uom'].toString(),
          sellprice: result[i]['sellprice'].toString());
    });
  }

  static Future<List<ItemMasterModelDB>> itemmastercheckitemcode(
      Database db, String itemCode) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    select * from ItemMaster where itemcode ='$itemCode'
     ''');
    return List.generate(result.length, (i) {
      // log("utinesperbox:::${result[i]['U_TINS_PER_BOX'].toString().isNotEmpty}");
      return ItemMasterModelDB(
          isselected: result[i]['IsSelected'] == null
              ? 0
              : int.parse(result[i]['IsSelected'].toString()),
          managedBy: result[i]['ManageBy'].toString(),
          autoId: int.parse(result[i]['AutoId'].toString()),
          // quantity: int.parse(result[i]['maximumQty'].toString()),
          maximumQty: result[i]['maximumQty'].toString(),
          minimumQty: result[i]['minimumQty'].toString(),
          weight: double.parse(result[i]['weight'].toString()),
          liter: double.parse(result[i]['liter'].toString()),
          displayQty: result[i]['displayQty'].toString(),
          searchString: result[i]['searchString'].toString(),
          brand: result[i]['brand'].toString(),
          category: result[i]['category'].toString(),
          createdUserID: result[i]['createdUserID'].toString(),
          createdateTime: result[i]['createdateTime'].toString(),
          hsnsac: result[i]['hsnsac'].toString(),
          isActive: result[i]['isActive'].toString(),
          isfreeby: result[i]['isfreeby'].toString(),
          isinventory: result[i]['isinventory'].toString(),
          issellpricebyscrbat: result[i]['is_sellpricebyscrbat'].toString(),
          // isserialBatch: result[i]['is_serialBatch'].toString(),
          itemcode: result[i]['itemcode'].toString(),
          itemnamelong: result[i]['itemnamelong'].toString(),
          itemnameshort: result[i]['itemnameshort'].toString(),
          lastupdateIp: result[i]['lastupdateIp'].toString(),
          maxdiscount: double.parse(result[i]['maxdiscount'].toString()),
          skucode: result[i]['skucode'].toString(),
          subcategory: result[i]['subcategory'].toString(),
          taxrate: result[i]['taxrate'].toString(),
          updatedDatetime: result[i]['UpdatedDatetime'].toString(),
          updateduserid: result[i]['updateduserid'].toString(),
          mrpprice: result[i]['mrpprice'].toString(),
          uPackSize: result[i]['U_Pack_Size'].toString(),
          uTINSPERBOX: result[i]['U_TINS_PER_BOX'].toString().isEmpty ||
                  result[i]['U_TINS_PER_BOX'] == null
              ? 0
              : int.parse(result[i]['U_TINS_PER_BOX'].toString()),
          uSpecificGravity: result[i]['U_Specific_Gravity'].toString(),
          uPackSizeuom: result[i]['U_Pack_Size_uom'].toString(),
          sellprice: result[i]['sellprice'].toString());
    });
//log('ItemMaster result::${result.toList()}');
    // return result;
  }

  // insert brand

  static Future insertBranch(Database db, List<BranchTModelDB> values) async {
    await db.rawQuery('''
    delete from Branch 
     ''');
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("Branch", es);
    });
    await batch.commit();

    // List<Map<String, Object?>> result3 = await db.rawQuery('''
    // select * from BranchMaster
    //  ''');
    // //log("Branch *: "+result3.toList().toString());
  }

  static Future<List<Map<String, Object?>>> getBranch(Database db) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
         select * from BranchMaster
     ''');
    // log("Branch all:: ${result.toList()}");

    return result;
  }

  static Future<List<Map<String, Object?>>> getBrnachbyCode(
      Database db, String whscode) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
         select * from BranchMaster where WhsCode = "$whscode"
     ''');
    // log("BranchMaster all:: " + result.toList().toString());
    return result;
  }
  // SalesReturn

  static Future<List<Map<String, Object?>>> getSsaleHeader(
      Database db, String customername) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  SalesHeader where customername=$customername''');

    //log("Salesheader cusotmer :" + result.toString());
    return result;
  }

  //where docentry=  $docentry
// and documentno = $docnum

// insert sales return

  static Future<List<Map<String, Object?>>> getSalesheadCkout(
      Database db, String? docnocustomercode) async {
    // log("docnodocnodocno$docnocustomercode");
//  A.documentno , A.customercode,customername,customeraccbal,customeremail,customerpoint, A.customername,A.doctype, B.rcamount,B.createdateTime FROM SalesHeader A
    //log("SalesHeader checkout::" + docno.toString());//
    List<Map<String, Object?>> result = await db.rawQuery('''
SELECT soh.docentry,soh.documentno,soh.createdateTime,soh.baltopay,
        soh.city,soh.state,soh.pinno,soh.gst,soh.country,soh.billaddressid,soh.customerphono,soh.customeremail,
 soh.customername,soh.taxno,soh.customerpoint,soh.customercode,soh.customeraccbal,soh.doctotal  FROM SalesHeader soh
        Inner Join SalesPay B On soh.docentry = B.docentry
WHERE soh.customercode= "${docnocustomercode.toString().trim()}"
   
    ''');

    // select * from SalesHeader where docstatus = '3' and
    // documentno= '${docno.toString().trim()}'

    //log("SalesHeader checkout:: " + result.toList().toString());
    // List<Map<String, Object?>> result2 = await db.rawQuery('''
    // select * from SalesHeader where docstatus = '3'
    // ''');
    // log("SalesHeader result:: " + result.toList().toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getSalesretheaderCkout(
      Database db, String? docnocustomercode) async {
    // log("docnodocnodocno$docnocustomercode");
//  A.documentno , A.customercode,customername,customeraccbal,customeremail,customerpoint, A.customername,A.doctype, B.rcamount,B.createdateTime FROM SalesHeader A
    //log("SalesHeader checkout::" + docno.toString());//
    List<Map<String, Object?>> result = await db.rawQuery('''
SELECT soh.docentry,soh.documentno,soh.createdateTime,soh.baltopay,
        soh.city,soh.state,soh.pinno,soh.gst,soh.country,soh.billaddressid,soh.customerphono,soh.customeremail,
 soh.customername,soh.taxno,soh.customerpoint,soh.customercode,soh.customeraccbal,soh.doctotal  FROM SalesReturnHeader soh
WHERE soh.customercode= "${docnocustomercode.toString().trim()}"
   
    ''');
    // log("SalesHeader result:: " + result.toList().toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> salestosalesret(
      Database db, String? docno) async {
    //log("SalesHeader checkout::" + docno.toString());
    List<Map<String, Object?>> result = await db.rawQuery('''
    select * from SalesHeader where docstatus = '3' and sapDocNo IS NOT NULL and 
    sapDocNo= '$docno'
    ''');
//log("SalesReturnHeaderXXXXXXXx $result");

    return result;
  }

  static Future<List<Map<String, Object?>>> salestoprint(Database db) async {
    //log("SalesHeader checkout::" + docno.toString());
    List<Map<String, Object?>> result = await db.rawQuery('''
    select * from SalesHeader where docstatus = '3' and sapDocNo IS NOT NULL 
 
    ''');
    // print("SalesReturnHeaderXXXXXXXx $result");

    return result;
  }
  // static Future<List<Map<String, Object?>>> salesRettosalesret(Database db, String? docno) async {
  //   // log("SalesReturnHeader checkout::" + docno.toString());
  //   List<Map<String, Object?>> result = await db.rawQuery('''
  //   select * from SalesReturnHeader where docstatus = '3' and
  //   documentno= '${docno.toString().trim()}'
  //   ''');
  //   // log("SalesReturnHeaderXXXXXXXXXXx $result");

  //   return result;
  // }
//log("SalesHeader checkout:: " + result.toList().toString());
  // List<Map<String, Object?>> result2 = await db.rawQuery('''
  // select * from SalesHeader where docstatus = '3'
  // ''');
  // //log("SalesHeader checkout:: " + result2.toList().toString());

  static Future<List<Map<String, Object?>>> getWeightLiterStockSnap(
      Database db, String? itemname, String? serialbatch) async {
    // //log("weight ::" + weight.toString()+"::liter::"+liter.toString());
    List<Map<String, Object?>> result = await db.rawQuery('''
    select liter,weight from StockSnap where itemcode = '$itemname' and serialbatch='$serialbatch'
    ''');
    log("StockSnap weight liter :: select * from StockSnap where itemname = '$itemname' and serialbatch='$serialbatch' " +
        result.toList().toString());

    // //log("StockSnap weight liter :: " + result.toList().toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getSalespaycreditCkout(
      Database db, int? docentry) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    select * from SalesPay where docentry="$docentry" 
    ''');
    //log("docentrydocentry:" + docentry.toString());
    //log("Salespay checkout length:: " + result.length.toString());
    //log("Salespay checkout:: " + result.toList().toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> saleslinegetbalqty(
      Database db, String docentry) async {
    final List<Map<String, Object?>> result2 = await db.rawQuery(
        '''SELECT T1.docentry, T1.balqty,T1.lineID,T1.itemcode,T1.itemname,T1.serialbatch,T1.quantity,
        T1.price,T1.linetotal,T1.taxrate,T1.discperc,T1.discperunit,T1.basic,T1.taxtotal,T1.discamt,T1.netlinetotal,
        T1.branch,T1.createdUser,T1.createdateTime,T1.UpdatedDatetime,T1.createdUserID,T1.updateduserid,T1.lastupdateIp,
         T1.quantity - IFNull(sum(T2.quantity),0) balqty
		 FROM  SalesLine T1
                    Left Join ( Select T2.basedocentry, T2.baselineID,T2.quantity from SalesReturnLine T2 
                    inner join SalesReturnHeader T3 on T2.docentry=t3.docentry
					Where t3.docstatus=3 and t3.qStatus='C') T2 on T1.docentry = T2.basedocentry And T1.lineID = T2.baselineID
                      Where  T1.docentry=$docentry 
                    Group by T1.docentry, T1.balqty,T1.lineID,T1.itemcode,T1.itemname,T1.serialbatch,T1.quantity,T1.price,
                    T1.linetotal,T1.taxrate,T1.discperc,T1.discperunit,T1.basic,T1.taxtotal,T1.discamt,T1.netlinetotal,
                    T1.branch,T1.createdUser,T1.createdateTime,T1.UpdatedDatetime,T1.createdUserID,T1.updateduserid,
                    T1.lastupdateIp  Having T1.quantity - IFNull(sum(T2.quantity),0) > 0'''); //where docentry="16"
//log("SalesLine result2 result2:" + result2.toString());

    return result2;
  }

  static Future<List<Map<String, Object?>>> getSalesRetbalamtDB(
      Database db, String bsdocentry, String bslineid) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT T1.quantity - IFNull(sum(T2.quantity),0) balqty
		 FROM  SalesLine T1
                    Left Join ( Select T2.basedocentry, T2.baselineID,T2.quantity from SalesReturnLine T2 
                    inner join SalesReturnHeader T3 on T2.docentry=t3.docentry
					Where t3.docstatus=3 )T2 on T1.docentry = T2.basedocentry And T1.lineID = T2.baselineID
                      Where  T1.docentry="$bsdocentry" And T1.lineid = "$bslineid"
                    Group by T1.quantity Having T1.quantity - IFNull(sum(T2.quantity),0) > 0''');
//log("SalesReturn balamt XX::" + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> salesRetHeadtorefund(
    Database db,
    String docnum,
  ) async {
    // log("donumdonum:$docnum");
    final List<Map<String, Object?>> result2 = await db.rawQuery(
        '''SELECT T1.docentry,T1.documentno,T1.customername,T1.customercode,T1.customerphono,
        T1.customeremail,T1.customeraccbal,T1.customerpoint,T1.taxno,T1.billaddressid,
        T1.transactiondate,T1.city,T1.state,T1.pinno,T1.country,T1.shipaddresid,T1.baltopay,
        T1.docbasic,T1.doctotal,T1.doctype,T1.docstatus,T1.sodocno,
        T1.branch,T1.createdateTime,T1.UpdatedDatetime,
       T1.updateduserid,T1.lastupdateIp,T2.transdocentry,T2.transdocnum FROM  SalesReturnHeader T1
      Left Join RefundHeader T2 on T1.docentry = T2.transdocentry And T1.documentno = T2.transdocnum 
       Where T1.documentno="$docnum" and  not exists(select T2.transdocnum From RefundHeader T2 where T2.transdocnum=T1.documentno) 
        
'''); //where docentry="16"
    // log("SalesRetruntoRefund result2:" + result2.toString());

    return result2;
  }

//   static Future<List<Map<String, Object?>>> salesQuoCancellQuery(Database db, String docnum) async {
//     print("");
//     final List<Map<String, Object?>> result2 = await db.rawQuery('''SELECT T1.docentry,T1.documentno,
//     T1.customername,T1.customercode,T1.customerphono,
//      T1.doctype,T1.docstatus,T1.sodocno,
//         T1.branch,T1.createdateTime,T1.UpdatedDatetime, T2.basedocentry,
//        T1.updateduserid,T1.lastupdateIp FROM  SalesQuotationHeader T1
//       Inner Join SalesOrderHeader T2 on T1.docentry = T2.basedocentry
//       where T1.documentno="$docnum"
// ''');
//     print("Saeles quo cancellQuery:" + result2.toString());

//     return result2;
//   }

  static Future<List<Map<String, Object?>>> salesQuoCancellQuery(
      Database db, String docentry) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
          SELECT T1.docentry,T1.basedocentry FROM  SalesOrderHeader T1
      left Join  SalesQuotationHeader T2 on T1.basedocentry = T2.docentry 
       Where T1.basedocentry="$docentry" and T1.docstatus=3 and T1.qStatus='C'
       group by T1.docentry,T1.basedocentry

       '''
//           ''' SELECT soh.docentry,soh.documentno,soh.sapDocentry,
//       s.lineid,s.itemcode,
// s.itemname,s.serialbatch,s.quantity,s.price,s.taxrate,s.discperc,s.maxdiscount
// FROM  SalesQuotationHeader soh Inner Join SalesQuotationLine s on
// s.docentry=soh.docentry
// Inner JOIN SalesOrderLine sl on sl.basedocentry=s.docentry and sl.baselineid=s.lineid
// where soh.documentno ="$docnum"
// group by soh.docentry,soh.documentno,soh.createdateTime,soh.baltopay,
//         soh.city,soh.state,soh.pinno,soh.gst,soh.country,soh.billaddressid,soh.customerphono,soh.customeremail,
//  soh.customername,soh.taxno,soh.customerpoint,soh.customercode,soh.customeraccbal,soh.doctotal
// '''
        );
//log("SalesQuotation cancel query:" + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> salesOrderCancellQuery(
      Database db, String docentry) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT T1.docentry,T1.basedocentry FROM  salesHeader T1
      left Join  SalesOrderHeader T2 on T1.basedocentry = T2.docentry 
       Where T1.basedocentry="$docentry" and T1.docstatus=3 and T1.qStatus='C'
       group by T1.docentry,T1.basedocentry

       '''
//           ''' SELECT soh.docentry,soh.documentno,soh.sapDocentry,
//       s.lineid,s.itemcode,
// s.itemname,s.serialbatch,s.quantity,s.price,s.taxrate,s.discperc,s.maxdiscount
// FROM  SalesOrderHeader soh Inner Join SalesOrderLine s on
// s.docentry=soh.docentry
// Inner JOIN SalesLine sl on sl.basedocentry=s.docentry and sl.baselineid=s.lineid
// where soh.documentno ="$docnum"
// group by soh.docentry,soh.documentno,soh.createdateTime,soh.baltopay,
//         soh.city,soh.state,soh.pinno,soh.gst,soh.country,soh.billaddressid,soh.customerphono,soh.customeremail,
//  soh.customername,soh.taxno,soh.customerpoint,soh.customercode,soh.customeraccbal,soh.doctotal, s.lineid,s.itemcode
// '''
        );
    log("SalesOrder cancel query:$result");
    return result;
  }

  static Future<List<Map<String, Object?>>> salesInvtoRetCancellQuery(
      Database db, String docnum) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT T1.docentry,T1.basedocnum,T1.basedocentry FROM  SalesReturnHeader T1
      left Join salesHeader T2 on T1.basedocentry = T2.docentry 
       Where T1.basedocnum="$docnum" and T1.docstatus=3 and T1.qStatus='C'
       group by T1.docentry,T1.basedocnum,T1.basedocentry

       ''');

//         SELECT soh.docentry,soh.documentno,soh.sapDocentry,
//       s.lineid,s.itemcode,
// s.itemname,s.serialbatch,s.quantity,s.price,s.taxrate,s.discperc,s.maxdiscount
// FROM  SalesHeader soh Inner Join SalesLine s on

// s.docentry=soh.docentry
// Inner JOIN SalesReturnLine sl on sl.basedocentry=s.docentry and sl.baselineid=s.lineid
// where soh.documentno ="$docnum"
// group by soh.docentry,soh.documentno,soh.createdateTime,soh.baltopay,
//         soh.city,soh.state,soh.pinno,soh.gst,soh.country,soh.billaddressid,soh.customerphono,soh.customeremail,
//  soh.customername,soh.taxno,soh.customerpoint,soh.customercode,soh.customeraccbal,soh.doctotal
    log("Resultttttt::::$result");
    return result;
  }

  static Future<List<Map<String, Object?>>> salesInvtoReceiptcancel(
    Database db,
    String docnum,
  ) async {
    // log("donumdonum:$docnum");
    final List<Map<String, Object?>> result2 = await db.rawQuery('''
SELECT T1.docentry,T1.transdocnum,T1.transdocentry FROM  ReceiptHeader T1
      Inner Join salesHeader T2 on T1.transdocentry = T2.docentry 
       Where T1.transdocnum="$docnum" and T1.docstatus=3 and T1.qStatus='C'
       group by T1.docentry,T1.transdocnum,T1.transdocentry

       '''

//         '''SELECT T1.docentry,T1.documentno,T1.customername,T1.customercode,T2.transdocentry,T2.transdocnum FROM  SalesHeader T1
//       Inner Join ReceiptHeader T2 on T1.docentry = T2.transdocentry And T1.documentno = T2.transdocnum
//        Where T1.documentno="$docnum"

// '''
        );
//log("SalestoReceipt result2:" + result2.toString());

    return result2;
  }

  static Future getSalesRetheadCkoutRefund(
      Database db, String customercode) async {
    // log("customercodecustomercodecustomercode:" + customercode.toString());
    List<Map<String, Object?>> result = await db.rawQuery('''
    select * from SalesReturnHeader where docstatus = '3' and customercode='$customercode'
  ''');
    // log("SalesReturnHeader checkout:: " + result.toList().toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> salesRetHeadCardCodetorefund(
      Database db, String customercode, String custname) async {
    // log("customercode:$customercode");
    final List<Map<String, Object?>> result2 = await db.rawQuery(
        '''SELECT T1.docentry,T1.documentno,T1.customername,T1.customercode,T1.customerphono,
        T1.customeremail,T1.customeraccbal,T1.customerpoint,T1.taxno,T1.billaddressid,
        T1.transactiondate,T1.city,T1.state,T1.pinno,T1.country,T1.shipaddresid,T1.baltopay,
        T1.docbasic,T1.doctotal,T1.doctype,T1.docstatus,T1.sodocno,
        T1.branch,T1.createdateTime,T1.UpdatedDatetime,
       T1.updateduserid,T1.lastupdateIp,T2.transdocentry,T2.transdocnum FROM  SalesReturnHeader T1
      Left Join RefundHeader T2 on T1.docentry = T2.transdocentry And T1.documentno = T2.transdocnum 
       Where T1.customercode="$customercode" or T1.customername="$custname" and  not exists(select T2.transdocnum From RefundHeader T2 where T2.transdocnum=T1.documentno) 
        
'''); //where docentry="16"
    // log("SalesRet cardcode result2:" + result2.toString());

    return result2;
  }

  static deleterefund(Database db) async {
    // List<Map<String, Object?>> sh = await db.rawQuery('''
    // select *from RefundHeader
    //  ''');
    await db.rawQuery('''
    delete from RefundHeader 
     ''');
    await db.rawQuery('''
    delete from RefundPay
     ''');
    await db.rawQuery('''
    delete from RefundLine1
     ''');
    // log('deleted doc entry no:' + sh.toString());
  }

  static Future<List<Map<String, Object?>>> adjustcreditamt(
      Database db, int? docentry) async {
    final List<Map<String, Object?>> result2 = await db.rawQuery('''
Select ifnull(amt,0) adjustedamt from SalesReturnPay where rcmode='OnAccount' and docentry in
 (Select DocEntry from SalesReturnHeader Where basedocentry=$docentry)''');
    //log("Adjust Amt::$result2");
    return result2;
  }

  static Future<int?> insertSaleReturnheader(
      Database db, List<SalesReturnTModelDB> values) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("SalesReturnHeader", es);
    });
    await batch.commit();

    // final List<Map<String, Object?>> result1 =
    //     await db.rawQuery('''SELECT * FROM  SalesReturnHeader''');
    //log("SalesReturnHeader Insert:" + result1.toString());

    List<Map<String, Object?>> result = await db.rawQuery('''
     SELECT docentry FROM SalesReturnHeader  ORDER BY docentry DESC limit 1
     ''');
    //log("SalesReturnHeader result:: " + result.toString());
    int? count = Sqflite.firstIntValue(result);
    //log("SalesReturnHeader count:: " + count.toString());
    return count ?? 0;
  }

  static Future<List<SalesReturnTModelDB>> salesretrunupdate(
      Database db, String docentry) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  SalesReturnHeader WHERE docentry="$docentry"''');
//log("SalesReturnHeader Len: " + result.toString());
    return List.generate(result.length, (i) {
      //log(" result updatedDatetime::${result[i]['updatedDatetime'].toString()}");
      return SalesReturnTModelDB(
        docentry: result[i]['docentry'].toString(),
        doctype: result[i]['doctype'].toString(),
        documentno: result[i]['documentno'].toString(),
        amtpaid: result[i]['amtpaid'].toString(),
        country: result[i]['country'].toString(),
        uDeviceId: result[i]['U_DeviceId'].toString(),

        city: result[i]['city'].toString(),
        state: result[i]['state'].toString(),
        gst: result[i]['gst'].toString(),
        pinno: result[i]['pinno'].toString(),
        baltopay: result[i]['baltopay'].toString(),
        billaddressid: result[i]['billaddressid'] != null
            ? result[i]['billaddressid'].toString()
            : null,
        shipaddresid: result[i]['shipaddresid'].toString(),
        billtype: result[i]['billtype'].toString(),
        branch: result[i]['branch'].toString(),
        createdUserID: result[i]['createdUserID'].toString(),
        createdateTime: result[i]['createdateTime'].toString(),
        createdbyuser: result[i]['createdbyuser'].toString(),
        customerphono: result[i]['customerphono'].toString(),
        customeremail: result[i]['customeremail'].toString(),
        customerpoint: result[i]['customerpoint'].toString(),
        customeraccbal: result[i]['customeraccbal'].toString(),
        customercode: result[i]['customercode'].toString(),
        customername: result[i]['customername'].toString(),
        customertype: result[i]['customertype'].toString(),
        docbasic: result[i]['docbasic'].toString(),
        docdiscamt: result[i]['docdiscamt'].toString(),
        docdiscuntpercen: result[i]['docdiscuntpercen'].toString(),
        terminal: result[i]['terminal'].toString(),
        basedocentry: null,
        //  result[i]['basedocentry'].toString(),
        basedocnum: null,
        //  result[i]['basedocnum'].toString(),
        docstatus: result[i]['docstatus'].toString(),
        doctotal: result[i]['doctotal'].toString(),
        lastupdateIp: result[i]['lastupdateIp'].toString(),
        paystatus: result[i]['paystatus'].toString(),
        premiumid: result[i]['premiumid'].toString(),
        remarks: result[i]['remarks'].toString(),
        salesexec: result[i]['salesexec'].toString(),
        seresid: result[i]['seresid'].toString(),
        seriesnum: result[i]['seriesnum'].toString(),
        sodocno: result[i]['sodocno'] != null
            ? result[i]['sodocno'].toString()
            : null,
        sodocseries: result[i]['sodocseries'] != null
            ? result[i]['sodocseries'].toString()
            : null,
        sodocseriesno: result[i]['sodocseriesno'].toString(),
        sodoctime: result[i]['sodoctime'].toString(),
        sosystime: result[i]['sosystime'].toString(),
        sotransdate: result[i]['sotransdate'].toString(),
        sysdatetime: result[i]['sysdatetime'].toString(),
        taxamount: result[i]['taxamount'].toString(),
        taxno: result[i]['taxno'].toString(),
        transactiondate: result[i]['transactiondate'].toString(),
        transtime: result[i]['transtime'].toString(),
        updatedDatetime: result[i]['UpdatedDatetime'].toString(),
        updateduserid: result[i]['updateduserid'].toString(),
        sapInvoicedocentry: result[i]['sapInvoicedocentry'].toString(),
        sapInvoicedocnum: result[i]['sapInvoicedocnum'].toString(),
        qStatus: 'No',
        sapDocentry: null,
        // result[i]['sapDocentry'] != null ? result[i]['sapDocentry'].toString() : null,
        sapDocNo: null,
        // result[i]['sapDocentry'] != null ? result[i]['sapDocentry'].toString() : null,
        totalltr: double.parse(result[i]['totalltr'].toString()),
        totalweight: double.parse(result[i]['totalweight'].toString()),
      );
    });
  }

  static Future insertSalesReturnPay(
      Database db, List<SalesReturnPayTDB> values, int? docEntry) async {
    var data = values.map((e) => e.toMap(docEntry)).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("SalesReturnPay", es);
    });
    await batch.commit();
    // final List<Map<String, Object?>> result1 =
    //     await db.rawQuery('''SELECT * FROM  SalesReturnPay''');
    //log("SalesReturnPay Insert:" + result1.toString());
  }

  static Future insertSalesReturnLine(
      Database db, List<SalesReturnLineTDB> values, int docEntry) async {
    var data = values.map((e) => e.toMap(docEntry)).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("SalesReturnLine", es);
    });
    await batch.commit();
    // final List<Map<String, Object?>> result1 =
    //     await db.rawQuery('''SELECT * FROM  SalesReturnLine''');
    // //log("SalesReturnLine Insert:" + result1.toString());
  }

// LED-150K-250K-2Yr

  static Future<List<Map<String, Object?>>> getSalesRetCkoutHeadDB(
    Database db,
  ) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  SalesReturnHeader where docstatus = "3"''');
    // log('SalesReturnHeader getdata' + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getsalesretrunalertDB(
      Database db, String basedocnum) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  SalesReturnHeader where basedocnum="$basedocnum" and docstatus="3"''');
    return result;
  }

  static Future<List<Map<String, Object?>>> getSalesRetHeadDB(
      Database db, int? docentry) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  SalesReturnHeader where docentry="$docentry" and docstatus="3"''');
//log('SalesReturnHeader getdata' + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getSalesRetPayDB(
      Database db, int? docentry) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  SalesReturnPay where docentry="$docentry"''');
    //log("SalesRetLine getdata:" + result.toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> grtSalesRetLineDB(
      Database db, int? docentry) async {
//log("docentrydocentrydocentry:" + docentry.toString());

    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  SalesReturnLine where docentry="$docentry"''');
    log("SalesReturnLine getdata:" + result.toString());
    return result;
  }

  static Future<List<SalesReturnLineTDB>> salesRetrunLineUpdate(
      Database db, String docentry) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  SalesReturnLine WHERE docentry="$docentry"''');
//log("SalesReturnLine Len: " + result.toString());
    return List.generate(result.length, (i) {
      //log('result line UpdatedDatetime::${result[i]["UpdatedDatetime"].toString()}');
      return SalesReturnLineTDB(
        docentry: result[i]['docentry'].toString(),
        createdUser: result[i]["createdUser"].toString(),
        baselineID: result[i]["baselineID"].toString(),
        basedocentry: null,
        //  result[i]["basedocentry"].toString(),
        basic: result[i]["basic"].toString(),
        itemname: result[i]["itemname"].toString(),
        branch: result[i]["branch"].toString(),
        terminal: result[i]["terminal"].toString(),
        createdUserID: result[i]["createdUserID"].toString(),
        createdateTime: result[i]["createdateTime"].toString(),
        discamt: result[i]["discamt"].toString(),
        discperc: result[i]["discperc"].toString(),
        discperunit: result[i]["discperunit"].toString(),
        itemcode: result[i]["itemcode"].toString(),
        lastupdateIp: result[i]["lastupdateIp"].toString(),
        lineID: result[i]["lineID"].toString(),
        linetotal: result[i]["linetotal"].toString(),
        netlinetotal: result[i]["netlinetotal"].toString(),
        price: result[i]["price"].toString(),
        quantity: result[i]["quantity"].toString(),
        serialbatch: result[i]["serialbatch"].toString(),
        taxrate: result[i]["taxrate"].toString(),
        taxtotal: result[i]["taxtotal"].toString(),
        updatedDatetime: result[i]["UpdatedDatetime"].toString(),
        updateduserid: result[i]["updateduserid"].toString(),
      );
    });
  }

  static Future<List<Map<String, Object?>>> getSalesRetHeaderDB(
      Database db, String docentry) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  SalesReturnHeader where  basedocentry="$docentry" and docstatus=3''');
//log('SalesReturnHeader getdata' + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getSalesRetbsLineDB(
      Database db, String bsdocentry, String docentry) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  SalesReturnLine where basedocentry="$bsdocentry" and docentry="$docentry" ''');
    //log("docentrydocentrydocentry:" + docentry.toString());
//log("SalesReturnLine getdata XX:" + result.toString());
    return result;
  }

  static Future updateSalesQuoclosedocsts(
      Database db, String sapdocentry) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery(''' UPDATE SalesQuotationHeader SET docstatus ="4"
 WHERE sapDocentry ="$sapdocentry" ''');
    // final List<Map<String, Object?>> result2 = await db.rawQuery(
    //     '''SELECT * FROM  SalesQuotationHeader WHERE  sapDocentry ="$sapdocentry"''');

//log("Update SalesQuotationHeader Docstatus Details" + result2.toString());
    return result;
  }

  static Future updateSalesOrderclosedocsts(
      Database db, String sapdocentry) async {
    // final List<Map<String, Object?>> result =
    await db.rawQuery(''' UPDATE SalesOrderHeader SET docstatus ="4"
 WHERE sapDocentry ="$sapdocentry" ''');
    // final List<Map<String, Object?>> result2 =
    await db.rawQuery(
        '''SELECT * FROM  SalesOrderHeader WHERE sapDocentry ="$sapdocentry"''');
  }

  static Future updateSOrdercApprovalsts(Database db, String docentry) async {
    // final List<Map<String, Object?>> result =
    await db.rawQuery(''' UPDATE SalesOrderHeader SET docstatus ="5"
 WHERE docentry ="$docentry" ''');
    // final List<Map<String, Object?>> result2 = await db.rawQuery(
    //     '''SELECT * FROM  SalesOrderHeader WHERE docentry ="$docentry"''');
  }

  static Future updateSOrdercErrorApprovalsts(
      Database db, String docentry) async {
    // final List<Map<String, Object?>> result =
    await db.rawQuery(''' UPDATE SalesOrderHeader SET docstatus ="6"
 WHERE docentry ="$docentry" ''');
    // final List<Map<String, Object?>> result2 = await db.rawQuery(
    //     '''SELECT * FROM  SalesOrderHeader WHERE docentry ="$docentry"''');
  }

  static Future getSoApprovalsts(
    Database db,
    String deviceidd,
  ) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''SELECT * FROM  SalesOrderHeader  
 WHERE  U_DeviceId= "$deviceidd" and  docstatus ="5" ''');

    // log(" SalesOrderApprovl Docstatus Details" + result.toString());
    return result;
  }

  static Future getReturnApprovalsts(
    Database db,
    String deviceidd,
  ) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''SELECT * FROM  SalesReturnHeader  
 WHERE  U_DeviceId= "$deviceidd" and  docstatus ="4" ''');

    log(" SalesReturnHeader Docstatus Details" + result.toString());
    return result;
  }

  static Future getExpApprovalsts(
    Database db,
    String deviceidd,
  ) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''SELECT * FROM  Expense 
 WHERE U_DeviceId= "$deviceidd" and  docstatus ="4" ''');
    log(" Expense Docstatus Details" + result.toString());
    return result;
  }

  static Future updateSaleInvoiceclosedocsts(
      Database db, String sapdocentry) async {
    // final List<Map<String, Object?>> result =
    await db.rawQuery(''' UPDATE SalesHeader SET docstatus ="4"
 WHERE sapDocentry ="$sapdocentry" ''');
    final List<Map<String, Object?>> result2 = await db.rawQuery(
        '''SELECT * FROM  SalesHeader WHERE sapDocentry ="$sapdocentry"''');

    log("Update SalesHeader Docstatus Details::$result2");
  }

  static Future updateSaleRetclosedocsts(Database db, String docentry) async {
    // final List<Map<String, Object?>> result =
    await db.rawQuery(''' UPDATE SalesReturnHeader SET docstatus ="4"
 WHERE  docentry ="$docentry" ''');
    final List<Map<String, Object?>> result2 = await db.rawQuery(
        '''SELECT * FROM  SalesReturnHeader WHERE  docentry ="$docentry"''');

    log("Update SalesReturnHeader Docstatus Details${{result2.length}}");
  }

  static Future updateStkReqclosedocsts(Database db, String sapdocentry) async {
    // final List<Map<String, Object?>> result =
    await db.rawQuery(''' UPDATE StockReqHDT SET docstatus ="4"
 WHERE sapDocentry ="$sapdocentry" ''');
    final List<Map<String, Object?>> result2 = await db.rawQuery(
        '''SELECT * FROM  StockReqHDT WHERE  sapDocentry ="$sapdocentry"''');

    log("Update StockReqHDT Docstatus Details${result2.length}");
  }

  static Future updateExpclosedocsts(Database db, String sapdocentry) async {
    // final List<Map<String, Object?>> result =
    await db.rawQuery(''' UPDATE Expense SET docstatus ="4"
 WHERE sapDocentry ="$sapdocentry" ''');
    final List<Map<String, Object?>> result2 = await db.rawQuery(
        '''SELECT * FROM  Expense WHERE  sapDocentry ="$sapdocentry"''');

    log("Update Expense Docstatus Details$result2");
  }

  static Future updatesalesreturnsts(
      Database db, SalesReturnTModelDB salesreqtable, String custcode) async {
    // final List<Map<String, Object?>> result =
    await db.rawQuery(
        ''' UPDATE SalesReturnHeader SET docstatus ="${salesreqtable.docstatus}"
      
 WHERE customercode ="$custcode" ''');
    // final List<Map<String, Object?>> result2 =
    //     await db.rawQuery('''SELECT * FROM  SalesReturnHeader''');

    //log("Update SalesReturnHeader Details" + result2.toString());
  }

  static Future<List<Map<String, Object?>>> getSalesRetheadholdDB(
    Database db,
  ) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  SalesReturnHeader where docstatus = "1"''');
    log("SalesReturnHeader hold::" + result.toString());
    return result;
  }

  static Future deleteSalesRetHold(Database db, String docEntry) async {
    // List<Map<String, Object?>> sh =
    await db.rawQuery('''
    select *from SalesReturnHeader 
     ''');
    //log('deleted doc entry no:' + docEntry.toString());
    await db.rawQuery('''
    delete from SalesReturnHeader where docentry = $docEntry
     ''');
    await db.rawQuery('''
    delete from SalesReturnPay where docentry = $docEntry
     ''');
    await db.rawQuery('''
    delete from SalesReturnLine where docentry = $docEntry
     ''');

    // //log("Branch *: "+result3.toList().toString());
    // List<Map<String, Object?>> sh2 = await db.rawQuery('''
    // select *from SalesReturnHeader
    //  ''');
    //log("SH2" + sh2.toString());
  }

  static Future viewsalesret(Database db) async {
    await db.rawQuery('''Delete  FROM  SalesHeader''');
//log("SalesOrderHeader getdata:" + result1.toString());

    await db.rawQuery('''Delete FROM  SalesLine ''');
//log("SalesOrderLine getdata:" + result2.toString());

    await db.rawQuery('''Delete FROM  SalesPay ''');
//log("SalesOrdervPay getdata:" + result3.toString());
  }

  static Future dltsalesret(Database db) async {
    await db.rawQuery('''delete FROM  SalesReturnHeader''');
    // log("SalesReturnHeader getdata:" + result1.toString());

    await db.rawQuery('''delete  FROM  SalesReturnLine ''');
    // log("SalesRetLine getdata:" + result2.toString());

    // final List<Map<String, Object?>> result3 =
    await db.rawQuery('''delete FROM  SalesReturnPay ''');
    // log("SalesReturnPay getdata:" + result3.toString());
  }

//payment receipt
  static Future<List<Map<String, Object?>>> salespaymentreceipt(
      Database db, String documentno) async {
    final List<Map<String, Object?>> result2 = await db.rawQuery(
        '''SELECT SH.docentry,SH.documentno,SH.sapDocentry,SH.customername,SH.doctype,SH.docstatus,SH.sodocno, SH.createdateTime, SP.docentry,
         SP.rcmode,SP.rcamount,  SB.balance -ifnull(sy.TransAmount,0) - (netlinetotal-rcamount) Balance
from SalesPay SP inner join SalesHeader SH on SH.docentry = SP.docentry
Inner join (Select docentry,sum(BalAmt) balance, sum(netlinetotal) netlinetotal from (
SELECT T1.docentry,T1.quantity,netlinetotal,
(T1.quantity - IFNull(sum(T2.quantity),0)) * T1.netlinetotal / T1.quantity BalAmt
FROM  SalesLine T1
Left Join ( Select T2.basedocentry, T2.baselineID,T2.quantity from SalesReturnLine T2 
inner join SalesReturnHeader T3 on T2.docentry=t3.docentry
Where t3.docstatus=3 )T2 on T1.docentry = T2.basedocentry And T1.lineID = T2.baselineID
Group by T1.docentry, T1.quantity,T1.netlinetotal  Having T1.quantity - IFNull(sum(T2.quantity),0) > 0) T
group by docentry) SB on SB.docentry = SH.docentry
left join (select transDocEnty,transtype,sum(TransAmount) TransAmount from  ReceiptLine1 RL
Inner Join ReceiptHeader R on R.docentry = RL.docentry Where R.docstatus=3 GROUP By transDocEnty,transtype) sy on sy.transDocEnty = SP.docentry and sy.transtype=sh.doctype
where SH.documentno="$documentno" and SH.sapDocNo IS NOT NULL and SH.docstatus='3' and SP.rcmode ='Credit' and SP.rcamount -ifnull(sy.TransAmount,0)>0 '''); //w
//log("SalesCredit:" + result2.toString());
    return result2;
  }

  static Future<List<Map<String, Object?>>> getSalesheadCkoutpayreceipt(
      Database db, String customercode, String custname) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    select * from SalesHeader where docstatus = '3' and customercode='$customercode' or customername='$custname'
  ''');
//log("SalesHeader checkout:: " + result.toList().toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> salespaymentareceiptcardcode(
    Database db,
    String custcode,
  ) async {
    //log("Cusotmer Code:" + custcode);

    final List<Map<String, Object?>> result2 = await db.rawQuery(
        '''SELECT SH.docentry,SH.documentno,SH.sapDocentry,SH.customername,SH.customercode,SH.doctype,SH.docstatus,SH.sodocno, SH.createdateTime,
  SP.docentry, SP.rcmode,SP.rcamount, 
  SB.balance -ifnull(sy.TransAmount,0) - (netlinetotal-rcamount) Balance
from SalesPay SP
inner join SalesHeader SH on SH.docentry = SP.docentry
Inner join (Select docentry,sum(BalAmt) balance, sum(netlinetotal) netlinetotal from (
SELECT T1.docentry,T1.quantity,netlinetotal,
(T1.quantity - IFNull(sum(T2.quantity),0)) * T1.netlinetotal / T1.quantity BalAmt
FROM  SalesLine T1
Left Join ( Select T2.basedocentry, T2.baselineID,T2.quantity from SalesReturnLine T2 
inner join SalesReturnHeader T3 on T2.docentry=t3.docentry
Where t3.docstatus=3 )T2 on T1.docentry = T2.basedocentry And T1.lineID = T2.baselineID
Group by T1.docentry, T1.quantity,T1.netlinetotal  Having T1.quantity - IFNull(sum(T2.quantity),0) > 0) T
group by docentry) SB on SB.docentry = SH.docentry
left join (select transDocEnty,transtype,sum(TransAmount) TransAmount from  ReceiptLine1 RL
Inner Join ReceiptHeader R on R.docentry = RL.docentry Where R.docstatus=3 GROUP By transDocEnty,transtype) sy on sy.transDocEnty = SP.docentry and sy.transtype=sh.doctype
where SH.customercode = '$custcode'and SH.sapDocNo IS NOT NULL and SH.docstatus='3' and SP.rcmode ='Credit' and SP.rcamount -ifnull(sy.TransAmount,0)>0
''');

//log("Payment Credit List:" + result2.toString());
    return result2;
  }

//Insert payment Receipt
  static Future insertRecieptHeader(
      Database db, List<ReceiptHeaderTDB> values) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("ReceiptHeader", es);
    });
    await batch.commit();
    // final List<Map<String, Object?>> result1 =
    //     await db.rawQuery('''SELECT * FROM  ReceiptHeader''');
//log("ReceiptHeader Insert:" + result1.toString());

    List<Map<String, Object?>> result = await db.rawQuery('''
     SELECT docentry FROM ReceiptHeader  ORDER BY docentry DESC limit 1
     ''');
    //log("ReceiptHeader result:: " + result.toString());
    int? count = Sqflite.firstIntValue(result);
    //log("ReceiptHeader count:: " + count.toString());
    return count ?? 0;
  }

  static Future insertRecieptLine(
      Database db, List<ReceiptLineTDB> values, int docentry) async {
    var data = values.map((e) => e.toMap(docentry)).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("ReceiptLine1", es);
    });
    await batch.commit();
    // final List<Map<String, Object?>> result1 =
    //     await db.rawQuery('''SELECT * FROM  ReceiptLine1''');
    //log("ReceiptLine1 Insert:" + result1.toString());
  }

  static Future insertReciepLine2(
      Database db, List<ReceiptLine2TDB> values, int docentry) async {
    var data = values.map((e) => e.toMap(docentry)).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("ReceiptLine2", es);
    });
    await batch.commit();
    // final List<Map<String, Object?>> result1 =
    //     await db.rawQuery('''SELECT * FROM  ReceiptLine2''');
    //log("ReceiptLine2 Insert:" + result1.toString());
  }

//refund
  static Future insertRefundHeader(
      Database db, List<RefundHeaderTDB> values) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("RefundHeader", es);
    });
    await batch.commit();
    // final List<Map<String, Object?>> result1 =
    //     await db.rawQuery('''SELECT * FROM  RefundHeader''');

    List<Map<String, Object?>> result = await db.rawQuery('''
     SELECT docentry FROM RefundHeader  ORDER BY docentry DESC limit 1
     ''');
    // log("ReceiptHeader result:: " + result.toString());
    int? count = Sqflite.firstIntValue(result);
    // log("RefundHeader count:: " + count.toString());
    return count ?? 0;
  }

  static Future insertRefundLine(
      Database db, List<RefundLineTDB> values, int docentry) async {
    var data = values.map((e) => e.toMap(docentry)).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("RefundLine1", es);
    });
    await batch.commit();
    // final List<Map<String, Object?>> result1 =
    //     await db.rawQuery('''SELECT * FROM  RefundLine1''');
    // log("RefundLine1 Insert:" + result1.toString());
  }

  static Future insertRefundPay(
      Database db, List<RefundPayTDB> values, int docentry) async {
    var data = values.map((e) => e.toMap(docentry)).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("RefundPay", es);
    });
    await batch.commit();
    // final List<Map<String, Object?>> result1 =
    //     await db.rawQuery('''SELECT * FROM  RefundPay''');
    // log("insertRefundPay Insert:" + result1.toString());
  }

  static Future<List<Map<String, Object?>>> getRefundHeaderDB(
      Database db, int docentry) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  RefundHeader where docentry=$docentry''');
    //log("SELECT * FROM  RefundHeader where docentry=$docentry'" +
    // result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getRefundLine1(
      Database db, int docentry) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  RefundLine1 where docentry=$docentry''');
    //log("SELECT * FROM  ReceiptLine1 where docentry=$docentry'" +
    // result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getRefundPay(
      Database db, int docentry) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  RefundPay where docentry=$docentry''');
    //log("SELECT * FROM  ReceiptLine2 where docentry=$docentry'" +
    // result.toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getRefunOnHold(Database db) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  RefundHeader where docstatus = "1"''');
    // log("SELECT * FROM  RefundHeader on hold" + result.toString());

    return result;
  }

  static Future deletRefundHold(Database db, String docEntry) async {
    // List<Map<String, Object?>> sh = await db.rawQuery('''
    // select *from RefundHeader
    //  ''');
    //log('deleted doc entry no:' + docEntry.toString());
    await db.rawQuery('''
    delete from RefundHeader where docentry = $docEntry
     ''');
    await db.rawQuery('''
    delete from RefundLine1 where docentry = $docEntry
     ''');
    await db.rawQuery('''
    delete from RefundPay where docentry = $docEntry
     ''');

    // //log("Branch *: "+result3.toList().toString());
    // List<Map<String, Object?>> sh2 = await db.rawQuery('''
    // select *from ReceiptHeader
    //  ''');
    //log("SH2" + sh2.toString());
  }
  // get Payment Receipt

  static Future<List<Map<String, Object?>>> getReceiptHeaderDB(
      Database db, int docentry) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  ReceiptHeader where docentry=$docentry''');
    return result;
  }

  static Future<List<Map<String, Object?>>> getReceiptLine1(
      Database db, int docentry) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  ReceiptLine1 where docentry=$docentry''');
//log("SELECT * FROM  ReceiptLine1 where docentry=$docentry'" +
    // result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getReceiptLine2(
      Database db, int docentry) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  ReceiptLine2 where docentry=$docentry''');
//log("SELECT * FROM  ReceiptLine2 where docentry=$docentry'" +
    // result.toString());

    return result;
  }

  static Future deletereceipt(Database db) async {
    // final List<Map<String, Object?>> result1 =
    await db.rawQuery('''delete FROM  ReceiptLine1''');
    // log("ReceiptLine1 delete:" + result1.toString());
    // final List<Map<String, Object?>> result13 =
    await db.rawQuery('''delete FROM  ReceiptLine2''');
    //log("ReceiptLine2 delete:" + result13.toString());
    // final List<Map<String, Object?>> result12 =
    await db.rawQuery('''delete FROM  ReceiptHeader''');
    //log("ReceiptHeader delete:" + result12.toString());
  }

  getreceiptcustomerdetails(
    Database db,
  ) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''select t0.*,t2.* from ReceiptHeader t0 
INNER JOIN CustomerMaster t1 on t0.customer=t1.customername
INNER JOIN CustomerMasterAddress t2 on t2.custcode=t1.customercode''');
    //log('getreceiptcustomerdetails getdata' + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getholdpayreceiptHeadDB(
    Database db,
  ) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  ReceiptHeader where docstatus = "1"''');
    log('ReceiptHeader getdata' + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getpayreceiptHeadDB(
    Database db,
  ) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''SELECT * FROM  ReceiptHeader''');
    //log('ReceiptHeader getdata alert' + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getpayreceipLine11DB(
      Database db, int? docentry) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  ReceiptLine1 where docentry="$docentry"''');
    log('ReceiptLine1 getdata' + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getpayreceipLine22DB(
      Database db, int? docentry) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  ReceiptLine2 where docentry="$docentry"''');
    // log("ReceiptLine2 getdata:" + result.toString());
    return result;
  }

  static Future deletepayreceipttHold(Database db, String docEntry) async {
    // List<Map<String, Object?>> sh = await db.rawQuery('''
    // select *from ReceiptHeader
    //  ''');
    //log('deleted doc entry no:' + docEntry.toString());
    await db.rawQuery('''
    delete from ReceiptHeader where docentry = $docEntry
     ''');
    await db.rawQuery('''
    delete from ReceiptLine1 where docentry = $docEntry
     ''');
    await db.rawQuery('''
    delete from ReceiptLine2 where docentry = $docEntry
     ''');

    // //log("Branch *: "+result3.toList().toString());
    // List<Map<String, Object?>> sh2 = await db.rawQuery('''
    // select *from ReceiptHeader
    //  ''');
    //log("SH2" + sh2.toString());
  }

  //Deposit

  static Future<int?> insertDepositHeader(
      Database db, List<DepositHeaderTDB> values) async {
    //log("Deposit header");
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("tableDepositHeader", es);
    });
    await batch.commit();

//     final List<Map<String, Object?>> result1 =
//         await db.rawQuery('''SELECT * FROM  tableDepositHeader''');
//log("tableDepositHeader:" + result1.toString());

    List<Map<String, Object?>> result = await db.rawQuery('''
     SELECT docentry FROM tableDepositHeader  ORDER BY docentry DESC limit 1
     ''');
    //log("tableDepositHeader result:: " + result.toString());
    int? count = Sqflite.firstIntValue(result);
    //log("tableDepositHeader count:: " + count.toString());
    return count ?? 0;
  }

  static Future<int?> getDocNOforsettled(
      Database db, String colName, tableName) async {
    //log("result ");
    List<Map<String, Object?>> result = await db.rawQuery('''
    select IFNULL(MAX($colName)+1,1) as docno   from $tableName
     ''');
    //log("result:: " + result.toString());
    int? count = Sqflite.firstIntValue(result);
    //log("count:: " + count.toString());

    return count;
  }

  static Future<List<Map<String, Object?>>> getsaveinsert(
      Database db, String paymodetype, String createdatetime) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  DepositLine where paymodetype="$paymodetype" and createdatetime="$createdatetime" ''');
//log("FFFFFFFF" + result.toString());
    return result;
  }

  static Future insertDepositLine(
      Database db, List<DepositLineTDB> values, int docentry) async {
    var data = values.map((e) => e.toMap(docentry)).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("DepositLine", es);
    });
    await batch.commit();
    // final List<Map<String, Object?>> result1 =
    //     await db.rawQuery('''SELECT * FROM  DepositLine''');
//log("tableDepositLine:" + result1.toString());
  }

  static deleteDeposit(Database db) async {
    // final List<Map<String, Object?>> result1 =
    await db.rawQuery('''DELETE FROM DepositLine''');
    //log("tableDepositLine:" + result1.toString());
    // final List<Map<String, Object?>> result2 =
    await db.rawQuery('''DELETE FROM tableDepositHeader''');
    //log("tableDepositHeader:" + result2.toString());
  }

  static Future<List<Map<String, Object?>>> getSalesHeaderDBforsellement(
    Database db,
  ) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''SELECT * FROM  SalesHeader''');
    return result;
  }

  static Future<List<Map<String, Object?>>> getSalesPaysettleDB(
      Database db, int? docentry, String rcmode) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  SalesPay where docentry=$docentry and rcmode="$rcmode"''');
    //log("$result");

    return result;
  }

  static Future<List<Map<String, Object?>>> loggetSalesPay(
    Database db,
  ) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''SELECT * FROM  SalesPay''');
    //log("$result");

    return result;
  }

  //expences
  static Future<int?> insertExpense(
      Database db, List<ExpenseDBModel> values) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("Expense", es);
    });
    await batch.commit();
    List<Map<String, Object?>> result = await db.rawQuery('''
     SELECT docentry FROM Expense ORDER BY docentry DESC limit 1
     ''');
    //log("Expense result:: " + result.toString());
    int? count = Sqflite.firstIntValue(result);
    //log("Expense count:: " + count.toString());
    return count ?? 0;
  }

  static Future<List<Map<String, Object?>>> getExpenseDB(
    Database db,
  ) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''SELECT * FROM  Expense where docstatus = "1"''');
    log('getExpenseDB::$result');
    return result;
  }

  static Future UpdateApprovalExpenseDB(Database db, String docentry) async {
    await db.rawQuery('''UPDATE Expense SET docstatus ="4"
 WHERE docentry ="$docentry" ''');
  }

  static Future UpdateApprovalReturnDB(Database db, String docentry) async {
    await db.rawQuery('''UPDATE SalesReturnHeader SET docstatus ="4"
 WHERE docentry ="$docentry" ''');
  }

  static Future<List<Map<String, Object?>>> getExpensData(
      Database db, int docentry) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  Expense where docentry=$docentry''');

    return result;
  }

  static Future<void> updtExcepSapDetSalHead(
      Database db, int docentry, String status, String tablename) async {
    // List<Map<String, Object?>> result =
    await db.rawQuery('''
   update $tablename set 
   qStatus = '$status'
where docentry = $docentry 
     ''');
    //   List<Map<String, Object?>> result2 = await db.rawQuery('''
    //  select * from $tablename where docentry = $docentry
    //    ''');
    // log("updated qStatus details *: " + result2.toList().toString());

    //   List<Map<String, Object?>> result3 = await db.rawQuery('''
    //  select * from $tablename where docentry = $docentry
    //    ''');
//log("select * from $tablename : " + result3.toList().toString());
  }

  static Future deleteExpenseHold(Database db, String docEntry) async {
    // List<Map<String, Object?>> sh = await db.rawQuery('''
    // select * from Expense
    //  ''');
    //log('deleted doc entry no:' + docEntry.toString());
    //log("SH1" + sh.toString());
    await db.rawQuery('''
    delete from Expense where docentry = $docEntry
     ''');

    List<Map<String, Object?>> sh2 = await db.rawQuery('''
    select *from Expense 

     ''');
//log("SH2" + sh2.toString());
  }

  static Future deleteExpense(
    Database db,
  ) async {
    await db.rawQuery('''
    delete from Expense
     ''');
  }

  static Future<void> updtQstatus(
    Database db,
    int docentry,
    String tablename,
  ) async {
    await db.rawQuery('''
   update $tablename set
   qStatus = 'Y'
where docentry = $docentry 
     ''');

    // List<Map<String, Object?>> result2 =
    await db.rawQuery('''
   select * from $tablename where docentry = $docentry 
     ''');
    // log("updated qStatus details***: " + result2.toList().toString());
  }

  static Future<void> updtSapDetSalHead(Database db, int sapdocEntry,
      int sapDocno, int docentry, String tablename) async {
//log("tablenametablename:: " + tablename);
    // List<Map<String, Object?>> result =
    await db.rawQuery('''
   update $tablename set sapDocentry = $sapdocEntry , sapDocNo = $sapDocno , qStatus = 'C'
where docentry = $docentry 
     ''');

    List<Map<String, Object?>> result2 = await db.rawQuery('''
     select * from $tablename where docentry = $docentry
       ''');

    log("updated qStatus details in $tablename zzz*: ${result2.toList()}");
  }

  static Future<void> updtSapStkReqHead(Database db, int sapdocEntry,
      int sapDocno, int docentry, String tablename) async {
//log("tablenametablename:: " + tablename);
    // List<Map<String, Object?>> result =
    await db.rawQuery('''
   update $tablename set sapDocentry = $sapdocEntry , sapDocNo = $sapDocno , qStatus = 'O'
where docentry = $docentry 
     ''');

    List<Map<String, Object?>> result2 = await db.rawQuery('''
     select * from $tablename where docentry = $docentry
       ''');

    log("updated stkreq details in $tablename zzz*: ${result2.toList()}");
  }

  static Future<void> updateRcSapDetSalpay(Database db, int docentry,
      int rcDocno, int rcdocentry, String tablename) async {
//log("tablenametablename:: " + tablename);
    // List<Map<String, Object?>> result =
    await db.rawQuery('''
   update $tablename set rcdocentry = $rcdocentry , rcnumber = $rcDocno
where docentry = $docentry 
     ''');

    // List<Map<String, Object?>> result2 =
    await db.rawQuery('''
     select * from $tablename where docentry = $docentry
       ''');

//log("updated RC details in $tablename *: " +
    // result2.toList().toString());
  }

  static Future<void> updtAprvltoDocSalHead(
      Database db, int sapdocEntry, int sapDocno, int docentry) async {
    // List<Map<String, Object?>> result =
    await db.rawQuery('''
   update SalesOrderHeader set sapDocentry = $sapdocEntry , sapDocNo = $sapDocno , qStatus = 'C', docstatus='3'
where docentry = $docentry 
     ''');

    List<Map<String, Object?>> result2 = await db.rawQuery('''
     select * from SalesOrderHeader where docentry = $docentry
       ''');

    log("updated AftAprvltoDoc in SalesOrderHeader zzz*: " +
        result2.toList().toString());
  }

  static Future<void> updtAprvltoDocSalRetHead(
      Database db, int sapdocEntry, int sapDocno, int docentry) async {
    // List<Map<String, Object?>> result =
    await db.rawQuery('''
   update SalesReturnHeader set sapDocentry = $sapdocEntry , sapDocNo = $sapDocno , qStatus = 'C', docstatus='3'
where docentry = $docentry 
     ''');

    List<Map<String, Object?>> result2 = await db.rawQuery('''
     select * from SalesReturnHeader
       ''');

    log("updated AftAprvltoDoc in SalesReturnHeader zzz*: " +
        result2.toList().toString());
  }

  static Future<void> updtAprvltoDocExpenseHead(
      Database db, int sapdocEntry, int sapDocno, int docentry) async {
    // List<Map<String, Object?>> result =
    await db.rawQuery('''
   update Expense set sapDocentry = $sapdocEntry , sapDocNo = $sapDocno , qStatus = 'C', docstatus='2'
where docentry = $docentry 
     ''');

    List<Map<String, Object?>> result2 = await db.rawQuery('''
     select * from Expense where docentry = $docentry
       ''');

    log("updated AftAprvltoDoc in Expense zzz*: " +
        result2.toList().toString());
  }

//
  static Future<void> updtCustcodeSalHead(
      Database db, String sapcustcode, int docentry, String tablename) async {
//log("tablenametablename:: " + tablename);
    // List<Map<String, Object?>> result =
    await db.rawQuery('''
   update $tablename set customercode = $sapcustcode,
where docentry = $docentry 
     ''');

    //   List<Map<String, Object?>> result2 = await db.rawQuery('''
    //  select * from $tablename where docentry = $docentry
    //    ''');

    // log("updated qStatus details in $tablename*: " +
    // result2.toList().toString());

    List<Map<String, Object?>> result3 = await db.rawQuery('''
   select * from $tablename 
     ''');
    // log("qStatus $tablename*: " + result3.toList().toString());
  }

//sotck outwared
  static Future updateQTYBatch(Database db, int docEntry, int lineno,
      String itemcode, String serialbatch) async {
    await db.rawQuery('''
   update StockOutBatchDB set quantity =(SELECT  sum(quantity) FROM  StockOutBatchDB where baseDocentry = $docEntry 
and lineno = $lineno and itemcode = '$itemcode' and serialBatch = '$serialbatch') -1
where baseDocentry = $docEntry and lineno = $lineno and itemcode = '$itemcode' and serialBatch = '$serialbatch'
     ''');
    //   final List<Map<String, Object?>> result = await db.rawQuery('''
    //  select * from StockOutBatchDB
    //    '''); // //log("Branch *: "+result3.toList().toString());
    //  log("batch table"+result.toString());
  }

  static Future<List<Map<String, Object?>>> getStOutCheckScanData(
      //ch
      Database db,
      int? docentry,
      int? lineno,
      String? itemcode,
      String? serialbatch) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        ''' select * from StockOutBatchDB where baseDocentry = $docentry and lineno = $lineno and
         itemcode = '$itemcode' and serialBatch='$serialbatch' ''');
    // log("get updatated Batch Data:" + result.toString());
    //log("query" +
    // '''select * from StockOutBatchDB where docentry = $docentry and lineno = $lineno and itemcode = '$itemcode' ''');
    return result;
    //old
    //  '''select * from StockOutBatchDB where docentry = $docentry and lineno = $lineno and
    //     itemcode = '$itemcode' '''
  }

  static Future<List<Map<String, Object?>>> getStOutCheckScanData2(
    //ch
    Database db,
    int? docentry,
    int? lineno,
    String? itemcode,
  ) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery(''' select * from StockOutBatchDB where 
    baseDocentry = $docentry and  itemcode = '$itemcode'  ''');

//log("test:2 StockOutBatchDB:" + result.toString());

    //log("query" +
    // '''select * from StockOutBatchDB where docentry = $docentry and lineno = $lineno and itemcode = '$itemcode' ''');
    return result;
    //old
    //  '''select * from StockOutBatchDB where docentry = $docentry and lineno = $lineno and
    //     itemcode = '$itemcode' '''
  }

  static Future deletAlreadyHoldDataLine(
      Database db, int basedocentry, int docentry, String itemcode) async {
    // await db.rawQuery('''
    // DELETE  FROM StockOutLineDB where baseDocentry = $docentry ''');
    // await db.rawQuery('''
    // DELETE  FROM StockOutBatchDB where docentry = $docentry ''');
    await db.rawQuery('''
    DELETE  FROM StockOutLineDB where baseDocentry = $basedocentry and itemcode="$itemcode" and docentry=$docentry ''');
  }

  static Future deletAlreadyHoldData(Database db, int docentry) async {
    // await db.rawQuery('''
    // DELETE  FROM StockOutLineDB where baseDocentry = $docentry ''');
    // await db.rawQuery('''
    // DELETE  FROM StockOutBatchDB where docentry = $docentry ''');
    await db.rawQuery('''
    DELETE  FROM StockOutHeaderDataDB where baseDocentry = $docentry and docstatus = "1"''');
  }

  static Future deletAllOutHoldData(Database db) async {
    await db.rawQuery('''
    DELETE  FROM StockOutLineDB ''');
    await db.rawQuery('''
    DELETE  FROM StockOutBatchDB ''');
    await db.rawQuery('''
    DELETE  FROM StockOutHeaderDataDB ''');
  }

  static Future<int?> updateStOutBach(Database db, int? docentry, int? lineno,
      String? itemcode, String? serialbatch) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    update StockOutBatchDB set quantity =(SELECT  ifNull(sum(quantity),0) as quantity FROM  StockOutBatchDB where baseDocentry = $docentry 
and lineno = $lineno and itemcode = '$itemcode' and serialBatch='$serialbatch') +1
where baseDocentry = $docentry and lineno = $lineno and itemcode = '$itemcode' and serialBatch='$serialbatch'
     ''');
    //   List<Map<String, Object?>> result2 = await db.rawQuery('''
    //  select * From StockOutBatchDB
    //    ''');
    //   log("Batch Table docentry = $docentry and lineno = $lineno and itemcode = '$itemcode' and serialBatch='$serialbatch'::" +
    //       result2.toList().toString());
    //   log("Update::" + result.toList().toString());
    int? count = Sqflite.firstIntValue(result);
    return count;
  }

  static Future<int?> updateStInBach(Database db, int? docentry, int? lineno,
      String? itemcode, String? serialbatch) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    update StockInBatchDB set quantity =(SELECT  ifNull(sum(quantity),0) as quantity FROM  StockInBatchDB where baseDocentry = $docentry 
and lineno = $lineno and itemcode = '$itemcode' and serialBatch='$serialbatch') +1
where baseDocentry = $docentry and lineno = $lineno and itemcode = '$itemcode' and serialBatch='$serialbatch'
     ''');
    List<Map<String, Object?>> result2 = await db.rawQuery('''
     select * From StockInBatchDB 
       ''');
//log("efgh::" + result2.toList().toString());
    //log("abcd::" + result.toList().toString());
    int? count = Sqflite.firstIntValue(result);
    return count;
  }

  static Future insertStOutBatch(
      Database db, List<StockOutBatchDataDB> values) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("StockOutBatchDB", es);
    });
    await batch.commit();
    // List<Map<String, Object?>> result = await db.rawQuery('''
    // select * from StockOutBatchDB
    //  ''');
//log("StockOutBatchDB :: " + result.toList().toString());
  }

  static Future updateSTOUTHeader(Database db, String updatedDatetime,
      String transdate, int docentry) async {
    await db.rawQuery('''
   update StockOutHeaderDataDB set UpdatedDatetime ='$updatedDatetime' , transdate = '$transdate'
where baseDocentry = $docentry
     ''');
  }

  static Future updateSTINHeader(Database db, String updatedDatetime,
      String transdate, int docentry) async {
    await db.rawQuery('''
   update StockInHeaderDB
 set UpdatedDatetime ='$updatedDatetime' , transdate = '$transdate'
where baseDocentry = $docentry
     ''');
  }

  static Future<List<Map<String, Object?>>> stockHeaderCheck(
      Database db, int docentry) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
     select * from StockOutHeaderDataDB where baseDocentry = $docentry
     ''');
//log("StockOutHeaderDataDByy result:: " + result.toString());
    int? count = Sqflite.firstIntValue(result);
    //log("StockReqHDT count:: " + count.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getStockOutBatch(
      Database db, int docentry, String baseDocentry) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    select * from StockOutBatchDB where docentry = $docentry and baseDocentry=$baseDocentry
     ''');
    //  //log("StockReqHDT hold:: "+result.toList().toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> stockOutLineCheck(Database db,
      int docentry, int baseDocentry, int baseDocline, String itemcode) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
     select * from StockOutLineDB where docentry = $docentry and baseDocentry = $baseDocentry and baseDocline = $baseDocentry and itemcode = '$itemcode'
     ''');
    //log("StockReqHDT result:: " + result.toString());
    int? count = Sqflite.firstIntValue(result);
    //log("StockReqHDT count:: " + count.toString());
    return result;
  }

  static Future insertStOutLine(
      Database db, List<StockOutLineDataDB> values) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("StockOutLineDB", es);
    });
    await batch.commit();
    // List<Map<String, Object?>> result = await db.rawQuery('''
    // select * from StockOutLineDB
    //  ''');
    //log("result:: " + result.toList().toString());
  }

  static Future<int?> insertStockOutheader(
      Database db, List<StockOutHeaderDataDB> values) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("StockOutHeaderDataDB", es);
    });
    await batch.commit();

    // final List<Map<String, Object?>> result1 =
    //     await db.rawQuery('''SELECT * FROM  StockOutHeaderDataDB''');
    // log("StockOutHeaderDataDB:" + result1.toString());

    List<Map<String, Object?>> result = await db.rawQuery('''
     SELECT docentry FROM StockOutHeaderDataDB  ORDER BY docentry DESC limit 1
     ''');
    // //log("StockOutHeader result:: " + result.toString());
    int? count = Sqflite.firstIntValue(result);
    // //log("StockOutHeader count:: " + count.toString());
    return count ?? 0;
  }

  static Future<List<Map<String, Object?>>> getStockSnapFullData(
      Database db) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    select * from StockSnap 
     ''');
    return result;
  }

  static Future<List<StockSnapTModelDB>> getSearchedStockListBatch(
      Database db, String name) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    select * from StockSnap where serialbatch = "$name"
     ''');

    //log("select * from StockSnap where serialbatch = '$name'::::$result");

    return List.generate(result.length, (i) {
      return StockSnapTModelDB(
        terminal: result[i]['terminal'].toString(),
        branchcode: result[i]['branchcode'].toString(),
        createdUserID: int.parse(result[i]['createdUserID'].toString()),
        taxCode: result[i]['taxCode'].toString(),
        createdateTime: result[i]['createdateTime'].toString(),
        itemcode: result[i]['itemcode'].toString(),
        lastupdateIp: result[i]['lastupdateIp'].toString(),
        maxdiscount: result[i]['maxdiscount'].toString(),
        mrpprice: result[i]['mrpprice'].toString(),
        purchasedate: result[i]['purchasedate'].toString(),
        liter: double.parse(result[i]['liter'].toString()),
        weight: double.parse(result[i]['weight'].toString()),
        quantity: result[i]['quantity'].toString(),
        sellprice: result[i]['sellprice'].toString(),
        serialbatch: result[i]['serialbatch'].toString(),
        snapdatetime: result[i]['snapdatetime'].toString(),
        specialprice: result[i]['specialprice'].toString(),
        updatedDatetime: result[i]['UpdatedDatetime'].toString(),
        updateduserid: int.parse(result[i]['updateduserid'].toString()),
        itemname: result[i]['itemname'].toString(),
        taxrate: result[i]['taxrate'].toString(),
        branch: result[i]['branch'].toString(),
        uPackSize: result[i]['UPackSize'].toString(),
        uTINSPERBOX: int.parse(result[i]['UTINSPERBOX'].toString()),
        uSpecificGravity: result[i]['USpecificGravity'].toString(),
        uPackSizeuom: result[i]['UPackSizeUom'].toString(),
      );
    });
  }

  static Future<List<Map<String, Object?>>> getStInCheckScanData2(
    //ch
    Database db,
    int? docentry,
    int? lineno,
    String? itemcode,
  ) async {
    final List<Map<String, Object?>> result2 =
        await db.rawQuery(''' select * from StockInLineDB ''');
    final List<Map<String, Object?>> result3 =
        await db.rawQuery(''' select * from StockInBatchDB ''');

    final List<Map<String, Object?>> result = await db.rawQuery(
        ''' select * from StockInBatchDB where baseDocentry = $docentry and  itemcode = '$itemcode'  ''');
//log("test1  docentry = $docentry and  itemcode = '$itemcode':" +
    // result.toString());
//log("StockInLineDB:2==" + result2.toString());
//log("StockInBatchDB:2==" + result3.toString());

    //log("query" +
    // '''select * from StockOutBatchDB where docentry = $docentry and lineno = $lineno and itemcode = '$itemcode' ''');
    return result;
    //old
    //  '''select * from StockOutBatchDB where docentry = $docentry and lineno = $lineno and
    //     itemcode = '$itemcode' '''
  }

  static Future<List<Map<String, Object?>>> updateStInBachInHoldButton(
      Database db,
      int? docentry,
      int? lineno,
      String? itemcode,
      int qty,
      String serialBatch) async {
    List<Map<String, Object?>> result = await db.rawQuery(
        ''' update StockInBatchDB set quantity= $qty , serialBatch= '$serialBatch' where baseDocentry = $docentry and lineno = $lineno and itemcode = '$itemcode' and serialBatch= '$serialBatch'     ''');
    // List<Map<String, Object?>> result2 =
    //     await db.rawQuery(''' select * from StockOutBatchDB ''');
    // log("Batch Table Updated:::" + result2.toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getBatchInOutwardStIn2(
      Database db, int? docentry, int? baseDocentry, String? itemcode) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''  Select * from StockOutBatchDB  '''); //where docentry="16"

    final List<Map<String, Object?>> result2 = await db.rawQuery(
        '''  Select * from StockOutBatchDB where docentry =$docentry and itemcode="$itemcode" and baseDocentry=$baseDocentry '''); //where docentry="16"
    // final List<Map<String, Object?>> result1 = await db
    //     .rawQuery('''  Select * from StockOutBatchDB '''); //where docentry="16"
//log("Batch111::::" + result.toString());

//log("Batch222::::" + result2.toString());
    // int? count = Sqflite.firstIntValue(result2);
    return result2;
  }

  static Future<List<Map<String, Object?>>> getbatchList(
    Database db,
  ) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''  Select * from StockOutBatchDB  '''); //where docentry="16"
    log('StockOutBatchDB::${result}');
    return result;
  }

  static Future<List<Map<String, Object?>>> getBatchInOutwardStIn(
      Database db, int? docentry, String? itemcode) async {
    final List<Map<String, Object?>> result2 = await db.rawQuery(
        '''  Select * from StockInBatchDB where docentry =$docentry and itemcode="$itemcode" '''); //where docentry="16"
    // final List<Map<String, Object?>> result1 = await db
    //     .rawQuery('''  Select * from StockOutBatchDB '''); //where docentry="16"
    log("Batch::::===-----------------" + result2.toString());
    int? count = Sqflite.firstIntValue(result2);
    return result2;
  }

  static Future updateBatchTableDocentry(
    Database db,
    int docEntry,
    int baseDocEntry,
    String itemcode,
  ) async {
    await db.rawQuery('''
   update StockOutBatchDB set docentry = $docEntry  where baseDocentry = $baseDocEntry 
and  itemcode = '$itemcode' 
     ''');
    //   final List<Map<String, Object?>> result = await db.rawQuery('''
    //  select * from StockOutBatchDB
    //    '''); // //log("Branch *: "+result3.toList().toString());
    //  log("batch table"+result.toString());
  }

  static Future<List<Map<String, Object?>>> getStockReq(Database db) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
Select DISTINCT RH.DocEntry,RH.reqfromWhs,RH.docstatus,RH.documentno,RH.reqtransdate,RH.branch,RH.reqtoWhs,RH.sapDocentry  
From StockReqHDT RH
inner Join StockReqLineT RL on RL.DocEntry = RH.DocEntry
left Join StockOutLineDB ODL on ODL.baseDocentry = RL.docentry And ODL.baseDocLine = RL.LineNo 
left Join StockOutHeaderDataDB ODH on ODH.docentry = ODL.docentry and ODH.docstatus != 1 and ODH.docstatus != 3 
where  julianday('now') - julianday(RH.reqtransdate) <3  and RH.sapDocNo IS NOT NULL
group by RH.DocEntry,RH.reqfromWhs,RH.docstatus,RH.documentno,RH.reqtransdate,RH.branch,RH.reqtoWhs,RL.LineNo
Having RL.quantity- IFNull(sum(ODL.scannedQty),0) > 0
 ''');
//and RH.reqtoWhs="${AppConstant.branch}"
//log("getStockReq::::" + result.toList().toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getTrasferQty(
      Database db, int? docentry) async {
    final List<Map<String, Object?>> result2 = await db.rawQuery(
        '''SELECT T1.docentry,T1.lineNo,T1.itemcode,T1.serialBatch,T1.quantity,T1.price,T1.taxRate,T1.createdateTime,T1.UpdatedDatetime,
T1.createdUserID,T1.updateduserid,T1.lastupdateIp,T1.branch, T1.quantity - IFNull(sum(ODB.quantity),0)balqty, 0
 scanndQty 
 FROM StockReqLineT T1
                    Left Join StockOutLineDB T2 on T1.docentry = T2.baseDocentry And T1.lineNo = T2.baseDocline 
					Left Join StockOutBatchDB ODB on ODB.baseDocentry = T1.docentry And ODB.lineno = T1.lineNo and t2.docentry = odb.docentry
					Where  T1.docentry= $docentry  
                    Group by T1.docentry,T1.lineNo,T1.itemcode,T1.serialBatch,T1.quantity,T1.price,T1.taxRate,T1.createdateTime,
					T1.UpdatedDatetime,T1.createdUserID,T1.updateduserid,T1.lastupdateIp,T1.branch
                    Having T1.quantity- IFNull(sum(ODB.quantity),0) > 0'''); //where docentry="16"
    // log("SalesLine result2 docentry:" + docentry.toString());

    int? count = Sqflite.firstIntValue(result2);
    return result2;
  }

  static Future deleteHoldStOut(Database db, String docEntry) async {
    List<Map<String, Object?>> sh = await db.rawQuery('''
    select * from StockOutHeaderDataDB 
     ''');
    // //log('deleted doc entry no:' + docEntry.toString());

    await db.rawQuery('''
    delete from StockOutHeaderDataDB where baseDocentry = '$docEntry'
     ''');
    await db.rawQuery('''
    delete from StockOutLineDB where baseDocentry = '$docEntry'
     ''');
    await db.rawQuery('''
    delete from StockOutBatchDB where docentry = '$docEntry'
     ''');
    // //log("Branch *: "+result3.toList().toString());
    // List<Map<String, Object?>> sh2 = await db.rawQuery('''
    // select *from StockOutHeaderDataDB
    //  ''');
    //log("SH2" + sh2.toString());
  }

  static Future deleteStOutTable(Database db) async {
    await db.rawQuery('''
    delete from StockOutHeaderDataDB 
     ''');
    await db.rawQuery('''
    delete from StockOutLineDB
     ''');
    await db.rawQuery('''
    delete from StockOutBatchDB
     ''');
  }

  static Future<List<Map<String, Object?>>> getHoldStOutHeadDB(
      Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  StockOutHeaderDataDB where docstatus="1"''');
    log('StockOutHeaderDataDB::$result');
    return result;
  }

  static Future<List<Map<String, Object?>>> getOutwardToWhsName(
      Database db, int docentry) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  StockOutHeaderDataDB where docentry=$docentry ''');
    //log("SELECT * FROM  StockOutHeaderDataDB where docstatus=1" +
    // result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getHoldStOutLineDB(
      Database db, int? docentry) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  StockOutLineDB where docentry=$docentry''');

    return result;
  }

  static Future<List<Map<String, Object?>>> holdStOutLineDB2(
      Database db, int? docentry) async {
    // final List<Map<String, Object?>> result2 = await db
    //     .rawQuery('''SELECT * FROM  StockOutLineDB where docentry=$docentry''');
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  StockOutLineDB where docentry=$docentry ''');
    //log("stoutlinedocentry:" + docentry.toString());
    log("stoutline result:" + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> holdStOutBatchDB2(
      Database db, int? basedocentry, int? docentry, String itemcode) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  StockOutBatchDB where baseDocentry=$basedocentry and itemcode="$itemcode" and docentry=$docentry ''');

    final List<Map<String, Object?>> result2 =
        await db.rawQuery('''SELECT * FROM  StockOutBatchDB''');
    log('StockOutBatchDB:${result2}');
    return result;
  }

  static Future<List<Map<String, Object?>>> UpdateStOutBachInHoldButton(
      Database db,
      int? docentry,
      int? lineno,
      String? itemcode,
      int qty,
      String serialBatch) async {
    List<Map<String, Object?>> result = await db.rawQuery(
        ''' update StockOutBatchDB set quantity= $qty , serialBatch= '$serialBatch' where baseDocentry = $docentry and lineno = $lineno and itemcode = '$itemcode' and serialBatch= '$serialBatch'
     ''');
    // List<Map<String, Object?>> result2 =
    //     await db.rawQuery(''' select * from StockOutBatchDB ''');
//log("Batch update StockOutBatchDB set quantity= $qty , serialBatch= '$serialBatch' where baseDocentry = $docentry and lineno = $lineno and itemcode = '$itemcode' and serialBatch= '$serialBatch':::" +
    // result.toString());

    return result;
  }

  static Future deleteSuspendBatchStOut(
      Database db, int docEntry, String itemcode) async {
    await db.rawQuery('''
    delete from StockOutBatchDB where baseDocentry = $docEntry and itemcode="$itemcode" 
     ''');
    //log('deleted doc entry no:' + docEntry.toString());
  }

  static Future deleteSuspendBatchStIn(Database db, int docEntry) async {
    await db.rawQuery('''
    delete from StockInBatchDB where baseDocentry = $docEntry
     ''');
    await db.rawQuery('''
    delete from StockInHeaderDB where baseDocentry = $docEntry
     ''');
    await db.rawQuery('''
    delete from StockInLineDB where baseDocentry = $docEntry
     ''');

    //log('deleted doc entry no:' + docEntry.toString());
  }

  static Future deleteStkInward(Database db) async {
    await db.rawQuery('''
    delete from StockInBatchDB
     ''');
    await db.rawQuery('''
    delete from StockInHeaderDB
     ''');
    await db.rawQuery('''
    delete from StockInLineDB 
     ''');

    //log('deleted doc entry no:' + docEntry.toString());
  }

  static Future<List<Map<String, Object?>>> stOutCheckScanData(
      //ch
      Database db,
      int? basedocentry,
      int? docentry,
      int? lineno,
      String? itemcode) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''select * from StockOutBatchDB where baseDocentry = $basedocentry and lineno = $lineno and 
        itemcode = '$itemcode' and docentry=$docentry  ''');
    // log("gjhgjgj111:" + result.toString());
    //log("query" +
    // ''' select * from StockOutBatchDB where docentry = $docentry and lineno = $lineno and
    // itemcode = '$itemcode'  and (ifnull(docstatus,'-1')) !='0' ''');
    return result;

    //old
    //  '''select * from StockOutBatchDB where docentry = $docentry and lineno = $lineno and
    //     itemcode = '$itemcode' '''
  }

  static Future<List<Map<String, Object?>>> getStockOutHeader(
      Database db, int docentry) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    select * from StockOutHeaderDataDB where docentry = "$docentry" and docstatus=3
     ''');
    //  //log("StockReqHDT hold:: "+result.toList().toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getStockOutHeader2(
      Database db, int docentry) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    select * from StockOutHeaderDataDB where docentry = "$docentry" and docstatus=3
     ''');
//log("StockReqHDT hold:: " + result.toList().toString());

    return result;
  }

  static Future deleteBatch(
    Database db,
    int basedocEntry,
    int docEntry,
    String itemcode,
  ) async {
    await db.rawQuery('''
    DELETE from StockOutBatchDB where itemcode = '$itemcode'  and docentry=$docEntry
     ''');
    // //log("Branch *: "+result3.toList().toString());
  }

  static Future deleteBatch_STIN(Database db, int docEntry, int lineno,
      String itemcode, String serialbatch) async {
    await db.rawQuery('''
    DELETE from StockInBatchDB where baseDocentry = $docEntry 
and lineno = $lineno and itemcode = '$itemcode' and serialBatch = '$serialbatch'
     ''');
    // //log("Branch *: "+result3.toList().toString());
  }

  static Future deleteBatch2(
      Database db, int docEntry, int lineno, String itemcode) async {
    await db.rawQuery('''
    DELETE from StockOutBatchDB where baseDocentry = $docEntry 
and lineno = $lineno and itemcode = '$itemcode' 
     ''');
    // //log("Branch *: "+result3.toList().toString());
  }

  static Future deleteBatch2_STIN(
      Database db, int docEntry, int lineno, String itemcode) async {
    await db.rawQuery('''
    DELETE from StockInBatchDB where baseDocentry = $docEntry 
and lineno = $lineno and itemcode = '$itemcode' 
     ''');
    // //log("Branch *: "+result3.toList().toString());
  }

  static Future<List<Map<String, Object?>>> getBachList(Database db,
      int? docentry, int? lineno, String? itemcode, String? serialBatch) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''select * from StockOutBatchDB where  baseDocentry = $docentry and lineno = $lineno and itemcode = '$itemcode' and serialBatch = '$serialBatch' ''');
    //log("batchList Erukkutha illaya::" + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> holdStOutLineDB(
      Database db, int? docentry, String? baseDocentry) async {
    // log("stoutline baseDocentry:" + baseDocentry.toString());

    // final List<Map<String, Object?>> result2 = await db
    //     .rawQuery('''SELECT * FROM  StockOutLineDB where docentry=$docentry''');
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  StockOutLineDB where baseDocentry=$baseDocentry and docentry=$docentry ''');
    //log("stoutlinedocentry:" + docentry.toString());
//log("stoutline result:" + result.toString());
    //log("stoutline result:" + result2.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> stOutLineDB(
      Database db, int? docentry) async {
    final List<Map<String, Object?>> result2 = await db
        .rawQuery('''SELECT * FROM  StockOutLineDB where docentry=$docentry''');
//log("StockOutLineDB::$result2");
    return result2;
  }

  static Future<List<Map<String, Object?>>> holdStOutBatchDB(
      Database db, int? docentry) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  StockOutBatchDB where docentry=$docentry''');
    //log("stoutBatchdocentry:" + docentry.toString());
    //log("stoutBatch result:" + result.length.toString());
    return result;
  }

  static Future deletereq(Database db) async {
//log("delete req");
    // await db.rawQuery('''
    // // DELETE  FROM StockReqHDT''');
    // await db.rawQuery('''
    // DELETE  FROM StockReqLineT''');
    await db.rawQuery('''
    DELETE  FROM StockOutLineDB''');
    await db.rawQuery('''
    DELETE  FROM StockOutBatchDB''');
    await db.rawQuery('''
    DELETE  FROM StockOutHeaderDataDB''');
    // await db.rawQuery('''
    // DELETE  FROM StockInBatchDB''');
    // await db.rawQuery('''
    // DELETE  FROM StockInLineDB''');
    // await db.rawQuery('''
    // DELETE  FROM StockInHeaderDB''');
  }
  // stock inward

  static Future<List<Map<String, Object?>>> stInCheckScanData(
      //ch
      Database db,
      int? docentry,
      int? lineno,
      String? itemcode,
      String? serialbatch) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''select * from StockInBatchDB where baseDocentry = $docentry and lineno = $lineno and 
        itemcode = '$itemcode' and serialBatch='$serialbatch'  ''');
    // final List<Map<String, Object?>> result2 =
    //     await db.rawQuery('''select * from StockInBatchDB   ''');

    //log("gjhgjgj111:" + result.toString());
    //log("query" +
    // ''' select * from StockInBatchDB where docentry = $docentry and lineno = $lineno and
    // itemcode = '$itemcode'  and (ifnull(docstatus,'-1')) !='0' ''' +
    // result2.toString());
    return result;
    //old
    //  '''select * from StockOutBatchDB where docentry = $docentry and lineno = $lineno and
    //     itemcode = '$itemcode' '''
  }

  static Future<List<Map<String, Object?>>> getTrasferQtyStIn(
      Database db, int? docentry, int basedocEnt) async {
    final List<Map<String, Object?>> result2 =
        await db.rawQuery('''SELECT T1.docentry,T1.baseDocentry,T1.lineno,
    T1.itemcode,T1.serialBatch,T1.quantity,
    T1.branch,  IFNull(T1.scannedQty,0)balqty , IfNull(sum(ODB.quantity),0) as scanndQty  FROM StockOutLineDB T1
                    Left Join StockInLineDB T2 on T1.docentry = T2.baseDocentry And T1.lineno = T2.baseDocline 
					Left Join StockInBatchDB ODB on ODB.baseDocentry = T1.docentry And ODB.lineno = T1.lineno  
                    Where  T1.docentry= $docentry and T1.baseDocentry=$basedocEnt
                    Group by T1.docentry,T1.baseDocentry,T1.lineno,T1.itemcode,T1.serialBatch,T1.quantity,T1.branch
                    Having T1.quantity - IFNull(sum(T2.scannedQty),0) > 0 '''); //where docentry="16"
    // log("SalesLine result2 result222:" + result2.toString());
    // final List<Map<String, Object?>> result3 =
    //     await db.rawQuery('''select * from StockInLineDB '''); //
//log("Out Line::::" + result2.toString());

    int? count = Sqflite.firstIntValue(result2);
    return result2;
  }

  static Future deleteBatchStIn(
      Database db, int docEntry, int lineno, String itemcode) async {
    await db.rawQuery('''
    DELETE from StockInBatchDB where docentry = $docEntry 
and lineno = $lineno and itemcode = '$itemcode'
     ''');
    // //log("Branch *: "+result3.toList().toString());
  }

  static Future updateQTYBatchsStIn(
      Database db, int docEntry, int lineno, String itemcode) async {
    await db.rawQuery('''
   update StockInBatchDB set quantity =(SELECT  sum(quantity) FROM  StockInBatchDB where docentry = $docEntry 
and lineno = $lineno and itemcode = '$itemcode') -1
where docentry = $docEntry and lineno = $lineno and itemcode = '$itemcode'
     ''');
    // //log("Branch *: "+result3.toList().toString());
  }

  static Future<List<Map<String, Object?>>> getBachListStIn(Database db,
      int? docentry, int? lineno, String? itemcode, String? serialBatch) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''select * from StockInBatchDB where  baseDocentry = $docentry and lineno = $lineno and itemcode = '$itemcode' and serialBatch = '$serialBatch' ''');
//log("batchList Erukkutha illaya::" + result.toString());
    return result;
  }

  static Future deletAlreadyHoldDataStIN(Database db, int docentry) async {
    await db.rawQuery('''
    DELETE  FROM StockInHeaderDB where baseDocentry = $docentry and docstatus = "1"''');
  }

  static Future deletAlreadyHoldDataLineSTIN(
      Database db, int docentry, String itemcode) async {
    await db.rawQuery('''
    DELETE  FROM StockInLineDB where baseDocentry = $docentry and itemcode="$itemcode" ''');
  }

  static Future updateBatchTableDocentrySTIN(
    Database db,
    int docEntry,
    int baseDocEntry,
    String itemcode,
  ) async {
    await db.rawQuery('''
   update StockInBatchDB set docentry = $docEntry  where baseDocentry = $baseDocEntry 
and  itemcode = '$itemcode' 
     ''');
    //   final List<Map<String, Object?>> result = await db.rawQuery('''
    //  select * from StockOutBatchDB
    //    '''); // //log("Branch *: "+result3.toList().toString());
    //  log("batch table"+result.toString());
  }

  static Future<List<Map<String, Object?>>> getStInCheckScanData(
      //ch
      Database db,
      int? docentry,
      int? lineno,
      String? itemcode,
      String? serialBatch) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        ''' select * from StockInBatchDB where baseDocentry = $docentry and lineno = $lineno and
         itemcode = '$itemcode' and serialBatch='$serialBatch' ''');
    //log("gjhgjgj222:" + result.toString());
    //log("query" +
    // '''select * from StockInBatchDB where docentry = $docentry and lineno = $lineno and itemcode = '$itemcode' ''');
    return result;
    //old
    //  '''select * from StockOutBatchDB where docentry = $docentry and lineno = $lineno and
    //     itemcode = '$itemcode' '''
  }

  static Future insertStInBatch(
      Database db, List<StockInBatchDataDB> values) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("StockInBatchDB", es);
    });
    await batch.commit();
    List<Map<String, Object?>> result = await db.rawQuery('''
    select * from StockInBatchDB
     ''');
    // log("StockInBatchDB :: " + result.toList().toString());
  }

  static Future<int?> insertStockInheader(
      Database db, List<StockInHeaderDataDB> values) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("StockInHeaderDB", es);
    });
    await batch.commit();

    // final List<Map<String, Object?>> result1 =
    //     await db.rawQuery('''SELECT * FROM  StockInHeaderDB''');
//log("StockOutHeaderDataDB:" + result1.toString());

    List<Map<String, Object?>> result = await db.rawQuery('''
     SELECT docentry FROM StockInHeaderDB  ORDER BY docentry DESC limit 1
     ''');
//log("StockOutHeader result:: " + result.toString());
    int? count = Sqflite.firstIntValue(result);
    // //log("StockOutHeader count:: " + count.toString());
    return count ?? 0;
  }

  static Future insertStInLine(
      Database db, List<StockInLineDataDB> values) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("StockInLineDB", es);
    });
    await batch.commit();
    // List<Map<String, Object?>> result = await db.rawQuery('''
    // select * from StockInLineDB
    //  ''');
    // log("result:: " + result.toList().toString());
  }

  static Future<List<Map<String, Object?>>> getHoldStInHeadDB(
      Database db) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''SELECT * FROM  StockInHeaderDB
 where docstatus="1"''');
    // log("SELECT * FROM  StockInHeaderDB where docstatus=1" + result.toString());
    log('getHoldStInHeadDB::${result}');
    return result;
  }

  static Future<List<Map<String, Object?>>> holdStInLineDB(
      Database db, int? basedocentry, int? docentry) async {
//log("basedocentrybasedocentry:" + basedocentry.toString());

    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  StockInLineDB where baseDocentry=$basedocentry and docentry=$docentry ''');
    // final List<Map<String, Object?>> result2 =
    //     await db.rawQuery('''SELECT * FROM  StockInLineDB''');
    //log("docentrydocentrydocentry:" + docentry.toString());
//log("StockInLineDB result2:" + result2.toString());
//log("stoutline result:" + result.length.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> stInLineDB(
      Database db, int? docentry) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  StockInLineDB where docentry=$docentry ''');
    // final List<Map<String, Object?>> result2 =
    //     await db.rawQuery('''SELECT * FROM  StockInLineDB''');
    //log("docentrydocentrydocentry:" + docentry.toString());
//log("stoutline result2:" + result2.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> holdStInBatchDB(
      Database db, int? basedocentry, String? itemcode) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  StockInBatchDB where itemcode='$itemcode' and baseDocentry=$basedocentry ''');
    //log("docentrydocentrydocentry:" + docentry.toString());
    // log("stoutBatch itemcode='$itemcode' and baseDocentry=$basedocentry result:" + result.length.toString());
    return result;
  }

  static Future deleteHoldStIn(Database db, String docEntry) async {
    // List<Map<String, Object?>> sh = await db.rawQuery('''
    // select * from StockInHeaderDB

    //  ''');
    await db.rawQuery('''
    delete from StockInLineDB where baseDocentry = '$docEntry'
     ''');
    await db.rawQuery('''
    delete from StockInHeaderDB
 where baseDocentry = '$docEntry'
     ''');

    // await db.rawQuery('''
    // delete from StockInBatchDB where docentry = '$docEntry'
    //  ''');
    // List<Map<String, Object?>> sh2 = await db.rawQuery('''
    // select * from StockInHeaderDB

    //  ''');
    //log("SH2" + sh2.toString());
  }

// nnn
  static Future<List<Map<String, Object?>>> getStockOut(Database db) async {
    List<Map<String, Object?>> result = await db.rawQuery(
        '''Select distinct RH.docentry,RH.baseDocentry,RH.documentno,RH.reqfromWhs,RH.docstatus,
    RH.reqdocno,RH.transdate,RH.reqtoWhs,RH.branch, RH.sapStockReqdocentry,RH.sapStockReqdocnum,RH.sapDocentry,
    RH.sapDocNo,
  IfNull(ODB.quantity,0) as quantity From StockOutHeaderDataDB RH
Inner Join StockOutLineDB RL on RL.DocEntry =   RH.docentry
Left Join StockInLineDB ODL on ODL.baseDocentry = RL.docentry And ODL.baseDocLine = RL.Lineno 
Left Join StockInBatchDB ODB on ODB.baseDocentry = RL.docentry And ODB.lineno = RL.Lineno 
Left Join StockInHeaderDB ODH on ODH.baseDocentry = ODL.docentry  and ODH.docstatus = 3
WHERE RH.docstatus=3 and  ODL.docentry is NULL and RH.sapDocNo IS NOT NULL
group by RH.docentry,RH.baseDocentry,RH.documentno,RH.reqfromWhs,RH.docstatus,RH.transdate,
RH.reqtoWhs,RH.reqdocno,RH.branch, 
RH.sapStockReqdocentry,RH.sapStockReqdocnum,RH.sapDocentry,RH.sapDocNo
Having IfNull(Sum(RL.scannedQty),0) - IfNull(Sum(ODL.scannedQty),0) > 0''');
//where T.reqtoWhs = 'CBE1'
//--
    // "SELECT * FROM StockReqHDT WHERE docstatus = '2' OR docstatus='3'  ");
    // where docstatus = '2' and docstatus = '3'
    // List<Map<String, Object?>> result2 =
    //     await db.rawQuery("Select * from StockReqLineTDB");
//log("to InwardHeader:::" + result.toList().toString());
    log('outward:::${result.toList()}');
    return result;
  }

  static Future<List<Map<String, Object?>>> getStockInHeader(
      Database db, int docentry) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    select * from StockInHeaderDB where docentry = "$docentry"
     ''');
//log("StockInHeaderDB :: " + result.toList().toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getStockInBatch(
      Database db, int baseDocentry, int docentry) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    select * from StockInBatchDB where baseDocentry = $baseDocentry and docentry=$docentry ''');
//log("StockInBatchDB :: " + result.toList().toString());

    return result;
  }

  // Deposit

  static Future<List<Map<String, Object?>>> getsaveinsertHeader(
      Database db, String createdatetime) async {
    //log("mycontroller-----:" + createdatetime);
    // final List<Map<String, Object?>> result2 = await db.rawQuery(
    //     '''SELECT * FROM  tableDepositHeader ''');//2023-05-04 //2023-05-04 123423
    //      //log("mycontroller222-----:"+result2.toString());

    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT  * FROM  tableDepositHeader where substr(createdatetime,1,10)="$createdatetime"'''); //2023-05-04 //2023-05-04 123423
//log("FFFFFFFFUUU" + result.toString());
    return result;
  }

// Left join DepositLine SL on SL.basedocentry = S.docentry and sp.lineid
//\= SL.baselineid  and S.doctype = SL.basedoctype
//   and SL.docentry IS NULL
//   static Future<List<Map<String, Object?>>> finalforDeposit(
//       Database db, String rcmode) async {
//     final List<Map<String, Object?>> result = await db.rawQuery(
//         '''select S.documentno,S.docentry,sp.lineid,S.doctype, sp.rcamount ,sp.rcmode,S.customerphono,sp.cardApprno,sp.cardterminal,sp.rcdatetime,sp.createdateTime,sp.couponcode,sp.coupontype,sp.walletid,sp.wallettype,sp.chequedate,sp.chequeno
// from SalesPay sp
// inner join SalesHeader S on S.docentry = sp.docentry

// where rcmode = '$rcmode'
// Union ALL

// select S.docnumber,S.docentry,sp.lineid,S.doctype,sp.rcamount ,sp.rcmode,"",sp.cardApprno,sp.cardterminal,sp.rcdatetime,sp.createdateTime,sp.couponcode,sp.coupontype,sp.walletid,sp.wallettype,sp.chequedate,sp.chequeno
// from ReceiptLine2 sp
// inner join ReceiptHeader S on S.docentry = sp.docentry
// where rcmode = '$rcmode'
// Union ALL
// SELECT sa.documentno,sa.docentry,sa.lineid,sa.doctype,-sa.rcamount,sa.rcmode,"","","","",sa.createdateTime,"","","","","","" FROM Expense sa
// ''');
//     //log("aaaaanbu+=$result");

//     return result;
//   }

  static Future<List<Map<String, Object?>>> finalforDeposit(
      Database db, String rcmode) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''select S.documentno,S.docentry,sp.rcnumber,sp.rcdocentry,sp.lineid,S.doctype, sp.rcamount ,sp.rcmode,S.customerphono,sp.cardApprno,sp.cardterminal,
        sp.rcdatetime,sp.createdateTime,sp.couponcode,sp.coupontype,sp.walletid,sp.wallettype,sp.chequedate,sp.chequeno
from SalesPay sp
inner join SalesHeader S on S.docentry = sp.docentry
Left join DepositLine SL on SL.basedocentry = S.docentry and sp.lineid = SL.baselineid and S.doctype = SL.basedoctype
where rcmode = '$rcmode' and SL.docentry IS NULL
Union ALL

select S.documentno,S.docentry,sp.rcnumber,sp.rcdocentry,sp.lineid,S.doctype,sp.rcamount ,sp.rcmode,"",sp.cardApprno,sp.cardterminal,sp.rcdatetime,sp.createdateTime,sp.couponcode,sp.coupontype,sp.walletid,sp.wallettype,sp.chequedate,sp.chequeno
from ReceiptLine2 sp
inner join ReceiptHeader S on S.docentry = sp.docentry
Left join DepositLine SL on SL.basedocentry = S.docentry and sp.lineid = SL.baselineid and S.doctype = SL.basedoctype
where rcmode = '$rcmode' and SL.docentry IS NULL
Union ALL

SELECT sa.documentno,sa.docentry,"","",sa.lineid,sa.doctype,-sa.rcamount,sa.rcmode,"","","","",sa.createdateTime,"","","","","","" FROM Expense sa
Left join DepositLine SL on SL.basedocentry = sa.docentry and sa.lineid = SL.baselineid and sa.doctype = SL.basedoctype
where rcmode = 'Cash' and SL.docentry IS NULL
''');
////log("""select S.documentno,S.docentry,sp.lineid,S.doctype, sp.rcamount ,sp.rcmode,S.customerphono,sp.cardApprno,sp.cardterminal,sp.rcdatetime,sp.createdateTime,sp.couponcode,sp.coupontype,sp.walletid,sp.wallettype,sp.chequedate,sp.chequeno
// from SalesPay sp
// inner join SalesHeader S on S.docentry = sp.docentry
// Left join DepositLine SL on SL.basedocentry = S.docentry and sp.lineid = SL.baselineid and S.doctype = SL.basedoctype
// where rcmode = '$rcmode' and SL.docentry IS NULL
// Union ALL

// select S.docnumber,S.docentry,sp.lineid,S.doctype,sp.rcamount ,sp.rcmode,"",sp.cardApprno,sp.cardterminal,sp.rcdatetime,sp.createdateTime,sp.couponcode,sp.coupontype,sp.walletid,sp.wallettype,sp.chequedate,sp.chequeno
// from ReceiptLine2 sp
// inner join ReceiptHeader S on S.docentry = sp.docentry
// Left join DepositLine SL on SL.basedocentry = S.docentry and sp.lineid = SL.baselineid and S.doctype = SL.basedoctype
// where rcmode = '$rcmode' and SL.docentry IS NULL
// Union ALL
// SELECT sa.documentno,sa.docentry,sa.lineid,sa.doctype,-sa.rcamount,sa.rcmode,"","","","",sa.createdateTime,"","","","","","" FROM Expense sa
// Left join DepositLine SL on SL.basedocentry = sa.docentry and sa.lineid = SL.baselineid and sa.doctype = SL.basedoctype
// where rcmode = '$rcmode'and SL.docentry IS NULL
// """);
//log("resuuuuL11: " + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getNetCollectionAmtByDate(
      Database db, String date) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''SELECT ifnull (SUM(rcamount),0)as totals
FROM SalesPay
WHERE  createdateTime like '$date%' and rcmode != 'Credit'
UNION ALL
SELECT  ifnull (SUM(rcamount),0)
FROM ReceiptLine2
WHERE  createdateTime like '$date%' 
UNION ALL
SELECT ifnull (SUM(rcamount),0)
FROM Expense
WHERE  createdateTime like '$date%';
''');
////log("""SELECT ifnull (SUM(rcamount),0)as totals
// FROM SalesPay
// WHERE  createdateTime like '$date%'
// UNION ALL
// SELECT  ifnull (SUM(rcamount),0)
// FROM ReceiptLine2
// WHERE  createdateTime like '$date%'
// UNION ALL
// SELECT ifnull (SUM(rcamount),0)
// FROM Expense
// WHERE  createdateTime like '$date%';
// """);
//log("resuuuuL22: " + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getTotalSettledByDateMode(
      Database db, String date, String mode) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''SELECT ifnull (SUM(amountsettled),0)as totals
FROM tableDepositHeader
WHERE  docdate like '$date%' and typedeposit = '$mode'
''');
////log(""" settle --
// SELECT ifnull (SUM(amountsettled),0)as totals
// FROM tableDepositHeader
// WHERE  docdate like '$date%'  and typedeposit = '$mode'
// """);
//log("resuuuuL33: " + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getTotalSettledByDate(
      Database db, String date) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''SELECT ifnull (SUM(amountsettled),0)as totals
FROM tableDepositHeader
WHERE  docdate like '$date%'
''');
////log("""SELECT ifnull (SUM(amountsettled),0)as totals
// FROM tableDepositHeader
// WHERE  docdate like '$date%'
// """);
//log("resuuuuL44: " + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getTotalCashByDate(
      Database db, String date, String mode) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''select S.documentno,S.docentry,sp.lineid,S.doctype, sp.rcamount ,sp.rcmode,S.customerphono,sp.cardApprno,sp.cardterminal,sp.rcdatetime,sp.createdateTime,sp.couponcode,sp.coupontype,sp.walletid,sp.wallettype,sp.chequedate,sp.chequeno
      from SalesPay sp
      inner join SalesHeader S on S.docentry = sp.docentry
      where rcmode = '$mode'  and  sp.createdateTime like '$date%' 
      Union ALL

      select S.documentno,S.docentry,sp.lineid,S.doctype,sp.rcamount ,sp.rcmode,"",sp.cardApprno,sp.cardterminal,sp.rcdatetime,sp.createdateTime,sp.couponcode,sp.coupontype,sp.walletid,sp.wallettype,sp.chequedate,sp.chequeno
      from ReceiptLine2 sp
      inner join ReceiptHeader S on S.docentry = sp.docentry
      where rcmode = '$mode'  and  sp.createdateTime like '$date%' 
      Union ALL
	  
      SELECT sa.documentno,sa.docentry,sa.lineid,sa.doctype,-sa.rcamount,sa.rcmode,"","","","",sa.createdateTime,"","","","","","" FROM Expense sa
      where rcmode = '$mode' and  sa.createdateTime like '$date%' ;
''');
////log("""select S.documentno,S.docentry,sp.lineid,S.doctype, sp.rcamount ,sp.rcmode,S.customerphono,sp.cardApprno,sp.cardterminal,sp.rcdatetime,sp.createdateTime,sp.couponcode,sp.coupontype,sp.walletid,sp.wallettype,sp.chequedate,sp.chequeno
//       from SalesPay sp
//       inner join SalesHeader S on S.docentry = sp.docentry
//       where rcmode = '$mode'  and  sp.createdateTime like '$date%'
//       Union ALL

//       select S.documentno,S.docentry,sp.lineid,S.doctype,sp.rcamount ,sp.rcmode,"",sp.cardApprno,sp.cardterminal,sp.rcdatetime,sp.createdateTime,sp.couponcode,sp.coupontype,sp.walletid,sp.wallettype,sp.chequedate,sp.chequeno
//       from ReceiptLine2 sp
//       inner join ReceiptHeader S on S.docentry = sp.docentry
//       where rcmode = '$mode'  and  sp.createdateTime like '$date%'
//       Union ALL

//       SELECT sa.documentno,sa.docentry,sa.lineid,sa.doctype,-sa.rcamount,sa.rcmode,"","","","",sa.createdateTime,"","","","","","" FROM Expense sa
//       where rcmode = '$mode' and  sa.createdateTime like '$date%' ;
// """);
//log("resuuuuL55: " + result.toString());
    return result;
  }

// select S.documentno,S.docentry,sp.lineid,S.doctype,-sp.rcamount ,sp.rcmode,"","","","",sp.createdateTime,sp.couponcode,sp.coupontype,"","",sp.chequedate,sp.chequeno
// from SalesReturnPay sp
// inner join SalesReturnHeader S on S.docentry = sp.docentry
// where rcmode = '$rcmode'
// Union ALL
  static Future<int?> insertExpenseMaster(
      Database db, List<ExpenseMasterModel> values) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("ExpenseMaster", es);
    });
    await batch.commit();
    // final List<Map<String, Object?>> result1 =
    //     await db.rawQuery('''SELECT * FROM  ExpenseMaster''');
    return null;
    //log("ExpenseMaster:" + result1.toString());
  }

  static Future<int?> insertExpensepaidfrom(
      Database db, List<expensepaidfrom> values) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("expensepaidfrom", es);
    });
    await batch.commit();
    // final List<Map<String, Object?>> result1 =
    //     await db.rawQuery('''SELECT * FROM  expensepaidfrom''');
    return null;
    //log("expensepaidfrom:" + result1.toString());
  }

  static Future<List<Map<String, Object?>>> getExpenseMaster(
    Database db,
  ) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''SELECT * FROM  ExpenseMaster''');
    //log("aaaahhhh1:" + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getExpensepaidfrom(
    Database db,
  ) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''SELECT * FROM  expensepaidfrom''');
    //log("aaahhh1:" + result.toString());
    //log("aaaahhhh1:" + result.toString());
    return result;
  }

//
  static Future<int?> getDocAldy(Database db, String colName, tableName,
      int value, String barnch, terminal) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    select count($colName) from $tableName where $colName = $value 
    and branch = '$barnch' and terminal = '$terminal' 
     ''');
    int? count = Sqflite.firstIntValue(result);
    // List<Map<String, Object?>> ress = await db.rawQuery('''
    // select * from $tableName
    //  ''');
//log("$tableName count:::${count}");
    return count;
  }

  static Future<int?> generateDocentr(
      Database db, String colName, tableName) async {
    // select max ((documentno) +1 )from StockReqHDT select documentno from StockReqHDT
    List<Map<String, Object?>> result = await db.rawQuery('''
    select IFNULL(MAX($colName)+1,1) as $colName from $tableName
     ''');
    int? count = Sqflite.firstIntValue(result);
    //log("count:: " + count.toString());

    return count;
  }

  static Future<List<Map<String, Object?>>> getDepositHeadDB(
      Database db, int? docentry) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT * FROM  tableDepositHeader where docentry="$docentry"''');
    //log('tableDepositHeader getdata' + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getAllDepositHeadDB(
    Database db,
  ) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''SELECT * FROM  tableDepositHeader ''');
    log('tableDepositHeader getdata' + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getDepositLineDB(
      Database db, int? docentry) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  DepositLine where docentry="$docentry"''');
    //log('DepositLine getdata' + result.toString());
    return result;
  }

  //parames Queries
  static Future<List<Map<String, Object?>>> getSalesHeaderDateWise(
    Database db,
    String fromdate,
    String toDate,
  ) async {
    // //log("date11:: " + fromdate.toString());
    // //log("date22:: " + toDate.toString());
    List<Map<String, Object?>> result = await db.rawQuery('''
  select * from SalesHeader WHERE substr(createdateTime,1,10) BETWEEN '$fromdate' AND '$toDate' AND docstatus='3'AND qStatus='C'
     ''');

    //   List<Map<String, Object?>> result2 = await db.rawQuery('''
    // select * from SalesHeader
    //    ''');
    log("SalesHeader:: " + result.toList().toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getSalesOrderDateWise(
    Database db,
    String fromdate,
    String toDate,
  ) async {
    //log("date11:: " + fromdate.toString());
    //log("date22:: " + toDate.toString());
    log('''
  select * from SalesOrderHeader WHERE substr(createdateTime,1,10) BETWEEN '$fromdate' AND '$toDate' AND docstatus='3' AND qStatus='C'
     ''');
    List<Map<String, Object?>> result = await db.rawQuery('''
  select * from SalesOrderHeader WHERE substr(createdateTime,1,10) BETWEEN '$fromdate' AND '$toDate' AND docstatus='3' AND qStatus='C'
     ''');

    List<Map<String, Object?>> result2 = await db.rawQuery('''
  select * from SalesOrderHeader 
     ''');
    log("SalesOrderHeader:: ${result.toList()}");

    return result;
  }

  static Future<List<Map<String, Object?>>> getSalesOrderAprvlDateWise(
    Database db,
    String fromdate,
    String toDate,
  ) async {
    //log("date11:: " + fromdate.toString());
    //log("date22:: " + toDate.toString());
    List<Map<String, Object?>> result = await db.rawQuery('''
  select * from SalesOrderHeader WHERE substr(createdateTime,1,10) BETWEEN '$fromdate' AND '$toDate' AND docstatus="5"
     ''');

    //   List<Map<String, Object?>> result2 = await db.rawQuery('''
    // select * from SalesOrderHeader
    //    ''');
//log("SalesOrderHeader:: " + result.toList().toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getExpenseDateWise(
    Database db,
    String fromdate,
    String toDate,
  ) async {
    //log("date11:: " + fromdate.toString());
    //log("date22:: " + toDate.toString());
    List<Map<String, Object?>> result = await db.rawQuery('''
  select * from Expense WHERE substr(createdateTime,1,10) BETWEEN '$fromdate' AND '$toDate' and docstatus="2"  AND qStatus='C'
     ''');

    log("Expense:: " + result.toList().toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getPayReciptHeaderDateWise(
    Database db,
    String fromdate,
    String toDate,
  ) async {
    //log("date11:: " + fromdate.toString());
    //log("date22:: " + toDate.toString());
    List<Map<String, Object?>> result = await db.rawQuery('''
  select * from ReceiptHeader WHERE substr(createdateTime,1,10) BETWEEN '$fromdate' AND '$toDate' AND docstatus= '3' AND qStatus='C'
     ''');

    List<Map<String, Object?>> result2 = await db.rawQuery('''
  select * from ReceiptHeader 
     ''');
    log("ReceiptHeader:: ${result2.length}");

    return result;
  }

  static Future<List<Map<String, Object?>>> getPayReciptLine1DateWise(
    Database db,
    String fromdate,
    String toDate,
  ) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
select * from ReceiptLine1 WHERE substr(createdateTime,1,10) BETWEEN '$fromdate' AND '$toDate' 
   
     ''');
    //  //log("ReceiptLine1 hold:: "+result.toList().toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getPayReciptLine2DateWise(
    Database db,
    String fromdate,
    String toDate,
  ) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
select * from ReceiptLine2 WHERE substr(createdateTime,1,10) BETWEEN '$fromdate' AND '$toDate'
     ''');

    return result;
  }

  //

  static Future<List<Map<String, Object?>>> getSalesRetHeaderDateWise(
    Database db,
    String fromdate,
    String toDate,
  ) async {
    //log("date11:: " + fromdate.toString());
    //log("date22:: " + toDate.toString());
    List<Map<String, Object?>> result = await db.rawQuery('''
  select * from SalesReturnHeader WHERE docstatus='3'and substr(createdateTime,1,10) BETWEEN '$fromdate' AND '$toDate'  AND qStatus='C'
     ''');

    List<Map<String, Object?>> result2 = await db.rawQuery('''
    select * from SalesReturnHeader
       ''');
    log("SalesReturnHeader DateWise:: " + result.toList().toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getSalesRetLineDateWise(
    Database db,
    String fromdate,
    String toDate,
  ) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
select * from SalesReturnLine WHERE substr(createdateTime,1,10) BETWEEN '$fromdate' AND '$toDate'
   
     ''');

    return result;
  }

  static Future<List<Map<String, Object?>>> getSalesRetPayDateWise(
    Database db,
    String fromdate,
    String toDate,
  ) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
select * from SalesReturnPay WHERE substr(createdateTime,1,10) BETWEEN '$fromdate' AND '$toDate'
     ''');
    //  //log("StockReqHDT hold:: "+result.toList().toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getSalesheadCkout2(
      Database db, String? customercode) async {
    //log("Sales header docno::" + customercode.toString());
    List<Map<String, Object?>> result = await db.rawQuery('''
    select * from SalesHeader where customercode="$customercode" 
    ''');
    //log("SalesHeader checkout:: " + result.toList().toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getStockInHeaderDateWise(
    Database db,
    String fromdate,
    String toDate,
  ) async {
    //log("date11:: " + fromdate.toString());
    //log("date22:: " + toDate.toString());
    List<Map<String, Object?>> result = await db.rawQuery('''
  select * from StockInHeaderDB WHERE substr(createdateTime,1,10) BETWEEN '$fromdate' AND '$toDate' AND docstatus='3' AND qStatus='C'
     ''');

    List<Map<String, Object?>> result2 = await db.rawQuery('''
  select * from StockInHeaderDB 
     ''');
    //log("StockInHeaderDB:: " + result.toList().toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getStockOutHeaderDateWise(
    Database db,
    String fromdate,
    String toDate,
  ) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
  select * from StockOutHeaderDataDB WHERE substr(createdateTime,1,10) BETWEEN '$fromdate' AND '$toDate' AND docstatus='3' AND qStatus='C'
     ''');

    List<Map<String, Object?>> result2 = await db.rawQuery('''
  select * from StockOutHeaderDataDB 
     ''');
    //log("StockOutHeaderDataDB:: " + result.toList().toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getStockReqHeaderDateWise(
    Database db,
    String fromdate,
    String toDate,
  ) async {
    //log("date11:: " + fromdate.toString());
    //log("date22:: " + toDate.toString());
    List<Map<String, Object?>> result = await db.rawQuery('''
  select * from StockReqHDT WHERE substr(createdateTime,1,10) BETWEEN '$fromdate' AND '$toDate' AND docstatus='3'  AND qStatus='O'
     ''');
//OR docstatus="2"
    //   List<Map<String, Object?>> result2 = await db.rawQuery('''
    // select * from StockReqLineT
    //    ''');
    log("StockReqLineT:: ${result.toList()}");

    return result;
  }

// copy from so
  static Future<List<Map<String, Object?>>> getSalesOrderconfirmvalueDB(
    Database db,
  ) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('''SELECT * FROM  SalesOrderHeader where docstatus = "3"''');
    //log("SalesOrderHeadHoldvalueDB:" + result.toString());
    return result;
  }

  static Future<List<Map<String, Object?>>> getSalesOrdervalueDB(
    Database db,
  ) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        ''' SELECT soh.docentry,soh.documentno,soh.sapDocNo,soh.sapDocentry,soh.createdateTime,soh.baltopay,
        soh.city,soh.state,soh.pinno,soh.gst,soh.country,soh.billaddressid,soh.customerphono,soh.customeremail,
 soh.customername,soh.taxno,soh.customerpoint,soh.customercode,soh.customeraccbal,soh.doctotal,s.lineid,s.itemcode,
s.itemname,s.serialbatch,s.quantity,s.price,s.taxrate,s.discperc,s.maxdiscount,
s.createdateTime,s.quantity-ifnull(sum(sl.quantity),0) Balanceqty
FROM  SalesOrderHeader soh Inner Join SalesOrderLine s on  
s.docentry=soh.docentry 
LEFT JOIN SalesLine sl on sl.basedocentry=s.docentry and sl.baselineid=s.lineid
where s.quantity > ifnull(sl.quantity,0) and soh.docstatus='3'and soh.sapDocNo IS NOT NULL
group by soh.docentry,soh.documentno,soh.sapDocNo,soh.createdateTime,soh.baltopay,
        soh.city,soh.state,soh.pinno,soh.gst,soh.country,soh.billaddressid,soh.customerphono,soh.customeremail,
 soh.customername,soh.taxno,soh.customerpoint,soh.customercode,soh.customeraccbal,soh.doctotal
''');
//log("SalesOrderHeadHoldvalueDB:" + result.toString());
    // log("SalesOrderHeadHoldvalueDB length:" + result.length.toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getSalesOrderLinevalueDB(
      Database db, String docentry) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT s.docentry,s.lineid,s.itemcode,s.itemname,s.serialbatch,s.quantity,s.price,s.taxrate,s.discperc,s.maxdiscount,s.createdateTime,s.quantity-sum(sl.quantity) Balanceqty
FROM  SalesOrderLine s
LEFT JOIN (Select sl.basedocentry, sl.baselineID,sl.quantity from SalesLine sl
                    inner join SalesHeader T3 on sl.docentry=T3.docentry
					Where t3.docstatus=3 and t3.qStatus='C')  sl on sl.basedocentry=s.docentry and sl.baselineid=s.lineid
where s.docentry in ($docentry)
group by s.docentry,s.lineid,s.itemcode,s.itemname,s.serialbatch,s.quantity,s.price,s.taxrate,s.discperc,s.maxdiscount,s.createdateTime

''');
    //log("SalesOrderLinevalueDB:" + result.toString());
    return result;
  }

  //coupons details
  static Future insertCouponmaster(
      Database db, List<CouponDetailDB> values) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("CouponDetailsT", es);
    });
    await batch.commit();
    final List<Map<String, Object?>> result1 =
        await db.rawQuery('''SELECT * FROM  CouponDetailsT''');
    //log("CouponDetailsT Table:" + result1.toString());
  }

  static Future getcoupontype(Database db, String custcode) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
Select  Distinct coupontype,coupontype,couponcode,couponamt,cardcode,status From CouponDetailsT Where status = 'Open' and cardcode="$custcode"
     ''');
    //log("CouponDetailsT result111" + result.toList().toString());
    List<Map<String, Object?>> result2 = await db.rawQuery('''
Select  * From CouponDetailsT
     ''');
    //log("CouponDetails result22222" + result2.toList().toString());

    return result;
  }

  static Future<int?> getCouponmaster(Database db) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
    select count(cardcode) from CouponDetailsT
     ''');
    //log(result.toList().toString());
    int? count = Sqflite.firstIntValue(result);
    return count;
  }

  static Future updatecouponstatus(
      Database db, String cpncode, String cardCode) async {
    List<Map<String, Object?>> result = await db.rawQuery(
        ''' UPDATE CouponDetailsT  SET status="Used" Where couponcode="$cpncode" and cardcode="$cardCode"
 ''');
    //log("Updated Coupon list::" + result.toString());
    return result;
  }

  //Notification

  static Future insertNotification(
      List<NotificationModel> values, Database db) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableNotification, es);
    });
    await batch.commit();
  }

  static Future<List<NotificationModel>> getNotification(
    Database db,
  ) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT * FROM $tableNotification 
''');
    log("Notiiiee: " + result.toList().toString());
    return List.generate(result.length, (i) {
      return NotificationModel(
        id: int.parse(result[i]['NId'].toString()),
        docEntry: int.parse(result[i]['DocEntry'].toString()),
        titile: result[i]['Title'].toString(),
        description: result[i]['Description'].toString(),
        receiveTime: result[i]['ReceiveTime'].toString(),
        seenTime: result[i]['SeenTime'].toString(),
        imgUrl: result[i]['ImgUrl'].toString(),
        naviScn: result[i]['NavigateScreen'].toString(),
      );
    });
  }

  static Future<List<NotificationModel>> getDateWiseNotification(
      Database db, String date) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT * FROM $tableNotification where  ReceiveTime like "$date%"
''');
    log("Notiiiee: " + result.toList().toString());
    return List.generate(result.length, (i) {
      return NotificationModel(
        id: int.parse(result[i]['NId'].toString()),
        docEntry: int.parse(result[i]['DocEntry'].toString()),
        titile: result[i]['Title'].toString(),
        description: result[i]['Description'].toString(),
        receiveTime: result[i]['ReceiveTime'].toString(),
        seenTime: result[i]['SeenTime'].toString(),
        imgUrl: result[i]['ImgUrl'].toString(),
        naviScn: result[i]['NavigateScreen'].toString(),
      );
    });
  }

  static Future<int?> getUnSeenNotificationCount(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
    SELECT count(NId) from $tableNotification where SeenTime = '0';
    ''');
//log(result.toList().toString());
    int? count = Sqflite.firstIntValue(result);
    //  await db.close();
    return count;
  }

  static Future<List<Map<String, Object?>>> deleteNotification(
    Database db,
  ) async {
    List<Map<String, Object?>> result =
        await db.rawQuery(''' delete from $tableNotification''');
    return result;
  }

  static updateNotify(int id, String time, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
      UPDATE $tableNotification
    SET SeenTime = "$time" WHERE NId = $id;
    ''');
    return result;
  }

  static deleteNotify(int id, Database db) async {
    await db.rawQuery('''
      delete from $tableNotification WHERE DocEntry = $id;
    ''');
    // await db.close();
  }

  static deleteNotifyAll(Database db) async {
    await db.rawQuery('''
      delete from $tableNotification;
    ''');
    // await db.close();
  }

  // ? get stock register

  static Future<List<Map<String, Object?>>> getStockRegister(
    Database db,
  ) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
     select t1.documentno,t1.docentry,t1.transtime,t1.customercode,t1.customername,t1.branch,t1.terminal,
t2.itemcode,t2.itemname
from SalesHeader t1 
inner JOIN
SalesLine t2 on t1.docentry = t2.docentry where t1.docstatus="3"
     ''');
    // log("salesheader:: " + result.toList().toString());
    return result;
  }

  // ? get return register
  static Future<List<Map<String, Object?>>> getRetunrRegister(
    Database db,
  ) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
     select t1.documentno,t1.docentry,t1.transtime,t1.customercode,t1.customername,t1.branch,t1.terminal,
t2.itemcode,t2.itemname
from SalesReturnHeader t1 
inner JOIN
SalesReturnLine t2 on t1.docentry = t2.docentry
     ''');
    // log("salesheader:: " + result.toList().toString());
    return result;
  }

  // ? get Cashstatement
  static Future<List<Map<String, Object?>>> getCashstatement(
    Database db,
  ) async {
    List<Map<String, Object?>> result = await db.rawQuery('''
     select t1.documentno,t1.customercode,t1.customername,t1.branch,t1.terminal, t1.docstatus,t1.doctype,
t2.rcamount, 0 Expense,t1.transtime
from Salesheader t1 
inner JOIN
SalesPay t2 on t1.docentry = t2.docentry where docstatus='3'
UNION all 
select t1.documentno,t1.customer,t3.customername,t1.branch,t1.terminal,t1.docstatus,t1.doctype,
t2.rcamount, 0 Expense ,t1.transdate
from ReceiptHeader t1
inner JOIN
ReceiptLine2 t2 on t1.docentry = t2.docentry 
inner join CustomerMaster t3 on t3.customercode = t1.customer where docstatus='3'
UNION all 
SELECT t4.documentno,t4.expencecode,'',t4.branch,t4.terminal,t4.docstatus,t4.doctype,0,t4.rcamount,t4.createdateTime
from Expense t4 
where rcmode = 'Cash' 
     ''');
//log("getCashstatement:: " + result.toList().toString());
    return result;
  }

  static Future holdDeleteQuery(
    Database db,
  ) async {
    //1.Quotation
    await db.rawQuery(
        ''' Delete From SalesQuotationLine Where docentry in (SELECT docentry from SalesQuotationHeader where docstatus=1 and cast(julianday('now') - julianday(createdatetime) as INTEGER)>=7)
''');
    await db.rawQuery(
        '''Delete From SalesQuotationHeader Where docentry in (SELECT docentry from SalesQuotationHeader where docstatus=1 and cast(julianday('now') - julianday(createdatetime) as INTEGER)>=7)
''');

//2.SalesOrder
    await db.rawQuery(
        ''' Delete From SalesOrderLine Where docentry in (SELECT docentry from SalesOrderHeader where docstatus=1 and cast(julianday('now') - julianday(createdatetime) as INTEGER)>=7)
''');
    await db.rawQuery(
        '''Delete From SalesOrderPay Where docentry in (SELECT docentry from SalesOrderHeader where docstatus=1 and cast(julianday('now') - julianday(createdatetime) as INTEGER)>=7)
''');
    await db.rawQuery(
        '''Delete From SalesorderHeader Where Docentry in (SELECT docentry from SalesOrderHeader where docstatus=1 and cast(julianday('now') - julianday(createdatetime) as INTEGER)>=7)
''');

//3.Sales
    await db.rawQuery(
        ''' Delete From SalesLine Where docentry in (SELECT docentry from SalesHeader where docstatus=1 and cast(julianday('now') - julianday(createdatetime) as INTEGER)>=7)
''');
    await db.rawQuery(
        '''Delete From SalesPay Where docentry in (SELECT docentry from SalesHeader where docstatus=1 and cast(julianday('now') - julianday(createdatetime) as INTEGER)>=7)
''');
    await db.rawQuery(
        '''Delete From SalesHeader Where docentry in (SELECT docentry from SalesHeader where docstatus=1 and cast(julianday('now') - julianday(createdatetime) as INTEGER)>=7)
''');

//4.SalesReturn
    await db.rawQuery(
        ''' Delete From SalesReturnLine Where docentry in (SELECT docentry from SalesReturnHeader where docstatus=1 and cast(julianday('now') - julianday(createdatetime) as INTEGER)>=7)
''');
    await db.rawQuery(
        '''Delete From SalesReturnHeader Where docentry in (SELECT docentry from SalesReturnHeader where docstatus=1 and cast(julianday('now') - julianday(createdatetime) as INTEGER)>=7)
''');

//5.StockReq
    await db.rawQuery(
        ''' Delete From StockReqLineT Where docentry in (SELECT docentry from StockReqHDT where docstatus=1 and cast(julianday('now') - julianday(createdatetime) as INTEGER)>=7)
''');
    await db.rawQuery(
        '''Delete From StockReqHDT Where docentry in (SELECT docentry from StockReqHDT where docstatus=1 and cast(julianday('now') - julianday(createdatetime) as INTEGER)>=7)
''');

//6.StockOutWard
    await db.rawQuery(
        ''' Delete From StockOutLineDB Where docentry in (SELECT docentry from StockOutHeaderDataDB where docstatus=1 and cast(julianday('now') - julianday(createdatetime) as INTEGER)>=7)
''');
    await db.rawQuery(
        '''Delete From StockOutBatchDB Where docentry in (SELECT docentry from StockOutHeaderDataDB where docstatus=1 and cast(julianday('now') - julianday(createdatetime) as INTEGER)>=7)
''');
    await db.rawQuery(
        '''Delete From StockOutHeaderDataDB Where docentry in (SELECT docentry from StockOutHeaderDataDB where docstatus=1 and cast(julianday('now') - julianday(createdatetime) as INTEGER)>=7)
''');
//7.Stockinward
    await db.rawQuery(
        ''' Delete From StockInLineDB Where docentry in (SELECT docentry from StockInHeaderDB where docstatus=1 and cast(julianday('now') - julianday(createdatetime) as INTEGER)>=7)
''');
    await db.rawQuery(
        '''Delete From StockInBatchDB Where docentry in (SELECT docentry from StockInHeaderDB where docstatus=1 and cast(julianday('now') - julianday(createdatetime) as INTEGER)>=7)
''');
    await db.rawQuery(
        '''Delete From StockInHeaderDB Where docentry in (SELECT docentry from StockInHeaderDB where docstatus=1 and cast(julianday('now') - julianday(createdatetime) as INTEGER)>=7)
''');

//8.Payment Receipt
    await db.rawQuery(
        ''' Delete From ReceiptLine1 Where docentry in (SELECT docentry from ReceiptHeader where docstatus=1 and cast(julianday('now') - julianday(createdatetime) as INTEGER)>=7)
''');
    await db.rawQuery(
        '''Delete From ReceiptLine2 Where docentry in (SELECT docentry from ReceiptHeader where docstatus=1 and cast(julianday('now') - julianday(createdatetime) as INTEGER)>=7)
''');
    await db.rawQuery(
        '''Delete From ReceiptHeader Where docentry in (SELECT docentry from ReceiptHeader where docstatus=1 and cast(julianday('now') - julianday(createdatetime) as INTEGER)>=7)
''');

//9.Expense
    await db.rawQuery(
        '''Delete From Expense Where docentry in (SELECT docentry from Expense where docstatus=1 and cast(julianday('now') - julianday(createdatetime) as INTEGER)>=7)
''');
  }

  static truncateItemMaster(
    Database db,
  ) async {
    await db.rawQuery('delete from $tableItemMaster');
  }

  static truncateStockSnap(
    Database db,
  ) async {
    await db.rawQuery('delete from $tableStockSnap');
  }

  static truncateBranchMaster(
    Database db,
  ) async {
    await db.rawQuery('delete from $tableBranch');
  }

  static truncateCouponDetailsMaster(
    Database db,
  ) async {
    await db.rawQuery('delete from $couponDetailsMaster');
  }

  // static truncateNewItemMasterCheck(
  //   Database db,
  // ) async {
  //   await db.rawQuery('delete from ItemMasterCheck');
  // }

  static truncateCustomerMasterAddress(
    Database db,
  ) async {
    await db.rawQuery('delete from $tableCustomerMasterAdress');
  }

  static truncateCustomerMaster(
    Database db,
  ) async {
    await db.rawQuery('delete from $tableCustomerMaster');
  }

  static truncateUserMaster(
    Database db,
  ) async {
    await db.rawQuery('delete from $tableUsers');
  }

  //customer controller
  static Future<List<Map<String, Object?>>> getCstmMasforcustomerpage(
      Database db) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''SELECT  * from CustomerMaster ''');
    // log("CustomerMaster Len: " + result.length.toString());
    // log("CustomerMaster Len: " + result.toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getcustomerdetails(
      Database db, String customercode) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT  * from CustomerMasterAddress WHERE custcode="$customercode"''');
    // log("CustomerMasterAddress Len: " + result.length.toString());
    // log("CustomerMasterAddress Len: " + result.toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getMoreCstmMasforcuspage(
      Database db, String customercode) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT  * from CustomerMaster WHERE customercode Like '%$customercode%' or  customername like '%$customercode%' ''');
    // log("CustomerMaster Len: " + result.length.toString());
    // log("CustomerMaster Len: " + result.toString());

    return result;
  }

  static Future<List<Map<String, Object?>>> getMoreCstgroups(
      Database db, String customercode) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''SELECT  * from CustomerMaster WHERE  customercode Like '%$customercode%' and customername like '%CASH%' ''');
//log("CustomerMaster Len: " + result.length.toString());
//log("CustomerMaster result: " + result.toString());

    return result;
  }
}
