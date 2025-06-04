// import 'dart:developer';

// import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
// import 'package:flutter/material.dart';
// import 'package:posbillingdesign/Constant/Configuration.dart';
// import 'package:posbillingdesign/DB%20Helper/DBOperation.dart';
// import 'package:posbillingdesign/DB%20Helper/DBhelper.dart';
// import 'package:posbillingdesign/DBModel/CustomerMasterAddress.dart';
// import 'package:posbillingdesign/Models/DataModel/CustomerModel/CustomerModel.dart';
// import 'package:posbillingdesign/Models/DataModel/PaymentModel/PaymentModel.dart';
// import 'package:posbillingdesign/Models/DataModel/SalesOrderModel.dart';
// import 'package:posbillingdesign/Models/Service%20Model/StockSnapModelApi.dart';
// import 'package:posbillingdesign/Pages/PrintPDF/PDFInVoiceApi.dart';
// import 'package:posbillingdesign/Pages/PrintPDF/ShowPdf.dart';
// import 'package:posbillingdesign/Pages/PrintPDF/invoice.dart';
// import 'package:sqflite/sqflite.dart';

// class PrintController extends ChangeNotifier {
//   Configure config = Configure();
//   Invoice invoice = Invoice();

//   List<SalesModel> salesmodl = [];
//   init() {
//   getPrintindex();
//   }

//  getPrintindex() async {
//     final Database db = (await DBHelper.getInstance())!;

//     List<Map<String, Object?>> getDBholddata5 = await DBOperation.salestoprint(db);
//     for (int i = 0; i < getDBholddata5.length; i++) {
//       print(i.toString());
//       getPrint(i);
//     }
//     notifyListeners();
//   }

//   List<SalesModel> onPrintFilter = [];

//   getPrint(int ji) async {
//     final Database db = (await DBHelper.getInstance())!;
//     List<Map<String, Object?>> getDBholddata1 = await DBOperation.salestoprint(db);

//     List<StocksnapModelData> scannData = [];
//     List<PaymentWay> payment = [];
//     salesmodl.clear();
//     List<Map<String, Object?>>? getDBholdSalesLine = await DBOperation.holdSalesLineDB(db, int.parse(getDBholddata1[ji]['docentry'].toString()));

//     for (int ik = 0; ik < getDBholdSalesLine.length; ik++) {
//       log("getDBholdSalesLine.length:${getDBholdSalesLine.length}");
//       if (getDBholddata1[ji]['docentry'] == getDBholdSalesLine[ik]['docentry']) {
//         print("${getDBholddata1[ji]['docentry'].toString()}::${getDBholdSalesLine[ik]['docentry']}");
//         scannData.add(StocksnapModelData(
//             basic: getDBholdSalesLine[ik]['basic'] != null ? double.parse(getDBholdSalesLine[ik]['basic'].toString()) : 00,
//             netvalue: getDBholdSalesLine[ik]['netlinetotal'] != null ? double.parse(getDBholdSalesLine[ik]['netlinetotal'].toString()) : null,
//             TransID: int.parse(getDBholdSalesLine[ik]['docentry'].toString()),
//             Branch: getDBholdSalesLine[ik]['branch'].toString(),
//             ItemCode: getDBholdSalesLine[ik]['itemcode'].toString(),
//             ItemName: getDBholdSalesLine[ik]['itemname'].toString(),
//             SerialBatch: getDBholdSalesLine[ik]['serialbatch'].toString(),
//             OpenQty: int.parse(getDBholdSalesLine[ik]['quantity'].toString()),
//             Qty: int.parse(getDBholdSalesLine[ik]['quantity'].toString()),
//             InDate: getDBholdSalesLine[ik][''].toString(),
//             InType: getDBholdSalesLine[ik][''].toString(),
//             VenCode: getDBholdSalesLine[ik][''].toString(),
//             VenName: getDBholdSalesLine[ik][''].toString(),
//             MRP: 0,
//             SellPrice: double.parse(getDBholdSalesLine[ik]['price'].toString()),
//             Cost: 0,
//             discount: getDBholdSalesLine[ik]['discperunit'] != null ? double.parse(getDBholdSalesLine[ik]['discperunit'].toString()) : 00,
//             taxvalue: getDBholdSalesLine[ik]['taxtotal'] != null ? double.parse(getDBholdSalesLine[ik]['taxtotal'].toString()) : 00,
//             TaxRate: double.parse(getDBholdSalesLine[ik]['taxrate'].toString()),
//             TaxType: getDBholdSalesLine[ik]['taxtype'].toString(),
//             Maxdiscount: getDBholdSalesLine[ik]['maxdiscount'].toString(),
//             discountper: getDBholdSalesLine[ik]['discperc'] == null ? 0.0 : double.parse(getDBholdSalesLine[ik]['discperc'].toString()),
//             basedocentry: getDBholdSalesLine[ik]['basedocentry'] != null ? getDBholdSalesLine[ik]['basedocentry'].toString() : "",
//             baselineid: getDBholdSalesLine[ik]['baselineID'] != null ? getDBholdSalesLine[ik]['baselineID'].toString() : "",
//             createdUserID: '',
//             createdateTime: '',
//             lastupdateIp: '',
//             purchasedate: '',
//             snapdatetime: '',
//             specialprice: 0,
//             updatedDatetime: '',
//             updateduserid: '',
//             liter: getDBholdSalesLine[ik]['liter'] != null ? double.parse(getDBholdSalesLine[ik]['liter'].toString()) : 00,
//             weight: getDBholdSalesLine[ik]['weight'] != null ? double.parse(getDBholdSalesLine[ik]['weight'].toString()) : 00)); //discperc
//       }
//       notifyListeners();
//     }

