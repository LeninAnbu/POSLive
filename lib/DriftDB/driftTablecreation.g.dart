// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'driftTablecreation.dart';

// // ignore_for_file: type=lint
// class $DriftItemMasterTable extends DriftItemMaster
//     with TableInfo<$DriftItemMasterTable, DriftItemMasterData> {
//   @override
//   final GeneratedDatabase attachedDatabase;
//   final String? _alias;
//   $DriftItemMasterTable(this.attachedDatabase, [this._alias]);
//   static const VerificationMeta _IMidMeta = const VerificationMeta('IMid');
//   @override
//   late final GeneratedColumn<int> IMid = GeneratedColumn<int>(
//       'i_mid', aliasedName, false,
//       hasAutoIncrement: true,
//       type: DriftSqlType.int,
//       requiredDuringInsert: false,
//       defaultConstraints:
//           GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
//   static const VerificationMeta _itemnameMeta =
//       const VerificationMeta('itemname');
//   @override
//   late final GeneratedColumn<String> itemname = GeneratedColumn<String>(
//       'itemname', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _itemcodeMeta =
//       const VerificationMeta('itemcode');
//   @override
//   late final GeneratedColumn<String> itemcode = GeneratedColumn<String>(
//       'itemcode', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _whsCodeMeta =
//       const VerificationMeta('whsCode');
//   @override
//   late final GeneratedColumn<String> whsCode = GeneratedColumn<String>(
//       'WhsCode', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _serialbatchMeta =
//       const VerificationMeta('serialbatch');
//   @override
//   late final GeneratedColumn<String> serialbatch = GeneratedColumn<String>(
//       'serialbatch', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _quantityMeta =
//       const VerificationMeta('quantity');
//   @override
//   late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
//       'quantity', aliasedName, true,
//       type: DriftSqlType.int, requiredDuringInsert: false);
//   static const VerificationMeta _maximumQtyMeta =
//       const VerificationMeta('maximumQty');
//   @override
//   late final GeneratedColumn<String> maximumQty = GeneratedColumn<String>(
//       'maximumQty', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _minimumQtyMeta =
//       const VerificationMeta('minimumQty');
//   @override
//   late final GeneratedColumn<String> minimumQty = GeneratedColumn<String>(
//       'minimumQty', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _displayQtyMeta =
//       const VerificationMeta('displayQty');
//   @override
//   late final GeneratedColumn<String> displayQty = GeneratedColumn<String>(
//       'displayQty', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _searchStringMeta =
//       const VerificationMeta('searchString');
//   @override
//   late final GeneratedColumn<String> searchString = GeneratedColumn<String>(
//       'searchString', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _categoryMeta =
//       const VerificationMeta('category');
//   @override
//   late final GeneratedColumn<String> category = GeneratedColumn<String>(
//       'category', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _literMeta = const VerificationMeta('liter');
//   @override
//   late final GeneratedColumn<double> liter = GeneratedColumn<double>(
//       'liter', aliasedName, true,
//       type: DriftSqlType.double, requiredDuringInsert: false);
//   static const VerificationMeta _category1Meta =
//       const VerificationMeta('category1');
//   @override
//   late final GeneratedColumn<String> category1 = GeneratedColumn<String>(
//       'category1', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _weightMeta = const VerificationMeta('weight');
//   @override
//   late final GeneratedColumn<double> weight = GeneratedColumn<double>(
//       'weight', aliasedName, true,
//       type: DriftSqlType.double, requiredDuringInsert: false);
//   static const VerificationMeta _hsnsacMeta = const VerificationMeta('hsnsac');
//   @override
//   late final GeneratedColumn<String> hsnsac = GeneratedColumn<String>(
//       'hsnsac', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _isActiveMeta =
//       const VerificationMeta('isActive');
//   @override
//   late final GeneratedColumn<String> isActive = GeneratedColumn<String>(
//       'isActive', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _isfreebyMeta =
//       const VerificationMeta('isfreeby');
//   @override
//   late final GeneratedColumn<String> isfreeby = GeneratedColumn<String>(
//       'isfreeby', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _isinventoryMeta =
//       const VerificationMeta('isinventory');
//   @override
//   late final GeneratedColumn<String> isinventory = GeneratedColumn<String>(
//       'isinventory', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _issellpricebyscrbatMeta =
//       const VerificationMeta('issellpricebyscrbat');
//   @override
//   late final GeneratedColumn<String> issellpricebyscrbat =
//       GeneratedColumn<String>('issellpricebyscrbat', aliasedName, true,
//           type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _itemnamelongMeta =
//       const VerificationMeta('itemnamelong');
//   @override
//   late final GeneratedColumn<String> itemnamelong = GeneratedColumn<String>(
//       'itemnamelong', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _itemnameshortMeta =
//       const VerificationMeta('itemnameshort');
//   @override
//   late final GeneratedColumn<String> itemnameshort = GeneratedColumn<String>(
//       'itemnameshort', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _skucodeMeta =
//       const VerificationMeta('skucode');
//   @override
//   late final GeneratedColumn<String> skucode = GeneratedColumn<String>(
//       'skucode', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _subcategoryMeta =
//       const VerificationMeta('subcategory');
//   @override
//   late final GeneratedColumn<String> subcategory = GeneratedColumn<String>(
//       'subcategory', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _sellpriceMeta =
//       const VerificationMeta('sellprice');
//   @override
//   late final GeneratedColumn<double> sellprice = GeneratedColumn<double>(
//       'sellprice', aliasedName, true,
//       type: DriftSqlType.double, requiredDuringInsert: false);
//   static const VerificationMeta _mrppriceMeta =
//       const VerificationMeta('mrpprice');
//   @override
//   late final GeneratedColumn<double> mrpprice = GeneratedColumn<double>(
//       'mrpprice', aliasedName, true,
//       type: DriftSqlType.double, requiredDuringInsert: false);
//   static const VerificationMeta _specialpriceMeta =
//       const VerificationMeta('specialprice');
//   @override
//   late final GeneratedColumn<double> specialprice = GeneratedColumn<double>(
//       'specialprice', aliasedName, true,
//       type: DriftSqlType.double, requiredDuringInsert: false);
//   static const VerificationMeta _maxdiscountMeta =
//       const VerificationMeta('maxdiscount');
//   @override
//   late final GeneratedColumn<String> maxdiscount = GeneratedColumn<String>(
//       'maxdiscount', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _taxrateMeta =
//       const VerificationMeta('taxrate');
//   @override
//   late final GeneratedColumn<double> taxrate = GeneratedColumn<double>(
//       'taxrate', aliasedName, true,
//       type: DriftSqlType.double, requiredDuringInsert: false);
//   static const VerificationMeta _snapdatetimeMeta =
//       const VerificationMeta('snapdatetime');
//   @override
//   late final GeneratedColumn<String> snapdatetime = GeneratedColumn<String>(
//       'snapdatetime', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _purchasedateMeta =
//       const VerificationMeta('purchasedate');
//   @override
//   late final GeneratedColumn<String> purchasedate = GeneratedColumn<String>(
//       'purchasedate', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _createdateTimeMeta =
//       const VerificationMeta('createdateTime');
//   @override
//   late final GeneratedColumn<String> createdateTime = GeneratedColumn<String>(
//       'createdateTime', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _updatedDatetimeMeta =
//       const VerificationMeta('updatedDatetime');
//   @override
//   late final GeneratedColumn<String> updatedDatetime = GeneratedColumn<String>(
//       'updatedDatetime', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _createdUserIDMeta =
//       const VerificationMeta('createdUserID');
//   @override
//   late final GeneratedColumn<String> createdUserID = GeneratedColumn<String>(
//       'createdUserID', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _updateduseridMeta =
//       const VerificationMeta('updateduserid');
//   @override
//   late final GeneratedColumn<String> updateduserid = GeneratedColumn<String>(
//       'updateduserid', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _lastupdateIpMeta =
//       const VerificationMeta('lastupdateIp');
//   @override
//   late final GeneratedColumn<String> lastupdateIp = GeneratedColumn<String>(
//       'lastupdateIp', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _uPackSizeMeta =
//       const VerificationMeta('uPackSize');
//   @override
//   late final GeneratedColumn<double> uPackSize = GeneratedColumn<double>(
//       'U_Pack_Size', aliasedName, true,
//       type: DriftSqlType.double, requiredDuringInsert: false);
//   static const VerificationMeta _uTINSPERBOXMeta =
//       const VerificationMeta('uTINSPERBOX');
//   @override
//   late final GeneratedColumn<int> uTINSPERBOX = GeneratedColumn<int>(
//       'U_TINS_PER_BOX', aliasedName, true,
//       type: DriftSqlType.int, requiredDuringInsert: false);
//   static const VerificationMeta _uSpecificGravityMeta =
//       const VerificationMeta('uSpecificGravity');
//   @override
//   late final GeneratedColumn<double> uSpecificGravity = GeneratedColumn<double>(
//       'U_Specific_Gravity', aliasedName, true,
//       type: DriftSqlType.double, requiredDuringInsert: false);
//   static const VerificationMeta _uPackSizeUomMeta =
//       const VerificationMeta('uPackSizeUom');
//   @override
//   late final GeneratedColumn<String> uPackSizeUom = GeneratedColumn<String>(
//       'U_Pack_Size_uom', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   @override
//   List<GeneratedColumn> get $columns => [
//         IMid,
//         itemname,
//         itemcode,
//         whsCode,
//         serialbatch,
//         quantity,
//         maximumQty,
//         minimumQty,
//         displayQty,
//         searchString,
//         category,
//         liter,
//         category1,
//         weight,
//         hsnsac,
//         isActive,
//         isfreeby,
//         isinventory,
//         issellpricebyscrbat,
//         itemnamelong,
//         itemnameshort,
//         skucode,
//         subcategory,
//         sellprice,
//         mrpprice,
//         specialprice,
//         maxdiscount,
//         taxrate,
//         snapdatetime,
//         purchasedate,
//         createdateTime,
//         updatedDatetime,
//         createdUserID,
//         updateduserid,
//         lastupdateIp,
//         uPackSize,
//         uTINSPERBOX,
//         uSpecificGravity,
//         uPackSizeUom
//       ];
//   @override
//   String get aliasedName => _alias ?? actualTableName;
//   @override
//   String get actualTableName => $name;
//   static const String $name = 'driftitemmaster';
//   @override
//   VerificationContext validateIntegrity(
//       Insertable<DriftItemMasterData> instance,
//       {bool isInserting = false}) {
//     final context = VerificationContext();
//     final data = instance.toColumns(true);
//     if (data.containsKey('i_mid')) {
//       context.handle(
//           _IMidMeta, IMid.isAcceptableOrUnknown(data['i_mid']!, _IMidMeta));
//     }
//     if (data.containsKey('itemname')) {
//       context.handle(_itemnameMeta,
//           itemname.isAcceptableOrUnknown(data['itemname']!, _itemnameMeta));
//     }
//     if (data.containsKey('itemcode')) {
//       context.handle(_itemcodeMeta,
//           itemcode.isAcceptableOrUnknown(data['itemcode']!, _itemcodeMeta));
//     }
//     if (data.containsKey('WhsCode')) {
//       context.handle(_whsCodeMeta,
//           whsCode.isAcceptableOrUnknown(data['WhsCode']!, _whsCodeMeta));
//     }
//     if (data.containsKey('serialbatch')) {
//       context.handle(
//           _serialbatchMeta,
//           serialbatch.isAcceptableOrUnknown(
//               data['serialbatch']!, _serialbatchMeta));
//     }
//     if (data.containsKey('quantity')) {
//       context.handle(_quantityMeta,
//           quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
//     }
//     if (data.containsKey('maximumQty')) {
//       context.handle(
//           _maximumQtyMeta,
//           maximumQty.isAcceptableOrUnknown(
//               data['maximumQty']!, _maximumQtyMeta));
//     }
//     if (data.containsKey('minimumQty')) {
//       context.handle(
//           _minimumQtyMeta,
//           minimumQty.isAcceptableOrUnknown(
//               data['minimumQty']!, _minimumQtyMeta));
//     }
//     if (data.containsKey('displayQty')) {
//       context.handle(
//           _displayQtyMeta,
//           displayQty.isAcceptableOrUnknown(
//               data['displayQty']!, _displayQtyMeta));
//     }
//     if (data.containsKey('searchString')) {
//       context.handle(
//           _searchStringMeta,
//           searchString.isAcceptableOrUnknown(
//               data['searchString']!, _searchStringMeta));
//     }
//     if (data.containsKey('category')) {
//       context.handle(_categoryMeta,
//           category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
//     }
//     if (data.containsKey('liter')) {
//       context.handle(
//           _literMeta, liter.isAcceptableOrUnknown(data['liter']!, _literMeta));
//     }
//     if (data.containsKey('category1')) {
//       context.handle(_category1Meta,
//           category1.isAcceptableOrUnknown(data['category1']!, _category1Meta));
//     }
//     if (data.containsKey('weight')) {
//       context.handle(_weightMeta,
//           weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
//     }
//     if (data.containsKey('hsnsac')) {
//       context.handle(_hsnsacMeta,
//           hsnsac.isAcceptableOrUnknown(data['hsnsac']!, _hsnsacMeta));
//     }
//     if (data.containsKey('isActive')) {
//       context.handle(_isActiveMeta,
//           isActive.isAcceptableOrUnknown(data['isActive']!, _isActiveMeta));
//     }
//     if (data.containsKey('isfreeby')) {
//       context.handle(_isfreebyMeta,
//           isfreeby.isAcceptableOrUnknown(data['isfreeby']!, _isfreebyMeta));
//     }
//     if (data.containsKey('isinventory')) {
//       context.handle(
//           _isinventoryMeta,
//           isinventory.isAcceptableOrUnknown(
//               data['isinventory']!, _isinventoryMeta));
//     }
//     if (data.containsKey('issellpricebyscrbat')) {
//       context.handle(
//           _issellpricebyscrbatMeta,
//           issellpricebyscrbat.isAcceptableOrUnknown(
//               data['issellpricebyscrbat']!, _issellpricebyscrbatMeta));
//     }
//     if (data.containsKey('itemnamelong')) {
//       context.handle(
//           _itemnamelongMeta,
//           itemnamelong.isAcceptableOrUnknown(
//               data['itemnamelong']!, _itemnamelongMeta));
//     }
//     if (data.containsKey('itemnameshort')) {
//       context.handle(
//           _itemnameshortMeta,
//           itemnameshort.isAcceptableOrUnknown(
//               data['itemnameshort']!, _itemnameshortMeta));
//     }
//     if (data.containsKey('skucode')) {
//       context.handle(_skucodeMeta,
//           skucode.isAcceptableOrUnknown(data['skucode']!, _skucodeMeta));
//     }
//     if (data.containsKey('subcategory')) {
//       context.handle(
//           _subcategoryMeta,
//           subcategory.isAcceptableOrUnknown(
//               data['subcategory']!, _subcategoryMeta));
//     }
//     if (data.containsKey('sellprice')) {
//       context.handle(_sellpriceMeta,
//           sellprice.isAcceptableOrUnknown(data['sellprice']!, _sellpriceMeta));
//     }
//     if (data.containsKey('mrpprice')) {
//       context.handle(_mrppriceMeta,
//           mrpprice.isAcceptableOrUnknown(data['mrpprice']!, _mrppriceMeta));
//     }
//     if (data.containsKey('specialprice')) {
//       context.handle(
//           _specialpriceMeta,
//           specialprice.isAcceptableOrUnknown(
//               data['specialprice']!, _specialpriceMeta));
//     }
//     if (data.containsKey('maxdiscount')) {
//       context.handle(
//           _maxdiscountMeta,
//           maxdiscount.isAcceptableOrUnknown(
//               data['maxdiscount']!, _maxdiscountMeta));
//     }
//     if (data.containsKey('taxrate')) {
//       context.handle(_taxrateMeta,
//           taxrate.isAcceptableOrUnknown(data['taxrate']!, _taxrateMeta));
//     }
//     if (data.containsKey('snapdatetime')) {
//       context.handle(
//           _snapdatetimeMeta,
//           snapdatetime.isAcceptableOrUnknown(
//               data['snapdatetime']!, _snapdatetimeMeta));
//     }
//     if (data.containsKey('purchasedate')) {
//       context.handle(
//           _purchasedateMeta,
//           purchasedate.isAcceptableOrUnknown(
//               data['purchasedate']!, _purchasedateMeta));
//     }
//     if (data.containsKey('createdateTime')) {
//       context.handle(
//           _createdateTimeMeta,
//           createdateTime.isAcceptableOrUnknown(
//               data['createdateTime']!, _createdateTimeMeta));
//     }
//     if (data.containsKey('updatedDatetime')) {
//       context.handle(
//           _updatedDatetimeMeta,
//           updatedDatetime.isAcceptableOrUnknown(
//               data['updatedDatetime']!, _updatedDatetimeMeta));
//     }
//     if (data.containsKey('createdUserID')) {
//       context.handle(
//           _createdUserIDMeta,
//           createdUserID.isAcceptableOrUnknown(
//               data['createdUserID']!, _createdUserIDMeta));
//     }
//     if (data.containsKey('updateduserid')) {
//       context.handle(
//           _updateduseridMeta,
//           updateduserid.isAcceptableOrUnknown(
//               data['updateduserid']!, _updateduseridMeta));
//     }
//     if (data.containsKey('lastupdateIp')) {
//       context.handle(
//           _lastupdateIpMeta,
//           lastupdateIp.isAcceptableOrUnknown(
//               data['lastupdateIp']!, _lastupdateIpMeta));
//     }
//     if (data.containsKey('U_Pack_Size')) {
//       context.handle(
//           _uPackSizeMeta,
//           uPackSize.isAcceptableOrUnknown(
//               data['U_Pack_Size']!, _uPackSizeMeta));
//     }
//     if (data.containsKey('U_TINS_PER_BOX')) {
//       context.handle(
//           _uTINSPERBOXMeta,
//           uTINSPERBOX.isAcceptableOrUnknown(
//               data['U_TINS_PER_BOX']!, _uTINSPERBOXMeta));
//     }
//     if (data.containsKey('U_Specific_Gravity')) {
//       context.handle(
//           _uSpecificGravityMeta,
//           uSpecificGravity.isAcceptableOrUnknown(
//               data['U_Specific_Gravity']!, _uSpecificGravityMeta));
//     }
//     if (data.containsKey('U_Pack_Size_uom')) {
//       context.handle(
//           _uPackSizeUomMeta,
//           uPackSizeUom.isAcceptableOrUnknown(
//               data['U_Pack_Size_uom']!, _uPackSizeUomMeta));
//     }
//     return context;
//   }

//   @override
//   Set<GeneratedColumn> get $primaryKey => {IMid};
//   @override
//   DriftItemMasterData map(Map<String, dynamic> data, {String? tablePrefix}) {
//     final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
//     return DriftItemMasterData(
//       IMid: attachedDatabase.typeMapping
//           .read(DriftSqlType.int, data['${effectivePrefix}i_mid'])!,
//       itemname: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}itemname']),
//       itemcode: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}itemcode']),
//       whsCode: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}WhsCode']),
//       serialbatch: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}serialbatch']),
//       quantity: attachedDatabase.typeMapping
//           .read(DriftSqlType.int, data['${effectivePrefix}quantity']),
//       maximumQty: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}maximumQty']),
//       minimumQty: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}minimumQty']),
//       displayQty: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}displayQty']),
//       searchString: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}searchString']),
//       category: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}category']),
//       liter: attachedDatabase.typeMapping
//           .read(DriftSqlType.double, data['${effectivePrefix}liter']),
//       category1: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}category1']),
//       weight: attachedDatabase.typeMapping
//           .read(DriftSqlType.double, data['${effectivePrefix}weight']),
//       hsnsac: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}hsnsac']),
//       isActive: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}isActive']),
//       isfreeby: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}isfreeby']),
//       isinventory: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}isinventory']),
//       issellpricebyscrbat: attachedDatabase.typeMapping.read(
//           DriftSqlType.string, data['${effectivePrefix}issellpricebyscrbat']),
//       itemnamelong: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}itemnamelong']),
//       itemnameshort: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}itemnameshort']),
//       skucode: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}skucode']),
//       subcategory: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}subcategory']),
//       sellprice: attachedDatabase.typeMapping
//           .read(DriftSqlType.double, data['${effectivePrefix}sellprice']),
//       mrpprice: attachedDatabase.typeMapping
//           .read(DriftSqlType.double, data['${effectivePrefix}mrpprice']),
//       specialprice: attachedDatabase.typeMapping
//           .read(DriftSqlType.double, data['${effectivePrefix}specialprice']),
//       maxdiscount: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}maxdiscount']),
//       taxrate: attachedDatabase.typeMapping
//           .read(DriftSqlType.double, data['${effectivePrefix}taxrate']),
//       snapdatetime: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}snapdatetime']),
//       purchasedate: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}purchasedate']),
//       createdateTime: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}createdateTime']),
//       updatedDatetime: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}updatedDatetime']),
//       createdUserID: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}createdUserID']),
//       updateduserid: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}updateduserid']),
//       lastupdateIp: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}lastupdateIp']),
//       uPackSize: attachedDatabase.typeMapping
//           .read(DriftSqlType.double, data['${effectivePrefix}U_Pack_Size']),
//       uTINSPERBOX: attachedDatabase.typeMapping
//           .read(DriftSqlType.int, data['${effectivePrefix}U_TINS_PER_BOX']),
//       uSpecificGravity: attachedDatabase.typeMapping.read(
//           DriftSqlType.double, data['${effectivePrefix}U_Specific_Gravity']),
//       uPackSizeUom: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}U_Pack_Size_uom']),
//     );
//   }

//   @override
//   $DriftItemMasterTable createAlias(String alias) {
//     return $DriftItemMasterTable(attachedDatabase, alias);
//   }
// }

