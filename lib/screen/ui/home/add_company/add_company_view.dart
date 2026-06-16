import 'dart:io';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'add_company_controller.dart';

class AddCompanyView extends StatelessWidget {
  const AddCompanyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddCompanyController>(
      init: AddCompanyController(),
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        resizeToAvoidBottomInset: true,

        // Proper AppBar
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 3,
          shadowColor: const Color(0x12000000),
          surfaceTintColor: Colors.white,
          centerTitle: false,
          leading: GestureDetector(
            onTap: () => controller.backTap(),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: newTextPrimary, size: 20),
          ),
          title: const Text('Add Customer',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: newTextPrimary)),
        ),

        // Submit as bottom nav bar
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () => controller.addCompanyApi(),
                icon: const Icon(Icons.person_add_outlined,
                    color: Colors.white, size: 20),
                label: Text(AppString.addCustomer,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: newBlueColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                ),
              ),
            ),
          ),
        ),

        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  Company Details
              _sectionCard(
                title: 'Company Details',
                icon: Icons.business_outlined,
                child: _companyFields(controller),
              ),
              const SizedBox(height: 16),

              //  Billing Address
              _sectionCard(
                title: AppString.addressTxt,
                icon: Icons.location_on_outlined,
                child: _addressFields(controller, isShipping: false),
              ),
              const SizedBox(height: 16),

              //  Shipping Address (if different)
              if (!(controller.isBillingAndShippingAddressSame))
                _sectionCard(
                  title: AppString.shippingAddressTxt,
                  icon: Icons.local_shipping_outlined,
                  child: _addressFields(controller, isShipping: true),
                ),
              if (!(controller.isBillingAndShippingAddressSame))
                const SizedBox(height: 16),

              //  Upload Document
              _sectionCard(
                title: AppString.uploadDocument,
                icon: Icons.upload_file_outlined,
                child: _uploadSection(controller),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  //  Section card wrapper

  Widget _sectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8ECF0)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Card header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            color: Color(0xFFF0F3FF),
            borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
            border: Border(bottom: BorderSide(color: Color(0xFFE8ECF0))),
          ),
          child: Row(children: [
            Icon(icon, color: const Color(0xFF5B5FC7), size: 18),
            const SizedBox(width: 8),
            Text(title,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: newTextPrimary)),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
          child: child,
        ),
      ]),
    );
  }

  //  Company fields 

  Widget _companyFields(AddCompanyController c) {
    return Column(children: [
      _field(c.companyNameController, c.customerNameFocus,
          AppString.customerCompanyNameTxt, AppString.enterCompanyNameTxt),
      _field(c.mobileNoController, c.mobileNoFocus, AppString.mobileTxt,
          AppString.enterMobileTxt,
          keyboard: TextInputType.number,
          formatters: [FilteringTextInputFormatter.digitsOnly],
          maxLength: 10),
      _field(c.gstNoController, c.gstNoFocus, AppString.gstNoTxt,
          AppString.enterGstNoTxt,
          keyboard: TextInputType.emailAddress),
      _field(c.contactPersonController, c.contactPersonFocus,
          AppString.contactPersonTxt, AppString.enterContactPersonTxt),
      _field(c.emailController, c.emailFocus, AppString.emailIdTxt,
          AppString.enterEmailIdTxt,
          keyboard: TextInputType.emailAddress),
      _field(c.panNoController, c.panNoFocus, AppString.panNoTxt,
          AppString.enterPanNoTxt),
    ]);
  }

  //  Address fields 

  Widget _addressFields(AddCompanyController c, {required bool isShipping}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _field(
        isShipping ? c.shippingAddressController : c.addressController,
        isShipping ? c.shippingAddressFocus : c.addressFocus,
        isShipping ? AppString.shippingAddressTxt : AppString.addressTxt,
        AppString.enterAddressTxt,
      ),
      _field(
        isShipping ? c.shippingCountryController : c.countryController,
        isShipping ? c.shippingCountryFocus : c.countryFocus,
        AppString.countryTxt,
        AppString.enterCountryTxt,
      ),
      _field(
        isShipping ? c.shippingStateController : c.stateController,
        isShipping ? c.shippingStateFocus : c.stateFocus,
        AppString.stateTxt,
        AppString.enterStateTxt,
      ),
      _field(
        isShipping ? c.shippingCityController : c.cityController,
        isShipping ? c.shippingCityFocus : c.cityFocus,
        AppString.cityTxt,
        AppString.enterCityTxt,
      ),
      _field(
        isShipping ? c.shippingPincodeController : c.pincodeController,
        isShipping ? c.shippingPincodeFocus : c.pincodeFocus,
        AppString.pincodeTxt,
        AppString.enterPincodeTxt,
        keyboard: TextInputType.number,
        formatters: [FilteringTextInputFormatter.digitsOnly],
      ),
      _field(c.googleAddressController, c.googleAddressFocus,
          AppString.mapAddress, '',
          readOnly: true),
      _field(c.latLngController, c.latLngFocus, AppString.latLng,
          AppString.enterPincodeTxt,
          readOnly: true),

      // Same as billing checkbox
      if (!isShipping) ...[
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => c.tapOnCheck(),
          child: Row(children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: c.isBillingAndShippingAddressSame
                    ? newBlueColor
                    : Colors.white,
                border: Border.all(
                    color: c.isBillingAndShippingAddressSame
                        ? newBlueColor
                        : const Color(0xFFBCC3D8),
                    width: 1.5),
                borderRadius: BorderRadius.circular(4),
              ),
              child: c.isBillingAndShippingAddressSame
                  ? const Icon(Icons.check_rounded,
                      color: Colors.white, size: 13)
                  : null,
            ),
            const SizedBox(width: 10),
            Text(AppString.sameForShippingAddressTxt,
                style: const TextStyle(
                    fontSize: 13,
                    color: newTextSecondary,
                    fontWeight: FontWeight.w500)),
          ]),
        ),
      ],
    ]);
  }

  Widget _field(
    TextEditingController ctrl,
    FocusNode focus,
    String label,
    String hint, {
    TextInputType keyboard = TextInputType.text,
    List<TextInputFormatter>? formatters,
    int? maxLength,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: TextField(
        controller: ctrl,
        focusNode: focus,
        keyboardType: keyboard,
        textInputAction: TextInputAction.next,
        inputFormatters: formatters,
        maxLength: maxLength,
        readOnly: readOnly,
        style: const TextStyle(fontSize: 14, color: newTextPrimary),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 13, color: newTextSecondary),
          labelStyle: const TextStyle(fontSize: 13, color: newTextSecondary),
          counterText: '',
          filled: true,
          fillColor: readOnly ? const Color(0xFFF5F6FA) : Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: newBorderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: newBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: newBlueColor, width: 1.5),
          ),
        ),
      ),
    );
  }

  //  Upload section 

  Widget _uploadSection(AddCompanyController c) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            if (c.selectedImage.value.isEmpty)
              GestureDetector(
                onTap: () => _showImageDialog(c),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F6FA),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: newBorderColor, style: BorderStyle.solid),
                  ),
                  child: Row(children: [
                    const Icon(Icons.upload_outlined,
                        color: newTextSecondary, size: 20),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text('Tap to upload document',
                          style:
                              TextStyle(fontSize: 13, color: newTextSecondary)),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded,
                        size: 14, color: newTextSecondary),
                  ]),
                ),
              )
            else
              Column(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(c.selectedImage.value),
                    fit: BoxFit.cover,
                    height: 160,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => _showImageDialog(c),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF0FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.refresh_rounded,
                          size: 16, color: Color(0xFF5B5FC7)),
                      SizedBox(width: 6),
                      Text('Change Image',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF5B5FC7))),
                    ]),
                  ),
                ),
              ]),
          ],
        ));
  }

  void _showImageDialog(AddCompanyController c) {
    c.unfocus();
    Get.defaultDialog(
      title: AppString.chooseOption,
      radius: 12,
      backgroundColor: Colors.white,
      titleStyle: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600, color: newTextPrimary),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(
          leading:
              const Icon(Icons.photo_library_outlined, color: newBlueColor),
          title: const Text(AppString.selectImageFromGallery,
              style: TextStyle(fontSize: 14, color: newTextPrimary)),
          onTap: () {
            Get.back();
            c.getImage(ImageSource.gallery);
          },
        ),
        ListTile(
          leading: const Icon(Icons.camera_alt_outlined, color: newBlueColor),
          title: const Text(AppString.takePicture,
              style: TextStyle(fontSize: 14, color: newTextPrimary)),
          onTap: () {
            Get.back();
            c.getImage(ImageSource.camera);
          },
        ),
      ]),
    );
  }
}
