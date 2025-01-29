import 'dart:developer';

class SapConsumeQueue {
  int? objectType;
  String? actionType;
  int? transId;
  String? branch;
  String? terminal;
  int? docNumber;
  int? docEntry;
  bool? status;
  String? errorMessage;
  String? myProperty1;
  String? myProperty2;
  SapConsumeQueue(
      {required this.actionType,
      //
      required this.branch,
      required this.docEntry,
      required this.docNumber,
      required this.objectType,
      required this.myProperty1,
      required this.myProperty2,
      required this.transId,
      required this.terminal,
      required this.status,
      required this.errorMessage});

  factory SapConsumeQueue.fromjson(Map<String, dynamic> resp) {
    log(' resp DocEntry::${resp['DocEntry']}');
    return SapConsumeQueue(
      actionType: resp['ActionType'],
      branch: resp['Branch'],
      docEntry: resp['DocEntry'] == null
          ? null
          : int.parse(resp['DocEntry'].toString()),
      objectType: resp['ObjectType'],
      docNumber: resp['DocNumber'] == null
          ? null
          : int.parse(resp['DocNumber'].toString()),
      terminal: resp['Terminal'] == null ? null : resp['Terminal'].toString(),
      transId: resp['TransId'] != null ? int.parse(resp['TransId']) : null,
      status: resp['Status'],
      errorMessage: resp['ErrorMessage'].toString(),
      myProperty1: resp['MyProperty1'],
      myProperty2: resp['MyProperty2'],
    );
  }
}
