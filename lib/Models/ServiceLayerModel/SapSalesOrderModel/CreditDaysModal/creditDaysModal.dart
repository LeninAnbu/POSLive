class CreaditDaysModal {
  String? odatametadata;
  List<CreaditDaysValue>? creaditDaysValueValue;
  String? error;

  CreaditDaysModal({
    required this.odatametadata,
    this.creaditDaysValueValue,
    this.error,
  });
  factory CreaditDaysModal.fromJson(Map<String, dynamic> jsons) {
    if (jsons['value'] != null) {
      final list = jsons['value'] as List; //jsonDecode
      // print(list);
      List<CreaditDaysValue> dataList = list
          .map((dynamic enquiries) => CreaditDaysValue.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return CreaditDaysModal(
        creaditDaysValueValue: dataList,
        odatametadata: jsons['odata.metadata'].toString(),
        // nextLink:  jsons['odata.nextLink'].toString(),
      );
    } else {
      return CreaditDaysModal(
        odatametadata: null,
      );
    }
  }

  factory CreaditDaysModal.issue(String e) {
    return CreaditDaysModal(
      odatametadata: null,
      error: e,
    );
  }
}

class CreaditDaysValue {
  int? CreditDays;

  CreaditDaysValue({
    required this.CreditDays,
  });

  factory CreaditDaysValue.fromJson(dynamic jsons) {
    return CreaditDaysValue(
      CreditDays: jsons['CreditDays'] as int,
    );
  }
}
