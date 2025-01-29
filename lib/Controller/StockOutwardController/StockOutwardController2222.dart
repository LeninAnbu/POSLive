// // ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, empty_constructor_bodies, non_constant_identifier_names, unused_local_variable, prefer_const_constructors, use_build_context_synchronously, curly_braces_in_flow_control_structures, unrelated_type_equality_checks, prefer_if_null_operators, prefer_is_empty

// import 'dart:convert';
// import 'dart:developer';

// import 'package:dart_amqp/dart_amqp.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:posbillingdesign/Pages/DashBoard/Screens/DashBoardScreen.dart';
// import 'package:sqflite/sqflite.dart';
// import '../../Constant/AppConstant.dart';
// import '../../Constant/Configuration.dart';
// import '../../Constant/UserValues.dart';
// import '../../DB Helper/DBOperation.dart';
// import '../../DB Helper/DBhelper.dart';
// import '../../DBModel/StockOutwardBatchModel.dart';
// import '../../DBModel/StockOutwardHeader.dart';
// import '../../DBModel/StockOutwardLineData.dart';
// import '../../DBModel/StockSnap.dart';
// import '../../Models/DataModel/StockOutwardModel/StockOutwardListModel.dart';
// import '../../Models/SearBox/SearchModel.dart';
// import '../../Pages/Sales Screen/Widgets/Dialog Box/AlertBox.dart';
// import '../../Widgets/ContentContainer.dart';
// import 'package:intl/intl.dart';

// class StockOutwardController extends ChangeNotifier {
//   // StockOutwardController() {
//   //   // deletereq();
//   //   getStockReqData();
//   //   gethold();
//   // }
//   void init() {
//     tappage = PageController(initialPage: 0);
//     getStockReqData();
//     gethold();
//   }

//   setstatemethod() {
//     notifyListeners();
//   }

//   passData(ThemeData theme, BuildContext context, int index) {
//     if (StockOutward[index].data.isNotEmpty) {
//       // Selectindex(index);
//       // passINDEX(index);
//       // passList(StockOutward[index].data);
//       tappageIndex = 0;
//       log('----tapindex' + tappageIndex.toString());
//       selectIndex = index;
//       i_value = index;
//       passdata = StockOutward[index].data;
//       notifyListeners();

//       // StOut_Con.clearTotal();
//     } else if (StockOutward[index].data.isEmpty) {
//       showDialog(
//           context: context,
//           barrierDismissible: true,
//           builder: (BuildContext context) {
//             return AlertDialog(
//                 contentPadding: EdgeInsets.all(0),
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

//   clearDataAll() {
//     log('---sasas-' + tappageIndex.toString());
//     page = PageController(initialPage: 0);
//     tappage = PageController(initialPage: 0);
//     pageIndex = 0;
//     tappageIndex = 0;
//     StOutController2[50].text = "";
//     passdata = [];
//     selectIndex;
//     notifyListeners();
//     // formkey.clear();
//     // StOutController.clear();
//     // StOutController2.clear();
//     // // i_value = 0;
//     // ScannigVal = 0;
//     // dbDataTrue = false;
//     // // StockOutward.clear();
//     // StockOutward2.clear();
//     // passdata!.clear();
//   }

// //  Future<bool> onbackpress() {
// //     DateTime now = DateTime.now();
// //     // if(saveTrans == true){
// //     //     return Future.value(false);
// //     //   } else {
// //     if (tappageIndex == 0) {
// //       tappage.animateToPage(--tappageIndex,
// //           duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
// //     } else if (tappageIndex == 1) {
// //       tappage.animateToPage(--tappageIndex,
// //           duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
// //     } else if (tappageIndex == 0) {
// //       return Future.value(true);
// //     }
// //     return Future.value(false);
// //     // }
// //   }
//   pagePlus() {
//     log('----' + tappage.toString());
//     log('----' + tappageIndex.toString());
//     tappageIndex = 0;
//     tappage.jumpToPage(1);
//     // tappage.animateToPage(++tappageIndex,
//     //     duration: Duration(milliseconds: 400), curve: Curves.linearToEaseOut);
//     notifyListeners();
//     log('--a--' + tappage.toString());
//     log('--a--' + tappageIndex.toString());
//   }

//   pageminus() {
//     tappageIndex = 1;
//     log('--a--' + tappage.toString());
//     // tappage.jumpToPage(0);
//     tappage.animateToPage(--tappageIndex,
//         duration: Duration(milliseconds: 400), curve: Curves.linearToEaseOut);
//     notifyListeners();
//   }

//   String searchError = "";
//   gethold() async {
//     final Database db = (await DBHelper.getInstance())!;

//     getHoldValues(db);
//   }

//   deletereq() async {
//     final Database db = (await DBHelper.getInstance())!;
//     await DBOperation.deletereq(db);
//   }

//   bool OndDisablebutton = false;

//   Config config = Config();

//   PageController page = PageController(initialPage: 0);
//   PageController tappage = PageController(initialPage: 0);

//   int pageIndex = 0;
//   int tappageIndex = 0;
//   List<GlobalKey<FormState>> formkey =
//       List.generate(50, (i) => GlobalKey<FormState>());

//   List<TextEditingController> StOutController =
//       List.generate(150, (i) => TextEditingController());
//   List<TextEditingController> StOutController2 =
//       List.generate(150, (i) => TextEditingController());

//   int i_value = 0;
//   int get get_i_value => i_value;
//   int ScannigVal = 0;
//   int get get_ScannigVal => ScannigVal;
//   int Scanned_Val = 0;
//   int get get_Scanned_Val => Scanned_Val;
//   int? selectIndex;
//   int? selectIndex2;
//   String? msg = '';
//   bool? OnclickDisable = false;
//   bool? OnScanDisable = false;

// //

//   bool? dbDataTrue = false;

//   Selectindex(int i) {
//     selectIndex = i;
//     notifyListeners();
//   }

//   Selectindex2(int i) {
//     selectIndex2 = i;
//     notifyListeners();
//   }

//   List<StockOutwardDetails>? Scandata;
//   List<String> ScandSerial = [];
//   // int i = 0;
//   List<List<String>>? test2;
//   int scannvalue2 = 0;
//   // List<StockOutSerialbatch> batchList = [];
//   getBatchData(int index, int list_i) async {
//     final Database db = (await DBHelper.getInstance())!;
//     List<Map<String, Object?>> getDBStOutBatchData =
//         await DBOperation.StOutCheckScanData(
//             db,
//             StockOutward[index].data[list_i].baseDocentry,
//             StockOutward[index].data[list_i].lineNo,
//             StockOutward[index].data[list_i].itemcode);
//     print(getDBStOutBatchData.length);
//     if (getDBStOutBatchData.isNotEmpty) {
//       StockOutward[index].data[list_i].serialbatchList = [];
//       StockOutward[index].data[list_i].serialbatchList!.add(StockOutSerialbatch(
//             lineno: getDBStOutBatchData[0]["lineno"].toString(),
//             docentry: getDBStOutBatchData[0]["docentry"].toString(),
//             itemcode: getDBStOutBatchData[0]["itemcode"].toString(),
//             qty: getDBStOutBatchData[0]["quantity"] == null
//                 ? 0
//                 : int.parse(getDBStOutBatchData[0]["quantity"].toString()),
//             scanbool: true,
//             serialbatch: getDBStOutBatchData[0]["serialBatch"].toString(),
//           ));
//       print("ascmkasckmascas" +
//           StockOutward[index].data[list_i].serialbatchList![0].qty.toString());
//     } else {
//       StockOutward[index].data[list_i].serialbatchList = [];
//     }
//     print("list Data ::" + StockOutward[index].data.length.toString());

//     notifyListeners();
//   }

//   Future stoutLineRefersh(int index, int list_i) async {
//     print(index);
//     print(list_i);

//     final Database db = (await DBHelper.getInstance())!;

//     List<Map<String, Object?>> getStockReqLineData =
//         await DBOperation.getTrasferQty(
//             db, int.parse(StockOutward[index].baceDocentry.toString()));
//     StockOutward[index].data.clear();
//     print("loop 2");

//     for (int j = 0; j < getStockReqLineData.length; j++) {
     

//       // if (StockOutward[index].data[list_i].lineNo ==
//       //     int.parse(getStockReqLineData[j]["lineNo"].toString())) {

//       StockOutward[index].data.add(StockOutwardDetails(
//           createdUserID:
//               int.parse(getStockReqLineData[j]["createdUserID"].toString()),
//           createdateTime: getStockReqLineData[j]["createdateTime"].toString(),
//           docentry: int.parse(getStockReqLineData[j]["docentry"].toString()),
//           baseDocentry:
//               int.parse(getStockReqLineData[j]["docentry"].toString()),
//           dscription: "",
//           itemcode: getStockReqLineData[j]["itemcode"].toString(),
//           lastupdateIp: getStockReqLineData[j]["lastupdateIp"].toString(),
//           lineNo: int.parse(getStockReqLineData[j]["lineNo"].toString()),
//           baseDocline: int.parse(getStockReqLineData[j]["lineNo"].toString()),
//           qty: int.parse(getStockReqLineData[j]["quantity"].toString()),
//           status: getStockReqLineData[j]["status"].toString(),
//           updatedDatetime: getStockReqLineData[j]["UpdatedDatetime"].toString(),
//           updateduserid:
//               int.parse(getStockReqLineData[j]["createdUserID"].toString()),
//           trans_Qty: int.parse(getStockReqLineData[j]["balqty"].toString()),
//           price: double.parse(getStockReqLineData[j]["price"].toString()),
//           serialBatch: StockOutward[index].data.isEmpty
//               ? ""
//               : StockOutward[index].data[list_i].serialBatch,
//           taxRate: double.parse(getStockReqLineData[j]["taxRate"].toString()),
//           taxType: getStockReqLineData[j]["taxType"].toString(),
//           // serialbatchList: serialbatchList2,
//           Scanned_Qty:
//               int.parse(getStockReqLineData[j]["scanndQty"].toString())));
//       notifyListeners();