// class DriftItemMasterData extends DataClass
//     implements Insertable<DriftItemMasterData> {
//   final int IMid;
//   final String? itemname;
//   final String? itemcode;
//   final String? whsCode;
//   final String? serialbatch;
//   final int? quantity;
//   final String? maximumQty;
//   final String? minimumQty;
//   final String? displayQty;
//   final String? searchString;
//   final String? category;
//   final double? liter;
//   final String? category1;
//   final double? weight;
//   final String? hsnsac;
//   final String? isActive;
//   final String? isfreeby;
//   final String? isinventory;
//   final String? issellpricebyscrbat;
//   final String? itemnamelong;
//   final String? itemnameshort;
//   final String? skucode;
//   final String? subcategory;
//   final double? sellprice;
//   final double? mrpprice;
//   final double? specialprice;
//   final String? maxdiscount;
//   final double? taxrate;
//   final String? snapdatetime;
//   final String? purchasedate;
//   final String? createdateTime;
//   final String? updatedDatetime;
//   final String? createdUserID;
//   final String? updateduserid;
//   final String? lastupdateIp;
//   final double? uPackSize;
//   final int? uTINSPERBOX;
//   final double? uSpecificGravity;
//   final String? uPackSizeUom;
//   const DriftItemMasterData(
//       {required this.IMid,
//       this.itemname,
//       this.itemcode,
//       this.whsCode,
//       this.serialbatch,
//       this.quantity,
//       this.maximumQty,
//       this.minimumQty,
//       this.displayQty,
//       this.searchString,
//       this.category,
//       this.liter,
//       this.category1,
//       this.weight,
//       this.hsnsac,
//       this.isActive,
//       this.isfreeby,
//       this.isinventory,
//       this.issellpricebyscrbat,
//       this.itemnamelong,
//       this.itemnameshort,
//       this.skucode,
//       this.subcategory,
//       this.sellprice,
//       this.mrpprice,
//       this.specialprice,
//       this.maxdiscount,
//       this.taxrate,
//       this.snapdatetime,
//       this.purchasedate,
//       this.createdateTime,
//       this.updatedDatetime,
//       this.createdUserID,
//       this.updateduserid,
//       this.lastupdateIp,
//       this.uPackSize,
//       this.uTINSPERBOX,
//       this.uSpecificGravity,
//       this.uPackSizeUom});
//   @override
//   Map<String, Expression> toColumns(bool nullToAbsent) {
//     final map = <String, Expression>{};
//     map['i_mid'] = Variable<int>(IMid);
//     if (!nullToAbsent || itemname != null) {
//       map['itemname'] = Variable<String>(itemname);
//     }
//     if (!nullToAbsent || itemcode != null) {
//       map['itemcode'] = Variable<String>(itemcode);
//     }
//     if (!nullToAbsent || whsCode != null) {
//       map['WhsCode'] = Variable<String>(whsCode);
//     }
//     if (!nullToAbsent || serialbatch != null) {
//       map['serialbatch'] = Variable<String>(serialbatch);
//     }
//     if (!nullToAbsent || quantity != null) {
//       map['quantity'] = Variable<int>(quantity);
//     }
//     if (!nullToAbsent || maximumQty != null) {
//       map['maximumQty'] = Variable<String>(maximumQty);
//     }
//     if (!nullToAbsent || minimumQty != null) {
//       map['minimumQty'] = Variable<String>(minimumQty);
//     }
//     if (!nullToAbsent || displayQty != null) {
//       map['displayQty'] = Variable<String>(displayQty);
//     }
//     if (!nullToAbsent || searchString != null) {
//       map['searchString'] = Variable<String>(searchString);
//     }
//     if (!nullToAbsent || category != null) {
//       map['category'] = Variable<String>(category);
//     }
//     if (!nullToAbsent || liter != null) {
//       map['liter'] = Variable<double>(liter);
//     }
//     if (!nullToAbsent || category1 != null) {
//       map['category1'] = Variable<String>(category1);
//     }
//     if (!nullToAbsent || weight != null) {
//       map['weight'] = Variable<double>(weight);
//     }
//     if (!nullToAbsent || hsnsac != null) {
//       map['hsnsac'] = Variable<String>(hsnsac);
//     }
//     if (!nullToAbsent || isActive != null) {
//       map['isActive'] = Variable<String>(isActive);
//     }
//     if (!nullToAbsent || isfreeby != null) {
//       map['isfreeby'] = Variable<String>(isfreeby);
//     }
//     if (!nullToAbsent || isinventory != null) {
//       map['isinventory'] = Variable<String>(isinventory);
//     }
//     if (!nullToAbsent || issellpricebyscrbat != null) {
//       map['issellpricebyscrbat'] = Variable<String>(issellpricebyscrbat);
//     }
//     if (!nullToAbsent || itemnamelong != null) {
//       map['itemnamelong'] = Variable<String>(itemnamelong);
//     }
//     if (!nullToAbsent || itemnameshort != null) {
//       map['itemnameshort'] = Variable<String>(itemnameshort);
//     }
//     if (!nullToAbsent || skucode != null) {
//       map['skucode'] = Variable<String>(skucode);
//     }
//     if (!nullToAbsent || subcategory != null) {
//       map['subcategory'] = Variable<String>(subcategory);
//     }
//     if (!nullToAbsent || sellprice != null) {
//       map['sellprice'] = Variable<double>(sellprice);
//     }
//     if (!nullToAbsent || mrpprice != null) {
//       map['mrpprice'] = Variable<double>(mrpprice);
//     }
//     if (!nullToAbsent || specialprice != null) {
//       map['specialprice'] = Variable<double>(specialprice);
//     }
//     if (!nullToAbsent || maxdiscount != null) {
//       map['maxdiscount'] = Variable<String>(maxdiscount);
//     }
//     if (!nullToAbsent || taxrate != null) {
//       map['taxrate'] = Variable<double>(taxrate);
//     }
//     if (!nullToAbsent || snapdatetime != null) {
//       map['snapdatetime'] = Variable<String>(snapdatetime);
//     }
//     if (!nullToAbsent || purchasedate != null) {
//       map['purchasedate'] = Variable<String>(purchasedate);
//     }
//     if (!nullToAbsent || createdateTime != null) {
//       map['createdateTime'] = Variable<String>(createdateTime);
//     }
//     if (!nullToAbsent || updatedDatetime != null) {
//       map['updatedDatetime'] = Variable<String>(updatedDatetime);
//     }
//     if (!nullToAbsent || createdUserID != null) {
//       map['createdUserID'] = Variable<String>(createdUserID);
//     }
//     if (!nullToAbsent || updateduserid != null) {
//       map['updateduserid'] = Variable<String>(updateduserid);
//     }
//     if (!nullToAbsent || lastupdateIp != null) {
//       map['lastupdateIp'] = Variable<String>(lastupdateIp);
//     }
//     if (!nullToAbsent || uPackSize != null) {
//       map['U_Pack_Size'] = Variable<double>(uPackSize);
//     }
//     if (!nullToAbsent || uTINSPERBOX != null) {
//       map['U_TINS_PER_BOX'] = Variable<int>(uTINSPERBOX);
//     }
//     if (!nullToAbsent || uSpecificGravity != null) {
//       map['U_Specific_Gravity'] = Variable<double>(uSpecificGravity);
//     }
//     if (!nullToAbsent || uPackSizeUom != null) {
//       map['U_Pack_Size_uom'] = Variable<String>(uPackSizeUom);
//     }
//     return map;
//   }

//   DriftItemMasterCompanion toCompanion(bool nullToAbsent) {
//     return DriftItemMasterCompanion(
//       IMid: Value(IMid),
//       itemname: itemname == null && nullToAbsent
//           ? const Value.absent()
//           : Value(itemname),
//       itemcode: itemcode == null && nullToAbsent
//           ? const Value.absent()
//           : Value(itemcode),
//       whsCode: whsCode == null && nullToAbsent
//           ? const Value.absent()
//           : Value(whsCode),
//       serialbatch: serialbatch == null && nullToAbsent
//           ? const Value.absent()
//           : Value(serialbatch),
//       quantity: quantity == null && nullToAbsent
//           ? const Value.absent()
//           : Value(quantity),
//       maximumQty: maximumQty == null && nullToAbsent
//           ? const Value.absent()
//           : Value(maximumQty),
//       minimumQty: minimumQty == null && nullToAbsent
//           ? const Value.absent()
//           : Value(minimumQty),
//       displayQty: displayQty == null && nullToAbsent
//           ? const Value.absent()
//           : Value(displayQty),
//       searchString: searchString == null && nullToAbsent
//           ? const Value.absent()
//           : Value(searchString),
//       category: category == null && nullToAbsent
//           ? const Value.absent()
//           : Value(category),
//       liter:
//           liter == null && nullToAbsent ? const Value.absent() : Value(liter),
//       category1: category1 == null && nullToAbsent
//           ? const Value.absent()
//           : Value(category1),
//       weight:
//           weight == null && nullToAbsent ? const Value.absent() : Value(weight),
//       hsnsac:
//           hsnsac == null && nullToAbsent ? const Value.absent() : Value(hsnsac),
//       isActive: isActive == null && nullToAbsent
//           ? const Value.absent()
//           : Value(isActive),
//       isfreeby: isfreeby == null && nullToAbsent
//           ? const Value.absent()
//           : Value(isfreeby),
//       isinventory: isinventory == null && nullToAbsent
//           ? const Value.absent()
//           : Value(isinventory),
//       issellpricebyscrbat: issellpricebyscrbat == null && nullToAbsent
//           ? const Value.absent()
//           : Value(issellpricebyscrbat),
//       itemnamelong: itemnamelong == null && nullToAbsent
//           ? const Value.absent()
//           : Value(itemnamelong),
//       itemnameshort: itemnameshort == null && nullToAbsent
//           ? const Value.absent()
//           : Value(itemnameshort),
//       skucode: skucode == null && nullToAbsent
//           ? const Value.absent()
//           : Value(skucode),
//       subcategory: subcategory == null && nullToAbsent
//           ? const Value.absent()
//           : Value(subcategory),
//       sellprice: sellprice == null && nullToAbsent
//           ? const Value.absent()
//           : Value(sellprice),
//       mrpprice: mrpprice == null && nullToAbsent
//           ? const Value.absent()
//           : Value(mrpprice),
//       specialprice: specialprice == null && nullToAbsent
//           ? const Value.absent()
//           : Value(specialprice),
//       maxdiscount: maxdiscount == null && nullToAbsent
//           ? const Value.absent()
//           : Value(maxdiscount),
//       taxrate: taxrate == null && nullToAbsent
//           ? const Value.absent()
//           : Value(taxrate),
//       snapdatetime: snapdatetime == null && nullToAbsent
//           ? const Value.absent()
//           : Value(snapdatetime),
//       purchasedate: purchasedate == null && nullToAbsent
//           ? const Value.absent()
//           : Value(purchasedate),
//       createdateTime: createdateTime == null && nullToAbsent
//           ? const Value.absent()
//           : Value(createdateTime),
//       updatedDatetime: updatedDatetime == null && nullToAbsent
//           ? const Value.absent()
//           : Value(updatedDatetime),
//       createdUserID: createdUserID == null && nullToAbsent
//           ? const Value.absent()
//           : Value(createdUserID),
//       updateduserid: updateduserid == null && nullToAbsent
//           ? const Value.absent()
//           : Value(updateduserid),
//       lastupdateIp: lastupdateIp == null && nullToAbsent
//           ? const Value.absent()
//           : Value(lastupdateIp),
//       uPackSize: uPackSize == null && nullToAbsent
//           ? const Value.absent()
//           : Value(uPackSize),
//       uTINSPERBOX: uTINSPERBOX == null && nullToAbsent
//           ? const Value.absent()
//           : Value(uTINSPERBOX),
//       uSpecificGravity: uSpecificGravity == null && nullToAbsent
//           ? const Value.absent()
//           : Value(uSpecificGravity),
//       uPackSizeUom: uPackSizeUom == null && nullToAbsent
//           ? const Value.absent()
//           : Value(uPackSizeUom),
//     );
//   }

//   factory DriftItemMasterData.fromJson(Map<String, dynamic> json,
//       {ValueSerializer? serializer}) {
//     serializer ??= driftRuntimeOptions.defaultSerializer;
//     return DriftItemMasterData(
//       IMid: serializer.fromJson<int>(json['IMid']),
//       itemname: serializer.fromJson<String?>(json['itemname']),
//       itemcode: serializer.fromJson<String?>(json['itemcode']),
//       whsCode: serializer.fromJson<String?>(json['whsCode']),
//       serialbatch: serializer.fromJson<String?>(json['serialbatch']),
//       quantity: serializer.fromJson<int?>(json['quantity']),
//       maximumQty: serializer.fromJson<String?>(json['maximumQty']),
//       minimumQty: serializer.fromJson<String?>(json['minimumQty']),
//       displayQty: serializer.fromJson<String?>(json['displayQty']),
//       searchString: serializer.fromJson<String?>(json['searchString']),
//       category: serializer.fromJson<String?>(json['category']),
//       liter: serializer.fromJson<double?>(json['liter']),
//       category1: serializer.fromJson<String?>(json['category1']),
//       weight: serializer.fromJson<double?>(json['weight']),
//       hsnsac: serializer.fromJson<String?>(json['hsnsac']),
//       isActive: serializer.fromJson<String?>(json['isActive']),
//       isfreeby: serializer.fromJson<String?>(json['isfreeby']),
//       isinventory: serializer.fromJson<String?>(json['isinventory']),
//       issellpricebyscrbat:
//           serializer.fromJson<String?>(json['issellpricebyscrbat']),
//       itemnamelong: serializer.fromJson<String?>(json['itemnamelong']),
//       itemnameshort: serializer.fromJson<String?>(json['itemnameshort']),
//       skucode: serializer.fromJson<String?>(json['skucode']),
//       subcategory: serializer.fromJson<String?>(json['subcategory']),
//       sellprice: serializer.fromJson<double?>(json['sellprice']),
//       mrpprice: serializer.fromJson<double?>(json['mrpprice']),
//       specialprice: serializer.fromJson<double?>(json['specialprice']),
//       maxdiscount: serializer.fromJson<String?>(json['maxdiscount']),
//       taxrate: serializer.fromJson<double?>(json['taxrate']),
//       snapdatetime: serializer.fromJson<String?>(json['snapdatetime']),
//       purchasedate: serializer.fromJson<String?>(json['purchasedate']),
//       createdateTime: serializer.fromJson<String?>(json['createdateTime']),
//       updatedDatetime: serializer.fromJson<String?>(json['updatedDatetime']),
//       createdUserID: serializer.fromJson<String?>(json['createdUserID']),
//       updateduserid: serializer.fromJson<String?>(json['updateduserid']),
//       lastupdateIp: serializer.fromJson<String?>(json['lastupdateIp']),
//       uPackSize: serializer.fromJson<double?>(json['uPackSize']),
//       uTINSPERBOX: serializer.fromJson<int?>(json['uTINSPERBOX']),
//       uSpecificGravity: serializer.fromJson<double?>(json['uSpecificGravity']),
//       uPackSizeUom: serializer.fromJson<String?>(json['uPackSizeUom']),
//     );
//   }
//   @override
//   Map<String, dynamic> toJson({ValueSerializer? serializer}) {
//     serializer ??= driftRuntimeOptions.defaultSerializer;
//     return <String, dynamic>{
//       'IMid': serializer.toJson<int>(IMid),
//       'itemname': serializer.toJson<String?>(itemname),
//       'itemcode': serializer.toJson<String?>(itemcode),
//       'whsCode': serializer.toJson<String?>(whsCode),
//       'serialbatch': serializer.toJson<String?>(serialbatch),
//       'quantity': serializer.toJson<int?>(quantity),
//       'maximumQty': serializer.toJson<String?>(maximumQty),
//       'minimumQty': serializer.toJson<String?>(minimumQty),
//       'displayQty': serializer.toJson<String?>(displayQty),
//       'searchString': serializer.toJson<String?>(searchString),
//       'category': serializer.toJson<String?>(category),
//       'liter': serializer.toJson<double?>(liter),
//       'category1': serializer.toJson<String?>(category1),
//       'weight': serializer.toJson<double?>(weight),
//       'hsnsac': serializer.toJson<String?>(hsnsac),
//       'isActive': serializer.toJson<String?>(isActive),
//       'isfreeby': serializer.toJson<String?>(isfreeby),
//       'isinventory': serializer.toJson<String?>(isinventory),
//       'issellpricebyscrbat': serializer.toJson<String?>(issellpricebyscrbat),
//       'itemnamelong': serializer.toJson<String?>(itemnamelong),
//       'itemnameshort': serializer.toJson<String?>(itemnameshort),
//       'skucode': serializer.toJson<String?>(skucode),
//       'subcategory': serializer.toJson<String?>(subcategory),
//       'sellprice': serializer.toJson<double?>(sellprice),
//       'mrpprice': serializer.toJson<double?>(mrpprice),
//       'specialprice': serializer.toJson<double?>(specialprice),
//       'maxdiscount': serializer.toJson<String?>(maxdiscount),
//       'taxrate': serializer.toJson<double?>(taxrate),
//       'snapdatetime': serializer.toJson<String?>(snapdatetime),
//       'purchasedate': serializer.toJson<String?>(purchasedate),
//       'createdateTime': serializer.toJson<String?>(createdateTime),
//       'updatedDatetime': serializer.toJson<String?>(updatedDatetime),
//       'createdUserID': serializer.toJson<String?>(createdUserID),
//       'updateduserid': serializer.toJson<String?>(updateduserid),
//       'lastupdateIp': serializer.toJson<String?>(lastupdateIp),
//       'uPackSize': serializer.toJson<double?>(uPackSize),
//       'uTINSPERBOX': serializer.toJson<int?>(uTINSPERBOX),
//       'uSpecificGravity': serializer.toJson<double?>(uSpecificGravity),
//       'uPackSizeUom': serializer.toJson<String?>(uPackSizeUom),
//     };
//   }

//   DriftItemMasterData copyWith(
//           {int? IMid,
//           Value<String?> itemname = const Value.absent(),
//           Value<String?> itemcode = const Value.absent(),
//           Value<String?> whsCode = const Value.absent(),
//           Value<String?> serialbatch = const Value.absent(),
//           Value<int?> quantity = const Value.absent(),
//           Value<String?> maximumQty = const Value.absent(),
//           Value<String?> minimumQty = const Value.absent(),
//           Value<String?> displayQty = const Value.absent(),
//           Value<String?> searchString = const Value.absent(),
//           Value<String?> category = const Value.absent(),
//           Value<double?> liter = const Value.absent(),
//           Value<String?> category1 = const Value.absent(),
//           Value<double?> weight = const Value.absent(),
//           Value<String?> hsnsac = const Value.absent(),
//           Value<String?> isActive = const Value.absent(),
//           Value<String?> isfreeby = const Value.absent(),
//           Value<String?> isinventory = const Value.absent(),
//           Value<String?> issellpricebyscrbat = const Value.absent(),
//           Value<String?> itemnamelong = const Value.absent(),
//           Value<String?> itemnameshort = const Value.absent(),
//           Value<String?> skucode = const Value.absent(),
//           Value<String?> subcategory = const Value.absent(),
//           Value<double?> sellprice = const Value.absent(),
//           Value<double?> mrpprice = const Value.absent(),
//           Value<double?> specialprice = const Value.absent(),
//           Value<String?> maxdiscount = const Value.absent(),
//           Value<double?> taxrate = const Value.absent(),
//           Value<String?> snapdatetime = const Value.absent(),
//           Value<String?> purchasedate = const Value.absent(),
//           Value<String?> createdateTime = const Value.absent(),
//           Value<String?> updatedDatetime = const Value.absent(),
//           Value<String?> createdUserID = const Value.absent(),
//           Value<String?> updateduserid = const Value.absent(),
//           Value<String?> lastupdateIp = const Value.absent(),
//           Value<double?> uPackSize = const Value.absent(),
//           Value<int?> uTINSPERBOX = const Value.absent(),
//           Value<double?> uSpecificGravity = const Value.absent(),
//           Value<String?> uPackSizeUom = const Value.absent()}) =>
//       DriftItemMasterData(
//         IMid: IMid ?? this.IMid,
//         itemname: itemname.present ? itemname.value : this.itemname,
//         itemcode: itemcode.present ? itemcode.value : this.itemcode,
//         whsCode: whsCode.present ? whsCode.value : this.whsCode,
//         serialbatch: serialbatch.present ? serialbatch.value : this.serialbatch,
//         quantity: quantity.present ? quantity.value : this.quantity,
//         maximumQty: maximumQty.present ? maximumQty.value : this.maximumQty,
//         minimumQty: minimumQty.present ? minimumQty.value : this.minimumQty,
//         displayQty: displayQty.present ? displayQty.value : this.displayQty,
//         searchString:
//             searchString.present ? searchString.value : this.searchString,
//         category: category.present ? category.value : this.category,
//         liter: liter.present ? liter.value : this.liter,
//         category1: category1.present ? category1.value : this.category1,
//         weight: weight.present ? weight.value : this.weight,
//         hsnsac: hsnsac.present ? hsnsac.value : this.hsnsac,
//         isActive: isActive.present ? isActive.value : this.isActive,
//         isfreeby: isfreeby.present ? isfreeby.value : this.isfreeby,
//         isinventory: isinventory.present ? isinventory.value : this.isinventory,
//         issellpricebyscrbat: issellpricebyscrbat.present
//             ? issellpricebyscrbat.value
//             : this.issellpricebyscrbat,
//         itemnamelong:
//             itemnamelong.present ? itemnamelong.value : this.itemnamelong,
//         itemnameshort:
//             itemnameshort.present ? itemnameshort.value : this.itemnameshort,
//         skucode: skucode.present ? skucode.value : this.skucode,
//         subcategory: subcategory.present ? subcategory.value : this.subcategory,
//         sellprice: sellprice.present ? sellprice.value : this.sellprice,
//         mrpprice: mrpprice.present ? mrpprice.value : this.mrpprice,
//         specialprice:
//             specialprice.present ? specialprice.value : this.specialprice,
//         maxdiscount: maxdiscount.present ? maxdiscount.value : this.maxdiscount,
//         taxrate: taxrate.present ? taxrate.value : this.taxrate,
//         snapdatetime:
//             snapdatetime.present ? snapdatetime.value : this.snapdatetime,
//         purchasedate:
//             purchasedate.present ? purchasedate.value : this.purchasedate,
//         createdateTime:
//             createdateTime.present ? createdateTime.value : this.createdateTime,
//         updatedDatetime: updatedDatetime.present
//             ? updatedDatetime.value
//             : this.updatedDatetime,
//         createdUserID:
//             createdUserID.present ? createdUserID.value : this.createdUserID,
//         updateduserid:
//             updateduserid.present ? updateduserid.value : this.updateduserid,
//         lastupdateIp:
//             lastupdateIp.present ? lastupdateIp.value : this.lastupdateIp,
//         uPackSize: uPackSize.present ? uPackSize.value : this.uPackSize,
//         uTINSPERBOX: uTINSPERBOX.present ? uTINSPERBOX.value : this.uTINSPERBOX,
//         uSpecificGravity: uSpecificGravity.present
//             ? uSpecificGravity.value
//             : this.uSpecificGravity,
//         uPackSizeUom:
//             uPackSizeUom.present ? uPackSizeUom.value : this.uPackSizeUom,
//       );
//   DriftItemMasterData copyWithCompanion(DriftItemMasterCompanion data) {
//     return DriftItemMasterData(
//       IMid: data.IMid.present ? data.IMid.value : this.IMid,
//       itemname: data.itemname.present ? data.itemname.value : this.itemname,
//       itemcode: data.itemcode.present ? data.itemcode.value : this.itemcode,
//       whsCode: data.whsCode.present ? data.whsCode.value : this.whsCode,
//       serialbatch:
//           data.serialbatch.present ? data.serialbatch.value : this.serialbatch,
//       quantity: data.quantity.present ? data.quantity.value : this.quantity,
//       maximumQty:
//           data.maximumQty.present ? data.maximumQty.value : this.maximumQty,
//       minimumQty:
//           data.minimumQty.present ? data.minimumQty.value : this.minimumQty,
//       displayQty:
//           data.displayQty.present ? data.displayQty.value : this.displayQty,
//       searchString: data.searchString.present
//           ? data.searchString.value
//           : this.searchString,
//       category: data.category.present ? data.category.value : this.category,
//       liter: data.liter.present ? data.liter.value : this.liter,
//       category1: data.category1.present ? data.category1.value : this.category1,
//       weight: data.weight.present ? data.weight.value : this.weight,
//       hsnsac: data.hsnsac.present ? data.hsnsac.value : this.hsnsac,
//       isActive: data.isActive.present ? data.isActive.value : this.isActive,
//       isfreeby: data.isfreeby.present ? data.isfreeby.value : this.isfreeby,
//       isinventory:
//           data.isinventory.present ? data.isinventory.value : this.isinventory,
//       issellpricebyscrbat: data.issellpricebyscrbat.present
//           ? data.issellpricebyscrbat.value
//           : this.issellpricebyscrbat,
//       itemnamelong: data.itemnamelong.present
//           ? data.itemnamelong.value
//           : this.itemnamelong,
//       itemnameshort: data.itemnameshort.present
//           ? data.itemnameshort.value
//           : this.itemnameshort,
//       skucode: data.skucode.present ? data.skucode.value : this.skucode,
//       subcategory:
//           data.subcategory.present ? data.subcategory.value : this.subcategory,
//       sellprice: data.sellprice.present ? data.sellprice.value : this.sellprice,
//       mrpprice: data.mrpprice.present ? data.mrpprice.value : this.mrpprice,
//       specialprice: data.specialprice.present
//           ? data.specialprice.value
//           : this.specialprice,
//       maxdiscount:
//           data.maxdiscount.present ? data.maxdiscount.value : this.maxdiscount,
//       taxrate: data.taxrate.present ? data.taxrate.value : this.taxrate,
//       snapdatetime: data.snapdatetime.present
//           ? data.snapdatetime.value
//           : this.snapdatetime,
//       purchasedate: data.purchasedate.present
//           ? data.purchasedate.value
//           : this.purchasedate,
//       createdateTime: data.createdateTime.present
//           ? data.createdateTime.value
//           : this.createdateTime,
//       updatedDatetime: data.updatedDatetime.present
//           ? data.updatedDatetime.value
//           : this.updatedDatetime,
//       createdUserID: data.createdUserID.present
//           ? data.createdUserID.value
//           : this.createdUserID,
//       updateduserid: data.updateduserid.present
//           ? data.updateduserid.value
//           : this.updateduserid,
//       lastupdateIp: data.lastupdateIp.present
//           ? data.lastupdateIp.value
//           : this.lastupdateIp,
//       uPackSize: data.uPackSize.present ? data.uPackSize.value : this.uPackSize,
//       uTINSPERBOX:
//           data.uTINSPERBOX.present ? data.uTINSPERBOX.value : this.uTINSPERBOX,
//       uSpecificGravity: data.uSpecificGravity.present
//           ? data.uSpecificGravity.value
//           : this.uSpecificGravity,
//       uPackSizeUom: data.uPackSizeUom.present
//           ? data.uPackSizeUom.value
//           : this.uPackSizeUom,
//     );
//   }

