// // ignore_for_file: use_build_context_synchronously, prefer_interpolation_to_compose_strings, non_constant_identifier_names, unused_local_variable

// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'package:dart_amqp/dart_amqp.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:posbillingdesign/Widgets/AlertBox.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sqflite/sqflite.dart';
// import '../../Constant/AppConstant.dart';
// import '../../Constant/Configuration.dart';
// import '../../Constant/ConstantRoutes.dart';
// import '../../Constant/Screen.dart';
// import '../../Constant/UserValues.dart';
// import '../../DB Helper/DBOperation.dart';
// import '../../DB Helper/DBhelper.dart';
// import '../../DBModel/StockInwardBatchModel.dart';
// import '../../DBModel/StockinwardHeader.dart';
// import '../../DBModel/StockinwardLineData.dart';
// import '../../Models/DataModel/StockInwardModel/StockInwardListModel.dart';
// // import '../../Models/DataModel/StockOutwardModel/StockOutwardListModel.dart';
// import '../../Models/SearBox/SearchModel.dart';
// import '../../Models/ServiceLayerModel/ErrorModell/ErrorModelSl.dart';
// import '../../Models/ServiceLayerModel/SAPInwardModel/SapInwardModel.dart';
// import '../../Pages/DashBoard/Screens/DashBoardScreen.dart';
// import 'package:intl/intl.dart';
// import '../../ServiceLayerAPIss/StockInwardAPI/GetInwardAPI.dart';
// import '../../ServiceLayerAPIss/StockInwardAPI/IntwardLoginnAPI.dart';
// import '../../ServiceLayerAPIss/StockInwardAPI/InwardCancelAPI.dart';
// import '../../Widgets/ContentContainer.dart';

// class StockInwardController extends ChangeNotifier {
// 
// 
// 
// 
// 
//   void init() {
//   
//     clear();
//     tappage = PageController(initialPage: 0);
//   
//     getStockOutData();
//     gethold();
//   }

//   bool isselect = false;
//   String SapDocentry = '';
//   String SapDocuNumber = '';
//   Future<SharedPreferences> pref = SharedPreferences.getInstance();
//   bool loadingscrn = false;
//   bool cancelbtn = false;
//   String? seriesValue;
//   String? custserieserrormsg = '';
//   bool seriesValuebool = true;
//   List<ErrorModel> sererrorlist = [];
//   List<StockTransferInwrdLine> sapInwardModelData = [];
//   String? stkreqfromwhs;
//   String holddocentry = '';
//   ErrorModel? errmodel = ErrorModel();

//   isselectmethod() {
//     isselect = !isselect;
//     log(isselect.toString());
//     notifyListeners();
//   }

//   clear() {
//     StockInward.clear();
//     StockOutDATA.clear();
//     isselect = false;
//     passdata!.clear();
//     cancelbtn = false;
//     i_value = 0;
//     batch_datalist = null;
//     batch_i = 0;
//     notifyListeners();
//   }

//   pagePlus() {
//   
//   
//     tappageIndex = 0;
//     tappage.jumpToPage(1);
//   
//   
//     notifyListeners();
//   
//   
//   }

//   pageminus() {
//     tappageIndex = 1;
//   
//   
//   

//     tappage.animateToPage(--tappageIndex,
//         duration: const Duration(milliseconds: 400),
//         curve: Curves.linearToEaseOut);
//     notifyListeners();
//   }

//   clearDataAll() {
//   
//     page = PageController(initialPage: 0);
//     tappage = PageController(initialPage: 0);
//     pageIndex = 0;
//     tappageIndex = 0;
//     StInController2[50].text = "";
//     passdata = [];
//     selectIndex;
//     OnclickDisable = false;
//     notifyListeners();
//   
//   
//   
//   
//   
//   
//   
//   
//   
//   }

//   deletereq() async {
//     final Database db = (await DBHelper.getInstance())!;
//     await DBOperation.deletereq(db);
//   }

//   Config config = Config();

//   PageController page = PageController(initialPage: 0);
//   PageController tappage = PageController(initialPage: 0);

//   int pageIndex = 0;
//   int tappageIndex = 0;
//   bool OndDisablebutton = false;

//   List<TextEditingController> StInController =
//       List.generate(150, (i) => TextEditingController());

//   List<TextEditingController> StInController2 =
//       List.generate(150, (i) => TextEditingController());

//   int i_value = 0;
//   int get get_i_value => i_value;
//   int ScannigVal = 0;
//   int get get_ScannigVal => ScannigVal;
//   int Scanned_Val = 0;
//   int get get_Scanned_Val => Scanned_Val;
//   int? selectIndex;
//   int selectIndex2 = 0;
//   String? msg = '';
//   bool? OnclickDisable = false;
//   bool? OnScanDisable = false;

// //

//   Selectindex(int i) {
//     selectIndex = i;
//     notifyListeners();
//   }

//   Selectindex2(int i) {
//     selectIndex2 = i;
//     notifyListeners();
//   }

// 
// 
// 
// 
// 
// 
//   List<StockInwardDetails>? Scandata;
//   List<String> ScandSerial = [];
// 
//   List<List<String>>? test2;
//   int scannvalue2 = 0;
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 

//   searchInitMethod() {
//     StInController[100].text = config.alignDate(config.currentDate());
//     StInController[101].text = config.alignDate(config.currentDate());
//     notifyListeners();
//   }

//   List<searchModel> searchData = [];
//   List<searchModel> filtersearchData = [];

//   filterSearchBoxList(String v) {
//     if (v.isNotEmpty) {
//       filtersearchData = searchData
//           .where((e) =>
//               e.customeraName.toLowerCase().contains(v.toLowerCase()) ||
//               e.docNo.toString().contains(v.toLowerCase()))
//           .toList();
//       notifyListeners();
//     } else if (v.isEmpty) {
//       filtersearchData = searchData;
//       notifyListeners();
//     }
//   }

//   bool searchbool = false;
//   getSalesDataDatewise(String fromdate, String todate) async {
//   
//   

//     searchbool = true;
//     final Database db = (await DBHelper.getInstance())!;
//     List<Map<String, Object?>> getStockinHeader =
//         await DBOperation.getStockInHeaderDateWise(
//             db, config.alignDate2(fromdate), config.alignDate2(todate));

//     List<searchModel> searchdata2 = [];
//     searchData.clear();

//     if (getStockinHeader.isNotEmpty) {
//       for (int i = 0; i < getStockinHeader.length; i++) {
//         searchdata2.add(searchModel(
//             username: UserValues.username,
//             terminal: AppConstant.terminal,
//           
//           
//           
//             qStatus: getStockinHeader[i]["qStatus"] == null
//                 ? ""
//                 : getStockinHeader[i]["qStatus"].toString(),
//             docentry: getStockinHeader[i]["docentry"] == null
//                 ? 0
//                 : int.parse(getStockinHeader[i]["docentry"].toString()),
//             docNo: getStockinHeader[i]["reqdocno"] == null
//                 ? "0"
//                 : getStockinHeader[i]["reqdocno"].toString(),
//             docDate: getStockinHeader[i]["createdateTime"].toString(),
//             sapNo: getStockinHeader[i]["sapDocNo"] == null
//                 ? 0
//                 : int.parse(getStockinHeader[i]["sapDocNo"].toString()),
//             sapDate: getStockinHeader[i]["createdateTime"] == null
//                 ? ""
//                 : getStockinHeader[i]["createdateTime"].toString(),
//             customeraName: getStockinHeader[i]["reqtoWhs"] == null
//                 ? ""
//                 : getStockinHeader[i]["reqtoWhs"].toString(),
//             doctotal: getStockinHeader[i][""] == null
//                 ? 0
//                 : double.parse(getStockinHeader[i][""].toString())));
//         notifyListeners();
//       }
//       searchData.addAll(searchdata2);
//       filtersearchData = searchData;
//     } else {
//     
//       searchbool = false;
//       searchData.clear();
//       notifyListeners();
//     }
//     notifyListeners();
//   }

//   List<StockInwardList> StockInward2 = [];

//   fixDataMethod(int docentry) async {
//     StockInward2.clear();
//     StInController2[50].text = "";
//     SapDocentry = '';
//     SapDocuNumber = '';
//     if (isselect == true) {
//       isselect = false;
//     }
//     final Database db = (await DBHelper.getInstance())!;
//     List<Map<String, Object?>> getDB_StInHeader =
//         await DBOperation.getStockInHeader(db, docentry);
//     List<Map<String, Object?>> getDB_StInLine =
//         await DBOperation.StInLineDB(db, docentry);
//     List<StockInwardList> StockOutDATA2 = [];
//     List<StockInwardDetails> stockDetails2 = [];
//   
//   
//   
//   
// //  List<StockInwardDetails> stoutDetails = [];
// //     List<StockInwardList> stoutList = [];

// // List<StockInwardList> stoutList=[];
//     for (int j = 0; j < getDB_StInLine.length; j++) {
//       List<StockInSerialbatch> stoutSeralBatchList = [];