//     SalesModel salesM = SalesModel(
//         objname: getDBholddata1[ji]['objname'].toString(),
//         objtype: getDBholddata1[ji]['objtype'].toString(),
//         doctype: getDBholddata1[ji]['doctype'].toString(),
//         docentry: int.parse(getDBholddata1[ji]['docentry'].toString()),
//         custName: getDBholddata1[ji]['customername'].toString(),
//         phNo: getDBholddata1[ji]['customerphono'].toString(),
//         cardCode: getDBholddata1[ji]['customercode'].toString(),
//         accBalance: getDBholddata1[ji]['customeraccbal'].toString(),
//         point: getDBholddata1[ji]['customerpoint'].toString(),
//         tarNo: getDBholddata1[ji]['taxno'].toString(),
//         email: getDBholddata1[ji]['customeremail'].toString(),
//         invoceDate: getDBholddata1[ji]['createdateTime'].toString(),
//         invoiceNum: getDBholddata1[ji]['documentno'].toString(),
//         sapOrderNum: getDBholddata1[ji]['basedocentry'].toString(),
//         sapInvoiceNum: getDBholddata1[ji]['sapDocNo'].toString(),
//         address: [
//           Address(
//               address1: getDBholddata1[ji]['billaddressid'].toString(),
//             
//               billCity: getDBholddata1[ji]['city'].toString(),
//               billCountry: getDBholddata1[ji]['country'].toString(),
//               billPincode: getDBholddata1[ji]['pinno'].toString(),
//               billstate: getDBholddata1[ji]['state'].toString())
//         ],
//         totalPayment: TotalPayment(
//           balance: getDBholddata1[ji]['baltopay'] == null ? 0.00 : double.parse(getDBholddata1[ji]['baltopay'].toString()),

//           discount2: getDBholddata1[ji]['docdiscamt'] == null ? 0.00 : double.parse(getDBholddata1[ji]['docdiscamt'].toString()),
//         
//           discount: getDBholddata1[ji]['docdiscamt'] == null ? 0.00 : double.parse(getDBholddata1[ji]['docdiscamt'].toString()),
//           totalTX: double.parse(getDBholddata1[ji]['taxamount'] == null ? '0' : getDBholddata1[ji]['taxamount'].toString().replaceAll(',', '')),

//           subtotal: double.parse(getDBholddata1[ji]['docbasic'] == null ? '0' : getDBholddata1[ji]['docbasic'].toString().replaceAll(',', '')), //doctotal

//           totalDue: double.parse(getDBholddata1[ji]['doctotal'] == null ? '0' : getDBholddata1[ji]['doctotal'].toString().replaceAll(',', '')),
//           totpaid: double.parse(getDBholddata1[ji]['amtpaid'] == null ? '0' : getDBholddata1[ji]['amtpaid'].toString().replaceAll(',', '')),
//         ),
//         item: scannData,
//         paymentway: payment);