//       // }
//     }
//     print("Kuthirai:::" + StockOutward[index].data.length.toString());
//     print("Kuthirai222:::" +
//         StockOutward[index]
//             .data[0]
//             .serialbatchList![0]
//             .serialbatch!
//             .toString());
//     searchcon.clear();
//     notifyListeners();
//   }

//   // get scanned searial batch
//   TextEditingController searchcon = TextEditingController();
//   List<StockSnapTModelDB> getSearchedData = [];
//   List<StockSnapTModelDB> getfilterSearchedData = [];
//   Future<List<StockSnapTModelDB>> getAllList(String data) async {
//     final Database db = (await DBHelper.getInstance())!;
//     getSearchedData = await DBOperation.getSearchedStockListBatch(db, data);
//     if (getSearchedData.isNotEmpty) {
//       searchError = "";
//       getfilterSearchedData = getSearchedData;
//       return getSearchedData;
//     } else {
//       searchError = "No data Found..!!";
//       return getSearchedData;
//     }
//   }

//   filterListSearched(String v) {
//     if (v.isNotEmpty) {
//       getfilterSearchedData = getSearchedData
//           .where((e) =>
//               e.itemcode!.toLowerCase().contains(v.toLowerCase()) ||
//               e.itemname!.toLowerCase().contains(v.toLowerCase()))
//           .toList();
//       notifyListeners();
//     } else if (v.isEmpty) {
//       getfilterSearchedData = getSearchedData;
//       notifyListeners();
//     }
//   }

//   ///

//   Future scanqtyRemove(int index, int list_i, int batchI) async {
//     final Database db = (await DBHelper.getInstance())!;
   

//     if (StockOutward[index].data[list_i].trans_Qty! !=
//         StockOutward[index].data[list_i].serialbatchList![batchI].qty!) {
//       StockOutward[index].data[list_i].serialbatchList![batchI].qty =
//           StockOutward[index].data[list_i].serialbatchList![batchI].qty! - 1;
//       msg = "";
//       notifyListeners();
//       if (StockOutward[index].data[list_i].serialbatchList![batchI].qty! == 0) {
//         print("object-Delete" +
//             StockOutward[index]
//                 .data[list_i]
//                 .serialbatchList![batchI]
//                 .docentry!
//                 .toString());

//         await DBOperation.deleteBatch(
//             db,
//             int.parse(StockOutward[index]
//                 .data[list_i]
//                 .serialbatchList![batchI]
//                 .docentry!
//                 .toString()),
//             int.parse(StockOutward[index]
//                 .data[list_i]
//                 .serialbatchList![batchI]
//                 .lineno
//                 .toString()),
//             StockOutward[index]
//                 .data[list_i]
//                 .serialbatchList![batchI]
//                 .itemcode
//                 .toString());
//         StockOutward[index].data[list_i].serialbatchList!.removeAt(batchI);
//       } else if (StockOutward[index]
//               .data[list_i]
//               .serialbatchList![batchI]
//               .qty! >
//           1) {
//         print("object-Minus");
//         await DBOperation.UpdateQTYBatch(
//             db,
//             int.parse(StockOutward[index]
//                 .data[list_i]
//                 .serialbatchList![batchI]
//                 .docentry!
//                 .toString()),
//             int.parse(StockOutward[index]
//                 .data[list_i]
//                 .serialbatchList![batchI]
//                 .lineno
//                 .toString()),
//             StockOutward[index]
//                 .data[list_i]
//                 .serialbatchList![batchI]
//                 .itemcode
//                 .toString());
//       }
//     } else if (StockOutward[index].data[list_i].trans_Qty ==
//         StockOutward[index].data[list_i].serialbatchList![batchI].qty) {
//       print("No More Qty to add...!!");
//       msg = 'Alreaty This Item is Submited...!!';
//     } // return StockOutward[index].data[list_i].serialbatchList![batchI].qty;
//     notifyListeners();
//   }

//   searchInitMethod() {
//     StOutController[100].text = config.alignDate(config.currentDate());
//     StOutController[101].text = config.alignDate(config.currentDate());
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
//     log(fromdate);
//     log(todate);

//     searchbool = true;
//     final Database db = (await DBHelper.getInstance())!;
//     List<Map<String, Object?>> getStockoutHeader =
//         await DBOperation.getStockOutHeaderDateWise(
//             db, config.alignDate2(fromdate), config.alignDate2(todate));

//     List<searchModel> searchdata2 = [];
//     searchData.clear();

//     if (getStockoutHeader.isNotEmpty) {
//       for (int i = 0; i < getStockoutHeader.length; i++) {
//         searchdata2.add(searchModel(
//             username: UserValues.username,
//             terminal: AppConstant.terminal,
//             type: getStockoutHeader[i]["docstatus"] == null
//                 ? ""
//                 : getStockoutHeader[i]["docstatus"] == "2"
//                     ? "Against Order"
//                     : getStockoutHeader[i]["docstatus"] == "3"
//                         ? "Against Stock"
//                         : "",
//             // sapDocNo: getStockoutHeader[i]["sapDocNo"] == null
//             //     ? 0
//             //     : int.parse(getStockoutHeader[i]["sapDocNo"].toString()),
//             qStatus: getStockoutHeader[i]["qStatus"] == null
//                 ? ""
//                 : getStockoutHeader[i]["qStatus"].toString(),
//             docentry: getStockoutHeader[i]["docentry"] == null
//                 ? 0
//                 : int.parse(getStockoutHeader[i]["docentry"].toString()),
//             docNo: getStockoutHeader[i]["reqdocno"] == null
//                 ? '0'
//                 : getStockoutHeader[i]["reqdocno"].toString(),
//             docDate: getStockoutHeader[i]["createdateTime"].toString(),
//             sapNo: getStockoutHeader[i]["sapDocNo"] == null
//                 ? 0
//                 : int.parse(getStockoutHeader[i]["sapDocNo"].toString()),
//             sapDate: getStockoutHeader[i]["createdateTime"] == null
//                 ? ""
//                 : getStockoutHeader[i]["createdateTime"].toString(),
//             customeraName: getStockoutHeader[i]["reqfromWhs"].toString(),
//             doctotal: getStockoutHeader[i][""] == null
//                 ? 0
//                 : double.parse(getStockoutHeader[i][""].toString())));
//         notifyListeners();
//       }
//       searchData.addAll(searchdata2);
//       filtersearchData = searchData;
//     } else {
//       log("aasdasdasda");
//       searchbool = false;
//       searchData.clear();
//       notifyListeners();
//     }
//     notifyListeners();
//   }

//   List<StockOutwardList> StockOutward2 = [];

//   fixDataMethod(int docentry) async {
//     StockOutward2.clear();
//     StOutController2[50].text = "";
//     final Database db = (await DBHelper.getInstance())!;
//     List<Map<String, Object?>> getDB_StoutHeader =
//         await DBOperation.getStockOutHeader(db, docentry);
//     List<Map<String, Object?>> getDB_StoutLine =
//         await DBOperation.StOutLineDB(db, docentry);
//     List<StockOutwardList> StockOutDATA2 = [];
//     List<StockOutwardDetails> stockDetails2 = [];
//     // List<StockOutSerialbatch> stockSerialBatch2 = [];
//     log("Header" + getDB_StoutHeader.length.toString());
//     log("line" + getDB_StoutLine[0]["itemcode"].toString());
//     log("Batch");
// //  List<StockOutwardDetails> stoutDetails = [];
// //     List<StockOutwardList> stoutList = [];

// // List<StockOutwardList> stoutList=[];
//     for (int j = 0; j < getDB_StoutLine.length; j++) {
//       List<StockOutSerialbatch> stoutSeralBatchList = [];

