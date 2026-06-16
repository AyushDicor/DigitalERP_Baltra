import 'dart:io';

import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/executive_list_response.dart';
import 'package:digitalerp/response/image_list_resp.dart';
import 'package:digitalerp/response/stcok_category_data_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();
  ExecutiveList? selectedUsernameDropdownValue;
  StockCategoryList? selectedGroupDropdownValue;
  List<ImageListRespData>? imageList;
  List<ExecutiveList>? userNameList;

  List<StockCategoryList>? groupList;

  final picker = ImagePicker();

  @override
  void onInit() async {
    setBusy(true);
    await getImageList();
    await getExecutiveList();
    await getGroupList();
    setBusy(false);
    super.onInit();
  }

  void setSelectGroup(StockCategoryList? value) async{
    selectedGroupDropdownValue = value;
    update();
    setBusy(true);
    await getImageList();
    setBusy(false);
  }

  void setSelectExecute(ExecutiveList? value)async {
    selectedUsernameDropdownValue = value;
    update();
    setBusy(true);
    await getImageList();
    setBusy(false);
  }

  Future<void> getImageList() async {
    imageList=null;
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '342613';
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.executiveId] = selectedUsernameDropdownValue?.executiveid.toString()??'0';
      body['groupid'] = selectedGroupDropdownValue?.categoryid.toString()??'0';
      setBusy(true);
      var res = await api.imageList(body);
      setBusy(false);
      if (res.status == 200) {
        imageList = res.data ?? [];
      } else {
        ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {

    }
  }

  Future<void> getExecutiveList() async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '342613';
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      var res = await api.executiveReportPersonListForeImageStamping(body);
      if (res.status == 200) {
        userNameList = res.data ?? [];
      } else {
        //ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {

    }
  }

  Future<void> getGroupList() async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      var res = await api.categoryListForeImageStamping(body);
      if (res.status == 200) {
        groupList = res.data ?? [];
      } else {
        //ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {

    }
  }

  void tapOnCard(int index) {
    Get.toNamed(AppRoutes.imageDetail, arguments: imageList![index]);
  }

  // void tapOnCamera() async {
  //   String location = await getUserCurrentAddress();
  //   // Get.back();
  //   var pickedFile = await picker.pickImage(
  //     source: ImageSource.camera,
  //     imageQuality: 65,
  //   );
  //   if (pickedFile != null) {
  //     Get.toNamed(AppRoutes.imagePreview,
  //         arguments: ImagePreviewArgument(File(pickedFile.path), location));
  //   }
  // }

  void tapOnCamera() async {
    Get.toNamed(AppRoutes.imagePreviewCam);
  }
}

class CommonDropdown {
  int index;
  String value;

  CommonDropdown(this.index, this.value);

  @override
  String toString() {
    return 'CommonDropdown{index: $index, value: $value}';
  }
}

class ImagePreviewArgument {
  File file;
  String location,lat,long;

  ImagePreviewArgument({
    required this.file,
    required this.location,
    required this.lat,
    required this.long,
  });
}
