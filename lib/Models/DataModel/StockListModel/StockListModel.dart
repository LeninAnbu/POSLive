


class StockListModel{
  int?IMId;
 String? itemCode;
 String itemName;
 String product ;
 String brand ;
 String division ;
 String segment;
 String favorite;
 int isselected;
 double? slpPrice;
 double? mgrPrice;
  double? storeStock;
 double? whsStock;
 String?refreshedRecordDate;


StockListModel({
 required this.itemCode,
  required this.brand, 
  required this.division,
  required this.product, 
  required this.itemName,
  required this.segment,
  required this.isselected,
  required this.favorite,
  required this.mgrPrice,
  required this.slpPrice,
  this.IMId,
  required this.storeStock,
  required this.whsStock,
  this.refreshedRecordDate
});}