//       stockDetails2.add(StockOutwardDetails(
//           createdUserID: 1,
//           createdateTime: getDB_StoutLine[j]["createdateTime"].toString(),
//           baseDocentry:
//               int.parse(getDB_StoutLine[j]["baseDocentry"].toString()),
//           docentry: int.parse(getDB_StoutLine[j]["docentry"].toString()),
//           dscription: getDB_StoutLine[j]["description"].toString(),
//           itemcode: getDB_StoutLine[j]["itemcode"].toString(),
//           lastupdateIp: "",
//           lineNo: getDB_StoutLine[j]["lineno"] == null
//               ? 0
//               : int.parse(getDB_StoutLine[j]["lineno"].toString()),
//           qty: getDB_StoutLine[j]["quantity"] == null
//               ? 0
//               : int.parse(getDB_StoutLine[j]["quantity"].toString()),
//           status: getDB_StoutLine[j]["createdateTime"].toString(),
//           updatedDatetime: getDB_StoutLine[j]["createdateTime"].toString(),
//           updateduserid: 1,
//           price: 1,
//           serialBatch: getDB_StoutLine[j]["serialBatch"].toString(),
//           taxRate: 0.0,
//           taxType: "",
//           trans_Qty: getDB_StoutLine[j]["transferQty"] == null
//               ? 0
//               : int.parse(getDB_StoutLine[j]["transferQty"].toString()),
//           Scanned_Qty: getDB_StoutLine[j]["scannedQty"] == null
//               ? 0
//               : int.parse(getDB_StoutLine[j]["scannedQty"].toString()),
//           baseDocline: getDB_StoutLine[j]["baseDocline"] == null
//               ? 0
//               : int.parse(getDB_StoutLine[j]["baseDocline"].toString()),
//           serialbatchList: stoutSeralBatchList));
//     }
//     StOutController2[50].text = getDB_StoutHeader[0]["remarks"].toString();
//     StockOutDATA2.add(StockOutwardList(
//         branch: getDB_StoutHeader[0]["branch"].toString(),
//         // createdUserID: StockOut[index].createdUserID,
//         // createdateTime: StockOut[index].createdateTime,
//         docentry: getDB_StoutHeader[0]["docentry"].toString(),
//         baceDocentry: getDB_StoutHeader[0]["baceDocentry"].toString(),
//         docstatus: getDB_StoutHeader[0]["baceDocentry"].toString(),
//         documentno: getDB_StoutHeader[0]["documentno"] == null
//             ? "0"
//             : getDB_StoutHeader[0]["documentno"].toString(),
//         // isagainstorder: StockOut[index].isagainstorder,
//         // isagainststock: StockOut[index].isagainststock,
//         // lastupdateIp: StockOut[index].lastupdateIp,
//         // reqdocno: StockOut[index].reqdocno,
//         // reqdocseries: StockOut[index].reqdocseries,
//         // reqdocseriesno: StockOut[index].reqdocseriesno,
//         // reqdoctime: StockOut[index].reqdoctime,
//         reqfromWhs: getDB_StoutHeader[0]["reqfromWhs"].toString(),
//         // reqsystime: StockOut[index].reqsystime,
//         reqtoWhs: getDB_StoutHeader[0]["reqtoWhs"].toString(),
//         reqtransdate: getDB_StoutHeader[0]["transdate"].toString(),
//         // salesexec: StockOut[index].salesexec,
//         // seresid: StockOut[index].seresid,
//         // seriesnum: StockOut[index].seriesnum,
//         // sysdatetime: StockOut[index].sysdatetime,
//         // totalitems: StockOut[index].totalitems,
//         // totalltr: StockOut[index].totalltr,
//         // totalqty: StockOut[index].totalqty,
//         // totalweight: StockOut[index].totalweight,
//         // transactiondate: StockOut[index].transactiondate,
//         // transtime: StockOut[index].transtime,
//         // updatedDatetime: StockOut[index].updatedDatetime,
//         // updateduserid: StockOut[index].updateduserid,
//         data: stockDetails2));

//     StockOutward2.addAll(StockOutDATA2);
//     notifyListeners();
//   }

//   getDate2(BuildContext context, datetype) async {
//     DateTime? pickedDate = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(2000),
//         lastDate: DateTime(2100));

//     if (pickedDate != null && datetype == "From") {
//       print(pickedDate);
//       datetype = DateFormat('dd-MM-yyyy').format(pickedDate);
//       StOutController[100].text = datetype!;
//       print(datetype);
//     } else if (pickedDate != null && datetype == "To") {
//       print(pickedDate);
//       datetype = DateFormat('dd-MM-yyyy').format(pickedDate);
//       StOutController[101].text = datetype!;
//       print(datetype);
//     } else {
//       print("Date is not selected");
//     }
//   }

//   scanmethod(int index, String serialBatch, int list_i, String itemcode) async {
//     log("AAAA1:" + index.toString());
//     log("AAAA2:" + list_i.toString());
//     log("AAAA3:" + serialBatch);
//     serialBatch = searchcon.text.toString();
//     if (itemcode == StockOutward[index].data[list_i].itemcode.toString()) {
//       OnScanDisable = true;
//       // StockOutward[i].data.length;
//       final Database db = (await DBHelper.getInstance())!;
//       msg = "";
//       List<Map<String, Object?>> serailbatchCheck =
//           await DBOperation.serialBatchCheck(db, serialBatch.toString().trim(),
//               StockOutward[index].data[list_i].itemcode.toString());
//       if (serailbatchCheck.isNotEmpty) {
//         if (int.parse(serailbatchCheck[0]["quantity"].toString()) != 0) {
//           int totalqty = int.parse(serailbatchCheck[0]["quantity"].toString());
//           int totalscanqty = 0;
//           for (int i = 0;
//               i < StockOutward[index].data[list_i].serialbatchList!.length;
//               i++) {
//             totalscanqty = totalscanqty +
//                 StockOutward[index].data[list_i].serialbatchList![i].qty!;
//             notifyListeners();
//           }

//           if ((totalqty > totalscanqty) &&
//               (StockOutward[index].data[list_i].qty != totalscanqty)) {
//             msg = "";
//             print(StOutController[0].text.toString().toUpperCase());
//             List<Map<String, Object?>> getDBStOutBatchList =
//                 await DBOperation.getBachList(
//                     db,
//                     StockOutward[index].data[list_i].baseDocentry,
//                     StockOutward[index].data[list_i].lineNo,
//                     StockOutward[index].data[list_i].itemcode,
//                     serialBatch.toString().trim());
//             // stoutLineRefersh(index, list_i);

//             if (getDBStOutBatchList.isNotEmpty) {
//               print(";;;;;;;;;;;;;;;;;;;;;;;;;;;;");
//               await DBOperation.UpdateStOutBach(
//                   db,
//                   StockOutward[index].data[list_i].baseDocentry,
//                   StockOutward[index].data[list_i].lineNo,
//                   StockOutward[index].data[list_i].itemcode);
//               //
//               List<Map<String, Object?>> getDBStOutBatchData =
//                   await DBOperation.GetStOutCheckScanData(
//                       db,
//                       StockOutward[index].data[list_i].baseDocentry,
//                       StockOutward[index].data[list_i].lineNo,
//                       StockOutward[index].data[list_i].itemcode);
//               // StockOutward[index].data[list_i].serialbatchList = [];

//               for (int k = 0;
//                   k < StockOutward[index].data[list_i].serialbatchList!.length;
//                   k++) {
//                 if (StockOutward[index]
//                         .data[list_i]
//                         .serialbatchList![k]
//                         .lineno ==
//                     getDBStOutBatchData[0]["lineno"].toString()) {
//                   StockOutward[index]
//                       .data[list_i]
//                       .serialbatchList![k]
//                       .docentry = getDBStOutBatchData[0]["docentry"].toString();
//                   StockOutward[index].data[list_i].serialbatchList![k].lineno =
//                       getDBStOutBatchData[0]["lineno"].toString();
//                   StockOutward[index]
//                       .data[list_i]
//                       .serialbatchList![k]
//                       .itemcode = getDBStOutBatchData[0]["itemcode"].toString();
//                   StockOutward[index].data[list_i].serialbatchList![k].qty =
//                       getDBStOutBatchData[0]["quantity"] == null
//                           ? 0
//                           : int.parse(
//                               getDBStOutBatchData[0]["quantity"].toString());
//                   print("serial qty score::" +
//                       StockOutward[index]
//                           .data[list_i]
//                           .serialbatchList![k]
//                           .qty
//                           .toString());
//                   StockOutward[index]
//                           .data[list_i]
//                           .serialbatchList![k]
//                           .serialbatch =
//                       getDBStOutBatchData[0]["serialBatch"].toString();
//                   notifyListeners();
//                 }
//                 notifyListeners();
//               }
//               print("serial batch leanght" +
//                   StockOutward[index]
//                       .data[list_i]
//                       .serialbatchList!
//                       .length
//                       .toString());

//               notifyListeners();
//             } else {
//               List<StockOutBatchDataDB> StOutBatch = [];
//               log("serrrrrrrrrrrrrrrrr" + serialBatch.toString());
//               StOutBatch.add(StockOutBatchDataDB(
//                 lineno: StockOutward[index].data[list_i].lineNo.toString(),
//                 docentry:
//                     StockOutward[index].data[list_i].baseDocentry.toString(),
//                 itemcode: StockOutward[index].data[list_i].itemcode,
//                 qty: 1,
//                 serialbatch: serialBatch.toString(),
//                 docstatus: null,

//                 // scannedQty: StockOutward[index].data[i].Scanned_Qty
//               ));
//               await DBOperation.insertStOutBatch(db, StOutBatch);
//               List<Map<String, Object?>> getDBStOutBatchData =
//                   await DBOperation.GetStOutCheckScanData(
//                       db,
//                       StockOutward[index].data[list_i].baseDocentry,
//                       StockOutward[index].data[list_i].lineNo,
//                       StockOutward[index].data[list_i].itemcode);
//               print("new batch leanght" +
//                   getDBStOutBatchData[0]["docentry"].toString());
//               StockOutward[index].data[list_i].serialbatchList = [];
//               for (int l = 0; l < getDBStOutBatchData.length; l++) {
// //
//                 StockOutward[index].data[list_i].serialbatchList!.add(
//                     StockOutSerialbatch(
//                         lineno: getDBStOutBatchData[l]["lineno"].toString(),
//                         docentry: getDBStOutBatchData[l]["docentry"].toString(),
//                         itemcode: getDBStOutBatchData[l]["itemcode"].toString(),
//                         qty: 1,
//                         serialbatch:
//                             getDBStOutBatchData[l]["serialBatch"].toString()));
//               }

//               print("serial batchhhh leanght" +
//                   StockOutward[index].data[list_i].baseDocentry!.toString());

//               notifyListeners();
//             }
//           } else {
//             print("No More Qty to add...!!");
//             msg = 'No More Qty to add...!!';
//           }
//         } else {
//           msg = "No Qty Does Not Have...!!";
//         }
//         // }

//         notifyListeners();
//       } else {
//         msg = 'Wrong BatchCode Scan...!!';
//       }
//       OnScanDisable = false;
//       serialBatch = "";
//     } else {
//       msg = "Itemcode Does not Matched...!!";
//       notifyListeners();
//     }
//     searchcon.text = "";
//     OnScanDisable = false;
//     notifyListeners();
//   }

//   suspendedbutton(int index, BuildContext context, ThemeData theme,
//       List<StockOutwardDetails>? data, StockOutwardList? datatotal) async {
//     final Database db = (await DBHelper.getInstance())!;

//     int? scannedtottal = 0;
//     int? totalReqQty = 0;
//     int? totalTransQty = 0;

