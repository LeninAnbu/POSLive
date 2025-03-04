import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:posproject/Constant/Configuration.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Models/ExpenseDialogModel/Expensedialog.dart';
import 'package:posproject/Models/ExpenseModel/paidfrom.dart';
import 'package:posproject/Service/ExpenseApi.dart';
import 'package:posproject/Service/PettyCashApi.dart';
import 'package:posproject/Service/SearchQuery/SearchExpneseHeaderApi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/UserValues.dart';
import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';
import '../../DBModel/ExpenseDBModel.dart';
import '../../Models/DataModel/SeriesMode/SeriesModels.dart';
import '../../Models/ExpenseModel/ExpenseGetModel.dart';
import '../../Models/ExpenseModel/SearchExpHeaderModel.dart';
import '../../Models/ExpenseModel/expensecode.dart';
import '../../Models/SearBox/SearchModel.dart';
import '../../Models/Service Model/PettyCashModel.dart';
import '../../Models/ServiceLayerModel/SapExpensModel/ExpePostingList.dart';
import '../../Models/ServiceLayerModel/SapSalesOrderModel/approvals_order_modal/approvals_details.modal.dart';
import '../../Models/ServiceLayerModel/SapSalesOrderModel/approvals_order_modal/approvals_modal.dart';
import '../../Models/ServiceLayerModel/SapSalesOrderModel/approvals_order_modal/approvals_order_modal.dart';
import '../../Service/SeriesApi.dart';
import '../../ServiceLayerAPIss/ExpensesAPI/ExpApprovalApi/ApprovalToDocApi.dart';
import '../../ServiceLayerAPIss/ExpensesAPI/ExpApprovalApi/ExpApprovalQryApi.dart';
import '../../ServiceLayerAPIss/ExpensesAPI/ExpApprovalApi/ExpPendingApprovalsApi.dart';
import '../../ServiceLayerAPIss/ExpensesAPI/ExpApprovalApi/ExpRejectedApi.dart';
import '../../ServiceLayerAPIss/ExpensesAPI/ExpApprovalApi/afterpostDraftdocApi.dart';
import '../../ServiceLayerAPIss/ExpensesAPI/ExpApprovalPostingApi.dart';
import '../../ServiceLayerAPIss/ExpensesAPI/GetExpDetailApi.dart';
import '../../ServiceLayerAPIss/ExpensesAPI/PostingExpAPI.dart';
import '../../ServiceLayerAPIss/OrderAPI/ApprovalAPIs/approvals_details_api.dart';
import '../../Widgets/AlertBox.dart';
import '../../ServiceLayerAPIss/ExpensesAPI/ExpenseCancelAPI.dart';
import '../../ServiceLayerAPIss/ExpensesAPI/ExpenseLoginnAPI.dart';
import '../../Widgets/ContentContainer.dart';

class ExpenseController extends ChangeNotifier {
  Configure config = Configure();

  void init() {
    clearData();
    getcodeExpense();
    getpaidfomExpense();
    getdraftindex();
    callPettyCashApi();
    notifyListeners();
    expenseModel = [];
  }

  List<SearchEpenseDataModel> filtersearchData = [];
  bool onDisablebutton = false;
  bool cancelbtn = false;
  bool isApprove = false;
  bool clickAprList = false;
  String? codeValue;
  String? displayExpanseValue;
  String? custserieserrormsg = '';
  bool loadingscrn = false;
  GlobalKey<FormState> approvalformkey = GlobalKey<FormState>();
  String? chosenValue;
  final List<GlobalKey<FormState>> formkey =
      List.generate(2, (i) => GlobalKey<FormState>());
  List<TextEditingController> mycontroller =
      List.generate(150, (i) => TextEditingController());
  List<codeforexpense> expCode = [];
  List finalcode = [];
  String holddocentry = '';
  List<PaidFrom> paidFromData = [];
  List<EpenseDataModel> expenseModel = [];
  String? sapDocentry = '';
  String? sapDocuNumber = '';
  String? localDocEntry = '';

  String? draftDocuNumber = '';
  String? uDeviceTransId = '';

