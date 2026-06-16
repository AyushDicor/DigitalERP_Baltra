// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/order/select_brand/select_brand_controller.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/app_network_image.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class SelectBrandView extends StatelessWidget {
//   const SelectBrandView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<SelectBrandController>(
//       init: SelectBrandController(),
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
//                   decoration:  const BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage(AppAssets.dashboardBg),
//                           fit: BoxFit.fill)),
//                   child: SafeArea(
//                     child: MyAppBar(
//                       title: 'Select Brand',
//                       onBackTap: () => controller.backTap(),
//                       showCartIcon: true,
//                       onCartTap: () => controller.onCartTap(),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 right: 0,
//                 left: 0,
//                 top: Get.height * 0.125,
//                 bottom: 0,
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: controller.isBusy
//                       ? SizedBox(
//                       height: Get.height*.50,child: showLoader())
//                       :
//                   Column(
//                     children: [
//                       /*_imageSection(controller),*/
//                       _brandSection(controller),
//                       const SizedBox(height: 70),
//                     ],
//                   ),
//                 ),
//               ),
//               /*Align(
//                 alignment: Alignment.bottomCenter,
//                 child: AppBottomButton(
//                     onPressed: () => controller.tapOnNext(), name: 'Next'),
//               )*/
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
// /*
//   Widget _imageSection(SelectCategoryController controller) {
//     return SizedBox(
//       height: 170,
//       child: Stack(
//         children: [
//           PageView.builder(
//             clipBehavior: Clip.antiAlias,
//             scrollDirection: Axis.horizontal,
//             onPageChanged: (index) {
//               controller.onBannerChange(index);
//             },
//             controller: controller.pageController,
//             itemCount: controller.bannerSlideList.length,
//             itemBuilder: (BuildContext context, int i) {
//               var item = controller.bannerSlideList[i];
//               return Container(
//                 height: 170,
//                 width: double.maxFinite,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(15),
//                     boxShadow: const [
//                       BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 5,
//                           offset: Offset(0, 5))
//                     ]),
//                 margin: const EdgeInsets.symmetric(vertical: 10),
//                 clipBehavior: Clip.antiAlias,
//                 child: CachedNetworkImage(
//                   imageUrl: controller.bannerSlideList[i].categoryimage ?? '',
//                   fit: BoxFit.fill,
//                 ),
//               );
//             },
//           ),
//           Positioned(
//             left: 0,
//             right: 0,
//             bottom: 15,
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: List.generate(
//                   controller.bannerSlideList.length,
//                       (index) => Container(
//                     width: 5,
//                     height: 5,
//                     margin: const EdgeInsets.only(left: 5),
//                     decoration: BoxDecoration(
//                         color: index == controller.pageIndex
//                             ? Colors.blue
//                             : const Color(0xffC0D3E8),
//                         borderRadius: BorderRadius.circular(5),
//                         border: Border.all(
//                             color: const Color(0xffC0D3E8), width: 0)),
//                   ),
//                 )),
//           ),
//         ],
//       ),
//     );
//   }
// */
//
//   Widget _brandSection(SelectBrandController controller) {
//     return GridView.builder(
//       physics: const NeverScrollableScrollPhysics(),
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       shrinkWrap: true,
//       itemCount: controller.brandListItem.length,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2, crossAxisSpacing: 10),
//       itemBuilder: (context, index) {
//         return brandCard(controller, index);
//       },
//     );
//   }
//
//   Widget brandCard(SelectBrandController controller, int index) {
//     var isSelected = false /*controller.selectedIndex == index*/;
//     // var isSelected = controller.categoryList[index].select;
//     LinearGradient cardGradient = customGradient(
//         topColor: index % controller.brandListItem.length == 0
//             ? orangeColor
//             : index % 4 == 1
//             ? purpleColor
//             : index % 4 == 2
//             ? red3Color
//             : orangeColor,
//         bottomColor: index % 4 == 0
//             ? red2Color
//             : index % 4 == 1
//             ? blueColor
//             : index % 4 == 2
//             ? red4Color
//             : const Color(0xFFCC3E0A),
//         opacity: .26);
//     return InkWell(
//       onTap: () {
//         controller.onClick(index);
//       },
//       child: Stack(
//         children: [
//           Card(
//             margin: const EdgeInsets.only(top: 10, right: 10),
//             elevation: 3,
//             shape: RoundedRectangleBorder(
//                 side: BorderSide(
//                     color:
//                     isSelected ? controller.color[index % 4] : Colors.white,
//                     width: 1.5),
//                 borderRadius: BorderRadius.circular(10.0)),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   margin: const EdgeInsets.all(8),
//                   height: 100,
//                   width: double.maxFinite,
//                   decoration: BoxDecoration(
//                     // color: controller.categoryList[index].color.withValues(alpha:0.26),
//                     // gradient: cardGradient,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   clipBehavior: Clip.antiAlias,
//                   child: AppNetworkImage(
//                     image:
//                     controller.brandListItem[index].brandimage ?? '',
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8),
//                   child: FittedBox(
//                     child: Text(
//                       controller.brandListItem[index].brandname ?? '',
//                       textAlign: TextAlign.center,
//                       maxLines: 3,
//                       style: const TextStyle().bold.copyWith(),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//               ],
//             ),
//           ),
//           Positioned(
//             right: 0,
//             top: 0,
//             child: CircleAvatar(
//               radius: 14,
//               backgroundColor: isSelected ? Colors.white : Colors.transparent,
//               child: CircleAvatar(
//                 radius: 12,
//                 backgroundColor: isSelected
//                     ? controller.color[index % 4]
//                     : Colors.transparent,
//                 child: Icon(
//                   Icons.check,
//                   color: isSelected ? Colors.white : Colors.transparent,
//                   size: 14,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/order/select_brand/select_brand_controller.dart';
import 'package:digitalerp/utils/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_constant_new.dart';

class SelectBrandView extends StatelessWidget {
  const SelectBrandView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectBrandController>(
      init: SelectBrandController(),
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 3,
          shadowColor: const Color(0x12000000),
          surfaceTintColor: Colors.white,
          centerTitle: false,
          leading: GestureDetector(
            onTap: () => controller.backTap(),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: newTextPrimary, size: 20),
          ),
          title: const Text('Select Brand',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: newTextPrimary)),
          actions: [
            GestureDetector(
              onTap: () => controller.onCartTap(),
              child: Container(
                margin: const EdgeInsets.only(right: 16),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF0FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.shopping_cart_outlined,
                    color: Color(0xFF5B5FC7), size: 20),
              ),
            ),
          ],
        ),
        body: controller.isBusy
            ? showLoader(color: newBlueColor)
            : GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
                itemCount: controller.brandListItem.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (ctx, i) => _brandCard(controller, i),
              ),
      ),
    );
  }

  Widget _brandCard(SelectBrandController controller, int index) {
    return GestureDetector(
      onTap: () => controller.onClick(index),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE8ECF0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(14)),
                child: AppNetworkImage(
                  image: controller.brandListItem[index].brandimage ?? '',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Text(
                controller.brandListItem[index].brandname ?? '',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: newTextPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
