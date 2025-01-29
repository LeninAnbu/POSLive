// import 'dart:io';
// import 'package:drift/native.dart';
// import 'package:drift/drift.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as p;
// import 'package:sqlite3/sqlite3.dart';
// import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
// part 'driftTablecreation.g.dart';

// class DriftItemMaster extends Table {
//   IntColumn get IMid => integer().autoIncrement()();
//   TextColumn get itemname => text().named("itemname").nullable()();
//   TextColumn get itemcode => text().named("itemcode").nullable()();
//   TextColumn get whsCode => text().named("WhsCode").nullable()();
//   TextColumn get serialbatch => text().named("serialbatch").nullable()();
//   IntColumn get quantity => integer().named("quantity").nullable()();
//   TextColumn get maximumQty => text().named("maximumQty").nullable()();
//   TextColumn get minimumQty => text().named("minimumQty").nullable()();
//   TextColumn get displayQty => text().named("displayQty").nullable()();

//   TextColumn get searchString => text().named("searchString").nullable()();
//   TextColumn get category => text().named("category").nullable()();
//   RealColumn get liter => real().named("liter").nullable()();
//   TextColumn get category1 => text().named("category1").nullable()();
//   RealColumn get weight => real().named("weight").nullable()();
//   TextColumn get hsnsac => text().named("hsnsac").nullable()();
//   TextColumn get isActive => text().named("isActive").nullable()();
// //{\"taxrate\":18.000000,\"snapdatetime\":\"2024-09-16T10:05:25.56\",\"purchasedate\":\"2024-09-16T10:05:25.56\",
// //\"createdateTime\":\"2024-09-16T10:05:25.56\",\"updatedDatetime\":\"2024-09-16T10:05:25.56\",\"createdUserID\":\"1\",
// //\"updateduserid\":\"1\",\"lastupdateIp\":\"\",\"U_Pack_Size\":5.000000,\"U_TINS_PER_BOX\":4,\"U_Specific_Gravity\":1.252600,\"U_Pack_Size_uom\":\"L\"}

//   TextColumn get isfreeby => text().named("isfreeby").nullable()();
//   TextColumn get isinventory => text().named("isinventory").nullable()();
//   TextColumn get issellpricebyscrbat =>
//       text().named("issellpricebyscrbat").nullable()();
//   TextColumn get itemnamelong => text().named("itemnamelong").nullable()();
//   TextColumn get itemnameshort => text().named("itemnameshort").nullable()();
//   TextColumn get skucode => text().named("skucode").nullable()();
//   TextColumn get subcategory => text().named("subcategory").nullable()();
//   RealColumn get sellprice => real().named("sellprice").nullable()();
//   RealColumn get mrpprice => real().named("mrpprice").nullable()();
//   RealColumn get specialprice => real().named("specialprice").nullable()();
//   TextColumn get maxdiscount => text().named("maxdiscount").nullable()();
//   RealColumn get taxrate => real().named("taxrate").nullable()();

//   TextColumn get snapdatetime => text().named("snapdatetime").nullable()();
//   TextColumn get purchasedate => text().named("purchasedate").nullable()();
//   TextColumn get createdateTime => text().named("createdateTime").nullable()();
//   TextColumn get updatedDatetime =>
//       text().named("updatedDatetime").nullable()();

//   TextColumn get createdUserID => text().named("createdUserID").nullable()();
//   TextColumn get updateduserid => text().named("updateduserid").nullable()();
//   TextColumn get lastupdateIp => text().named("lastupdateIp").nullable()();

//   RealColumn get uPackSize => real().named("U_Pack_Size").nullable()();
//   IntColumn get uTINSPERBOX => integer().named("U_TINS_PER_BOX").nullable()();
//   RealColumn get uSpecificGravity =>
//       real().named("U_Specific_Gravity").nullable()();
//   TextColumn get uPackSizeUom => text().named("U_Pack_Size_uom").nullable()();
//   @override
//   String get tableName => 'driftitemmaster';
// }