//     for (int i = 0; i < data!.length; i++) {
//       scannedtottal = scannedtottal! + data[i].Scanned_Qty!;
//       totalTransQty = totalTransQty! + data[i].trans_Qty!;
//       totalReqQty = totalReqQty! + data[i].qty!;
//       notifyListeners();
//     }
//     log(scannedtottal!.toString());
//     log(totalReqQty!.toString());

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
//                   child: Text("Close"),
//                   onPressed: () => Get.back(),
//                 ),
//               ],
//             ),
//           ],
//           radius: 5);
//     } else if (scannedtottal != 0) {
//       // await DBOperation.deleteSuspendBatchStOut(
//       //     db, int.parse(StockOutward[index].baceDocentry.toString()));
//       for (int i = 0; i < StockOutward[index].data.length; i++) {
//         StockOutward[index].data[i].Scanned_Qty = 0;
//         StockOutward[index].data[i].serialbatchList = [];
//         // StockOutward[index].data[i].serialbatchList!=null;
//         notifyListeners();
//       }
//       // SuspendDBInsert('suspend', context, theme, index, data, datatotal);
//     }
//     notifyListeners();
//   }

//   submitbutton(int index, BuildContext context, ThemeData theme,
//       List<StockOutwardDetails>? data, StockOutwardList? datatotal) {
//     OnclickDisable = true;
//     if (data!.isEmpty) {
//       Get.defaultDialog(
//               // content: Container(
//               //   width: Screens.width(context) * 0.4,
//               //   height: Screens.bodyheight(context) * 0.1,
//               // ),
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
//                       child: Text("Close"),
//                       onPressed: () => Get.back(),
//                     ),
//                   ],
//                 ),
//               ],
//               radius: 0)
//           .then((value) {
//         OnclickDisable = false;
//         notifyListeners();
//       });
//     } else {
//       int? scannedtottal = 0;
//       int? totalReqQty = 0;
//       int? totalscanqty = 0;

//       for (int i = 0; i < data.length; i++) {
//         scannedtottal =
//             scannedtottal! + data[i].Scanned_Qty! + data[i].trans_Qty!;
//         totalReqQty = totalReqQty! + data[i].qty!;
//         totalscanqty = totalscanqty! + data[i].Scanned_Qty!;
//         notifyListeners();
//       }
//       log(scannedtottal!.toString());
//       log(totalReqQty!.toString());

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
//                         child: Text("Close"),
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
//       } else if (totalscanqty != 0) {
//         savepartialData('submit', context, theme, index, data, datatotal);
//       }
//     }
//   }

//   savepartialData(
//       String docstatus,
//       BuildContext context,
//       ThemeData theme,
//       int index,
//       List<StockOutwardDetails>? data,
//       StockOutwardList? datatotal) async {
//     OnclickDisable = true;
//     final Database db = (await DBHelper.getInstance())!;
//     List<StockOutHeaderDataDB> StOutHeader = []; //headersss
//     List<StockOutLineDataDB> StOutLine = [];
//     List<StockOutBatchDataDB> StOutBatch = [];
//     bool submitBool = false;
//     log("Save Data Process");
//     // StockOutward[index].data[i].serialbatchList = [];
//     // int count = 0;
//     int scanToatal = 0;
//     int qtyToatal = 0;
//     int tempDocentry = 0;

//     for (int i = 0; i < StockOutward[index].data.length; i++) {
//       scanToatal = scanToatal + StockOutward[index].data[i].Scanned_Qty!;
//       qtyToatal = qtyToatal + StockOutward[index].data[i].qty!;
//       if (scanToatal == qtyToatal) {
//         submitBool = true;
//         notifyListeners();
//       }
//     }
//     int? docEntryCreated = await DBOperation.generateDocentr(
//         db, "docentry", "StockOutHeaderDataDB");
//     DBOperation.getSaleHeadSapDet(
//         db, int.parse(StockOutward[index].baceDocentry!), 'SalesHeader');
//     List<Map<String, Object?>> count = await DBOperation.StockHeaderCheck(
//         db, int.parse(StockOutward[index].baceDocentry.toString()));

//     List<Map<String, Object?>> sapdetails = await DBOperation.getSaleHeadSapDet(
//         db,
//         int.parse(StockOutward[index].baceDocentry.toString()),
//         'StockReqHDT');

//     if (count.length != 0) {
//       await DBOperation.UpdateSTOUT_Header(
//           db,
//           config.currentDate(),
//           config.currentDate(),
//           int.parse(StockOutward[index].baceDocentry.toString()));

//       List<Map<String, Object?>> getDB_StOutBatch =
//           await DBOperation.getStockOutBatch(
//               db, int.parse(StockOutward[index].baceDocentry.toString()));
//       for (int k = 0; k < getDB_StOutBatch.length; k++) {
//         List<Map<String, Object?>> count2 = await DBOperation.StockOutLineCheck(
//             db,
//             // int.parse(StockOutward[index].docentry.toString()),
//             int.parse(getDB_StOutBatch[k]["docentry"].toString()),
//             int.parse(getDB_StOutBatch[k]["lineno"].toString()),
//             getDB_StOutBatch[k]["itemcode"].toString());

//         if (count2.length == 0) {
//           for (int j = 0; j < StockOutward[index].data.length; j++) {
//             if (StockOutward[index].data[j].itemcode ==
//                     getDB_StOutBatch[k]["itemcode"].toString() &&
//                 StockOutward[index].data[j].lineNo ==
//                     int.parse(getDB_StOutBatch[k]["lineno"].toString())) {
//               StOutLine.add(StockOutLineDataDB(
//                 lineno: getDB_StOutBatch[k]["lineno"].toString(),
//                 docentry: count[0]["docentry"].toString(),
//                 itemcode: StockOutward[index].data[j].itemcode.toString(),
//                 description: StockOutward[index].data[j].dscription,
//                 qty: int.parse(StockOutward[index].data[j].qty.toString()),
//                 baseDocentry: StockOutward[index].baceDocentry.toString(),
//                 baseDocline: StockOutward[index].data[j].lineNo.toString(),
//                 status: StockOutward[index].data[j].status,
//                 traansferQty: StockOutward[index].data[j].Scanned_Qty,
//                 scannedQty: StockOutward[index].data[j].Scanned_Qty,
//                 serialBatch: getDB_StOutBatch[k]["serialBatch"].toString(),
//                 terminal: UserValues.terminal,
//                 branch: UserValues.branch,
//               ));
//             }
//           }
//           await DBOperation.insertStOutLine(db, StOutLine);
//         }
//       }
//     } else if (count.length == 0) {
//       log("doc Encrept::::======" + docEntryCreated.toString());
//       StOutHeader.add(StockOutHeaderDataDB(
//           docentry: docEntryCreated.toString(),
//           terminal: UserValues.terminal,
//           branch: UserValues.branch,
//           baseDocentry: StockOutward[index].baceDocentry,
//           createdUserID: UserValues.userID,
//           createdateTime: config.currentDate(),
//           docstatus: "3",
//           lastupdateIp: UserValues.lastUpdateIp,
//           reqdocno: StockOutward[index].documentno.toString(),
//           docseries: "",
//           docseriesno: 0,
//           doctime: config.currentDate(),
//           reqfromWhs: StockOutward[index].reqfromWhs,
//           systime: config.currentDate(),
//           reqtoWhs: StockOutward[index].reqtoWhs,
//           transdate: config.currentDate(),
//           salesexec: "",
//           totalitems: 0,
//           totalltr: 0,
//           totalqty: 0,
//           updatedDatetime: config.currentDate(),
//           updateduserid: UserValues.userID,
//           sapDocNo: null,
//           sapDocentry: null,
//           qStatus: 'N',
//           sapStockReqdocentry:
//               sapdetails[0]['sapDocentry'].toString(), //checkkkkkkk
//           sapStockReqdocnum: sapdetails[0]['sapDocNo'].toString(),
//           remarks: StOutController[50].text.toString()));

//       //  StockOutward[index].updateduserid,//
//       // ));
//       int? docentry2 = await DBOperation.insertStockOutheader(db, StOutHeader);
//       tempDocentry = docentry2!;
//       for (int i = 0; i < StockOutward[index].data.length; i++) {

//          List<StockOutSerialbatch>? serialbatchList2 = [];
//       List<Map<String, Object?>> getDBStOutBatchData =
//           await DBOperation.GetStOutCheckScanData(
//               db,
//               StockOutward[index].data[i].baseDocentry,
//              StockOutward[index].data[i].lineNo,
//               StockOutward[index].data[i].itemcode.toString(),);
     
