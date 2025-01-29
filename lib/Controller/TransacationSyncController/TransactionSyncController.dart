import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:posproject/Constant/Configuration.dart';
import 'package:posproject/Controller/DashBoardController/DashboardController.dart';
import 'package:posproject/Controller/ExpenseController/ExpenseController.dart';
import 'package:posproject/Controller/PaymentReceiptController/PayReceiptController.dart';
import 'package:posproject/Controller/SalesInvoice/SalesInvoiceController.dart';
import 'package:posproject/Controller/SalesOrderController/SalesOrderController.dart';
import 'package:posproject/Controller/SalesQuotationController/SalesQuotationController.dart';
import 'package:posproject/Controller/StockOutwardController/StockOutwardController.dart';
import 'package:posproject/Controller/StockRequestController/StockRequestController.dart';
import 'package:sqflite/sqflite.dart';

import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';

class TransactionSyncController extends ChangeNotifier {
  Configure config = Configure();
  bool syncdataBool = false;
  List<SyncData> syncData1 = [];
  List<SyncData> filtersyncData1 = [];
  bool syncbool = false;
  bool loadingbtn = false;
  init() {
    clearDataAll();
    getDataMethod();
  }

  clearDataAll() {
    syncData1.clear();
    filtersyncData1.clear();
    syncdataBool = false;
    syncbool = false;
    loadingbtn = false;
  }

  getDataMethod() async {
    final Database db = (await DBHelper.getInstance())!;

    syncdataBool = true;
    syncData1.clear();

    List<Map<String, Object?>> getsyncedData =
        await DBOperation.getSynceData(db);
    if (getsyncedData.isNotEmpty) {
      for (int j = 0; j < getsyncedData.length; j++) {
        syncData1.add(
          SyncData(
            basedocentry: getsyncedData[j]["basedocentry"].toString(),
            doctype: getsyncedData[j]["doctype"].toString(),
            docNo: getsyncedData[j]["documentno"] == null
                ? "0"
                : getsyncedData[j]["documentno"].toString(),
            docdate: getsyncedData[j]["createdateTime"].toString(),
            sapDate: getsyncedData[j]["UpdatedDatetime"] == null
                ? ""
                : getsyncedData[j]["UpdatedDatetime"].toString(),
            customername: getsyncedData[j]["customername"].toString(),
            sapNo: getsyncedData[j]["sapDocNo"] == null
                ? 0
                : int.parse(
                    getsyncedData[j]["sapDocNo"].toString(),
                  ),
            sapStatus: getsyncedData[j]["qStatus"].toString(),
            sapDocentry: getsyncedData[j]["sapDocentry"] == null
                ? ""
                : getsyncedData[j]["sapDocentry"].toString(),
            reqfromwhs: getsyncedData[j]["reqfromWhs"].toString(),
            reqtowhs: getsyncedData[j]["reqtoWhs"].toString(),
            docentry: getsyncedData[j]["docentry"].toString(),
            editType: getsyncedData[j]["editType"].toString(),
          ),
        );
        notifyListeners();
      }
      filtersyncData1 = syncData1;
    } else {
      syncdataBool = false;
      notifyListeners();
    }
    notifyListeners();
  }

