import 'package:digitalerp/response/stcok_category_data_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/Image/image_controller.dart';
import 'package:digitalerp/screen/ui/home/Image/image_preview/image_preview_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_bottom_button.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePreviewView extends StatelessWidget {
  const ImagePreviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImagePreviewController>(
      init: ImagePreviewController(
          ModalRoute.of(context)!.settings.arguments as ImagePreviewArgument, context),
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
                          image: AssetImage(AppAssets.dashboardBg), fit: BoxFit.fill)),
                  child: SafeArea(
                      child:
                          MyAppBar(title: 'Image Preview', onBackTap: () => controller.backTap())),
                ),
              ),
              Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                top: Get.height * 0.135,
                child: controller.isBusy
                    ? showLoader()
                    : SingleChildScrollView(
                        padding: EdgeInsets.only(
                            bottom: (MediaQuery.of(context).viewInsets.bottom > 0) ? 200 : 0,
                            left: 20,
                            right: 20),
                        child: Column(
                          children: [
                            card(controller),
                            txtField(controller),
                          ],
                        ),
                      ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AppBottomButton(onPressed: () => controller.onTapSave(), name: 'Save'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget card(ImagePreviewController controller) => Stack(
    children: [
      Container(
        height: 200,
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 5))
            ]),
        margin: const EdgeInsets.only(bottom: 10),
        clipBehavior: Clip.antiAlias,
        child: Image.file(
          controller.captureImage.file,
          fit: BoxFit.cover,
        ),
      ),
      RepaintBoundary(
        key: controller.globalKey,
        child: SizedBox(
          height: 200,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 10,
                child: Container(
                  // decoration: BoxDecoration(
                  //     color: blueColor.withValues(alpha:0.3),
                  //     borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15))),
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  // alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // '3929 Jehovah Drive Fredericksburg',
                        'LAT - ${controller.captureImage.lat}',
                        style: const TextStyle().bold.copyWith(fontSize: 12, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        // '3929 Jehovah Drive Fredericksburg',
                        'LON - ${controller.captureImage.long}',
                        style: const TextStyle().bold.copyWith(fontSize: 12, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        // '3929 Jehovah Drive Fredericksburg',
                        'ADD - ${controller.captureImage.location}',
                        style: const TextStyle().bold.copyWith(fontSize: 12, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    ],
  );

  Widget txtField(ImagePreviewController controller) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23),
        child: Column(
          children: [
            groupDropdown(controller),
            TextFormField(
              style: const TextStyle().light,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              controller: controller.titleController,
              focusNode: controller.titleFocus,
              decoration: const InputDecoration().txtFieldStyle2(
                  hintText: 'Enter Title', labelName: 'Title', bottomAlwaysPurple: true),
            ),
            TextFormField(
              style: const TextStyle().light,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              controller: controller.descriptionController,
              minLines: 5,
              maxLines: 5,
              focusNode: controller.descriptionFocus,
              decoration: const InputDecoration().txtFieldStyle2(
                  hintText: 'Enter Description',
                  labelName: 'Description',
                  bottomAlwaysPurple: true),
            ),
            const SizedBox(height: 100),
          ],
        ),
      );

  Widget groupTxtField(ImagePreviewController controller) {
    return TextFormField(
      style: const TextStyle().light,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      controller: controller.groupController,
      focusNode: controller.groupFocus,
      decoration: const InputDecoration()
          .txtFieldStyle2(hintText: 'Enter group', labelName: 'Group', bottomAlwaysPurple: true),
    );
  }

  Widget groupDropdown(ImagePreviewController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            'Group',
            style: const TextStyle().medium.copyWith(color: red2Color, fontSize: 12),
          ),
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton2<StockCategoryList>(
            buttonHeight: 40,
            buttonPadding: const EdgeInsets.all(5),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: dropdownBoxColor,
            ),
            buttonDecoration: const BoxDecoration(
                color: Colors.transparent,
                // color: Colors.green,
                border: Border(bottom: BorderSide(color: purpleColor, width: 1.25))),
            dropdownPadding: EdgeInsets.zero,
            isExpanded: true,
            hint: Text(
              'Select Group',
              style: const TextStyle().normal.copyWith(fontSize: 12),
            ),
            value: controller.selectedGroupDropdownValue,
            icon: Image.asset(
              AppAssets.dropdownIcon,
              width: 15,
              height: 15,
            ),
            items: controller.groupList?.map((StockCategoryList value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value.categoryname.toString()),
              );
            }).toList(),
            onChanged: controller.setSelectGroup,
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