//       stockDetails2.add(StockInwardDetails(
//           createdUserID: 1,
//           createdateTime: getDB_StInLine[j]["createdateTime"].toString(),
//           baseDocentry: int.parse(getDB_StInLine[j]["baseDocentry"].toString()),
//           docentry: int.parse(getDB_StInLine[j]["docentry"].toString()),
//           dscription: getDB_StInLine[j]["description"].toString(),
//           itemcode: getDB_StInLine[j]["itemcode"].toString(),
//           lastupdateIp: "",
//           lineNo: getDB_StInLine[j]["lineno"] == null
//               ? 0
//               : int.parse(getDB_StInLine[j]["lineno"].toString()),
//           qty: getDB_StInLine[j]["quantity"] == null
//               ? 0
//               : int.parse(getDB_StInLine[j]["quantity"].toString()),
//           status: getDB_StInLine[j]["createdateTime"].toString(),
//           updatedDatetime: getDB_StInLine[j]["createdateTime"].toString(),
//           updateduserid: 1,
//           price: 1,
//           serialBatch: getDB_StInLine[j]["serialBatch"].toString(),
//           taxRate: 0.0,
//           taxType: "",
//           trans_Qty: getDB_StInLine[j]["transferQty"] == null
//               ? 0
//               : int.parse(getDB_StInLine[j]["transferQty"].toString()),
//           Scanned_Qty: getDB_StInLine[j]["scannedQty"] == null
//               ? 0
//               : int.parse(getDB_StInLine[j]["scannedQty"].toString()),
//           baseDocline: getDB_StInLine[j]["baseDocline"] == null
//               ? 0
//               : int.parse(getDB_StInLine[j]["baseDocline"].toString()),
//           serialbatchList: stoutSeralBatchList));
//     }
//     StInController2[50].text = getDB_StInHeader[0]["remarks"].toString();
//     StockOutDATA2.add(StockInwardList(
//         remarks: getDB_StInHeader[0]["remarks"].toString(),
//         branch: getDB_StInHeader[0]["branch"].toString(),
//       
//       
//         docentry: getDB_StInHeader[0]["docentry"].toString(),
//         baceDocentry: getDB_StInHeader[0]["baceDocentry"].toString(),
//         docstatus: getDB_StInHeader[0]["baceDocentry"].toString(),
//         documentno: getDB_StInHeader[0]["documentno"] == null
//             ? "0"
//             : getDB_StInHeader[0]["documentno"].toString(),
//       
//       
//       
//       
//       
//       
//       
//         reqfromWhs: getDB_StInHeader[0]["reqfromWhs"].toString(),
//       
//         reqtoWhs: getDB_StInHeader[0]["reqtoWhs"].toString(),
//         reqtransdate: getDB_StInHeader[0]["transdate"].toString(),
//       
//       
//       
//       
//       
//       
//       
//       
//       
//       
//       
//       
//         data: stockDetails2));
//     SapDocentry = getDB_StInHeader[0]["sapDocentry"].toString();
//     SapDocuNumber = getDB_StInHeader[0]["sapDocNo"].toString();
//     StockInward2.addAll(StockOutDATA2);
//     notifyListeners();
//   }

//   List<GlobalKey<FormState>> formkey =
//       List.generate(50, (i) => GlobalKey<FormState>());

// 
// 
// 

// 
// 
// 
// 
// 
// 
// 

// 
// 
// 
// 

// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 

// 
// 

// 
// 
// 
// 
// 
// 
// 

// 
// 
// 
// 
// 
// 
// 

// 
// 

//   getDate2(BuildContext context, datetype) async {
//     DateTime? pickedDate = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(2000),
//         lastDate: DateTime(2100));

//     if (pickedDate != null && datetype == "From") {
//     
//       datetype = DateFormat('dd-MM-yyyy').format(pickedDate);
//       StInController[100].text = datetype!;
//     
//     } else if (pickedDate != null && datetype == "To") {
//     
//       datetype = DateFormat('dd-MM-yyyy').format(pickedDate);
//       StInController[101].text = datetype!;
//     
//     } else {
//     
//     }
//   }

//   Future StInLineRefersh(
//       int index, int list_i, List<StockInSerialbatch>? serialbatchList2) async {
//     int totalscannedQty = 0;
//     if (StockInward[index].data[list_i].serialbatchList != null) {
//       for (int i = 0;
//           i < StockInward[index].data[list_i].serialbatchList!.length;
//           i++) {
//         totalscannedQty = totalscannedQty +
//             StockInward[index].data[list_i].serialbatchList![i].qty!;
//       }
//       StockInward[index].data[list_i].serialbatchList = serialbatchList2;
//       StockInward[index].data[list_i].Scanned_Qty = totalscannedQty;
//     }
//   

//     StInController[0].clear();
//     notifyListeners();
//   }

//   setstatemethod() {
//     notifyListeners();
//   }

//   passData(ThemeData theme, BuildContext context, int index) {
//     log("StockOutward[index].data length:" +
//         StockInward[index].data.length.toString());
//     if (StockInward[index].data.isNotEmpty) {
//     
//     
//     
//     
//     
//       selectIndex = index;
//       i_value = index;

//       passdata = StockInward[index].data;
//       notifyListeners();

//     
//     } else if (StockInward[index].data.isEmpty) {
//       showDialog(
//           context: context,
//           barrierDismissible: true,
//           builder: (BuildContext context) {
//             return AlertDialog(
//                 contentPadding: const EdgeInsets.all(0),
//                 content: AlertBox(
//                     payMent: 'Alert',
//                     errormsg: true,
//                     widget: Center(
//                         child: ContentContainer(
//                       content: 'This Item Saved in DraftBill..!!',
//                       theme: theme,
//                     )),
//                     buttonName: null));
//           });
//     }
//     notifyListeners();
//   }

//   Future scanqtyRemove(int index, int list_i, int batchI) async {
//     final Database db = (await DBHelper.getInstance())!;
//   
//   

//   
//   
//   
//   
//   
//   
//   
//   

//   
//   

//     if (StockInward[index].data[list_i].trans_Qty! !=
//         StockInward[index].data[list_i].serialbatchList![batchI].qty!) {
//       StockInward[index].data[list_i].serialbatchList![batchI].qty =
//           StockInward[index].data[list_i].serialbatchList![batchI].qty! - 1;
//       msg = "";
//       notifyListeners();
//       if (StockInward[index].data[list_i].serialbatchList![batchI].qty! == 0) {
//       
//       
//       
//       
//       
//       

//         await DBOperation.deleteBatch_StIn(
//             db,
//             int.parse(StockInward[index]
//                 .data[list_i]
//                 .serialbatchList![batchI]
//                 .baseDocentry!
//                 .toString()),
//             int.parse(StockInward[index]
//                 .data[list_i]
//                 .serialbatchList![batchI]
//                 .lineno
//                 .toString()),
//             StockInward[index]
//                 .data[list_i]
//                 .serialbatchList![batchI]
//                 .itemcode
//                 .toString());
//         StockInward[index].data[list_i].serialbatchList!.removeAt(batchI);
//       } else if (StockInward[index]
//               .data[list_i]
//               .serialbatchList![batchI]
//               .qty! >=
//           1) {
//       
//         await DBOperation.UpdateQTYBatch_StIn(
//             db,
//             int.parse(StockInward[index]
//                 .data[list_i]
//                 .serialbatchList![batchI]
//                 .baseDocentry!
//                 .toString()),
//             int.parse(StockInward[index]
//                 .data[list_i]
//                 .serialbatchList![batchI]
//                 .lineno
//                 .toString()),
//             StockInward[index]
//                 .data[list_i]
//                 .serialbatchList![batchI]
//                 .itemcode
//                 .toString());
//       }
//     } else if (StockInward[index].data[list_i].trans_Qty ==
//         StockInward[index].data[list_i].serialbatchList![batchI].qty) {
//     
//       msg = 'Alreaty This Item is Submited...!!';
//     } // return StockInward[index].data[list_i].serialbatchList![batchI].qty;
//     notifyListeners();
//   }

//   scanmethod(int index, StockInwardDetails? data, int list_i) async {
//     OnScanDisable = true;
//     String serialBatch = "";
//     int qty = 0;
//   
//     final Database db = (await DBHelper.getInstance())!;

//   
//   
//   
//   
//     if (StInController[0].text.isNotEmpty) {
//       for (int k = 0; k < data!.StOutSerialbatchList!.length; k++) {
//         if (data.StOutSerialbatchList![k].serialbatch ==
//             StInController[0].text.trim()) {
//           serialBatch = data.StOutSerialbatchList![k].serialbatch.toString();
//           qty = data.StOutSerialbatchList![k].qty!;
//         }
//       }
//       print("Serialbartcjc::" + serialBatch.toString());

//       if (serialBatch.isNotEmpty) {
//         print(
//             "${StockInward[index].data[list_i].serialbatchList} Serialbartcjc1:: " +
//                 serialBatch.toString());

//         int totalscanqty = 0;

//         if (StockInward[index].data[list_i].serialbatchList != null) {
//           print("test_+1");
//           bool AlreadyScan = false;
//           int AlreadyScanQty = 0;
//           for (int i = 0;
//               i < StockInward[index].data[list_i].serialbatchList!.length;
//               i++) {
//             totalscanqty = totalscanqty +
//                 StockInward[index].data[list_i].serialbatchList![i].qty!;
//             if (serialBatch ==
//                 StockInward[index]
//                     .data[list_i]
//                     .serialbatchList![i]
//                     .serialbatch) {
//               AlreadyScan = true;
//               AlreadyScanQty =
//                   StockInward[index].data[list_i].serialbatchList![i].qty!;
//             }
//             notifyListeners();
//           }
//           if (StockInward[index].data[list_i].trans_Qty! > totalscanqty) {
//             print("Already Scan::" + AlreadyScan.toString());
//             if (AlreadyScan == true) {
//               if (AlreadyScanQty < qty) {
//                 for (int k = 0;
//                     k < StockInward[index].data[list_i].serialbatchList!.length;
//                     k++) {
//                   if (serialBatch ==
//                       StockInward[index]
//                           .data[list_i]
//                           .serialbatchList![k]
//                           .serialbatch) {
//                     StockInward[index].data[list_i].serialbatchList![k].qty =
//                         StockInward[index]
//                                 .data[list_i]
//                                 .serialbatchList![k]
//                                 .qty! +
//                             1;
//                     notifyListeners();
//                   }
//                   notifyListeners();
//                 }
//               } else {
//                 msg = 'Please Scan Other SerialBatch...!!';
//               }
//               notifyListeners();
//             } else {
//               print("Already Scan2::" + AlreadyScan.toString());

