import 'package:digitalerp/change_company/change_companay_controller.dart';
import 'package:digitalerp/utils/shared_pre.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restart_app/restart_app.dart';
import '../utils/app_constant_new.dart';

const Color _kWhite = Colors.white;
const Color _kBorder = Color(0xFFE2E8F0);
const Color _kTextPrimary = newTextPrimary;
const Color _kTextSub = newTextSecondary;
const Color _kTextHint = newTextHint;

class ChangeCompanyView extends StatelessWidget {
  const ChangeCompanyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangeCompanyController>(
      init: ChangeCompanyController(),
      builder: (ctrl) => Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        body: SafeArea(
          child: Column(children: [
            _appBar(),
            Expanded(
              child: ctrl.isPageLoading
                  ? const Center(
                  child: CircularProgressIndicator(color: purpleColor))
                  : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ── Company dropdown ─────────────────────────────
                    _label('Company Name'),
                    _dropdownBox(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          isExpanded: true,
                          value: ctrl.selectCompany?.compid,
                          hint: const Text('Select Company',
                              style: TextStyle(
                                  fontSize: 14, color: _kTextHint)),
                          icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: _kTextSub),
                          items: ctrl.companyList.map((c) {
                            return DropdownMenuItem<int>(
                              value: c.compid,
                              child: Text(c.companyname ?? '',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: _kTextPrimary)),
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (val == null) return;
                            final company = ctrl.companyList
                                .firstWhere((e) => e.compid == val);
                            ctrl.setSelectCompanyDropdownValue(company);
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ── Branch dropdown ──────────────────────────────
                    _label('Branch Name'),
                    // Show spinner inside the box while loading
                    ctrl.isLoadingBranches
                        ? _loadingBox()
                        : _dropdownBox(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          isExpanded: true,
                          value: ctrl.selectBranch?.branchid,
                          hint: Text(
                            ctrl.selectCompany == null
                                ? 'Select a company first'
                                : 'Select Branch',
                            style: const TextStyle(
                                fontSize: 14, color: _kTextHint),
                          ),
                          icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: _kTextSub),
                          // Disable if no company selected
                          onChanged: ctrl.selectCompany == null
                              ? null
                              : (val) {
                            if (val == null) return;
                            final branch = ctrl.branchList
                                .firstWhere(
                                    (e) => e.branchid == val);
                            ctrl.setSelectBranchDropdownValue(
                                branch);
                          },
                          items: ctrl.branchList.map((b) {
                            return DropdownMenuItem<int>(
                              value: b.branchid,
                              child: Text(b.branchname ?? '',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: _kTextPrimary)),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // ── Submit ───────────────────────────────────────
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: (ctrl.selectCompany == null ||
                            ctrl.selectBranch == null)
                            ? null // greyed out until both are selected
                            : () async {
                          final userData = ctrl
                              .homeController.currentUserData!;
                          userData.compId =
                              ctrl.selectCompany!.compid;
                          userData.branchId =
                              ctrl.selectBranch!.branchid;
                          await SharedPre.setValue(
                              SharedPre.userData,
                              userData.toJson());
                          Restart.restartApp();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: purpleColor,
                          foregroundColor: _kWhite,
                          disabledBackgroundColor:
                          purpleColor.withValues(alpha: 0.4),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                        ),
                        child: const Text('Apply',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _appBar() {
    return Container(
      color: _kWhite,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios_new,
              color: _kTextPrimary, size: 20),
        ),
        const SizedBox(width: 12),
        const Text('Change Company',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: _kTextPrimary)),
      ]),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _kTextPrimary)),
    );
  }

  Widget _dropdownBox({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: _kWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder),
      ),
      child: child,
    );
  }

  /// Shown in place of branch dropdown while API is loading
  Widget _loadingBox() {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: _kWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder),
      ),
      child: Row(children: [
        const SizedBox(
          width: 16, height: 16,
          child: CircularProgressIndicator(
              strokeWidth: 2, color: purpleColor),
        ),
        const SizedBox(width: 10),
        Text('Loading branches…',
            style: TextStyle(
                fontSize: 13,
                color: _kTextHint.withValues(alpha: 0.8))),
      ]),
    );
  }
}