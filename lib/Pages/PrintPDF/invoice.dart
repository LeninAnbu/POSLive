class Invoice {
  final InvoiceHeader? headerinfo;
  final InvoiceMiddle? invoiceMiddle;
  final InvoiceCash? invoiceCash;
  final List<InvoiceItem>? items;

  const Invoice({
    this.headerinfo,
    this.invoiceMiddle,
    this.invoiceCash,
    this.items,
  });
}

class InvoiceHeader {
  final String? companyName;
  final String? custcode;
  final String? docEntry;

  final String? invNum;
  final String? invDate;
  final String? reqFrom;
  final String? reqTo;
  final String? address;
  final String? area;
  final String? pincode;
  final String? mobile;
  final String? gstNo;
  final String? tincode;
  final String? vatNo;
  final String? salesOrder;
  final String? ordReference;
  final String? U_rctCde;
  final String? U_QRPath;
  final String? U_QRValue;
  final String? U_VfdIn;
  final String? U_Zno;
  final String? U_idate;
  final String? U_itime;
  const InvoiceHeader({
    this.custcode,
    this.invDate,
    this.invNum,
    this.reqFrom,
    this.reqTo,
    this.docEntry,
    this.companyName,
    this.address,
    this.area,
    this.pincode,
    this.tincode,
    this.vatNo,
    this.mobile,
    this.gstNo,
    this.salesOrder,
    this.ordReference,
    this.U_QRPath,
    this.U_QRValue,
    this.U_VfdIn,
    this.U_Zno,
    this.U_idate,
    this.U_itime,
    this.U_rctCde,
  });
}

class InvoiceMiddle {
  final String? date;
  final String? time;
  final String? customerName;
  final String? mobile;
  final String? address;
  final String? city;
  final String? area;
  final String? pin;
  final String? tinNo;
  final String? vatNo;
  final String? printerName;
  final String? paymentTerms;

  const InvoiceMiddle(
      {this.date,
      this.time,
      this.customerName,
      this.mobile,
      this.address,
      this.printerName,
      this.city,
      this.paymentTerms,
      this.area,
      this.tinNo,
      this.vatNo,
      this.pin});
}

class InvoiceItem {
  double? basic;
  String? itemcode;

  double? discountamt;
  final String? slNo;
  final String? descripton;
  final double? unitPrice;
  double? netTotal;
  final double? quantity;
  double? dics;
  final double? vat;
  int? pails;
  int? cartons;
  double? tax;
  double? looseTins;
  double? tonnage;
  int? totalPack;
  double? uPackSize;
  InvoiceItem({
    this.itemcode,
    this.tax,
    this.pails,
    this.cartons,
    this.looseTins,
    this.tonnage,
    this.totalPack,
    this.slNo,
    this.discountamt,
    this.basic,
    this.descripton,
    this.netTotal,
    this.unitPrice,
    this.quantity,
    this.dics,
    this.vat,
  });
}

class InvoiceCash {
  final String? cash;
  final String? card1;
  final String? card2;
  final String? exchange;
  final String? finance;
  final String? cod;
  final String? credit;
  final String? total;
  final String? advance;
  final String? discountamt;
  final String? salesEmployee;
  final String? remarks;
  final String? upiAmnt;
  final String? deliverydate;
  final String? deliveryTime;
  const InvoiceCash({
    this.upiAmnt,
    this.remarks,
    this.advance,
    this.discountamt,
    this.cash,
    this.card1,
    this.card2,
    this.exchange,
    this.finance,
    this.cod,
    this.credit,
    this.total,
    this.salesEmployee,
    this.deliveryTime,
    this.deliverydate,
  });
}
