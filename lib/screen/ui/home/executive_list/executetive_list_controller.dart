import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/executive_list_with_lat_long_response.dart';
import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:get/get.dart';

class ExecutiveListController extends AppBaseController {
  final HomeController homeController = Get.find<HomeController>();
  ExecutiveDropdownData? selectedDropdownValue;
  List<ExecutiveLatLongData> executiveList = [];
  List<ExecutiveDropdownData>? executiveDropdownList = [];

  @override
  void onInit() async {
    // TODO: implement onInit
    await getDropdownList();
    super.onInit();
  }

  void setSelectDropdownValue(value) {
    selectedDropdownValue = value;
    getExecutiveListWithLatLong();
    update();
  }

  Future<void> getDropdownList() async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] =
          homeController.currentUserData?.userid.toString() ?? '';
      body[RequestKeys.compId] =
          homeController.currentUserData?.compId.toString() ?? '';
      var res = await api.getExecutiveDropdown(body);
      if (res.status == 200) {
        executiveDropdownList?.addAll(res.data!);
        // if (dropdownList?.length == 1) {
        //   setSelectDropdownValue(dropdownList?[0]);
        // }
        // else{
        await getExecutiveListWithLatLong();
        // }
      } else {
        final msg = res.message ?? 'Executive dropdown unavailable';
        ShowMessage.showSnackBar('Server Res', msg);
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
    }
  }

  Future<void> getExecutiveListWithLatLong() async {
    executiveList.clear();
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] =
          homeController.currentUserData?.userid.toString() ?? '';
      body[RequestKeys.compId] =
          homeController.currentUserData?.compId.toString() ?? '';
      body[RequestKeys.executiveId] =
          selectedDropdownValue?.executiveId.toString() ?? '';
      var res = await api.getExecutiveListWithLatLong(body);
      if (res.status == 200) {
        executiveList.addAll(res.data ?? []);
        update();
      } else {
        //ShowMessage.showSnackBar('Failed Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('catch Server Res', '$e');
    } finally {}
  }

  void tapOnLiveLocation(int index) {
    Get.toNamed(AppRoutes.map, arguments: executiveList[index]);
  }

  void tapOnCalender(int index) {
    // Get.toNamed(AppRoutes.executiveAttendance,
    //     arguments: executiveList[index].userid.toString());
    Get.toNamed(AppRoutes.executiveAttendance,
        arguments: executiveList[index]); // ← full ExecutiveLatLongData
  }
}
