import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/catalouge/catalouge_list_view.dart';
import 'package:digitalerp/change_company/change_company_view.dart';
import 'package:digitalerp/download_document_management/download_documents_view.dart';
import 'package:digitalerp/home_view_new.dart';
import 'package:digitalerp/lead%20management/lead_management_view.dart';
import 'package:digitalerp/new_menu_defalut_screen.dart';
import 'package:digitalerp/orderfollowup/order_followup_view.dart';
import 'package:digitalerp/payment_request/payment_request_screen.dart';
import 'package:digitalerp/performace_management/performace_view.dart';
import 'package:digitalerp/screen/ui/fotgot_password/forgot_pass_otp/forgot_pass_otp_view.dart';
import 'package:digitalerp/screen/ui/fotgot_password/forgot_pass_otp/reset_password/reset_password_view.dart';
import 'package:digitalerp/screen/ui/fotgot_password/forgot_password_view.dart';
import 'package:digitalerp/screen/ui/graph/all_graph_screen.dart';
import 'package:digitalerp/screen/ui/home/Image/image_detail/image_detail_view.dart';
import 'package:digitalerp/screen/ui/home/Image/image_preview/image_preview_view.dart';
import 'package:digitalerp/screen/ui/home/Image/image_preview_cam/image_preview_cam_view.dart';
import 'package:digitalerp/screen/ui/home/Image/image_view.dart';
import 'package:digitalerp/screen/ui/home/account_module/account_module_view.dart';
import 'package:digitalerp/screen/ui/home/account_module/collection/collection_view.dart';
import 'package:digitalerp/screen/ui/home/account_module/contra/contra_view.dart';
import 'package:digitalerp/screen/ui/home/account_module/expenses/expsenes_view.dart';
import 'package:digitalerp/screen/ui/home/account_module/journal_entry/journal_entry_view.dart';
import 'package:digitalerp/screen/ui/home/account_module/list/list_with_filter_view.dart';
import 'package:digitalerp/screen/ui/home/account_module/outstanding/outstanding_view.dart';
import 'package:digitalerp/screen/ui/home/account_module/party_ledger/party_transactions_view.dart';
import 'package:digitalerp/screen/ui/home/account_module/payment_entry/payment_entry_view.dart';
import 'package:digitalerp/screen/ui/home/account_module/receipt_entry/receipt_entry_view.dart';
import 'package:digitalerp/screen/ui/home/add_company/add_company_view.dart';
import 'package:digitalerp/screen/ui/home/approval/approval_list/approval_list_Screen.dart';
import 'package:digitalerp/screen/ui/home/approval_management/approval_hub_screens/approval_hub_dashboard.dart';
import 'package:digitalerp/screen/ui/home/attendance/approved_or_rejected_leave_view/approve_or_rejected_leaves_view.dart';
import 'package:digitalerp/screen/ui/home/attendance/attendance_list/attendance_list_view.dart';
import 'package:digitalerp/screen/ui/home/attendance/attendance_view.dart';
import 'package:digitalerp/screen/ui/home/attendance/leave_apply_view/leave_apply_view.dart';
import 'package:digitalerp/screen/ui/home/attendance/leave_history_view/leave_history_view.dart';
import 'package:digitalerp/screen/ui/home/cart/cart_view.dart';
import 'package:digitalerp/screen/ui/home/cart/your_order/order_place_success/order_placed_view.dart';
import 'package:digitalerp/screen/ui/home/cart/your_order/select_company/select_company_view.dart';
import 'package:digitalerp/screen/ui/home/cart/your_order/your_order_view.dart';
import 'package:digitalerp/screen/ui/home/customer_list/customer_list_view.dart';
import 'package:digitalerp/screen/ui/home/dashboard/dashboard_view.dart';
import 'package:digitalerp/screen/ui/home/dashboard/map/map_view.dart';
import 'package:digitalerp/screen/ui/home/drawer/profile/profile_view.dart';
import 'package:digitalerp/screen/ui/home/executive_list/executive_attendance/approved_or_rejected_leave_view/approve_or_rejected_leaves_view.dart';
import 'package:digitalerp/screen/ui/home/executive_list/executive_attendance/executive_attendance_list/executive_attendance_list_view.dart';
import 'package:digitalerp/screen/ui/home/executive_list/executive_attendance/executive_attendance_view.dart';
import 'package:digitalerp/screen/ui/home/executive_list/executive_list_view.dart';
import 'package:digitalerp/screen/ui/home/home_view.dart';
import 'package:digitalerp/screen/ui/home/indent/indent_screens/indent_list_screen.dart';
import 'package:digitalerp/screen/ui/home/issue%20item/issue_item_screens/issue_item_list_screen.dart';
import 'package:digitalerp/screen/ui/home/mis_module/attendance_report/attendance_report_view.dart';
import 'package:digitalerp/screen/ui/home/mis_module/mis_module_view.dart';
import 'package:digitalerp/screen/ui/home/mis_module/mis_order/mis_order_view.dart';
import 'package:digitalerp/screen/ui/home/mis_module/mis_outstanding/mis_outstanding_view.dart';
import 'package:digitalerp/screen/ui/home/mis_module/pending_shipping/pending_shipping_view.dart';
import 'package:digitalerp/screen/ui/home/mis_module/print_report/print_report_view.dart';
import 'package:digitalerp/screen/ui/home/mis_module/stock_report/stock_report_view.dart';
import 'package:digitalerp/screen/ui/home/mrn/screens/add_mrn_screen.dart';
import 'package:digitalerp/screen/ui/home/mrn/screens/mrn_list_screen.dart';
import 'package:digitalerp/screen/ui/home/mrn_module/mrn_entry_view.dart';
import 'package:digitalerp/screen/ui/home/mrn_module/mrn_screens/mrn_list_screen.dart';
import 'package:digitalerp/screen/ui/home/order/order_detail/order_detail_view.dart';
import 'package:digitalerp/screen/ui/home/order/order_list/order_list_view.dart';
import 'package:digitalerp/screen/ui/home/order/order_view.dart';
import 'package:digitalerp/screen/ui/home/order/select_brand/select_brand_view.dart';
import 'package:digitalerp/screen/ui/home/order/select_category/product_list/product_details/product_details_view.dart';
import 'package:digitalerp/screen/ui/home/order/select_category/product_list/product_list_view.dart';
import 'package:digitalerp/screen/ui/home/order/select_category/select_category_view.dart';
import 'package:digitalerp/screen/ui/home/reimbursements/Add/add_reimbursement_screen.dart';
import 'package:digitalerp/screen/ui/home/reimbursements/reimbursement_screen.dart';
import 'package:digitalerp/screen/ui/home/visit_plan/new_visit_planing/new_visit_planing_view.dart';
import 'package:digitalerp/screen/ui/home/visit_plan/new_visit_planing/preview/preview_view.dart';
import 'package:digitalerp/screen/ui/home/visit_plan/visit_plan_detail/stock_taking_view/stock_taking_view.dart';
import 'package:digitalerp/screen/ui/home/visit_plan/visit_plan_detail/visit_plan_detail_view.dart';
import 'package:digitalerp/screen/ui/home/visit_plan/visit_plan_view.dart';
import 'package:digitalerp/screen/ui/login/login_view.dart';
import 'package:digitalerp/screen/ui/otp/otp_view.dart';
import 'package:digitalerp/screen/ui/setup/setup_view.dart';
import 'package:digitalerp/screen/ui/splash/splash_view.dart';
import 'package:digitalerp/stock%20_reconcillation/stock_reconciliation.dart';
import 'package:digitalerp/task%20management/task_list_view.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:get/get.dart';

