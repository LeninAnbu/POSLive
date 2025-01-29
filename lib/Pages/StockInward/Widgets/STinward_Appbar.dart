import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../Controller/StockInwardController/StockInwardContler.dart';
import 'package:posproject/Pages/StockInward/Widgets/Draftbillr.dart';
import 'package:posproject/Pages/StockInward/Widgets/SearchBox.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/ContentContainer.dart';
import '../../../Widgets/AlertBox.dart';

AppBar inwardAppbar(
  String titles,
  ThemeData theme,
  BuildContext context,
) {
  final theme = Theme.of(context);

  return AppBar(
    backgroundColor: theme.primaryColor,
    automaticallyImplyLeading: false,
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      },
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(titles),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                context.read<StockInwrdController>().searchInitMethod();
                context.read<StockInwrdController>().getSalesDataDatewise(
                    context.read<StockInwrdController>().config.alignDate(
                        context
                            .read<StockInwrdController>()
                            .config
                            .currentDate()),
                    context.read<StockInwrdController>().config.alignDate(
                        context
                            .read<StockInwrdController>()
                            .config
                            .currentDate()));
                // context.read<StockInwrdController>().getSalesDataDatewise(
                //     context.read<StockInwrdController>().config.alignDate(
                //         context
                //             .read<StockInwrdController>()
                //             .config
                //             .currentDate()),
                //     context.read<StockInwrdController>().config.alignDate(
                //         context
                //             .read<StockInwrdController>()
                //             .config
                //             .currentDate()));
                context.read<StockInwrdController>().callsearchInwApi();

                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          contentPadding: const EdgeInsets.all(0),
                          content: AlertBox(
                              payMent: 'Search',
                              buttonName: null,
                              widget: StInConSearhBox(
                                theme: theme,
                                searchHeight:
                                    Screens.bodyheight(context) * 0.77,
                                searchWidth: Screens.width(context),
                              )));
                    });
              },
              child: Column(
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: const Icon(Icons.search)),
                  Text(
                    'Search',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
            SizedBox(width: Screens.width(context) * 0.02),
            GestureDetector(
              onTap: () {
                if (context
                    .read<StockInwrdController>()
                    .savedraftBill
                    .isEmpty) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            contentPadding: EdgeInsets.zero,
                            content: AlertBox(
                              payMent: 'Draft bills',
                              buttonName: null,
                              widget: ContentContainer(
                                  content: "Draft bills", theme: theme),
                            ));
                      });
                } else {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            contentPadding: EdgeInsets.zero,
                            content: AlertBox(
                                payMent: 'Draft bills',
                                buttonName: null,
                                widget: StockInDraftbill(
                                    theme: theme,
                                    searchHeight:
                                        Screens.bodyheight(context) * 0.9,
                                    searchWidth: Screens.width(context) * 0.49,
                                    stockIn: context
                                        .watch<StockInwrdController>()
                                        .savedraftBill)));
                      });
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: const Icon(Icons.ballot_outlined)),
                  Text(
                    'Draft Bills',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
            SizedBox(width: Screens.width(context) * 0.02),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          contentPadding: const EdgeInsets.all(0),
                          content: AlertBox(
                            payMent: 'Stock Refresh',
                            buttonName: null,
                            widget: ContentContainer(
                                content: "Stock Refresh", theme: theme),
                          ));
                    });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: const Icon(Icons.autorenew_outlined)),
                  Text(
                    "Stock Refresh",
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
            SizedBox(width: Screens.width(context) * 0.02),
            GestureDetector(
              onTap: () async {
                context.read<StockInwrdController>().onDisablebutton = true;

                SharedPreferences preff = await SharedPreferences.getInstance();
                if (context
                    .read<StockInwrdController>()
                    .stockInward2
                    .isNotEmpty) {
                  await context
                      .read<StockInwrdController>()
                      .callPrintApi(context, theme);
                  context.read<StockInwrdController>().setstatemethod();
                } else {
                  // .mapCallInwardForPDF(preff, context, theme);
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            contentPadding: const EdgeInsets.all(0),
                            content: AlertBox(
                              payMent: 'Alert',
                              buttonName: null,
                              widget: ContentContainer(
                                  content: "Kindly choose document",
                                  theme: theme),
                            ));
                      });
                }
              },
              child: Column(
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: const Icon(Icons.print_outlined)),
                  Text(
                    'Printers',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
            SizedBox(width: Screens.width(context) * 0.02),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          contentPadding: const EdgeInsets.all(0),
                          content: AlertBox(
                            payMent: 'Access Til',
                            buttonName: null,
                            widget: ContentContainer(
                                content: "Access Til", theme: theme),
                          ));
                    });
              },
              child: Column(
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: const Icon(Icons.auto_mode_outlined)),
                  Text(
                    'Access Til',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
            SizedBox(width: Screens.width(context) * 0.02),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          contentPadding: const EdgeInsets.all(0),
                          content: AlertBox(
                            payMent: 'Dual Screen',
                            buttonName: null,
                            widget: ContentContainer(
                                content: "Dual Screen", theme: theme),
                          ));
                    });
              },
              child: Column(
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: const Icon(Icons.screenshot_outlined)),
                  Text('Dual Screen',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white))
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