// //{\"itemname\":\"RED OXIDE PRIMER - 5LTR\",\"itemcode\":\"1000002C\",\"WhsCode\":\"HOFG\",\"serialbatch\":\"OB\",\"quantity\":23,\"maximumQty\":\"10\",\"minimumQty\":\"0\",\"displayQty\":\"10\",\"searchString\":\"1000002C,RED OXIDE PRIMER - 5LTR,RED OXIDE PRIMER - 5LTR,CORAL\",\"category\":\"\",\"liter\":5.000000,\"category1\":\"\",\"weight\":0.000000,\"hsnsac\":\"\",\"isActive\":\"N\",\"isfreeby\":\"FALSE\",\"isinventory\":\"TRUE\",\"issellpricebyscrbat\":\"FALSE\",\"itemnamelong\":\"1000002C,RED OXIDE PRIMER - 5LTR,RED OXIDE PRIMER - 5LTR,CORAL\",\"itemnameshort\":\"RED OXIDE PRIMER - 5LTR\",\"skucode\":\"1000002C\",\"subcategory\":\"\",\"sellprice\":23500.000000,\"mrpprice\":23500.000000,\"specialprice\":23500.000000,\"maxdiscount\":\"50\",\"taxrate\":18.000000,\"snapdatetime\":\"2024-09-16T10:05:25.56\",\"purchasedate\":\"2024-09-16T10:05:25.56\",\"createdateTime\":\"2024-09-16T10:05:25.56\",\"updatedDatetime\":\"2024-09-16T10:05:25.56\",\"createdUserID\":\"1\",\"updateduserid\":\"1\",\"lastupdateIp\":\"\",\"U_Pack_Size\":5.000000,\"U_TINS_PER_BOX\":4,\"U_Specific_Gravity\":1.252600,\"U_Pack_Size_uom\":\"L\"}
// class DriftProductMaster extends Table {
//   IntColumn get IMid => integer().autoIncrement()();
//   TextColumn get itemname => text().named("itemname").nullable()();
//   TextColumn get itemcode => text().named("itemcode").nullable()();
//   // IntColumn get quantity => integer().named("quantity").nullable()();
//   TextColumn get maximumQty => text().named("maximumQty").nullable()();
//   TextColumn get minimumQty => text().named("minimumQty").nullable()();
//   TextColumn get displayQty => text().named("displayQty").nullable()();
//   TextColumn get searchString => text().named("searchString").nullable()();
//   RealColumn get liter => real().named("liter").nullable()();
//   TextColumn get category => text().named("category").nullable()();
//   TextColumn get category1 => text().named("category1").nullable()();
//   TextColumn get brand => text().named("brand").nullable()();
//   TextColumn get brand1 => text().named("brand1").nullable()();
//   RealColumn get weight => real().named("weight").nullable()();
//   TextColumn get hsnsac => text().named("hsnsac").nullable()();
//   TextColumn get isActive => text().named("isActive").nullable()();
//   TextColumn get isfreeby => text().named("isfreeby").nullable()();
//   TextColumn get isinventory => text().named("isinventory").nullable()();
//   TextColumn get issellpricebyscrbat =>
//       text().named("issellpricebyscrbat").nullable()();
//   TextColumn get itemnamelong => text().named("itemnamelong").nullable()();
//   TextColumn get itemnameshort => text().named("itemnameshort").nullable()();
//   TextColumn get skucode => text().named("skucode").nullable()();
//   TextColumn get subcategory => text().named("subcategory").nullable()();
//   RealColumn get sellprice => real().named("sellprice").nullable()();
//   RealColumn get mrpprice => real().named("mrpprice").nullable()();
//   RealColumn get specialprice => real().named("specialprice").nullable()();
//   TextColumn get maxdiscount => text().named("maxdiscount").nullable()();
//   RealColumn get taxrate => real().named("taxrate").nullable()();
//   TextColumn get snapdatetime => text().named("snapdatetime").nullable()();
//   TextColumn get purchasedate => text().named("purchasedate").nullable()();
//   TextColumn get createdateTime => text().named("createdateTime").nullable()();
//   TextColumn get updatedDatetime =>
//       text().named("updatedDatetime").nullable()();
//   TextColumn get createdUserID => text().named("createdUserID").nullable()();
//   TextColumn get updateduserid => text().named("updateduserid").nullable()();
//   TextColumn get lastupdateIp => text().named("lastupdateIp").nullable()();
//   RealColumn get uPackSize => real().named("U_Pack_Size").nullable()();
//   IntColumn get uTINSPERBOX => integer().named("U_TINS_PER_BOX").nullable()();
//   RealColumn get uSpecificGravity =>
//       real().named("U_Specific_Gravity").nullable()();
//   TextColumn get uPackSizeUom => text().named("U_Pack_Size_uom").nullable()();
//   @override
//   String get tableName => 'productmaster';
// }

// LazyDatabase openConnection() {
//   return LazyDatabase(() async {
//     final dbFolder = await getApplicationDocumentsDirectory();
//     final file = File(p.join(dbFolder.path, 'db.sqlite'));
//     if (Platform.isAndroid) {
//       await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
//     }
//     final cachebase = (await getTemporaryDirectory()).path;
//     sqlite3.tempDirectory = cachebase;

//     return NativeDatabase.createInBackground(file);
//   });
// }

// @DriftDatabase(tables: [DriftItemMaster, DriftProductMaster])
// class AppDatabase extends _$AppDatabase {
//   AppDatabase(QueryExecutor e) : super(e);

//   @override
//   int get schemaVersion => 1;
//   static AppDatabase? _instance;
//   static AppDatabase get instance {
//     if (_instance == null) {
//       throw Exception(
//           "AppDatabase not initialized. Call AppDatabase.initialize() first.");
//     }
//     return _instance!;
//   }

//   static Future<AppDatabase?> initialize() async {
//     final directory = await getApplicationDocumentsDirectory();
//     if (_instance == null) {
//       // final directory = await getApplicationDocumentsDirectory();
//       final path = join(directory.path, 'db.sqlite');

//       _instance = AppDatabase(NativeDatabase(File(path)));
//     }
//     return _instance;
//   }
// }
