import 'dart:convert';
import 'dart:io';

import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddCompanyController extends AppBaseController {
  final HomeController homeController = Get.find<HomeController>();

  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController gstNoController = TextEditingController();
  final TextEditingController contactPersonController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController panNoController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController googleAddressController = TextEditingController();
  final TextEditingController latLngController = TextEditingController();

  final TextEditingController shippingAddressController = TextEditingController();
  final TextEditingController shippingCountryController = TextEditingController();
  final TextEditingController shippingStateController = TextEditingController();
  final TextEditingController shippingCityController = TextEditingController();
  final TextEditingController shippingPincodeController = TextEditingController();
  final FocusNode customerNameFocus = FocusNode();
  final FocusNode mobileNoFocus = FocusNode();
  final FocusNode gstNoFocus = FocusNode();
  final FocusNode contactPersonFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode panNoFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();
  final FocusNode countryFocus = FocusNode();
  final FocusNode stateFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();
  final FocusNode pincodeFocus = FocusNode();
  final FocusNode latLngFocus = FocusNode();
  final FocusNode googleAddressFocus = FocusNode();
  final FocusNode shippingAddressFocus = FocusNode();
  final FocusNode shippingCountryFocus = FocusNode();
  final FocusNode shippingStateFocus = FocusNode();
  final FocusNode shippingCityFocus = FocusNode();
  final FocusNode shippingPincodeFocus = FocusNode();

  Position? currentPosition;

  @override
  void onInit() async {
    // TODO: implement onInit
    currentPosition = await getUserCurrentPosition();
    latLngController.text = "${currentPosition?.latitude}, ${currentPosition?.longitude}";
    googleAddressController.text = await getUserCurrentAddress();

    super.onInit();
  }

  final picker = ImagePicker();
  var selectedImage = ''.obs;
  var selectedImageBase64 = ''.obs;
  var selectedImageFileName = ''.obs;

  void setSelectedImage(String value) {
    selectedImage.value = value;
    update();
  }

  void getImage(ImageSource source) async {
    Get.back();
    var pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 65,
    );
    if (pickedFile != null) {
      var file = File(pickedFile.path);
      selectedImageBase64.value = base64.encode(file.readAsBytesSync());
      selectedImageFileName.value = file.path.split('/').last;
      setSelectedImage(file.path);
    }
  }

  bool isBillingAndShippingAddressSame = false;

  bool _isValidate() {
    if (companyNameController.text.trim().isEmpty) {
      ShowMessage.showSnackBar(
        AppString.requiredFieldTxt.tr,
        AppString.pleaseEnterCompanyNameTxt.tr,
      );
      return false;
    }
    if (mobileNoController.text.trim().isEmpty) {
      ShowMessage.showSnackBar(
        AppString.requiredFieldTxt.tr,
        AppString.pleaseEnterMobileTxt.tr,
      );
      return false;
    }
    if (mobileNoController.text.trim().length != 10 && !mobileNoController.text.isNumericOnly) {
      ShowMessage.showSnackBar(
        AppString.requiredFieldTxt.tr,
        AppString.pleaseEnterValidMobileTxt.tr,
      );
      return false;
    }

    if (gstNoController.text.trim().isEmpty) {
      ShowMessage.showSnackBar(
        AppString.requiredFieldTxt.tr,
        AppString.pleaseEnterGstNoTxt.tr,
      );
      return false;
    }


    if (contactPersonController.text.trim().isEmpty) {
      ShowMessage.showSnackBar(
        AppString.requiredFieldTxt.tr,
        AppString.pleaseEnterContactPersonTxt.tr,
      );
      return false;
    }
    /*
    if (emailController.text.trim().isEmpty) {
      ShowMessage.showSnackBar(
        AppString.requiredFieldTxt.tr,
        AppString.pleaseEnterEmailTxt.tr,
      );
      return false;
    }
    if (!emailController.text.trim().isEmail) {
      ShowMessage.showSnackBar(
        AppString.requiredFieldTxt.tr,
        AppString.pleaseEnterValidEmailTxt.tr,
      );
      return false;
    }
    if (panNoController.text.trim().isEmpty) {
      ShowMessage.showSnackBar(
        AppString.requiredFieldTxt.tr,
        AppString.pleaseEnterPanNoTxt.tr,
      );
      return false;
    }
     */
    if (addressController.text.trim().isEmpty) {
      ShowMessage.showSnackBar(
        AppString.requiredFieldTxt.tr,
        AppString.pleaseEnterAddress.tr,
      );
      return false;
    }
    if (countryController.text.trim().isEmpty) {
      ShowMessage.showSnackBar(
        AppString.requiredFieldTxt.tr,
        AppString.pleaseEnterCountryTxt.tr,
      );
      return false;
    }
    if (stateController.text.trim().isEmpty) {
      ShowMessage.showSnackBar(
        AppString.requiredFieldTxt.tr,
        AppString.pleaseEnterStateTxt.tr,
      );
      return false;
    }
    if (cityController.text.trim().isEmpty) {
      ShowMessage.showSnackBar(
        AppString.requiredFieldTxt.tr,
        AppString.pleaseEnterStateTxt.tr,
      );
      return false;
    }
    if (pincodeController.text.trim().isEmpty) {
      ShowMessage.showSnackBar(
        AppString.requiredFieldTxt.tr,
        AppString.pleaseEnterPincodeTxt.tr,
      );
      return false;
    }
    if (pincodeController.text.trim().length != 6) {
      ShowMessage.showSnackBar(
        AppString.requiredFieldTxt.tr,
        AppString.pleaseEnterValidPincodeTxt.tr,
      );
      return false;
    }
    if (!isBillingAndShippingAddressSame) {
      if (shippingAddressController.text.trim().isEmpty) {
        ShowMessage.showSnackBar(
          AppString.requiredFieldTxt.tr,
          AppString.pleaseEnterAddress.tr,
        );
        return false;
      }
      if (shippingCountryController.text.trim().isEmpty) {
        ShowMessage.showSnackBar(
          AppString.requiredFieldTxt.tr,
          AppString.pleaseEnterCountryTxt.tr,
        );
        return false;
      }
      if (shippingStateController.text.trim().isEmpty) {
        ShowMessage.showSnackBar(
          AppString.requiredFieldTxt.tr,
          AppString.pleaseEnterStateTxt.tr,
        );
        return false;
      }
      if (shippingCityController.text.trim().isEmpty) {
        ShowMessage.showSnackBar(
          AppString.requiredFieldTxt.tr,
          AppString.pleaseEnterStateTxt.tr,
        );
        return false;
      }
      if (shippingPincodeController.text.trim().isEmpty) {
        ShowMessage.showSnackBar(
          AppString.requiredFieldTxt.tr,
          AppString.pleaseEnterPincodeTxt.tr,
        );
        return false;
      }
      if (shippingPincodeController.text.trim().length != 6) {
        ShowMessage.showSnackBar(
          AppString.requiredFieldTxt.tr,
          AppString.pleaseEnterValidPincodeTxt.tr,
        );
        return false;
      }
    }
    /*
    if (selectedImageFileName.value.isEmpty) {
      ShowMessage.showSnackBar(
        AppString.requiredFieldTxt.tr,
        AppString.pleaseUploadDocumentTxt.tr,
      );
      return false;
    }
     */
    return true;
  }

  void tapOnCheck() {
    isBillingAndShippingAddressSame = !isBillingAndShippingAddressSame;
    update();
  }

  void addCompanyApi() async {
    unfocus();
    setBusy(true);
    if (_isValidate()) {
      try {
        Map<String, String> body = {};
        body[RequestKeys.compId] = homeController.currentUserData!.compId.toString();
        body[RequestKeys.branchId] = homeController.currentUserData!.branchId.toString();
        body[RequestKeys.yearId] = homeController.currentUserData!.yearId.toString();
        body[RequestKeys.userId] = homeController.currentUserData!.userid.toString();
        body[RequestKeys.companyName] = companyNameController.text.trim();
        body[RequestKeys.mobileNo] = mobileNoController.text.trim();
        body[RequestKeys.gstNo] = gstNoController.text.trim();
        body[RequestKeys.contactPerson] = contactPersonController.text.trim();
        body[RequestKeys.emailId] = emailController.text.trim();
        body[RequestKeys.panNo] = panNoController.text.trim();
        body[RequestKeys.billingAddress] = addressController.text.trim();
        body[RequestKeys.billingCountry] = countryController.text.trim();
        body[RequestKeys.billingCountryId] = '0';
        body[RequestKeys.billingState] = stateController.text.trim();
        body[RequestKeys.billingStateId] = '0';
        body[RequestKeys.billingCity] = cityController.text.trim();
        body[RequestKeys.billingCityId] = '0';
        body[RequestKeys.billingPincode] = pincodeController.text.trim();
        body[RequestKeys.shippingAddress] =
            isBillingAndShippingAddressSame ? addressController.text.trim() : shippingAddressController.text.trim();
        body[RequestKeys.shippingCountry] =
            isBillingAndShippingAddressSame ? countryController.text.trim() : shippingCountryController.text.trim();
        body[RequestKeys.shippingCountryId] = isBillingAndShippingAddressSame ? '0' : '0';
        body[RequestKeys.shippingState] =
            isBillingAndShippingAddressSame ? stateController.text.trim() : shippingStateController.text.trim();
        body[RequestKeys.shippingStateId] = isBillingAndShippingAddressSame ? '0' : '0';
        body[RequestKeys.shippingCity] =
            isBillingAndShippingAddressSame ? cityController.text.trim() : shippingCityController.text.trim();
        body[RequestKeys.shippingCityId] = isBillingAndShippingAddressSame ? '0' : '0';
        body[RequestKeys.shippingPincode] =
            isBillingAndShippingAddressSame ? pincodeController.text.trim() : shippingPincodeController.text.trim();
        body[RequestKeys.document] = selectedImageBase64.value;
        body[RequestKeys.filename] = selectedImageFileName.value;
        body[RequestKeys.latitude] = currentPosition?.latitude.toString() ?? '0';
        body[RequestKeys.longitude] = currentPosition?.longitude.toString() ?? '0';
        body[RequestKeys.location] = googleAddressController.text;

        var res = await api.addCompanyJson(json.encode(body));
        if (res.status == 200) {
          backTap();
          ShowMessage.showSnackBar('addCompanyJson Success Res', res.message.toString());
        } else {
          ShowMessage.showSnackBar('addCompanyJson res.status not 200', res.message.toString());
        }
      } catch (e) {
        ShowMessage.showSnackBar('addCompanyJson catch', '$e');
      } finally {
        setBusy(false);
      }
    }
  }
}