  Future<SharedPreferences> pref = SharedPreferences.getInstance();
  callExpenseApi() async {
    ExpanseMasterApi.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.addressdata != null) {
          expenseModel = value.addressdata!;
          notifyListeners();
        } else {
          Get.defaultDialog(title: 'Alert', middleText: 'No Expense Data..!!')
              .then((value) {
            Get.back();
          });
        }
      } else {
        Get.defaultDialog(
                title: 'Alert',
                middleText: 'Something went wrong try again..!!')
            .then((value) {
          Get.back();
        });
      }
    });
  }

  List<PettyCashData>? pettyCashListt = [];
  String? pettyCashAmt;
  callPettyCashApi() async {
    expenseModel = [];
    PettyCashModelAPI.getData(AppConstant.branch).then((value) {
      if (value.statuscode >= 200 && value.statuscode <= 210) {
        if (value.pettyCashList != null) {
          pettyCashListt = value.pettyCashList;
          for (var i = 0; i < pettyCashListt!.length; i++) {
            expenseModel.add(EpenseDataModel(
                currentTotal: pettyCashListt![i].currTotal ?? 0,
                code: pettyCashListt![i].code.toString(),
                name: pettyCashListt![i].name));
          }
          notifyListeners();
        } else {
          Get.defaultDialog(title: 'Alert', middleText: 'No Data..!!')
              .then((value) {
            Get.back();
          });
        }
      } else {
        Get.defaultDialog(
                title: 'Alert',
                middleText: 'Something went wrong try again..!!')
            .then((value) {
          Get.back();
        });
      }
    });
  }

  disableKeyBoard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    notifyListeners();
  }

  FilePickerResult? result;
  File? attachFiles;

  void selectattachment() async {
    mycontroller[16].text = '';
    log('xxxxxxx');
    result = await FilePicker.platform.pickFiles();

    if (result != null) {
      List<File> filesz = result!.paths.map((path) => File(path!)).toList();

      for (int i = 0; i < filesz.length; i++) {
        attachFiles = filesz[i];

        mycontroller[16].text = attachFiles!.path.split('/').last.toString();
        notifyListeners();
      }
    }
    log('xxxxxxx222222:::$attachFiles');
  }

  pettyCashValidation(BuildContext context, ThemeData theme) {
    depitAcc = '';
    creditAcc = '';
    double expval = double.parse(mycontroller[1].text.toString());
    log("pettyCashAmtpettyCashAmt:::$pettyCashAmt");
    for (var i = 0; i < pettyCashListt!.length; i++) {
      if (pettyCashListt![i].name == displayExpanseValue) {
        log('kkkkkkkkkkk');
        if (expval <= double.parse(pettyCashListt![i].currTotal.toString())) {
          depitAcc = pettyCashListt![i].debitAcc.toString();
          creditAcc = pettyCashListt![i].creditAcc.toString();
          mycontroller[1].text = expval.toString();
          notifyListeners();
          saveValuesTODB("save", context, theme);
        } else {
          Get.defaultDialog(
                  title: 'Alert',
                  middleText: 'Kindly enter the correct amount..!!')
              .then((value) {});
          mycontroller[1].text = '';

          onDisablebutton = false;
          notifyListeners();
        }
      }
    }
    notifyListeners();
  }

  filterSearchBoxList(String v) {
    if (v.isNotEmpty) {
      filtersearchData = expSearchHeaderdata
          .where((e) =>
              e.docEntry.toString().toLowerCase().contains(v.toLowerCase()) ||
              e.docNum.toString().toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filtersearchData = expSearchHeaderdata;
      notifyListeners();
    }
    notifyListeners();
  }

  getDate2(BuildContext context, datetype) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (datetype == "From") {
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate!);
      mycontroller[100].text = datetype!;
    } else if (datetype == "To") {
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate!);
      mycontroller[101].text = datetype!;
    } else {}
  }

  getPostingDate(
    BuildContext context,
  ) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now());

    String datetype = DateFormat('dd-MM-yyyy').format(pickedDate!);
    mycontroller[17].text = datetype;
  }

  searchInitMethod() {
    mycontroller[100].text = config.alignDate(config.currentDate());
    mycontroller[101].text = config.alignDate(config.currentDate());
    notifyListeners();
  }

  bool searchbool = false;
  List<searchModel> searchData = [];

  getSalesDataDatewise(String fromdate, String todate) async {
    searchbool = true;
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getSalesHeader =
        await DBOperation.getExpenseDateWise(
            db, config.alignDate2(fromdate), config.alignDate2(todate));

    List<searchModel> searchdata2 = [];
    searchData.clear();
    filtersearchData.clear();
    for (int i = 0; i < getSalesHeader.length; i++) {
      searchdata2.add(searchModel(
          username: UserValues.username,
          terminal: AppConstant.terminal,
          sapDocNo: getSalesHeader[i]["sapDocNo"] == null
              ? 0
              : int.parse(getSalesHeader[i]["sapDocNo"].toString()),
          qStatus: getSalesHeader[i]["qStatus"] == null
              ? ""
              : getSalesHeader[i]["qStatus"].toString(),
          docentry: getSalesHeader[i]["docentry"] == null
              ? 0
              : int.parse(getSalesHeader[i]["docentry"].toString()),
          docNo: getSalesHeader[i]["documentno"] == null
              ? "0"
              : getSalesHeader[i]["documentno"].toString(),
          docDate: getSalesHeader[i]["createdateTime"].toString(),
          sapNo: getSalesHeader[i]["sapDocNo"] == null
              ? 0
              : int.parse(getSalesHeader[i]["sapDocNo"].toString()),
          sapDate: getSalesHeader[i]["createdateTime"] == null
              ? ""
              : getSalesHeader[i]["createdateTime"].toString(),
          customeraName: "",
          doctotal: getSalesHeader[i]["rcamount"] == null
              ? 0
              : double.parse(getSalesHeader[i]["rcamount"].toString())));
    }
    searchData.addAll(searchdata2);
    // filtersearchData = searchData;
    searchbool = false;
    notifyListeners();
  }

  bool expBool = false;

  String? shipaddress = "";
  fixDataMethod(int docentry) async {
    sapDocentry = '';
    sapDocuNumber = '';
    mycontroller[9].text = "";
    mycontroller[10].text = "";
    mycontroller[11].text = "";
    mycontroller[12].text = "";
    mycontroller[13].text = "";
    mycontroller[14].text = "";

    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBExpensesHeader =
        await DBOperation.getExpensHeaderData(db, docentry);
    if (getDBExpensesHeader.isNotEmpty) {
      sapDocentry = getDBExpensesHeader[0]["sapDocentry"] != null
          ? getDBExpensesHeader[0]["sapDocentry"].toString()
          : "";
      sapDocuNumber = getDBExpensesHeader[0]["sapDocNo"] != null
          ? getDBExpensesHeader[0]["sapDocNo"].toString()
          : '';
      expBool = true;
      mycontroller[9].text = getDBExpensesHeader[0]["expencecode"].toString();
      mycontroller[10].text = getDBExpensesHeader[0]["reference"].toString();
      mycontroller[11].text = getDBExpensesHeader[0]["rcamount"].toString();
      mycontroller[12].text = getDBExpensesHeader[0]["paidto"].toString();
      mycontroller[13].text = getDBExpensesHeader[0]["paidfrom"].toString();
      mycontroller[14].text = getDBExpensesHeader[0]["remarks"].toString();
      mycontroller[15].text = getDBExpensesHeader[0]["attachment"].toString();

      notifyListeners();
    } else {
      expBool = false;
      notifyListeners();
    }

    notifyListeners();
  }

  mapApprovalData(int docentry, String uDevicTransId) async {
    isApprove = true;
    sapDocentry = '';
    sapDocuNumber = '';
    mycontroller[9].text = "";
    mycontroller[10].text = "";
    mycontroller[11].text = "";
    mycontroller[12].text = "";
    mycontroller[13].text = "";
    mycontroller[14].text = "";
    mycontroller[16].text = "";
    mycontroller[17].text = "";

    draftDocuNumber = docentry.toString();
    uDeviceTransId = uDevicTransId;
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBExpensesHeader =
        await DBOperation.getExpApprovalsts(db, uDevicTransId.toString());
    if (getDBExpensesHeader.isNotEmpty) {
      sapDocentry = getDBExpensesHeader[0]["sapDocentry"] != null
          ? getDBExpensesHeader[0]["sapDocentry"].toString()
          : "";
      sapDocuNumber = getDBExpensesHeader[0]["sapDocNo"] != null
          ? getDBExpensesHeader[0]["sapDocNo"].toString()
          : '';
      expBool = true;
      localDocEntry = getDBExpensesHeader[0]["docentry"].toString() ?? "";
      mycontroller[9].text = getDBExpensesHeader[0]["expencecode"].toString();
      mycontroller[10].text = getDBExpensesHeader[0]["reference"].toString();
      mycontroller[11].text = getDBExpensesHeader[0]["rcamount"].toString();
      mycontroller[12].text = getDBExpensesHeader[0]["paidto"].toString();
      mycontroller[13].text = getDBExpensesHeader[0]["paidfrom"].toString();
      mycontroller[14].text = getDBExpensesHeader[0]["remarks"].toString();
      mycontroller[15].text = getDBExpensesHeader[0]["attachment"].toString();
      mycontroller[18].text =
          getDBExpensesHeader[0]["createdateTime"].toString();

      notifyListeners();
    } else {
      expBool = false;
      notifyListeners();
    }

    notifyListeners();
  }

  clearData() {
    mycontroller = List.generate(150, (i) => TextEditingController());
    mycontroller[9].text = "";
    displayExpanseValue = null;
    sapDocentry = '';
    seriesType = '';
    availableAmt = 0;
    seriesVal = [];
    uuiDeviceId = '';
    draftDocuNumber = '';
    uDeviceTransId = '';
    sapDocuNumber = '';
    mycontroller[17].text = '';
    mycontroller[18].text = '';
    mycontroller[10].text = "";
    mycontroller[11].text = "";
    mycontroller[12].text = "";
    mycontroller[13].text = "";
    mycontroller[15].text = '';
    mycontroller[14].text = "";
    mycontroller[0].text = "";
    mycontroller[1].text = "";
    mycontroller[2].text = "";
    mycontroller[3].text = "";
    codeValue = null;
    chosenValue = null;
    codeValue = null;
    expBool = false;
    expCode = [];
    finalcode = [];
    paidFromData = [];
    cancelbtn = false;
    onDisablebutton = false;
    itemsDocDetails = [];
    pendingApprovalData = [];
    filterPendingApprovalData = [];
    rejectedData = [];
    filterRejectedData = [];
    filterAprvlData = [];
    searchAprvlData = [];
    expSearchHeaderdata = [];
    filtersearchData = [];
    notifyListeners();
  }

  Future<List<String>> checkingdoc(int id) async {
    List<String> listdata = [];
    final Database db = (await DBHelper.getInstance())!;
    String? data = await DBOperation.getnumbSeriesvlue(db, id);
    listdata.add(data.toString());
    listdata.add(data!.substring(8));

    return listdata;
  }

  saveValuesTODB(
      String docstatus, BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    log('Ssssssssss');
    if (formkey[0].currentState!.validate()) {
      if (docstatus.toLowerCase() == "hold") {
        if (holddocentry.isNotEmpty) {
          await DBOperation.deleteExpenseHold(db, holddocentry.toString())
              .then((value) {
            onholdfilter = [];
            holddocentry = '';
            onhold.clear();
          });
        }
        insertExpenseTable(docstatus, context, theme);
      } else if (docstatus.toLowerCase() == "save") {
        log('Ssssssssss1111');

        if (holddocentry.isNotEmpty) {
          await DBOperation.deleteExpenseHold(db, holddocentry.toString())
              .then((value) {
            onholdfilter = [];
            holddocentry = '';
            onhold.clear();
          });
        }
        insertExpenseTable(docstatus, context, theme);
      }
      notifyListeners();
    } else {
      onDisablebutton = false;
      notifyListeners();
    }
  }

  doubleDotMethod(int i, val) {
    String originalString = val;
    String modifiedString = originalString.replaceAll("-", ".");
    String modifiedString2 = modifiedString.replaceAll("..", ".");

    mycontroller[i].text = modifiedString2.toString();
    log(mycontroller[i].text); // Output: example-text-with-double-dots
    notifyListeners();
  }

  String depitAcc = '';
  String creditAcc = '';
  Uuid uuid = const Uuid();
  String? uuiDeviceId = '';
  insertExpenseTable(
      String docstatus, BuildContext context, ThemeData theme) async {
    onDisablebutton = true;
    notifyListeners();
    log('message111111');
    uuiDeviceId = '';
    final Database db = (await DBHelper.getInstance())!;
    List<ExpenseDBModel> values = [];
    int? counofData =
        await DBOperation.getcountofTable(db, "docentry", "Expense");
    int? docEntryCreated = 0;
    if (counofData == 0) {
      if (AppConstant.terminal == 'T1') {
        docEntryCreated = 1000000;
      } else if (AppConstant.terminal == 'T2') {
        docEntryCreated = 2000000;
      } else if (AppConstant.terminal == 'T3') {
        docEntryCreated = 3000000;
      } else if (AppConstant.terminal == 'T4') {
        docEntryCreated = 4000000;
      }
    } else {
      docEntryCreated =
          await DBOperation.generateDocentr(db, "docentry", "Expense");
    }
    log('message22222');
    String documentNum = '';
    int? documentN0 =
        await DBOperation.getnumbSer(db, "nextno", "NumberingSeries", 8);

    List<String> getseriesvalue = await checkingdoc(8);

    int docseries = int.parse(getseriesvalue[1]);

    int nextno = documentN0!;

    documentN0 = docseries + documentN0;

    String finlDocnum = getseriesvalue[0].toString().substring(0, 8);

    documentNum = finlDocnum + documentN0.toString();
    uuiDeviceId = uuid.v1();

    values.add(ExpenseDBModel(
        lineid: "",
        docentry: docEntryCreated.toString(),
        doctype: "Expense",
        rcmode: "Cash",
        branch: UserValues.branch,
        uDeviceId: uuiDeviceId.toString(),
        createdateTime: mycontroller[17].text,
        expensecode: codeValue,
        terminal: UserValues.terminal,
        documentno: documentNum.toString(),
        reference: mycontroller[0].text,
        rcamount: mycontroller[1].text,
        paidto: depitAcc,
        paidfrom: creditAcc,
        docstatus: docstatus == "hold"
            ? '1'
            : docstatus == "save"
                ? "2"
                : "null",
        qStatus: "No",
        sapDocNo: null,
        sapDocentry: null,
        remarks: mycontroller[3].text.toString(),
        attachment: mycontroller[16].text.toString()));

    int? docentry2 = await DBOperation.insertExpense(db, values);
    await DBOperation.updatenextno(db, 8, nextno);

    if (docstatus == "hold") {
      chosenValue = null;
      displayExpanseValue = null;

      getdraftindex();
      mycontroller[0].text = "";
      mycontroller[1].text = "";
      mycontroller[2].text = "";
      mycontroller[3].text = '';
      codeValue = null;
      onDisablebutton = true;
      chosenValue = null;
      displayExpanseValue = null;
      await Get.defaultDialog(
              title: "Success",
              middleText: docstatus == "hold" ? "Saved as draft" : "null",
              backgroundColor: Colors.white,
              titleStyle:
                  theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
              middleTextStyle: theme.textTheme.bodyLarge,
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: const Text("Close"),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
              ],
              radius: 5)
          .then((value) {
        onDisablebutton = false;
        displayExpanseValue = null;
        notifyListeners();
      });
      notifyListeners();
    } else if (docstatus == "save") {
      bool? netbool = await config.haveInterNet();

      if (netbool == true) {
        await callExpPostApi(context, theme, docentry2!, docstatus);
      }
    }

    notifyListeners();

    onDisablebutton = false;
    notifyListeners();
  }

  callExpPostApi(
    BuildContext context,
    ThemeData theme,
    int docEntry,
    String docstatus,
  ) async {
    await sapLoginApi(context);

    if (double.parse(mycontroller[1].text) < 10000) {
      await postingExp(context, theme, docEntry, docstatus);
    } else {
      await postingApprovalExp(context, theme, docEntry, docstatus);
    }
    notifyListeners();
  }

  List<ExpenseListMoel> itemsDocDetails = [];
  addAccLine() {
    itemsDocDetails = [];
    itemsDocDetails.add(ExpenseListMoel(
        accountCode: depitAcc,
        decription: mycontroller[3].text.toString(),
        grossAmount: double.parse(mycontroller[1].text),
        sumPaid: double.parse(mycontroller[1].text.toString())));
    notifyListeners();
  }

  String seriesType = '';
  List<SeriesValue> seriesVal = [];

  callSeriesApi(BuildContext context, String type) async {
    final Database db = (await DBHelper.getInstance())!;
    seriesVal = [];
    seriesType = '';
    log('sessionid::${AppConstant.sapSessionID}');
    await SeriesAPi.getGlobalData('$type').then((value) async {
      if (value.stsCode! >= 200 && value.stsCode! <= 210) {
        if (value.seriesvalue != null) {
          seriesVal = value.seriesvalue!;
          notifyListeners();
          List<Map<String, Object?>> branchdata =
              await DBOperation.getBrnachbyCode(db, AppConstant.branch);
          for (var i = 0; i < seriesVal.length; i++) {
            for (var ik = 0; ik < branchdata.length; ik++) {
              // log('seriesVal[i].name::${seriesVal[i].name}::${branchdata[ik]['WhsName'].toString()}');
              if (branchdata[ik]['WhsName'].toString() == seriesVal[i].name) {
                seriesType = seriesVal[i].series.toString();
              }
            }
          }
        }
      } else {}
    });

    notifyListeners();
  }

  postingExp(
    BuildContext context,
    ThemeData theme,
    int docEntry,
    String docstatus,
  ) async {
    final Database db = (await DBHelper.getInstance())!;
    seriesType = '';

    // await callSeriesApi(context, '46');
    addAccLine();
    PostExpenseAPi.cashAccount = creditAcc;
    PostExpenseAPi.seriesType = seriesType;
    PostExpenseAPi.reference = mycontroller[0].text;

    PostExpenseAPi.payTo = mycontroller[21].text.toString();
    PostExpenseAPi.docDate = config.alignDate1(mycontroller[17].text);
    PostExpenseAPi.docType = "rAccount";
    PostExpenseAPi.cashSum = mycontroller[1].text;
    PostExpenseAPi.remarks = mycontroller[3].text.toString();
    PostExpenseAPi.paymentAccounts = itemsDocDetails;

    await PostExpenseAPi.method(uuiDeviceId);
    // // var uuid = const Uuid();
    // String? uuidg = uuid.v1();
    await PostExpenseAPi.getGlobalData(uuiDeviceId).then((value) async {
      if (value.statusCode == null) {
        return;
      }
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.docEntry != null) {
          sapDocentry = value.docEntry.toString();
          sapDocuNumber = value.docNum.toString();
          await DBOperation.updtSapDetSalHead(db, int.parse(sapDocentry!),
              int.parse(sapDocuNumber!), docEntry, 'Expense');

          await Get.defaultDialog(
                  title: "Success",
                  middleText: docstatus == "save"
                      ? 'Successfully Done ,Document Number is ${sapDocuNumber!.isNotEmpty || sapDocuNumber != null ? sapDocuNumber : "N/A"}'
                      : "null",
                  backgroundColor: Colors.white,
                  titleStyle:
                      theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
                  middleTextStyle: theme.textTheme.bodyLarge,
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: const Text("Close"),
                          onPressed: () => Get.back(),
                        ),
                      ],
                    ),
                  ],
                  radius: 5)
              .then((value) {
            mycontroller = List.generate(150, (i) => TextEditingController());
            onDisablebutton = false;
            notifyListeners();
            mycontroller[0].text = "";
            mycontroller[1].text = "";
            mycontroller[2].text = "";
            mycontroller[3].text = '';
            codeValue = null;
            onDisablebutton = true;
            chosenValue = null;
            displayExpanseValue = null;
            if (docstatus == "save") {
              Get.offAllNamed(ConstantRoutes.dashboard);
            }
            onDisablebutton = false;
            displayExpanseValue = null;
            itemsDocDetails = [];
            notifyListeners();
          });

          custserieserrormsg = '';
        } else {
          custserieserrormsg = value.error!.message!.value.toString();
          mycontroller = List.generate(150, (i) => TextEditingController());

          onDisablebutton = false;
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        custserieserrormsg = value.error!.message!.value.toString();

        log('message error msg::${custserieserrormsg}');
        Get.defaultDialog(
            title: 'Alert',
            middleText: '$custserieserrormsg',
            actions: [
              ElevatedButton(
                  onPressed: () {
                    onDisablebutton = false;

                    Get.back();
                  },
                  child: Text('Close'))
            ]);

        // showDialog(
        //     context: context,
        //     barrierDismissible: false,
        //     builder: (BuildContext context) {
        //       return AlertDialog(
        //           contentPadding: const EdgeInsets.all(0),
        //           content: AlertBox(
        //             payMent: 'Alert',
        //             errormsg: true,
        //             widget: Center(
        //                 child: ContentContainer(
        //               content: '$custserieserrormsg',
        //               theme: theme,
        //             )),
        //             buttonName: null,
        //           ));
        //     }).then((value) {
        //   onDisablebutton = false;
        // });
        notifyListeners();
      } else {
        cancelbtn = false;
        custserieserrormsg = value.error!.message!.value.toString();
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: const EdgeInsets.all(0),
                  content: AlertBox(
                    payMent: 'Alert',
                    errormsg: true,
                    widget: Center(
                        child: ContentContainer(
                      content: 'Something wwent Wrong..!!',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {});
      }
      onDisablebutton = false;
    });

    onDisablebutton = false;

    notifyListeners();
  }

  postingApprovalExp(
    BuildContext context,
    ThemeData theme,
    int docEntry,
    String docstatus,
  ) async {
    final Database db = (await DBHelper.getInstance())!;

    seriesType = '';
    log('message1');
    // await callSeriesApi(context, '46');
    addAccLine();
    PostApprovalExpenseAPi.cashAccount = creditAcc;
    PostApprovalExpenseAPi.docDate = config.alignDate1(mycontroller[17].text);
    PostApprovalExpenseAPi.seriesType = seriesType;
    PostApprovalExpenseAPi.payTo = mycontroller[21].text.toString();
    PostApprovalExpenseAPi.docType = "rAccount";
    PostApprovalExpenseAPi.cashSum = mycontroller[1].text;
    PostApprovalExpenseAPi.remarks = mycontroller[3].text.toString();
    PostApprovalExpenseAPi.paymentAccounts = itemsDocDetails;

    await PostApprovalExpenseAPi.getGlobalData(uuiDeviceId).then((value) async {
      log('message1');

      if (value.statusCode == null) {
        return;
      }
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        await DBOperation.UpdateApprovalExpenseDB(db, docEntry.toString());

        await Get.defaultDialog(
                title: "Success",
                middleText: docstatus == "save"
                    ? 'Successfully sent to approval'
                    : "null",
                backgroundColor: Colors.white,
                titleStyle:
                    theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
                middleTextStyle: theme.textTheme.bodyLarge,
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: const Text("Close"),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                ],
                radius: 5)
            .then((value) {
          mycontroller = List.generate(150, (i) => TextEditingController());
          onDisablebutton = false;
          notifyListeners();
          mycontroller[0].text = "";
          mycontroller[1].text = "";
          mycontroller[2].text = "";
          mycontroller[3].text = '';
          codeValue = null;
          onDisablebutton = true;
          chosenValue = null;
          displayExpanseValue = null;
          if (docstatus == "save") {
            Get.offAllNamed(ConstantRoutes.dashboard);
          }
          onDisablebutton = false;
          displayExpanseValue = null;
          itemsDocDetails = [];
          notifyListeners();
        });

        custserieserrormsg = '';
        // } else {
        //   custserieserrormsg = value.error!.message!.value.toString();
        //   mycontroller = List.generate(150, (i) => TextEditingController());

        //   onDisablebutton = false;
        // }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        cancelbtn = false;
        // custserieserrormsg = value.error!.message!.value.toString();
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: const EdgeInsets.all(0),
                  content: AlertBox(
                    payMent: 'Alert',
                    errormsg: true,
                    widget: Center(
                        child: ContentContainer(
                      content: '$custserieserrormsg',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          onDisablebutton = false;
        });
      } else {
        cancelbtn = false;
        custserieserrormsg = value.error!.message!.value.toString();
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: const EdgeInsets.all(0),
                  content: AlertBox(
                    payMent: 'Alert',
                    errormsg: true,
                    widget: Center(
                        child: ContentContainer(
                      content: 'Something wwent Wrong..!!',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {});
      }
      onDisablebutton = false;
    });
    onDisablebutton = false;

    notifyListeners();
  }

  clearSuspendedData(BuildContext context, ThemeData theme) {
    displayExpanseValue = null;
    codeValue = null;
    onDisablebutton = false;
    codeValue = null;
    mycontroller[0].text = "";
    mycontroller[1].text = "";
    mycontroller[2].text = "";
    mycontroller[3].text = '';
    codeValue = null;
    onDisablebutton = false;
    chosenValue = null;
    notifyListeners();
    Get.defaultDialog(
            title: "Success",
            middleText: "Data Cleared Successfully..!!",
            backgroundColor: Colors.white,
            titleStyle: const TextStyle(color: Colors.red),
            middleTextStyle: const TextStyle(color: Colors.black),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text("Close"),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ],
            radius: 5)
        .then((value) {
      onDisablebutton = false;
      codeValue = null;
      mycontroller[0].text = "";
      mycontroller[1].text = "";
      mycontroller[2].text = "";
      mycontroller[3].text = '';
      codeValue = null;
      onDisablebutton = false;
      chosenValue = null;
      notifyListeners();
    });
    notifyListeners();
  }

  Future<void> postRabitMqExpense(int docentry) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBExpensesHeader =
        await DBOperation.getExpensHeaderData(db, docentry);
    String bxpensesHeader = json.encode(getDBExpensesHeader);

    var ddd = json.encode({
      "ObjectType": 8,
      "ActionType": "Add",
      "ExpensesHeader": bxpensesHeader,
    });

    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(),
        port: 5672,
        authProvider: const PlainAuthenticator("buson", "BusOn123"));
    Client client1 = Client(settings: settings);

    MessageProperties properties = MessageProperties();

    Channel channel = await client1.channel();
    Exchange exchange =
        await channel.exchange("POS", ExchangeType.HEADERS, durable: true);

    properties.headers = {"Branch": "Server"};
    exchange.publish(ddd, "", properties: properties);
    client1.close();
  }

  Future<void> postRabitMqExpense2(int docentry) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBExpensesHeader =
        await DBOperation.getExpensHeaderData(db, docentry);
    String bExpensesHeader = json.encode(getDBExpensesHeader);

    var ddd = json.encode({
      "ObjectType": 8,
      "ActionType": "Add",
      "ExpensesHeader": bExpensesHeader,
    });

    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(),
        port: 5672,
        authProvider: const PlainAuthenticator("buson", "BusOn123"));
    Client client1 = Client(settings: settings);

    MessageProperties properties = MessageProperties();

    properties.headers = {"Branch": UserValues.branch};
    Channel channel = await client1.channel();
    Exchange exchange =
        await channel.exchange("POS", ExchangeType.HEADERS, durable: true);
    exchange.publish(ddd, "", properties: properties);

    client1.close();
  }

  Future getdraftindex() async {
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getDBholddata5 =
        await DBOperation.getExpenseDB(db);
    onholdfilter = [];
    onhold = [];
    for (int i = 0; i < getDBholddata5.length; i++) {
      getdraft(i);
    }
    notifyListeners();
  }

  List<Expensedummy> onhold = [];
  List<Expensedummy> onholdfilter = [];
  List<Expensedummy> expenceval2 = [];

  getdraft(int i) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBholddata5 =
        await DBOperation.getExpenseDB(db);
    onholdfilter = [];

    Expensedummy expenceval = Expensedummy(
      expensecode: getDBholddata5[i]['expencecode'].toString(),
      reference: getDBholddata5[i]['reference'].toString(),
      rcamount: (int.parse(getDBholddata5[i]['rcamount'].toString()))
          .toStringAsFixed(2),
      paidto: getDBholddata5[i]['paidto'].toString(),
      paidfrom: getDBholddata5[i]['paidfrom'].toString(),
      docstatus: getDBholddata5[i]['docstatus'].toString(),
      createDate: getDBholddata5[i]['createdateTime'].toString(),
      docentry: getDBholddata5[i]['docentry'].toString(),
      remarks: getDBholddata5[i]['remarks'].toString(),
      attachment: getDBholddata5[i]['attachment'].toString(),
    );
    expenceval2.add(expenceval);
    onhold.add(expenceval);
    onholdfilter = onhold;
    notifyListeners();
  }

  filterListOnHold(String v) {
    if (v.isNotEmpty) {
      onholdfilter = onhold
          .where((e) =>
              e.rcamount!.toLowerCase().contains(v.toLowerCase()) ||
              e.expensecode!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      onholdfilter = onhold;
      notifyListeners();
    }
  }

  mapHoldValues(int i, BuildContext context, ThemeData theme) async {
    await selectedName(onholdfilter[i].expensecode.toString());
    codeValue = onholdfilter[i].expensecode.toString();
    mycontroller[0].text = onholdfilter[i].reference.toString();
    mycontroller[1].text = onholdfilter[i].rcamount.toString();
    mycontroller[2].text = onholdfilter[i].paidto.toString();
    chosenValue = onholdfilter[i].paidfrom.toString();
    creditAcc = onholdfilter[i].paidfrom.toString();
    depitAcc = onholdfilter[i].paidto.toString();
    mycontroller[3].text = onholdfilter[i].remarks.toString();
    mycontroller[16].text = onholdfilter[i].attachment.toString();

    notifyListeners();
    holddocentry = onholdfilter[i].docentry.toString();

    notifyListeners();
  }

  clickcancelbtn(BuildContext context, ThemeData theme) async {
    if (sapDocentry != null) {
      await sapLoginApi(context);
      await callSerlaySalesCancelQuoAPI(context, theme);
      notifyListeners();
    } else {
      cancelbtn = false;
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
                contentPadding: const EdgeInsets.all(0),
                content: AlertBox(
                  payMent: 'Alert',
                  errormsg: true,
                  widget: Center(
                      child: ContentContainer(
                    content: 'Something went wrong',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        clearData();
        sapDocentry = '';
        sapDocuNumber = '';
        mycontroller[9].text = "";
        mycontroller[10].text = "";
        mycontroller[11].text = "";
        mycontroller[12].text = "";
        mycontroller[13].text = "";
        mycontroller[14].text = "";
        notifyListeners();
      });
      notifyListeners();
    }
  }

  sapLoginApi(BuildContext context) async {
    final pref2 = await pref;

    await PostExpensesLoginAPi.getGlobalData().then((value) async {
      if (value.stCode! >= 200 && value.stCode! <= 210) {
        if (value.sessionId != null) {
          pref2.setString("sessionId", value.sessionId.toString());
          pref2.setString("sessionTimeout", value.sessionTimeout.toString());
          getSession();
        }
      } else if (value.stCode! >= 400 && value.stCode! <= 410) {
        if (value.error!.code != null) {
          loadingscrn = false;
          final snackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
              bottom: Screens.bodyheight(context) * 0.3,
            ),
            duration: const Duration(seconds: 4),
            backgroundColor: Colors.red,
            content: Text(
              "${value.error!.message!.value}\nCheck Your Sap Details !!..",
              style: const TextStyle(color: Colors.white),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Future.delayed(const Duration(seconds: 5), () {
            exit(0);
          });
        }
      } else if (value.stCode == 500) {
        final snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: Screens.bodyheight(context) * 0.3,
          ),
          duration: const Duration(seconds: 4),
          backgroundColor: Colors.red,
          content: const Text(
            "Opps Something went wrong !!..",
            style: TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: Screens.bodyheight(context) * 0.3,
          ),
          duration: const Duration(seconds: 4),
          backgroundColor: Colors.red,
          content: const Text(
            "Opps Something went wrong !!..",
            style: TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  void getSession() async {
    var preff = await SharedPreferences.getInstance();
    AppConstant.sapSessionID = preff.getString('sessionId')!;
    notifyListeners();
  }

  void callApprovaltoDocApi(BuildContext context, ThemeData theme) async {
    sapDocentry = '';
    sapDocuNumber = '';
    final Database db = (await DBHelper.getInstance())!;
    await sapLoginApi(context);
    ApprovalsExpPostAPi.docEntry = draftDocuNumber;
    // ApprovalsExpPostAPi.docDueDate = approvalDetailsValue!.DocDate;
    // ApprovalsExpPostAPi.orderDate = approvalDetailsValue!.U_OrderDate;
    // ApprovalsExpPostAPi.orderTime = approvalDetailsValue!.U_Received_Time;
    // ApprovalsExpPostAPi.orderType = approvalDetailsValue!.PostOrder_Type;
    // ApprovalsExpPostAPi.custREfNo = approvalDetailsValue!.numAt;
    // ApprovalsExpPostAPi.gpApproval = approvalDetailsValue!.PostGP_Approval;

    await ApprovalsExpPostAPi.getGlobalData().then((valuex) async {
      if (valuex.statusCode >= 200 && valuex.statusCode <= 210) {
        ApprovalsExpAPi.uDeviceID = uDeviceTransId;
        // approvalDetailsValue!.uDevicTransId.toString();

        await ApprovalsExpAPi.getGlobalData().then((value) async {
          if (value.statusCode! >= 200 && value.statusCode! <= 210) {
            if (value.approvalsOrdersValue!.isNotEmpty) {
              await DBOperation.updtAprvltoDocExpenseHead(
                  db,
                  int.parse(value.approvalsOrdersValue![0].docEntry.toString()),
                  int.parse(value.approvalsOrdersValue![0].docNum.toString()),
                  int.parse(localDocEntry.toString()));
              onDisablebutton = false;
              await Get.defaultDialog(
                      title: "Success",
                      middleText:
                          "Successfully Done,\n Document Number ${value.approvalsOrdersValue![0].docNum}",
                      backgroundColor: Colors.white,
                      titleStyle: const TextStyle(color: Colors.red),
                      middleTextStyle: const TextStyle(color: Colors.black),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                child: const Text("Close"),
                                onPressed: () {
                                  loadingscrn = false;

                                  Get.back();
                                }),
                          ],
                        ),
                      ],
                      radius: 5)
                  .then((value) {
                isApprove = false;
                draftDocuNumber = '';
                uDeviceTransId = '';

                Get.offAllNamed(ConstantRoutes.dashboard);
                notifyListeners();
              });
            } else {}
          }
        });
        isApprove = false;
        notifyListeners();
      } else if (valuex.statusCode >= 400 || valuex.statusCode <= 404) {
        await Get.defaultDialog(
                title: "Alert",
                middleText: '${valuex.erorrs!.message!.value}',
                backgroundColor: Colors.white,
                titleStyle: const TextStyle(color: Colors.red),
                middleTextStyle: const TextStyle(color: Colors.black),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: const Text("Close"),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                ],
                radius: 5)
            .then((value) {
          onDisablebutton = false;
        });
        notifyListeners();
      } else {
        await Get.defaultDialog(
                title: "Alert",
                middleText: '${valuex.erorrs!.message!.value}',
                backgroundColor: Colors.white,
                titleStyle: const TextStyle(color: Colors.red),
                middleTextStyle: const TextStyle(color: Colors.black),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: const Text("Close"),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                ],
                radius: 5)
            .then((value) {
          isApprove = false;
        });
      }
    });
  }

  callSerlaySalesCancelQuoAPI(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    await SerlayExpensesCancelAPI.getData(sapDocentry.toString())
        .then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 204) {
        cancelbtn = false;
        await DBOperation.updateExpclosedocsts(db, sapDocentry.toString());
        await Get.defaultDialog(
                title: "Success",
                middleText: 'Document is successfully cancelled ..!!',
                backgroundColor: Colors.white,
                titleStyle: const TextStyle(color: Colors.red),
                middleTextStyle: const TextStyle(color: Colors.black),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: const Text("Close"),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                ],
                radius: 5)
            .then((value) {
          clearData();
          sapDocentry = '';
          sapDocuNumber = '';
          mycontroller[9].text = "";
          mycontroller[10].text = "";
          mycontroller[11].text = "";
          mycontroller[12].text = "";
          mycontroller[13].text = "";
          mycontroller[14].text = "";
          notifyListeners();
        });
        custserieserrormsg = '';
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        cancelbtn = false;
        custserieserrormsg = value.exception!.message!.value.toString();

        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: const EdgeInsets.all(0),
                  content: AlertBox(
                    payMent: 'Alert',
                    errormsg: true,
                    widget: Center(
                        child: ContentContainer(
                      content: '$custserieserrormsg',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          clearData();
          sapDocentry = '';
          sapDocuNumber = '';
          mycontroller[9].text = "";
          mycontroller[10].text = "";
          mycontroller[11].text = "";
          mycontroller[12].text = "";
          mycontroller[13].text = "";
          mycontroller[14].text = "";
          notifyListeners();
        });
      } else {}
    });
    notifyListeners();
  }

  getcodeExpense() async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBholddata5 =
        await DBOperation.getExpenseMaster(db);
    for (int i = 0; i < getDBholddata5.length; i++) {
      expCode.add(codeforexpense(
          expensecode: getDBholddata5[i]["expensecode"].toString(),
          expensename: getDBholddata5[i]["expensename"].toString(),
          debit: getDBholddata5[i]["debit"].toString(),
          credit: getDBholddata5[i]["credit"].toString(),
          limit: getDBholddata5[i]["limitval"].toString()));
      notifyListeners();
    }

    notifyListeners();
  }

  getpaidfomExpense() async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBholddata5 =
        await DBOperation.getExpensepaidfrom(db);
    for (int i = 0; i < getDBholddata5.length; i++) {
      paidFromData.add(PaidFrom(
          accountcode: getDBholddata5[i]["accountcode"].toString(),
          accountname: getDBholddata5[i]["accountname"].toString(),
          balance: getDBholddata5[i]["balance"].toString()));
      notifyListeners();
    }
    notifyListeners();
  }

  Future<bool> onbackpress() {
    if (checkAnyValue() == true) {
      Get.defaultDialog(
          barrierDismissible: false,
          title: 'Warning..!!',
          titleStyle: TextStyle(color: Colors.red),
          content: StatefulBuilder(builder: (context, st) {
            return SizedBox(
              width: Screens.width(context) * 0.3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.005,
                  ),
                  const Text(
                      'Are sure to close this expence all data will lost'),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: Screens.width(context) * 0.08,
                        child: ElevatedButton(
                            onPressed: () {
                              clearAllDataHold();
                              notifyListeners();
                            },
                            child: const Text('Ok')),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.08,
                        child: ElevatedButton(
                            onPressed: () {
                              onDisablebutton = false;
                              Get.back();
                            },
                            child: const Text('Cancel')),
                      ),
                    ],
                  )
                ],
              ),
            );
          }));
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  clearAllDataHold() {
    clearData();
    Get.back();
    notifyListeners();
  }

  bool checkAnyValue() {
    bool result = false;
    if (codeValue != null ||
        chosenValue != null ||
        mycontroller[0].text.isNotEmpty ||
        mycontroller[1].text.isNotEmpty ||
        mycontroller[3].text.isNotEmpty ||
        mycontroller[4].text.isNotEmpty) {
      result = true;
    }
    return result;
  }

  double? availableAmt = 0;
  void selectedCode(String value) {
    availableAmt = 0;
    codeValue = '';
    displayExpanseValue = value;
    for (int i = 0; i < expenseModel.length; i++) {
      if (value == expenseModel[i].name) {
        codeValue = expenseModel[i].code;
        availableAmt = expenseModel[i].currentTotal;
      }
      notifyListeners();
    }

    notifyListeners();
  }

  Future selectedName(String code) async {
    for (int i = 0; i < expenseModel.length; i++) {
      if (code == expenseModel[i].code) {
        displayExpanseValue = expenseModel[i].name;
      }
    }
    notifyListeners();
  }

  List<DocumentApprovalValue> documentApprovalValue = [];

  ApprovalDetailsValue? approvalDetailsValue;
  getdraftDocEntry(
      BuildContext context, ThemeData theme, String dcEntry) async {
    approvalDetailsValue = null;
    await ApprovalsDetailsAPi.getGlobalData(dcEntry).then((value) async {
      if (value.documentLines != null) {
        approvalDetailsValue = value;
        documentApprovalValue = value.documentLines!;
        log('documentApprovalValue::${documentApprovalValue.length}');
        // await mapApprovalData(
        //     int.parse(approvalDetailsValue!.docEntry.toString()));
      } else if (value.error != null) {
        final snackBar = SnackBar(
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
          content: Text(
            '${value.error}!!..',
            style: const TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  searchAprvlMethod() {
    mycontroller[102].text = config.alignDate(config.currentDate());
    mycontroller[103].text = config.alignDate(config.currentDate());
    notifyListeners();
  }

  List<SearchEpenseDataModel> expSearchHeaderdata = [];

  callSearchHeader() async {
    expSearchHeaderdata = [];
    filtersearchData = [];
    await SerachExpHeaderAPi.getGlobalData(
            config.alignDate2(mycontroller[100].text),
            config.alignDate2(mycontroller[101].text))
        .then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.expSearchdata!.isNotEmpty) {
          expSearchHeaderdata = value.expSearchdata!;
          filtersearchData = expSearchHeaderdata;
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
      } else {}
    });
    notifyListeners();
  }

  bool searchLoad = false;
  callGetExpDetailsApi(String docEntry, BuildContext context) async {
    await sapLoginApi(context);
    mycontroller[9].text = mycontroller[10].text = '';
    mycontroller[11].text = '';
    mycontroller[12].text = '';
    mycontroller[13].text = '';
    mycontroller[14].text = '';
    mycontroller[15].text = '';
    searchLoad = true;
    await SerlayExpensesAPI.getData(docEntry).then((value) {
      expBool = true;

      if (value.stsCode! >= 200 && value.stsCode! <= 210) {
        if (value.docEntry != null && value.paymentAccounts.isNotEmpty) {
          for (var i = 0; i < value.paymentAccounts.length; i++) {
            mycontroller[9].text =
                value.paymentAccounts[i].accountName.toString();
            mycontroller[10].text = value.reference1.toString();
            mycontroller[11].text = config.splitValues(
                value.paymentAccounts[i].sumPaid.toStringAsFixed(2));
            // mycontroller[12].text = getDBExpensesHeader[0]["paidto"].toString();
            mycontroller[13].text = '';
            // getDBExpensesHeader[0]["paidfrom"].toString();
            mycontroller[14].text = value.remarks.toString();
            mycontroller[18].text = config.alignDate(value.docDate.toString());

            // mycontroller[15].text =
            //     getDBExpensesHeader[0]["attachment"].toString();
          }
          searchLoad = false;

          notifyListeners();
        } else {
          searchLoad = false;
        }
        notifyListeners();
      } else if (value.stsCode! >= 400 && value.stsCode! <= 410) {
        expBool = false;
        searchLoad = false;
        notifyListeners();
      } else {
        searchLoad = false;
        expBool = false;
        notifyListeners();
      }
    });
    Get.back();
    notifyListeners();
  }

  List<ApprovalsOrdersValue> filterAprvlData = [];
  List<ApprovalsOrdersValue> searchAprvlData = [];

  callPendingApprovalapi(BuildContext context) async {
    await ExpPensingApprovalsAPi.getGlobalData(
      config.alignDate2(mycontroller[102].text),
      config.alignDate2(mycontroller[103].text),
    ).then((value) {
      if (value.stsCode >= 200 && value.stsCode <= 210) {
        pendingApprovalData = value.approvalsvalue!;
        filterPendingApprovalData = pendingApprovalData;
        log('pendingApprovalDatapendingApprovalData::${pendingApprovalData.length}');
        notifyListeners();
      } else if (value.stsCode >= 400 || value.stsCode <= 404) {
      } else {}
    });
    notifyListeners();
  }

  callRejectedAPi(BuildContext context) async {
    await ExpRejectedAPi.getGlobalData(
      config.alignDate2(mycontroller[102].text),
      config.alignDate2(mycontroller[103].text),
    ).then((value) {
      if (value.stsCode >= 200 && value.stsCode <= 210) {
        log('messagellllll');
        rejectedData = value.approvalsvalue!;
        filterRejectedData = rejectedData;
        log('Rejected data length::${filterRejectedData.length}');
        notifyListeners();
      } else if (value.stsCode >= 400 || value.stsCode <= 404) {
        notifyListeners();
      } else {}
    });
    notifyListeners();
  }

  callAprvllDataDatewise(String fromdate, String todate) async {
    searchAprvlData = [];
    filterAprvlData = [];
    searchbool = true;
    // ExpApprovalAPi.slpCode = AppConstant.slpCode;
    ExpApprovalAPi.dbname = "${AppConstant.sapDB}";
    await ExpApprovalAPi.getGlobalData(fromdate, todate).then(
      (value) {
        if (value.statusCode! >= 200 && value.statusCode! <= 204) {
          searchAprvlData = value.approvedData!;
          filterAprvlData = searchAprvlData;
          log('searchAprvlData length:::${searchAprvlData.length}');

          notifyListeners();
        } else if (value.statusCode! >= 400 && value.statusCode! <= 404) {
          clickAprList = false;

          log('message:::${value.error}');
        } else {
          clickAprList = false;
          log('message22:::${value.error}');
        }
      },
    );

    notifyListeners();
  }

  filterAprvlBoxList(String v) {
    if (v.isNotEmpty) {
      filterAprvlData = searchAprvlData
          .where((e) =>
              e.docEntry!.toString().toLowerCase().contains(v.toLowerCase()) ||
              e.docNum.toString().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterAprvlData = searchAprvlData;
      notifyListeners();
    }
  }

  List<ApprovalsValue> pendingApprovalData = [];
  List<ApprovalsValue> filterPendingApprovalData = [];
  List<ApprovalsValue> rejectedData = [];
  List<ApprovalsValue> filterRejectedData = [];
  filterPendingAprvlBoxList(String v) {
    if (v.isNotEmpty) {
      filterPendingApprovalData = pendingApprovalData
          .where((e) =>
              e.draftEntry!
                  .toString()
                  .toLowerCase()
                  .contains(v.toLowerCase()) ||
              e.docNum.toString().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterPendingApprovalData = pendingApprovalData;
      notifyListeners();
    }
  }

  filterRejectedBoxList(String v) {
    if (v.isNotEmpty) {
      filterRejectedData = rejectedData
          .where((e) =>
              e.draftEntry!
                  .toString()
                  .toLowerCase()
                  .contains(v.toLowerCase()) ||
              e.docNum.toString().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterRejectedData = rejectedData;
      notifyListeners();
    }
  }

  int? groupValueSelected = 0;
  int? get getgroupValueSelected => groupValueSelected;
  groupSelectvalue(int i) {
    groupValueSelected = i;
    if (i == 0) {
      notifyListeners();
    } else {}
    notifyListeners();
  }

  getAprvlDate2(BuildContext context, datetype) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (datetype == "From") {
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate!);
      mycontroller[102].text = datetype!;
    } else if (datetype == "To") {
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate!);
      mycontroller[103].text = datetype!;
    } else {}
  }
}