//               StockInward[index]
//                   .data[list_i]
//                   .serialbatchList!
//                   .add(StockInSerialbatch(
//                     lineno: StockInward[index].data[list_i].lineNo.toString(),
//                     baseDocentry:
//                         StockInward[index].data[list_i].baseDocentry.toString(),
//                     itemcode: StockInward[index].data[list_i].itemcode,
//                     qty: 1,
//                     serialbatch: serialBatch.toString().trim(),
//                     docstatus: null,
//                   ));
//               notifyListeners();
//             }
//           } else {
//           
//             msg = 'No More Qty to add...!!';
//           }
//         } else {
//           List<StockInSerialbatch> StInBatch = [];
//           print("111");
//           StInBatch.add(StockInSerialbatch(
//             lineno: StockInward[index].data[list_i].lineNo.toString(),
//             baseDocentry:
//                 StockInward[index].data[list_i].baseDocentry.toString(),
//             itemcode: StockInward[index].data[list_i].itemcode,
//             qty: 1,
//             serialbatch: serialBatch.toString().trim(),
//             docstatus: null,
//           ));
//           StockInward[index].data[list_i].serialbatchList = StInBatch;
//         }
//       } else {
//         msg = 'Wrong BatchCode Scan...!!';
//       }
//     
//     

//       notifyListeners();
//     } else {
//       msg = "Please Enter the Scancode..";
//     }
//     OnScanDisable = false;
//     StInController[0].clear();
//     notifyListeners();
//   }

//   suspendedbutton(int index, BuildContext context, ThemeData theme,
//       List<StockInwardDetails>? data, StockInwardList? datatotal) async {
//     int? scannedtottal = 0;
//     int? totalReqQty = 0;
//     int? totalTransQty = 0;

//     for (int i = 0; i < data!.length; i++) {
//       scannedtottal = scannedtottal! + data[i].Scanned_Qty!;
//       totalTransQty = totalTransQty! + data[i].trans_Qty!;
//       totalReqQty = totalReqQty! + data[i].qty!;
//       notifyListeners();
//     }
//   
//   

//     if (scannedtottal == 0) {
//       Get.defaultDialog(
//           title: "Alert",
//           middleText: 'Items Already Suspended..!!',
//           backgroundColor: Colors.white,
//           titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
//           middleTextStyle: theme.textTheme.bodyLarge,
//           actions: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                   child: const Text("Close"),
//                   onPressed: () => Get.back(),
//                 ),
//               ],
//             ),
//           ],
//           radius: 5);
//     } else if (scannedtottal != 0) {
//     
//     

//       for (int i = 0; i < StockInward[index].data.length; i++) {
//         StockInward[index].data[i].Scanned_Qty = 0;
//         StockInward[index].data[i].serialbatchList = [];
//         notifyListeners();
//       }
//       i_value = index;

//     
//     
//     
//     }
//     notifyListeners();
//   }

//   submitbutton(int index, BuildContext context, ThemeData theme,
//       List<StockInwardDetails>? data, StockInwardList? datatotal) async {
//     final Database db = (await DBHelper.getInstance())!;

//     OnclickDisable = true;
//     if (data!.isEmpty) {
//       Get.defaultDialog(
//               title: "Alert",
//               middleText: 'Please Select Items..!!',
//               backgroundColor: Colors.white,
//               titleStyle:
//                   theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
//               middleTextStyle: theme.textTheme.bodyLarge,
//               actions: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     TextButton(
//                       child: const Text("Close"),
//                       onPressed: () => Get.back(),
//                     ),
//                   ],
//                 ),
//               ],
//               radius: 5)
//           .then((value) {
//         OnclickDisable = false;
//         notifyListeners();
//       });
//     } else {
//       int? scannedtottal = 0;
//       int? totalTransQty = 0;
//       int? totalscanqty = 0;

//       for (int i = 0; i < data.length; i++) {
//         scannedtottal =
//             scannedtottal! + data[i].Scanned_Qty! + data[i].trans_Qty!;
//         totalTransQty = totalTransQty! + data[i].trans_Qty!;
//         totalscanqty = totalscanqty! + data[i].Scanned_Qty!;
//         notifyListeners();
//       }
//     
//     

//       if (totalscanqty == 0) {
//         Get.defaultDialog(
//                 title: "Alert",
//                 middleText: 'Please Select Items..!!',
//                 backgroundColor: Colors.white,
//                 titleStyle:
//                     theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
//                 middleTextStyle: theme.textTheme.bodyLarge,
//                 actions: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         child: const Text("Close"),
//                         onPressed: () => Get.back(),
//                       ),
//                     ],
//                   ),
//                 ],
//                 radius: 5)
//             .then((value) {
//           OnclickDisable = false;
//           notifyListeners();
//         });
//       } else if (totalscanqty != totalTransQty) {
//         log("totalTransQty!.toString()");
// //  log("totalTransQty!.toString()");
//         Get.defaultDialog(
//                 title: "Alert",
//                 middleText: 'Please Scan All Items..!!',
//                 backgroundColor: Colors.white,
//                 titleStyle:
//                     theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
//                 middleTextStyle: theme.textTheme.bodyLarge,
//                 actions: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         child: const Text("Close"),
//                         onPressed: () => Get.back(),
//                       ),
//                     ],
//                   ),
//                 ],
//                 radius: 5)
//             .then((value) {
//           OnclickDisable = false;
//           notifyListeners();
//         });
//       } else if (totalscanqty == totalTransQty) {
//         await DBOperation.deletAlreadyHoldData_StIN(
//           
//             db,
//             int.parse(StockInward[index].baceDocentry.toString()));

//         savepartialData('submit', context, theme, index, data, datatotal);
//       
//       
//       
//       
//       
//       }
//     }
//   }

//   Future<List<String>> checkingdoc(int id) async {
//     List<String> listdata = [];
//     final Database db = (await DBHelper.getInstance())!;
//     String? data = await DBOperation.getnumbSeriesvlue(db, id);
//     listdata.add(data.toString());
//     listdata.add(data!.substring(8));

//     log("datattata doc : ${data.substring(8)}");
//     return listdata; // int.parse(data.substring(8));
//   }

//   savepartialData(
//       String docstatus,
//       BuildContext context,
//       ThemeData theme,
//       int index,
//       List<StockInwardDetails>? data,
//       StockInwardList? datatotal) async {
//     OnclickDisable = true;
//     final Database db = (await DBHelper.getInstance())!;
//     List<StockInHeaderDataDB> StInHeader = [];
//     List<StockInLineDataDB> StInLine = [];
//   
//   
//   
//     int? counofData =
//         await DBOperation.getcountofTable(db, "docentry", "StockInHeaderDB");
//     int? docEntryCreated = 0;
//   
//     if (counofData == 0) {
//       if (AppConstant.terminal == 'T1') {
//         docEntryCreated = 1000000;
//       } else if (AppConstant.terminal == 'T2') {
//         docEntryCreated = 2000000;
//       } else if (AppConstant.terminal == 'T3') {
//         docEntryCreated = 3000000;
//       } else if (AppConstant.terminal == 'T4') {
//         docEntryCreated = 4000000;
//       }
//     } else {
//       docEntryCreated =
//           await DBOperation.generateDocentr(db, "docentry", "StockInHeaderDB");
//     }
// // docnumber generatiom

//     String docmntNo = '';
//     int? documentN0 =
//         await DBOperation.getnumbSer(db, "nextno", "NumberingSeries", 6);

//     List<String> getseriesvalue = await checkingdoc(6);

//     int docseries = int.parse(getseriesvalue[1]);

//     int nextno = documentN0!;

//     documentN0 = docseries + documentN0;

//     String finlDocnum = getseriesvalue[0].toString().substring(0, 8);

//     docmntNo = finlDocnum + documentN0.toString();

//     List<Map<String, Object?>> sapdetails = await DBOperation.getSaleHeadSapDet(
//         db,
//         int.parse(StockInward[index].baceDocentry.toString()),
//         'StockReqHDT');
//     log("StockInward[index].reqtoWhs:::" +
//         StockInward[index].reqtoWhs.toString());
//     log("StockInward[index].reqfromWhs:::" +
//         StockInward[index].reqfromWhs.toString());

