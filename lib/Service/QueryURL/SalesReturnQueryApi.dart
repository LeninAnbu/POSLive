import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import '../../Models/QueryUrlModel/SalesRetqueryModel.dart';

class SalesReturnQryApi {
  static Future<OpenSalesReturnModel> getGlobalData(
      String siteCode, String docNum) async {
    try {
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "Query":
                "EXEC BZ_POS_SalesReturnQryApi '${AppConstant.branch}','$docNum' "
                    // "Select distinct  A.DocEntry,A.DocNum, A.DocDate,A.DocTotal,A.CardCode,A.CardName,B.LineNum,B.ItemCode,Dscription,B.OpenQty,C.quantity,c.BatchNum,B.WhsCode,B.TaxCode,b.DiscPrcnt,b.PriceBefDi  from OINV A Join INV1 B on A.Docentry=B.docEntry Left Outer Join IBT1 C (nolock) On C.BaseEntry=A.DocEntry and C.BaseType=A.ObjType and C.ItemCode=B.ItemCode And B.LineNum =  C.BaseLinNum  Where A.DocStatus='O' and B.OpenQty>'0' and B.WhsCode='${AppConstant.branch}' and A.DocNum='$docNum' order by B.LineNum"
                // "Select T0.DocEntry, T0.DocNum,T0.CardCode , T0.CardName ,T0.DocDate, T1.LineNum, T1.ItemCode, T1.Dscription ItemName, T1.OpenQty, T1.PriceBefDi  From OINV T0 Inner Join INV1 T1 on T0.DocEntry = T1.DocEntry Where T0.DocStatus = 'O' And T1.LineStatus = 'O' And T1.OpenQty > 0 And T1.WhsCode = '${AppConstant.branch}' And T0.DocNum = '$docNum'"
              }));

//5030420
      // json.encode({
      // "constr":
      //     "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
      // "query":
      //       "Select  A.DocDate, A.DocEntry,A.DocNum,A.DocTotal,A.CardCode,A.CardName,B.LineNum,B.ItemCode,Dscription,B.OpenQty,c.BatchNum,B.WhsCode,B.TaxCode,b.DiscPrcnt,b.PriceBefDi  from OINV A Join INV1 B on A.Docentry=B.docEntry Left Outer Join IBT1 C (nolock) On C.BaseEntry=A.DocEntry and C.BaseType=A.ObjType and C.ItemCode=B.ItemCode  Where A.DocStatus='O' and B.OpenQty>'0' and B.WhsCode='$siteCode' and A.DocNum='$docNum'  order by B.LineNum"
      // }));
      log('sales ret query::${json.encode({
            "constr":
                "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
            "Query":
                "Select T0.DocEntry, T0.CardCode , T0.CardName , T1.LineNum, T1.ItemCode, T1.Dscription ItemName, T1.OpenQty  From OINV T0 Inner Join INV1 T1 on T0.DocEntry = T1.DocEntry Where T0.DocStatus = 'O' And T1.LineStatus = 'O' And T1.OpenQty > 0 And T1.WhsCode = '${AppConstant.branch}' And T0.DocNum = '$docNum'"
          })}');
      log("SalesReturn Res: ${json.decode(response.body)}");
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return OpenSalesReturnModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        // throw Exception("Error!!...");
        return OpenSalesReturnModel.fromJson(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log('message::${e.toString()}');
      //  throw Exception("Exception: $e");
      return OpenSalesReturnModel.error(e.toString(), 500);
    }
  }
}
