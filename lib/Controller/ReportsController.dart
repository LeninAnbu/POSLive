import 'dart:developer';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:posproject/Constant/AppConstant.dart';
import 'package:posproject/Constant/Configuration.dart';
import 'package:posproject/Constant/ConstantRoutes.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:intl/intl.dart';
import '../Models/NewReportsModel/GetReportFieldModel.dart';
import '../Models/NewReportsModel/NewChangeReportModel.dart';
import '../Pages/Reports/PDFHelper.dart';
import '../Service/NewReportsApi/GetReportFieldApi.dart';
import '../Service/NewReportsApi/NewReportQuery.dart';
import '../Service/NewReportsApi/NewReportQuery2.dart';
import '../Service/NewReportsApi/NweQuerCompoApi.dart';

class ReportController extends ChangeNotifier {
  init() async {
    clearAllData();
    await callReportsListNameApi();
    notifyListeners();
  }

  static List<Map<String, dynamic>> tablercolumnzz = [];

  clearAllData() {
    reportsList = [];
    noDataMsg = '';
    reportQeury = '';
    showListVal = false;
    listBoxData = [];
    valuesddd = [];
    keysList = [];
    loadingscrn = false;
    frmController = List.generate(150, (i) => TextEditingController());
  }

  GlobalKey<FormState> frmFormkey = GlobalKey<FormState>();
  GlobalKey<FormState> toFormkey = GlobalKey<FormState>();

  static List<SplitLeadData> tablerColumn = [];
  static List<String> tablerColumn55 = [];

  bool showListVal = false;
  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    final now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.offAllNamed<dynamic>(ConstantRoutes.dashboard);
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  List<TextEditingController> frmController =
      List.generate(150, (i) => TextEditingController());
  List<TextEditingController> toController =
      List.generate(150, (i) => TextEditingController());
  List<NewReportMdlData> reportsList = [];
  List<TextEditingController> listController =
      List.generate(150, (i) => TextEditingController());
  onTapReportList(int index, BuildContext context, ThemeData theme) {
    for (var i = 0; i < reportsList.length; i++) {
      reportsList[i].reportclr = false;
    }

    reportsList[index].reportclr = true;
    frmController[0].text = '';
    toController[1].text = '';
    reportQeury = reportsList[index].u_query;
    callGetReportFieldApi(reportsList[index].code, context, theme);

    notifyListeners();
  }

  callReportsListNameApi() async {
    reportsList = [];
    await NewReportApi.getGlobalData().then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        reportsList = value.openOutwardData!;
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
      } else {}
    });
    notifyListeners();
  }
