// import 'dart:convert';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/home_controller.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/show_message.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
//
// class LeadManagementController extends AppBaseController {
//   HomeController homeController = Get.find<HomeController>();
//
//   //  Lead list (used by LeadManagementView) 
//   // Replace `dynamic` with your actual LeadData model once the API is wired up
//   List<dynamic> leadList = [];
//
//   //  Text controllers 
//   /// Lead entry
//   final TextEditingController leadNumberController = TextEditingController();
//   final TextEditingController requirementController = TextEditingController();
//   final TextEditingController companyNameController = TextEditingController();
//   final TextEditingController ownerNameController = TextEditingController();
//   final TextEditingController contactPersonController = TextEditingController();
//   final TextEditingController mobileNumberController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController alternateNumberController = TextEditingController();
//   final TextEditingController websiteController = TextEditingController();
//   final TextEditingController companyAddressController = TextEditingController();
//   final TextEditingController phoneNumberController = TextEditingController();
//   final TextEditingController businessNatureController = TextEditingController();
//
//   /// Followup details
//   final TextEditingController addressController = TextEditingController();
//   final TextEditingController specificationController = TextEditingController();
//   final TextEditingController remarksController = TextEditingController();
//   final TextEditingController followupTimeController = TextEditingController();
//   final TextEditingController remarkFollowController = TextEditingController();
//
//   //  Focus nodes 
//   /// Lead entry
//   final FocusNode leadNoFocus = FocusNode();
//   final FocusNode requirementFocus = FocusNode();
//   final FocusNode companyNameFocus = FocusNode();
//   final FocusNode ownerNameFocus = FocusNode();
//   final FocusNode contactPersonFocus = FocusNode();
//   final FocusNode mobileNoFocus = FocusNode();
//   final FocusNode alternateNoFocus = FocusNode();
//   final FocusNode emailIdFocus = FocusNode();
//   final FocusNode websiteFocus = FocusNode();
//   final FocusNode companyAddresFocus = FocusNode();
//   final FocusNode phoneFocus = FocusNode();
//   final FocusNode businessFocus = FocusNode();
//
//   /// Followup details
//   final FocusNode addressFocus = FocusNode();
//   final FocusNode specificationFocus = FocusNode();
//   final FocusNode remarkFocus = FocusNode();
//   final FocusNode followupTimeFocus = FocusNode();
//   final FocusNode remarkFollowupFocus = FocusNode();
//
//   //  Observable 
//   RxBool isCheck = false.obs;
//
//   void onChangeValue(var value) {
//     isCheck.value = value;
//   }
//
//   //  Date fields 
//   String selectDate = 'Lead Date';
//   void setSelectedDate(String value) {
//     selectDate = value;
//     update();
//   }
//
//   void clearSelectedDate() {
//     selectDate = 'Lead Date';
//     update();
//   }
//
//   String selectDatef = 'Entry Date';
//   void setSelectedDatef(String value) {
//     selectDatef = value;
//     update();
//   }
//
//   void clearSelected() {
//     selectDatef = 'Entry Date';
//     update();
//   }
//
//   String selectDate2 = 'Entry Date';
//   void setSelectedDate2(String value) {
//     selectDate2 = value;
//     update();
//   }
//
//   void clearSelected2() {
//     selectDate2 = 'Entry Date';
//     update();
//   }
//
//   //  Validation 
//
//   bool _isLeadValidate() {
//     if (leadNumberController.text.trim().isEmpty) {
//       ShowMessage.showSnackBar(
//           AppString.requiredFieldTxt.tr, AppString.pleaseEnterLeadNo.tr);
//       return false;
//     }
//     if (requirementController.text.trim().isEmpty) {
//       ShowMessage.showSnackBar(AppString.requiredFieldTxt.tr,
//           AppString.pleaseEnterRequirementSpecification.tr);
//       return false;
//     }
//     if (companyNameController.text.trim().isEmpty) {
//       ShowMessage.showSnackBar(AppString.requiredFieldTxt.tr,
//           AppString.pleaseEnterCompanyName.tr);
//       return false;
//     }
//     if (ownerNameController.text.trim().isEmpty) {
//       ShowMessage.showSnackBar(AppString.requiredFieldTxt.tr,
//           AppString.pleaseEnterOwnerName.tr);
//       return false;
//     }
//     if (contactPersonController.text.trim().isEmpty) {
//       ShowMessage.showSnackBar(AppString.requiredFieldTxt.tr,
//           AppString.pleaseEnterContactPersonTxt.tr);
//       return false;
//     }
//     if (mobileNumberController.text.trim().isEmpty) {
//       ShowMessage.showSnackBar(AppString.requiredFieldTxt.tr,
//           AppString.pleaseEnterMobileTxt.tr);
//       return false;
//     }
//     if (mobileNumberController.text.trim().length != 10) {
//       ShowMessage.showSnackBar(AppString.requiredFieldTxt.tr,
//           AppString.pleaseEnterValidMobileTxt.tr);
//       return false;
//     }
//     if (alternateNumberController.text.trim().isEmpty) {
//       ShowMessage.showSnackBar(AppString.requiredFieldTxt.tr,
//           AppString.pleaseEnterAlternateMobileNo.tr);
//       return false;
//     }
//     // ✅ FIX: was checking mobileNumber twice — now checks alternateNumber length
//     if (alternateNumberController.text.trim().length != 10) {
//       ShowMessage.showSnackBar(AppString.requiredFieldTxt.tr,
//           AppString.pleaseEnterValidMobileTxt.tr);
//       return false;
//     }
//     if (emailController.text.trim().isEmpty) {
//       ShowMessage.showSnackBar(
//           AppString.requiredFieldTxt, AppString.pleaseEnterEmailIdTxt.tr);
//       return false;
//     }
//     if (websiteController.text.trim().isEmpty) {
//       ShowMessage.showSnackBar(
//           AppString.requiredFieldTxt, AppString.pleaseEnterWebsite.tr);
//       return false;
//     }
//     if (companyAddressController.text.trim().isEmpty) {
//       ShowMessage.showSnackBar(
//           AppString.requiredFieldTxt, AppString.pleaseEnterCompanyAddress.tr);
//       return false;
//     }
//     if (phoneNumberController.text.trim().isEmpty) {
//       ShowMessage.showSnackBar(
//           AppString.requiredFieldTxt, AppString.pleaseEnterPhoneNo.tr);
//       return false;
//     }
//     if (businessNatureController.text.trim().isEmpty) {
//       ShowMessage.showSnackBar(
//           AppString.requiredFieldTxt, AppString.pleaseEnterBusinessNature.tr);
//       return false;
//     }
//     return true;
//   }
//
//   // ✅ FIX: Removed unreachable code that came after `return true` inside
//   // the nested block — the original had dead validation checks after that.
//   bool _isFollowupValidate() {
//     if (addressController.text.trim().isEmpty) {
//       ShowMessage.showSnackBar(
//           AppString.requiredFieldTxt, AppString.pleaseEnterAddress);
//       return false;
//     }
//     if (selectDatef == 'Entry Date') {
//       ShowMessage.showSnackBar(
//           AppString.requiredFieldTxt, 'Please Select Entry Date');
//       return false;
//     }
//     if (specificationController.text.trim().isEmpty) {
//       ShowMessage.showSnackBar(AppString.requiredFieldTxt,
//           AppString.pleaseEnterRequirementSpecification);
//       return false;
//     }
//     if (remarksController.text.trim().isEmpty) {
//       ShowMessage.showSnackBar(
//           AppString.requiredFieldTxt, AppString.pleaseEnterRemark);
//       return false;
//     }
//     if (followupTimeController.text.trim().isEmpty) {
//       ShowMessage.showSnackBar(
//           AppString.requiredFieldTxt, AppString.pleaseEnterFollowupTime);
//       return false;
//     }
//     if (remarkFollowController.text.trim().isEmpty) {
//       ShowMessage.showSnackBar(
//           AppString.requiredFieldTxt, AppString.pleaseEnterRemark);
//       return false;
//     }
//     return true;
//   }
//
//   //  API calls 
//
//   void addleadApi() async {
//     unfocus();
//     setBusy(true);
//     if (_isLeadValidate()) {
//       try {
//         // TODO: populate body with actual field values
//         final Map<String, String> body = {};
//         final res = await api.addCompanyJson(json.encode(body));
//         if (res.status == 200) {
//           backTap();
//           ShowMessage.showSnackBar(
//               'Success', res.message.toString());
//         } else {
//           ShowMessage.showSnackBar(
//               'Error', res.message.toString());
//         }
//       } catch (e) {
//         ShowMessage.showSnackBar('Error', '$e');
//       } finally {
//         setBusy(false);
//       }
//     } else {
//       setBusy(false);
//     }
//   }
//
//   void followupDetailsApi() async {
//     unfocus();
//     setBusy(true);
//     if (_isFollowupValidate()) {
//       try {
//         // TODO: populate body with actual field values
//         final Map<String, String> body = {};
//         final res = await api.addCompanyJson(json.encode(body));
//         if (res.status == 200) {
//           backTap();
//           ShowMessage.showSnackBar(
//               'Success', res.message.toString());
//         } else {
//           ShowMessage.showSnackBar(
//               'Error', res.message.toString());
//         }
//       } catch (e) {
//         ShowMessage.showSnackBar('Error', '$e');
//       } finally {
//         setBusy(false);
//       }
//     } else {
//       setBusy(false);
//     }
//   }
//
//   //  Dispose 
//
//   @override
//   void onClose() {
//     // Lead entry controllers
//     leadNumberController.dispose();
//     requirementController.dispose();
//     companyNameController.dispose();
//     ownerNameController.dispose();
//     contactPersonController.dispose();
//     mobileNumberController.dispose();
//     emailController.dispose();
//     alternateNumberController.dispose();
//     websiteController.dispose();
//     companyAddressController.dispose();
//     phoneNumberController.dispose();
//     businessNatureController.dispose();
//     // Followup controllers
//     addressController.dispose();
//     specificationController.dispose();
//     remarksController.dispose();
//     followupTimeController.dispose();
//     remarkFollowController.dispose();
//     super.onClose();
//   }
// }

