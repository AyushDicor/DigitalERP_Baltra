import 'package:digitalerp/response/get_parentgroup_resp.dart';
import 'package:digitalerp/response/get_party_for_parent_resp.dart';
import 'package:digitalerp/response/show_all_party_outstanding_resp.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MisOutstandingController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();
  List<GetParentGroupData> parentGroupList = [];
  List<GetPartyForParentData> partyNameList = [];
  GetParentGroupData? parent;
  GetPartyForParentData? party;
  List<MisOutstandingData>? list;
  var daysCtr = TextEditingController();

  @override
  onInit() async {
    setBusy(true);
    await getParentGroupList();
    setBusy(false);
    super.onInit();
  }

  Future<void> getParentGroupList() async {
    try {
      Map<String, String> body = {};
      // body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '342613';
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      // body[RequestKeys.executiveId] = executiveId ?? '0';
      var res = await api.getParentGroup(body);
      if (res.status == 200) {
        parentGroupList = res.data ?? [];
        update();
      } else {
        ShowMessage.showSnackBar('Failed Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('catch Server Res', '$e');
    }
  }

  Future<void> getPartyNameList() async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '342613';
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.branchId] = homeController.currentUserData?.branchId.toString() ?? '';
      body[RequestKeys.parentid] = parent?.parentid.toString() ?? '0';
      var res = await api.getPartyForParent(body);
      if (res.status == 200) {
        partyNameList = res.data ?? [];
        update();
      } else {
        ShowMessage.showSnackBar('Failed Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('catch Server Res', '$e');
    }
  }

  void setGroupParty(GetParentGroupData? parent) {
    this.parent = parent;
    party = null;
    getPartyNameList();
    update();
  }

  void onSearch() async {
    if (parent == null) {
      ShowMessage.showSnackBar('Error', 'PLease Select Parent Group');
      return;
    // } else if (party == null) {
    //   ShowMessage.showSnackBar('Error', 'PLease Select Party Name');
    //   return;
    } else if (daysCtr.text.isEmpty) {
      ShowMessage.showSnackBar('Error', 'PLease Enter Days');
      return;
    } else if (int.parse(daysCtr.text) < 0) {
      ShowMessage.showSnackBar('Error', 'PLease Enter Valid Days');
      return;
    }
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '342613';
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.branchId] = homeController.currentUserData?.branchId.toString() ?? '';
      body[RequestKeys.parentid] = parent?.parentid.toString() ?? '0';
      body[RequestKeys.partyId] = party?.partyid.toString() ?? '0';
      body[RequestKeys.days] = daysCtr.text;
      var res = await api.showAllPartyOutstanding(body);
      setBusy(false);
      if (res.status == 200) {
        list = res.data ?? [];

        update();
      } else {
        ShowMessage.showSnackBar('Failed Server Res', res.message.toString());
      }
    } catch (e) {
      setBusy(false);
      ShowMessage.showSnackBar('catch Server Res', '$e');
    }
  }

  void setPartyName(GetPartyForParentData? party) {
    this.party = party;
    update();
  }
}
