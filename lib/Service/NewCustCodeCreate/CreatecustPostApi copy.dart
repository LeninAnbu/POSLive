import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import 'package:posproject/Models/Service%20Model/CustomerModel/CreateCustPostModel.dart';
import 'package:posproject/url/url.dart';

class PostCustCreateAPi {
  static Future<CreateCustPostModel> getGlobalData(
    NewCutomerModel newCutomerModel,
  ) async {
    try {
      log("http://102.69.167.106:50001/b1s/v1/BusinessPartners");
      final response = await http.post(
        Uri.parse("${URL.sapUrl}/BusinessPartners"),
        headers: {
          'content-type': 'application/json',
          "cookie": 'B1SESSION=${AppConstant.sapSessionID}'
        },
        body: newCutomerModel.cardCode == null
            ? json.encode({
                "CardName": "${newCutomerModel.cardName}",
                "CardType": "cCustomer",
                "GroupCode": newCutomerModel.grupCode,
                "FederalTaxID": newCutomerModel.federalTaxID,
                "AdditionalID": newCutomerModel.additionalID,
                "Territory": newCutomerModel.territory,
                "Cellular": newCutomerModel.cellular,
                "SalesPersonCode": newCutomerModel.salesPersonCode,
                "ContactPerson": newCutomerModel.contactPerson,
                "CreditLimit": newCutomerModel.creditLimit,
                "Notes": newCutomerModel.notes,
                "PayTermsGrpCode": newCutomerModel.payTermsGrpCod,
                "Series": newCutomerModel.series,
                "U_TinCer": newCutomerModel.tincer,
                "U_VatCer": newCutomerModel.vatcer,
                "BPAddresses": newCutomerModel.newModel!
                    .map(
                      (e) => e.tojson(),
                    )
                    .toList(),
                "ContactEmployees":
                    newCutomerModel.contEmp!.map((e) => e.tojson()).toList()
              })
            : json.encode({
                "CardCode": "${newCutomerModel.cardCode}",
                "CardName": "${newCutomerModel.cardName}",
                "CardType": "cCustomer",
                "GroupCode": newCutomerModel.grupCode,
                "FederalTaxID": newCutomerModel.federalTaxID,
                "AdditionalID": newCutomerModel.additionalID,
                "Territory": newCutomerModel.territory,
                "Cellular": newCutomerModel.cellular,
                "SalesPersonCode": newCutomerModel.salesPersonCode,
                "ContactPerson": newCutomerModel.contactPerson,
                "CreditLimit": newCutomerModel.creditLimit,
                "Notes": newCutomerModel.notes,
                "PayTermsGrpCode": newCutomerModel.payTermsGrpCod,
                "Valid": "tNO",
                "Frozen": "tYES",
                "Series": newCutomerModel.series,
                "U_TinCer": newCutomerModel.tincer,
                "U_VatCer": newCutomerModel.vatcer,
                "BPAddresses": newCutomerModel.newModel!
                    .map(
                      (e) => e.tojson(),
                    )
                    .toList(),
                "ContactEmployees":
                    newCutomerModel.contEmp!.map((e) => e.tojson()).toList()
              }),
      );

      log(
        newCutomerModel.cardCode == null
            ? json.encode({
                "CardName": "${newCutomerModel.cardName}",
                "CardType": "cCustomer",
                "GroupCode": newCutomerModel.grupCode,
                "FederalTaxID": newCutomerModel.federalTaxID,
                "AdditionalID": newCutomerModel.additionalID,
                "Territory": newCutomerModel.territory,
                "Cellular": newCutomerModel.cellular,
                "SalesPersonCode": newCutomerModel.salesPersonCode,
                "ContactPerson": newCutomerModel.contactPerson,
                "CreditLimit": newCutomerModel.creditLimit,
                "Notes": newCutomerModel.notes,
                "PayTermsGrpCode": newCutomerModel.payTermsGrpCod,
                "Valid": "tNO",
                "Frozen": "tYES",
                "Series": newCutomerModel.series,
                "U_TinCer": newCutomerModel.tincer,
                "U_VatCer": newCutomerModel.vatcer,
                "BPAddresses": newCutomerModel.newModel!
                    .map(
                      (e) => e.tojson(),
                    )
                    .toList(),
                "ContactEmployees":
                    newCutomerModel.contEmp!.map((e) => e.tojson()).toList()
              })
            : json.encode({
                "CardCode": "${newCutomerModel.cardCode}",
                "CardName": "${newCutomerModel.cardName}",
                "CardType": "cCustomer",
                "GroupCode": newCutomerModel.grupCode,
                "FederalTaxID": newCutomerModel.federalTaxID,
                "AdditionalID": newCutomerModel.additionalID,
                "Territory": newCutomerModel.territory,
                "Cellular": newCutomerModel.cellular,
                "SalesPersonCode": newCutomerModel.salesPersonCode,
                "ContactPerson": newCutomerModel.contactPerson,
                "CreditLimit": newCutomerModel.creditLimit,
                "Notes": newCutomerModel.notes,
                "PayTermsGrpCode": newCutomerModel.payTermsGrpCod,
                "Valid": "tNO",
                "Frozen": "tYES",
                "Series": newCutomerModel.series,
                "BPAddresses": newCutomerModel.newModel!
                    .map(
                      (e) => e.tojson(),
                    )
                    .toList(),
                "ContactEmployees":
                    newCutomerModel.contEmp!.map((e) => e.tojson()).toList()
              }),
      );

      log("Customer Code Creation:${json.decode(response.body)}");
      if (response.statusCode == 200) {
        log("Success");
        return CreateCustPostModel.fromJson(response.body, response.statusCode);
      } else {
        log("Exception11");

        return CreateCustPostModel.fromJson(response.body, response.statusCode);
      }
    } catch (e) {
      log("Exception22");

      return CreateCustPostModel.fromJson(e.toString(), 500);
    }
  }
}

