// indent_header_screen.dart - Step 0
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../indent_controller/indent_controller.dart';
import '../indent_response/indent_model.dart';
import '../indent_widgets.dart';

class IndentHeaderScreen extends StatelessWidget {
  const IndentHeaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IndentController>(builder: (ctrl) {
      // ADD THIS:
      if (kDebugMode) {
        print('🔄 isInitialLoading: ${ctrl.isInitialLoading}');
        print('🔄 isLoadingSite: ${ctrl.isLoadingSite}');
        print('🔄 isLoadingCompany: ${ctrl.isLoadingCompany}');
        print('🔄 siteList: ${ctrl.siteList.length}');
      }
      return Column(children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 100),
            child: Column(children: [
              // Indent Header card
              IndentCard(
                  child: Column(children: [
                    const IndentSectionHead("Indent Header"),
                    Row(children: [
                      Expanded(
                          child: IndentSearchableDropdown<IndentDropdownOption>(
                            label: "Indent Type",
                            value: ctrl.selectedIndentType,
                            items: ctrl.indentTypeList,
                            isLoading: ctrl.isLoadingIndentType,
                            itemLabel: (o) => o.label,
                            onChanged: ctrl.setIndentType,
                            hint: "Select type...",
                          )),
                      const SizedBox(width: 10),
                      Expanded(
                          child: IndentField(
                            label: "Indent No.",
                            controller: ctrl.indentDisplayNoCtrl,
                            readOnly: true,
                          )),
                    ]),
                    const SizedBox(height: 10),
                    Row(children: [
                      Expanded(
                          child: IndentField(
                            label: "Indent Date",
                            controller: ctrl.indentDateCtrl,
                            readOnly: true,
                            onTap: () => ctrl.pickIndentDate(context),
                            suffix: const Padding(
                              padding: EdgeInsets.all(12),
                              child: Icon(Icons.calendar_today_outlined,
                                  size: 16, color: indTextSecondary),
                            ),
                          )),
                      const SizedBox(width: 10),
                      Expanded(
                          child: IndentField(
                            label: "Required Date",
                            controller: ctrl.requiredDateCtrl,
                            readOnly: true,
                            onTap: () => ctrl.pickRequiredDate(context),
                            suffix: const Padding(
                              padding: EdgeInsets.all(12),
                              child: Icon(Icons.calendar_today_outlined,
                                  size: 16, color: indTextSecondary),
                            ),
                          )),
                    ]),
                    const SizedBox(height: 10),
                    IndentSearchableDropdown<IndentDropdownOption>(
                      label: "BOQ No.",
                      value: ctrl.selectedCustomerOrder,
                      items: ctrl.customerOrderList,
                      isLoading: ctrl.isLoadingCustomerOrder,
                      itemLabel: (o) => o.label,
                      onChanged: ctrl.setCustomerOrder,
                      hint: "Select customer order...",
                    ),
                    const SizedBox(height: 10),
                    IndentField(
                      label: "User Name",
                      controller:
                      TextEditingController(text: ctrl.loggedInUserName),
                      readOnly: true,
                    ),
                  ])),

              // Request Details card
              IndentCard(
                  child: Column(children: [
                    const IndentSectionHead("Request Details"),
                    IndentField(
                      label: "Request By ",
                      controller: ctrl.requestByCtrl,
                      hint: "Enter requester name",
                    ),
                    const SizedBox(height: 10),
                    IndentSearchableDropdown<IndentDropdownOption>(
                      label: "Department",
                      value: ctrl.selectedDepartment,
                      items: ctrl.departmentList,
                      isLoading: ctrl.isLoadingDepartment,
                      itemLabel: (o) => o.label,
                      onChanged: ctrl.setDepartment,
                      hint: "Select department...",
                    ),
                    const SizedBox(height: 10),
                    IndentSearchableDropdown<IndentDropdownOption>(
                      label: "Job Type",
                      value: ctrl.selectedJobType,
                      items: ctrl.jobTypeList,
                      isLoading: ctrl.isLoadingJobType,
                      itemLabel: (o) => o.label,
                      onChanged: ctrl.setJobType,
                      hint: "Select job type...",
                    ),
                    const SizedBox(height: 10),
                    IndentSearchableDropdown<IndentDropdownOption>(
                      label: "Priority",
                      value: ctrl.selectedPriorityOption,
                      items: ctrl.priorityList,
                      isLoading: ctrl.isLoadingPriority,
                      itemLabel: (o) => o.label,
                      onChanged: ctrl.setPriorityOption,
                      hint: "Select priority...",
                    ),
                  ])),

              // Site and Godown card
              IndentCard(
                  child: Column(children: [
                    const IndentSectionHead("Site and Godown"),
                    IndentSearchableDropdown<IndentDropdownOption>(
                      label: "Site Name",
                      value: ctrl.selectedSite,
                      items: ctrl.siteList,
                      isLoading: ctrl.isLoadingSite,
                      itemLabel: (o) => o.label,
                      onChanged: ctrl.setSite,
                      hint: "Select site...",
                    ),
                    const SizedBox(height: 10),
                    IndentSearchableDropdown<IndentDropdownOption>(
                      label: "Godown",
                      value: ctrl.selectedGodown,
                      items: ctrl.godownList,
                      isLoading: ctrl.isLoadingGodown,
                      itemLabel: (o) => o.label,
                      onChanged: ctrl.setGodown,
                      hint: ctrl.selectedSite == null
                          ? "Select a site first..."
                          : "Select godown...",
                    ),
                    const SizedBox(height: 10),
                    IndentSearchableDropdown<IndentDropdownOption>(
                      label: "Approver Name",
                      value: ctrl.selectedApprover,
                      items: ctrl.approverList,
                      isLoading: ctrl.isLoadingApprover,
                      itemLabel: (o) => o.label,
                      onChanged: ctrl.setApprover,
                      hint: "Select approver...",
                    ),
                    const SizedBox(height: 10),
                    IndentSearchableDropdown<IndentDropdownOption>(
                      label: "Company Name",
                      value: ctrl.selectedCompany,
                      items: ctrl.companyList,
                      isLoading: ctrl.isLoadingCompany,
                      itemLabel: (o) => o.label,
                      onChanged: ctrl.setCompany,
                      hint: "Select company...",
                    ),
                    const SizedBox(height: 10),
                    IndentSearchableDropdown<IndentDropdownOption>(
                      label: "Request To Site",
                      value: ctrl.selectedBranch,
                      items: ctrl.branchList,
                      isLoading: ctrl.isLoadingBranch,
                      itemLabel: (o) => o.label,
                      onChanged: ctrl.setBranch,
                      hint: "Select branch...",
                    ),
                    const SizedBox(height: 10),
                    // IndentSearchableDropdown<IndentDropdownOption>(
                    //   label: "Work Order No.",
                    //   value: ctrl.selectedWorkOrder,
                    //   items: ctrl.workOrderList,
                    //   isLoading: ctrl.isLoadingWorkOrder,
                    //   itemLabel: (o) => o.label,
                    //   onChanged: ctrl.setWorkOrder,
                    //   hint: ctrl.selectedSite == null ? "Select a site first..." : "Search work order...",
                    // ),
                    const SizedBox(height: 10),
                    IndentField(
                      label: "Site Incharge",
                      controller: ctrl.siteInchargeCtrl,
                      hint: "Enter site incharge name",
                    ),
                  ])),

              // Remarks card
              IndentCard(
                  child: Column(children: [
                    const IndentSectionHead("Remarks"),
                    IndentField(
                      label: "Remarks",
                      controller: ctrl.remarksCtrl,
                      hint: "Any additional notes...",
                      minLines: 3,
                      maxLines: 5,
                    ),
                  ])),
            ]),
          ),
        ),
        _bottomCta(ctrl),
      ]);
    });
  }

  Widget _bottomCta(IndentController ctrl) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: indBorderColor)),
      ),
      child: SafeArea(
        top: false,
        child: IndentPrimaryBtn(
          label: "Continue -> Add Items",
          icon: Icons.arrow_forward_rounded,
          onTap: () {
            if (ctrl.selectedSite == null) {
              Get.snackbar("Validation", "Please select a site",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red.shade50,
                  colorText: Colors.red.shade800,
                  margin: const EdgeInsets.all(12));
              return;
            }
            ctrl.nextStep();
          },
        ),
      ),
    );
  }
}
