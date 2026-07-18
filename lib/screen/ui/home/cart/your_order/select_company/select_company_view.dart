import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/cart/your_order/select_company/select_company_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/app_profile_image.dart';
import 'package:digitalerp/utils/gradient_icon_app_button.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectCompanyView extends StatelessWidget {
  const SelectCompanyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectCompanyController>(
      init: SelectCompanyController(),
      builder: (controller) => Scaffold(
        resizeToAvoidBottomInset: false,
        // FAB now lives in its proper Scaffold slot instead of a Positioned
        // widget inside the Stack, so it can never be pushed around or
        // overlapped by list content.
        floatingActionButton: GradientIconButton(
          onPressed: () => controller.tapOnAdd(),
          radius: 15,
          vPadding: 20,
        ),
        body: Container(
          decoration: const BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage(AppAssets.dashboardBg),
            //   fit: BoxFit.fill,
            // ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // --- Fixed header: takes only the height it actually needs,
                // no more guessing with Get.height * 0.135 ---
                MyAppBar(
                  title: 'Select Customer',
                  onBackTap: () => controller.backTap(),
                ),

                // --- Scrollable body: Expanded guarantees this can never
                // grow into / overlap the header above it ---
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Get.height * 0.02),
                        if (controller.isManager) _dropdown(controller),
                        if (controller.isManager) const SizedBox(height: 20),
                        TextFormField(
                          decoration:
                          const InputDecoration().searchTxtFieldStyle(),
                          controller: controller.searchController,
                          focusNode: controller.searchFocus,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.search,
                          onChanged: (value) =>
                              controller.searchCompany(value),
                        ),
                        controller.isListLoading
                            ? Padding(
                          padding:
                          EdgeInsets.only(top: Get.height * 0.28),
                          child: const Center(
                              child: CircularProgressIndicator()),
                        )
                            : controller.companyList.isNotEmpty
                            ? ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics:
                          const NeverScrollableScrollPhysics(),
                          itemCount: controller.companyList.length,
                          itemBuilder: (context, index) {
                            return companyCard(controller, index);
                          },
                        )
                            : SizedBox(
                          height: Get.height * .2,
                          child: centerText(
                            'Party list Not Available',
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget companyCard(SelectCompanyController controller, int index) {
    var item = controller.companyList[index];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => controller.tapOnCard(index),
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: purpleColor,
                  ),
                  child: const ProfileImageView(
                    size: 56,
                    imageUrl: dummyImageUrlTxt,
                    borderSize: 2,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    item.partyname ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle().bold.copyWith(fontSize: 15),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                   color:purpleColor,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Select',
                        style: const TextStyle()
                            .bold
                            .copyWith(color: whiteColor, fontSize: 13),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward_rounded,
                          size: 14, color: whiteColor),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dropdown(SelectCompanyController controller) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<ExecutiveDropdownData>(
        buttonHeight: 40,
        buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: dropdownBoxColor,
        ),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: dropdownBoxColor,
        ),
        isExpanded: true,
        value: controller.selectedDropdownValue,
        hint: Text(
          'Select Executive user name',
          style: const TextStyle().normal.copyWith(fontSize: 14),
          overflow: TextOverflow.ellipsis,
        ),
        icon: Image.asset(
          AppAssets.dropdownIcon,
          width: 15,
          height: 15,
        ),
        items: controller.yourOrderController.orderController.executiveList
            .map((ExecutiveDropdownData items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items.executiveName.toString()),
          );
        }).toList(),
        onChanged: (ExecutiveDropdownData? newValue) {
          controller.setDropdownValue(newValue!);
        },
      ),
    );
  }
}