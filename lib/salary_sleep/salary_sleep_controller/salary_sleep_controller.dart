import 'package:digitalerp/response/download_salary_sleep_res.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:get/get.dart';

class SalarySleepController  extends AppBaseController{
  HomeController homeController = Get.find<HomeController>();

  List<DownloadSalarySleepData> salarySleepData=[];

  @override
  void onInit() {
    super.onInit();
    getSalarySleepList();
  }

  void getSalarySleepList() async {
    setBusy(true);
    try{
      Map<String, String>body ={};
      body[RequestKeys.compId] = // '68';
      homeController.currentUserData?.compId.toString()??'';
      body[RequestKeys.branchId] = // "121";
      homeController.currentUserData?.branchId.toString()??'';
      body[RequestKeys.userId] = // "462675";
      homeController.currentUserData?.userid.toString()??'';
      body[RequestKeys.yearId] = homeController.currentUserData?.yearId.toString()??"";

      var res = await api.salarySleepApi(body);
      if(res.status==200){
        salarySleepData = res.data ??[];
      }
      else{
        ShowMessage.showSnackBar('Salary Sleep res.status not 200', res.message.toString());
      }
    }catch(e){
      ShowMessage.showSnackBar('Salary Sleep List catch', '$e');
    }
    finally{
      setBusy(false);
    }
  }


}