//     StInHeader.add(StockInHeaderDataDB(
//         documentno: docmntNo.toString(),
//         branch: UserValues.branch,
//         docentry: docEntryCreated.toString(),
//         baseDocentry: StockInward[index].baceDocentry,
//       
//         createdUserID: UserValues.userID,
//       
//         createdateTime: config.currentDate(),
//         docstatus: "3",
//         lastupdateIp: UserValues.lastUpdateIp,
//       
//         reqdocno: StockInward[index].documentno.toString(),
//       
//         docseries: "",
//       
//         docseriesno: 0,
//       
//         doctime: config.currentDate(),
//         reqfromWhs: "HOGIT",
//       
//         systime: config.currentDate(),
//         reqtoWhs: stkreqfromwhs,
//       
//       
//         transdate: config.currentDate(),
//         salesexec: "",
//       
//         totalitems: 0,
//       
//         totalltr: 0,
//       
//         totalqty: 0,
//       
//         updatedDatetime: config.currentDate(),
//       
//         updateduserid: UserValues.userID,
//         terminal: UserValues.terminal,
//         sapDocNo: null,
//         sapDocentry: null,
//         qStatus: 'N',
//         sapStockReqdocentry: sapdetails.isEmpty
//             ? ""
//             : sapdetails[0]['sapDocentry'].toString(), //checkkkkkkk
//         sapStockReqdocnum:
//             sapdetails.isEmpty ? "" : sapdetails[0]['sapDocNo'].toString(),
//         remarks: StInController[50].text.toString()
//       
//         ));
//     int? docentry2 = await DBOperation.insertStockInheader(db, StInHeader);
//     await DBOperation.updatenextno(db, 6, nextno);

//     for (int i = 0; i < StockInward[index].data.length; i++) {
//     
//     
//     

//       await DBOperation.UpdateBatchTableDocentry_STIN(
//       
//       
//         db,
//         docentry2!,
//         int.parse(StockInward[index].data[i].baseDocentry.toString()),
//         StockInward[index].data[i].itemcode.toString(),
//       );
//       await DBOperation.deletAlreadyHoldDataLine_STIN(
//         
//           db,
//           int.parse(StockInward[index].baceDocentry.toString()),
//           StockInward[index].data[i].itemcode.toString());
//     
//     
//     
//       StInLine.add(StockInLineDataDB(
//           lineno: StockInward[index].data[i].lineNo.toString(),
//           docentry: docentry2.toString(),
//           itemcode: StockInward[index].data[i].itemcode.toString(),
//           description: StockInward[index].data[i].dscription,
//           qty: int.parse(StockInward[index].data[i].qty.toString()),
//           baseDocentry: StockInward[index].data[i].docentry.toString(),
//           baseDocline: StockInward[index].data[i].lineNo.toString(),
//           status: StockInward[index].data[i].status,
//           traansferQty: StockInward[index].data[i].Scanned_Qty,
//           scannedQty: StockInward[index].data[i].Scanned_Qty,
//           serialBatch: StockInward[index].data[i].serialBatch,
//           branch: UserValues.branch,
//           terminal: UserValues.terminal));
//     }

//     await DBOperation.insertStInLine(db, StInLine);

//   
//     bool? netbool = await config.haveInterNet();

//   
//     if (netbool == true) {
//       await PostRabitMq(docentry2!, int.parse(StockInward[index].baceDocentry!),
//           StockInward[index].reqtoWhs.toString());
//     }

//     await Get.defaultDialog(
//       title: "Success",
//       middleText: ' Sucessfully Done \n'
//           " Stock Inward successfully saved..!!",
//       backgroundColor: Colors.white,
//       titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
//       middleTextStyle: theme.textTheme.bodyLarge,
//       radius: 5,
//       actions: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             TextButton(
//               child: const Text("Close"),
//               onPressed: () => Get.offAllNamed(ConstantRoutes.dashboard),

//             
//             ),
//           ],
//         ),
//       ],
//     ).then((value) {
//       OnclickDisable = false;
//       StInController[50].text = "";
//       StInController2[50].text = "";
//       isselect = false;
//       StockInward.remove(datatotal);
//       data!.clear();
//       data.clear();
//       notifyListeners();
//     });

//     notifyListeners();
//   }

//   Future myFuture(
//       BuildContext context, theme, List<StockInwardDetails>? data) async {
//     if (data!.isEmpty) {
//       Get.defaultDialog(
//           title: "Alert",
//           middleText: 'Please Select Items..!!',
//           backgroundColor: Colors.white,
//           titleStyle: theme.textTheme.bodyMedium!.copyWith(color: Colors.red),
//           middleTextStyle: theme.textTheme.bodyMedium,
//           actions: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                   child: const Text("Close"),
//                   onPressed: () => Get.back(),
//                 ),
//               ],
//             ),
//           ],
//           radius: 5);
//     } else {
//       int? scannedtottal = 0;
//       int? totalTransQty = 0;
//       int? totalscanqty = 0;

//       for (int i = 0; i < data.length; i++) {
//         scannedtottal =
//             scannedtottal! + data[i].Scanned_Qty! + data[i].trans_Qty!;
//         totalTransQty = totalTransQty! + data[i].trans_Qty!;
//         totalscanqty = totalscanqty! + data[i].Scanned_Qty!;
//         notifyListeners();
//       }
//     
//     

//       if (totalscanqty == 0) {
//         Get.defaultDialog(
//             title: "Alert",
//             middleText: 'Please Select Items..!!',
//             backgroundColor: Colors.white,
//             titleStyle: theme.textTheme.bodyMedium!.copyWith(color: Colors.red),
//             middleTextStyle: theme.textTheme.bodyMedium,
//             actions: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   TextButton(
//                     child: const Text("Close"),
//                     onPressed: () => Get.back(),
//                   ),
//                 ],
//               ),
//             ],
//             radius: 5);
//       } else if (totalscanqty == totalTransQty) {
//         await Future.delayed(const Duration(seconds: 2));
//         Navigator.of(context).push(
//             MaterialPageRoute(builder: (context) => const DashBoardScreen()));
//       
//       } else if (totalscanqty != totalTransQty) {
//         Get.defaultDialog(
//             title: "Alert",
//             middleText: 'Please Scan All Items..!!',
//             backgroundColor: Colors.white,
//             titleStyle: theme.textTheme.bodyMedium!.copyWith(color: Colors.red),
//             middleTextStyle: theme.textTheme.bodyMedium,
//             actions: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   TextButton(
//                     child: const Text("Close"),
//                     onPressed: () => Get.back(),
//                   ),
//                 ],
//               ),
//             ],
//             radius: 5);
//       }
//     }
//   }

//   holdbutton(int index, BuildContext context, ThemeData theme,
//       List<StockInwardDetails>? data, StockInwardList? datatotal) async {
//     final Database db = (await DBHelper.getInstance())!;
//     OnclickDisable = true;
//     int? scannedtottal = 0;
//     int? totalReqQty = 0;
//     int? totalTransQty = 0;

//     for (int i = 0; i < data!.length; i++) {
//       scannedtottal = scannedtottal! + data[i].Scanned_Qty!;
//       totalTransQty = totalTransQty! + data[i].trans_Qty!;
//       totalReqQty = totalReqQty! + data[i].qty!;
//       notifyListeners();
//     }
//   
//   

//     if (scannedtottal == 0) {
//       Get.defaultDialog(
//               title: "Alert",
//               middleText: 'Please Scan Minimum One Item..!!',
//               backgroundColor: Colors.white,
//               titleStyle:
//                   theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
//               middleTextStyle: theme.textTheme.bodyLarge,
//               actions: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     TextButton(
//                       child: const Text("Close"),
//                       onPressed: () => Get.back(),
//                     ),
//                   ],
//                 ),
//               ],
//               radius: 5)
//           .then((value) {
//         OnclickDisable = true;
//         notifyListeners();
//       });
//     } else if (scannedtottal != 0) {
//       await DBOperation.deletAlreadyHoldData_StIN(
//         
//           db,
//           int.parse(StockInward[index].baceDocentry.toString()));

//       await HoldValueInsertToDB('hold', context, theme, index, data, datatotal);
//     
//     
//     
//     
//     
//       notifyListeners();
//     }
//     notifyListeners();
//   }

//   HoldValueInsertToDB(
//       String docstatus,
//       BuildContext context,
//       ThemeData theme,
//       int index,
//       List<StockInwardDetails>? data,
//       StockInwardList? datatotal) async {
//     final Database db = (await DBHelper.getInstance())!;
//     List<StockInHeaderDataDB> StInHeader = [];
//     List<StockInLineDataDB> StInLine = [];

//   
//   
//     int? docEntryCreated =
//         await DBOperation.generateDocentr(db, "docentry", "StockInHeaderDB");

//     StInHeader.add(StockInHeaderDataDB(
//         branch: UserValues.branch, //
//         docentry: docEntryCreated.toString(),
//         createdUserID: UserValues.userID,
//         baseDocentry: StockInward[index].baceDocentry,
//       
//         createdateTime: config.currentDate(),
//         docstatus: '1',
//         lastupdateIp: UserValues.lastUpdateIp,
//       
//         reqdocno: StockInward[index].documentno,
//       
//         docseries: "",
//       
//         docseriesno: 0,
//       
//         doctime: config.currentDate(),
//         reqfromWhs: StockInward[index].reqfromWhs,
//         systime: config.currentDate(),
//         reqtoWhs: StockInward[index].reqtoWhs, //
//         transdate: config.currentDate(),
//         salesexec: "",
//       
//         totalitems: 0,
//       
//         totalltr: 0,
//       
//         totalqty: 0,
//       
//         updatedDatetime: config.currentDate(),
//       
//         updateduserid: UserValues.userID,
//         terminal: UserValues.terminal,
//         sapDocNo: null,
//         sapDocentry: null,
//         qStatus: 'N',
//         sapStockReqdocentry: '', //checkkkkkkk
//         sapStockReqdocnum: '',
//         remarks: StInController[50].text.toString()
//       
//         ));
//     int? docentry2 = await DBOperation.insertStockInheader(db, StInHeader);