class NewCutomerModel {
  String? tincer;
  String? vatcer;
  String? cardCode;
  String? cardName;
  int? grupCode;
  String? federalTaxID;
  String? additionalID;
  int? territory;
  String? cellular;
  int? salesPersonCode;
  String? contactPerson;
  int? creditLimit;
  String? notes;
  int? payTermsGrpCod;
  String? valid;
  int? series;
  List<NewCutomeAdrsModel>? newModel;
  List<ContactEmployees>? contEmp;
  NewCutomerModel({
    this.cardName,
    this.grupCode,
    this.cardCode,
    this.newModel,
    this.additionalID,
    this.cellular,
    this.contactPerson,
    this.creditLimit,
    this.federalTaxID,
    this.notes,
    this.payTermsGrpCod,
    this.salesPersonCode,
    this.series,
    this.territory,
    this.valid,
    this.contEmp,
    this.tincer,
    this.vatcer,
  });
}

class NewCutomeAdrsModel {
  String? addressName;
  String? street;
  String? zipCode;
  String? city;
  String? country;
  String? state;
  String? addressType;
  String? addressName2;
  String? addressName3;

  NewCutomeAdrsModel({
    this.addressName,
    this.addressName2,
    this.addressName3,
    this.addressType,
    this.city,
    this.country,
    this.state,
    this.street,
    this.zipCode,
  });
  Map<String, dynamic> tojson() {
    Map<String, dynamic> data = {
      "AddressName": addressName,
      "Street": street,
      "ZipCode": zipCode,
      "City": city,
      "Country": country,
      "State": state,
      "AddressType": addressType,
      "AddressName2": addressName2,
      "AddressName3": addressName3
    };

    return data;
  }
}

class ContactEmployees {
  String? name;
  ContactEmployees({
    required this.name,
  });

  Map<String, dynamic> tojson() {
    Map<String, dynamic> data = <String, dynamic>{
      "Name": name,
    };
    return data;
  }
}