//NewReportApi2

  Configure config = Configure();

  getFrmDate(BuildContext context, int indx) async {
    log('indxindx::${indx}');
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    var datetype = DateFormat('yyyy-MM-dd').format(pickedDate!);

    frmController[indx].text = datetype;

    log('frmController[indx].text::${frmController[indx].text}');
    notifyListeners();
  }

  getToDate(
    BuildContext context,
  ) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    var datetype = DateFormat('yyyy-MM-dd').format(pickedDate!);
    toController[1].text = config.alignDate(datetype);
    notifyListeners();
  }

  bool loadingscrn = false;
  String reportQeury = '';
  String compoBoxQeury = '';

  List<newvaluedynamic> valuesddd = [];
  List<String> valuesheader = [];
  Map<String, dynamic> entryList = {};
  List<dynamic> keysList = [];
  List<dynamic> values = [];

  String noDataMsg = '';

  callReportDetailsApi() {
    loadingscrn = true;
    valuesddd.clear();
    noDataMsg = '';
    NewReportApi2.getGlobalData(reportQeury).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 200) {
        log('NewReportApi2NewReportApi2::${NewReportApi2.values.length}');
        if (NewReportApi2.values.isNotEmpty) {
          valuesddd = NewReportApi2.values;
          keysList.clear();
          keysList = valuesddd[0].data.keys.toList();
          CollectionReceiptPdfHelper.keysList = keysList;
          CollectionReceiptPdfHelper.valuesddd = valuesddd;
        } else {
          log('NewReportApi2NewReportApi2222::${NewReportApi2.values.length}');
          noDataMsg = 'No data found';
          notifyListeners();
        }
        log("noDataMsg::" + noDataMsg);

        loadingscrn = false;
      } else if (value.statusCode! >= 400 && value.statusCode! <= 400) {
        valuesddd = [];
        noDataMsg = 'No data found';
        loadingscrn = false;
      } else {
        valuesddd = [];
        noDataMsg = '${value.erros}';
        loadingscrn = false;
      }
      notifyListeners();
    });
    notifyListeners();
  }

  static List<String> listBoxData = [];
  List<String> filterListBoxData = [];
  filterListOnList(String v) {
    log("salesModelsalesModel.length:${listBoxData.length}");
    if (v.isNotEmpty) {
      filterListBoxData = listBoxData
          .where((e) => e.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterListBoxData = listBoxData;

      notifyListeners();
    }
    notifyListeners();
  }

  callReportCompoApi(String compoUrl) async {
    loadingscrn = true;
    filterListBoxData = [];
    await NewReportCompoApi.getGlobalData(
      compoUrl,
    ).then((value) {
      filterListBoxData = listBoxData;
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        loadingscrn = false;
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        loadingscrn = false;
        notifyListeners();
      } else {
        loadingscrn = false;
      }
    });
    notifyListeners();
  }

  List<NewReportFieldMdlData> reportFieldList = [];
  int? selectIndex;
  callGetReportFieldApi(
      String code, BuildContext context, ThemeData theme) async {
    reportFieldList = [];
    await NewFieldReportApi.getGlobalData(code).then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        reportFieldList = value.openOutwardData!;
        for (var i = 0; i < reportFieldList.length; i++) {
          if (reportFieldList[i].uParamType == 'F') {}
          if (reportFieldList[i].uDefault == 'LoginBranch') {
            frmController[i].text = AppConstant.branch;
          }
          if (reportFieldList[i].uParamQry!.isNotEmpty &&
              reportFieldList[i].uParamType == 'L') {
            log(' reportFieldList[i].uParamQry::${reportFieldList[i].uParamQry}');
            await callReportCompoApi(
              reportFieldList[i].uParamQry.toString(),
            );
            notifyListeners();
          }
        }
        loadingscrn = false;

        if (reportFieldList.isNotEmpty) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return StatefulBuilder(builder: (context, setState) {
                  return AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    content: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: theme.primaryColor,
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              height: Screens.padingHeight(context) * 0.35,
                              width: Screens.width(context) * 0.4,
                              child: ListView.builder(
                                  itemCount: reportFieldList.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          reportFieldList[index].uParamType ==
                                                  'D'
                                              ? Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: Screens.width(
                                                              context) *
                                                          0.1,
                                                      child: Text(
                                                          '${reportFieldList[index].uParamDesc}'),
                                                    ),
                                                    Container(
                                                      width: Screens.width(
                                                              context) *
                                                          0.25,
                                                      child: TextFormField(
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return '*Choose the from date';
                                                          }
                                                          return null;
                                                        },
                                                        onTap: () {
                                                          setState(
                                                            () {
                                                              getFrmDate(
                                                                  context,
                                                                  index);
                                                            },
                                                          );
                                                        },
                                                        readOnly: true,
                                                        controller:
                                                            frmController[
                                                                index],
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon:
                                                              const Icon(Icons
                                                                  .calendar_today),
                                                          filled: false,
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .red),
                                                          ),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .red),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical: 0,
                                                            horizontal: 5,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : Container(),
                                          reportFieldList[index].uDefault ==
                                                  'LoginBranch'
                                              ? Row(
                                                  children: [
                                                    Container(
                                                      width: Screens.width(
                                                              context) *
                                                          0.1,
                                                      child: Text(
                                                          '${reportFieldList[index].uParamDesc}'),
                                                    ),
                                                    Container(
                                                      width: Screens.width(
                                                              context) *
                                                          0.25,
                                                      child: TextFormField(
                                                        readOnly: true,
                                                        controller:
                                                            frmController[
                                                                index],
                                                        decoration:
                                                            InputDecoration(
                                                          filled: false,
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical: 0,
                                                            horizontal: 5,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : Container(),
                                          reportFieldList[index].uParamQry !=
                                                      null &&
                                                  reportFieldList[index]
                                                          .uParamType ==
                                                      'L'
                                              ? Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      width: Screens.width(
                                                              context) *
                                                          0.1,
                                                      child: Text(
                                                          '${reportFieldList[index].uParamDesc}'),
                                                    ),
                                                    Container(
                                                      height:
                                                          Screens.padingHeight(
                                                                  context) *
                                                              0.07,
                                                      alignment:
                                                          Alignment.center,
                                                      width: Screens.width(
                                                              context) *
                                                          0.25,
                                                      child: TextFormField(
                                                        controller:
                                                            frmController[
                                                                index],
                                                        onChanged: (val) {
                                                          setState(
                                                            () {
                                                              filterListOnList(
                                                                  val);
                                                            },
                                                          );
                                                        },
                                                        onTap: () {
                                                          setState(
                                                            () {
                                                              selectIndex =
                                                                  index;

                                                              showListVal =
                                                                  !showListVal;
                                                              ;
                                                            },
                                                          );
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  borderSide:
                                                                      const BorderSide(
                                                                          color:
                                                                              Colors.grey),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  borderSide:
                                                                      const BorderSide(
                                                                          color:
                                                                              Colors.grey),
                                                                ),
                                                                contentPadding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  vertical: 0,
                                                                  horizontal: 5,
                                                                ),
                                                                suffixIcon:
                                                                    Icon(Icons
                                                                        .arrow_drop_down)),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Container(),
                                          Visibility(
                                              visible: showListVal,
                                              child: SingleChildScrollView(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      left: Screens.width(
                                                              context) *
                                                          0.09,
                                                      right: Screens.width(
                                                              context) *
                                                          0.07),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  height: Screens.padingHeight(
                                                          context) *
                                                      0.9,
                                                  width:
                                                      Screens.width(context) *
                                                          0.4,
                                                  child: ListView.builder(
                                                      itemCount:
                                                          filterListBoxData
                                                              .length,
                                                      itemBuilder:
                                                          (context, i) {
                                                        return Card(
                                                          child: InkWell(
                                                            onTap: () {
                                                              setState(
                                                                () {
                                                                  frmController[
                                                                          selectIndex!]
                                                                      .text = filterListBoxData[
                                                                          i]
                                                                      .toString();
                                                                  showListVal =
                                                                      false;
                                                                },
                                                              );
                                                            },
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              child: Text(
                                                                  '${filterListBoxData[i].toString()}'),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                ),
                                              )),
                                          SizedBox(
                                            height:
                                                Screens.padingHeight(context) *
                                                    0.01,
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                            Container(
                                width: Screens.width(context) * 0.4,
                                child: ElevatedButton(
                                    onPressed: () {
                                      setState(
                                        () {
                                          showreportdetailsapi();
                                        },
                                      );
                                      notifyListeners();
                                    },
                                    child: Text('OK')))
                          ],
                        ),
                      ),
                    ),
                  );
                });
              });
        }
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
      } else {}
    });
    notifyListeners();
  }

  showreportdetailsapi() async {
    for (int i = 0; i < reportFieldList.length; i++) {
      if (i == 0) {
        reportQeury = reportQeury + " '" + frmController[i].text + "'";
      } else {
        reportQeury = reportQeury + ",'" + frmController[i].text + "'";
      }
    }

    if (frmController[0].text.isNotEmpty || toController[1].text.isNotEmpty) {
      await callReportDetailsApi();
      Get.back();
      notifyListeners();
    } else {
      Get.defaultDialog(
          title: 'Alert',
          middleText: 'Kindly fill the required field',
          actions: [
            TextButton(
                child: const Text("Close"),
                onPressed: () {
                  Get.back();
                })
          ]);
    }
    notifyListeners();
  }

  Future<void> requestStoragePermissionxx(BuildContext context, ThemeData theme,
      List<newvaluedynamic> valuesddd1, List<dynamic> keysList1) async {
    if (await Permission.storage.isGranted) {
      saveAllExcel(context, theme, valuesddd1, keysList1);
      log('Storage permission is already granted.');
    } else {
      var status = await Permission.storage.request();

      if (status.isGranted) {
        log('Storage permission granted.');
      } else if (status.isDenied) {
        log('Storage permission denied.');
        openAppSettings();
      } else if (status.isPermanentlyDenied) {
        log('Storage permission permanently denied. Open app settings.');
        openAppSettings();
      }
    }
    notifyListeners();
  }

  static String? path = '';
  Future<void> requestStoragePermission(BuildContext context, ThemeData theme,
      List<newvaluedynamic> valuesddd1, List<dynamic> keysList1) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      saveAllExcel(context, theme, valuesddd1, keysList1);
    } else {
      await Permission.storage.request();
      log("Storage permission denied.");
    }
    notifyListeners();
  }

  saveToExcel(List<newvaluedynamic> valuesddd1, List<dynamic> keysList1) async {
    path = '';
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    sheetObject.appendRow(keysList1.map((key) => TextCellValue(key)).toList());

    for (var dataMap in valuesddd1) {
      List<CellValue?> row = keysList1.map<CellValue?>((key) {
        var value = dataMap.getFieldValue(key);
        if (value is String) {
          return TextCellValue(value);
        } else if (value is int) {
          return IntCellValue(value);
        } else if (value is double) {
          return DoubleCellValue(value);
        }
        return null;
      }).toList();
      sheetObject.appendRow(row);
    }

    String timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());

    final directory = await Directory('/storage/emulated/0/Download');
    String filePath = '${directory.path}/posreports_$timestamp.xlsx';
    File file = File(filePath);

    if (await file.exists()) {
      log('Exist filePath::${filePath.toString()}');

      file.deleteSync();
      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(excel.save()!);
      path = filePath;
      log("Directory created: $filePath");
    } else {
      log('No Exist filePath11::${filePath.toString()}');

      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(excel.save()!);
      path = filePath;
      log('No Exist filePath::${filePath.toString()}');
    }

    log('Excel file saved at $filePath');
  }

  saveAllExcel(BuildContext context, ThemeData theme,
      List<newvaluedynamic> valuesddd1, List<dynamic> keysList1) async {
    await saveToExcel(valuesddd1, keysList1);
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: Screens.width(context) * 0.3,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text("Successfull Saved..",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: Colors.green,
                          )),
                      Text(
                        "Path Name:$path",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.05,
                        width: Screens.width(context) * 0.3,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5),
                            minimumSize: const Size(0, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            'Close',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
