import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

import '../../Constant/Configuration.dart';
import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';
import '../../Models/DataModel/PaymentModel/PaymentModel.dart';
import '../../Models/DataModel/SalesOrderModel.dart';
import '../../Models/ReportsModel/PendingOrderModel.dart';
import '../../Models/Service Model/StockSnapModelApi.dart';
import '../../Service/ReportsApi/PendingOrderApi.dart';

class PendingOrderController extends ChangeNotifier {
  init() {
    clearAllData();

    notifyListeners();
  }

  Configure config = Configure();

  TotalPayment? totalPayment;
  TotalPayment? get gettotalPayment => totalPayment;
  List<SalesModel> soSalesmodl = [];
  List<StocksnapModelData> filteritems = [];
  List<GlobalKey<FormState>> formkey =
      List.generate(100, (i) => GlobalKey<FormState>());

  List<TextEditingController> searchcontroller =
      List.generate(150, (i) => TextEditingController());

  List<StocksnapModelData> soData = [];
  List<StocksnapModelData> get getsoData => soData;

  clearAllData() {
    config = Configure();
    totalPayment = null;
    soSalesmodl = [];
    filteritems = [];
    pendingOrderdatas = [];
    filterHeaderOrderdatas = [];

    pendingOrderListdatas = [];
    filterOrderdatas = [];
    searchcontroller = List.generate(150, (i) => TextEditingController());
    soData = [];
    notifyListeners();
  }

  String expMsg = '';
  bool isloading = false;
  List<PendingOrdersList>? pendingOrderdatas = [];
  List<PendingOrdersList>? filterHeaderOrderdatas = [];