//     for (int i = 0; i < StockInward[index].data.length; i++) {
//       List<StockInBatchDataDB>? stInbatch = [];
//       await DBOperation.deleteBatch2_STIN(
//           db,
//           StockInward[index].data[i].baseDocentry!,
//           StockInward[index].data[i].lineNo!,
//           StockInward[index].data[i].itemcode!);
//       if (StockInward[index].data[i].serialbatchList != null) {
//         for (int k = 0;
//             k < StockInward[index].data[i].serialbatchList!.length;
//             k++) {
//           stInbatch.add(StockInBatchDataDB(
//               lineno: StockInward[index].data[i].serialbatchList![k].lineno,
//               baseDocentry:
//                   StockInward[index].data[i].serialbatchList![k].baseDocentry,
//               itemcode: StockInward[index].data[i].serialbatchList![k].itemcode,
//               qty: StockInward[index].data[i].serialbatchList![k].qty,
//               serialbatch:
//                   StockInward[index].data[i].serialbatchList![k].serialbatch,
//               docentry: StockInward[index].data[i].docentry.toString(),
//               docstatus: ''));
//         }
//       }
//       await DBOperation.insertStInBatch(db, stInbatch);
//       await DBOperation.deletAlreadyHoldDataLine_STIN(
//         
//           db,
//           int.parse(StockInward[index].baceDocentry.toString()),
//           StockInward[index].data[i].itemcode.toString());
//       StInLine.add(StockInLineDataDB(
//           lineno: StockInward[index].data[i].lineNo.toString(),
//           docentry: docentry2.toString(),
//           itemcode: StockInward[index].data[i].itemcode.toString(),
//           description: StockInward[index].data[i].dscription,
//           qty: int.parse(StockInward[index].data[i].qty.toString()),
//           baseDocentry: StockInward[index].baceDocentry.toString(),
//           baseDocline: StockInward[index].data[i].lineNo.toString(),
//           status: StockInward[index].data[i].status,
//           traansferQty: StockInward[index].data[i].trans_Qty,
//           scannedQty: StockInward[index].data[i].Scanned_Qty,
//           serialBatch: StockInward[index].data[i].serialBatch,
//           branch: UserValues.branch,
//           terminal: UserValues.terminal));
//     }
//     await DBOperation.insertStInLine(db, StInLine);
//   

//     getHoldValues(db);
//   
//     await Get.defaultDialog(
//       title: "Alert",
//       middleText: "Saved as draft",
//       backgroundColor: Colors.white,
//       titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
//       middleTextStyle: theme.textTheme.bodyLarge,
//       radius: 5,
//       actions: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             TextButton(
//               child: const Text("Close"),
//               onPressed: () => Get.back(),
//             ),
//           ],
//         ),
//       ],
//     ).then((value) {
//       StInController[50].clear();
//       StockInward.remove(datatotal);
//       data!.clear();
//       OnclickDisable = false;
//     
//     });

//     notifyListeners();
//   }

//   gethold() async {
//     final Database db = (await DBHelper.getInstance())!;

//     getHoldValues(db);
//   }

//   SuspendDBInsert(
//       String docstatus,
//       BuildContext context,
//       ThemeData theme,
//       int index,
//       List<StockInwardDetails>? data,
//       StockInwardList? datatotal) async {
//     final Database db = (await DBHelper.getInstance())!;
//     List<StockInHeaderDataDB> StInHeader = [];
//   
//   
//   

//     StInHeader.add(StockInHeaderDataDB(
//         branch: UserValues.branch,
//         terminal: UserValues.terminal,
//       
//         createdUserID: UserValues.userID,
//         baseDocentry: StockInward[index].baceDocentry,
//       
//         createdateTime: config.currentDate(),
//         docstatus: "0",
//         lastupdateIp: UserValues.lastUpdateIp,
//       
//         reqdocno: "0",
//       
//         docseries: "",
//       
//         docseriesno: 0,
//       
//         doctime: config.currentDate(),
//         reqfromWhs: StockInward[index].reqfromWhs,
//         systime: config.currentDate(),
//         reqtoWhs: StockInward[index].reqtoWhs, //
//         transdate: config.currentDate(),
//         salesexec: "",
//       
//         totalitems: 0,
//       
//         totalltr: 0,
//       
//         totalqty: 0,
//       
//         updatedDatetime: config.currentDate(),
//       
//         updateduserid: UserValues.userID,
//         sapDocNo: null,
//         sapDocentry: null,
//         qStatus: 'N',
//         sapStockReqdocentry: '', //checkkkkkkk
//         sapStockReqdocnum: '',
//         remarks: ''
//       
//         ));
//     int? docentry2 = await DBOperation.insertStockInheader(db, StInHeader);
//     await DBOperation.deleteSuspendBatchStIn(
//         db, int.parse(StockInward[index].baceDocentry!));

//     for (int i = 0; i < StockInward[index].data.length; i++) {
//       StockInward[index].data[i].Scanned_Qty = 0;
//     
//       notifyListeners();
//     }
//     await Get.defaultDialog(
//       title: "Alert",
//       middleText: "This Sales Transaction Suspended Sucessfully..!!",
//       backgroundColor: Colors.white,
//       titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
//       middleTextStyle: theme.textTheme.bodyLarge,
//       radius: 5,
//       actions: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             TextButton(
//               child: const Text("Close"),
//               onPressed: () => Get.back(),
//             ),
//           ],
//         ),
//       ],
//     ).then((value) {});

//     notifyListeners();
//   }

//   int? totalqty(int? index) {
//     int? totalqty = 0;
//     for (int i = 0; i < StockInward[index!].data.length; i++) {
//       totalqty = totalqty! + StockInward[index].data[i].qty!;
//     }
//     return totalqty;
//   }

//   int? totalValdationqty(int? index) {
//     int? totalqty = 0;
//     for (int i = 0; i < StockInward[index!].data.length; i++) {
//       totalqty = totalqty! + StockInward[index].data[i].Scanned_Qty!;
//     }
//     return totalqty;
//   }

//   int? totalscannedqty(int? index) {
//     int? totalscanqty = 0;
//     for (int i = 0; i < StockInward[index!].data.length; i++) {
//       totalscanqty = totalscanqty! + StockInward[index].data[i].Scanned_Qty!;
//     }
//     return totalscanqty;
//   }

//   String a = "";
//   Future getHoldValues(Database db) async {
//     List<Map<String, Object?>> getDBStInHead =
//         await DBOperation.getHoldStInHeadDB(db);
//     savedraftBill = [];

//   
//     List<StockInwardDetails> StIn_Line = [];
//     List<StockInSerialbatch> StIn_Batch = [];
//     for (int i = 0; i < getDBStInHead.length; i++) {
//     

//       List<Map<String, Object?>> getDBStInLine =
//           await DBOperation.holdStInLineDB(
//               db,
//               int.parse(getDBStInHead[i]["baseDocentry"].toString()),
//               int.parse(getDBStInHead[i]["docentry"].toString()));
//       StIn_Line = [];
//       for (int j = 0; j < getDBStInLine.length; j++) {
// // -----------------------
//         List<Map<String, Object?>> getDBStInBatch =
//             await DBOperation.holdStInBatchDB(
//                 db,
//                 int.parse(getDBStInLine[j]["baseDocentry"].toString()),
//                 getDBStInLine[j]["itemcode"].toString());
//       
//       
//         StIn_Batch=[];
//         if (int.parse(getDBStInLine[j]["scannedQty"].toString()) != 0) {
//           for (int k = 0; k < getDBStInBatch.length; k++) {
//             print("2---"+getDBStInBatch[k]["serialBatch"].toString());

//             StIn_Batch.add(
//               StockInSerialbatch(
//                 lineno: getDBStInBatch[k]["lineno"].toString(),
//                 baseDocentry: getDBStInBatch[k]["baseDocentry"].toString(),
//                 itemcode: getDBStInBatch[k]["itemcode"].toString(),
//                 qty: int.parse(getDBStInBatch[k]["quantity"].toString()),
//                 serialbatch: getDBStInBatch[k]["serialBatch"].toString(),
//               
//               
//               ),
//             );
//           }
//         } else {
//           StIn_Batch = [];
//         }

// //---------------------------
//       
//       

//         StIn_Line.add(StockInwardDetails(
//             lineNo: int.parse(getDBStInLine[j]["lineno"].toString()),
//             docentry: int.parse(getDBStInLine[j]["docentry"].toString()),
//             baseDocentry:
//                 int.parse(getDBStInLine[j]["baseDocentry"].toString()),
//             itemcode: getDBStInLine[j]["itemcode"].toString(),
//             dscription: getDBStInLine[j]["description"].toString(),
//             qty: int.parse(getDBStInLine[j]["quantity"].toString()),
//             status: getDBStInLine[j]["status"].toString(),
//             serialBatch: getDBStInLine[j]["serialBatch"].toString(),
//             createdUserID: 0,
//             taxRate: 0.0,
//             taxType: "",
//             baseDocline: int.parse(getDBStInLine[j]["baseDocline"].toString()),
//             trans_Qty:getDBStInLine[j]["transferQty"]==null?0: int.parse(getDBStInLine[j]["transferQty"].toString()),
//             Scanned_Qty: int.parse(getDBStInLine[j]["scannedQty"].toString()),
//             createdateTime: "",
//             updatedDatetime: "",
//             updateduserid: 0,
//             price: 0,
//             lastupdateIp: "",
//             serialbatchList: StIn_Batch));
//       }

