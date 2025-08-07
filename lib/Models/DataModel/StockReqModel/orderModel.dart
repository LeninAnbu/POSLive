import 'package:posproject/Models/DataModel/StockReqModel/warehouseModel.dart';
import 'package:posproject/Models/Service%20Model/StockSnapModelApi.dart';

class Orderdetails {
  WhsDetails? whsAdd;
  String orderType;
  String cardCode;
  String cardname;

  String remarks;
  List<StocksnapModelData> scannData;
  Orderdetails(
      {required this.remarks,
      required this.whsAdd,
      required this.cardCode,
      required this.cardname,
      required this.orderType,
      required this.scannData});
}
