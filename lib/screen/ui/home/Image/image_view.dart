// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:digitalerp/response/executive_list_response.dart';
// import 'package:digitalerp/response/image_list_resp.dart';
// import 'package:digitalerp/response/stcok_category_data_response.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/Image/image_controller.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/gradient_icon_app_button.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ImageView extends StatelessWidget {
//   const ImageView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ImageController>(
//       init: ImageController(),
//       builder: (controller) => Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Center(
//           child: Stack(
//             children: [
//               Positioned(
//                 top: 0,
//                 bottom: 0,
//                 right: 0,
//                 left: 0,
//                 child: Container(
//                   decoration: const BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage(AppAssets.dashboardBg),
//                           fit: BoxFit.fill)),
//                   child: SafeArea(
//                     child: MyAppBar(
//                         title: 'Image capture',
//                       onBackTap: ()=>Get.back(),
//
//                       // onDrawerTap: () => controller.openDrawer(context)
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 right: 0,
//                 left: 0,
//                 bottom: 0,
//                 top: Get.height * 0.135,
//                 child: controller.isBusy
//                     ? showLoader()
//                     : SingleChildScrollView(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         child: Column(
//                           children: [
//                             SizedBox(height: Get.height * 0.02),
//                             _dropdown(controller, 0),
//                             const SizedBox(height: 10),
//                             _dropdownGroup(controller),
//                             const SizedBox(height: 10),
//                             if (controller.imageList?.isEmpty ?? true)
//                               SizedBox(
//                                   height: Get.height * .4,
//                                   child: centerText('No Data found'))
//                             else
//                               ListView.builder(
//                                 shrinkWrap: true,
//                                 padding: EdgeInsets.zero,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 itemCount: controller.imageList?.length ?? 0,
//                                 itemBuilder: (context, index) {
//                                   var data = controller.imageList?[index];
//                                   return InkWell(
//                                     onTap: () => controller.tapOnCard(index),
//                                     child: card(data),
//                                   );
//                                 },
//                               ),
//                             const SizedBox(height: 60),
//                           ],
//                         ),
//                       ),
//               ),
//               Positioned(
//                 right: 18,
//                 bottom: 95,
//                 child: GradientIconButton(
//                   onPressed: () => controller.tapOnCamera(),
//                   icon: AppAssets.cameraIcon,
//                   radius: 15,
//                   vPadding: 20,
//                   iconSize: 20,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget card(ImageListRespData? data) {
//     return Stack(
//       children: [
//         Container(
//           height: 135,
//           width: double.maxFinite,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(15),
//             boxShadow: const [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 3,
//                 offset: Offset(0, 5),
//               )
//             ],
//           ),
//           margin: const EdgeInsets.symmetric(
//             vertical: 10,
//           ),
//           clipBehavior: Clip.antiAlias,
//           child: CachedNetworkImage(
//             imageUrl: data?.image ?? '',
//             fit: BoxFit.cover,
//           ),
//         ),
//         // Positioned(
//         //   left: 0,
//         //   right: 0,
//         //   bottom: 10,
//         //   child: Container(
//         //     decoration: BoxDecoration(
//         //       color: blueColor.withValues(alpha:0.3),
//         //       borderRadius: const BorderRadius.vertical(
//         //         bottom: Radius.circular(15),
//         //       ),
//         //     ),
//         //     padding: const EdgeInsets.symmetric(
//         //       vertical: 8,
//         //       horizontal: 30,
//         //     ),
//         //     alignment: Alignment.center,
//         //     child: Text(
//         //       data?.description ?? '',
//         //       style: const TextStyle().bold.copyWith(
//         //             fontSize: 14,
//         //             color: Colors.white,
//         //           ),
//         //     ),
//         //   ),
//         // ),
//       ],
//     );
//   }
//
//   Widget _dropdownGroup(ImageController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<StockCategoryList?>(
//         buttonHeight: 40,
//         buttonPadding: const EdgeInsets.symmetric(
//           horizontal: 20,
//         ),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: dropdownBoxColor,
//         ),
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: dropdownBoxColor,
//           gradient: customGradient(
//             topColor: grBottomColor,
//             bottomColor: grTopColor,
//             opacity: 0.09,
//           ),
//         ),
//         isExpanded: true,
//         hint: Text(
//           'Select Group',
//           style: const TextStyle().normal.copyWith(fontSize: 12),
//         ),
//         value: controller.selectedGroupDropdownValue,
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         items: controller.groupList?.map((StockCategoryList? value) {
//           return DropdownMenuItem(
//             value: value,
//             child: Text(value?.categoryname.toString() ?? '',
//                 style: const TextStyle()
//                     .medium
//                     .copyWith(fontSize: 14, color: msgTextColor)),
//           );
//         }).toList(),
//         onChanged: controller.setSelectGroup,
//       ),
//     );
//   }
//
//   Widget _dropdown(ImageController controller, int type) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<ExecutiveList>(
//         buttonHeight: 40,
//         buttonPadding: const EdgeInsets.symmetric(
//           horizontal: 20,
//         ),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: dropdownBoxColor,
//         ),
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: dropdownBoxColor,
//           gradient: customGradient(
//             topColor: grBottomColor,
//             bottomColor: grTopColor,
//             opacity: 0.09,
//           ),
//         ),
//         isExpanded: true,
//         hint: Text(
//           'Select Executive name',
//           style: const TextStyle().normal.copyWith(fontSize: 12),
//         ),
//         value: controller.selectedUsernameDropdownValue,
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         items: controller.userNameList?.map((ExecutiveList value) {
//           return DropdownMenuItem(
//             value: value,
//             child: Text(value.executivename.toString(),
//                 style: const TextStyle()
//                     .medium
//                     .copyWith(fontSize: 14, color: msgTextColor)),
//           );
//         }).toList(),
//         onChanged: controller.setSelectExecute,
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:digitalerp/response/executive_list_response.dart';
import 'package:digitalerp/response/image_list_resp.dart';
import 'package:digitalerp/response/stcok_category_data_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/Image/image_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../fab/menu_fab.dart';

class ImageView extends StatelessWidget {
  const ImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageController>(
      init: ImageController(),
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        body: MenuFabBody(
          parentMenuId: 2381,
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    //  App Bar 
                    Container(
                      //color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 16),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x12000000),
                            blurRadius: 12,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: const Icon(Icons.arrow_back_ios_new,
                                color: newTextPrimary, size: 20),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Image Capture',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: newTextPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //  Body 
                    Expanded(
                      child: controller.isBusy
                          ? showLoader(color: newBlueColor)
                          : SingleChildScrollView(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 16, 16, 100),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Executive dropdown
                                  _styledDropdown(
                                    child: _executiveDropdown(controller),
                                  ),
                                  const SizedBox(height: 10),

                                  // Group dropdown
                                  _styledDropdown(
                                    child: _groupDropdown(controller),
                                  ),
                                  const SizedBox(height: 20),

                                  // Image grid / list
                                  (controller.imageList?.isEmpty ?? true)
                                      ? SizedBox(
                                          height: Get.height * .4,
                                          child: centerText('No Data found'),
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount:
                                              controller.imageList?.length ?? 0,
                                          itemBuilder: (context, index) {
                                            final data =
                                                controller.imageList?[index];
                                            return GestureDetector(
                                              onTap: () =>
                                                  controller.tapOnCard(index),
                                              child: _imageCard(data),
                                            );
                                          },
                                        ),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),

                //  FAB 
                Positioned(
                  right: 20,
                  bottom: 28,
                  child: FloatingActionButton(
                    onPressed: () => controller.tapOnCamera(),
                    backgroundColor: purpleColor,
                    shape: const CircleBorder(
                        side: BorderSide(color: Colors.white, width: 2)),
                    elevation: 4,
                    child: const Icon(Icons.add, color: Colors.white, size: 32),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _styledDropdown({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: newBorderColor),
      ),
      child: child,
    );
  }

  Widget _executiveDropdown(ImageController controller) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<ExecutiveList>(
        buttonHeight: 50,
        buttonPadding: const EdgeInsets.symmetric(horizontal: 14),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0x12000000),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        dropdownMaxHeight: 220,
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0x12000000),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        isExpanded: true,
        hint: const Text(
          'Select Executive Name',
          style: TextStyle(fontSize: 14, color: newTextHint),
        ),
        value: controller.selectedUsernameDropdownValue,
        icon: const Icon(Icons.keyboard_arrow_down_rounded,
            color: newTextSecondary, size: 22),
        items: controller.userNameList?.map((ExecutiveList value) {
          return DropdownMenuItem(
            value: value,
            child: Text(
              value.executivename.toString(),
              style: const TextStyle(fontSize: 14, color: newTextPrimary),
            ),
          );
        }).toList(),
        onChanged: controller.setSelectExecute,
      ),
    );
  }

  Widget _groupDropdown(ImageController controller) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<StockCategoryList?>(
        buttonHeight: 50,
        buttonPadding: const EdgeInsets.symmetric(horizontal: 14),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0x12000000),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        dropdownMaxHeight: 220,
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0x12000000),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        isExpanded: true,
        hint: const Text(
          'Select Group',
          style: TextStyle(fontSize: 14, color: newTextHint),
        ),
        value: controller.selectedGroupDropdownValue,
        icon: const Icon(Icons.keyboard_arrow_down_rounded,
            color: newTextSecondary, size: 22),
        items: controller.groupList?.map((StockCategoryList? value) {
          return DropdownMenuItem(
            value: value,
            child: Text(
              value?.categoryname.toString() ?? '',
              style: const TextStyle(fontSize: 14, color: newTextPrimary),
            ),
          );
        }).toList(),
        onChanged: controller.setSelectGroup,
      ),
    );
  }

  Widget _imageCard(ImageListRespData? data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: newBorderColor),
        boxShadow: [
          BoxShadow(
            color: const Color(0x12000000),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image area
          SizedBox(
            height: 180,
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: data?.image ?? '',
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: newSurfaceColor,
                child: const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: newBlueColor,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: newSurfaceColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.broken_image_outlined,
                        color: newTextHint, size: 36),
                    const SizedBox(height: 8),
                    const Text(
                      'Image not available',
                      style: TextStyle(fontSize: 12, color: newTextHint),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Description row (if any)
          if ((data?.description ?? '').isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Text(
                data?.description ?? '',
                style: const TextStyle(
                  fontSize: 13,
                  color: newTextSecondary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