//     notifyListeners();

//     salesmodl.add(salesM);

//     log("salesmodl.item.length:${salesM.item!.length}");
//     notifyListeners();
//     onPrintFilter = salesmodl;
//     notifyListeners();
//   }

//   filterListOnPrint(String v) {
//     if (v.isNotEmpty) {
//       onPrintFilter = salesmodl.where((e) => e.cardCode!.toLowerCase().contains(v.toLowerCase()) || e.custName!.toLowerCase().contains(v.toLowerCase()) || e.invoceDate!.toLowerCase().contains(v.toLowerCase())).toList();
//       notifyListeners();
//     } else if (v.isEmpty) {
//       onPrintFilter = salesmodl;
//       notifyListeners();
//     }
//   }

//   mapCallSalesInfoApiForPDF(preff, BuildContext context, int ih) async {
//     final Database db = (await DBHelper.getInstance())!;

//     List<Address>? address2 = [];
//     List<Address>? address25 = [];
//     List<InvoiceItem> itemsList = [];
//     List<CustomerAddressModelDB> csadresdataDB = await DBOperation.getCstmMasAddDB(
//       db,
//     );
//     for (int k = 0; k < csadresdataDB.length; k++) {
//       if (csadresdataDB[k].custcode.toString() == salesmodl[ih].cardCode.toString()) {
//         address2 = [
//           Address(
//               autoId: int.parse(csadresdataDB[k].autoid.toString()),
//               address1: csadresdataDB[k].address1,
//               address2: csadresdataDB[k].address2,
//               address3: csadresdataDB[k].address3,
//               custcode: csadresdataDB[k].custcode,
//               billCity: csadresdataDB[k].city!, //city
//               billCountry: csadresdataDB[k].countrycode!, //country
//               billPincode: csadresdataDB[k].pincode!, //pinno
//               billstate: csadresdataDB[k].statecode)
//         ];
//       }
//     }

//     for (int i = 0; i < salesmodl[ih].item!.length; i++) {
//       itemsList.add(InvoiceItem(
//         slNo: '${i + 1}',
//       
//         descripton: salesmodl[ih].item![i].ItemName,
//         netTotal: salesmodl[ih].item![i].netvalue.toString(),
//         unitPrice: salesmodl[ih].item![i].SellPrice.toString(),
//         quantity: salesmodl[ih].item![i].Qty.toString(),
//         dics: salesmodl[ih].item![i].discountper.toString(),
//         vat: salesmodl[ih].item![i].taxvalue.toString(),
//       ));
//     }
//     invoice = Invoice(
//       headerinfo: InvoiceHeader(
//           companyName: 'companyName',
//         
//           address: 'address',
//           area: 'area',
//           pincode: 'pincode',
//           mobile: 'mobile',
//           gstNo: 'gstNo',
//           salesOrder: 'salesOrder'),
//       invoiceMiddle: InvoiceMiddle(
//         date: salesmodl[ih].createdateTime.toString(),
//       
//         time: 'time',
//         customerName: salesmodl[ih].custName ?? '',
//         mobile: salesmodl[ih].phNo ?? '',
//         address: address2![0].address1!.isEmpty ? '' : address2[0].address1.toString(),
//         city: address2[0].billCity.isEmpty ? '' : address2[0].billCity.toString(),
//         area: address2[0].address3!.isEmpty ? '' : address2[0].address3.toString(),
//         pin: address2[0].billPincode.isEmpty ? '' : address2[0].billPincode.toString(),
//       ),
//     
//     
//     
//     
//     
//     
//     
//     
//     
//     
//     
//     
//     
//     
//     
//     
//       items: itemsList,
//     
//     );

//     notifyListeners();

//     log("invoice.items:::${invoice.items!.length}");
//     int length = invoice.items!.length;
//     if (length > 0) {
//       PdfInvoiceApiii.height = length + 19;
//       notifyListeners();
//     }
//     final pdfFile = await PdfInvoiceApiii.gennnerate(invoice);

//     PDFDocument doc = await PDFDocument.fromFile(pdfFile);
//     ShowPdfs.document = doc;
//     Navigator.push(context, MaterialPageRoute(builder: (context) => ShowPdf()));
//   
//   
//   
//     notifyListeners();
//   }
// }