//       savedraftBill.add(StockInwardList(
//         remarks: getDBStInHead[i]["remarks"].toString(),
//         docentry: getDBStInHead[i]["docentry"].toString(),
//         baceDocentry: getDBStInHead[i]["baseDocentry"].toString(),
//         branch: getDBStInHead[i]["branch"].toString(),
//       
//       
//         docstatus: getDBStInHead[i]["docstatus"].toString(),
//       
//       
//       
//       
//       
//         reqfromWhs: getDBStInHead[i]["reqfromWhs"].toString(),
//       
//         reqtoWhs: getDBStInHead[i]["reqtoWhs"].toString(),
//         reqtransdate: getDBStInHead[i]["transdate"].toString(),
//       
//       
//       
//       
//       
//       
//       
//       
//       
//       
//       
//       
//       
//       
//       
//       
//       
//       
//         documentno: getDBStInHead[i]["reqdocno"].toString(),
//         data: StIn_Line,
//       ));
//     }
//   
//   
//   
//   
//   }

//   valPass(int scanQty) {
//     msg = "";
//   
//     notifyListeners();
//   }

//   PageIndexvalue(int? index) {
//     pageIndex = index!;
//     notifyListeners();
//   }

//   passINDEX(int? index) {
//     i_value = index!;
//     notifyListeners();
//   }

//   int? listI = 0;
//   int? batch_i = 0;

//   StockInwardDetails? batch_datalist;
//   passindexBachPage(
//     int? index,
//     int? i,
//     StockInwardDetails? datalist,
//   ) {
//   
//     listI = index!;
//     batch_i = i;
//   
//     batch_datalist = datalist;
//     notifyListeners();
//   }

//   Future<bool> onbackpress() async {
//   
//     if (pageIndex == 1) {
//     

//       page.animateToPage(--pageIndex,
//           duration: const Duration(milliseconds: 250), curve: Curves.bounceIn);
//     } else if (pageIndex == 2) {
//     
//     
//     
//     
//       notifyListeners();
//       page.animateToPage(--pageIndex,
//           duration: const Duration(milliseconds: 250), curve: Curves.bounceIn);
//     }
//     return Future.value(false);
//   }

//   List<StockInwardDetails>? passdata = [];
//   passList(List<StockInwardDetails>? data) {
//     passdata = data!;
//   
//   
//   
//   
//   
//   
//     notifyListeners();
//   }

//   List<StockInwardList> StockInward = [];
//   callList() {}

//   clearmsg() {
//     msg = "";
//   
//     notifyListeners();
//   }

//   DateTime? currentBackPressTime;
//   Future<bool> onWillPop() {
//     page.previousPage(
//       duration: const Duration(milliseconds: 200),
//       curve: Curves.linear,
//     );
//     return Future.value(false);
//   }

//   clickcancelbtn(BuildContext context, ThemeData theme) async {
//     if (SapDocentry.isNotEmpty) {
//       await sapLoginApi(context);
//       await callgetStkinwardAPI(context, theme);
//       await callStkInwardCancelQuoAPI(context, theme);
//       notifyListeners();
//     } else {
//       cancelbtn = false;
//       log("BBBBBBBBBBBBBBBBBBBBBB");
//       showDialog(
//           context: context,
//           barrierDismissible: true,
//           builder: (BuildContext context) {
//             return AlertDialog(
//                 contentPadding: const EdgeInsets.all(0),
//                 content: AlertBox(
//                   payMent: 'Alert',
//                   errormsg: true,
//                   widget: Center(
//                       child: ContentContainer(
//                     content: 'Something went Wrong',
//                     theme: theme,
//                   )),
//                   buttonName: null,
//                 ));
//           }).then((value) {
//         SapDocentry = '';
//         SapDocuNumber = '';
//         StInController2[50].text = '';
//         StockInward2.clear();
//         getStockOutData();
//         StockInward.clear();
//         notifyListeners();
//       });

//       notifyListeners();
//     }
//   }

//   sapLoginApi(BuildContext context) async {
//     final pref2 = await pref;

//     await PostInwardLoginAPi.getGlobalData().then((value) async {
//       if (value.stCode! >= 200 && value.stCode! <= 210) {
//         if (value.sessionId != null) {
//           pref2.setString("sessionId", value.sessionId.toString());
//           pref2.setString("sessionTimeout", value.sessionTimeout.toString());
//           print("sessionID: " + value.sessionId.toString());
//           getSession();
//         }
//       } else if (value.stCode! >= 400 && value.stCode! <= 410) {
//         if (value.error!.code != null) {
//           loadingscrn = false;
//           final snackBar = SnackBar(
//             behavior: SnackBarBehavior.floating,
//             margin: EdgeInsets.only(
//               bottom: Screens.bodyheight(context) * 0.3,
//             ),
//             duration: const Duration(seconds: 4),
//             backgroundColor: Colors.red,
//             content: Text(
//               "${value.error!.message!.value}\nCheck Your Sap Details !!..",
//               style: const TextStyle(color: Colors.white),
//             ),
//           );
//           ScaffoldMessenger.of(context).showSnackBar(snackBar);
//           Future.delayed(const Duration(seconds: 5), () {
//             exit(0);
//           });
//         }
//       } else if (value.stCode == 500) {
//         final snackBar = SnackBar(
//           behavior: SnackBarBehavior.floating,
//           margin: EdgeInsets.only(
//             bottom: Screens.bodyheight(context) * 0.3,
//           ),
//           duration: const Duration(seconds: 4),
//           backgroundColor: Colors.red,
//           content: const Text(
//             "Opps Something went wrong !!..",
//             style: TextStyle(color: Colors.white),
//           ),
//         );
//       } else {
//         final snackBar = SnackBar(
//           behavior: SnackBarBehavior.floating,
//           margin: EdgeInsets.only(
//             bottom: Screens.bodyheight(context) * 0.3,
//           ),
//           duration: const Duration(seconds: 4),
//           backgroundColor: Colors.red,
//           content: const Text(
//             "Opps Something went wrong !!..",
//             style: TextStyle(color: Colors.white),
//           ),
//         );
//       }
//     });
//   }

//   void getSession() async {
//     var preff = await SharedPreferences.getInstance();
//     AppConstant.sapSessionID = preff.getString('sessionId')!;
//     log("  AppConstant.sapSessionID::${AppConstant.sapSessionID}");
//   }

//   callgetStkinwardAPI(BuildContext context, ThemeData theme) async {
//     final Database db = (await DBHelper.getInstance())!;

//     log("SapDocentrySapDocentrySapDocentry:::$SapDocentry");

//     await SerlayInwardAPI.getData(SapDocentry.toString()).then((value) {
//       if (value.statusCode! >= 200 && value.statusCode! <= 210) {
//         if (value.stockTransferInwrdLines.isNotEmpty) {
//           sapInwardModelData = value.stockTransferInwrdLines;

//           log("sapInvocieModelDatasapInvocieModelData::${sapInwardModelData[0].lineStatus}");

//           custserieserrormsg = '';
//         } else {
//           log("Error11");

//         
//         }
//       } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
//         log("Error22");
//         cancelbtn = false;
//         custserieserrormsg = value.error!.message!.value.toString();
//         showDialog(
//             context: context,
//             barrierDismissible: true,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                   contentPadding: const EdgeInsets.all(0),
//                   content: AlertBox(
//                     payMent: 'Alert',
//                     errormsg: true,
//                     widget: Center(
//                         child: ContentContainer(
//                       content: value.error!.message!.value.toString(),
//                       theme: theme,
//                     )),
//                     buttonName: null,
//                   ));
//             }).then((value) {
//           SapDocentry = '';
//           SapDocuNumber = '';
//           StInController2[50].text = '';
//           StockInward2.clear();
//           getStockOutData();
//           StockInward.clear();
//           notifyListeners();
//         });
//         log("custserieserrormsgcustserieserrormsg::$custserieserrormsg");
//       } else {
//         log("Error33");

//       
//       }
//     });
//   }

//   callStkInwardCancelQuoAPI(BuildContext context, ThemeData theme) async {
//     final Database db = (await DBHelper.getInstance())!;
//     if (sapInwardModelData.isNotEmpty) {
//       for (int ij = 0; ij < sapInwardModelData.length; ij++) {
//         if (sapInwardModelData[ij].lineStatus == "bost_Open") {
//           await SerlayvInwardCancelAPI.getData(SapDocentry.toString())
//               .then((value) async {
//             if (value.statusCode! >= 200 && value.statusCode! <= 204) {
//               cancelbtn = false;
//               log("sapInwardModelDatasapInwardModelData::${sapInwardModelData[0].lineStatus}");

//               await DBOperation.updateSalesQuoclosedocsts(
//                   db, SapDocentry.toString());

//               showDialog(
//                   context: context,
//                   barrierDismissible: false,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                         contentPadding: const EdgeInsets.all(0),
//                         content: AlertBox(
//                           payMent: 'Success',
//                           errormsg: true,
//                           widget: Center(
//                               child: ContentContainer(
//                             content: 'Document is successfully cancelled ..!!',
//                             theme: theme,
//                           )),
//                           buttonName: null,
//                         ));
//                   }).then((value) {
//                 SapDocentry = '';
//                 SapDocuNumber = '';
//                 StInController2[50].text = '';
//                 StockInward2.clear();
//                 getStockOutData();
//                 StockInward.clear();
//                 notifyListeners();
//               });

