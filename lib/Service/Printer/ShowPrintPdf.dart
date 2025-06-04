// ignore_for_file: file_names, prefer_const_constructors
import 'dart:developer';
import 'dart:io';

import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';

class ShowPdf extends StatefulWidget {
  const ShowPdf({super.key});

  @override
  ShowPdfs createState() => ShowPdfs();
}

class ShowPdfs extends State<ShowPdf> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static PDFDocument? document;
  static String? docNO;
  static String? title;
  PDFDocument? document2;
  String name = '';
  String companyID = '';
  String? imei;
  List<XFile> files = <XFile>[];

  static bool notstream = true;
  @override
  void initState() {
    super.initState();
    setState(() {
      document2 = document;
    });
  }

  List<String> paths = [];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('PDF Viewer'),
        backgroundColor: theme.primaryColor,
        leading: Row(
          children: [
            InkWell(
              onTap: () async {
                if (notstream) {
                  DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());

                  files = [];
                  final tempDir =
                      await Directory('/storage/emulated/0/Download');

                  files.add(
                      XFile('${tempDir.path}/$title-$docNO.pdf', name: title));
                  log('direc: ${tempDir.path}/$title-$docNO.pdf');
                  paths.add('${tempDir.path}/$title-$docNO.pdf');

                  final filepath = File(files[0].path);
                  if (await filepath.exists()) {
                    await Share.shareXFiles(files);
                    paths.clear();
                  } else {
                    print('File not found: $filepath');
                  }
                } else {
                  log('$title:::::::::$title');
                  paths.add('$title');
                  await Share.shareXFiles(files);
                }
              },
              child: Icon(
                Icons.file_upload_outlined,
              ),
            ),
          ],
        ),
      ),
      key: _scaffoldKey,
      body: document2 == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return contentOfTab(context);
                },
              ),
            ),
    );
  }

  Container contentOfTab(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40, bottom: 10, left: 40, right: 40),
      child: PDFViewer(
        document: document2!,
      ),
    );
  }

  Center contentOfmobile(BuildContext context) {
    return Center(
      child: PDFViewer(
        document: document2!,
      ),
    );
  }

  SingleChildScrollView contentOfWeb(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: 250,
            height: 700,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.home),
                  onTap: () {},
                  title: Visibility(
                    maintainAnimation: true,
                    maintainState: true,
                    child: Text(
                      'DashBord',
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.contact_mail),
                  onTap: () {},
                  title: Visibility(
                    child: Text(
                      'Lead Book',
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.menu,
                  ),
                  onTap: () {},
                  title: Visibility(
                    child: Text(
                      'Follow Up',
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.leaderboard,
                  ),
                  onTap: () {},
                  title: Visibility(
                    child: Text(
                      'open Sale Bill',
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.print,
                  ),
                  onTap: () {},
                  title: Visibility(
                    child: Text('Printer Setting'),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.directions_walk_outlined,
                  ),
                  onTap: () {},
                  title: Visibility(child: Text('Walkin')),
                ),
                ListTile(
                  leading: Icon(Icons.unsubscribe_rounded),
                  onTap: () {},
                  title: Visibility(child: Text('User Details')),
                ),
                ListTile(
                  leading: Icon(
                    Icons.unsubscribe_rounded,
                  ),
                  onTap: () {},
                  title: Visibility(
                    child: Text('SalesPerson Details'),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.unsubscribe_rounded,
                  ),
                  onTap: () {},
                  title: Visibility(child: Text('Product MAster')),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: 500,
              height: 700,
              padding:
                  EdgeInsets.only(top: 40, bottom: 10, left: 40, right: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
