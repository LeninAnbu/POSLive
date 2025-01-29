import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Controller/SalesInvoice/SalesInvoiceController.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/Drawer.dart';
import '../../Controller/LocalizationController/Localization.dart';
import '../../l10n/l10n.dart';
import '../Sales Screen/Widgets/AppBar/AppBar.dart';

class SettingScreens extends StatefulWidget {
  const SettingScreens({
    super.key,
  });

  @override
  State<SettingScreens> createState() => SettingScreensState();
}

class SettingScreensState extends State<SettingScreens> {
  Locale? _selectedLocale; //= L10n.all.first;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _selectedLocale = Provider.of<LocaleProvider>(context).getSavedLocale();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final locale = Provider.of<LocaleProvider>(context);
    return Scaffold(
        drawer: naviDrawer(),
        body: ChangeNotifierProvider<PosController>(
            create: (context) => PosController(),
            builder: (context, child) {
              return Consumer<PosController>(
                  builder: (BuildContext context, prdSCD, Widget? child) {
                return LayoutBuilder(builder: (context, constraints) {
                  if (constraints.maxWidth <= 1168) {
                    return SizedBox(
                      width: Screens.width(context),
                      height: Screens.padingHeight(context),
                      child: Column(
                        children: [
                          appbar("Billing Screen", theme, context),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: L10n.all.map((locale) {
                              return RadioListTile(
                                value: locale,
                                activeColor: theme.primaryColor,
                                title: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Text(
                                        locale.languageCode,
                                        style: theme.textTheme.bodyMedium,
                                      )
                                    ],
                                  ),
                                ),
                                groupValue: _selectedLocale,
                                onChanged: (dynamic value) {
                                  setState(() {
                                    log("_selectedLocale $_selectedLocale");
                                    log("locale $locale");

                                    _selectedLocale = locale;
                                    // locale.setLocale(locale);
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      width: Screens.width(context),
                      height: Screens.padingHeight(context),
                      color: Colors.amber,
                    );
                  }
                });
              });
            }));
  }
}