//       if (getDBStOutBatchData.isNotEmpty) {
//         for (int l = 0; l < getDBStOutBatchData.length; l++) {
//           serialbatchList2.add(StockOutSerialbatch(
//               lineno: getDBStOutBatchData[l]["lineno"].toString(),
//               docentry: getDBStOutBatchData[l]["docentry"].toString(),
//               itemcode: getDBStOutBatchData[l]["itemcode"].toString(),
//               qty: getDBStOutBatchData[l]["quantity"] == null
//                   ? 0
//                   : int.parse(getDBStOutBatchData[l]["quantity"].toString()),
//               serialbatch: getDBStOutBatchData[l]["serialBatch"].toString()));
//         }
//       }
//         //  List<Map<String, Object?>> getDB_StOutBatch =
//         // await DBOperation.getStockOutBatch(
//         //     db, int.parse(StockOutward[index].baceDocentry.toString()));
//         if (StockOutward[index].data[i].Scanned_Qty! !=
//                 StockOutward[index].data[i].qty &&
//             StockOutward[index].data[i].Scanned_Qty != 0) {
//           StOutLine.add(StockOutLineDataDB(
//             lineno: StockOutward[index].data[i].lineNo.toString(),
//             docentry: docentry2.toString(),
//             itemcode: StockOutward[index].data[i].itemcode.toString(),
//             description: StockOutward[index].data[i].dscription,
//             qty: int.parse(StockOutward[index].data[i].qty.toString()),
//             baseDocentry: StockOutward[index].data[i].docentry.toString(),
//             baseDocline: StockOutward[index].data[i].lineNo.toString(),
//             status: StockOutward[index].data[i].status,
//             traansferQty: StockOutward[index].data[i].Scanned_Qty,
//             scannedQty: StockOutward[index].data[i].Scanned_Qty,
//             serialBatch: getDBStOutBatchData[0]["serialBatch"]==null?"": getDBStOutBatchData[0]["serialBatch"].toString(),
//             branch: UserValues.branch,
//             terminal: UserValues.terminal,
//           ));
//         } else if (StockOutward[index].data[i].Scanned_Qty! ==
//                 StockOutward[index].data[i].qty &&
//             StockOutward[index].data[i].Scanned_Qty != 0) {
//           StOutLine.add(StockOutLineDataDB(
//             lineno: StockOutward[index].data[i].lineNo.toString(),
//             docentry: docentry2.toString(),
//             itemcode: StockOutward[index].data[i].itemcode.toString(),
//             description: StockOutward[index].data[i].dscription,
//             qty: int.parse(StockOutward[index].data[i].qty.toString()),
//             baseDocentry: StockOutward[index].data[i].docentry.toString(),
//             baseDocline: StockOutward[index].data[i].lineNo.toString(),
//             status: StockOutward[index].data[i].status,
//             traansferQty: StockOutward[index].data[i].Scanned_Qty,
//             scannedQty: StockOutward[index].data[i].Scanned_Qty,
//             serialBatch:getDBStOutBatchData[0]["serialBatch"]==null?"": getDBStOutBatchData[0]["serialBatch"].toString(),
//             branch: UserValues.branch,
//             terminal: UserValues.terminal,
//           ));
//         }
//       }
//       // await DBOperation.insertStOutBatch(db, StOutBatch);
//       await DBOperation.insertStOutLine(db, StOutLine);
//     }
//     log("batch list length" + StOutBatch.length.toString());
//     log("tempDocentry" + tempDocentry.toString());
//     log("AlertDialogBox");
//     bool? netbool = await config.haveInterNet();

//     log("config.haveInterNet():::" + netbool.toString());
//     if (netbool == true) {
//       await PostRabitMq(
//           count.length == 0
//               ? tempDocentry
//               : StockOutward[index].data[0].docentry!,
//           int.parse(StockOutward[index].baceDocentry!),
//           StockOutward[index].reqfromWhs.toString());
//     }

//     await Get.defaultDialog(
//       title: "Alert",
//       middleText: ' Sucessfully Done \n'
//           " Stock Outward successfully saved..!!",
//       backgroundColor: Colors.white,
//       titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
//       middleTextStyle: theme.textTheme.bodyLarge,
//       radius: 5,
//       actions: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             TextButton(
//               child: Text("Close"),
//               onPressed: () => Get.back(),
//             ),
//           ],
//         ),
//       ],
//     ).then((value) {
//       OnclickDisable = false;
//       if (submitBool == true) {
//         StockOutward.remove(datatotal);
//         data!.clear();
//         StOutController[50].text = "";
//         StockOutward[index].data.clear();
//         tappageIndex = 0;
//         tappage = PageController();
//         notifyListeners();
//         // myFuture(context);
//         // Navigator.of(context)
//         //     .push(MaterialPageRoute(builder: (context) => DashBoardScreen()));
//       } else {
//         submitBool == false;
//       }
//     });
//     // if (submitBool == true) {
//     //   Get.toNamed(ConstantRoutes.dashboard);
//     //   // Navigator.of(context)
//     //   //     .push(MaterialPageRoute(builder: (context) => DashBoardScreen()));
//     //   // notifyListeners();
//     // }
//     notifyListeners();
//   }

//   static Future<List<Map<String, Object?>>> getStockOutBatch(
//       Database db, int docentry) async {
//     List<Map<String, Object?>> result = await db.rawQuery('''
//     select * from StockOutBatchDB where docentry = "$docentry"
//      ''');
//     //  log("StockReqHDT hold:: "+result.toList().toString());

//     return result;
//   }

//   Future myFuture(BuildContext context, ThemeData theme,
//       List<StockOutwardDetails>? data) async {
//     if (data!.isEmpty) {
//       Get.defaultDialog(
//           // content: Container(
//           //   width: Screens.width(context) * 0.4,
//           //   height: Screens.bodyheight(context) * 0.1,
//           // ),
//           title: "Alert",
//           middleText: 'Please Select Items..!!',
//           backgroundColor: Colors.white,
//           titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
//           middleTextStyle: theme.textTheme.bodyLarge,
//           actions: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                   child: Text("Close"),
//                   onPressed: () => Get.back(),
//                 ),
//               ],
//             ),
//           ],
//           radius: 5);
//     } else {
//       int? scannedtottal = 0;
//       int? totalReqQty = 0;
//       int? totalscanqty = 0;

//       for (int i = 0; i < data.length; i++) {
//         scannedtottal =
//             scannedtottal! + data[i].Scanned_Qty! + data[i].trans_Qty!;
//         totalReqQty = totalReqQty! + data[i].qty!;
//         totalscanqty = totalscanqty! + data[i].Scanned_Qty!;
//         notifyListeners();
//       }
//       log(scannedtottal!.toString());
//       log(totalReqQty!.toString());

//       if (totalscanqty == 0) {
//         Get.defaultDialog(
//             title: "Alert",
//             middleText: 'Please Select Items..!!',
//             backgroundColor: Colors.white,
//             titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
//             middleTextStyle: theme.textTheme.bodyLarge,
//             actions: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   TextButton(
//                     child: Text("Close"),
//                     onPressed: () => Get.back(),
//                   ),
//                 ],
//               ),
//             ],
//             radius: 5);
//       } else if (totalscanqty != 0) {
//         await Future.delayed(Duration(seconds: 1));
//         Navigator.of(context)
//             .push(MaterialPageRoute(builder: (context) => DashBoardScreen()));
//       }
//     }
//   }
// // disableKeyBoard(BuildContext context) {
// //     FocusScopeNode currentFocus = FocusScope.of(context);

// //     if (!currentFocus.hasPrimaryFocus) {
// //       currentFocus.unfocus();
// //     }
// //     notifyListeners();
// //   }
//   holdbutton(int index, BuildContext context, ThemeData theme,
//       List<StockOutwardDetails>? data, StockOutwardList? datatotal) async {
//     final Database db = (await DBHelper.getInstance())!;

//     int? scannedtottal = 0;
//     int? totalReqQty = 0;
//     int? totalTransQty = 0;

//     for (int i = 0; i < data!.length; i++) {
//       scannedtottal = scannedtottal! + data[i].Scanned_Qty!;
//       totalTransQty = totalTransQty! + data[i].trans_Qty!;
//       totalReqQty = totalReqQty! + data[i].qty!;
//       notifyListeners();
//     }
//     log(scannedtottal!.toString());
//     log(totalReqQty!.toString());

//     if (scannedtottal == 0) {
//       Get.defaultDialog(
//           // content: Container(
//           //   width: Screens.width(context) * 0.4,
//           //   height: Screens.bodyheight(context) * 0.1,
//           // ),
//           title: "Alert",
//           middleText: 'Please Scan Minimum One Item..!!',
//           backgroundColor: Colors.white,
//           titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
//           middleTextStyle: theme.textTheme.bodyLarge,
//           actions: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                   child: Text("Close"),
//                   onPressed: () => Get.back(),
//                 ),
//               ],
//             ),
//           ],
//           radius: 5);
//     } else if (scannedtottal != 0) {
//       HoldValueInsertToDB('hold', context, theme, index, data, datatotal);
//       notifyListeners();
//     }

//     notifyListeners();
//   }

//   HoldValueInsertToDB(
//       String docstatus,
//       BuildContext context,
//       ThemeData theme,
//       int index,
//       List<StockOutwardDetails>? data,
//       StockOutwardList? datatotal) async {
//     final Database db = (await DBHelper.getInstance())!;
//     List<StockOutHeaderDataDB> StOutHeader = [];
//     List<StockOutLineDataDB> StOutLine = [];
//     List<StockOutBatchDataDB> StOutBatch = [];

//     log("Save Data Process");
//     log("Save Data Process" + StockOutward[index].baceDocentry.toString());
//     int? docEntryCreated = await DBOperation.generateDocentr(
//         db, "docentry", "StockOutHeaderDataDB");

//     StOutHeader.add(StockOutHeaderDataDB(
//         terminal: UserValues.terminal,
//         docentry: docEntryCreated.toString(),
//         branch: UserValues.branch,
//         createdUserID: UserValues.userID,
//         baseDocentry: StockOutward[index].baceDocentry,
//         createdateTime: config.currentDate(),
//         docstatus: '1',
//         lastupdateIp: UserValues.lastUpdateIp,
//         reqdocno: "0",
//         docseries: "",
//         docseriesno: 0,
//         doctime: config.currentDate(),
//         reqfromWhs: 'hofg', //StockOutward[index].reqfromWhs,
//         systime: config.currentDate(),
//         reqtoWhs: "hogit",
//         transdate: config.currentDate(),
//         salesexec: "",
//         totalitems: 0,
//         totalltr: 0,
//         totalqty: 0,
//         updatedDatetime: config.currentDate(),
//         updateduserid: UserValues.userID,
//         sapDocNo: null,
//         sapDocentry: null,
//         qStatus: 'N',
//         sapStockReqdocentry: '',
//         sapStockReqdocnum: '',
//         remarks: StOutController[50].text.toString()));
//     int? docentry2 = await DBOperation.insertStockOutheader(db, StOutHeader);