  filterListSearched(String v) {
    syncdataBool = false;
    if (v.isNotEmpty) {
      filtersyncData1 = syncData1
          .where((e) =>
              e.doctype!.toLowerCase().contains(v.toLowerCase()) ||
              e.customername!.toLowerCase().contains(v.toLowerCase()) ||
              e.sapStatus!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filtersyncData1 = syncData1;
      notifyListeners();
    }
  }

  refreshQueue22() async {
    loadingbtn = true;
    bool? netbool = await config.haveInterNet();
    if (netbool == true) {
      log("MMMMMMMMMMMMM");
      final Database db = (await DBHelper.getInstance())!;
      List<Map<String, Object?>> getQstatusData =
          await DBOperation.getQstatusData33(db);

      if (getQstatusData.isNotEmpty) {
        for (int i = 0; i < getQstatusData.length; i++) {
          if (getQstatusData[i]["doctype"].toString() == "Sales Invoice") {
            if (getQstatusData[i]["sapDocentry"] != null &&
                getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.updtSapDetSalHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'SalesHeader');
              notifyListeners();
            }
          } else if (getQstatusData[i]["doctype"].toString() == "Sales Order") {
            if (getQstatusData[i]["sapDocentry"] != null &&
                getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.updtSapDetSalHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'SalesOrderHeader');
              notifyListeners();
            }
          } else if (getQstatusData[i]["sapDocentry"] != null &&
              getQstatusData[i]["doctype"].toString() == "Sales Quotation") {
            log("sales quo doc entry::${getQstatusData[i]["sapDocNo"]}");

            if (getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.updtSapDetSalHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'SalesQuotationHeader');

              notifyListeners();
            }
          } else if (getQstatusData[i]["doctype"].toString() ==
              "Sales Return") {
            if (getQstatusData[i]["sapDocentry"] != null &&
                getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.updtSapDetSalHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'SalesReturnHeader');
              notifyListeners();
            }
          } else if (getQstatusData[i]["doctype"].toString() ==
              "Payment Receipt") {
            if (getQstatusData[i]["sapDocentry"] != null &&
                getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.updtSapDetSalHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'ReceiptHeader');
              notifyListeners();
            }
          } else if (getQstatusData[i]["doctype"].toString() ==
              "Stock Request") {
            if (getQstatusData[i]["sapDocentry"] != null &&
                getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.updtSapDetSalHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'StockReqHDT');
              notifyListeners();
            }
          } else if (getQstatusData[i]["doctype"].toString() ==
              "Stock Outward") {
            if (getQstatusData[i]["sapDocentry"] != null &&
                getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.updtSapDetSalHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'StockOutHeaderDataDB');
            }
          } else if (getQstatusData[i]["doctype"].toString() ==
              "Stock Inward") {
            if (getQstatusData[i]["sapDocentry"] != null &&
                getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.updtSapDetSalHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'StockInHeaderDB');
              notifyListeners();
            }
          } else if (getQstatusData[i]["doctype"].toString() == "Expense") {
            if (getQstatusData[i]["sapDocentry"] != null &&
                getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.updtSapDetSalHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'Expense');
              notifyListeners();
            }
          } else if (getQstatusData[i]["doctype"].toString() == "Settlement") {
            if (getQstatusData[i]["sapDocentry"] != null &&
                getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.updtSapDetSalHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'tableDepositHeader');
              notifyListeners();
            }
          } else if (getQstatusData[i]["doctype"].toString() == "Refund") {
            notifyListeners();
          }
        }
        notifyListeners();
      }
    }

    await Future.delayed(const Duration(seconds: 1)).then((value) {
      getDataMethod();
      loadingbtn = false;

      notifyListeners();
    });
    notifyListeners();
  }

  refreshQueue(SyncData? syncData2, BuildContext context) async {
    syncbool = true;
    bool? netbool = await config.haveInterNet();
    if (netbool == true) {
      final Database db = (await DBHelper.getInstance())!;

      if (syncData2!.doctype == "Sales Invoice") {
        PosController salesInvoice = PosController();
        salesInvoice.pushRabitmqSales(int.parse(syncData2.docentry.toString()));

        if (syncData2.sapDocentry != null &&
            syncData2.sapDocentry!.isNotEmpty) {
          await DBOperation.updtSapDetSalHead(
              db,
              int.parse(syncData2.sapDocentry.toString()),
              int.parse(syncData2.sapNo.toString()),
              int.parse(syncData2.docentry.toString()),
              'SalesHeader');
          notifyListeners();
        }
      } else if (syncData2.doctype == "Sales Order") {
        SOCon salesOrder = SOCon();
        if (syncData2.editType == "Edit") {
          salesOrder.pushRabiMqSO3(int.parse(syncData2.docentry.toString()));
          if (syncData2.sapDocentry != null &&
              syncData2.sapDocentry!.isNotEmpty) {
            await DBOperation.updtSapDetSalHead(
                db,
                int.parse(syncData2.sapDocentry.toString()),
                int.parse(syncData2.sapNo.toString()),
                int.parse(syncData2.docentry.toString()),
                'SalesOrderHeader');
            notifyListeners();
          }
        } else {
          salesOrder.pushRabiMqSO(int.parse(syncData2.docentry.toString()));
          if (syncData2.sapDocentry != null &&
              syncData2.sapDocentry!.isNotEmpty) {
            await DBOperation.updtSapDetSalHead(
                db,
                int.parse(syncData2.sapDocentry.toString()),
                int.parse(syncData2.sapNo.toString()),
                int.parse(syncData2.docentry.toString()),
                'SalesOrderHeader');
            notifyListeners();
          }
        }
      } else if (syncData2.doctype == "Sales Quotation") {
        SalesQuotationCon salesQuot = SalesQuotationCon();
        if (syncData2.editType == "Edit") {
          salesQuot.pushRabiMqSO3(int.parse(syncData2.docentry.toString()));
          if (syncData2.sapDocentry != null &&
              syncData2.sapDocentry!.isNotEmpty) {
            await DBOperation.updtSapDetSalHead(
                db,
                int.parse(syncData2.sapDocentry.toString()),
                int.parse(syncData2.sapNo.toString()),
                int.parse(syncData2.docentry.toString()),
                'SalesQuotationHeader');

            notifyListeners();
          }
        } else {
          salesQuot.pushRabiMqSO(int.parse(syncData2.docentry.toString()));
          if (syncData2.sapDocentry != null &&
              syncData2.sapDocentry!.isNotEmpty) {
            await DBOperation.updtSapDetSalHead(
                db,
                int.parse(syncData2.sapDocentry.toString()),
                int.parse(syncData2.sapNo.toString()),
                int.parse(syncData2.docentry.toString()),
                'SalesQuotationHeader');

            notifyListeners();
          }
        }
      } else if (syncData2.doctype == "Sales Return") {
        if (syncData2.sapDocentry != null &&
            syncData2.sapDocentry!.isNotEmpty) {
          await DBOperation.updtSapDetSalHead(
              db,
              int.parse(syncData2.sapDocentry.toString()),
              int.parse(syncData2.sapNo.toString()),
              int.parse(syncData2.docentry.toString()),
              'SalesReturnHeader');
          notifyListeners();
        }
      } else if (syncData2.doctype == "Payment Receipt") {
        PayreceiptController payRecipt = PayreceiptController();

        if (syncData2.sapDocentry != null &&
            syncData2.sapDocentry!.isNotEmpty) {
          await DBOperation.updtSapDetSalHead(
              db,
              int.parse(syncData2.sapDocentry.toString()),
              int.parse(syncData2.sapNo.toString()),
              int.parse(syncData2.docentry.toString()),
              'ReceiptHeader');
          notifyListeners();
        }
      } else if (syncData2.doctype == "Stock Request") {
        StockReqController stockReq = StockReqController();
        String? whsCode = await DBOperation.getStockReqWhsCode(
            db, int.parse(syncData2.docentry.toString()));
        stockReq.postRabitMqStockReq(
            int.parse(syncData2.docentry.toString()), whsCode.toString());

        if (syncData2.sapDocentry != null &&
            syncData2.sapDocentry!.isNotEmpty) {
          await DBOperation.updtSapDetSalHead(
              db,
              int.parse(syncData2.sapDocentry.toString()),
              int.parse(syncData2.sapNo.toString()),
              int.parse(syncData2.docentry.toString()),
              'StockReqHDT');
          notifyListeners();
        }
      } else if (syncData2.doctype == "Stock Outward") {
        StockOutwardController stOut = StockOutwardController();
        List<Map<String, Object?>> getStOutDetails =
            await DBOperation.getRabitMqStOutDetails(
                db, syncData2.docentry.toString());

        stOut.PostRabitMq(
            int.parse(syncData2.docentry.toString()),
            int.parse(getStOutDetails[0]["baseDocentry"].toString()),
            getStOutDetails[0]["reqfromWhs"].toString());
        if (syncData2.sapDocentry != null &&
            syncData2.sapDocentry!.isNotEmpty) {
          await DBOperation.updtSapDetSalHead(
              db,
              int.parse(syncData2.sapDocentry.toString()),
              int.parse(syncData2.sapNo.toString()),
              int.parse(syncData2.docentry.toString()),
              'StockOutHeaderDataDB');
        }
      } else if (syncData2.doctype == "Stock Inward") {
        if (syncData2.sapDocentry != null &&
            syncData2.sapDocentry!.isNotEmpty) {
          await DBOperation.updtSapDetSalHead(
              db,
              int.parse(syncData2.sapDocentry.toString()),
              int.parse(syncData2.sapNo.toString()),
              int.parse(syncData2.docentry.toString()),
              'StockInHeaderDB');
          notifyListeners();
        }
      } else if (syncData2.doctype == "Expense") {
        ExpenseController Expense = ExpenseController();
        Expense.postRabitMqExpense(int.parse(syncData2.docentry.toString()));
        if (syncData2.sapDocentry != null &&
            syncData2.sapDocentry!.isNotEmpty) {
          await DBOperation.updtSapDetSalHead(
              db,
              int.parse(syncData2.sapDocentry.toString()),
              int.parse(syncData2.sapNo.toString()),
              int.parse(syncData2.docentry.toString()),
              'Expense');
          notifyListeners();
        }
      } else if (syncData2.doctype == "Settlement") {
        if (syncData2.sapDocentry != null &&
            syncData2.sapDocentry!.isNotEmpty) {
          await DBOperation.updtSapDetSalHead(
              db,
              int.parse(syncData2.sapDocentry.toString()),
              int.parse(syncData2.sapNo.toString()),
              int.parse(syncData2.docentry.toString()),
              'tableDepositHeader');
          notifyListeners();
        }
      } else if (syncData2.doctype == "Refund") {
        notifyListeners();
      }
      notifyListeners();
    }

    await Future.delayed(const Duration(seconds: 3)).then((value) {
      getDataMethod();
      notifyListeners();
    });
    syncbool = false;
    Navigator.pop(context);
    notifyListeners();
  }
}

class stockCheckList {
  String? itemname;
  String? itemCode;
  String? serialbatch;
  String? branch;
  int? qty;
  stockCheckList({
    this.branch,
    this.itemCode,
    this.itemname,
    this.qty,
    this.serialbatch,
  });
}
