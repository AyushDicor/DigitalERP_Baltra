import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/cart/your_order/select_company/select_company_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant.dart';
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
        body: Center(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AppAssets.dashboardBg),
                          fit: BoxFit.fill)),
                  child: SafeArea(
                      child: MyAppBar(
                          title: 'Select Customer',
                          onBackTap: () => controller.backTap())),
                ),
              ),
              Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                top: Get.height * 0.135,
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
                        onChanged: (value) => controller.searchCompany(value),
                      ),
                      controller.isListLoading
                          ? Padding(
                              padding: EdgeInsets.only(top: Get.height * 0.28),
                              child: const Center(
                                  child: CircularProgressIndicator()))
                          : controller.companyList.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
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
              Positioned(
                right: 18,
                bottom: 35,
                child: GradientIconButton(
                    onPressed: () => controller.tapOnAdd(),
                    radius: 15,
                    vPadding: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget companyCard(SelectCompanyController controller, int index) {
    var item = controller.companyList[index];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      constraints: const BoxConstraints(maxHeight: 160),
      child: InkWell(
        onTap: () => controller.tapOnCard(index),
        child: Stack(
          alignment: Alignment.topLeft,
          fit: StackFit.loose,
          children: [
            Positioned(
              left: 0,
              top: 35,
              right: 0,
              child: Container(
                // height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                      colors: /*item.isPending ? [orangeColor, orangeColor] :*/ grad1,
                      stops: [0, 0.35],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter),
                ),
                // margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: Get.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                          bottom: Radius.circular(25),
                        ),
                        color: Colors.white,
                      ),
                      padding:
                          const EdgeInsets.only(left: 25, bottom: 10, top: 45),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        item.partyname ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle().bold.copyWith(fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      /*item.isPending ? 'Pending' : */
                      'Select',
                      style: const TextStyle()
                          .bold
                          .copyWith(color: whiteColor, fontSize: 14),
                    ),
                    const SizedBox(
                      height: 8,
                    )
                  ],
                ),
              ),
            ),
            const Positioned(
              top: 0,
              left: 20,
              child: ProfileImageView(
                size: 65,
                imageUrl: dummyImageUrlTxt,
                borderSize: 2,
              ),
            ),
          ],
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
