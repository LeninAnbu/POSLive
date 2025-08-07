import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../Controller/DashBoardController/DashboardController.dart';

class StockTable extends StatelessWidget {
  StockTable({
    super.key,
    required this.theme,
    required this.dbWidth,
    required this.dbHeight,
  });
  double dbHeight;
  double dbWidth;

  ThemeData theme;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(
          dbHeight * 0.02,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        height: dbHeight * 1.3,
        width: dbWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: dbHeight * 0.02),
              child: Text(
                "Out Of Stock Item",
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: dbHeight * 0.02),
            Container(
              color: theme.primaryColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: theme.primaryColor,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Text(
                      "S.No",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      color: theme.primaryColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 1),
                      child: Text(
                        "Item",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    color: theme.primaryColor,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Text(
                      "Quantity",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: context.watch<DashBoardController>().outOfstock.isEmpty &&
                      context.watch<DashBoardController>().outOfstockBool ==
                          false
                  ? const Center(
                      child: Text("No data..!!"),
                    )
                  : context.watch<DashBoardController>().outOfstock.isEmpty &&
                          context.watch<DashBoardController>().outOfstockBool ==
                              true
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: context
                              .watch<DashBoardController>()
                              .outOfstock
                              .length,
                          itemBuilder: (context, index) {
                            return Card(
                                margin: EdgeInsets.all(1.5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(
                                    dbHeight * 0.01,
                                  ),
                                  width: dbWidth * 0.9,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        width: dbWidth * 0.06,
                                        child: Text('${index + 1}',
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(fontSize: 16)),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: dbWidth * 0.7,
                                            child: Text(
                                              "${context.watch<DashBoardController>().outOfstock[index].itemname}",
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: dbWidth * 0.09,
                                        child: Text(
                                          '${context.watch<DashBoardController>().outOfstock[index].qty}',
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                          }),
            ),
          ],
        ),
      ),
    );
  }
}
