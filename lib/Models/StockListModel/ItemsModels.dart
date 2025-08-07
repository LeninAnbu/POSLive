class ItemModal {
  String? odatametadata;
  List<ItemValue>? itemValueValue;
  String? error;
  String? nextLink;
  ItemModal({
    required this.odatametadata,
    this.itemValueValue,
    this.error,
    this.nextLink,
  });
  factory ItemModal.fromJson(Map<String, dynamic> jsons) {
    final list = jsons['value'] as List;
    final List<ItemValue> dataList =
        list.map((dynamic enquiries) => ItemValue.fromJson(enquiries)).toList();
    return ItemModal(
      itemValueValue: dataList,
      odatametadata: jsons['odata.metadata'].toString(),
      nextLink: jsons['odata.nextLink'].toString(),
    );
  }

  factory ItemModal.issue(String e) {
    return ItemModal(
      odatametadata: null,
      error: e,
    );
  }
}

class ItemValue {
  String? warehouse;

  String? itemCode;
  String? itemName;
  String? salesUnit;
  String? odataetag;

  String? salesperCode;

  double? U_Pack_Size;
  int? U_Tins_Per_Box;
  List<ItemPrices>? itemPrices;
  ItemValue({
    required this.salesperCode,
    required this.itemCode,
    required this.itemName,
    required this.salesUnit,
    required this.odataetag,
    required this.itemPrices,
    required this.U_Pack_Size,
    required this.U_Tins_Per_Box,
    this.warehouse,
  });

  factory ItemValue.fromJson(dynamic jsons) {
    final list = jsons['ItemPrices'] as List;
    final List<ItemPrices> dataList = list
        .map((dynamic enquiries) => ItemPrices.fromJson(enquiries))
        .toList();
    return ItemValue(
      itemCode: jsons['ItemCode'].toString(),
      itemName: jsons['ItemName'].toString(),
      odataetag: jsons['odata.etag'].toString(),
      salesUnit: jsons['SalesUnit'].toString(),
      warehouse: jsons['WarehouseCode'].toString(),
      itemPrices: dataList,
      U_Pack_Size:
          jsons['U_Pack_Size'] == null ? 0.00 : jsons['U_Pack_Size'] as double,
      U_Tins_Per_Box:
          jsons['U_Tins_Per_Box'] == null ? 0 : jsons['U_Tins_Per_Box'] as int,
      salesperCode: jsons['SalesPersonCode'].toString(),
    );
  }
}

class ItemPrices {
  int? PriceList;
  double? price;
  ItemPrices({required this.PriceList, required this.price});
  factory ItemPrices.fromJson(dynamic jsons) {
    return ItemPrices(
      PriceList: jsons['PriceList'] == null ? 0 : jsons['PriceList'] as int,
      price: jsons['Price'] == null ? 0.00 : jsons['Price'] as double,
    );
  }
}
