import 'package:digitalerp/change_company/Company_list_responce.dart';
import 'package:digitalerp/change_company/branch_list_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:get/get.dart';

class ChangeCompanyController extends AppBaseController {
  bool isPageLoading = true;
  bool isLoadingBranches = false; // separate flag so only branch dropdown shows spinner
  HomeController homeController = Get.find<HomeController>();

  List<CompanyListData> companyList = [];
  List<BranchListData> branchList = [];
  CompanyListData? selectCompany;
  BranchListData? selectBranch;

  @override
  void onInit() {
    super.onInit();
    _loadInitialData();
  }

  // ── Initial load: companies first, then branches for current company ────────
  Future<void> _loadInitialData() async {
    isPageLoading = true;
    setBusy(true);
    update();
    try {
      await getChangeCompanyApi();
      // Use the currently selected company's id to load matching branches
      await getBranchListApi(compId: selectCompany?.compid);
    } finally {
      isPageLoading = false;
      setBusy(false);
      update();
    }
  }

  // ── Company dropdown changed ────────────────────────────────────────────────
  Future<void> setSelectCompanyDropdownValue(CompanyListData? value) async {
    if (value == null || value.compid == selectCompany?.compid) return;
    selectCompany = value;
    // Clear branch selection immediately so UI doesn't show stale data
    selectBranch = null;
    branchList = [];
    update();
    // Re-fetch branches for the newly selected company
    await getBranchListApi(compId: value.compid);
  }

  void setSelectBranchDropdownValue(BranchListData? value) {
    selectBranch = value;
    update();
  }

  // ── Fetch company list ──────────────────────────────────────────────────────
  Future<void> getChangeCompanyApi() async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] =
          homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.userId] =
          homeController.currentUserData?.userid.toString() ?? '369622';

      var res = await api.getCompanyList(body);
      companyList = res.data ?? [];

      // Deduplicate
      final seen = <int>{};
      companyList = companyList.where((c) => seen.add(c.compid ?? 0)).toList();

      // Pre-select the user's current company
      final currentCompId = homeController.currentUserData!.compId;
      final matched = companyList.where((e) => e.compid == currentCompId);
      selectCompany = matched.length == 1 ? matched.first : null;

      if (res.status != 200) {
        ShowMessage.showSnackBar(
            'Company List Error', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Company List', '$e');
    }
  }

  // ── Fetch branch list for a specific company ────────────────────────────────
  /// [compId] — pass the SELECTED company's id, not the logged-in user's.
  Future<void> getBranchListApi({int? compId}) async {
    isLoadingBranches = true;
    update();
    try {
      Map<String, String> body = {};
      // ✅ KEY FIX: use the passed compId (selected company), not currentUserData
      body[RequestKeys.compId] =
          (compId ?? homeController.currentUserData?.compId ?? 39).toString();
      body[RequestKeys.userId] =
          homeController.currentUserData?.userid.toString() ?? '369622';

      var res = await api.getBranchList(body);

      // Filter out placeholder entries and deduplicate
      List<BranchListData> fetched =
      (res.data ?? []).where((b) => (b.branchid ?? 0) != 0).toList();
      final seenB = <int>{};
      branchList = fetched.where((b) => seenB.add(b.branchid ?? 0)).toList();

      // Pre-select branch only if it belongs to the same company as current session
      final currentBranchId = homeController.currentUserData!.branchId;
      final currentCompId = homeController.currentUserData!.compId;
      if (compId == currentCompId) {
        final matchedB = branchList.where((e) => e.branchid == currentBranchId);
        selectBranch = matchedB.length == 1 ? matchedB.first : null;
      } else {
        // Different company selected — no branch pre-selection
        selectBranch = null;
      }

      if (res.status != 200) {
        ShowMessage.showSnackBar('Branch List Error', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Branch List', '$e');
    } finally {
      isLoadingBranches = false;
      update();
    }
  }
}