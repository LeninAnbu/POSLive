// import 'dart:developer';
// import 'package:drift/drift.dart' as drift;
// import 'package:drift/drift.dart';
// import '../Models/Service Model/StockSnapModelApi.dart';
// import '../Models/Service Model/productMasterModel.dart';
// import 'driftTablecreation.dart';

// class DriftOperation {
//   static Future<void> insertdriftdatabase(
//       List<StocksnapModelData> dataList, AppDatabase database) async {
//     final stopwatch = Stopwatch()..start();
//     // final database = AppDatabase.instance;
//     const int batchSize = 10000; // Adjust based on your performance tests

//     await database.transaction(() async {
//       for (int i = 0; i < dataList.length; i += batchSize) {
//         await database.batch((Batch batch) {
//           for (int j = i; j < i + batchSize && j < dataList.length; j++) {
//             final data = dataList[j];
//             batch.insert(
//               database.driftItemMaster,
//               DriftItemMasterCompanion(
//                 category1: drift.Value(data.category),
//                 createdUserID: drift.Value(data.createdUserID),
//                 createdateTime: drift.Value(data.createdateTime),
//                 displayQty: drift.Value(data.displayQty),
//                 hsnsac: drift.Value(data.hsnsac),
//                 category: drift.Value(data.category),
//                 isActive: drift.Value(data.isActive),
//                 isfreeby: drift.Value(data.isfreeby),
//                 isinventory: drift.Value(data.isinventory),
//                 issellpricebyscrbat: drift.Value(data.issellpricebyscrbat),
//                 skucode: drift.Value(data.skuCode),
//                 itemname: drift.Value(data.itemName),
//                 itemcode: drift.Value(data.itemCode),
//                 itemnamelong: drift.Value(data.itemnamelong),
//                 itemnameshort: drift.Value(data.itemnameshort),
//                 lastupdateIp: drift.Value(data.lastupdateIp),
//                 liter: drift.Value(data.liter),
//                 maxdiscount: drift.Value(data.maxdiscount),
//                 maximumQty: drift.Value(data.maximumQty),
//                 minimumQty: drift.Value(data.minimumQty),
//                 mrpprice: drift.Value(data.mrp),
//                 purchasedate: drift.Value(data.purchasedate),
//                 quantity: drift.Value(data.qty),
//                 searchString: drift.Value(data.searchString),
//                 subcategory: drift.Value(data.subcategory),
//                 serialbatch: drift.Value(data.serialBatch),
//                 sellprice: drift.Value(data.sellPrice),
//                 snapdatetime: drift.Value(data.snapdatetime),
//                 specialprice: drift.Value(data.sellPrice),
//                 taxrate: drift.Value(data.taxRate),
//                 uPackSize: drift.Value(data.uPackSize),
//                 uPackSizeUom: drift.Value(data.uPackSizeuom),
//                 uSpecificGravity: drift.Value(data.uSpecificGravity),
//                 uTINSPERBOX: drift.Value(data.uTINSPERBOX),
//                 updatedDatetime: drift.Value(data.updatedDatetime),
//                 updateduserid: drift.Value(data.updateduserid),
//                 weight: drift.Value(data.weight),
//                 whsCode: drift.Value(data.branch),
//               ),
//             );
//           }
//         });
//       }
//     });

//     stopwatch.stop();
//     log('Inserted Item SS::${dataList.length} records in ${stopwatch.elapsedMilliseconds} ms');
//   }

//   static Future<void> insertProductDatabase(
//       List<ProductMasterModslData> dataList, AppDatabase database) async {
//     final stopwatch = Stopwatch()..start();
//     log('dataListdataListdataList::${dataList.length}');
//     // final database = AppDatabase.instance;
//     const int batchSize = 10000; // Adjust based on your performance tests

//     await database.transaction(() async {
//       for (int i = 0; i < dataList.length; i += batchSize) {
//         await database.batch((Batch batch) {
//           for (int j = i; j < i + batchSize && j < dataList.length; j++) {
//             final data = dataList[j];
//             batch.insert(
//               database.driftProductMaster,
//               DriftProductMasterCompanion(
//                 brand: drift.Value(data.brand),
//                 brand1: drift.Value(data.brand1),
//                 category: drift.Value(data.category),
//                 category1: drift.Value(data.category1),
//                 createdUserID: drift.Value(data.createdUserID),
//                 createdateTime: drift.Value(data.createdateTime),
//                 displayQty: drift.Value(data.displayQty),
//                 hsnsac: drift.Value(data.hsnsac),
//                 isActive: drift.Value(data.isActive),
//                 isfreeby: drift.Value(data.isfreeby),
//                 isinventory: drift.Value(data.isinventory),
//                 issellpricebyscrbat: drift.Value(data.issellpricebyscrbat),
//                 skucode: drift.Value(data.skucode),
//                 itemname: drift.Value(data.itemName),
//                 itemcode: drift.Value(data.itemcode),
//                 itemnamelong: drift.Value(data.itemnamelong),
//                 itemnameshort: drift.Value(data.itemnameshort),
//                 lastupdateIp: drift.Value(data.lastupdateIp),
//                 liter: drift.Value(data.liter),
//                 maxdiscount: drift.Value(data.maxdiscount),
//                 maximumQty: drift.Value(data.maximumQty),
//                 minimumQty: drift.Value(data.minimumQty),
//                 mrpprice: drift.Value(data.mrpprice),
//                 purchasedate: drift.Value(data.purchasedate),
//                 searchString: drift.Value(data.searchString),
//                 subcategory: drift.Value(data.subcategory),
//                 sellprice: drift.Value(data.sellprice),
//                 snapdatetime: drift.Value(data.snapdatetime),
//                 specialprice: drift.Value(data.sellprice),
//                 taxrate: drift.Value(data.taxrate),
//                 uPackSize: drift.Value(data.uPackSize),
//                 uPackSizeUom: drift.Value(data.uPackSizeuom),
//                 uSpecificGravity: drift.Value(data.uSpecificGravity),
//                 uTINSPERBOX: drift.Value(data.uTINSPERBOX),
//                 updatedDatetime: drift.Value(data.updatedDatetime),
//                 updateduserid: drift.Value(data.updateduserid),
//                 weight: drift.Value(data.weight),
//               ),
//             );
//           }
//         });
//       }
//     });

//     stopwatch.stop();
//     log('Inserted product::${dataList.length} records in ${stopwatch.elapsedMilliseconds} ms');
//   }

//   static Future deleteItemmaster(AppDatabase database) async {
//     // return (delete(items)..where((tbl) => tbl.id.equals(id))).go();
//     var result = database.customStatement("delete from driftitemmaster");
//     // log("driftitemmaster::${{result}}");
//     return result;
//   }

//   static Future deleteProductMaster(AppDatabase database) async {
//     // return (delete(items)..where((tbl) => tbl.id.equals(id))).go();
//     var result = database.customStatement("delete from productmaster");
//     // log("driftproductmaster::${{result.}}");
//     return result;
//   }
// }