  List<PendingOrdersList>? pendingOrderListdatas = [];
  List<PendingOrdersList>? filterOrderdatas = [];
  callpendingOrderApi() async {
    pendingOrderdatas = [];
    filterOrderdatas = [];
    filterHeaderOrderdatas = [];
    pendingOrderListdatas = [];
    isloading = true;
    expMsg = '';
    await PendingOrderAPi.getGlobalData(fromDate!, toDate!).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        pendingOrderdatas = value.pendingOrderdata;
        filterHeaderOrderdatas = pendingOrderdatas;
        isloading = false;
        log('message length::${value.pendingOrderdata!.length}');
        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isloading = false;
        expMsg = value.exception.toString();
      }
    });
    notifyListeners();
  }

  String? fromDate;
  String? toDate;

  getDate2(
    BuildContext context,
    datetype,
  ) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    String datetype2;
    if (datetype == "From") {
      log('message::$pickedDate');
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate!);
      datetype2 = DateFormat('yyyy-MM-dd').format(pickedDate);

      searchcontroller[2].text = datetype!;
      fromDate = datetype2;
      log('datetype11::$fromDate');
    } else if (datetype == "To") {
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate!);
      datetype2 = DateFormat('yyyy-MM-dd').format(pickedDate);
      toDate = datetype2;
      searchcontroller[3].text = datetype!;
      log('To datetype::$fromDate');
    } else {}
    notifyListeners();
  }

  filterListItem(String v) {
    if (v.isNotEmpty) {
      filterOrderdatas = pendingOrderListdatas!
          .where((e) =>
              e.itemCode!.toLowerCase().contains(v.toLowerCase()) ||
              e.itemname!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterOrderdatas = pendingOrderListdatas;

      notifyListeners();
    }
  }

  filterHeaderListItem(String v) {
    if (v.isNotEmpty) {
      filterHeaderOrderdatas = pendingOrderdatas!
          .where((e) =>
              e.docNum.toString().contains(v.toLowerCase()) ||
              e.custName!.toLowerCase().contains(v.toLowerCase()) ||
              e.customerCode!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterHeaderOrderdatas = pendingOrderdatas;

      notifyListeners();
    }
  }

  soDetailsData(PendingOrdersList pendingOrderList) {
    pendingOrderListdatas!.add(PendingOrdersList(
        totalQty: pendingOrderList.totalQty,
        date: pendingOrderList.date,
        total: pendingOrderList.total,
        customerCode: pendingOrderList.customerCode,
        docNum: pendingOrderList.docNum,
        custName: pendingOrderList.custName,
        itemCode: pendingOrderList.itemCode,
        itemname: pendingOrderList.itemname,
        balQty: pendingOrderList.balQty));
    filterOrderdatas = pendingOrderListdatas;

    notifyListeners();
  }

  searchBtn() {
    if (formkey[0].currentState!.validate()) {
      callpendingOrderApi();
      notifyListeners();
    }
    notifyListeners();
  }

  soOrderdata(String basedoc, int ih) {
    soData.clear();
    filteritems.clear();
    for (int ik = 0; ik < soSalesmodl[ih].item!.length; ik++) {
      if (soSalesmodl[ih].item![ik].basedocentry.toString() ==
          basedoc.toString()) {
        if (soSalesmodl[ih].item![ik].qty != 0) {
          soData.add(StocksnapModelData(
            docentry: basedoc.toString(),
            basedocentry: soSalesmodl[ih].item![ik].basedocentry,
            baselineid: soSalesmodl[ih].item![ik].baselineid,
            branch: soSalesmodl[ih].item![ik].branch,
            itemCode: soSalesmodl[ih].item![ik].itemCode,
            itemName: soSalesmodl[ih].item![ik].itemName,
            serialBatch: "",
            openQty: soSalesmodl[ih].item![ik].openQty,
            qty: soSalesmodl[ih].item![ik].qty,
            mrp: double.parse(soSalesmodl[ih].item![ik].mrp.toString()),
            createdUserID: soSalesmodl[ih].item![ik].createdUserID.toString(),
            createdateTime: config
                .alignDate(soSalesmodl[ih].item![ik].createdateTime.toString()),
            lastupdateIp: soSalesmodl[ih].item![ik].lastupdateIp,
            purchasedate: soSalesmodl[ih].item![ik].purchasedate,
            snapdatetime: soSalesmodl[ih].item![ik].snapdatetime,
            specialprice:
                double.parse(soSalesmodl[ih].item![ik].specialprice.toString()),
            updatedDatetime: soSalesmodl[ih].item![ik].updatedDatetime,
            updateduserid: soSalesmodl[ih].item![ik].updateduserid.toString(),
            sellPrice:
                double.parse(soSalesmodl[ih].item![ik].sellPrice.toString()),
            maxdiscount: soSalesmodl[ih].item![ik].maxdiscount != null
                ? soSalesmodl[ih].item![ik].maxdiscount.toString()
                : '',
            taxRate: soSalesmodl[ih].item![ik].taxRate != null
                ? double.parse(soSalesmodl[ih].item![ik].taxRate.toString())
                : 0.0,
            discountper:
                double.parse(soSalesmodl[ih].item![ik].discountper!.toString()),
            inDate: '',
            cost: 0,
            inType: '',
            liter: soSalesmodl[ih].item![ik].liter != null
                ? double.parse(soSalesmodl[ih].item![ik].liter.toString())
                : 0.0,
            weight: soSalesmodl[ih].item![ik].weight != null
                ? double.parse(soSalesmodl[ih].item![ik].weight.toString())
                : 0.0,
          ));
          notifyListeners();
        }

        filteritems = soData;
        notifyListeners();
      }

      notifyListeners();
    }
  }

  sBatchFrmStksnap(int indexx) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> serailbatchCheck =
        await DBOperation.cfoserialBatchCheck(
            db, soData[indexx].itemCode.toString());
    for (int i = 0; i < serailbatchCheck.length; i++) {
      if (soData[indexx].itemCode ==
          serailbatchCheck[i]['itemcode'].toString()) {
        soData[indexx].serialBatch =
            serailbatchCheck[i]['serialbatch'].toString();

        notifyListeners();
      }
    }
    notifyListeners();
  }
}