//               custserieserrormsg = '';
//             } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
//               cancelbtn = false;
//               log("Error22");
//               custserieserrormsg = errmodel!.message!.value.toString();

//               showDialog(
//                   context: context,
//                   barrierDismissible: true,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                         contentPadding: const EdgeInsets.all(0),
//                         content: AlertBox(
//                           payMent: 'Alert',
//                           errormsg: true,
//                           widget: Center(
//                               child: ContentContainer(
//                             content: value.exception!.message!.value.toString(),
//                             theme: theme,
//                           )),
//                           buttonName: null,
//                         ));
//                   }).then((value) {
//                 SapDocentry = '';
//                 SapDocuNumber = '';
//                 StInController2[50].text = '';
//                 StockInward2.clear();
//                 getStockOutData();
//                 StockInward.clear();
//                 notifyListeners();
//               });
//               log("custserieserrormsgcustserieserrormsg::$custserieserrormsg");
//             } else {
//               log("Error33");
//             }
//           });
//         } else if (sapInwardModelData[ij].lineStatus == "bost_Close") {
//           showDialog(
//               context: context,
//               barrierDismissible: true,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                     contentPadding: const EdgeInsets.all(0),
//                     content: AlertBox(
//                       payMent: 'Alert',
//                       errormsg: true,
//                       widget: Center(
//                           child: ContentContainer(
//                         content: 'Document is already cancelled',
//                         theme: theme,
//                       )),
//                       buttonName: null,
//                     ));
//               }).then((value) {
//             SapDocentry = '';
//             SapDocuNumber = '';
//             StInController2[50].text = '';
//             StockInward2.clear();
//             StInController2[50].text = "";
//             getStockOutData();
//             StockInward.clear();
//             notifyListeners();
//           });
//           notifyListeners();
//         }
//       }
//     }
//   }

// 
// 

// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 

// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 

// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 

// 
// 

//   mapvalue(List<StockInwardList> StockOut, int index) async {
//     OndDisablebutton = false;
//     final Database db = (await DBHelper.getInstance())!;
//     List<StOutSerialbatch>? StOutSerialbatchList2 = [];
//     StockInward2.clear();
//     StInController2[50].text = "";

//     if (isselect == true) {
//       isselect = false;
//     }
// // List<StockInwardList> StInList=[];
//     List<StockInwardDetails> StInDetails = [];
//     List<StockInwardList> StInList = [];

//     for (int j = 0; j < StockOut[index].data.length; j++) {
      
//       print("StIn batch Hold::"+StockOut[index].data[j].serialbatchList!.length.toString());

//       StOutSerialbatchList2 = [];
//       List<StockInSerialbatch> StInSeralBatchList = [];
//       if(StockOut[index].data[j].serialbatchList !=null){
//         for (int k = 0;
//             k < StockOut[index].data[j].serialbatchList!.length;
//               k++) {
//       
//           print("Hold bAtch:"+StockOut[index].data[j].serialbatchList![k].serialbatch.toString());
//         StInSeralBatchList.add(StockInSerialbatch(
//             lineno: StockOut[index].data[j].lineNo.toString(),
//             baseDocentry: StockOut[index].data[j].baseDocentry.toString(),
//             itemcode: StockOut[index].data[j].itemcode.toString(),
//             qty: StockOut[index].data[j].serialbatchList![k].qty,
//           
//             serialbatch: StockOut[index].data[j].serialbatchList![k].serialbatch.toString()));
//       
//               }
//           }
      

//       List<Map<String, Object?>> getStockOutBatchListData =
//           await DBOperation.getBatchInOutward_StIn(
//               db,
//               int.parse(StockOut[index].data[j].baseDocentry.toString()),
//               StockOut[index].data[j].itemcode.toString());
//       for (int k = 0; k < getStockOutBatchListData.length; k++) {
//         StOutSerialbatchList2.add(StOutSerialbatch(
//             lineno: getStockOutBatchListData[k]['linene'].toString(),
//             docentry: getStockOutBatchListData[k]['docentry'].toString(),
//             baseDocentry:
//                 getStockOutBatchListData[k]['baseDocentry'].toString(),
//             itemcode: getStockOutBatchListData[k]['itemcode'].toString(),
//             qty: int.parse(getStockOutBatchListData[k]['quantity'].toString()),
//             serialbatch:
//                 getStockOutBatchListData[k]['serialBatch'].toString()));
//       }

      

      
//       StInDetails.add(StockInwardDetails(
//           createdUserID: StockOut[index].data[j].createdUserID,
//           createdateTime: StockOut[index].data[j].createdateTime,
//           baseDocentry: StockOut[index].data[j].baseDocentry,
//           docentry: StockOut[index].data[j].docentry,
//           dscription: StockOut[index].data[j].dscription,
//           itemcode: StockOut[index].data[j].itemcode,
//           lastupdateIp: StockOut[index].data[j].lastupdateIp,
//           lineNo: StockOut[index].data[j].lineNo,
//           qty: StockOut[index].data[j].qty,
//           status: StockOut[index].data[j].status,
//           updatedDatetime: StockOut[index].data[j].updatedDatetime,
//           updateduserid: StockOut[index].data[j].updateduserid,
//           price: StockOut[index].data[j].price,
//           serialBatch: StockOut[index].data[j].serialBatch,
//           taxRate: StockOut[index].data[j].taxRate,
//           taxType: StockOut[index].data[j].taxType,
//           trans_Qty: StockOut[index].data[j].trans_Qty,
//           Scanned_Qty: StockOut[index].data[j].Scanned_Qty,
//           baseDocline: StockOut[index].data[j].baseDocline,
//           serialbatchList: StInSeralBatchList,
//           StOutSerialbatchList: StOutSerialbatchList2));
//     }
//     StInController[50].text = StockOut[index].remarks.toString();

//     StInList.add(StockInwardList(
//         branch: StockOut[index].branch,
//       
//       
//         docentry: StockOut[index].docentry,
//         baceDocentry: StockOut[index].baceDocentry,
//         docstatus: StockOut[index].docstatus,
//         documentno: StockOut[index].documentno,
//       
//       
//       
//       
//       
//       
//       
//         reqfromWhs: StockOut[index].reqfromWhs,
//       
//         reqtoWhs: StockOut[index].reqtoWhs,
//         reqtransdate: StockOut[index].reqtransdate,
//       
//       
//       
//       
//       
//       
//       
//       
//       
//       
//       
//       
//         data: StInDetails,
//         remarks: StockOut[index].remarks));
//     int? count = await dupilicateHoldDataCheck(StInList);

//     if (count != null) {
//       log("StockOutward Length::" + StockInward.length.toString());
//       log("StockOut Length::" + StockOut.length.toString());

//       log("Remove I::" + count.toString());

//       StockInward.removeAt(count);
//       StockInward.addAll(StInList);
//     
//     
//     } else {
//       log("message");
//       log("Remove I::" + count.toString());

//       StockInward.addAll(StInList);
//     
//     
//     }
//     log(StockInward.length.toString());
//     passdata = StockInward[StockInward.length - 1].data;
//     i_value = StockInward.length - 1;
//     selectIndex = StockInward.length - 1;

//   
//   
//   
//   
//   

//   
//   
//   
//   
//     getHoldValues(db);
//     notifyListeners();
//   }

//   Future<int?> dupilicateHoldDataCheck(List<StockInwardList> stInList) {
//     for (int i = 0; i < StockInward.length; i++) {
//       if (StockInward[i].baceDocentry == stInList[0].baceDocentry) {
//         log("Basedocentry::" + StockInward[i].baceDocentry.toString());
//         log("i-----------------::" + i.toString());

//         return Future.value(i);
//       }
//     }
//     return Future.value(null);
//   }
// 
// 
// 
// 
// 
// 
// 
// 

//   int mainTranTotal = 0;
//   int mainScannedTotal = 0;

//   mainaValidation(List<StockInwardDetails> StockInward, StockInwardList Stock) {
//     mainTranTotal = 0;
//     mainScannedTotal = 0;
//     notifyListeners();

//     for (int i = 0; i < StockInward.length; i++) {
//       mainScannedTotal = mainScannedTotal + StockInward[i].Scanned_Qty!;
//       mainTranTotal = mainTranTotal + StockInward[i].trans_Qty!;

//       notifyListeners();
//     }
//   
//   
//   
//   
//     notifyListeners();
//   }

// 
//   List<StockInwardList> savedraftBill = [];
//   List<StockInwardList> SaveBill = [];
//   List<StockInwardList> StockOutDATA = [];
//   bool? dbDataTrue = false;
//   bool? scandbDataTrue = false;
//   bool? scanListTrue = false;

// 
// 