//   @override
//   String toString() {
//     return (StringBuffer('DriftItemMasterData(')
//           ..write('IMid: $IMid, ')
//           ..write('itemname: $itemname, ')
//           ..write('itemcode: $itemcode, ')
//           ..write('whsCode: $whsCode, ')
//           ..write('serialbatch: $serialbatch, ')
//           ..write('quantity: $quantity, ')
//           ..write('maximumQty: $maximumQty, ')
//           ..write('minimumQty: $minimumQty, ')
//           ..write('displayQty: $displayQty, ')
//           ..write('searchString: $searchString, ')
//           ..write('category: $category, ')
//           ..write('liter: $liter, ')
//           ..write('category1: $category1, ')
//           ..write('weight: $weight, ')
//           ..write('hsnsac: $hsnsac, ')
//           ..write('isActive: $isActive, ')
//           ..write('isfreeby: $isfreeby, ')
//           ..write('isinventory: $isinventory, ')
//           ..write('issellpricebyscrbat: $issellpricebyscrbat, ')
//           ..write('itemnamelong: $itemnamelong, ')
//           ..write('itemnameshort: $itemnameshort, ')
//           ..write('skucode: $skucode, ')
//           ..write('subcategory: $subcategory, ')
//           ..write('sellprice: $sellprice, ')
//           ..write('mrpprice: $mrpprice, ')
//           ..write('specialprice: $specialprice, ')
//           ..write('maxdiscount: $maxdiscount, ')
//           ..write('taxrate: $taxrate, ')
//           ..write('snapdatetime: $snapdatetime, ')
//           ..write('purchasedate: $purchasedate, ')
//           ..write('createdateTime: $createdateTime, ')
//           ..write('updatedDatetime: $updatedDatetime, ')
//           ..write('createdUserID: $createdUserID, ')
//           ..write('updateduserid: $updateduserid, ')
//           ..write('lastupdateIp: $lastupdateIp, ')
//           ..write('uPackSize: $uPackSize, ')
//           ..write('uTINSPERBOX: $uTINSPERBOX, ')
//           ..write('uSpecificGravity: $uSpecificGravity, ')
//           ..write('uPackSizeUom: $uPackSizeUom')
//           ..write(')'))
//         .toString();
//   }

