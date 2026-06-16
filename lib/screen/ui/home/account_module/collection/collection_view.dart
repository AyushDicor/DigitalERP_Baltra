import 'dart:convert';
import 'dart:io';

import 'package:digitalerp/response/cash_bank_ledger_response.dart';
import 'package:digitalerp/response/collection_customer_list_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/fab/menu_fab.dart';
import 'package:digitalerp/screen/ui/home/account_module/collection/collection_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_bottom_button.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/app_loader.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CollectionView extends StatelessWidget {
  const CollectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CollectionController>(
      init: CollectionController(),
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
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: SafeArea(
                    child: MyAppBar(
                      title: 'Collection',
                      onBackTap: () => controller.backTap(),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                top: Get.height * 0.135,
                child: controller.isBusy
                    ? const AppLoader()
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: Get.height * 0.02),
                              controller.argument == null
                                  ? _dropdown(controller)
                                  : Container(
                                      width: Get.width,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: dropdownBoxColor,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text(
                                        controller.customerName,
                                        style:
                                            const TextStyle().bold.copyWith(),
                                      ),
                                    ),
                              const SizedBox(height: 20),
                              _dateView(
                                  context, controller.selectDate, controller),
                              const SizedBox(height: 15),
                              TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                maxLength: 6,
                                style: const TextStyle().light,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                controller: controller.amountController,
                                focusNode: controller.amountFocus,
                                decoration:
                                    const InputDecoration().txtFieldStyle2(
                                  hintText: AppString.enterAmount,
                                  labelName: AppString.amount,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text('  ${AppString.paymentMode}',
                                  style: const TextStyle().normal.copyWith(
                                      color: red2Color, fontSize: 12)),
                              ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.paymentOptionList.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      controller.selectedIndex == 1
                                          ? paymentCard2(
                                              controller, index, context)
                                          : paymentCard(controller, index),
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              _cashAndBankLedgerDropdown(controller),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                style: const TextStyle().light,
                                minLines: 4,
                                maxLines: 6,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                controller: controller.remarkController,
                                focusNode: controller.remarkFocus,
                                decoration:
                                    const InputDecoration().txtFieldStyle2(
                                  hintText: AppString.type,
                                  labelName: AppString.remark,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Material(
                                child: InkWell(
                                  onTap: () => _showImageDialog(controller),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            grBottomColor.withValues(
                                                alpha: 0.2),
                                            grTopColor.withValues(alpha: 0.2),
                                          ],
                                        )),
                                    padding: EdgeInsets.symmetric(
                                      vertical:
                                          controller.selectedImage.value == ''
                                              ? 45
                                              : 0,
                                    ),
                                    alignment: Alignment.center,
                                    clipBehavior: Clip.antiAlias,
                                    child: Visibility(
                                      visible:
                                          controller.selectedImage.value == '',
                                      child: Image.asset(
                                        AppAssets.uploadIcon,
                                        height: 28,
                                        width: 28,
                                      ),
                                      replacement: Image.file(
                                        File(controller.selectedImage.value),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: TextButton(
                                  onPressed: () => _showImageDialog(controller),
                                  child: Text(
                                      controller.selectedImage.value == ''
                                          ? 'Upload picture'
                                          : 'Change image',
                                      style: const TextStyle().normal.copyWith(
                                          color: red2Color, fontSize: 12)),
                                ),
                              ),
                              const SizedBox(height: 80),
                            ],
                          ),
                        ),
                      ),
              ),
              Positioned(
                bottom: 80,
                right: 20,
                child: Visibility(
                  visible: false,
                  child: InkWell(
                    onTap: () {
                      controller.onTabAccountModule();
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: gr2,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 10,
                              color: purpleColor,
                            )
                          ]),
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: Image.asset(
                        AppAssets.accountsModuleIcon,
                        height: 18,
                        width: 28,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AppBottomButton(
                    onPressed: () {
                      controller.tapOnSubmit();
                    },
                    name: 'Submit'),
              )
            ],
          ),
        ),
        floatingActionButton: MenuFab(parentMenuId: 2382),
      ),
    );
  }

  Widget _dateView(
      BuildContext context, String value, CollectionController ctrl) {
    return InkWell(
      onTap: () => ctrl.tapOnDate(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select Date',
                  style: const TextStyle()
                      .bold
                      .copyWith(color: red2Color, fontSize: 12),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(value, style: const TextStyle().normal),
                    Image.asset(
                      AppAssets.calendarIcon,
                      width: 18,
                      height: 18,
                    )
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            color: purpleColor,
            thickness: 1,
            height: 2,
          ),
        ],
      ),
    );
  }

  Widget paymentCard(
    CollectionController controller,
    int index,
  ) {
    return SizedBox(
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            right: 14,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
                border: Border.all(width: 1, color: purpleColor),
              ),
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12.5),
              child: Text(
                controller.paymentOptionList[index],
                style: const TextStyle()
                    .bold
                    .copyWith(fontSize: 12, color: purpleColor),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 16,
            child: InkWell(
              onTap: () => controller.setSelectedIndex(index),
              child: Container(
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: gr1,
                    boxShadow: const [
                      BoxShadow(
                        color: purpleColor,
                        blurRadius: 5,
                        offset: Offset(
                          -3,
                          1,
                        ),
                      ),
                    ]),
                alignment: Alignment.center,
                child: Image.asset(
                  controller.selectedIndex == index
                      ? AppAssets.checkIcon
                      : AppAssets.uncheckIcon,
                  width: 10,
                  height: 10,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget paymentCard2(
      CollectionController controller, int index, BuildContext context) {
    return SizedBox(
      height: controller.selectedIndex == index ? 160 : 60,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            right: 14,
            bottom: 0,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                  border: Border.all(width: 1, color: purpleColor),
                ),
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12.5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      controller.paymentOptionList[index],
                      style: const TextStyle().bold.copyWith(
                            fontSize: 12,
                            color: purpleColor,
                          ),
                    ),
                    Visibility(
                      visible: controller.selectedIndex == index,
                      child: const SizedBox(
                        height: 10,
                      ),
                    ),
                    Visibility(
                      visible: controller.selectedIndex == index,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                grBottomColor.withValues(alpha: 0.2),
                                grTopColor.withValues(alpha: 0.2),
                              ],
                            )),
                        child: TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          maxLength: 6,
                          decoration:
                              const InputDecoration().newTxtFieldStyle(),
                          controller: controller.chequeNoController,
                          focusNode: FocusNode(),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.search,
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                    Visibility(
                      visible: controller.selectedIndex == index,
                      child: const SizedBox(height: 10),
                    ),
                    Visibility(
                      visible: controller.selectedIndex == index,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: 40,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              grBottomColor.withValues(alpha: 0.2),
                              grTopColor.withValues(alpha: 0.2),
                            ],
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            controller.tapOnChequeDate(context);
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              controller.selectChequeDate,
                              style: const TextStyle().normal.copyWith(
                                    fontSize: 12,
                                    color: medGreyColor,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ),
          Positioned(
            right: 0,
            top: 16,
            child: InkWell(
              onTap: () => controller.setSelectedIndex(index),
              child: Container(
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: gr1,
                    boxShadow: const [
                      BoxShadow(
                        color: purpleColor,
                        blurRadius: 5,
                        offset: Offset(
                          -3,
                          1,
                        ),
                      ),
                    ]),
                alignment: Alignment.center,
                child: Image.asset(
                  controller.selectedIndex == index
                      ? AppAssets.checkIcon
                      : AppAssets.uncheckIcon,
                  width: 10,
                  height: 10,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _dropdown(CollectionController controller) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<CustomerData>(
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
          AppString.selectCustomer,
          style: const TextStyle().normal.copyWith(fontSize: 14),
          overflow: TextOverflow.ellipsis,
        ),
        icon: Image.asset(
          AppAssets.dropdownIcon,
          width: 15,
          height: 15,
        ),
        items: controller.customerDataList.map(
          (items) {
            return DropdownMenuItem<CustomerData>(
              value: items,
              child: Text(items.partyname.toString()),
            );
          },
        ).toList(),
        onChanged: (newValue) {
          controller.setDropdownValue(newValue);
        },
      ),
    );
  }

  Widget _cashAndBankLedgerDropdown(CollectionController controller) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<CashAndBankLedgerDataList>(
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
        value: controller.selectedCollectionLedgerValue,
        hint: Text(
          AppString.selectCollectionLedger,
          style: const TextStyle().normal.copyWith(fontSize: 14),
          overflow: TextOverflow.ellipsis,
        ),
        icon: Image.asset(
          AppAssets.dropdownIcon,
          width: 15,
          height: 15,
        ),
        items: controller.cashAndBankLedgerList.map(
          (items) {
            return DropdownMenuItem<CashAndBankLedgerDataList>(
              value: items,
              child: Text(items.partyname.toString()),
            );
          },
        ).toList(),
        onChanged: (newValue) {
          controller.setCashAndBankLedgerDropdownValue(newValue);
        },
      ),
    );
  }

  _showImageDialog(CollectionController value) {
    return Get.defaultDialog(
      title: AppString.chooseOption,
      radius: 8,
      titleStyle: const TextStyle().normal,
      content: Column(
        children: [
          InkWell(
            onTap: () {
              _getImage(ImageSource.gallery, value);
            },
            child: Text(
              AppString.selectImageFromGallery,
              style: const TextStyle().normal,
            ),
          ),
          SizedBox(height: Get.height * .02),
          InkWell(
            onTap: () {
              _getImage(ImageSource.camera, value);
            },
            child: Text(
              AppString.takePicture,
              style: const TextStyle().normal,
            ),
          ),
        ],
      ),
    );
  }

  void _getImage(ImageSource source, CollectionController value) async {
    Get.back();
    var pickedFile = await value.picker.pickImage(
      source: source,
      imageQuality: 65,
    );
    if (pickedFile != null) {
      var file = File(pickedFile.path);
      value.selectedImageBase64.value = base64.encode(file.readAsBytesSync());
      value.selectedImageFileName.value = file.path.split('/').last;
      value.setSelectedImage(file.path);
    }
  }
}
