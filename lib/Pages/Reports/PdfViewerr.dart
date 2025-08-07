import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:posproject/Pages/Reports/PDFHelper.dart';
import 'package:printing/printing.dart';

class CollectionReceiptPdf extends StatefulWidget {
  const CollectionReceiptPdf({super.key});

  @override
  State<CollectionReceiptPdf> createState() => CollectionReceiptPdfState();
}

class CollectionReceiptPdfState extends State<CollectionReceiptPdf> {
  final pdf = pw.Document();

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  var name;
  var subject1;
  var subject2;
  var subject3;
  var marks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PdfPreview(
          initialPageFormat: PdfPageFormat.a4,
          dynamicLayout: true,
          onPageFormatChanged: (PdfPageFormat) {},
          build: (format) {
            return CollectionReceiptPdfHelper.generatePdff(
                format, 'title', context);
          }),
    );
  }
}