//   @override
//   int get hashCode => Object.hashAll([
//         IMid,
//         itemname,
//         itemcode,
//         whsCode,
//         serialbatch,
//         quantity,
//         maximumQty,
//         minimumQty,
//         displayQty,
//         searchString,
//         category,
//         liter,
//         category1,
//         weight,
//         hsnsac,
//         isActive,
//         isfreeby,
//         isinventory,
//         issellpricebyscrbat,
//         itemnamelong,
//         itemnameshort,
//         skucode,
//         subcategory,
//         sellprice,
//         mrpprice,
//         specialprice,
//         maxdiscount,
//         taxrate,
//         snapdatetime,
//         purchasedate,
//         createdateTime,
//         updatedDatetime,
//         createdUserID,
//         updateduserid,
//         lastupdateIp,
//         uPackSize,
//         uTINSPERBOX,
//         uSpecificGravity,
//         uPackSizeUom
//       ]);
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       (other is DriftItemMasterData &&
//           other.IMid == this.IMid &&
//           other.itemname == this.itemname &&
//           other.itemcode == this.itemcode &&
//           other.whsCode == this.whsCode &&
//           other.serialbatch == this.serialbatch &&
//           other.quantity == this.quantity &&
//           other.maximumQty == this.maximumQty &&
//           other.minimumQty == this.minimumQty &&
//           other.displayQty == this.displayQty &&
//           other.searchString == this.searchString &&
//           other.category == this.category &&
//           other.liter == this.liter &&
//           other.category1 == this.category1 &&
//           other.weight == this.weight &&
//           other.hsnsac == this.hsnsac &&
//           other.isActive == this.isActive &&
//           other.isfreeby == this.isfreeby &&
//           other.isinventory == this.isinventory &&
//           other.issellpricebyscrbat == this.issellpricebyscrbat &&
//           other.itemnamelong == this.itemnamelong &&
//           other.itemnameshort == this.itemnameshort &&
//           other.skucode == this.skucode &&
//           other.subcategory == this.subcategory &&
//           other.sellprice == this.sellprice &&
//           other.mrpprice == this.mrpprice &&
//           other.specialprice == this.specialprice &&
//           other.maxdiscount == this.maxdiscount &&
//           other.taxrate == this.taxrate &&
//           other.snapdatetime == this.snapdatetime &&
//           other.purchasedate == this.purchasedate &&
//           other.createdateTime == this.createdateTime &&
//           other.updatedDatetime == this.updatedDatetime &&
//           other.createdUserID == this.createdUserID &&
//           other.updateduserid == this.updateduserid &&
//           other.lastupdateIp == this.lastupdateIp &&
//           other.uPackSize == this.uPackSize &&
//           other.uTINSPERBOX == this.uTINSPERBOX &&
//           other.uSpecificGravity == this.uSpecificGravity &&
//           other.uPackSizeUom == this.uPackSizeUom);
// }

// class DriftItemMasterCompanion extends UpdateCompanion<DriftItemMasterData> {
//   final Value<int> IMid;
//   final Value<String?> itemname;
//   final Value<String?> itemcode;
//   final Value<String?> whsCode;
//   final Value<String?> serialbatch;
//   final Value<int?> quantity;
//   final Value<String?> maximumQty;
//   final Value<String?> minimumQty;
//   final Value<String?> displayQty;
//   final Value<String?> searchString;
//   final Value<String?> category;
//   final Value<double?> liter;
//   final Value<String?> category1;
//   final Value<double?> weight;
//   final Value<String?> hsnsac;
//   final Value<String?> isActive;
//   final Value<String?> isfreeby;
//   final Value<String?> isinventory;
//   final Value<String?> issellpricebyscrbat;
//   final Value<String?> itemnamelong;
//   final Value<String?> itemnameshort;
//   final Value<String?> skucode;
//   final Value<String?> subcategory;
//   final Value<double?> sellprice;
//   final Value<double?> mrpprice;
//   final Value<double?> specialprice;
//   final Value<String?> maxdiscount;
//   final Value<double?> taxrate;
//   final Value<String?> snapdatetime;
//   final Value<String?> purchasedate;
//   final Value<String?> createdateTime;
//   final Value<String?> updatedDatetime;
//   final Value<String?> createdUserID;
//   final Value<String?> updateduserid;
//   final Value<String?> lastupdateIp;
//   final Value<double?> uPackSize;
//   final Value<int?> uTINSPERBOX;
//   final Value<double?> uSpecificGravity;
//   final Value<String?> uPackSizeUom;
//   const DriftItemMasterCompanion({
//     this.IMid = const Value.absent(),
//     this.itemname = const Value.absent(),
//     this.itemcode = const Value.absent(),
//     this.whsCode = const Value.absent(),
//     this.serialbatch = const Value.absent(),
//     this.quantity = const Value.absent(),
//     this.maximumQty = const Value.absent(),
//     this.minimumQty = const Value.absent(),
//     this.displayQty = const Value.absent(),
//     this.searchString = const Value.absent(),
//     this.category = const Value.absent(),
//     this.liter = const Value.absent(),
//     this.category1 = const Value.absent(),
//     this.weight = const Value.absent(),
//     this.hsnsac = const Value.absent(),
//     this.isActive = const Value.absent(),
//     this.isfreeby = const Value.absent(),
//     this.isinventory = const Value.absent(),
//     this.issellpricebyscrbat = const Value.absent(),
//     this.itemnamelong = const Value.absent(),
//     this.itemnameshort = const Value.absent(),
//     this.skucode = const Value.absent(),
//     this.subcategory = const Value.absent(),
//     this.sellprice = const Value.absent(),
//     this.mrpprice = const Value.absent(),
//     this.specialprice = const Value.absent(),
//     this.maxdiscount = const Value.absent(),
//     this.taxrate = const Value.absent(),
//     this.snapdatetime = const Value.absent(),
//     this.purchasedate = const Value.absent(),
//     this.createdateTime = const Value.absent(),
//     this.updatedDatetime = const Value.absent(),
//     this.createdUserID = const Value.absent(),
//     this.updateduserid = const Value.absent(),
//     this.lastupdateIp = const Value.absent(),
//     this.uPackSize = const Value.absent(),
//     this.uTINSPERBOX = const Value.absent(),
//     this.uSpecificGravity = const Value.absent(),
//     this.uPackSizeUom = const Value.absent(),
//   });
//   DriftItemMasterCompanion.insert({
//     this.IMid = const Value.absent(),
//     this.itemname = const Value.absent(),
//     this.itemcode = const Value.absent(),
//     this.whsCode = const Value.absent(),
//     this.serialbatch = const Value.absent(),
//     this.quantity = const Value.absent(),
//     this.maximumQty = const Value.absent(),
//     this.minimumQty = const Value.absent(),
//     this.displayQty = const Value.absent(),
//     this.searchString = const Value.absent(),
//     this.category = const Value.absent(),
//     this.liter = const Value.absent(),
//     this.category1 = const Value.absent(),
//     this.weight = const Value.absent(),
//     this.hsnsac = const Value.absent(),
//     this.isActive = const Value.absent(),
//     this.isfreeby = const Value.absent(),
//     this.isinventory = const Value.absent(),
//     this.issellpricebyscrbat = const Value.absent(),
//     this.itemnamelong = const Value.absent(),
//     this.itemnameshort = const Value.absent(),
//     this.skucode = const Value.absent(),
//     this.subcategory = const Value.absent(),
//     this.sellprice = const Value.absent(),
//     this.mrpprice = const Value.absent(),
//     this.specialprice = const Value.absent(),
//     this.maxdiscount = const Value.absent(),
//     this.taxrate = const Value.absent(),
//     this.snapdatetime = const Value.absent(),
//     this.purchasedate = const Value.absent(),
//     this.createdateTime = const Value.absent(),
//     this.updatedDatetime = const Value.absent(),
//     this.createdUserID = const Value.absent(),
//     this.updateduserid = const Value.absent(),
//     this.lastupdateIp = const Value.absent(),
//     this.uPackSize = const Value.absent(),
//     this.uTINSPERBOX = const Value.absent(),
//     this.uSpecificGravity = const Value.absent(),
//     this.uPackSizeUom = const Value.absent(),
//   });
//   static Insertable<DriftItemMasterData> custom({
//     Expression<int>? IMid,
//     Expression<String>? itemname,
//     Expression<String>? itemcode,
//     Expression<String>? whsCode,
//     Expression<String>? serialbatch,
//     Expression<int>? quantity,
//     Expression<String>? maximumQty,
//     Expression<String>? minimumQty,
//     Expression<String>? displayQty,
//     Expression<String>? searchString,
//     Expression<String>? category,
//     Expression<double>? liter,
//     Expression<String>? category1,
//     Expression<double>? weight,
//     Expression<String>? hsnsac,
//     Expression<String>? isActive,
//     Expression<String>? isfreeby,
//     Expression<String>? isinventory,
//     Expression<String>? issellpricebyscrbat,
//     Expression<String>? itemnamelong,
//     Expression<String>? itemnameshort,
//     Expression<String>? skucode,
//     Expression<String>? subcategory,
//     Expression<double>? sellprice,
//     Expression<double>? mrpprice,
//     Expression<double>? specialprice,
//     Expression<String>? maxdiscount,
//     Expression<double>? taxrate,
//     Expression<String>? snapdatetime,
//     Expression<String>? purchasedate,
//     Expression<String>? createdateTime,
//     Expression<String>? updatedDatetime,
//     Expression<String>? createdUserID,
//     Expression<String>? updateduserid,
//     Expression<String>? lastupdateIp,
//     Expression<double>? uPackSize,
//     Expression<int>? uTINSPERBOX,
//     Expression<double>? uSpecificGravity,
//     Expression<String>? uPackSizeUom,
//   }) {
//     return RawValuesInsertable({
//       if (IMid != null) 'i_mid': IMid,
//       if (itemname != null) 'itemname': itemname,
//       if (itemcode != null) 'itemcode': itemcode,
//       if (whsCode != null) 'WhsCode': whsCode,
//       if (serialbatch != null) 'serialbatch': serialbatch,
//       if (quantity != null) 'quantity': quantity,
//       if (maximumQty != null) 'maximumQty': maximumQty,
//       if (minimumQty != null) 'minimumQty': minimumQty,
//       if (displayQty != null) 'displayQty': displayQty,
//       if (searchString != null) 'searchString': searchString,
//       if (category != null) 'category': category,
//       if (liter != null) 'liter': liter,
//       if (category1 != null) 'category1': category1,
//       if (weight != null) 'weight': weight,
//       if (hsnsac != null) 'hsnsac': hsnsac,
//       if (isActive != null) 'isActive': isActive,
//       if (isfreeby != null) 'isfreeby': isfreeby,
//       if (isinventory != null) 'isinventory': isinventory,
//       if (issellpricebyscrbat != null)
//         'issellpricebyscrbat': issellpricebyscrbat,
//       if (itemnamelong != null) 'itemnamelong': itemnamelong,
//       if (itemnameshort != null) 'itemnameshort': itemnameshort,
//       if (skucode != null) 'skucode': skucode,
//       if (subcategory != null) 'subcategory': subcategory,
//       if (sellprice != null) 'sellprice': sellprice,
//       if (mrpprice != null) 'mrpprice': mrpprice,
//       if (specialprice != null) 'specialprice': specialprice,
//       if (maxdiscount != null) 'maxdiscount': maxdiscount,
//       if (taxrate != null) 'taxrate': taxrate,
//       if (snapdatetime != null) 'snapdatetime': snapdatetime,
//       if (purchasedate != null) 'purchasedate': purchasedate,
//       if (createdateTime != null) 'createdateTime': createdateTime,
//       if (updatedDatetime != null) 'updatedDatetime': updatedDatetime,
//       if (createdUserID != null) 'createdUserID': createdUserID,
//       if (updateduserid != null) 'updateduserid': updateduserid,
//       if (lastupdateIp != null) 'lastupdateIp': lastupdateIp,
//       if (uPackSize != null) 'U_Pack_Size': uPackSize,
//       if (uTINSPERBOX != null) 'U_TINS_PER_BOX': uTINSPERBOX,
//       if (uSpecificGravity != null) 'U_Specific_Gravity': uSpecificGravity,
//       if (uPackSizeUom != null) 'U_Pack_Size_uom': uPackSizeUom,
//     });
//   }

//   DriftItemMasterCompanion copyWith(
//       {Value<int>? IMid,
//       Value<String?>? itemname,
//       Value<String?>? itemcode,
//       Value<String?>? whsCode,
//       Value<String?>? serialbatch,
//       Value<int?>? quantity,
//       Value<String?>? maximumQty,
//       Value<String?>? minimumQty,
//       Value<String?>? displayQty,
//       Value<String?>? searchString,
//       Value<String?>? category,
//       Value<double?>? liter,
//       Value<String?>? category1,
//       Value<double?>? weight,
//       Value<String?>? hsnsac,
//       Value<String?>? isActive,
//       Value<String?>? isfreeby,
//       Value<String?>? isinventory,
//       Value<String?>? issellpricebyscrbat,
//       Value<String?>? itemnamelong,
//       Value<String?>? itemnameshort,
//       Value<String?>? skucode,
//       Value<String?>? subcategory,
//       Value<double?>? sellprice,
//       Value<double?>? mrpprice,
//       Value<double?>? specialprice,
//       Value<String?>? maxdiscount,
//       Value<double?>? taxrate,
//       Value<String?>? snapdatetime,
//       Value<String?>? purchasedate,
//       Value<String?>? createdateTime,
//       Value<String?>? updatedDatetime,
//       Value<String?>? createdUserID,
//       Value<String?>? updateduserid,
//       Value<String?>? lastupdateIp,
//       Value<double?>? uPackSize,
//       Value<int?>? uTINSPERBOX,
//       Value<double?>? uSpecificGravity,
//       Value<String?>? uPackSizeUom}) {
//     return DriftItemMasterCompanion(
//       IMid: IMid ?? this.IMid,
//       itemname: itemname ?? this.itemname,
//       itemcode: itemcode ?? this.itemcode,
//       whsCode: whsCode ?? this.whsCode,
//       serialbatch: serialbatch ?? this.serialbatch,
//       quantity: quantity ?? this.quantity,
//       maximumQty: maximumQty ?? this.maximumQty,
//       minimumQty: minimumQty ?? this.minimumQty,
//       displayQty: displayQty ?? this.displayQty,
//       searchString: searchString ?? this.searchString,
//       category: category ?? this.category,
//       liter: liter ?? this.liter,
//       category1: category1 ?? this.category1,
//       weight: weight ?? this.weight,
//       hsnsac: hsnsac ?? this.hsnsac,
//       isActive: isActive ?? this.isActive,
//       isfreeby: isfreeby ?? this.isfreeby,
//       isinventory: isinventory ?? this.isinventory,
//       issellpricebyscrbat: issellpricebyscrbat ?? this.issellpricebyscrbat,
//       itemnamelong: itemnamelong ?? this.itemnamelong,
//       itemnameshort: itemnameshort ?? this.itemnameshort,
//       skucode: skucode ?? this.skucode,
//       subcategory: subcategory ?? this.subcategory,
//       sellprice: sellprice ?? this.sellprice,
//       mrpprice: mrpprice ?? this.mrpprice,
//       specialprice: specialprice ?? this.specialprice,
//       maxdiscount: maxdiscount ?? this.maxdiscount,
//       taxrate: taxrate ?? this.taxrate,
//       snapdatetime: snapdatetime ?? this.snapdatetime,
//       purchasedate: purchasedate ?? this.purchasedate,
//       createdateTime: createdateTime ?? this.createdateTime,
//       updatedDatetime: updatedDatetime ?? this.updatedDatetime,
//       createdUserID: createdUserID ?? this.createdUserID,
//       updateduserid: updateduserid ?? this.updateduserid,
//       lastupdateIp: lastupdateIp ?? this.lastupdateIp,
//       uPackSize: uPackSize ?? this.uPackSize,
//       uTINSPERBOX: uTINSPERBOX ?? this.uTINSPERBOX,
//       uSpecificGravity: uSpecificGravity ?? this.uSpecificGravity,
//       uPackSizeUom: uPackSizeUom ?? this.uPackSizeUom,
//     );
//   }

//   @override
//   Map<String, Expression> toColumns(bool nullToAbsent) {
//     final map = <String, Expression>{};
//     if (IMid.present) {
//       map['i_mid'] = Variable<int>(IMid.value);
//     }
//     if (itemname.present) {
//       map['itemname'] = Variable<String>(itemname.value);
//     }
//     if (itemcode.present) {
//       map['itemcode'] = Variable<String>(itemcode.value);
//     }
//     if (whsCode.present) {
//       map['WhsCode'] = Variable<String>(whsCode.value);
//     }
//     if (serialbatch.present) {
//       map['serialbatch'] = Variable<String>(serialbatch.value);
//     }
//     if (quantity.present) {
//       map['quantity'] = Variable<int>(quantity.value);
//     }
//     if (maximumQty.present) {
//       map['maximumQty'] = Variable<String>(maximumQty.value);
//     }
//     if (minimumQty.present) {
//       map['minimumQty'] = Variable<String>(minimumQty.value);
//     }
//     if (displayQty.present) {
//       map['displayQty'] = Variable<String>(displayQty.value);
//     }
//     if (searchString.present) {
//       map['searchString'] = Variable<String>(searchString.value);
//     }
//     if (category.present) {
//       map['category'] = Variable<String>(category.value);
//     }
//     if (liter.present) {
//       map['liter'] = Variable<double>(liter.value);
//     }
//     if (category1.present) {
//       map['category1'] = Variable<String>(category1.value);
//     }
//     if (weight.present) {
//       map['weight'] = Variable<double>(weight.value);
//     }
//     if (hsnsac.present) {
//       map['hsnsac'] = Variable<String>(hsnsac.value);
//     }
//     if (isActive.present) {
//       map['isActive'] = Variable<String>(isActive.value);
//     }
//     if (isfreeby.present) {
//       map['isfreeby'] = Variable<String>(isfreeby.value);
//     }
//     if (isinventory.present) {
//       map['isinventory'] = Variable<String>(isinventory.value);
//     }
//     if (issellpricebyscrbat.present) {
//       map['issellpricebyscrbat'] = Variable<String>(issellpricebyscrbat.value);
//     }
//     if (itemnamelong.present) {
//       map['itemnamelong'] = Variable<String>(itemnamelong.value);
//     }
//     if (itemnameshort.present) {
//       map['itemnameshort'] = Variable<String>(itemnameshort.value);
//     }
//     if (skucode.present) {
//       map['skucode'] = Variable<String>(skucode.value);
//     }
//     if (subcategory.present) {
//       map['subcategory'] = Variable<String>(subcategory.value);
//     }
//     if (sellprice.present) {
//       map['sellprice'] = Variable<double>(sellprice.value);
//     }
//     if (mrpprice.present) {
//       map['mrpprice'] = Variable<double>(mrpprice.value);
//     }
//     if (specialprice.present) {
//       map['specialprice'] = Variable<double>(specialprice.value);
//     }
//     if (maxdiscount.present) {
//       map['maxdiscount'] = Variable<String>(maxdiscount.value);
//     }
//     if (taxrate.present) {
//       map['taxrate'] = Variable<double>(taxrate.value);
//     }
//     if (snapdatetime.present) {
//       map['snapdatetime'] = Variable<String>(snapdatetime.value);
//     }
//     if (purchasedate.present) {
//       map['purchasedate'] = Variable<String>(purchasedate.value);
//     }
//     if (createdateTime.present) {
//       map['createdateTime'] = Variable<String>(createdateTime.value);
//     }
//     if (updatedDatetime.present) {
//       map['updatedDatetime'] = Variable<String>(updatedDatetime.value);
//     }
//     if (createdUserID.present) {
//       map['createdUserID'] = Variable<String>(createdUserID.value);
//     }
//     if (updateduserid.present) {
//       map['updateduserid'] = Variable<String>(updateduserid.value);
//     }
//     if (lastupdateIp.present) {
//       map['lastupdateIp'] = Variable<String>(lastupdateIp.value);
//     }
//     if (uPackSize.present) {
//       map['U_Pack_Size'] = Variable<double>(uPackSize.value);
//     }
//     if (uTINSPERBOX.present) {
//       map['U_TINS_PER_BOX'] = Variable<int>(uTINSPERBOX.value);
//     }
//     if (uSpecificGravity.present) {
//       map['U_Specific_Gravity'] = Variable<double>(uSpecificGravity.value);
//     }
//     if (uPackSizeUom.present) {
//       map['U_Pack_Size_uom'] = Variable<String>(uPackSizeUom.value);
//     }
//     return map;
//   }

//   @override
//   String toString() {
//     return (StringBuffer('DriftItemMasterCompanion(')
//           ..write('IMid: $IMid, ')
//           ..write('itemname: $itemname, ')
//           ..write('itemcode: $itemcode, ')
//           ..write('whsCode: $whsCode, ')
//           ..write('serialbatch: $serialbatch, ')
//           ..write('quantity: $quantity, ')
//           ..write('maximumQty: $maximumQty, ')
//           ..write('minimumQty: $minimumQty, ')
//           ..write('displayQty: $displayQty, ')
//           ..write('searchString: $searchString, ')
//           ..write('category: $category, ')
//           ..write('liter: $liter, ')
//           ..write('category1: $category1, ')
//           ..write('weight: $weight, ')
//           ..write('hsnsac: $hsnsac, ')
//           ..write('isActive: $isActive, ')
//           ..write('isfreeby: $isfreeby, ')
//           ..write('isinventory: $isinventory, ')
//           ..write('issellpricebyscrbat: $issellpricebyscrbat, ')
//           ..write('itemnamelong: $itemnamelong, ')
//           ..write('itemnameshort: $itemnameshort, ')
//           ..write('skucode: $skucode, ')
//           ..write('subcategory: $subcategory, ')
//           ..write('sellprice: $sellprice, ')
//           ..write('mrpprice: $mrpprice, ')
//           ..write('specialprice: $specialprice, ')
//           ..write('maxdiscount: $maxdiscount, ')
//           ..write('taxrate: $taxrate, ')
//           ..write('snapdatetime: $snapdatetime, ')
//           ..write('purchasedate: $purchasedate, ')
//           ..write('createdateTime: $createdateTime, ')
//           ..write('updatedDatetime: $updatedDatetime, ')
//           ..write('createdUserID: $createdUserID, ')
//           ..write('updateduserid: $updateduserid, ')
//           ..write('lastupdateIp: $lastupdateIp, ')
//           ..write('uPackSize: $uPackSize, ')
//           ..write('uTINSPERBOX: $uTINSPERBOX, ')
//           ..write('uSpecificGravity: $uSpecificGravity, ')
//           ..write('uPackSizeUom: $uPackSizeUom')
//           ..write(')'))
//         .toString();
//   }
// }

// class $DriftProductMasterTable extends DriftProductMaster
//     with TableInfo<$DriftProductMasterTable, DriftProductMasterData> {
//   @override
//   final GeneratedDatabase attachedDatabase;
//   final String? _alias;
//   $DriftProductMasterTable(this.attachedDatabase, [this._alias]);
//   static const VerificationMeta _IMidMeta = const VerificationMeta('IMid');
//   @override
//   late final GeneratedColumn<int> IMid = GeneratedColumn<int>(
//       'i_mid', aliasedName, false,
//       hasAutoIncrement: true,
//       type: DriftSqlType.int,
//       requiredDuringInsert: false,
//       defaultConstraints:
//           GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
//   static const VerificationMeta _itemnameMeta =
//       const VerificationMeta('itemname');
//   @override
//   late final GeneratedColumn<String> itemname = GeneratedColumn<String>(
//       'itemname', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _itemcodeMeta =
//       const VerificationMeta('itemcode');
//   @override
//   late final GeneratedColumn<String> itemcode = GeneratedColumn<String>(
//       'itemcode', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _maximumQtyMeta =
//       const VerificationMeta('maximumQty');
//   @override
//   late final GeneratedColumn<String> maximumQty = GeneratedColumn<String>(
//       'maximumQty', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _minimumQtyMeta =
//       const VerificationMeta('minimumQty');
//   @override
//   late final GeneratedColumn<String> minimumQty = GeneratedColumn<String>(
//       'minimumQty', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _displayQtyMeta =
//       const VerificationMeta('displayQty');
//   @override
//   late final GeneratedColumn<String> displayQty = GeneratedColumn<String>(
//       'displayQty', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _searchStringMeta =
//       const VerificationMeta('searchString');
//   @override
//   late final GeneratedColumn<String> searchString = GeneratedColumn<String>(
//       'searchString', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _literMeta = const VerificationMeta('liter');
//   @override
//   late final GeneratedColumn<double> liter = GeneratedColumn<double>(
//       'liter', aliasedName, true,
//       type: DriftSqlType.double, requiredDuringInsert: false);
//   static const VerificationMeta _categoryMeta =
//       const VerificationMeta('category');
//   @override
//   late final GeneratedColumn<String> category = GeneratedColumn<String>(
//       'category', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _category1Meta =
//       const VerificationMeta('category1');
//   @override
//   late final GeneratedColumn<String> category1 = GeneratedColumn<String>(
//       'category1', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _brandMeta = const VerificationMeta('brand');
//   @override
//   late final GeneratedColumn<String> brand = GeneratedColumn<String>(
//       'brand', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _brand1Meta = const VerificationMeta('brand1');
//   @override
//   late final GeneratedColumn<String> brand1 = GeneratedColumn<String>(
//       'brand1', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _weightMeta = const VerificationMeta('weight');
//   @override
//   late final GeneratedColumn<double> weight = GeneratedColumn<double>(
//       'weight', aliasedName, true,
//       type: DriftSqlType.double, requiredDuringInsert: false);
//   static const VerificationMeta _hsnsacMeta = const VerificationMeta('hsnsac');
//   @override
//   late final GeneratedColumn<String> hsnsac = GeneratedColumn<String>(
//       'hsnsac', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _isActiveMeta =
//       const VerificationMeta('isActive');
//   @override
//   late final GeneratedColumn<String> isActive = GeneratedColumn<String>(
//       'isActive', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _isfreebyMeta =
//       const VerificationMeta('isfreeby');
//   @override
//   late final GeneratedColumn<String> isfreeby = GeneratedColumn<String>(
//       'isfreeby', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _isinventoryMeta =
//       const VerificationMeta('isinventory');
//   @override
//   late final GeneratedColumn<String> isinventory = GeneratedColumn<String>(
//       'isinventory', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _issellpricebyscrbatMeta =
//       const VerificationMeta('issellpricebyscrbat');
//   @override
//   late final GeneratedColumn<String> issellpricebyscrbat =
//       GeneratedColumn<String>('issellpricebyscrbat', aliasedName, true,
//           type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _itemnamelongMeta =
//       const VerificationMeta('itemnamelong');
//   @override
//   late final GeneratedColumn<String> itemnamelong = GeneratedColumn<String>(
//       'itemnamelong', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _itemnameshortMeta =
//       const VerificationMeta('itemnameshort');
//   @override
//   late final GeneratedColumn<String> itemnameshort = GeneratedColumn<String>(
//       'itemnameshort', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _skucodeMeta =
//       const VerificationMeta('skucode');
//   @override
//   late final GeneratedColumn<String> skucode = GeneratedColumn<String>(
//       'skucode', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _subcategoryMeta =
//       const VerificationMeta('subcategory');
//   @override
//   late final GeneratedColumn<String> subcategory = GeneratedColumn<String>(
//       'subcategory', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _sellpriceMeta =
//       const VerificationMeta('sellprice');
//   @override
//   late final GeneratedColumn<double> sellprice = GeneratedColumn<double>(
//       'sellprice', aliasedName, true,
//       type: DriftSqlType.double, requiredDuringInsert: false);
//   static const VerificationMeta _mrppriceMeta =
//       const VerificationMeta('mrpprice');
//   @override
//   late final GeneratedColumn<double> mrpprice = GeneratedColumn<double>(
//       'mrpprice', aliasedName, true,
//       type: DriftSqlType.double, requiredDuringInsert: false);
//   static const VerificationMeta _specialpriceMeta =
//       const VerificationMeta('specialprice');
//   @override
//   late final GeneratedColumn<double> specialprice = GeneratedColumn<double>(
//       'specialprice', aliasedName, true,
//       type: DriftSqlType.double, requiredDuringInsert: false);
//   static const VerificationMeta _maxdiscountMeta =
//       const VerificationMeta('maxdiscount');
//   @override
//   late final GeneratedColumn<String> maxdiscount = GeneratedColumn<String>(
//       'maxdiscount', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _taxrateMeta =
//       const VerificationMeta('taxrate');
//   @override
//   late final GeneratedColumn<double> taxrate = GeneratedColumn<double>(
//       'taxrate', aliasedName, true,
//       type: DriftSqlType.double, requiredDuringInsert: false);
//   static const VerificationMeta _snapdatetimeMeta =
//       const VerificationMeta('snapdatetime');
//   @override
//   late final GeneratedColumn<String> snapdatetime = GeneratedColumn<String>(
//       'snapdatetime', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _purchasedateMeta =
//       const VerificationMeta('purchasedate');
//   @override
//   late final GeneratedColumn<String> purchasedate = GeneratedColumn<String>(
//       'purchasedate', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _createdateTimeMeta =
//       const VerificationMeta('createdateTime');
//   @override
//   late final GeneratedColumn<String> createdateTime = GeneratedColumn<String>(
//       'createdateTime', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _updatedDatetimeMeta =
//       const VerificationMeta('updatedDatetime');
//   @override
//   late final GeneratedColumn<String> updatedDatetime = GeneratedColumn<String>(
//       'updatedDatetime', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _createdUserIDMeta =
//       const VerificationMeta('createdUserID');
//   @override
//   late final GeneratedColumn<String> createdUserID = GeneratedColumn<String>(
//       'createdUserID', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _updateduseridMeta =
//       const VerificationMeta('updateduserid');
//   @override
//   late final GeneratedColumn<String> updateduserid = GeneratedColumn<String>(
//       'updateduserid', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _lastupdateIpMeta =
//       const VerificationMeta('lastupdateIp');
//   @override
//   late final GeneratedColumn<String> lastupdateIp = GeneratedColumn<String>(
//       'lastupdateIp', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   static const VerificationMeta _uPackSizeMeta =
//       const VerificationMeta('uPackSize');
//   @override
//   late final GeneratedColumn<double> uPackSize = GeneratedColumn<double>(
//       'U_Pack_Size', aliasedName, true,
//       type: DriftSqlType.double, requiredDuringInsert: false);
//   static const VerificationMeta _uTINSPERBOXMeta =
//       const VerificationMeta('uTINSPERBOX');
//   @override
//   late final GeneratedColumn<int> uTINSPERBOX = GeneratedColumn<int>(
//       'U_TINS_PER_BOX', aliasedName, true,
//       type: DriftSqlType.int, requiredDuringInsert: false);
//   static const VerificationMeta _uSpecificGravityMeta =
//       const VerificationMeta('uSpecificGravity');
//   @override
//   late final GeneratedColumn<double> uSpecificGravity = GeneratedColumn<double>(
//       'U_Specific_Gravity', aliasedName, true,
//       type: DriftSqlType.double, requiredDuringInsert: false);
//   static const VerificationMeta _uPackSizeUomMeta =
//       const VerificationMeta('uPackSizeUom');
//   @override
//   late final GeneratedColumn<String> uPackSizeUom = GeneratedColumn<String>(
//       'U_Pack_Size_uom', aliasedName, true,
//       type: DriftSqlType.string, requiredDuringInsert: false);
//   @override
//   List<GeneratedColumn> get $columns => [
//         IMid,
//         itemname,
//         itemcode,
//         maximumQty,
//         minimumQty,
//         displayQty,
//         searchString,
//         liter,
//         category,
//         category1,
//         brand,
//         brand1,
//         weight,
//         hsnsac,
//         isActive,
//         isfreeby,
//         isinventory,
//         issellpricebyscrbat,
//         itemnamelong,
//         itemnameshort,
//         skucode,
//         subcategory,
//         sellprice,
//         mrpprice,
//         specialprice,
//         maxdiscount,
//         taxrate,
//         snapdatetime,
//         purchasedate,
//         createdateTime,
//         updatedDatetime,
//         createdUserID,
//         updateduserid,
//         lastupdateIp,
//         uPackSize,
//         uTINSPERBOX,
//         uSpecificGravity,
//         uPackSizeUom
//       ];
//   @override
//   String get aliasedName => _alias ?? actualTableName;
//   @override
//   String get actualTableName => $name;
//   static const String $name = 'productmaster';
//   @override
//   VerificationContext validateIntegrity(
//       Insertable<DriftProductMasterData> instance,
//       {bool isInserting = false}) {
//     final context = VerificationContext();
//     final data = instance.toColumns(true);
//     if (data.containsKey('i_mid')) {
//       context.handle(
//           _IMidMeta, IMid.isAcceptableOrUnknown(data['i_mid']!, _IMidMeta));
//     }
//     if (data.containsKey('itemname')) {
//       context.handle(_itemnameMeta,
//           itemname.isAcceptableOrUnknown(data['itemname']!, _itemnameMeta));
//     }
//     if (data.containsKey('itemcode')) {
//       context.handle(_itemcodeMeta,
//           itemcode.isAcceptableOrUnknown(data['itemcode']!, _itemcodeMeta));
//     }
//     if (data.containsKey('maximumQty')) {
//       context.handle(
//           _maximumQtyMeta,
//           maximumQty.isAcceptableOrUnknown(
//               data['maximumQty']!, _maximumQtyMeta));
//     }
//     if (data.containsKey('minimumQty')) {
//       context.handle(
//           _minimumQtyMeta,
//           minimumQty.isAcceptableOrUnknown(
//               data['minimumQty']!, _minimumQtyMeta));
//     }
//     if (data.containsKey('displayQty')) {
//       context.handle(
//           _displayQtyMeta,
//           displayQty.isAcceptableOrUnknown(
//               data['displayQty']!, _displayQtyMeta));
//     }
//     if (data.containsKey('searchString')) {
//       context.handle(
//           _searchStringMeta,
//           searchString.isAcceptableOrUnknown(
//               data['searchString']!, _searchStringMeta));
//     }
//     if (data.containsKey('liter')) {
//       context.handle(
//           _literMeta, liter.isAcceptableOrUnknown(data['liter']!, _literMeta));
//     }
//     if (data.containsKey('category')) {
//       context.handle(_categoryMeta,
//           category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
//     }
//     if (data.containsKey('category1')) {
//       context.handle(_category1Meta,
//           category1.isAcceptableOrUnknown(data['category1']!, _category1Meta));
//     }
//     if (data.containsKey('brand')) {
//       context.handle(
//           _brandMeta, brand.isAcceptableOrUnknown(data['brand']!, _brandMeta));
//     }
//     if (data.containsKey('brand1')) {
//       context.handle(_brand1Meta,
//           brand1.isAcceptableOrUnknown(data['brand1']!, _brand1Meta));
//     }
//     if (data.containsKey('weight')) {
//       context.handle(_weightMeta,
//           weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
//     }
//     if (data.containsKey('hsnsac')) {
//       context.handle(_hsnsacMeta,
//           hsnsac.isAcceptableOrUnknown(data['hsnsac']!, _hsnsacMeta));
//     }
//     if (data.containsKey('isActive')) {
//       context.handle(_isActiveMeta,
//           isActive.isAcceptableOrUnknown(data['isActive']!, _isActiveMeta));
//     }
//     if (data.containsKey('isfreeby')) {
//       context.handle(_isfreebyMeta,
//           isfreeby.isAcceptableOrUnknown(data['isfreeby']!, _isfreebyMeta));
//     }
//     if (data.containsKey('isinventory')) {
//       context.handle(
//           _isinventoryMeta,
//           isinventory.isAcceptableOrUnknown(
//               data['isinventory']!, _isinventoryMeta));
//     }
//     if (data.containsKey('issellpricebyscrbat')) {
//       context.handle(
//           _issellpricebyscrbatMeta,
//           issellpricebyscrbat.isAcceptableOrUnknown(
//               data['issellpricebyscrbat']!, _issellpricebyscrbatMeta));
//     }
//     if (data.containsKey('itemnamelong')) {
//       context.handle(
//           _itemnamelongMeta,
//           itemnamelong.isAcceptableOrUnknown(
//               data['itemnamelong']!, _itemnamelongMeta));
//     }
//     if (data.containsKey('itemnameshort')) {
//       context.handle(
//           _itemnameshortMeta,
//           itemnameshort.isAcceptableOrUnknown(
//               data['itemnameshort']!, _itemnameshortMeta));
//     }
//     if (data.containsKey('skucode')) {
//       context.handle(_skucodeMeta,
//           skucode.isAcceptableOrUnknown(data['skucode']!, _skucodeMeta));
//     }
//     if (data.containsKey('subcategory')) {
//       context.handle(
//           _subcategoryMeta,
//           subcategory.isAcceptableOrUnknown(
//               data['subcategory']!, _subcategoryMeta));
//     }
//     if (data.containsKey('sellprice')) {
//       context.handle(_sellpriceMeta,
//           sellprice.isAcceptableOrUnknown(data['sellprice']!, _sellpriceMeta));
//     }
//     if (data.containsKey('mrpprice')) {
//       context.handle(_mrppriceMeta,
//           mrpprice.isAcceptableOrUnknown(data['mrpprice']!, _mrppriceMeta));
//     }
//     if (data.containsKey('specialprice')) {
//       context.handle(
//           _specialpriceMeta,
//           specialprice.isAcceptableOrUnknown(
//               data['specialprice']!, _specialpriceMeta));
//     }
//     if (data.containsKey('maxdiscount')) {
//       context.handle(
//           _maxdiscountMeta,
//           maxdiscount.isAcceptableOrUnknown(
//               data['maxdiscount']!, _maxdiscountMeta));
//     }
//     if (data.containsKey('taxrate')) {
//       context.handle(_taxrateMeta,
//           taxrate.isAcceptableOrUnknown(data['taxrate']!, _taxrateMeta));
//     }
//     if (data.containsKey('snapdatetime')) {
//       context.handle(
//           _snapdatetimeMeta,
//           snapdatetime.isAcceptableOrUnknown(
//               data['snapdatetime']!, _snapdatetimeMeta));
//     }
//     if (data.containsKey('purchasedate')) {
//       context.handle(
//           _purchasedateMeta,
//           purchasedate.isAcceptableOrUnknown(
//               data['purchasedate']!, _purchasedateMeta));
//     }
//     if (data.containsKey('createdateTime')) {
//       context.handle(
//           _createdateTimeMeta,
//           createdateTime.isAcceptableOrUnknown(
//               data['createdateTime']!, _createdateTimeMeta));
//     }
//     if (data.containsKey('updatedDatetime')) {
//       context.handle(
//           _updatedDatetimeMeta,
//           updatedDatetime.isAcceptableOrUnknown(
//               data['updatedDatetime']!, _updatedDatetimeMeta));
//     }
//     if (data.containsKey('createdUserID')) {
//       context.handle(
//           _createdUserIDMeta,
//           createdUserID.isAcceptableOrUnknown(
//               data['createdUserID']!, _createdUserIDMeta));
//     }
//     if (data.containsKey('updateduserid')) {
//       context.handle(
//           _updateduseridMeta,
//           updateduserid.isAcceptableOrUnknown(
//               data['updateduserid']!, _updateduseridMeta));
//     }
//     if (data.containsKey('lastupdateIp')) {
//       context.handle(
//           _lastupdateIpMeta,
//           lastupdateIp.isAcceptableOrUnknown(
//               data['lastupdateIp']!, _lastupdateIpMeta));
//     }
//     if (data.containsKey('U_Pack_Size')) {
//       context.handle(
//           _uPackSizeMeta,
//           uPackSize.isAcceptableOrUnknown(
//               data['U_Pack_Size']!, _uPackSizeMeta));
//     }
//     if (data.containsKey('U_TINS_PER_BOX')) {
//       context.handle(
//           _uTINSPERBOXMeta,
//           uTINSPERBOX.isAcceptableOrUnknown(
//               data['U_TINS_PER_BOX']!, _uTINSPERBOXMeta));
//     }
//     if (data.containsKey('U_Specific_Gravity')) {
//       context.handle(
//           _uSpecificGravityMeta,
//           uSpecificGravity.isAcceptableOrUnknown(
//               data['U_Specific_Gravity']!, _uSpecificGravityMeta));
//     }
//     if (data.containsKey('U_Pack_Size_uom')) {
//       context.handle(
//           _uPackSizeUomMeta,
//           uPackSizeUom.isAcceptableOrUnknown(
//               data['U_Pack_Size_uom']!, _uPackSizeUomMeta));
//     }
//     return context;
//   }

//   @override
//   Set<GeneratedColumn> get $primaryKey => {IMid};
//   @override
//   DriftProductMasterData map(Map<String, dynamic> data, {String? tablePrefix}) {
//     final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
//     return DriftProductMasterData(
//       IMid: attachedDatabase.typeMapping
//           .read(DriftSqlType.int, data['${effectivePrefix}i_mid'])!,
//       itemname: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}itemname']),
//       itemcode: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}itemcode']),
//       maximumQty: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}maximumQty']),
//       minimumQty: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}minimumQty']),
//       displayQty: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}displayQty']),
//       searchString: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}searchString']),
//       liter: attachedDatabase.typeMapping
//           .read(DriftSqlType.double, data['${effectivePrefix}liter']),
//       category: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}category']),
//       category1: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}category1']),
//       brand: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}brand']),
//       brand1: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}brand1']),
//       weight: attachedDatabase.typeMapping
//           .read(DriftSqlType.double, data['${effectivePrefix}weight']),
//       hsnsac: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}hsnsac']),
//       isActive: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}isActive']),
//       isfreeby: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}isfreeby']),
//       isinventory: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}isinventory']),
//       issellpricebyscrbat: attachedDatabase.typeMapping.read(
//           DriftSqlType.string, data['${effectivePrefix}issellpricebyscrbat']),
//       itemnamelong: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}itemnamelong']),
//       itemnameshort: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}itemnameshort']),
//       skucode: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}skucode']),
//       subcategory: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}subcategory']),
//       sellprice: attachedDatabase.typeMapping
//           .read(DriftSqlType.double, data['${effectivePrefix}sellprice']),
//       mrpprice: attachedDatabase.typeMapping
//           .read(DriftSqlType.double, data['${effectivePrefix}mrpprice']),
//       specialprice: attachedDatabase.typeMapping
//           .read(DriftSqlType.double, data['${effectivePrefix}specialprice']),
//       maxdiscount: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}maxdiscount']),
//       taxrate: attachedDatabase.typeMapping
//           .read(DriftSqlType.double, data['${effectivePrefix}taxrate']),
//       snapdatetime: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}snapdatetime']),
//       purchasedate: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}purchasedate']),
//       createdateTime: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}createdateTime']),
//       updatedDatetime: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}updatedDatetime']),
//       createdUserID: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}createdUserID']),
//       updateduserid: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}updateduserid']),
//       lastupdateIp: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}lastupdateIp']),
//       uPackSize: attachedDatabase.typeMapping
//           .read(DriftSqlType.double, data['${effectivePrefix}U_Pack_Size']),
//       uTINSPERBOX: attachedDatabase.typeMapping
//           .read(DriftSqlType.int, data['${effectivePrefix}U_TINS_PER_BOX']),
//       uSpecificGravity: attachedDatabase.typeMapping.read(
//           DriftSqlType.double, data['${effectivePrefix}U_Specific_Gravity']),
//       uPackSizeUom: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}U_Pack_Size_uom']),
//     );
//   }

//   @override
//   $DriftProductMasterTable createAlias(String alias) {
//     return $DriftProductMasterTable(attachedDatabase, alias);
//   }
// }

// class DriftProductMasterData extends DataClass
//     implements Insertable<DriftProductMasterData> {
//   final int IMid;
//   final String? itemname;
//   final String? itemcode;
//   final String? maximumQty;
//   final String? minimumQty;
//   final String? displayQty;
//   final String? searchString;
//   final double? liter;
//   final String? category;
//   final String? category1;
//   final String? brand;
//   final String? brand1;
//   final double? weight;
//   final String? hsnsac;
//   final String? isActive;
//   final String? isfreeby;
//   final String? isinventory;
//   final String? issellpricebyscrbat;
//   final String? itemnamelong;
//   final String? itemnameshort;
//   final String? skucode;
//   final String? subcategory;
//   final double? sellprice;
//   final double? mrpprice;
//   final double? specialprice;
//   final String? maxdiscount;
//   final double? taxrate;
//   final String? snapdatetime;
//   final String? purchasedate;
//   final String? createdateTime;
//   final String? updatedDatetime;
//   final String? createdUserID;
//   final String? updateduserid;
//   final String? lastupdateIp;
//   final double? uPackSize;
//   final int? uTINSPERBOX;
//   final double? uSpecificGravity;
//   final String? uPackSizeUom;
//   const DriftProductMasterData(
//       {required this.IMid,
//       this.itemname,
//       this.itemcode,
//       this.maximumQty,
//       this.minimumQty,
//       this.displayQty,
//       this.searchString,
//       this.liter,
//       this.category,
//       this.category1,
//       this.brand,
//       this.brand1,
//       this.weight,
//       this.hsnsac,
//       this.isActive,
//       this.isfreeby,
//       this.isinventory,
//       this.issellpricebyscrbat,
//       this.itemnamelong,
//       this.itemnameshort,
//       this.skucode,
//       this.subcategory,
//       this.sellprice,
//       this.mrpprice,
//       this.specialprice,
//       this.maxdiscount,
//       this.taxrate,
//       this.snapdatetime,
//       this.purchasedate,
//       this.createdateTime,
//       this.updatedDatetime,
//       this.createdUserID,
//       this.updateduserid,
//       this.lastupdateIp,
//       this.uPackSize,
//       this.uTINSPERBOX,
//       this.uSpecificGravity,
//       this.uPackSizeUom});
//   @override
//   Map<String, Expression> toColumns(bool nullToAbsent) {
//     final map = <String, Expression>{};
//     map['i_mid'] = Variable<int>(IMid);
//     if (!nullToAbsent || itemname != null) {
//       map['itemname'] = Variable<String>(itemname);
//     }
//     if (!nullToAbsent || itemcode != null) {
//       map['itemcode'] = Variable<String>(itemcode);
//     }
//     if (!nullToAbsent || maximumQty != null) {
//       map['maximumQty'] = Variable<String>(maximumQty);
//     }
//     if (!nullToAbsent || minimumQty != null) {
//       map['minimumQty'] = Variable<String>(minimumQty);
//     }
//     if (!nullToAbsent || displayQty != null) {
//       map['displayQty'] = Variable<String>(displayQty);
//     }
//     if (!nullToAbsent || searchString != null) {
//       map['searchString'] = Variable<String>(searchString);
//     }
//     if (!nullToAbsent || liter != null) {
//       map['liter'] = Variable<double>(liter);
//     }
//     if (!nullToAbsent || category != null) {
//       map['category'] = Variable<String>(category);
//     }
//     if (!nullToAbsent || category1 != null) {
//       map['category1'] = Variable<String>(category1);
//     }
//     if (!nullToAbsent || brand != null) {
//       map['brand'] = Variable<String>(brand);
//     }
//     if (!nullToAbsent || brand1 != null) {
//       map['brand1'] = Variable<String>(brand1);
//     }
//     if (!nullToAbsent || weight != null) {
//       map['weight'] = Variable<double>(weight);
//     }
//     if (!nullToAbsent || hsnsac != null) {
//       map['hsnsac'] = Variable<String>(hsnsac);
//     }
//     if (!nullToAbsent || isActive != null) {
//       map['isActive'] = Variable<String>(isActive);
//     }
//     if (!nullToAbsent || isfreeby != null) {
//       map['isfreeby'] = Variable<String>(isfreeby);
//     }
//     if (!nullToAbsent || isinventory != null) {
//       map['isinventory'] = Variable<String>(isinventory);
//     }
//     if (!nullToAbsent || issellpricebyscrbat != null) {
//       map['issellpricebyscrbat'] = Variable<String>(issellpricebyscrbat);
//     }
//     if (!nullToAbsent || itemnamelong != null) {
//       map['itemnamelong'] = Variable<String>(itemnamelong);
//     }
//     if (!nullToAbsent || itemnameshort != null) {
//       map['itemnameshort'] = Variable<String>(itemnameshort);
//     }
//     if (!nullToAbsent || skucode != null) {
//       map['skucode'] = Variable<String>(skucode);
//     }
//     if (!nullToAbsent || subcategory != null) {
//       map['subcategory'] = Variable<String>(subcategory);
//     }
//     if (!nullToAbsent || sellprice != null) {
//       map['sellprice'] = Variable<double>(sellprice);
//     }
//     if (!nullToAbsent || mrpprice != null) {
//       map['mrpprice'] = Variable<double>(mrpprice);
//     }
//     if (!nullToAbsent || specialprice != null) {
//       map['specialprice'] = Variable<double>(specialprice);
//     }
//     if (!nullToAbsent || maxdiscount != null) {
//       map['maxdiscount'] = Variable<String>(maxdiscount);
//     }
//     if (!nullToAbsent || taxrate != null) {
//       map['taxrate'] = Variable<double>(taxrate);
//     }
//     if (!nullToAbsent || snapdatetime != null) {
//       map['snapdatetime'] = Variable<String>(snapdatetime);
//     }
//     if (!nullToAbsent || purchasedate != null) {
//       map['purchasedate'] = Variable<String>(purchasedate);
//     }
//     if (!nullToAbsent || createdateTime != null) {
//       map['createdateTime'] = Variable<String>(createdateTime);
//     }
//     if (!nullToAbsent || updatedDatetime != null) {
//       map['updatedDatetime'] = Variable<String>(updatedDatetime);
//     }
//     if (!nullToAbsent || createdUserID != null) {
//       map['createdUserID'] = Variable<String>(createdUserID);
//     }
//     if (!nullToAbsent || updateduserid != null) {
//       map['updateduserid'] = Variable<String>(updateduserid);
//     }
//     if (!nullToAbsent || lastupdateIp != null) {
//       map['lastupdateIp'] = Variable<String>(lastupdateIp);
//     }
//     if (!nullToAbsent || uPackSize != null) {
//       map['U_Pack_Size'] = Variable<double>(uPackSize);
//     }
//     if (!nullToAbsent || uTINSPERBOX != null) {
//       map['U_TINS_PER_BOX'] = Variable<int>(uTINSPERBOX);
//     }
//     if (!nullToAbsent || uSpecificGravity != null) {
//       map['U_Specific_Gravity'] = Variable<double>(uSpecificGravity);
//     }
//     if (!nullToAbsent || uPackSizeUom != null) {
//       map['U_Pack_Size_uom'] = Variable<String>(uPackSizeUom);
//     }
//     return map;
//   }

//   DriftProductMasterCompanion toCompanion(bool nullToAbsent) {
//     return DriftProductMasterCompanion(
//       IMid: Value(IMid),
//       itemname: itemname == null && nullToAbsent
//           ? const Value.absent()
//           : Value(itemname),
//       itemcode: itemcode == null && nullToAbsent
//           ? const Value.absent()
//           : Value(itemcode),
//       maximumQty: maximumQty == null && nullToAbsent
//           ? const Value.absent()
//           : Value(maximumQty),
//       minimumQty: minimumQty == null && nullToAbsent
//           ? const Value.absent()
//           : Value(minimumQty),
//       displayQty: displayQty == null && nullToAbsent
//           ? const Value.absent()
//           : Value(displayQty),
//       searchString: searchString == null && nullToAbsent
//           ? const Value.absent()
//           : Value(searchString),
//       liter:
//           liter == null && nullToAbsent ? const Value.absent() : Value(liter),
//       category: category == null && nullToAbsent
//           ? const Value.absent()
//           : Value(category),
//       category1: category1 == null && nullToAbsent
//           ? const Value.absent()
//           : Value(category1),
//       brand:
//           brand == null && nullToAbsent ? const Value.absent() : Value(brand),
//       brand1:
//           brand1 == null && nullToAbsent ? const Value.absent() : Value(brand1),
//       weight:
//           weight == null && nullToAbsent ? const Value.absent() : Value(weight),
//       hsnsac:
//           hsnsac == null && nullToAbsent ? const Value.absent() : Value(hsnsac),
//       isActive: isActive == null && nullToAbsent
//           ? const Value.absent()
//           : Value(isActive),
//       isfreeby: isfreeby == null && nullToAbsent
//           ? const Value.absent()
//           : Value(isfreeby),
//       isinventory: isinventory == null && nullToAbsent
//           ? const Value.absent()
//           : Value(isinventory),
//       issellpricebyscrbat: issellpricebyscrbat == null && nullToAbsent
//           ? const Value.absent()
//           : Value(issellpricebyscrbat),
//       itemnamelong: itemnamelong == null && nullToAbsent
//           ? const Value.absent()
//           : Value(itemnamelong),
//       itemnameshort: itemnameshort == null && nullToAbsent
//           ? const Value.absent()
//           : Value(itemnameshort),
//       skucode: skucode == null && nullToAbsent
//           ? const Value.absent()
//           : Value(skucode),
//       subcategory: subcategory == null && nullToAbsent
//           ? const Value.absent()
//           : Value(subcategory),
//       sellprice: sellprice == null && nullToAbsent
//           ? const Value.absent()
//           : Value(sellprice),
//       mrpprice: mrpprice == null && nullToAbsent
//           ? const Value.absent()
//           : Value(mrpprice),
//       specialprice: specialprice == null && nullToAbsent
//           ? const Value.absent()
//           : Value(specialprice),
//       maxdiscount: maxdiscount == null && nullToAbsent
//           ? const Value.absent()
//           : Value(maxdiscount),
//       taxrate: taxrate == null && nullToAbsent
//           ? const Value.absent()
//           : Value(taxrate),
//       snapdatetime: snapdatetime == null && nullToAbsent
//           ? const Value.absent()
//           : Value(snapdatetime),
//       purchasedate: purchasedate == null && nullToAbsent
//           ? const Value.absent()
//           : Value(purchasedate),
//       createdateTime: createdateTime == null && nullToAbsent
//           ? const Value.absent()
//           : Value(createdateTime),
//       updatedDatetime: updatedDatetime == null && nullToAbsent
//           ? const Value.absent()
//           : Value(updatedDatetime),
//       createdUserID: createdUserID == null && nullToAbsent
//           ? const Value.absent()
//           : Value(createdUserID),
//       updateduserid: updateduserid == null && nullToAbsent
//           ? const Value.absent()
//           : Value(updateduserid),
//       lastupdateIp: lastupdateIp == null && nullToAbsent
//           ? const Value.absent()
//           : Value(lastupdateIp),
//       uPackSize: uPackSize == null && nullToAbsent
//           ? const Value.absent()
//           : Value(uPackSize),
//       uTINSPERBOX: uTINSPERBOX == null && nullToAbsent
//           ? const Value.absent()
//           : Value(uTINSPERBOX),
//       uSpecificGravity: uSpecificGravity == null && nullToAbsent
//           ? const Value.absent()
//           : Value(uSpecificGravity),
//       uPackSizeUom: uPackSizeUom == null && nullToAbsent
//           ? const Value.absent()
//           : Value(uPackSizeUom),
//     );
//   }

//   factory DriftProductMasterData.fromJson(Map<String, dynamic> json,
//       {ValueSerializer? serializer}) {
//     serializer ??= driftRuntimeOptions.defaultSerializer;
//     return DriftProductMasterData(
//       IMid: serializer.fromJson<int>(json['IMid']),
//       itemname: serializer.fromJson<String?>(json['itemname']),
//       itemcode: serializer.fromJson<String?>(json['itemcode']),
//       maximumQty: serializer.fromJson<String?>(json['maximumQty']),
//       minimumQty: serializer.fromJson<String?>(json['minimumQty']),
//       displayQty: serializer.fromJson<String?>(json['displayQty']),
//       searchString: serializer.fromJson<String?>(json['searchString']),
//       liter: serializer.fromJson<double?>(json['liter']),
//       category: serializer.fromJson<String?>(json['category']),
//       category1: serializer.fromJson<String?>(json['category1']),
//       brand: serializer.fromJson<String?>(json['brand']),
//       brand1: serializer.fromJson<String?>(json['brand1']),
//       weight: serializer.fromJson<double?>(json['weight']),
//       hsnsac: serializer.fromJson<String?>(json['hsnsac']),
//       isActive: serializer.fromJson<String?>(json['isActive']),
//       isfreeby: serializer.fromJson<String?>(json['isfreeby']),
//       isinventory: serializer.fromJson<String?>(json['isinventory']),
//       issellpricebyscrbat:
//           serializer.fromJson<String?>(json['issellpricebyscrbat']),
//       itemnamelong: serializer.fromJson<String?>(json['itemnamelong']),
//       itemnameshort: serializer.fromJson<String?>(json['itemnameshort']),
//       skucode: serializer.fromJson<String?>(json['skucode']),
//       subcategory: serializer.fromJson<String?>(json['subcategory']),
//       sellprice: serializer.fromJson<double?>(json['sellprice']),
//       mrpprice: serializer.fromJson<double?>(json['mrpprice']),
//       specialprice: serializer.fromJson<double?>(json['specialprice']),
//       maxdiscount: serializer.fromJson<String?>(json['maxdiscount']),
//       taxrate: serializer.fromJson<double?>(json['taxrate']),
//       snapdatetime: serializer.fromJson<String?>(json['snapdatetime']),
//       purchasedate: serializer.fromJson<String?>(json['purchasedate']),
//       createdateTime: serializer.fromJson<String?>(json['createdateTime']),
//       updatedDatetime: serializer.fromJson<String?>(json['updatedDatetime']),
//       createdUserID: serializer.fromJson<String?>(json['createdUserID']),
//       updateduserid: serializer.fromJson<String?>(json['updateduserid']),
//       lastupdateIp: serializer.fromJson<String?>(json['lastupdateIp']),
//       uPackSize: serializer.fromJson<double?>(json['uPackSize']),
//       uTINSPERBOX: serializer.fromJson<int?>(json['uTINSPERBOX']),
//       uSpecificGravity: serializer.fromJson<double?>(json['uSpecificGravity']),
//       uPackSizeUom: serializer.fromJson<String?>(json['uPackSizeUom']),
//     );
//   }
//   @override
//   Map<String, dynamic> toJson({ValueSerializer? serializer}) {
//     serializer ??= driftRuntimeOptions.defaultSerializer;
//     return <String, dynamic>{
//       'IMid': serializer.toJson<int>(IMid),
//       'itemname': serializer.toJson<String?>(itemname),
//       'itemcode': serializer.toJson<String?>(itemcode),
//       'maximumQty': serializer.toJson<String?>(maximumQty),
//       'minimumQty': serializer.toJson<String?>(minimumQty),
//       'displayQty': serializer.toJson<String?>(displayQty),
//       'searchString': serializer.toJson<String?>(searchString),
//       'liter': serializer.toJson<double?>(liter),
//       'category': serializer.toJson<String?>(category),
//       'category1': serializer.toJson<String?>(category1),
//       'brand': serializer.toJson<String?>(brand),
//       'brand1': serializer.toJson<String?>(brand1),
//       'weight': serializer.toJson<double?>(weight),
//       'hsnsac': serializer.toJson<String?>(hsnsac),
//       'isActive': serializer.toJson<String?>(isActive),
//       'isfreeby': serializer.toJson<String?>(isfreeby),
//       'isinventory': serializer.toJson<String?>(isinventory),
//       'issellpricebyscrbat': serializer.toJson<String?>(issellpricebyscrbat),
//       'itemnamelong': serializer.toJson<String?>(itemnamelong),
//       'itemnameshort': serializer.toJson<String?>(itemnameshort),
//       'skucode': serializer.toJson<String?>(skucode),
//       'subcategory': serializer.toJson<String?>(subcategory),
//       'sellprice': serializer.toJson<double?>(sellprice),
//       'mrpprice': serializer.toJson<double?>(mrpprice),
//       'specialprice': serializer.toJson<double?>(specialprice),
//       'maxdiscount': serializer.toJson<String?>(maxdiscount),
//       'taxrate': serializer.toJson<double?>(taxrate),
//       'snapdatetime': serializer.toJson<String?>(snapdatetime),
//       'purchasedate': serializer.toJson<String?>(purchasedate),
//       'createdateTime': serializer.toJson<String?>(createdateTime),
//       'updatedDatetime': serializer.toJson<String?>(updatedDatetime),
//       'createdUserID': serializer.toJson<String?>(createdUserID),
//       'updateduserid': serializer.toJson<String?>(updateduserid),
//       'lastupdateIp': serializer.toJson<String?>(lastupdateIp),
//       'uPackSize': serializer.toJson<double?>(uPackSize),
//       'uTINSPERBOX': serializer.toJson<int?>(uTINSPERBOX),
//       'uSpecificGravity': serializer.toJson<double?>(uSpecificGravity),
//       'uPackSizeUom': serializer.toJson<String?>(uPackSizeUom),
//     };
//   }

//   DriftProductMasterData copyWith(
//           {int? IMid,
//           Value<String?> itemname = const Value.absent(),
//           Value<String?> itemcode = const Value.absent(),
//           Value<String?> maximumQty = const Value.absent(),
//           Value<String?> minimumQty = const Value.absent(),
//           Value<String?> displayQty = const Value.absent(),
//           Value<String?> searchString = const Value.absent(),
//           Value<double?> liter = const Value.absent(),
//           Value<String?> category = const Value.absent(),
//           Value<String?> category1 = const Value.absent(),
//           Value<String?> brand = const Value.absent(),
//           Value<String?> brand1 = const Value.absent(),
//           Value<double?> weight = const Value.absent(),
//           Value<String?> hsnsac = const Value.absent(),
//           Value<String?> isActive = const Value.absent(),
//           Value<String?> isfreeby = const Value.absent(),
//           Value<String?> isinventory = const Value.absent(),
//           Value<String?> issellpricebyscrbat = const Value.absent(),
//           Value<String?> itemnamelong = const Value.absent(),
//           Value<String?> itemnameshort = const Value.absent(),
//           Value<String?> skucode = const Value.absent(),
//           Value<String?> subcategory = const Value.absent(),
//           Value<double?> sellprice = const Value.absent(),
//           Value<double?> mrpprice = const Value.absent(),
//           Value<double?> specialprice = const Value.absent(),
//           Value<String?> maxdiscount = const Value.absent(),
//           Value<double?> taxrate = const Value.absent(),
//           Value<String?> snapdatetime = const Value.absent(),
//           Value<String?> purchasedate = const Value.absent(),
//           Value<String?> createdateTime = const Value.absent(),
//           Value<String?> updatedDatetime = const Value.absent(),
//           Value<String?> createdUserID = const Value.absent(),
//           Value<String?> updateduserid = const Value.absent(),
//           Value<String?> lastupdateIp = const Value.absent(),
//           Value<double?> uPackSize = const Value.absent(),
//           Value<int?> uTINSPERBOX = const Value.absent(),
//           Value<double?> uSpecificGravity = const Value.absent(),
//           Value<String?> uPackSizeUom = const Value.absent()}) =>
//       DriftProductMasterData(
//         IMid: IMid ?? this.IMid,
//         itemname: itemname.present ? itemname.value : this.itemname,
//         itemcode: itemcode.present ? itemcode.value : this.itemcode,
//         maximumQty: maximumQty.present ? maximumQty.value : this.maximumQty,
//         minimumQty: minimumQty.present ? minimumQty.value : this.minimumQty,
//         displayQty: displayQty.present ? displayQty.value : this.displayQty,
//         searchString:
//             searchString.present ? searchString.value : this.searchString,
//         liter: liter.present ? liter.value : this.liter,
//         category: category.present ? category.value : this.category,
//         category1: category1.present ? category1.value : this.category1,
//         brand: brand.present ? brand.value : this.brand,
//         brand1: brand1.present ? brand1.value : this.brand1,
//         weight: weight.present ? weight.value : this.weight,
//         hsnsac: hsnsac.present ? hsnsac.value : this.hsnsac,
//         isActive: isActive.present ? isActive.value : this.isActive,
//         isfreeby: isfreeby.present ? isfreeby.value : this.isfreeby,
//         isinventory: isinventory.present ? isinventory.value : this.isinventory,
//         issellpricebyscrbat: issellpricebyscrbat.present
//             ? issellpricebyscrbat.value
//             : this.issellpricebyscrbat,
//         itemnamelong:
//             itemnamelong.present ? itemnamelong.value : this.itemnamelong,
//         itemnameshort:
//             itemnameshort.present ? itemnameshort.value : this.itemnameshort,
//         skucode: skucode.present ? skucode.value : this.skucode,
//         subcategory: subcategory.present ? subcategory.value : this.subcategory,
//         sellprice: sellprice.present ? sellprice.value : this.sellprice,
//         mrpprice: mrpprice.present ? mrpprice.value : this.mrpprice,
//         specialprice:
//             specialprice.present ? specialprice.value : this.specialprice,
//         maxdiscount: maxdiscount.present ? maxdiscount.value : this.maxdiscount,
//         taxrate: taxrate.present ? taxrate.value : this.taxrate,
//         snapdatetime:
//             snapdatetime.present ? snapdatetime.value : this.snapdatetime,
//         purchasedate:
//             purchasedate.present ? purchasedate.value : this.purchasedate,
//         createdateTime:
//             createdateTime.present ? createdateTime.value : this.createdateTime,
//         updatedDatetime: updatedDatetime.present
//             ? updatedDatetime.value
//             : this.updatedDatetime,
//         createdUserID:
//             createdUserID.present ? createdUserID.value : this.createdUserID,
//         updateduserid:
//             updateduserid.present ? updateduserid.value : this.updateduserid,
//         lastupdateIp:
//             lastupdateIp.present ? lastupdateIp.value : this.lastupdateIp,
//         uPackSize: uPackSize.present ? uPackSize.value : this.uPackSize,
//         uTINSPERBOX: uTINSPERBOX.present ? uTINSPERBOX.value : this.uTINSPERBOX,
//         uSpecificGravity: uSpecificGravity.present
//             ? uSpecificGravity.value
//             : this.uSpecificGravity,
//         uPackSizeUom:
//             uPackSizeUom.present ? uPackSizeUom.value : this.uPackSizeUom,
//       );
//   DriftProductMasterData copyWithCompanion(DriftProductMasterCompanion data) {
//     return DriftProductMasterData(
//       IMid: data.IMid.present ? data.IMid.value : this.IMid,
//       itemname: data.itemname.present ? data.itemname.value : this.itemname,
//       itemcode: data.itemcode.present ? data.itemcode.value : this.itemcode,
//       maximumQty:
//           data.maximumQty.present ? data.maximumQty.value : this.maximumQty,
//       minimumQty:
//           data.minimumQty.present ? data.minimumQty.value : this.minimumQty,
//       displayQty:
//           data.displayQty.present ? data.displayQty.value : this.displayQty,
//       searchString: data.searchString.present
//           ? data.searchString.value
//           : this.searchString,
//       liter: data.liter.present ? data.liter.value : this.liter,
//       category: data.category.present ? data.category.value : this.category,
//       category1: data.category1.present ? data.category1.value : this.category1,
//       brand: data.brand.present ? data.brand.value : this.brand,
//       brand1: data.brand1.present ? data.brand1.value : this.brand1,
//       weight: data.weight.present ? data.weight.value : this.weight,
//       hsnsac: data.hsnsac.present ? data.hsnsac.value : this.hsnsac,
//       isActive: data.isActive.present ? data.isActive.value : this.isActive,
//       isfreeby: data.isfreeby.present ? data.isfreeby.value : this.isfreeby,
//       isinventory:
//           data.isinventory.present ? data.isinventory.value : this.isinventory,
//       issellpricebyscrbat: data.issellpricebyscrbat.present
//           ? data.issellpricebyscrbat.value
//           : this.issellpricebyscrbat,
//       itemnamelong: data.itemnamelong.present
//           ? data.itemnamelong.value
//           : this.itemnamelong,
//       itemnameshort: data.itemnameshort.present
//           ? data.itemnameshort.value
//           : this.itemnameshort,
//       skucode: data.skucode.present ? data.skucode.value : this.skucode,
//       subcategory:
//           data.subcategory.present ? data.subcategory.value : this.subcategory,
//       sellprice: data.sellprice.present ? data.sellprice.value : this.sellprice,
//       mrpprice: data.mrpprice.present ? data.mrpprice.value : this.mrpprice,
//       specialprice: data.specialprice.present
//           ? data.specialprice.value
//           : this.specialprice,
//       maxdiscount:
//           data.maxdiscount.present ? data.maxdiscount.value : this.maxdiscount,
//       taxrate: data.taxrate.present ? data.taxrate.value : this.taxrate,
//       snapdatetime: data.snapdatetime.present
//           ? data.snapdatetime.value
//           : this.snapdatetime,
//       purchasedate: data.purchasedate.present
//           ? data.purchasedate.value
//           : this.purchasedate,
//       createdateTime: data.createdateTime.present
//           ? data.createdateTime.value
//           : this.createdateTime,
//       updatedDatetime: data.updatedDatetime.present
//           ? data.updatedDatetime.value
//           : this.updatedDatetime,
//       createdUserID: data.createdUserID.present
//           ? data.createdUserID.value
//           : this.createdUserID,
//       updateduserid: data.updateduserid.present
//           ? data.updateduserid.value
//           : this.updateduserid,
//       lastupdateIp: data.lastupdateIp.present
//           ? data.lastupdateIp.value
//           : this.lastupdateIp,
//       uPackSize: data.uPackSize.present ? data.uPackSize.value : this.uPackSize,
//       uTINSPERBOX:
//           data.uTINSPERBOX.present ? data.uTINSPERBOX.value : this.uTINSPERBOX,
//       uSpecificGravity: data.uSpecificGravity.present
//           ? data.uSpecificGravity.value
//           : this.uSpecificGravity,
//       uPackSizeUom: data.uPackSizeUom.present
//           ? data.uPackSizeUom.value
//           : this.uPackSizeUom,
//     );
//   }

//   @override
//   String toString() {
//     return (StringBuffer('DriftProductMasterData(')
//           ..write('IMid: $IMid, ')
//           ..write('itemname: $itemname, ')
//           ..write('itemcode: $itemcode, ')
//           ..write('maximumQty: $maximumQty, ')
//           ..write('minimumQty: $minimumQty, ')
//           ..write('displayQty: $displayQty, ')
//           ..write('searchString: $searchString, ')
//           ..write('liter: $liter, ')
//           ..write('category: $category, ')
//           ..write('category1: $category1, ')
//           ..write('brand: $brand, ')
//           ..write('brand1: $brand1, ')
//           ..write('weight: $weight, ')
//           ..write('hsnsac: $hsnsac, ')
//           ..write('isActive: $isActive, ')
//           ..write('isfreeby: $isfreeby, ')
//           ..write('isinventory: $isinventory, ')
//           ..write('issellpricebyscrbat: $issellpricebyscrbat, ')
//           ..write('itemnamelong: $itemnamelong, ')
//           ..write('itemnameshort: $itemnameshort, ')
//           ..write('skucode: $skucode, ')
//           ..write('subcategory: $subcategory, ')
//           ..write('sellprice: $sellprice, ')
//           ..write('mrpprice: $mrpprice, ')
//           ..write('specialprice: $specialprice, ')
//           ..write('maxdiscount: $maxdiscount, ')
//           ..write('taxrate: $taxrate, ')
//           ..write('snapdatetime: $snapdatetime, ')
//           ..write('purchasedate: $purchasedate, ')
//           ..write('createdateTime: $createdateTime, ')
//           ..write('updatedDatetime: $updatedDatetime, ')
//           ..write('createdUserID: $createdUserID, ')
//           ..write('updateduserid: $updateduserid, ')
//           ..write('lastupdateIp: $lastupdateIp, ')
//           ..write('uPackSize: $uPackSize, ')
//           ..write('uTINSPERBOX: $uTINSPERBOX, ')
//           ..write('uSpecificGravity: $uSpecificGravity, ')
//           ..write('uPackSizeUom: $uPackSizeUom')
//           ..write(')'))
//         .toString();
//   }

//   @override
//   int get hashCode => Object.hashAll([
//         IMid,
//         itemname,
//         itemcode,
//         maximumQty,
//         minimumQty,
//         displayQty,
//         searchString,
//         liter,
//         category,
//         category1,
//         brand,
//         brand1,
//         weight,
//         hsnsac,
//         isActive,
//         isfreeby,
//         isinventory,
//         issellpricebyscrbat,
//         itemnamelong,
//         itemnameshort,
//         skucode,
//         subcategory,
//         sellprice,
//         mrpprice,
//         specialprice,
//         maxdiscount,
//         taxrate,
//         snapdatetime,
//         purchasedate,
//         createdateTime,
//         updatedDatetime,
//         createdUserID,
//         updateduserid,
//         lastupdateIp,
//         uPackSize,
//         uTINSPERBOX,
//         uSpecificGravity,
//         uPackSizeUom
//       ]);
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       (other is DriftProductMasterData &&
//           other.IMid == this.IMid &&
//           other.itemname == this.itemname &&
//           other.itemcode == this.itemcode &&
//           other.maximumQty == this.maximumQty &&
//           other.minimumQty == this.minimumQty &&
//           other.displayQty == this.displayQty &&
//           other.searchString == this.searchString &&
//           other.liter == this.liter &&
//           other.category == this.category &&
//           other.category1 == this.category1 &&
//           other.brand == this.brand &&
//           other.brand1 == this.brand1 &&
//           other.weight == this.weight &&
//           other.hsnsac == this.hsnsac &&
//           other.isActive == this.isActive &&
//           other.isfreeby == this.isfreeby &&
//           other.isinventory == this.isinventory &&
//           other.issellpricebyscrbat == this.issellpricebyscrbat &&
//           other.itemnamelong == this.itemnamelong &&
//           other.itemnameshort == this.itemnameshort &&
//           other.skucode == this.skucode &&
//           other.subcategory == this.subcategory &&
//           other.sellprice == this.sellprice &&
//           other.mrpprice == this.mrpprice &&
//           other.specialprice == this.specialprice &&
//           other.maxdiscount == this.maxdiscount &&
//           other.taxrate == this.taxrate &&
//           other.snapdatetime == this.snapdatetime &&
//           other.purchasedate == this.purchasedate &&
//           other.createdateTime == this.createdateTime &&
//           other.updatedDatetime == this.updatedDatetime &&
//           other.createdUserID == this.createdUserID &&
//           other.updateduserid == this.updateduserid &&
//           other.lastupdateIp == this.lastupdateIp &&
//           other.uPackSize == this.uPackSize &&
//           other.uTINSPERBOX == this.uTINSPERBOX &&
//           other.uSpecificGravity == this.uSpecificGravity &&
//           other.uPackSizeUom == this.uPackSizeUom);
// }

// class DriftProductMasterCompanion
//     extends UpdateCompanion<DriftProductMasterData> {
//   final Value<int> IMid;
//   final Value<String?> itemname;
//   final Value<String?> itemcode;
//   final Value<String?> maximumQty;
//   final Value<String?> minimumQty;
//   final Value<String?> displayQty;
//   final Value<String?> searchString;
//   final Value<double?> liter;
//   final Value<String?> category;
//   final Value<String?> category1;
//   final Value<String?> brand;
//   final Value<String?> brand1;
//   final Value<double?> weight;
//   final Value<String?> hsnsac;
//   final Value<String?> isActive;
//   final Value<String?> isfreeby;
//   final Value<String?> isinventory;
//   final Value<String?> issellpricebyscrbat;
//   final Value<String?> itemnamelong;
//   final Value<String?> itemnameshort;
//   final Value<String?> skucode;
//   final Value<String?> subcategory;
//   final Value<double?> sellprice;
//   final Value<double?> mrpprice;
//   final Value<double?> specialprice;
//   final Value<String?> maxdiscount;
//   final Value<double?> taxrate;
//   final Value<String?> snapdatetime;
//   final Value<String?> purchasedate;
//   final Value<String?> createdateTime;
//   final Value<String?> updatedDatetime;
//   final Value<String?> createdUserID;
//   final Value<String?> updateduserid;
//   final Value<String?> lastupdateIp;
//   final Value<double?> uPackSize;
//   final Value<int?> uTINSPERBOX;
//   final Value<double?> uSpecificGravity;
//   final Value<String?> uPackSizeUom;
//   const DriftProductMasterCompanion({
//     this.IMid = const Value.absent(),
//     this.itemname = const Value.absent(),
//     this.itemcode = const Value.absent(),
//     this.maximumQty = const Value.absent(),
//     this.minimumQty = const Value.absent(),
//     this.displayQty = const Value.absent(),
//     this.searchString = const Value.absent(),
//     this.liter = const Value.absent(),
//     this.category = const Value.absent(),
//     this.category1 = const Value.absent(),
//     this.brand = const Value.absent(),
//     this.brand1 = const Value.absent(),
//     this.weight = const Value.absent(),
//     this.hsnsac = const Value.absent(),
//     this.isActive = const Value.absent(),
//     this.isfreeby = const Value.absent(),
//     this.isinventory = const Value.absent(),
//     this.issellpricebyscrbat = const Value.absent(),
//     this.itemnamelong = const Value.absent(),
//     this.itemnameshort = const Value.absent(),
//     this.skucode = const Value.absent(),
//     this.subcategory = const Value.absent(),
//     this.sellprice = const Value.absent(),
//     this.mrpprice = const Value.absent(),
//     this.specialprice = const Value.absent(),
//     this.maxdiscount = const Value.absent(),
//     this.taxrate = const Value.absent(),
//     this.snapdatetime = const Value.absent(),
//     this.purchasedate = const Value.absent(),
//     this.createdateTime = const Value.absent(),
//     this.updatedDatetime = const Value.absent(),
//     this.createdUserID = const Value.absent(),
//     this.updateduserid = const Value.absent(),
//     this.lastupdateIp = const Value.absent(),
//     this.uPackSize = const Value.absent(),
//     this.uTINSPERBOX = const Value.absent(),
//     this.uSpecificGravity = const Value.absent(),
//     this.uPackSizeUom = const Value.absent(),
//   });
//   DriftProductMasterCompanion.insert({
//     this.IMid = const Value.absent(),
//     this.itemname = const Value.absent(),
//     this.itemcode = const Value.absent(),
//     this.maximumQty = const Value.absent(),
//     this.minimumQty = const Value.absent(),
//     this.displayQty = const Value.absent(),
//     this.searchString = const Value.absent(),
//     this.liter = const Value.absent(),
//     this.category = const Value.absent(),
//     this.category1 = const Value.absent(),
//     this.brand = const Value.absent(),
//     this.brand1 = const Value.absent(),
//     this.weight = const Value.absent(),
//     this.hsnsac = const Value.absent(),
//     this.isActive = const Value.absent(),
//     this.isfreeby = const Value.absent(),
//     this.isinventory = const Value.absent(),
//     this.issellpricebyscrbat = const Value.absent(),
//     this.itemnamelong = const Value.absent(),
//     this.itemnameshort = const Value.absent(),
//     this.skucode = const Value.absent(),
//     this.subcategory = const Value.absent(),
//     this.sellprice = const Value.absent(),
//     this.mrpprice = const Value.absent(),
//     this.specialprice = const Value.absent(),
//     this.maxdiscount = const Value.absent(),
//     this.taxrate = const Value.absent(),
//     this.snapdatetime = const Value.absent(),
//     this.purchasedate = const Value.absent(),
//     this.createdateTime = const Value.absent(),
//     this.updatedDatetime = const Value.absent(),
//     this.createdUserID = const Value.absent(),
//     this.updateduserid = const Value.absent(),
//     this.lastupdateIp = const Value.absent(),
//     this.uPackSize = const Value.absent(),
//     this.uTINSPERBOX = const Value.absent(),
//     this.uSpecificGravity = const Value.absent(),
//     this.uPackSizeUom = const Value.absent(),
//   });
//   static Insertable<DriftProductMasterData> custom({
//     Expression<int>? IMid,
//     Expression<String>? itemname,
//     Expression<String>? itemcode,
//     Expression<String>? maximumQty,
//     Expression<String>? minimumQty,
//     Expression<String>? displayQty,
//     Expression<String>? searchString,
//     Expression<double>? liter,
//     Expression<String>? category,
//     Expression<String>? category1,
//     Expression<String>? brand,
//     Expression<String>? brand1,
//     Expression<double>? weight,
//     Expression<String>? hsnsac,
//     Expression<String>? isActive,
//     Expression<String>? isfreeby,
//     Expression<String>? isinventory,
//     Expression<String>? issellpricebyscrbat,
//     Expression<String>? itemnamelong,
//     Expression<String>? itemnameshort,
//     Expression<String>? skucode,
//     Expression<String>? subcategory,
//     Expression<double>? sellprice,
//     Expression<double>? mrpprice,
//     Expression<double>? specialprice,
//     Expression<String>? maxdiscount,
//     Expression<double>? taxrate,
//     Expression<String>? snapdatetime,
//     Expression<String>? purchasedate,
//     Expression<String>? createdateTime,
//     Expression<String>? updatedDatetime,
//     Expression<String>? createdUserID,
//     Expression<String>? updateduserid,
//     Expression<String>? lastupdateIp,
//     Expression<double>? uPackSize,
//     Expression<int>? uTINSPERBOX,
//     Expression<double>? uSpecificGravity,
//     Expression<String>? uPackSizeUom,
//   }) {
//     return RawValuesInsertable({
//       if (IMid != null) 'i_mid': IMid,
//       if (itemname != null) 'itemname': itemname,
//       if (itemcode != null) 'itemcode': itemcode,
//       if (maximumQty != null) 'maximumQty': maximumQty,
//       if (minimumQty != null) 'minimumQty': minimumQty,
//       if (displayQty != null) 'displayQty': displayQty,
//       if (searchString != null) 'searchString': searchString,
//       if (liter != null) 'liter': liter,
//       if (category != null) 'category': category,
//       if (category1 != null) 'category1': category1,
//       if (brand != null) 'brand': brand,
//       if (brand1 != null) 'brand1': brand1,
//       if (weight != null) 'weight': weight,
//       if (hsnsac != null) 'hsnsac': hsnsac,
//       if (isActive != null) 'isActive': isActive,
//       if (isfreeby != null) 'isfreeby': isfreeby,
//       if (isinventory != null) 'isinventory': isinventory,
//       if (issellpricebyscrbat != null)
//         'issellpricebyscrbat': issellpricebyscrbat,
//       if (itemnamelong != null) 'itemnamelong': itemnamelong,
//       if (itemnameshort != null) 'itemnameshort': itemnameshort,
//       if (skucode != null) 'skucode': skucode,
//       if (subcategory != null) 'subcategory': subcategory,
//       if (sellprice != null) 'sellprice': sellprice,
//       if (mrpprice != null) 'mrpprice': mrpprice,
//       if (specialprice != null) 'specialprice': specialprice,
//       if (maxdiscount != null) 'maxdiscount': maxdiscount,
//       if (taxrate != null) 'taxrate': taxrate,
//       if (snapdatetime != null) 'snapdatetime': snapdatetime,
//       if (purchasedate != null) 'purchasedate': purchasedate,
//       if (createdateTime != null) 'createdateTime': createdateTime,
//       if (updatedDatetime != null) 'updatedDatetime': updatedDatetime,
//       if (createdUserID != null) 'createdUserID': createdUserID,
//       if (updateduserid != null) 'updateduserid': updateduserid,
//       if (lastupdateIp != null) 'lastupdateIp': lastupdateIp,
//       if (uPackSize != null) 'U_Pack_Size': uPackSize,
//       if (uTINSPERBOX != null) 'U_TINS_PER_BOX': uTINSPERBOX,
//       if (uSpecificGravity != null) 'U_Specific_Gravity': uSpecificGravity,
//       if (uPackSizeUom != null) 'U_Pack_Size_uom': uPackSizeUom,
//     });
//   }

//   DriftProductMasterCompanion copyWith(
//       {Value<int>? IMid,
//       Value<String?>? itemname,
//       Value<String?>? itemcode,
//       Value<String?>? maximumQty,
//       Value<String?>? minimumQty,
//       Value<String?>? displayQty,
//       Value<String?>? searchString,
//       Value<double?>? liter,
//       Value<String?>? category,
//       Value<String?>? category1,
//       Value<String?>? brand,
//       Value<String?>? brand1,
//       Value<double?>? weight,
//       Value<String?>? hsnsac,
//       Value<String?>? isActive,
//       Value<String?>? isfreeby,
//       Value<String?>? isinventory,
//       Value<String?>? issellpricebyscrbat,
//       Value<String?>? itemnamelong,
//       Value<String?>? itemnameshort,
//       Value<String?>? skucode,
//       Value<String?>? subcategory,
//       Value<double?>? sellprice,
//       Value<double?>? mrpprice,
//       Value<double?>? specialprice,
//       Value<String?>? maxdiscount,
//       Value<double?>? taxrate,
//       Value<String?>? snapdatetime,
//       Value<String?>? purchasedate,
//       Value<String?>? createdateTime,
//       Value<String?>? updatedDatetime,
//       Value<String?>? createdUserID,
//       Value<String?>? updateduserid,
//       Value<String?>? lastupdateIp,
//       Value<double?>? uPackSize,
//       Value<int?>? uTINSPERBOX,
//       Value<double?>? uSpecificGravity,
//       Value<String?>? uPackSizeUom}) {
//     return DriftProductMasterCompanion(
//       IMid: IMid ?? this.IMid,
//       itemname: itemname ?? this.itemname,
//       itemcode: itemcode ?? this.itemcode,
//       maximumQty: maximumQty ?? this.maximumQty,
//       minimumQty: minimumQty ?? this.minimumQty,
//       displayQty: displayQty ?? this.displayQty,
//       searchString: searchString ?? this.searchString,
//       liter: liter ?? this.liter,
//       category: category ?? this.category,
//       category1: category1 ?? this.category1,
//       brand: brand ?? this.brand,
//       brand1: brand1 ?? this.brand1,
//       weight: weight ?? this.weight,
//       hsnsac: hsnsac ?? this.hsnsac,
//       isActive: isActive ?? this.isActive,
//       isfreeby: isfreeby ?? this.isfreeby,
//       isinventory: isinventory ?? this.isinventory,
//       issellpricebyscrbat: issellpricebyscrbat ?? this.issellpricebyscrbat,
//       itemnamelong: itemnamelong ?? this.itemnamelong,
//       itemnameshort: itemnameshort ?? this.itemnameshort,
//       skucode: skucode ?? this.skucode,
//       subcategory: subcategory ?? this.subcategory,
//       sellprice: sellprice ?? this.sellprice,
//       mrpprice: mrpprice ?? this.mrpprice,
//       specialprice: specialprice ?? this.specialprice,
//       maxdiscount: maxdiscount ?? this.maxdiscount,
//       taxrate: taxrate ?? this.taxrate,
//       snapdatetime: snapdatetime ?? this.snapdatetime,
//       purchasedate: purchasedate ?? this.purchasedate,
//       createdateTime: createdateTime ?? this.createdateTime,
//       updatedDatetime: updatedDatetime ?? this.updatedDatetime,
//       createdUserID: createdUserID ?? this.createdUserID,
//       updateduserid: updateduserid ?? this.updateduserid,
//       lastupdateIp: lastupdateIp ?? this.lastupdateIp,
//       uPackSize: uPackSize ?? this.uPackSize,
//       uTINSPERBOX: uTINSPERBOX ?? this.uTINSPERBOX,
//       uSpecificGravity: uSpecificGravity ?? this.uSpecificGravity,
//       uPackSizeUom: uPackSizeUom ?? this.uPackSizeUom,
//     );
//   }

//   @override
//   Map<String, Expression> toColumns(bool nullToAbsent) {
//     final map = <String, Expression>{};
//     if (IMid.present) {
//       map['i_mid'] = Variable<int>(IMid.value);
//     }
//     if (itemname.present) {
//       map['itemname'] = Variable<String>(itemname.value);
//     }
//     if (itemcode.present) {
//       map['itemcode'] = Variable<String>(itemcode.value);
//     }
//     if (maximumQty.present) {
//       map['maximumQty'] = Variable<String>(maximumQty.value);
//     }
//     if (minimumQty.present) {
//       map['minimumQty'] = Variable<String>(minimumQty.value);
//     }
//     if (displayQty.present) {
//       map['displayQty'] = Variable<String>(displayQty.value);
//     }
//     if (searchString.present) {
//       map['searchString'] = Variable<String>(searchString.value);
//     }
//     if (liter.present) {
//       map['liter'] = Variable<double>(liter.value);
//     }
//     if (category.present) {
//       map['category'] = Variable<String>(category.value);
//     }
//     if (category1.present) {
//       map['category1'] = Variable<String>(category1.value);
//     }
//     if (brand.present) {
//       map['brand'] = Variable<String>(brand.value);
//     }
//     if (brand1.present) {
//       map['brand1'] = Variable<String>(brand1.value);
//     }
//     if (weight.present) {
//       map['weight'] = Variable<double>(weight.value);
//     }
//     if (hsnsac.present) {
//       map['hsnsac'] = Variable<String>(hsnsac.value);
//     }
//     if (isActive.present) {
//       map['isActive'] = Variable<String>(isActive.value);
//     }
//     if (isfreeby.present) {
//       map['isfreeby'] = Variable<String>(isfreeby.value);
//     }
//     if (isinventory.present) {
//       map['isinventory'] = Variable<String>(isinventory.value);
//     }
//     if (issellpricebyscrbat.present) {
//       map['issellpricebyscrbat'] = Variable<String>(issellpricebyscrbat.value);
//     }
//     if (itemnamelong.present) {
//       map['itemnamelong'] = Variable<String>(itemnamelong.value);
//     }
//     if (itemnameshort.present) {
//       map['itemnameshort'] = Variable<String>(itemnameshort.value);
//     }
//     if (skucode.present) {
//       map['skucode'] = Variable<String>(skucode.value);
//     }
//     if (subcategory.present) {
//       map['subcategory'] = Variable<String>(subcategory.value);
//     }
//     if (sellprice.present) {
//       map['sellprice'] = Variable<double>(sellprice.value);
//     }
//     if (mrpprice.present) {
//       map['mrpprice'] = Variable<double>(mrpprice.value);
//     }
//     if (specialprice.present) {
//       map['specialprice'] = Variable<double>(specialprice.value);
//     }
//     if (maxdiscount.present) {
//       map['maxdiscount'] = Variable<String>(maxdiscount.value);
//     }
//     if (taxrate.present) {
//       map['taxrate'] = Variable<double>(taxrate.value);
//     }
//     if (snapdatetime.present) {
//       map['snapdatetime'] = Variable<String>(snapdatetime.value);
//     }
//     if (purchasedate.present) {
//       map['purchasedate'] = Variable<String>(purchasedate.value);
//     }
//     if (createdateTime.present) {
//       map['createdateTime'] = Variable<String>(createdateTime.value);
//     }
//     if (updatedDatetime.present) {
//       map['updatedDatetime'] = Variable<String>(updatedDatetime.value);
//     }
//     if (createdUserID.present) {
//       map['createdUserID'] = Variable<String>(createdUserID.value);
//     }
//     if (updateduserid.present) {
//       map['updateduserid'] = Variable<String>(updateduserid.value);
//     }
//     if (lastupdateIp.present) {
//       map['lastupdateIp'] = Variable<String>(lastupdateIp.value);
//     }
//     if (uPackSize.present) {
//       map['U_Pack_Size'] = Variable<double>(uPackSize.value);
//     }
//     if (uTINSPERBOX.present) {
//       map['U_TINS_PER_BOX'] = Variable<int>(uTINSPERBOX.value);
//     }
//     if (uSpecificGravity.present) {
//       map['U_Specific_Gravity'] = Variable<double>(uSpecificGravity.value);
//     }
//     if (uPackSizeUom.present) {
//       map['U_Pack_Size_uom'] = Variable<String>(uPackSizeUom.value);
//     }
//     return map;
//   }

//   @override
//   String toString() {
//     return (StringBuffer('DriftProductMasterCompanion(')
//           ..write('IMid: $IMid, ')
//           ..write('itemname: $itemname, ')
//           ..write('itemcode: $itemcode, ')
//           ..write('maximumQty: $maximumQty, ')
//           ..write('minimumQty: $minimumQty, ')
//           ..write('displayQty: $displayQty, ')
//           ..write('searchString: $searchString, ')
//           ..write('liter: $liter, ')
//           ..write('category: $category, ')
//           ..write('category1: $category1, ')
//           ..write('brand: $brand, ')
//           ..write('brand1: $brand1, ')
//           ..write('weight: $weight, ')
//           ..write('hsnsac: $hsnsac, ')
//           ..write('isActive: $isActive, ')
//           ..write('isfreeby: $isfreeby, ')
//           ..write('isinventory: $isinventory, ')
//           ..write('issellpricebyscrbat: $issellpricebyscrbat, ')
//           ..write('itemnamelong: $itemnamelong, ')
//           ..write('itemnameshort: $itemnameshort, ')
//           ..write('skucode: $skucode, ')
//           ..write('subcategory: $subcategory, ')
//           ..write('sellprice: $sellprice, ')
//           ..write('mrpprice: $mrpprice, ')
//           ..write('specialprice: $specialprice, ')
//           ..write('maxdiscount: $maxdiscount, ')
//           ..write('taxrate: $taxrate, ')
//           ..write('snapdatetime: $snapdatetime, ')
//           ..write('purchasedate: $purchasedate, ')
//           ..write('createdateTime: $createdateTime, ')
//           ..write('updatedDatetime: $updatedDatetime, ')
//           ..write('createdUserID: $createdUserID, ')
//           ..write('updateduserid: $updateduserid, ')
//           ..write('lastupdateIp: $lastupdateIp, ')
//           ..write('uPackSize: $uPackSize, ')
//           ..write('uTINSPERBOX: $uTINSPERBOX, ')
//           ..write('uSpecificGravity: $uSpecificGravity, ')
//           ..write('uPackSizeUom: $uPackSizeUom')
//           ..write(')'))
//         .toString();
//   }
// }

// abstract class _$AppDatabase extends GeneratedDatabase {
//   _$AppDatabase(QueryExecutor e) : super(e);
//   $AppDatabaseManager get managers => $AppDatabaseManager(this);
//   late final $DriftItemMasterTable driftItemMaster =
//       $DriftItemMasterTable(this);
//   late final $DriftProductMasterTable driftProductMaster =
//       $DriftProductMasterTable(this);
//   @override
//   Iterable<TableInfo<Table, Object?>> get allTables =>
//       allSchemaEntities.whereType<TableInfo<Table, Object?>>();
//   @override
//   List<DatabaseSchemaEntity> get allSchemaEntities =>
//       [driftItemMaster, driftProductMaster];
// }

// typedef $$DriftItemMasterTableCreateCompanionBuilder = DriftItemMasterCompanion
//     Function({
//   Value<int> IMid,
//   Value<String?> itemname,
//   Value<String?> itemcode,
//   Value<String?> whsCode,
//   Value<String?> serialbatch,
//   Value<int?> quantity,
//   Value<String?> maximumQty,
//   Value<String?> minimumQty,
//   Value<String?> displayQty,
//   Value<String?> searchString,
//   Value<String?> category,
//   Value<double?> liter,
//   Value<String?> category1,
//   Value<double?> weight,
//   Value<String?> hsnsac,
//   Value<String?> isActive,
//   Value<String?> isfreeby,
//   Value<String?> isinventory,
//   Value<String?> issellpricebyscrbat,
//   Value<String?> itemnamelong,
//   Value<String?> itemnameshort,
//   Value<String?> skucode,
//   Value<String?> subcategory,
//   Value<double?> sellprice,
//   Value<double?> mrpprice,
//   Value<double?> specialprice,
//   Value<String?> maxdiscount,
//   Value<double?> taxrate,
//   Value<String?> snapdatetime,
//   Value<String?> purchasedate,
//   Value<String?> createdateTime,
//   Value<String?> updatedDatetime,
//   Value<String?> createdUserID,
//   Value<String?> updateduserid,
//   Value<String?> lastupdateIp,
//   Value<double?> uPackSize,
//   Value<int?> uTINSPERBOX,
//   Value<double?> uSpecificGravity,
//   Value<String?> uPackSizeUom,
// });
// typedef $$DriftItemMasterTableUpdateCompanionBuilder = DriftItemMasterCompanion
//     Function({
//   Value<int> IMid,
//   Value<String?> itemname,
//   Value<String?> itemcode,
//   Value<String?> whsCode,
//   Value<String?> serialbatch,
//   Value<int?> quantity,
//   Value<String?> maximumQty,
//   Value<String?> minimumQty,
//   Value<String?> displayQty,
//   Value<String?> searchString,
//   Value<String?> category,
//   Value<double?> liter,
//   Value<String?> category1,
//   Value<double?> weight,
//   Value<String?> hsnsac,
//   Value<String?> isActive,
//   Value<String?> isfreeby,
//   Value<String?> isinventory,
//   Value<String?> issellpricebyscrbat,
//   Value<String?> itemnamelong,
//   Value<String?> itemnameshort,
//   Value<String?> skucode,
//   Value<String?> subcategory,
//   Value<double?> sellprice,
//   Value<double?> mrpprice,
//   Value<double?> specialprice,
//   Value<String?> maxdiscount,
//   Value<double?> taxrate,
//   Value<String?> snapdatetime,
//   Value<String?> purchasedate,
//   Value<String?> createdateTime,
//   Value<String?> updatedDatetime,
//   Value<String?> createdUserID,
//   Value<String?> updateduserid,
//   Value<String?> lastupdateIp,
//   Value<double?> uPackSize,
//   Value<int?> uTINSPERBOX,
//   Value<double?> uSpecificGravity,
//   Value<String?> uPackSizeUom,
// });

// class $$DriftItemMasterTableFilterComposer
//     extends FilterComposer<_$AppDatabase, $DriftItemMasterTable> {
//   $$DriftItemMasterTableFilterComposer(super.$state);
//   ColumnFilters<int> get IMid => $state.composableBuilder(
//       column: $state.table.IMid,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get itemname => $state.composableBuilder(
//       column: $state.table.itemname,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get itemcode => $state.composableBuilder(
//       column: $state.table.itemcode,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get whsCode => $state.composableBuilder(
//       column: $state.table.whsCode,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get serialbatch => $state.composableBuilder(
//       column: $state.table.serialbatch,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<int> get quantity => $state.composableBuilder(
//       column: $state.table.quantity,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get maximumQty => $state.composableBuilder(
//       column: $state.table.maximumQty,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get minimumQty => $state.composableBuilder(
//       column: $state.table.minimumQty,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get displayQty => $state.composableBuilder(
//       column: $state.table.displayQty,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get searchString => $state.composableBuilder(
//       column: $state.table.searchString,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get category => $state.composableBuilder(
//       column: $state.table.category,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<double> get liter => $state.composableBuilder(
//       column: $state.table.liter,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get category1 => $state.composableBuilder(
//       column: $state.table.category1,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<double> get weight => $state.composableBuilder(
//       column: $state.table.weight,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get hsnsac => $state.composableBuilder(
//       column: $state.table.hsnsac,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get isActive => $state.composableBuilder(
//       column: $state.table.isActive,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get isfreeby => $state.composableBuilder(
//       column: $state.table.isfreeby,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get isinventory => $state.composableBuilder(
//       column: $state.table.isinventory,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get issellpricebyscrbat => $state.composableBuilder(
//       column: $state.table.issellpricebyscrbat,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get itemnamelong => $state.composableBuilder(
//       column: $state.table.itemnamelong,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get itemnameshort => $state.composableBuilder(
//       column: $state.table.itemnameshort,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get skucode => $state.composableBuilder(
//       column: $state.table.skucode,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get subcategory => $state.composableBuilder(
//       column: $state.table.subcategory,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<double> get sellprice => $state.composableBuilder(
//       column: $state.table.sellprice,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<double> get mrpprice => $state.composableBuilder(
//       column: $state.table.mrpprice,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<double> get specialprice => $state.composableBuilder(
//       column: $state.table.specialprice,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get maxdiscount => $state.composableBuilder(
//       column: $state.table.maxdiscount,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<double> get taxrate => $state.composableBuilder(
//       column: $state.table.taxrate,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get snapdatetime => $state.composableBuilder(
//       column: $state.table.snapdatetime,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get purchasedate => $state.composableBuilder(
//       column: $state.table.purchasedate,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get createdateTime => $state.composableBuilder(
//       column: $state.table.createdateTime,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get updatedDatetime => $state.composableBuilder(
//       column: $state.table.updatedDatetime,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get createdUserID => $state.composableBuilder(
//       column: $state.table.createdUserID,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get updateduserid => $state.composableBuilder(
//       column: $state.table.updateduserid,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get lastupdateIp => $state.composableBuilder(
//       column: $state.table.lastupdateIp,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<double> get uPackSize => $state.composableBuilder(
//       column: $state.table.uPackSize,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<int> get uTINSPERBOX => $state.composableBuilder(
//       column: $state.table.uTINSPERBOX,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<double> get uSpecificGravity => $state.composableBuilder(
//       column: $state.table.uSpecificGravity,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get uPackSizeUom => $state.composableBuilder(
//       column: $state.table.uPackSizeUom,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));
// }

// class $$DriftItemMasterTableOrderingComposer
//     extends OrderingComposer<_$AppDatabase, $DriftItemMasterTable> {
//   $$DriftItemMasterTableOrderingComposer(super.$state);
//   ColumnOrderings<int> get IMid => $state.composableBuilder(
//       column: $state.table.IMid,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get itemname => $state.composableBuilder(
//       column: $state.table.itemname,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get itemcode => $state.composableBuilder(
//       column: $state.table.itemcode,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get whsCode => $state.composableBuilder(
//       column: $state.table.whsCode,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get serialbatch => $state.composableBuilder(
//       column: $state.table.serialbatch,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<int> get quantity => $state.composableBuilder(
//       column: $state.table.quantity,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get maximumQty => $state.composableBuilder(
//       column: $state.table.maximumQty,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get minimumQty => $state.composableBuilder(
//       column: $state.table.minimumQty,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get displayQty => $state.composableBuilder(
//       column: $state.table.displayQty,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get searchString => $state.composableBuilder(
//       column: $state.table.searchString,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get category => $state.composableBuilder(
//       column: $state.table.category,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<double> get liter => $state.composableBuilder(
//       column: $state.table.liter,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get category1 => $state.composableBuilder(
//       column: $state.table.category1,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<double> get weight => $state.composableBuilder(
//       column: $state.table.weight,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get hsnsac => $state.composableBuilder(
//       column: $state.table.hsnsac,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get isActive => $state.composableBuilder(
//       column: $state.table.isActive,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get isfreeby => $state.composableBuilder(
//       column: $state.table.isfreeby,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get isinventory => $state.composableBuilder(
//       column: $state.table.isinventory,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get issellpricebyscrbat => $state.composableBuilder(
//       column: $state.table.issellpricebyscrbat,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get itemnamelong => $state.composableBuilder(
//       column: $state.table.itemnamelong,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get itemnameshort => $state.composableBuilder(
//       column: $state.table.itemnameshort,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get skucode => $state.composableBuilder(
//       column: $state.table.skucode,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get subcategory => $state.composableBuilder(
//       column: $state.table.subcategory,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<double> get sellprice => $state.composableBuilder(
//       column: $state.table.sellprice,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<double> get mrpprice => $state.composableBuilder(
//       column: $state.table.mrpprice,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<double> get specialprice => $state.composableBuilder(
//       column: $state.table.specialprice,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get maxdiscount => $state.composableBuilder(
//       column: $state.table.maxdiscount,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<double> get taxrate => $state.composableBuilder(
//       column: $state.table.taxrate,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get snapdatetime => $state.composableBuilder(
//       column: $state.table.snapdatetime,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get purchasedate => $state.composableBuilder(
//       column: $state.table.purchasedate,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get createdateTime => $state.composableBuilder(
//       column: $state.table.createdateTime,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get updatedDatetime => $state.composableBuilder(
//       column: $state.table.updatedDatetime,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get createdUserID => $state.composableBuilder(
//       column: $state.table.createdUserID,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get updateduserid => $state.composableBuilder(
//       column: $state.table.updateduserid,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get lastupdateIp => $state.composableBuilder(
//       column: $state.table.lastupdateIp,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<double> get uPackSize => $state.composableBuilder(
//       column: $state.table.uPackSize,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<int> get uTINSPERBOX => $state.composableBuilder(
//       column: $state.table.uTINSPERBOX,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<double> get uSpecificGravity => $state.composableBuilder(
//       column: $state.table.uSpecificGravity,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get uPackSizeUom => $state.composableBuilder(
//       column: $state.table.uPackSizeUom,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));
// }

// class $$DriftItemMasterTableTableManager extends RootTableManager<
//     _$AppDatabase,
//     $DriftItemMasterTable,
//     DriftItemMasterData,
//     $$DriftItemMasterTableFilterComposer,
//     $$DriftItemMasterTableOrderingComposer,
//     $$DriftItemMasterTableCreateCompanionBuilder,
//     $$DriftItemMasterTableUpdateCompanionBuilder,
//     (
//       DriftItemMasterData,
//       BaseReferences<_$AppDatabase, $DriftItemMasterTable, DriftItemMasterData>
//     ),
//     DriftItemMasterData,
//     PrefetchHooks Function()> {
//   $$DriftItemMasterTableTableManager(
//       _$AppDatabase db, $DriftItemMasterTable table)
//       : super(TableManagerState(
//           db: db,
//           table: table,
//           filteringComposer:
//               $$DriftItemMasterTableFilterComposer(ComposerState(db, table)),
//           orderingComposer:
//               $$DriftItemMasterTableOrderingComposer(ComposerState(db, table)),
//           updateCompanionCallback: ({
//             Value<int> IMid = const Value.absent(),
//             Value<String?> itemname = const Value.absent(),
//             Value<String?> itemcode = const Value.absent(),
//             Value<String?> whsCode = const Value.absent(),
//             Value<String?> serialbatch = const Value.absent(),
//             Value<int?> quantity = const Value.absent(),
//             Value<String?> maximumQty = const Value.absent(),
//             Value<String?> minimumQty = const Value.absent(),
//             Value<String?> displayQty = const Value.absent(),
//             Value<String?> searchString = const Value.absent(),
//             Value<String?> category = const Value.absent(),
//             Value<double?> liter = const Value.absent(),
//             Value<String?> category1 = const Value.absent(),
//             Value<double?> weight = const Value.absent(),
//             Value<String?> hsnsac = const Value.absent(),
//             Value<String?> isActive = const Value.absent(),
//             Value<String?> isfreeby = const Value.absent(),
//             Value<String?> isinventory = const Value.absent(),
//             Value<String?> issellpricebyscrbat = const Value.absent(),
//             Value<String?> itemnamelong = const Value.absent(),
//             Value<String?> itemnameshort = const Value.absent(),
//             Value<String?> skucode = const Value.absent(),
//             Value<String?> subcategory = const Value.absent(),
//             Value<double?> sellprice = const Value.absent(),
//             Value<double?> mrpprice = const Value.absent(),
//             Value<double?> specialprice = const Value.absent(),
//             Value<String?> maxdiscount = const Value.absent(),
//             Value<double?> taxrate = const Value.absent(),
//             Value<String?> snapdatetime = const Value.absent(),
//             Value<String?> purchasedate = const Value.absent(),
//             Value<String?> createdateTime = const Value.absent(),
//             Value<String?> updatedDatetime = const Value.absent(),
//             Value<String?> createdUserID = const Value.absent(),
//             Value<String?> updateduserid = const Value.absent(),
//             Value<String?> lastupdateIp = const Value.absent(),
//             Value<double?> uPackSize = const Value.absent(),
//             Value<int?> uTINSPERBOX = const Value.absent(),
//             Value<double?> uSpecificGravity = const Value.absent(),
//             Value<String?> uPackSizeUom = const Value.absent(),
//           }) =>
//               DriftItemMasterCompanion(
//             IMid: IMid,
//             itemname: itemname,
//             itemcode: itemcode,
//             whsCode: whsCode,
//             serialbatch: serialbatch,
//             quantity: quantity,
//             maximumQty: maximumQty,
//             minimumQty: minimumQty,
//             displayQty: displayQty,
//             searchString: searchString,
//             category: category,
//             liter: liter,
//             category1: category1,
//             weight: weight,
//             hsnsac: hsnsac,
//             isActive: isActive,
//             isfreeby: isfreeby,
//             isinventory: isinventory,
//             issellpricebyscrbat: issellpricebyscrbat,
//             itemnamelong: itemnamelong,
//             itemnameshort: itemnameshort,
//             skucode: skucode,
//             subcategory: subcategory,
//             sellprice: sellprice,
//             mrpprice: mrpprice,
//             specialprice: specialprice,
//             maxdiscount: maxdiscount,
//             taxrate: taxrate,
//             snapdatetime: snapdatetime,
//             purchasedate: purchasedate,
//             createdateTime: createdateTime,
//             updatedDatetime: updatedDatetime,
//             createdUserID: createdUserID,
//             updateduserid: updateduserid,
//             lastupdateIp: lastupdateIp,
//             uPackSize: uPackSize,
//             uTINSPERBOX: uTINSPERBOX,
//             uSpecificGravity: uSpecificGravity,
//             uPackSizeUom: uPackSizeUom,
//           ),
//           createCompanionCallback: ({
//             Value<int> IMid = const Value.absent(),
//             Value<String?> itemname = const Value.absent(),
//             Value<String?> itemcode = const Value.absent(),
//             Value<String?> whsCode = const Value.absent(),
//             Value<String?> serialbatch = const Value.absent(),
//             Value<int?> quantity = const Value.absent(),
//             Value<String?> maximumQty = const Value.absent(),
//             Value<String?> minimumQty = const Value.absent(),
//             Value<String?> displayQty = const Value.absent(),
//             Value<String?> searchString = const Value.absent(),
//             Value<String?> category = const Value.absent(),
//             Value<double?> liter = const Value.absent(),
//             Value<String?> category1 = const Value.absent(),
//             Value<double?> weight = const Value.absent(),
//             Value<String?> hsnsac = const Value.absent(),
//             Value<String?> isActive = const Value.absent(),
//             Value<String?> isfreeby = const Value.absent(),
//             Value<String?> isinventory = const Value.absent(),
//             Value<String?> issellpricebyscrbat = const Value.absent(),
//             Value<String?> itemnamelong = const Value.absent(),
//             Value<String?> itemnameshort = const Value.absent(),
//             Value<String?> skucode = const Value.absent(),
//             Value<String?> subcategory = const Value.absent(),
//             Value<double?> sellprice = const Value.absent(),
//             Value<double?> mrpprice = const Value.absent(),
//             Value<double?> specialprice = const Value.absent(),
//             Value<String?> maxdiscount = const Value.absent(),
//             Value<double?> taxrate = const Value.absent(),
//             Value<String?> snapdatetime = const Value.absent(),
//             Value<String?> purchasedate = const Value.absent(),
//             Value<String?> createdateTime = const Value.absent(),
//             Value<String?> updatedDatetime = const Value.absent(),
//             Value<String?> createdUserID = const Value.absent(),
//             Value<String?> updateduserid = const Value.absent(),
//             Value<String?> lastupdateIp = const Value.absent(),
//             Value<double?> uPackSize = const Value.absent(),
//             Value<int?> uTINSPERBOX = const Value.absent(),
//             Value<double?> uSpecificGravity = const Value.absent(),
//             Value<String?> uPackSizeUom = const Value.absent(),
//           }) =>
//               DriftItemMasterCompanion.insert(
//             IMid: IMid,
//             itemname: itemname,
//             itemcode: itemcode,
//             whsCode: whsCode,
//             serialbatch: serialbatch,
//             quantity: quantity,
//             maximumQty: maximumQty,
//             minimumQty: minimumQty,
//             displayQty: displayQty,
//             searchString: searchString,
//             category: category,
//             liter: liter,
//             category1: category1,
//             weight: weight,
//             hsnsac: hsnsac,
//             isActive: isActive,
//             isfreeby: isfreeby,
//             isinventory: isinventory,
//             issellpricebyscrbat: issellpricebyscrbat,
//             itemnamelong: itemnamelong,
//             itemnameshort: itemnameshort,
//             skucode: skucode,
//             subcategory: subcategory,
//             sellprice: sellprice,
//             mrpprice: mrpprice,
//             specialprice: specialprice,
//             maxdiscount: maxdiscount,
//             taxrate: taxrate,
//             snapdatetime: snapdatetime,
//             purchasedate: purchasedate,
//             createdateTime: createdateTime,
//             updatedDatetime: updatedDatetime,
//             createdUserID: createdUserID,
//             updateduserid: updateduserid,
//             lastupdateIp: lastupdateIp,
//             uPackSize: uPackSize,
//             uTINSPERBOX: uTINSPERBOX,
//             uSpecificGravity: uSpecificGravity,
//             uPackSizeUom: uPackSizeUom,
//           ),
//           withReferenceMapper: (p0) => p0
//               .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
//               .toList(),
//           prefetchHooksCallback: null,
//         ));
// }

// typedef $$DriftItemMasterTableProcessedTableManager = ProcessedTableManager<
//     _$AppDatabase,
//     $DriftItemMasterTable,
//     DriftItemMasterData,
//     $$DriftItemMasterTableFilterComposer,
//     $$DriftItemMasterTableOrderingComposer,
//     $$DriftItemMasterTableCreateCompanionBuilder,
//     $$DriftItemMasterTableUpdateCompanionBuilder,
//     (
//       DriftItemMasterData,
//       BaseReferences<_$AppDatabase, $DriftItemMasterTable, DriftItemMasterData>
//     ),
//     DriftItemMasterData,
//     PrefetchHooks Function()>;
// typedef $$DriftProductMasterTableCreateCompanionBuilder
//     = DriftProductMasterCompanion Function({
//   Value<int> IMid,
//   Value<String?> itemname,
//   Value<String?> itemcode,
//   Value<String?> maximumQty,
//   Value<String?> minimumQty,
//   Value<String?> displayQty,
//   Value<String?> searchString,
//   Value<double?> liter,
//   Value<String?> category,
//   Value<String?> category1,
//   Value<String?> brand,
//   Value<String?> brand1,
//   Value<double?> weight,
//   Value<String?> hsnsac,
//   Value<String?> isActive,
//   Value<String?> isfreeby,
//   Value<String?> isinventory,
//   Value<String?> issellpricebyscrbat,
//   Value<String?> itemnamelong,
//   Value<String?> itemnameshort,
//   Value<String?> skucode,
//   Value<String?> subcategory,
//   Value<double?> sellprice,
//   Value<double?> mrpprice,
//   Value<double?> specialprice,
//   Value<String?> maxdiscount,
//   Value<double?> taxrate,
//   Value<String?> snapdatetime,
//   Value<String?> purchasedate,
//   Value<String?> createdateTime,
//   Value<String?> updatedDatetime,
//   Value<String?> createdUserID,
//   Value<String?> updateduserid,
//   Value<String?> lastupdateIp,
//   Value<double?> uPackSize,
//   Value<int?> uTINSPERBOX,
//   Value<double?> uSpecificGravity,
//   Value<String?> uPackSizeUom,
// });
// typedef $$DriftProductMasterTableUpdateCompanionBuilder
//     = DriftProductMasterCompanion Function({
//   Value<int> IMid,
//   Value<String?> itemname,
//   Value<String?> itemcode,
//   Value<String?> maximumQty,
//   Value<String?> minimumQty,
//   Value<String?> displayQty,
//   Value<String?> searchString,
//   Value<double?> liter,
//   Value<String?> category,
//   Value<String?> category1,
//   Value<String?> brand,
//   Value<String?> brand1,
//   Value<double?> weight,
//   Value<String?> hsnsac,
//   Value<String?> isActive,
//   Value<String?> isfreeby,
//   Value<String?> isinventory,
//   Value<String?> issellpricebyscrbat,
//   Value<String?> itemnamelong,
//   Value<String?> itemnameshort,
//   Value<String?> skucode,
//   Value<String?> subcategory,
//   Value<double?> sellprice,
//   Value<double?> mrpprice,
//   Value<double?> specialprice,
//   Value<String?> maxdiscount,
//   Value<double?> taxrate,
//   Value<String?> snapdatetime,
//   Value<String?> purchasedate,
//   Value<String?> createdateTime,
//   Value<String?> updatedDatetime,
//   Value<String?> createdUserID,
//   Value<String?> updateduserid,
//   Value<String?> lastupdateIp,
//   Value<double?> uPackSize,
//   Value<int?> uTINSPERBOX,
//   Value<double?> uSpecificGravity,
//   Value<String?> uPackSizeUom,
// });

// class $$DriftProductMasterTableFilterComposer
//     extends FilterComposer<_$AppDatabase, $DriftProductMasterTable> {
//   $$DriftProductMasterTableFilterComposer(super.$state);
//   ColumnFilters<int> get IMid => $state.composableBuilder(
//       column: $state.table.IMid,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get itemname => $state.composableBuilder(
//       column: $state.table.itemname,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get itemcode => $state.composableBuilder(
//       column: $state.table.itemcode,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get maximumQty => $state.composableBuilder(
//       column: $state.table.maximumQty,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get minimumQty => $state.composableBuilder(
//       column: $state.table.minimumQty,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get displayQty => $state.composableBuilder(
//       column: $state.table.displayQty,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get searchString => $state.composableBuilder(
//       column: $state.table.searchString,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<double> get liter => $state.composableBuilder(
//       column: $state.table.liter,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get category => $state.composableBuilder(
//       column: $state.table.category,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get category1 => $state.composableBuilder(
//       column: $state.table.category1,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get brand => $state.composableBuilder(
//       column: $state.table.brand,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get brand1 => $state.composableBuilder(
//       column: $state.table.brand1,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<double> get weight => $state.composableBuilder(
//       column: $state.table.weight,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get hsnsac => $state.composableBuilder(
//       column: $state.table.hsnsac,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get isActive => $state.composableBuilder(
//       column: $state.table.isActive,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get isfreeby => $state.composableBuilder(
//       column: $state.table.isfreeby,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get isinventory => $state.composableBuilder(
//       column: $state.table.isinventory,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get issellpricebyscrbat => $state.composableBuilder(
//       column: $state.table.issellpricebyscrbat,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get itemnamelong => $state.composableBuilder(
//       column: $state.table.itemnamelong,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get itemnameshort => $state.composableBuilder(
//       column: $state.table.itemnameshort,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get skucode => $state.composableBuilder(
//       column: $state.table.skucode,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get subcategory => $state.composableBuilder(
//       column: $state.table.subcategory,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<double> get sellprice => $state.composableBuilder(
//       column: $state.table.sellprice,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<double> get mrpprice => $state.composableBuilder(
//       column: $state.table.mrpprice,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<double> get specialprice => $state.composableBuilder(
//       column: $state.table.specialprice,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get maxdiscount => $state.composableBuilder(
//       column: $state.table.maxdiscount,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<double> get taxrate => $state.composableBuilder(
//       column: $state.table.taxrate,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get snapdatetime => $state.composableBuilder(
//       column: $state.table.snapdatetime,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get purchasedate => $state.composableBuilder(
//       column: $state.table.purchasedate,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get createdateTime => $state.composableBuilder(
//       column: $state.table.createdateTime,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get updatedDatetime => $state.composableBuilder(
//       column: $state.table.updatedDatetime,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get createdUserID => $state.composableBuilder(
//       column: $state.table.createdUserID,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get updateduserid => $state.composableBuilder(
//       column: $state.table.updateduserid,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get lastupdateIp => $state.composableBuilder(
//       column: $state.table.lastupdateIp,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<double> get uPackSize => $state.composableBuilder(
//       column: $state.table.uPackSize,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<int> get uTINSPERBOX => $state.composableBuilder(
//       column: $state.table.uTINSPERBOX,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<double> get uSpecificGravity => $state.composableBuilder(
//       column: $state.table.uSpecificGravity,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));

//   ColumnFilters<String> get uPackSizeUom => $state.composableBuilder(
//       column: $state.table.uPackSizeUom,
//       builder: (column, joinBuilders) =>
//           ColumnFilters(column, joinBuilders: joinBuilders));
// }

// class $$DriftProductMasterTableOrderingComposer
//     extends OrderingComposer<_$AppDatabase, $DriftProductMasterTable> {
//   $$DriftProductMasterTableOrderingComposer(super.$state);
//   ColumnOrderings<int> get IMid => $state.composableBuilder(
//       column: $state.table.IMid,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get itemname => $state.composableBuilder(
//       column: $state.table.itemname,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get itemcode => $state.composableBuilder(
//       column: $state.table.itemcode,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get maximumQty => $state.composableBuilder(
//       column: $state.table.maximumQty,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get minimumQty => $state.composableBuilder(
//       column: $state.table.minimumQty,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get displayQty => $state.composableBuilder(
//       column: $state.table.displayQty,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get searchString => $state.composableBuilder(
//       column: $state.table.searchString,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<double> get liter => $state.composableBuilder(
//       column: $state.table.liter,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get category => $state.composableBuilder(
//       column: $state.table.category,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get category1 => $state.composableBuilder(
//       column: $state.table.category1,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get brand => $state.composableBuilder(
//       column: $state.table.brand,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get brand1 => $state.composableBuilder(
//       column: $state.table.brand1,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<double> get weight => $state.composableBuilder(
//       column: $state.table.weight,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get hsnsac => $state.composableBuilder(
//       column: $state.table.hsnsac,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get isActive => $state.composableBuilder(
//       column: $state.table.isActive,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get isfreeby => $state.composableBuilder(
//       column: $state.table.isfreeby,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get isinventory => $state.composableBuilder(
//       column: $state.table.isinventory,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get issellpricebyscrbat => $state.composableBuilder(
//       column: $state.table.issellpricebyscrbat,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get itemnamelong => $state.composableBuilder(
//       column: $state.table.itemnamelong,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get itemnameshort => $state.composableBuilder(
//       column: $state.table.itemnameshort,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get skucode => $state.composableBuilder(
//       column: $state.table.skucode,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get subcategory => $state.composableBuilder(
//       column: $state.table.subcategory,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<double> get sellprice => $state.composableBuilder(
//       column: $state.table.sellprice,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<double> get mrpprice => $state.composableBuilder(
//       column: $state.table.mrpprice,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<double> get specialprice => $state.composableBuilder(
//       column: $state.table.specialprice,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get maxdiscount => $state.composableBuilder(
//       column: $state.table.maxdiscount,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<double> get taxrate => $state.composableBuilder(
//       column: $state.table.taxrate,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get snapdatetime => $state.composableBuilder(
//       column: $state.table.snapdatetime,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get purchasedate => $state.composableBuilder(
//       column: $state.table.purchasedate,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get createdateTime => $state.composableBuilder(
//       column: $state.table.createdateTime,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get updatedDatetime => $state.composableBuilder(
//       column: $state.table.updatedDatetime,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get createdUserID => $state.composableBuilder(
//       column: $state.table.createdUserID,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get updateduserid => $state.composableBuilder(
//       column: $state.table.updateduserid,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get lastupdateIp => $state.composableBuilder(
//       column: $state.table.lastupdateIp,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<double> get uPackSize => $state.composableBuilder(
//       column: $state.table.uPackSize,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<int> get uTINSPERBOX => $state.composableBuilder(
//       column: $state.table.uTINSPERBOX,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<double> get uSpecificGravity => $state.composableBuilder(
//       column: $state.table.uSpecificGravity,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));

//   ColumnOrderings<String> get uPackSizeUom => $state.composableBuilder(
//       column: $state.table.uPackSizeUom,
//       builder: (column, joinBuilders) =>
//           ColumnOrderings(column, joinBuilders: joinBuilders));
// }

// class $$DriftProductMasterTableTableManager extends RootTableManager<
//     _$AppDatabase,
//     $DriftProductMasterTable,
//     DriftProductMasterData,
//     $$DriftProductMasterTableFilterComposer,
//     $$DriftProductMasterTableOrderingComposer,
//     $$DriftProductMasterTableCreateCompanionBuilder,
//     $$DriftProductMasterTableUpdateCompanionBuilder,
//     (
//       DriftProductMasterData,
//       BaseReferences<_$AppDatabase, $DriftProductMasterTable,
//           DriftProductMasterData>
//     ),
//     DriftProductMasterData,
//     PrefetchHooks Function()> {
//   $$DriftProductMasterTableTableManager(
//       _$AppDatabase db, $DriftProductMasterTable table)
//       : super(TableManagerState(
//           db: db,
//           table: table,
//           filteringComposer:
//               $$DriftProductMasterTableFilterComposer(ComposerState(db, table)),
//           orderingComposer: $$DriftProductMasterTableOrderingComposer(
//               ComposerState(db, table)),
//           updateCompanionCallback: ({
//             Value<int> IMid = const Value.absent(),
//             Value<String?> itemname = const Value.absent(),
//             Value<String?> itemcode = const Value.absent(),
//             Value<String?> maximumQty = const Value.absent(),
//             Value<String?> minimumQty = const Value.absent(),
//             Value<String?> displayQty = const Value.absent(),
//             Value<String?> searchString = const Value.absent(),
//             Value<double?> liter = const Value.absent(),
//             Value<String?> category = const Value.absent(),
//             Value<String?> category1 = const Value.absent(),
//             Value<String?> brand = const Value.absent(),
//             Value<String?> brand1 = const Value.absent(),
//             Value<double?> weight = const Value.absent(),
//             Value<String?> hsnsac = const Value.absent(),
//             Value<String?> isActive = const Value.absent(),
//             Value<String?> isfreeby = const Value.absent(),
//             Value<String?> isinventory = const Value.absent(),
//             Value<String?> issellpricebyscrbat = const Value.absent(),
//             Value<String?> itemnamelong = const Value.absent(),
//             Value<String?> itemnameshort = const Value.absent(),
//             Value<String?> skucode = const Value.absent(),
//             Value<String?> subcategory = const Value.absent(),
//             Value<double?> sellprice = const Value.absent(),
//             Value<double?> mrpprice = const Value.absent(),
//             Value<double?> specialprice = const Value.absent(),
//             Value<String?> maxdiscount = const Value.absent(),
//             Value<double?> taxrate = const Value.absent(),
//             Value<String?> snapdatetime = const Value.absent(),
//             Value<String?> purchasedate = const Value.absent(),
//             Value<String?> createdateTime = const Value.absent(),
//             Value<String?> updatedDatetime = const Value.absent(),
//             Value<String?> createdUserID = const Value.absent(),
//             Value<String?> updateduserid = const Value.absent(),
//             Value<String?> lastupdateIp = const Value.absent(),
//             Value<double?> uPackSize = const Value.absent(),
//             Value<int?> uTINSPERBOX = const Value.absent(),
//             Value<double?> uSpecificGravity = const Value.absent(),
//             Value<String?> uPackSizeUom = const Value.absent(),
//           }) =>
//               DriftProductMasterCompanion(
//             IMid: IMid,
//             itemname: itemname,
//             itemcode: itemcode,
//             maximumQty: maximumQty,
//             minimumQty: minimumQty,
//             displayQty: displayQty,
//             searchString: searchString,
//             liter: liter,
//             category: category,
//             category1: category1,
//             brand: brand,
//             brand1: brand1,
//             weight: weight,
//             hsnsac: hsnsac,
//             isActive: isActive,
//             isfreeby: isfreeby,
//             isinventory: isinventory,
//             issellpricebyscrbat: issellpricebyscrbat,
//             itemnamelong: itemnamelong,
//             itemnameshort: itemnameshort,
//             skucode: skucode,
//             subcategory: subcategory,
//             sellprice: sellprice,
//             mrpprice: mrpprice,
//             specialprice: specialprice,
//             maxdiscount: maxdiscount,
//             taxrate: taxrate,
//             snapdatetime: snapdatetime,
//             purchasedate: purchasedate,
//             createdateTime: createdateTime,
//             updatedDatetime: updatedDatetime,
//             createdUserID: createdUserID,
//             updateduserid: updateduserid,
//             lastupdateIp: lastupdateIp,
//             uPackSize: uPackSize,
//             uTINSPERBOX: uTINSPERBOX,
//             uSpecificGravity: uSpecificGravity,
//             uPackSizeUom: uPackSizeUom,
//           ),
//           createCompanionCallback: ({
//             Value<int> IMid = const Value.absent(),
//             Value<String?> itemname = const Value.absent(),
//             Value<String?> itemcode = const Value.absent(),
//             Value<String?> maximumQty = const Value.absent(),
//             Value<String?> minimumQty = const Value.absent(),
//             Value<String?> displayQty = const Value.absent(),
//             Value<String?> searchString = const Value.absent(),
//             Value<double?> liter = const Value.absent(),
//             Value<String?> category = const Value.absent(),
//             Value<String?> category1 = const Value.absent(),
//             Value<String?> brand = const Value.absent(),
//             Value<String?> brand1 = const Value.absent(),
//             Value<double?> weight = const Value.absent(),
//             Value<String?> hsnsac = const Value.absent(),
//             Value<String?> isActive = const Value.absent(),
//             Value<String?> isfreeby = const Value.absent(),
//             Value<String?> isinventory = const Value.absent(),
//             Value<String?> issellpricebyscrbat = const Value.absent(),
//             Value<String?> itemnamelong = const Value.absent(),
//             Value<String?> itemnameshort = const Value.absent(),
//             Value<String?> skucode = const Value.absent(),
//             Value<String?> subcategory = const Value.absent(),
//             Value<double?> sellprice = const Value.absent(),
//             Value<double?> mrpprice = const Value.absent(),
//             Value<double?> specialprice = const Value.absent(),
//             Value<String?> maxdiscount = const Value.absent(),
//             Value<double?> taxrate = const Value.absent(),
//             Value<String?> snapdatetime = const Value.absent(),
//             Value<String?> purchasedate = const Value.absent(),
//             Value<String?> createdateTime = const Value.absent(),
//             Value<String?> updatedDatetime = const Value.absent(),
//             Value<String?> createdUserID = const Value.absent(),
//             Value<String?> updateduserid = const Value.absent(),
//             Value<String?> lastupdateIp = const Value.absent(),
//             Value<double?> uPackSize = const Value.absent(),
//             Value<int?> uTINSPERBOX = const Value.absent(),
//             Value<double?> uSpecificGravity = const Value.absent(),
//             Value<String?> uPackSizeUom = const Value.absent(),
//           }) =>
//               DriftProductMasterCompanion.insert(
//             IMid: IMid,
//             itemname: itemname,
//             itemcode: itemcode,
//             maximumQty: maximumQty,
//             minimumQty: minimumQty,
//             displayQty: displayQty,
//             searchString: searchString,
//             liter: liter,
//             category: category,
//             category1: category1,
//             brand: brand,
//             brand1: brand1,
//             weight: weight,
//             hsnsac: hsnsac,
//             isActive: isActive,
//             isfreeby: isfreeby,
//             isinventory: isinventory,
//             issellpricebyscrbat: issellpricebyscrbat,
//             itemnamelong: itemnamelong,
//             itemnameshort: itemnameshort,
//             skucode: skucode,
//             subcategory: subcategory,
//             sellprice: sellprice,
//             mrpprice: mrpprice,
//             specialprice: specialprice,
//             maxdiscount: maxdiscount,
//             taxrate: taxrate,
//             snapdatetime: snapdatetime,
//             purchasedate: purchasedate,
//             createdateTime: createdateTime,
//             updatedDatetime: updatedDatetime,
//             createdUserID: createdUserID,
//             updateduserid: updateduserid,
//             lastupdateIp: lastupdateIp,
//             uPackSize: uPackSize,
//             uTINSPERBOX: uTINSPERBOX,
//             uSpecificGravity: uSpecificGravity,
//             uPackSizeUom: uPackSizeUom,
//           ),
//           withReferenceMapper: (p0) => p0
//               .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
//               .toList(),
//           prefetchHooksCallback: null,
//         ));
// }

// typedef $$DriftProductMasterTableProcessedTableManager = ProcessedTableManager<
//     _$AppDatabase,
//     $DriftProductMasterTable,
//     DriftProductMasterData,
//     $$DriftProductMasterTableFilterComposer,
//     $$DriftProductMasterTableOrderingComposer,
//     $$DriftProductMasterTableCreateCompanionBuilder,
//     $$DriftProductMasterTableUpdateCompanionBuilder,
//     (
//       DriftProductMasterData,
//       BaseReferences<_$AppDatabase, $DriftProductMasterTable,
//           DriftProductMasterData>
//     ),
//     DriftProductMasterData,
//     PrefetchHooks Function()>;

// class $AppDatabaseManager {
//   final _$AppDatabase _db;
//   $AppDatabaseManager(this._db);
//   $$DriftItemMasterTableTableManager get driftItemMaster =>
//       $$DriftItemMasterTableTableManager(_db, _db.driftItemMaster);
//   $$DriftProductMasterTableTableManager get driftProductMaster =>
//       $$DriftProductMasterTableTableManager(_db, _db.driftProductMaster);
// }