//     for (int i = 0; i < StockOutward[index].data.length; i++) {
//       StOutLine.add(StockOutLineDataDB(
//         lineno: (i + 1).toString(),
//         docentry: docentry2.toString(),
//         itemcode: StockOutward[index].data[i].itemcode.toString(),
//         description: StockOutward[index].data[i].dscription,
//         qty: int.parse(StockOutward[index].data[i].qty.toString()),
//         baseDocentry: StockOutward[index].baceDocentry.toString(),
//         baseDocline: StockOutward[index].data[i].lineNo.toString(),
//         status: StockOutward[index].data[i].status,
//         traansferQty: StockOutward[index].data[i].trans_Qty,
//         scannedQty: StockOutward[index].data[i].Scanned_Qty,
//         serialBatch: StockOutward[index].data[i].serialBatch.toString(),
//         branch: UserValues.branch,
//         terminal: UserValues.terminal,
//       ));
//       log("batch list length" + StockOutward[index].baceDocentry.toString());
//       log("StOutLine list " + StOutLine[0].baseDocentry.toString());
//       // StOutBatch.add(StockOutBatchDataDB(
//       //   lineno: StockOutward[index].data[i].lineNo.toString(),
//       //   docentry: docentry2.toString(),
//       //   itemcode: StockOutward[index].data[i].itemcode,
//       //   qty: StockOutward[index].data[i].Scanned_Qty,
//       //   serialbatch: StockOutward[index].data[i].serialBatch,
//       //   // scannedQty: StockOutward[index].data[i].Scanned_Qty
//       // ));
//     }
//     // await DBOperation.insertStOutBatch(db, StOutBatch);
//     await DBOperation.insertStOutLine(db, StOutLine);
//     log("Inside Hold Process");

//     getHoldValues(db);
//     log("AlertDialogBox");
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
//               child: Text("Close"),
//               onPressed: () => Get.back(),
//             ),
//           ],
//         ),
//       ],
//     ).then((value) {
//       StockOutward.remove(datatotal);
//       data!.clear();
//       // StockOutward[index].data.clear();
//     });

//     notifyListeners();
//   }

//   SuspendDBInsert(
//       String docstatus,
//       BuildContext context,
//       ThemeData theme,
//       int index,
//       List<StockOutwardDetails>? data,
//       StockOutwardList? datatotal) async {
//     final Database db = (await DBHelper.getInstance())!;
//     List<StockOutHeaderDataDB> StOutHeader = [];
//     List<StockOutLineDataDB> StOutLine = [];
//     List<StockOutBatchDataDB> StOutBatch = [];
//     log("Save Data Process");

//     StOutHeader.add(StockOutHeaderDataDB(
//         branch: UserValues.branch,
//         // StockOutward[index].branch,//
//         createdUserID: UserValues.userID,
//         baseDocentry: StockOutward[index].baceDocentry,
//         // StockOutward[index].createdUserID,//
//         createdateTime: config.currentDate(),
//         docstatus: "0",
//         lastupdateIp: UserValues.lastUpdateIp,
//         // StockOutward[index].lastupdateIp,//
//         reqdocno: "0",
//         // StockOutward[index].reqdocno,//
//         docseries: "",
//         //  StockOutward[index].reqdocseries,//
//         docseriesno: 0,
//         // StockOutward[index].reqdocseriesno,//
//         doctime: config.currentDate(),
//         reqfromWhs: StockOutward[index].reqfromWhs,
//         systime: config.currentDate(),
//         reqtoWhs: StockOutward[index].reqtoWhs, //
//         transdate: config.currentDate(),
//         salesexec: "",
//         //  StockOutward[index].salesexec,//
//         totalitems: 0,
//         // StockOutward[index].totalitems,//
//         totalltr: 0,
//         //  StockOutward[index].totalltr,//
//         totalqty: 0,
//         //  StockOutward[index].totalqty,//
//         updatedDatetime: config.currentDate(),
//         //  StockOutward[index].updatedDatetime,//
//         updateduserid: UserValues.userID,
//         terminal: UserValues.terminal,
//         sapDocNo: null,
//         sapDocentry: null,
//         qStatus: 'N',
//         sapStockReqdocentry: '',
//         sapStockReqdocnum: '',
//         remarks: ''
//         //  StockOutward[index].updateduserid,//
//         ));
//     int? docentry2 = await DBOperation.insertStockOutheader(db, StOutHeader);
//     // await DBOperation.deleteSuspendBatchStOut(
//     //     db, int.parse(StockOutward[index].baceDocentry.toString()));
//     // for (int i = 0; i < StockOutward[index].data.length; i++) {
//     //   StOutLine.add(StockOutLineDataDB(
//     //     lineno: (i + 1).toString(),
//     //     docentry: docentry2.toString(),
//     //     itemcode: StockOutward[index].data[i].itemcode.toString(),
//     //     description: StockOutward[index].data[i].dscription,
//     //     qty: int.parse(StockOutward[index].data[i].qty.toString()),
//     //     baseDocentry: StockOutward[index].data[i].docentry.toString(),
//     //     baseDocline: StockOutward[index].data[i].lineNo.toString(),
//     //     status: StockOutward[index].data[i].status,
//     //     traansferQty: StockOutward[index].data[i].trans_Qty,
//     //     scannedQty: StockOutward[index].data[i].Scanned_Qty,
//     //     serialBatch: StockOutward[index].data[i].serialBatch,
//     //   ));

//     // StOutBatch.add(StockOutBatchDataDB(
//     //   lineno: StockOutward[index].data[i].lineNo.toString(),
//     //   docentry: docentry2.toString(),
//     //   itemcode: StockOutward[index].data[i].itemcode,
//     //   qty: StockOutward[index].data[i].Scanned_Qty,
//     //   serialbatch: StockOutward[index].data[i].serialBatch,
//     //   // scannedQty: StockOutward[index].data[i].Scanned_Qty
//     // ));
//     // }
//     for (int i = 0; i < StockOutward[index].data.length; i++) {
//       StockOutward[index].data[i].Scanned_Qty = 0;
//       // StockOutward[index].data[i].serialbatchList!=null;
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
//               child: Text("Close"),
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
//     for (int i = 0; i < StockOutward[index!].data.length; i++) {
//       totalqty = totalqty! + StockOutward[index].data[i].qty!;
//     }
//     return totalqty;
//   }

//   int? totalValdationqty(int? index) {
//     int? totalqty = 0;
//     for (int i = 0; i < StockOutward[index!].data.length; i++) {
//       totalqty = totalqty! + StockOutward[index].data[i].Scanned_Qty!;
//     }
//     return totalqty;
//   }

//   int? totalscannedqty(int? index) {
//     int? totalscanqty = 0;
//     for (int i = 0; i < StockOutward[index!].data.length; i++) {
//       totalscanqty = totalscanqty! + StockOutward[index].data[i].Scanned_Qty!;
//     }
//     return totalscanqty;
//   }

//   String a = "";
//   Future getHoldValues(Database db) async {
//     List<Map<String, Object?>> getDBStOutHead =
//         await DBOperation.getHoldStOutHeadDB(db);
//     // List<StockOutHeaderDataDB> StOut_Head = [];
//     List<StockOutwardDetails> Stout_Line = [];
//     List<StockOutSerialbatch> Stout_Batch = [];
//     for (int i = 0; i < getDBStOutHead.length; i++) {
//       log("get head doc:" + getDBStOutHead[i]["docentry"].toString());

//       List<Map<String, Object?>> getDBStOutLine =
//           await DBOperation.holdStOutLineDB(
//               db, int.parse(getDBStOutHead[i]["baseDocentry"].toString()));
//       for (int j = 0; j < getDBStOutLine.length; j++) {
// // -----------------------
//         List<Map<String, Object?>> getDBStOutBatch =
//             await DBOperation.holdStOutBatchDB(
//                 db, int.parse(getDBStOutHead[i]["baseDocentry"].toString()));
//         // if (getDBStOutHead[i]["docstatus"].toString() == '1') {
//         log("1---");
//         // if (int.parse(getDBStOutLine[j]["scannedQty"].toString()) != 0) {
//         for (int k = 0; k < getDBStOutBatch.length; k++) {
//           log("2---");

//           Stout_Batch.add(
//             StockOutSerialbatch(
//               lineno: getDBStOutBatch[k]["lineno"].toString(),
//               docentry: getDBStOutBatch[k]["docentry"].toString(),
//               itemcode: getDBStOutBatch[k]["itemcode"].toString(),
//               qty: int.parse(getDBStOutBatch[k]["quantity"].toString()),
//               serialbatch: getDBStOutBatch[k]["serialBatch"].toString(),
//               // scannedQty:
//               //     int.parse(getDBStOutBatch[k]["scannedQty"].toString()),
//             ),
//           );
//         }
//         // } else {
//         //   log("3---");

//         //   Stout_Batch = [];
//         // }
//         // }

// //---------------------------
//         log("DDRAFT1111::" + Stout_Batch.length.toString());
//         // log("DDRAFT2::" + Stout_Line.length.toString());

//         Stout_Line.add(StockOutwardDetails(
//             lineNo: int.parse(getDBStOutLine[j]["lineno"].toString()),
//             docentry: int.parse(getDBStOutLine[j]["docentry"].toString()),
//             baseDocentry:
//                 int.parse(getDBStOutLine[j]["baseDocentry"].toString()),
//             itemcode: getDBStOutLine[j]["itemcode"].toString(),
//             dscription: getDBStOutLine[j]["description"].toString(),
//             qty: int.parse(getDBStOutLine[j]["quantity"].toString()),
//             status: getDBStOutLine[j]["status"].toString(),
//             serialBatch: getDBStOutLine[j]["serialBatch"].toString(),
//             createdUserID: 0,
//             taxRate: 0.0,
//             taxType: "",
//             baseDocline: int.parse(getDBStOutLine[j]["baseDocline"].toString()),
//             trans_Qty: int.parse(getDBStOutLine[j]["transferQty"].toString()),
//             Scanned_Qty: int.parse(getDBStOutLine[j]["scannedQty"].toString()),
//             createdateTime: "",
//             updatedDatetime: "",
//             updateduserid: 0,
//             price: 0,
//             lastupdateIp: "",
//             serialbatchList: Stout_Batch));
//       }