//   getStockOutData() async {
//     StockInward.clear();
//     StockOutDATA.clear();
//     List<StOutSerialbatch>? StOutSerialbatchList2 = [];
//     final Database db = (await DBHelper.getInstance())!;
//   
//     List<Map<String, Object?>> getStockReqValues =
//         await DBOperation.getStockOut(db);
//     if (getStockReqValues.isNotEmpty) {
//     
//       for (int i = 0; i < getStockReqValues.length; i++) {
//         StockOutDATA = [];
//         stkreqfromwhs = getStockReqValues[i]["reqfromWhs"].toString();
//         log("reqfromWhs22::" +
//             getStockReqValues[i]["reqfromWhs"].toString() +
//             "--reqtoWhs22::" +
//             getStockReqValues[i]["reqtoWhs"].toString());
//         if (getStockReqValues[i]["reqfromWhs"].toString() ==
//             AppConstant.branch) {
//           log("step--2");

//           dbDataTrue = false;

//           List<Map<String, Object?>> getStockReqLineData =
//               await DBOperation.getTrasferQty_StIn(
//                   db, int.parse(getStockReqValues[i]["docentry"].toString()));
//           List<StockInwardDetails> stockDetails = [];
//           for (int j = 0; j < getStockReqLineData.length; j++) {
//             StOutSerialbatchList2 = [];
//             if (getStockReqValues[i]["reqtoWhs"].toString() == "HOGIT") {
//             

//               List<Map<String, Object?>> getStockOutBatchListData =
//                   await DBOperation.getBatchInOutward_StIn2(
//                       db,
//                       int.parse(getStockReqLineData[j]["docentry"].toString()),
//                       int.parse(
//                           getStockReqLineData[j]["baseDocentry"].toString()),
//                       getStockReqLineData[j]["itemcode"].toString());
//               for (int k = 0; k < getStockOutBatchListData.length; k++) {
//                 StOutSerialbatchList2.add(StOutSerialbatch(
//                     lineno: getStockOutBatchListData[k]['linene'].toString(),
//                     docentry:
//                         getStockOutBatchListData[k]['docentry'].toString(),
//                     baseDocentry:
//                         getStockOutBatchListData[k]['baseDocentry'].toString(),
//                     itemcode:
//                         getStockOutBatchListData[k]['itemcode'].toString(),
//                     qty: int.parse(
//                         getStockOutBatchListData[k]['quantity'].toString()),
//                     serialbatch:
//                         getStockOutBatchListData[k]['serialBatch'].toString()));
//               }

//               stockDetails.add(StockInwardDetails(
//                   baseDocentry:
//                       int.parse(getStockReqLineData[j]["docentry"].toString()),
//                   baseDocline:
//                       int.parse(getStockReqLineData[j]["lineno"].toString()),
//                   createdUserID: getStockReqLineData[j]["createdUserID"] == null
//                       ? 0
//                       : int.parse(
//                           getStockReqLineData[j]["createdUserID"].toString()),
//                   createdateTime:
//                       getStockReqLineData[j]["createdateTime"].toString(),
//                   docentry:
//                       int.parse(getStockReqLineData[j]["docentry"].toString()),
//                   dscription: "",
//                   itemcode: getStockReqLineData[j]["itemcode"].toString(),
//                   lastupdateIp:
//                       getStockReqLineData[j]["lastupdateIp"].toString(),
//                   lineNo:
//                       int.parse(getStockReqLineData[j]["lineno"].toString()),
//                   qty: int.parse(getStockReqLineData[j]["quantity"].toString()),
//                   status: "",
//                   updatedDatetime:
//                       getStockReqLineData[j]["UpdatedDatetime"].toString(),
//                   updateduserid: getStockReqLineData[j]["updateduserid"] == null
//                       ? 0
//                       : int.parse(
//                           getStockReqLineData[j]["updateduserid"].toString()),
//                   price: getStockReqLineData[j]["price"] == null
//                       ? 0.0
//                       : double.parse(
//                           getStockReqLineData[j]["price"].toString()),
//                   serialBatch: getStockReqLineData[j]["serialBatch"].toString(),
//                   taxRate: 0.0,
//                   Scanned_Qty:
//                       int.parse(getStockReqLineData[j]["scanndQty"].toString()),
//                   trans_Qty:
//                       int.parse(getStockReqLineData[j]["balqty"].toString()),
//                   taxType: "",
//                   StOutSerialbatchList: StOutSerialbatchList2));
//               log("StOutSerialbatchList2------------------ ::" +
//                   StOutSerialbatchList2.length.toString());
//             }

//           
//           }

//           log("step--5");

//           StockOutDATA.add(StockInwardList(
//               branch: getStockReqValues[i]["branch"].toString(),
//             
//             
//             

//               docentry: getStockReqValues[i]["docentry"].toString(),
//               baceDocentry: getStockReqValues[i]["docentry"].toString(),
//               docstatus: getStockReqValues[i]["docstatus"].toString(),
//               documentno: getStockReqValues[i]["reqdocno"] == null
//                   ? "0"
//                   : getStockReqValues[i]["reqdocno"].toString(),
//             
//             
//             
//             
//             
//             
//             
//             
//               reqfromWhs: getStockReqValues[i]["reqfromWhs"].toString(),
//             
//               reqtoWhs: getStockReqValues[i]["branch"].toString(),
//               reqtransdate: getStockReqValues[i]["transdate"].toString(),
//             
//             
//             
//             
//             
//             
//             
//             
//             
//             
//             
//             
//             
//             
//               data: stockDetails));
//         
//         
//           log("step--6");

//           log("StockOutDATA lenght::" + StockOutDATA.length.toString());

//           StockInward.addAll(StockOutDATA);
//         

//           log("StockInward::" + StockInward.length.toString());
//         } else {
//           dbDataTrue = true;
//           notifyListeners();
//         }
//       }

//     
//       notifyListeners();
//     } else {
//       dbDataTrue = true;
//       notifyListeners();
//     }
//     notifyListeners();
//   }

//   disableKeyBoard(BuildContext context) {
//     FocusScopeNode focus = FocusScope.of(context);
//     if (!focus.hasPrimaryFocus) {
//       focus.unfocus();
//     }
//   }

//   PostRabitMq(int docentry, int baseDocentry, String toWhs) async {
//     final Database db = (await DBHelper.getInstance())!;
//     List<Map<String, Object?>> getDB_StInHeader =
//         await DBOperation.getStockInHeader(db, docentry);
//     List<Map<String, Object?>> getDB_StInLine =
//         await DBOperation.holdStInLineDB(db, baseDocentry, docentry);
//     List<Map<String, Object?>> getDB_StInBatch =
//         await DBOperation.getStockInBatch(db, baseDocentry, docentry);
//     String StInHeader = json.encode(getDB_StInHeader);
//     String StInLine = json.encode(getDB_StInLine);
//     String StInBatch = json.encode(getDB_StInBatch);

//     var ddd = json.encode({
//       "ObjectType": 6,
//       "ActionType": "Add",
//       "StockInwardHeader": StInHeader,
//       "StockInwardLine": StInLine,
//       "StockInwardBatch": StInBatch,
//     });
//     log("payload : $ddd");

//   
//     Client client = Client();
//     ConnectionSettings settings = ConnectionSettings(
//         host: AppConstant.ip.toString().trim(), //"102.69.167.106"
//       
//         port: 5672,
//         authProvider: const PlainAuthenticator("buson", "BusOn123"));
//     Client client1 = Client(settings: settings);

//     MessageProperties properties = MessageProperties();

//     properties.headers = {"Branch": UserValues.branch};
//     Channel channel = await client1.channel();
//     Exchange exchange =
//         await channel.exchange("POS", ExchangeType.HEADERS, durable: true);
//     exchange.publish(ddd, "", properties: properties);

//   

//     properties.headers = {"Branch": "Server"};
//     exchange.publish(ddd, "", properties: properties);
// //to
//     properties.headers = {"Branch": toWhs};
//     exchange.publish(ddd, "", properties: properties);
//     client1.close();
//   }

//   PostRabitMq2(int docentry, int baseDocentry, String toWhs) async {
//     final Database db = (await DBHelper.getInstance())!;
//     List<Map<String, Object?>> getDB_StInHeader =
//         await DBOperation.getStockInHeader(db, docentry);
//     List<Map<String, Object?>> getDB_StInLine =
//         await DBOperation.holdStInLineDB(db, baseDocentry, docentry);
//     List<Map<String, Object?>> getDB_StInBatch =
//         await DBOperation.getStockInBatch(db, baseDocentry, docentry);
//     String StInHeader = json.encode(getDB_StInHeader);
//     String StInLine = json.encode(getDB_StInLine);
//     String StInBatch = json.encode(getDB_StInBatch);

//     var ddd = json.encode({
//       "ObjectType": 6,
//       "ActionType": "Add",
//       "StockInwardHeader": StInHeader,
//       "StockInwardLine": StInLine,
//       "StockInwardBatch": StInBatch,
//     });
//   

//   
//     Client client = Client();
//     ConnectionSettings settings = ConnectionSettings(
//         host: AppConstant.ip.toString().trim(), //"102.69.167.106"
//       
//         port: 5672,
//         authProvider: const PlainAuthenticator("buson", "BusOn123"));
//     Client client1 = Client(settings: settings);

//     MessageProperties properties = MessageProperties();

//     properties.headers = {"Branch": UserValues.branch};
//     Channel channel = await client1.channel();
//     Exchange exchange =
//         await channel.exchange("POS", ExchangeType.HEADERS, durable: true);
//     exchange.publish(ddd, "", properties: properties);

//   

//     properties.headers = {"Branch": "Server"};
//     exchange.publish(ddd, "", properties: properties);
// //to
//     properties.headers = {"Branch": toWhs};
//     exchange.publish(ddd, "", properties: properties);
//     client1.close();
//   }
// }
