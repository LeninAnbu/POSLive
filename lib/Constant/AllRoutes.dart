import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:posproject/Pages/Customer/Screens/Screens.dart';
import 'package:posproject/Pages/ReconciliationPage/Screens/Screens.dart';
import 'package:posproject/Pages/Settlement/Screens/SettlementScreen.dart';
import 'package:posproject/Pages/TransactionSync/Screens/TranscationSyncPage.dart';
import '../Pages/ApiSettings/TabScreen/TabApiSettingScreen.dart';
import '../Pages/CashStatement/CashStatement/screens/CashStatement.dart';
import '../Pages/DashBoard/Screens/DashBoardScreen.dart';
import '../Pages/DownloadPage/Screens.dart';
import '../Pages/Expenses/ExpenseScreen.dart';
import '../Pages/NotificationPage/Screens/Screenss.dart';
import '../Pages/NumberingSeriesPage/Screens/Screens.dart';
import '../Pages/PaymentReceipt/Screens/Screens.dart';
import '../Pages/PendingOrder/Screens/Screens.dart';
import '../Pages/Refunds/Screens/Screens.dart';
import '../Pages/ReturnRegister/ReturnRegister/screens/ReturnRegister.dart';
import '../Pages/Sales Screen/Screens/Screens.dart';
import '../Pages/SalesOrder/Screens/screens.dart';
import '../Pages/SalesQuotation/Screens/Screens.dart';
import '../Pages/SalesRegister/screens/SalesRegister.dart';
import '../Pages/SalesReturn/Screens.dart';
import '../Pages/Stock Replenish/Screens/Screens.dart';
import '../Pages/StockInward/Screens/Screens.dart';
import '../Pages/StockOutward/Screens/Screens.dart';
import '../Pages/StockRequest/Screens/Screens.dart';
import '../Pages/StocksCheck/Screens/Screens.dart';
import '../Service/Printer/ShowPrintPdf.dart';
import 'ConstantRoutes.dart';

class Routes {
  static List<GetPage> allRoutes = [
    GetPage<dynamic>(
        name: ConstantRoutes.dashboard,
        page: () => const DashBoardScreen(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.sales,
        page: () => const PosMainScreens(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.salesReturn,
        page: () => const SalesReturnScreens(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.paymentReciept,
        page: () => const PaymentReceiptScreens(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.stockRequest,
        page: () => const StockReqScreens(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.stockInward,
        page: () => const StockInwardScreens(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),

    //Resource

    GetPage<dynamic>(
        name: ConstantRoutes.stockOutward,
        page: () => const StockOutwardScreens(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.expence,
        page: () => const ExpenseScreen(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.deposits,
        page: () => const DepositScreen(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),

    GetPage<dynamic>(
        name: ConstantRoutes.salesOrder,
        page: () => const SalesOrderScreens(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.stockCheck,
        page: () => const StockCheckMainScreens(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
    // StockReplenishMainScreens
    GetPage<dynamic>(
        name: ConstantRoutes.stockReplenish,
        page: () => const StockReplenishMainScreens(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
    // DownloadPage
    GetPage<dynamic>(
        name: ConstantRoutes.downloadPage,
        page: () => const DownloadScreen(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.stockRegister,
        page: () => const SalesRegisterScreens(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.retrurnRegister,
        page: () => const RetRegisterScreens(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.cashStatement,
        page: () => const CashSatementScreens(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.pendingOrders,
        page: () => const PendingOrderScreens(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.customer,
        page: () => const CustomerMainScreens(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.refunds,
        page: () => const RefundScreens(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.apiSettings,
        page: () => const TabApiSettingsScreen(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.salesQuotation,
        page: () => const SalesQuotationScreens(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.syncdataPage,
        page: () => const TransactionSyncScreen(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.numberSeris,
        page: () => const NumberingScreens(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.reconciliation,
        page: () => const ReconciliationScreens(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
    GetPage<dynamic>(
      name: ConstantRoutes.showPdf,
      page: () => ShowPdf(),
    ),
    GetPage<dynamic>(
      name: ConstantRoutes.notification,
      page: () => NotificationMainScreens(),
    ),
  ];
}
