import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/login_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/shared_pre.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../change_company/branch_list_response.dart';

  class LoginController extends AppBaseController {
  final TextEditingController mobileCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final FocusNode mobileFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  bool isShowPassword = true;

  @override
  void onInit() {
    super.onInit();

    // Safe cast — OTP screen passes List<String>, error args pass Map
    final args = Get.arguments;
    if (args is Map && args['error'] != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ShowMessage.showSnackBar('Access Denied', args['error']);
      });
    }
  }

  // Add this method inside LoginController class
  Future<void> _autoSelectFirstBranch() async {
    try {
      // Get the latest saved user data
      UserData? userData = await getLoginUserData();   // This is from your BaseController

      if (userData == null) {
        debugPrint("UserData not found");
        return;
      }

      // Prepare body for branch list API
      Map<String, String> body = {
        RequestKeys.compId: userData.compId?.toString() ?? '39',
        RequestKeys.userId: userData.userid?.toString() ?? '',
      };

      // Call your branch list API
      BranchListResponse res = await api.getBranchList(body);

      if (res.status == 200 &&
          res.data != null &&
          res.data!.isNotEmpty) {

        // Filter out invalid branches (branchid = 0)
        final validBranches = res.data!.where((b) => b.branchid != 0).toList();

        if (validBranches.isEmpty) {
          debugPrint("No valid branches found");
          return;
        }

        // ✅ AUTO SELECT THE FIRST BRANCH
        final firstBranch = validBranches.first;

        // Update userData with selected branch
        userData.branchId = firstBranch.branchid;

        // Save updated userData back to SharedPreferences
        await SharedPre.setValue(SharedPre.userData, userData.toJson());

        // Also save current branch separately (recommended)
        await SharedPre.setValue(SharedPre.currentBranchId, firstBranch.branchid.toString());
        await SharedPre.setValue(SharedPre.currentBranchName, firstBranch.branchname ?? "Default Branch");

        debugPrint("✅ Auto-selected first branch: ${firstBranch.branchid} - ${firstBranch.branchname}");

      } else {
        debugPrint("Branch list API failed: ${res.message}");
      }
    } catch (e) {
      debugPrint("Auto select first branch error: $e");
    }
  }

  Future<void> clickOnLogin() async {
    mobileFocus.unfocus();
    passwordFocus.unfocus();
    String? deviceID = await getDeviceIdentifier();
    setBusy(true);
    try {
      if (_isValidate()) {
        Map<String, String> body = {};
        body[RequestKeys.mobile] = mobileCtrl.text.trim();
        body[RequestKeys.password] = passwordCtrl.text.trim();
        body[RequestKeys.deviceId] = deviceID ?? 'abcde874556';
        LoginResponse res = await api.loginApi(body);

        if (res.status == 200 && res.data != null) {
          UserData? userData = res.data;

          SharedPre.setValue(SharedPre.userData, userData?.toJson());
          SharedPre.setValue(SharedPre.isLogin, true);

          if (userData?.mobileVerifyStatus == 0) {
            Get.toNamed(AppRoutes.otp, arguments: [
              mobileCtrl.text.trim(),
              passwordCtrl.text.trim()
            ]);
          } else if (userData?.profileStatus == 0) {
            Get.offAndToNamed(AppRoutes.setupProfile);
          } else {
            await _autoSelectFirstBranch();


            mobileCtrl.clear();
            passwordCtrl.clear();
            Get.offAndToNamed(AppRoutes.home);
          }
        }
        // else {
        //   // ✅ SHOW ACTUAL ERROR
        //   ShowMessage.showSnackBar(
        //     'Login Failed',
        //     res.message ?? 'Invalid credentials',
        //   );
        // }
         else {
          String msg = res.message ?? "";

          if (msg.toLowerCase().contains("mobile")) {
            msg = "Invalid mobile number or password";
          }

          ShowMessage.showSnackBar("Login Failed", msg);
        }
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
    }
    update();
  }

  void tapOnShowPassword() {
    isShowPassword = !isShowPassword;
    update();
  }

  bool _isValidate() {
    if (mobileCtrl.text.isEmpty) {
      ShowMessage.showSnackBar(
        AppString.requiredFieldTxt.tr,
        AppString.pleaseEnterMobileTxt.tr,
      );
      return false;
    }
    if (passwordCtrl.text.isEmpty) {
      ShowMessage.showSnackBar(
        AppString.requiredFieldTxt.tr,
        AppString.pleaseEnterPasswordTxt.tr,
      );
      return false;
    }
    return true;
  }

  void tapOnForgotPassword() {
    mobileFocus.unfocus();
    passwordFocus.unfocus();
    Get.toNamed(AppRoutes.forgotPassword)?.then((value) {
      mobileCtrl.clear();
      passwordCtrl.clear();
      return null;
    });
  }
}
