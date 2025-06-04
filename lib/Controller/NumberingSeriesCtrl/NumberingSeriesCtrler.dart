import 'package:flutter/cupertino.dart';
import 'package:posproject/Constant/Configuration.dart';
import 'package:sqflite/sqflite.dart';

import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';
import '../../DBModel/NumberingSeries.dart';

class NumberSeriesCtrl extends ChangeNotifier {
  Configure config = Configure();
  List<TextEditingController> nxtnocontroller =
      List.generate(150, (index) => TextEditingController());
  List<TextEditingController> frstnocontroller =
      List.generate(150, (index) => TextEditingController());
  List<TextEditingController> lstnocontroller =
      List.generate(150, (index) => TextEditingController());
  List<TextEditingController> prfixcontroller =
      List.generate(150, (index) => TextEditingController());
  List<TextEditingController> frmdatecontroller =
      List.generate(150, (index) => TextEditingController());
  List<TextEditingController> todatecontroller =
      List.generate(150, (index) => TextEditingController());

  List<NumberingSriesTDB> numberSerisList = [];
  init() {
    clearData();
    getNumberSeriesList();
    notifyListeners();
  }

  clearData() {
    numberSerisList = [];
    nxtnocontroller = List.generate(150, (index) => TextEditingController());
    notifyListeners();
  }

  getNumberSeriesList() async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> numberSeriesData =
        await DBOperation.getNumberSeries(db);
    for (int i = 0; i < numberSeriesData.length; i++) {
      numberSerisList.add(NumberingSriesTDB(
          id: int.parse(numberSeriesData[i]['id'].toString()),
//
          docID: int.parse(numberSeriesData[i]['DocID'].toString()),
          firstNo: int.parse(numberSeriesData[i]['FirstNo'].toString()),
          fromDate: numberSeriesData[i]['FromDate'].toString(),
          lastNo: int.parse(numberSeriesData[i]['LastNo'].toString()),
          nextNo: int.parse(numberSeriesData[i]['NextNo'].toString()),
          prefix: numberSeriesData[i]['Prefix'].toString(),
          terminal: numberSeriesData[i]['Terminal'].toString(),
          toDate: numberSeriesData[i]['ToDate'].toString(),
          wareHouse: numberSeriesData[i]['WareHouse'].toString(),
          docName: numberSeriesData[i]['DocName'].toString()));
    }
    notifyListeners();
    for (int ij = 0; ij < numberSerisList.length; ij++) {
      nxtnocontroller[ij].text = numberSerisList[ij].nextNo.toString();
      frstnocontroller[ij].text = numberSerisList[ij].firstNo.toString();
      lstnocontroller[ij].text = numberSerisList[ij].lastNo.toString();
      prfixcontroller[ij].text = numberSerisList[ij].prefix.toString();
      frmdatecontroller[ij].text =
          config.alignDate(numberSerisList[ij].fromDate.toString());
      todatecontroller[ij].text =
          config.alignDate(numberSerisList[ij].toDate.toString());

      notifyListeners();
    }
    notifyListeners();
  }

  disableKeyBoard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    notifyListeners();
  }

  updateNxtnoTable(int ij) async {
    final Database db = (await DBHelper.getInstance())!;

    numberSerisList[ij].nextNo = int.parse(nxtnocontroller[ij].text);
    await DBOperation.updatenextno(
        db, numberSerisList[ij].id!, numberSerisList[ij].nextNo);
    notifyListeners();
// }
// else{
// print('not updated ');

// }
// notifyListeners();
  }

  updateLastnoTable(int ij) async {
    final Database db = (await DBHelper.getInstance())!;

    numberSerisList[ij].nextNo = int.parse(lstnocontroller[ij].text);
    await DBOperation.updatelastno(
        db, numberSerisList[ij].id!, numberSerisList[ij].nextNo);
    notifyListeners();
// }
// else{
// print('not updated ');

// }
// notifyListeners();
  }

  updateFirstnoTable(int ij) async {
    final Database db = (await DBHelper.getInstance())!;

    numberSerisList[ij].nextNo = int.parse(frstnocontroller[ij].text);
    await DBOperation.updatefirstno(
        db, numberSerisList[ij].id!, numberSerisList[ij].firstNo!);
    notifyListeners();
// }
// else{
// print('not updated ');

// }
// notifyListeners();
  }

  updatePrfixnoTable(int ij) async {
    final Database db = (await DBHelper.getInstance())!;
    numberSerisList[ij].prefix = prfixcontroller[ij].text;
    await DBOperation.updateprefixno(
        db, numberSerisList[ij].id!, numberSerisList[ij].prefix.toString());

    notifyListeners();
  }

  updateFrmDateTable(int ij) async {
    final Database db = (await DBHelper.getInstance())!;

    numberSerisList[ij].fromDate = frmdatecontroller[ij].text;
    await DBOperation.updatefromdate(db, numberSerisList[ij].id!,
        config.alignDate2(numberSerisList[ij].fromDate.toString()));
    notifyListeners();
// }
// else{
// print('not updated ');

// }
// notifyListeners();
  }

  updatetoDateTable(int ij) async {
    final Database db = (await DBHelper.getInstance())!;

    numberSerisList[ij].nextNo = int.parse(todatecontroller[ij].text);
    await DBOperation.updatetodate(db, numberSerisList[ij].id!,
        config.alignDate2(numberSerisList[ij].toDate.toString()));
    notifyListeners();
// }
// else{
// print('not updated ');

// }
// notifyListeners();
  }
}