import 'dart:convert';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LeadManagementController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();

  //  Lead list 
  // Replace `dynamic` with your actual LeadData model once the API returns data
  List<dynamic> leadList = [];

  @override
  void onInit() {
    super.onInit();
    getLeadList(); // ✅ FIX: fetch leads on init so the list is never null/empty
  }

  /// Fetch the lead list from the API.
  /// Replace the body/endpoint below with your actual implementation.
  void getLeadList() async {
    setBusy(true);
    try {
      //  TODO: swap this with your real API call 
      // Example:
      //   final res = await api.getLeadList(homeController.currentUserData?.companyId ?? '');
      //   if (res.status == 200) {
      //     leadList = res.data ?? [];
      //   } else {
      //     ShowMessage.showSnackBar('Error', res.message.toString());
      //   }
      // 
      // Placeholder: keeps list empty until API is wired up
      leadList = [];
    } catch (e) {
      ShowMessage.showSnackBar('Error', '$e');
    } finally {
      setBusy(false);
    }
  }

  //  Text controllers 
  /// Lead entry
  final TextEditingController leadNumberController = TextEditingController();
  final TextEditingController requirementController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController contactPersonController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController alternateNumberController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController companyAddressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController businessNatureController = TextEditingController();

  /// Followup details
  final TextEditingController addressController = TextEditingController();
  final TextEditingController specificationController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();
  final TextEditingController followupTimeController = TextEditingController();
  final TextEditingController remarkFollowController = TextEditingController();

  //  Focus nodes 
  final FocusNode leadNoFocus = FocusNode();
  final FocusNode requirementFocus = FocusNode();
  final FocusNode companyNameFocus = FocusNode();
  final FocusNode ownerNameFocus = FocusNode();
  final FocusNode contactPersonFocus = FocusNode();
  final FocusNode mobileNoFocus = FocusNode();
  final FocusNode alternateNoFocus = FocusNode();
  final FocusNode emailIdFocus = FocusNode();
  final FocusNode websiteFocus = FocusNode();
  final FocusNode companyAddresFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode businessFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();
  final FocusNode specificationFocus = FocusNode();
  final FocusNode remarkFocus = FocusNode();
  final FocusNode followupTimeFocus = FocusNode();
  final FocusNode remarkFollowupFocus = FocusNode();

  //  Observables 
  RxBool isCheck = false.obs;

  void onChangeValue(var value) {
    isCheck.value = value;
  }

  //  Date fields 
  String selectDate = 'Lead Date';
  void setSelectedDate(String value) { selectDate = value; update(); }
  void clearSelectedDate() { selectDate = 'Lead Date'; update(); }

  String selectDatef = 'Entry Date';
  void setSelectedDatef(String value) { selectDatef = value; update(); }
  void clearSelected() { selectDatef = 'Entry Date'; update(); }

  String selectDate2 = 'Entry Date';
  void setSelectedDate2(String value) { selectDate2 = value; update(); }
  void clearSelected2() { selectDate2 = 'Entry Date'; update(); }

  //  Validation 
  bool _isLeadValidate() {
    if (leadNumberController.text.trim().isEmpty) {
      ShowMessage.showSnackBar(AppString.requiredFieldTxt.tr, AppString.pleaseEnterLeadNo.tr);
      return false;
    }
    if (requirementController.text.trim().isEmpty) {
      ShowMessage.showSnackBar(AppString.requiredFieldTxt.tr, AppString.pleaseEnterRequirementSpecification.tr);
      return false;
    }
    if (companyNameController.text.trim().isEmpty) {
      ShowMessage.showSnackBar(AppString.requiredFieldTxt.tr, AppString.pleaseEnterCompanyName.tr);
      return false;
    }
    if (ownerNameController.text.trim().isEmpty) {
      ShowMessage.showSnackBar(AppString.requiredFieldTxt.tr, AppString.pleaseEnterOwnerName.tr);
      return false;
    }
    if (contactPersonController.text.trim().isEmpty) {
      ShowMessage.showSnackBar(AppString.requiredFieldTxt.tr, AppString.pleaseEnterContactPersonTxt.tr);
      return false;
    }
    if (mobileNumberController.text.trim().isEmpty) {
      ShowMessage.showSnackBar(AppString.requiredFieldTxt.tr, AppString.pleaseEnterMobileTxt.tr);
      return false;
    }
    if (mobileNumberController.text.trim().length != 10) {
      ShowMessage.showSnackBar(AppString.requiredFieldTxt.tr, AppString.pleaseEnterValidMobileTxt.tr);
      return false;
    }
    if (alternateNumberController.text.trim().isEmpty) {
      ShowMessage.showSnackBar(AppString.requiredFieldTxt.tr, AppString.pleaseEnterAlternateMobileNo.tr);
      return false;
    }
    // ✅ FIX: was checking mobileNumber length twice — now correctly checks alternateNumber
    if (alternateNumberController.text.trim().length != 10) {
      ShowMessage.showSnackBar(AppString.requiredFieldTxt.tr, AppString.pleaseEnterValidMobileTxt.tr);
      return false;
    }
    if (emailController.text.trim().isEmpty) {
      ShowMessage.showSnackBar(AppString.requiredFieldTxt, AppString.pleaseEnterEmailIdTxt.tr);
      return false;
    }
    if (websiteController.text.trim().isEmpty) {
      ShowMessage.showSnackBar(AppString.requiredFieldTxt, AppString.pleaseEnterWebsite.tr);
      return false;
    }
    if (companyAddressController.text.trim().isEmpty) {
      ShowMessage.showSnackBar(AppString.requiredFieldTxt, AppString.pleaseEnterCompanyAddress.tr);
      return false;
    }
    if (phoneNumberController.text.trim().isEmpty) {
      ShowMessage.showSnackBar(AppString.requiredFieldTxt, AppString.pleaseEnterPhoneNo.tr);
      return false;
    }
    if (businessNatureController.text.trim().isEmpty) {
      ShowMessage.showSnackBar(AppString.requiredFieldTxt, AppString.pleaseEnterBusinessNature.tr);
      return false;
    }
    return true;
  }

  bool _isFollowupValidate() {
    if (addressController.text.trim().isEmpty) {
      ShowMessage.showSnackBar(AppString.requiredFieldTxt, AppString.pleaseEnterAddress);
      return false;
    }
    if (selectDatef == 'Entry Date') {
      ShowMessage.showSnackBar(AppString.requiredFieldTxt, 'Please Select Entry Date');
      return false;
    }
    if (specificationController.text.trim().isEmpty) {
      ShowMessage.showSnackBar(AppString.requiredFieldTxt, AppString.pleaseEnterRequirementSpecification);
      return false;
    }
    if (remarksController.text.trim().isEmpty) {
      ShowMessage.showSnackBar(AppString.requiredFieldTxt, AppString.pleaseEnterRemark);
      return false;
    }
    if (followupTimeController.text.trim().isEmpty) {
      ShowMessage.showSnackBar(AppString.requiredFieldTxt, AppString.pleaseEnterFollowupTime);
      return false;
    }
    if (remarkFollowController.text.trim().isEmpty) {
      ShowMessage.showSnackBar(AppString.requiredFieldTxt, AppString.pleaseEnterRemark);
      return false;
    }
    return true;
  }

  //  API calls 
  void addleadApi() async {
    unfocus();
    setBusy(true);
    if (_isLeadValidate()) {
      try {
        // TODO: populate body with actual field values
        final Map<String, String> body = {};
        final res = await api.addCompanyJson(json.encode(body));
        if (res.status == 200) {
          backTap();
          // ✅ Refresh the list after a successful add
          getLeadList();
          ShowMessage.showSnackBar('Success', res.message.toString());
        } else {
          ShowMessage.showSnackBar('Error', res.message.toString());
        }
      } catch (e) {
        ShowMessage.showSnackBar('Error', '$e');
      } finally {
        setBusy(false);
      }
    } else {
      setBusy(false);
    }
  }

  void followupDetailsApi() async {
    unfocus();
    setBusy(true);
    if (_isFollowupValidate()) {
      try {
        // TODO: populate body with actual field values
        final Map<String, String> body = {};
        final res = await api.addCompanyJson(json.encode(body));
        if (res.status == 200) {
          backTap();
          ShowMessage.showSnackBar('Success', res.message.toString());
        } else {
          ShowMessage.showSnackBar('Error', res.message.toString());
        }
      } catch (e) {
        ShowMessage.showSnackBar('Error', '$e');
      } finally {
        setBusy(false);
      }
    } else {
      setBusy(false);
    }
  }

  //  Dispose 
  @override
  void onClose() {
    leadNumberController.dispose();
    requirementController.dispose();
    companyNameController.dispose();
    ownerNameController.dispose();
    contactPersonController.dispose();
    mobileNumberController.dispose();
    emailController.dispose();
    alternateNumberController.dispose();
    websiteController.dispose();
    companyAddressController.dispose();
    phoneNumberController.dispose();
    businessNatureController.dispose();
    addressController.dispose();
    specificationController.dispose();
    remarksController.dispose();
    followupTimeController.dispose();
    remarkFollowController.dispose();
    super.onClose();
  }
}