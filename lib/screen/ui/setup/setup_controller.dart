import 'dart:convert';

import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/login_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/shared_pre.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SetupController extends AppBaseController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();
  UserData userData = UserData();
  final picker = ImagePicker();
  var selectedImage = ''.obs;
  var selectedImageBase64 = ''.obs;
  var selectedImageFileName = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }

  void getData() async {
    userData = (await userDataController.getUserData)!;
    nameController.text = userData.name ?? '';
    emailController.text = userData.email ?? '';
    addressController.text = userData.address ?? '';
    update();
  }

  void setSelectedImage(String value) {
    selectedImage.value = value;
    update();
  }

  void tapOnSetupProfile() {
    nameFocus.unfocus();
    emailFocus.unfocus();
    addressFocus.unfocus();
    updateProfile();
  }

  void tapOnSkip() {
    nameFocus.unfocus();
    emailFocus.unfocus();
    addressFocus.unfocus();
    Get.offAndToNamed(AppRoutes.home);
  }

  bool _isValidate() {
    if (nameController.text.isEmpty) {
      ShowMessage.showSnackBar(
        AppString.requiredFieldTxt.tr,
        AppString.pleaseEnterNameTxt.tr,
      );
      return false;
    }
    if (emailController.text.isEmpty) {
      ShowMessage.showSnackBar(
        AppString.requiredFieldTxt.tr,
        AppString.pleaseEnterEmailTxt.tr,
      );
      return false;
    }
    if (!emailController.text.isEmail) {
      ShowMessage.showSnackBar(
        AppString.requiredFieldTxt.tr,
        AppString.pleaseEnterValidEmailTxt.tr,
      );
      return false;
    }
    if (emailController.text.isHaveEmoji) {
      ShowMessage.showSnackBar(
        AppString.pleaseCheckTxt.tr,
        AppString.pleaseEnterValidEmailTxt.tr,
      );
      return false;
    }

    if (addressController.text.isEmpty) {
      ShowMessage.showSnackBar(
        AppString.requiredFieldTxt.tr,
        AppString.pleaseEnterAddress.tr,
      );
      return false;
    }
    if (addressController.text.isHaveEmoji) {
      ShowMessage.showSnackBar(
        AppString.pleaseCheckTxt.tr,
        AppString.pleaseEnterValidAddressTxt.tr,
      );
      return false;
    }
    return true;
  }

  void updateProfile() async {
    setBusy(true);
    try {
      if (_isValidate()) {
        Map<String, String> body = {};
        body[RequestKeys.userId] = userData.userid.toString();
        body[RequestKeys.compId] = userData.compId.toString();
        body[RequestKeys.name] = nameController.text.trim();
        body[RequestKeys.email] = emailController.text.trim();
        body[RequestKeys.address] = addressController.text.trim();
        body[RequestKeys.photo] = selectedImageBase64.value;
        body[RequestKeys.filename] = selectedImageFileName.value;

        /// json body
        var res = await api.updateProfileJson(json.encode(body));
        //   var res = await api.updateProfile(body);
        if (res.status == 200) {
          SharedPre.setValue(SharedPre.userData, res.data?.toJson());
          ShowMessage.showSnackBar('Success Server Res', res.message.toString());
          getData();
          Get.offAndToNamed(AppRoutes.home);
        } else {
          ShowMessage.showSnackBar('Failed Server Res', res.message.toString());
        }
      }
    } catch (e) {
      ShowMessage.showSnackBar('', '$e');
    } finally {
      setBusy(false);
    }
  }
}
