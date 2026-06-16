import 'package:digitalerp/catalouge/catalogue_list_response.dart';
import 'package:digitalerp/response/stcok_category_data_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:get/get.dart';

class CatalougeController extends AppBaseController{
  HomeController homeController =Get.find<HomeController>();
  List<StockCategoryList> categoryList =[];
  StockCategoryList? selectCategory;
  List<CatalougeData> catalougeData =[];

@override
  void onInit() {
  getCategoryDropdown();
    super.onInit();
  }

  void setSelectedCategoryDropDown(StockCategoryList value){
    selectCategory = value;
    update();
  }


  void getCategoryDropdown() async {
    setBusy(true);
    try {
      Map<String, String> body = {
        RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '',
        RequestKeys.branchId: homeController.currentUserData?.branchId.toString() ?? '',
      };

      var res = await api.getCategoryCatalougeData(body);
      if (res.status == 200) {
        categoryList = res.data ?? [];
      } else {
        ShowMessage.showSnackBar(
            'categoryList Server res.status not 200', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
    }
  }

  Future<void> getCatalougeListApi(String categoryId) async {
    setBusy(true);
    try{
      Map<String,String > body= {};
      body[RequestKeys.compId] =
      // '68';
      homeController.currentUserData?.compId.toString()??'';
      body[RequestKeys.branchId] =
      // "121";
          homeController.currentUserData?.branchId.toString()??'';
      body[RequestKeys.userId] =
      // "121";
          homeController.currentUserData?.userid .toString()??'';
      body[RequestKeys.categoryId] =
     categoryId.toString();
      // categoryId.toString()??'';

      var res = await api.catalogueList(body);
      if(res.status ==200){
         catalougeData = res.data ??[];
      }else{
        // ShowMessage.showSnackBar('CatalogueListJson not res.200', res.message.toString());
      }
    }catch(e){
      ShowMessage.showSnackBar("CatalogueListJson catch", e.toString());
    }
    finally{
      setBusy(false);
    }
  }


}