//       savedraftBill.add(StockOutwardList(
//         docentry: getDBStOutHead[i]["docentry"].toString(),
//         baceDocentry: getDBStOutHead[i]["baseDocentry"].toString(),
//         branch: getDBStOutHead[i]["branch"].toString(),
//         // createdUserID: int.parse(getDBStOutHead[i]["createdUserID"].toString()),
//         // createdateTime: getDBStOutHead[i]["createdateTime"].toString(),
//         docstatus: getDBStOutHead[i]["docstatus"].toString(),
//         // lastupdateIp: getDBStOutHead[i]["lastupdateIp"].toString(),
//         // reqdocno: int.parse(getDBStOutHead[i]["reqdocno"].toString()),
//         // reqdocseries: getDBStOutHead[i]["docseries"].toString(),
//         // reqdocseriesno: int.parse(getDBStOutHead[i]["docseriesno"].toString()),
//         // reqdoctime: getDBStOutHead[i]["doctime"].toString(),
//         reqfromWhs: getDBStOutHead[i]["reqfromWhs"].toString(),
//         // reqsystime: getDBStOutHead[i]["systime"].toString(),
//         reqtoWhs: getDBStOutHead[i]["reqtoWhs"].toString(),
//         reqtransdate: getDBStOutHead[i]["transdate"].toString(),
//         // salesexec: getDBStOutHead[i]["salesexec"].toString(),
//         // totalitems: int.parse(getDBStOutHead[i]["totalitems"].toString()),
//         // totalltr: double.parse(getDBStOutHead[i]["totalltr"].toString()),
//         // totalqty: double.parse(getDBStOutHead[i]["totalqty"].toString()),
//         // updatedDatetime: getDBStOutHead[i]["UpdatedDatetime"].toString(),
//         // updateduserid: int.parse(
//         //   getDBStOutHead[i]["updateduserid"].toString(),
//         // ),
//         // seresid: 0,
//         // seriesnum: 0,
//         // sysdatetime: "",
//         // scanToatal: 0,
//         // totalweight: 0,
//         // transactiondate: "",
//         // transtime: "",
//         // transTotal: 0,
//         // isagainstorder: "",
//         // isagainststock: "",
//         documentno: "0",
//         data: Stout_Line,
//       ));

//       //savedraftBill[i].data.add(StockOutwardList(branch: StOut_Head.branch, createdUserID: StOut_Head.createdUserID, createdateTime: StOut_Head.createdateTime, docentry: StOut_Head.docentry, docstatus:StOut_Head. docstatus, documentno: StOut_Head.reqdocno, isagainstorder: StOut_Head.isagainstorder, isagainststock: isagainststock, lastupdateIp: StOut_Head.lastupdateIp, reqdocno: StOut_Head.reqdocno, reqdocseries: StOut_Head.reqdocseries, reqdocseriesno: StOut_Head.reqdocseriesno, reqdoctime: StOut_Head.reqdoctime, reqfromWhs: StOut_Head.reqfromWhs, reqsystime: StOut_Head.reqsystime, reqtoWhs: StOut_Head.reqtoWhs, reqtransdate: StOut_Head.reqtransdate, salesexec: StOut_Head.salesexec, seresid: StOut_Head.seresid, seriesnum: StOut_Head.seriesnum, sysdatetime: StOut_Head.sysdatetime, totalitems: StOut_Head.totalitems, totalltr: StOut_Head.totalltr, totalqty: StOut_Head.totalqty, totalweight: StOut_Head.totalweight, transactiondate: transactiondate, transtime: transtime, updatedDatetime: updatedDatetime, updateduserid: updateduserid, data: data))
//     }
//     log("Stout_Batch::" + Stout_Batch.length.toString());
//     // log("Stout_Batch.qty::" + Stout_Batch[0].qty!.toString());
//     log("Stout_Line::" + Stout_Line.length.toString());
//     log("savedraftBill::" + savedraftBill.length.toString());

//     // log("DDRAFT::" + savedraftBill.length.toString());
//   }

//   valPass(int scanQty) {
//     msg = "";
//     // ScannigVal = scanQty;
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

//   StockOutwardDetails? batch_datalist;
//   passindexBachPage(
//     int? index,
//     int? i,
//     StockOutwardDetails? datalist,
//   ) {
//     // listI = 0;
//     // print("datalist datalist::" + datalist!.serialbatchList!.length.toString());
//     listI = index!;
//     batch_i = i;
//     // selectedBaceDocentry = baceDocentry;
//     batch_datalist = datalist;
//     notifyListeners();
//   }

//   Future<bool> onbackpress() async {
//     DateTime now = DateTime.now();
//     if (pageIndex == 1) {
//       print("object");

//       page.animateToPage(--pageIndex,
//           duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
//     } else if (pageIndex == 2) {
//       log("object");
//       // stoutLineRefersh(listI!, batch_i!);
//       // getBatchData(int index, int list_i);
//       // await stoutLineRefersh(listI!);
//       notifyListeners();
//       page.animateToPage(--pageIndex,
//           duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
//     }
//     return Future.value(false);
//   }

//   Future<bool> onbackpress2() async {
//       print("stockoutwardddddd $tappageIndex ");
//     DateTime now = DateTime.now();
//     if (tappageIndex == 1) {
//       print("object");

//       tappage.animateToPage(--tappageIndex,
//           duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
//     } else if (tappageIndex == 2) {
//       log("object");
//       tappage.animateToPage(--tappageIndex,
//           duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
//     }else  if (tappageIndex == 0) {
//       return Future.value(true);
//     }
//     return Future.value(false);

//   }

//   List<StockOutwardDetails>? passdata = [];
//   passList(List<StockOutwardDetails>? data) {
//     passdata = data!;
//     // getBatchData(index, list_i);
//     // for (int i = 0; i < data.length; i++) {
//     //   for (int j = 0; j < data[i].serialbatchList!.length; j++) {
//     //     data[i].Scanned_Qty = data[i].serialbatchList![j].qty;
//     //   }
//     // }
//     notifyListeners();
//   }

//   List<StockOutwardList> StockOutward = [];
//   callList() {}

//   clearmsg() {
//     msg = "";
//     // ScannigVal = 0;
//     notifyListeners();
//   }

//   DateTime? currentBackPressTime;
//   Future<bool> onWillPop() {
//     page.previousPage(
//       duration: Duration(milliseconds: 200),
//       curve: Curves.linear,
//     );
//     return Future.value(false);
//   }

//   mapvalue(List<StockOutwardList> StockOut, int index) async {
//     List<StockOutwardDetails> stoutDetails = [];
//     List<StockOutwardList> stoutList = [];
//     final Database db = (await DBHelper.getInstance())!;

// // List<StockOutwardList> stoutList=[];
//     for (int j = 0; j < StockOut[index].data.length; j++) {
//       log("stbatch length:" +
//           StockOut[index].data[j].serialbatchList!.length.toString());
//       log("data length:" + StockOut[index].data.length.toString());
//       log("bbbbbbbbbbbbbbbbbbbbbbbbbbb::" +
//           StockOut[index].data[j].Scanned_Qty.toString());
//       List<StockOutSerialbatch> stoutSeralBatchList = [];
//       log("aaaaaaaaaaaaaaaaaaaaaaa::" +
//           StockOut[index].data[j].Scanned_Qty.toString());
//       for (int k = 0;
//           k < StockOut[index].data[j].serialbatchList!.length;
//           k++) {
//         log("ccccccccccccccccc::" +
//             StockOut[index].data[j].Scanned_Qty.toString());

//         // if (StockOut[index].data[j].Scanned_Qty != 0) {
//         stoutSeralBatchList.add(StockOutSerialbatch(
//             lineno: StockOut[index].data[j].lineNo.toString(),
//             docentry: StockOut[index].data[j].docentry.toString(),
//             itemcode: StockOut[index].data[j].itemcode.toString(),
//             qty: StockOut[index].data[j].qty,
//             // scannedQty: StockOut[index].data[j].Scanned_Qty,
//             serialbatch: StockOut[index]
//                 .data[j]
//                 .serialbatchList![k]
//                 .serialbatch
//                 .toString()));
//         // }
//       }

//       log("data   docentry:" + StockOut[index].data[j].docentry.toString());
//       log("data   itemcode:" + StockOut[index].data[j].itemcode.toString());
//       log("data   qty:" + StockOut[index].data[j].qty.toString());
//       log("data   tra qty:" + StockOut[index].data[j].trans_Qty.toString());
//       log("data   scannqty:" + StockOut[index].data[j].Scanned_Qty.toString());