import '../payment_request/payment request detail/payment_request_detail_controller.dart';
import '../payment_request/payment request detail/payment_request_detail_screen.dart';
import '../payment_request/payment request list/payment_request_list_screen.dart';
import '../screen/ui/home/approval_management/approval_hub_screens/approval_hub_list.dart';
import '../screen/ui/home/grn/grn_screens/grn_list_screen.dart';
import '../screen/ui/home/indent/indent_controller/indent_list_controller.dart';
import '../screen/ui/home/mrn_qc/mrn_qc_list/mrn_qc_list_screen.dart';
import '../screen/ui/home/mrn_qc/mrn_qc_screens/mrn_qc_screen.dart';
import '../task management/create_task/create_task_screen.dart';

class AppPages {
  static const initial = AppRoutes.splash;

  static List<GetPage> routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardView(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.otp,
      page: () => const OtpView(),
    ),
    GetPage(
      name: AppRoutes.setupProfile,
      page: () => const SetupView(),
    ),
    GetPage(
      name: AppRoutes.map,
      page: () => const MapView(),
    ),
    GetPage(
      name: AppRoutes.attendance,
      page: () => AttendanceView(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeView(),
    ),
    GetPage(
      name: AppRoutes.leaveApply,
      page: () => LeaveApplyView(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.forgotPassOtp,
      page: () => const ForgotPassOtpView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => const ResetPasswordView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.visitPlanDetail,
      page: () => const VisitPlanDetailView(),
    ),
    GetPage(
      name: AppRoutes.visitPlan,
      page: () => const VisitPlanView(),
    ),
    GetPage(
      name: AppRoutes.approvedOrLeaveView,
      page: () => const ApprovedOrRejectedLeaveView(),
    ),
    GetPage(
      name: AppRoutes.executiveApprovedOrLeaveView,
      page: () => const ExecutiveApprovedOrRejectedLeaveView(),
    ),
    GetPage(
      name: AppRoutes.stockTakingView,
      page: () => const StockTakingView(),
    ),
    GetPage(
      name: AppRoutes.newVisitPlaning,
      page: () => const NewVisitPlaningView(),
    ),
    GetPage(
      name: AppRoutes.preview,
      page: () => const PreviewView(),
    ),
    GetPage(
      name: AppRoutes.partyList,
      page: () => const CustomerListView(),
    ),
    GetPage(
      name: AppRoutes.orderDetail,
      page: () => const OrderDetailView(),
    ),
    GetPage(
      name: AppRoutes.imageDetail,
      page: () => const ImageDetailView(),
    ),
    GetPage(
      name: AppRoutes.paymentEntry,
      page: () =>
          const PaymentEntryView(isPayment: true, title: 'Payment Entry'),
    ),
    GetPage(
      name: AppRoutes.receiptEntry,
      page: () => const ReceiptEntryView(),
    ),
    GetPage(
      name: AppRoutes.collection,
      page: () => const CollectionView(),
    ),
    GetPage(
      name: AppRoutes.expense,
      page: () => const ExpensesView(),
    ),
    GetPage(
      name: AppRoutes.outstanding,
      page: () => OutstandingView(),
    ),
    GetPage(
      name: AppRoutes.contra,
      page: () => const ContraView(),
    ),
    GetPage(
      name: AppRoutes.journalEntry,
      page: () => const JournalEntryView(),
    ),
    GetPage(
      name: AppRoutes.partyTransactions,
      page: () => const PartyTransactionsView(),
    ),
    GetPage(
      name: AppRoutes.attendanceList,
      page: () => const AttendanceListView(),
    ),
    GetPage(
      name: AppRoutes.executiveAttendanceList,
      page: () => const ExecutiveAttendanceListView(),
    ),
    GetPage(
      name: AppRoutes.orderList,
      page: () => const OrderListView(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
    ),
    GetPage(
      name: AppRoutes.addCompany,
      page: () => const AddCompanyView(),
    ),
    GetPage(
      name: AppRoutes.imagePreview,
      page: () => const ImagePreviewView(),
    ),
    GetPage(
      name: AppRoutes.imagePreviewCam,
      page: () => const ImagePreviewCamView(),
    ),
    GetPage(
      name: AppRoutes.orderPlaced,
      page: () => const OrderPlacedView(),
    ),
    GetPage(
      name: AppRoutes.selectCompany,
      page: () => const SelectCompanyView(),
    ),
    GetPage(
      name: AppRoutes.yourOrder,
      page: () => const YourOrderView(),
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => const CartView(),
    ),
    GetPage(
      name: AppRoutes.productDetails,
      page: () => const ProductDetailsView(),
    ),
    GetPage(
      name: AppRoutes.productList,
      page: () => const ProductListView(),
    ),
    GetPage(
      name: AppRoutes.selectBrand,
      page: () => const SelectBrandView(),
    ),
    GetPage(
      name: AppRoutes.selectCategory,
      page: () => const SelectCategoryView(),
    ),
    GetPage(
      name: AppRoutes.leaveHistory,
      page: () => const LeaveHistoryView(),
    ),
    GetPage(
      name: AppRoutes.executiveAttendance,
      page: () => const ExecutiveAttendanceView(),
    ),
    GetPage(
      name: AppRoutes.executiveListView,
      page: () => const ExecutiveListView(),
    ),
    GetPage(
      name: AppRoutes.accountModule,
      page: () => const AccountModuleView(),
    ),
    GetPage(
      name: AppRoutes.entry,
      page: () => const ListWithFilterView(),
    ),
    GetPage(
      name: AppRoutes.misOutstanding,
      page: () => const MisOutstandingView(),
    ),
    GetPage(
        name: AppRoutes.misDayBook,
        page: () => const PrintReportView(
              reportType: ReportType.dayBook,
            )),
    GetPage(
      name: AppRoutes.misAccountRegister,
      page: () => const PrintReportView(reportType: ReportType.accountRegister),
    ),
    GetPage(
      name: AppRoutes.misBalanceSheet,
      page: () => const PrintReportView(
        reportType: ReportType.balanceSheet,
      ),
    ),
    GetPage(
      name: AppRoutes.misProfitLoss,
      page: () => const PrintReportView(
        reportType: ReportType.profitAndLoss,
      ),
    ),
    GetPage(
      name: AppRoutes.misTrialBalance,
      page: () => const PrintReportView(
        reportType: ReportType.trialBalance,
      ),
    ),
    GetPage(
      name: AppRoutes.misPendingShipping,
      page: () => const PendingShippingView(),
    ),
    GetPage(
      name: AppRoutes.misAttendanceReport,
      page: () => const AttendanceReportView(),
    ),
    GetPage(
      name: AppRoutes.misOrderReport,
      page: () => const MisOrderView(),
    ),
    GetPage(
      name: AppRoutes.misStockReport,
      page: () => const StockReportView(),
    ),
    GetPage(
      name: AppRoutes.misModule,
      page: () => const MisModuleView(),
    ),
    GetPage(
      name: AppRoutes.changeCompany,
      page: () => const ChangeCompanyView(),
    ),
    GetPage(
      name: AppRoutes.performance,
      page: () => const PerformanceView(),
    ),
    GetPage(
      name: AppRoutes.catalougeListView,
      page: () => const CatalougeListView(),
    ),
    GetPage(
      name: AppRoutes.homeNew,
      page: () => const HomeViewNew(),
    ),
    GetPage(
      name: AppRoutes.approvalHub,
      page: () => const ApprovalHubDashboard(),
    ),
    GetPage(
      name: AppRoutes.taskManagement,
      page: () => const TaskListView(),
    ),
    GetPage(
      name: AppRoutes.documentDownload,
      page: () => DownloadDocumentsView(),
    ),
    GetPage(
      name: AppRoutes.orderFollowup,
      page: () => const OrderFollowupView(),
    ),
    GetPage(
      name: AppRoutes.orderView,
      page: () => const OrderView(),
    ),
    GetPage(
      name: AppRoutes.imageView,
      page: () => const ImageView(),
    ),
    GetPage(
      name: AppRoutes.leadManagement,
      page: () => const LeadManagementView(),
    ),
    GetPage(
      name: AppRoutes.stockReconcillation,
      page: () => StockReconciliation(),
    ),
    GetPage(
      name: AppRoutes.paymentRequestListScreen,
      page: () => PaymentRequestListScreen(),
      binding: PaymentRequestListBinding(),
    ),
    GetPage(
      name: AppRoutes.paymentRequestDetailScreen,
      page: () => const PaymentRequestDetailScreen(),
      // no binding — controller manually put before navigation
    ),
    GetPage(
      name: AppRoutes.mrnScreen,
      page: () => MrnListScreen(),
    ),
    // GetPage(
    //   name: AppRoutes.addMRN,
    //   page: () => AddMRNScreen(),
    // ),
    // GetPage(
    //   name: AppRoutes.materialReceiptScreen,
    //   page: () => const MaterialReceiptListScreen(),
    // ),
    GetPage(
      name: AppRoutes.grnScreen,
      page: () => GrnListScreen(),
    ),
    GetPage(
      name: AppRoutes.mrnQcList,
      page: () => MrnQcListScreen(),
    ),
    GetPage(
      name: AppRoutes.mrnQcScreen,
      page: () => MrnQcScreen(),
    ),
    GetPage(
      name: AppRoutes.indentList,
      page: () => const IndentListScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => IndentListController());
      }),
    ),
    GetPage(
      name: AppRoutes.issueItemList,
      page: () => IssueItemListScreen(),
    ),
    GetPage(
      name: AppRoutes.paymentRequestScreen,
      page: () => PaymentRequestScreen(),
      binding: PaymentRequestBinding(),
    ),
    GetPage(
      name: AppRoutes.reimbursement,
      page: () => ReimbursementListScreen(),
    ),
  ];
}