//       stoutDetails.add(StockOutwardDetails(
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
//           serialbatchList: stoutSeralBatchList));
//     }
//     stoutList.add(StockOutwardList(
//         branch: StockOut[index].branch,
//         // createdUserID: StockOut[index].createdUserID,
//         // createdateTime: StockOut[index].createdateTime,
//         docentry: StockOut[index].docentry,
//         baceDocentry: StockOut[index].baceDocentry,
//         docstatus: StockOut[index].docstatus,
//         documentno: StockOut[index].documentno,
//         // isagainstorder: StockOut[index].isagainstorder,
//         // isagainststock: StockOut[index].isagainststock,
//         // lastupdateIp: StockOut[index].lastupdateIp,
//         // reqdocno: StockOut[index].reqdocno,
//         // reqdocseries: StockOut[index].reqdocseries,
//         // reqdocseriesno: StockOut[index].reqdocseriesno,
//         // reqdoctime: StockOut[index].reqdoctime,
//         reqfromWhs: StockOut[index].reqfromWhs,
//         // reqsystime: StockOut[index].reqsystime,
//         reqtoWhs: StockOut[index].reqtoWhs,
//         reqtransdate: StockOut[index].reqtransdate,
//         // salesexec: StockOut[index].salesexec,
//         // seresid: StockOut[index].seresid,
//         // seriesnum: StockOut[index].seriesnum,
//         // sysdatetime: StockOut[index].sysdatetime,
//         // totalitems: StockOut[index].totalitems,
//         // totalltr: StockOut[index].totalltr,
//         // totalqty: StockOut[index].totalqty,
//         // totalweight: StockOut[index].totalweight,
//         // transactiondate: StockOut[index].transactiondate,
//         // transtime: StockOut[index].transtime,
//         // updatedDatetime: StockOut[index].updatedDatetime,
//         // updateduserid: StockOut[index].updateduserid,
//         data: stoutDetails));

//     StockOutward.addAll(stoutList);
//     // await DBOperation.deleteHoldStOut(
//     //     db, StockOut[index].baceDocentry.toString());
//     print("befoe" + StockOut.length.toString());
//     StockOut.removeAt(index);
//     print("after" + StockOut.length.toString());
//     getHoldValues(db);
//     notifyListeners();
//   }

//   // savedraft(List<StockInwardList> datatotal, int i) {
//   //   savedraftBill.add(StockInwardList(
//   //       req_date: datatotal[i].req_date,
//   //       Branch_No: datatotal[i].Branch_No,
//   //       scanToatal: datatotal[i].scanToatal,
//   //       transTotal: datatotal[i].transTotal,
//   //       data: datatotal[i].data));
//   //

//   // List<StockInwardList> StockInDATA = [];
//   List<StockOutwardList> savedraftBill = [];
//   List<StockOutwardList> SaveBill = [];

//   //
//   //

//   getStockReqData() async {
//     StockOutward.clear();
//     final Database db = (await DBHelper.getInstance())!;
//     List<Map<String, Object?>> getStockReqValues =
//         await DBOperation.getStockReq(db);
//     List<StockOutwardList> StockOutDATA = [];

//     if (getStockReqValues.isNotEmpty) {
//       // log( "stock len::"+getStockReqValues.length.toString());
//       for (int i = 0; i < getStockReqValues.length; i++) {
//         log("reqto" + getStockReqValues[i]["reqtoWhs"].toString());
//         log("reqFromto" + getStockReqValues[i]["reqfromWhs"].toString());

//         // if (getStockReqValues[i]["reqtoWhs"].toString() == UserValues.branch &&
//         //     getStockReqValues[i]["reqfromWhs"].toString() !=
//         //         UserValues.branch) {
//         log("reqt--------To::" + getStockReqValues[i]["reqtoWhs"].toString());
//         log("reqFrom--------::" +
//             getStockReqValues[i]["reqfromWhs"].toString());

//         dbDataTrue = false;

//         List<Map<String, Object?>> getStockReqLineData =
//             await DBOperation.getTrasferQty(
//                 db, int.parse(getStockReqValues[i]["docentry"].toString()));
//         print("stock docE::" + getStockReqValues.toString());
//         List<StockOutwardDetails> stockDetails = [];
//         for (int j = 0; j < getStockReqLineData.length; j++) {
//           print("loop 1");
//           stockDetails.add(StockOutwardDetails(
//               baseDocentry:
//                   int.parse(getStockReqLineData[j]["docentry"].toString()),
//               baseDocline:
//                   int.parse(getStockReqLineData[j]["lineNo"].toString()),
//               createdUserID:
//                   int.parse(getStockReqLineData[j]["createdUserID"].toString()),
//               createdateTime:
//                   getStockReqLineData[j]["createdateTime"].toString(),
//               docentry:
//                   int.parse(getStockReqLineData[j]["docentry"].toString()),
//               dscription: "",
//               itemcode: getStockReqLineData[j]["itemcode"].toString(),
//               lastupdateIp: getStockReqLineData[j]["lastupdateIp"].toString(),
//               lineNo: int.parse(getStockReqLineData[j]["lineNo"].toString()),
//               qty: int.parse(getStockReqLineData[j]["quantity"].toString()),
//               status: "",
//               updatedDatetime:
//                   getStockReqLineData[j]["UpdatedDatetime"].toString(),
//               updateduserid:
//                   int.parse(getStockReqLineData[j]["createdUserID"].toString()),
//               price: double.parse(getStockReqLineData[j]["price"].toString()),
//               serialBatch: getStockReqLineData[j]["serialBatch"].toString(),
//               taxRate: 0.0,
//               Scanned_Qty:
//                   int.parse(getStockReqLineData[j]["scanndQty"].toString()),
//               trans_Qty: int.parse(getStockReqLineData[j]["balqty"].toString()),
//               taxType: ""));
//           log("stock Details data::" + stockDetails.length.toString());
//         }
//         print("line length ::" + stockDetails.length.toString());
//         StockOutDATA.add(StockOutwardList(
//             branch: getStockReqValues[i]["branch"].toString(),
//             // createdUserID:getStockReqValues[i]["createdUserID"].toString().isEmpty?0:
//             // int.parse(getStockReqValues[i]["createdUserID"].toString()),
//             // createdateTime: getStockReqValues[i]["createdateTime"].toString(),

//             docentry: getStockReqValues[i]["docentry"].toString(),
//             baceDocentry: getStockReqValues[i]["docentry"].toString(),
//             docstatus: getStockReqValues[i]["docstatus"].toString(),
//             documentno: getStockReqValues[i]["documentno"].toString(),
//             // isagainstorder: getStockReqValues[i]["isagainstorder"].toString(),
//             // isagainststock: getStockReqValues[i]["isagainststock"].toString(),
//             // lastupdateIp: getStockReqValues[i]["lastupdateIp"].toString(),
//             // reqdocno: int.parse(getStockReqValues[i]["reqdocno"].toString()),
//             // reqdocseries: getStockReqValues[i]["reqdocseries"].toString(),
//             // reqdocseriesno:
//             //     int.parse(getStockReqValues[i]["reqdocseriesno"].toString()),
//             // reqdoctime: getStockReqValues[i]["reqdoctime"].toString(),
//             reqfromWhs: getStockReqValues[i]["reqfromWhs"].toString(),
//             // reqsystime: getStockReqValues[i]["reqsystime"].toString(),
//             reqtoWhs: getStockReqValues[i]["reqtoWhs"].toString(),
//             reqtransdate: getStockReqValues[i]["reqtransdate"].toString(),
//             // salesexec: getStockReqValues[i]["salesexec"].toString(),
//             // seresid: int.parse(getStockReqValues[i]["seresid"].toString()),
//             // seriesnum: int.parse(getStockReqValues[i]["seriesnum"].toString()),
//             // sysdatetime: getStockReqValues[i]["sysdatetime"].toString(),
//             // totalitems: int.parse(getStockReqValues[i]["totalitems"].toString()),
//             // totalltr: double.parse(getStockReqValues[i]["totalltr"].toString()),
//             // totalqty: double.parse(getStockReqValues[i]["totalqty"].toString()),
//             // totalweight:
//             //     double.parse(getStockReqValues[i]["totalweight"].toString()),
//             // transactiondate: getStockReqValues[i]["transactiondate"].toString(),
//             // transtime: getStockReqValues[i]["transtime"].toString(),
//             // updatedDatetime: getStockReqValues[i]["UpdatedDatetime"].toString(),
//             // updateduserid:
//             //     int.parse(getStockReqValues[i]["updateduserid"].toString()),
//             data: stockDetails));
//         // log("stock out data::" + StockOutDATA[i].data.length.toString());
//         // stockDetails//;
//         StockOutward.addAll(StockOutDATA);
//         // } else {
//         //   dbDataTrue = true;
//         //   notifyListeners();
//         // }
//       }

//       print("object::" + StockOutward.length.toString());
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
//     List<Map<String, Object?>> getDB_StoutHeader =
//         await DBOperation.getStockOutHeader(db, docentry);
//     List<Map<String, Object?>> getDB_StoutLine =
//         await DBOperation.holdStOutLineDB(db, baseDocentry);
//     // List<Map<String, Object?>> getDB_StOutBatch =
//     //     await DBOperation.getStockOutBatch(db, baseDocentry);
//     String stOutHeader = json.encode(getDB_StoutHeader);
//     String stOutLine = json.encode(getDB_StoutLine);
//     // String stOutBatch = json.encode(getDB_StOutBatch);

//     var ddd = json.encode({
//       "ObjectType": 5, "ActionType": "Add",
//       "StockOutwardHeader": stOutHeader,
//       "StockOutwardLine": stOutLine,
//       // "StockOutwardBatch": "$stOutBatch",
//     });
//     log("payload : $ddd");

//     //RabitMQ
//     Client client = Client();
//     ConnectionSettings settings = ConnectionSettings(
//         host: AppConstant.ip.toString().trim(), //"102.69.167.106"
//         //AppConstant.ip
//         port: 5672,
//         authProvider: PlainAuthenticator("buson", "BusOn123"));
//     Client client1 = Client(settings: settings);

//     MessageProperties properties = MessageProperties();
// //from
//     properties.headers = {"Branch": UserValues.branch};
//     Channel channel = await client1.channel();
//     Exchange exchange =
//         await channel.exchange("POS", ExchangeType.HEADERS, durable: true);
//     exchange.publish(ddd, "", properties: properties);

//     //cs

//     properties.headers = {"Branch": "Server"};
//     exchange.publish(ddd, "", properties: properties);

//     //to
//     properties.headers = {"Branch": toWhs};
//     exchange.publish(ddd, "", properties: properties);

//     client1.close();
//   }
// }
