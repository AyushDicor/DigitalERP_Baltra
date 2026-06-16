//
// import 'package:digitalerp/catalouge/catalogue_list_response.dart';
// import 'package:digitalerp/catalouge/catalouge_controller.dart';
// import 'package:digitalerp/download_document_management/dawnload_documents_controller.dart';
// import 'package:digitalerp/download_document_management/download_document-list_responce.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:digitalerp/utils/show_message.dart';
// import 'package:digitalerp/utils/solid_app_button.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class CatalougeListView extends StatelessWidget {
//   const CatalougeListView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<CatalougeController>(
//         init: CatalougeController(),
//         builder:(controller){
//           return Scaffold(
//             body: Center(
//               child: Stack(
//                 children: [
//                   Positioned(
//                     top: 0,
//                     left: 0,
//                     right: 0,
//                     bottom: 0,
//                     child: Container(
//                       decoration: const BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage('assets/images/dashboard_bg.png'),
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                       child: SafeArea(
//                         child: MyAppBar(
//                           title: 'Category Catalouge',
//                           onBackTap: () => Get.back(),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                       right: 0,
//                       left: 0,
//                       bottom: 0,
//                       top: Get.height * 0.350,
//                       child: SingleChildScrollView(
//                         child: Column(
//                             children: [
//                               ListView.builder(
//                                 shrinkWrap: true,
//                                 padding: EdgeInsets.zero,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 itemCount: controller.catalougeData.length,
//                                 itemBuilder: (context, index) =>
//                                     _catalougeDetails(controller.catalougeData.elementAt(index),context)
//
//                               ),
//
//                             ]),
//                       )
//
//                   ),
//                   Positioned(
//                       right: 0,
//                       left: 0,
//                       bottom: 0,
//                       top: Get.height * 0.170,
//                       child: Column(
//                           children: [
//                             _categoryDropDown(controller),
//                             SizedBox(height: Get.height * 0.0100,),
//                             SizedBox(height: Get.height * 0.0100,),
//                             SolidAppButton(
//                               onPressed: () {
//                                 if(controller.selectCategory==null|| controller.selectCategory!.categoryname!.isEmpty){
//                                   ShowMessage.showSnackBar('', 'Please Select Document Type');
//                                 }
//                                 else {
//                                   controller.getCatalougeListApi(controller.selectCategory?.categoryid.toString()??'');
//                                   print(controller.selectCategory!.categoryid.toString());
//
//                                 }
//                               },
//                               name: 'Search',
//                               topColor: orangeColor,
//                               bottomColor: red2Color,
//                               textSize: 16,
//                               hPadding: 30,
//                             ),
//                             SizedBox(height: Get.height * 0.0100,),
//
//                           ])
//
//                   ),
//
//                 ],
//               ),
//             ),
//           );
//         });
//   }
//
//   _catalougeDetails(CatalougeData data ,BuildContext context) {
//     return Padding(
//       padding:  const EdgeInsets.all(5.0),
//       child: Column(
//         children: [
//           Card(
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             child: Container(
//               width: Get.width,
//               // height: Get.height * 0.270,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white,
//                   boxShadow: const [
//                     BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 3,
//                         offset: Offset(0, 3))
//                   ]),
//               padding: const EdgeInsets.all(20.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context).size.width*0.60,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Category Name:",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.deepOrange.shade400)),
//                         SizedBox(height: 5,),
//                         Text(
//                             data.categoryname?.toString()??'N/A',
//                             style: TextStyle().newstyle.copyWith(color: Colors.black)),
//                       ],
//                     ),
//                   ),
//
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Catalouge File:",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.deepOrange.shade400)),
//                       SizedBox(height: 5,),
//                       Row(
//                         children: [
//                           Text(' PDF',style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             decoration: TextDecoration.underline,
//                           ),),
//                           SizedBox(width: 5,),
//                           InkWell(
//                             onTap: () async {
//                               print("Link = ${data.catalouhefile}");
//                               launchUrl(Uri.parse(data.catalouhefile.toString()),mode: LaunchMode.externalApplication);
//                             },
//                             child: Image(
//                               image: const AssetImage('assets/images/pdf.png'),
//                               height: Get.height * 0.0310,
//                             ),
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(height: Get.height * 0.0100,),
//
//         ],
//       ),
//     );
//   }
//   Widget _categoryDropDown(CatalougeController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2(
//         buttonHeight: Get.height * 0.0550,
//         buttonWidth: Get.width * 0.900,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: dropdownBoxColor,
//         ),
//         dropdownMaxHeight: 200,
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: dropdownBoxColor,
//           gradient: LinearGradient(
//             colors: [
//               grBottomColor.withValues(alpha:0.2),
//               grTopColor.withValues(alpha:0.2)
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         isExpanded: true,
//         hint: Text(
//           "Select Category",
//           style: const TextStyle().newstyle.copyWith(
//             color: Colors.black,
//           ),
//           // overflow: TextOverflow.ellipsis,
//         ),
//         // value: controller.selectedDocument,
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         value: controller.selectCategory?.categoryid,
//         items: controller.categoryList.map(
//               (items) {
//             return DropdownMenuItem(
//               value: items.categoryid,
//               child: Text(
//                 items.categoryname.toString(),
//                 style: TextStyle().newstyle.copyWith(color: Colors.black),
//               ),
//             );
//           },
//         ).toList(),
//         onChanged: (newValue) => controller.setSelectedCategoryDropDown(
//             controller.categoryList
//                 .firstWhere((element) => element.categoryid == newValue)),
//         // items: controller.filterDocumentData.map(
//         //       (items) {
//         //     return DropdownMenuItem(
//         //       value: items,
//         //       child: Text(
//         //         items.documentname ?? '',
//         //       ),
//         //     );
//         //   },
//         // ).toList(),
//         // onChanged: (newValue){
//         //   controller.onChangedDocumentDataValue(newValue);
//         //   controller.update();
//         // },
//       ),
//     );
//   }
//
// }

import 'package:digitalerp/catalouge/catalogue_list_response.dart';
import 'package:digitalerp/catalouge/catalouge_controller.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CatalougeListView extends StatelessWidget {
  const CatalougeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CatalougeController>(
      init: CatalougeController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F6FA),
          body: SafeArea(
            child: Column(
              children: [
                //  App Bar 
                _AppBar(),

                //  Search bar (dropdown + button) 
                _SearchBar(controller: controller),

                //  Results list 
                Expanded(
                  child: controller.catalougeData.isEmpty
                      ? const Center(
                          child: Text(
                            'No results found',
                            style: TextStyle(
                              fontSize: 16,
                              color: grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                          itemCount: controller.catalougeData.length,
                          itemBuilder: (context, index) => _CatalogueCard(
                            data: controller.catalougeData.elementAt(index),
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// 
// App Bar
// 
class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                size: 20, color: blackColor),
            onPressed: () => Get.back(),
          ),
          const Text(
            'Category Catalogue',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: newTextPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

// 
// Search Bar (dropdown + search button)
// 
class _SearchBar extends StatelessWidget {
  final CatalougeController controller;

  const _SearchBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        children: [
          // Category dropdown
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              buttonHeight: 50,
              buttonPadding: const EdgeInsets.symmetric(horizontal: 16),
              buttonDecoration: BoxDecoration(
                color: const Color(0xFFF5F6FA),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE8E9EF)),
              ),
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.white,
                border: Border.all(color: const Color(0xFFE8E9EF)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              dropdownMaxHeight: 220,
              hint: const Text(
                'Select Category',
                style: TextStyle(fontSize: 14, color: newTextHint),
              ),
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  color: newTextHint, size: 22),
              value: controller.selectCategory?.categoryid,
              items: controller.categoryList.map((items) {
                return DropdownMenuItem(
                  value: items.categoryid,
                  child: Text(
                    items.categoryname.toString(),
                    style: const TextStyle(fontSize: 14, color: blackColor),
                  ),
                );
              }).toList(),
              onChanged: (newValue) => controller.setSelectedCategoryDropDown(
                controller.categoryList
                    .firstWhere((e) => e.categoryid == newValue),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Search button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () {
                if (controller.selectCategory == null ||
                    (controller.selectCategory?.categoryname?.isEmpty ??
                        true)) {
                  ShowMessage.showSnackBar('', 'Please Select a Category');
                } else {
                  controller.getCatalougeListApi(
                      controller.selectCategory?.categoryid.toString() ?? '');
                }
              },
              icon: const Icon(Icons.search_rounded,
                  color: Colors.white, size: 20),
              label: const Text(
                'Search',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: purpleColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 
// Catalogue Card
// 
class _CatalogueCard extends StatelessWidget {
  final CatalougeData data;

  const _CatalogueCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Category icon placeholder
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: purpleLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.folder_open_rounded,
              color: purpleColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),

          // Category name
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Category Name',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: newTextHint,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  data.categoryname?.toString() ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: newTextPrimary,
                  ),
                ),
              ],
            ),
          ),

          // PDF download button
          GestureDetector(
            onTap: () async {
              if (data.catalouhefile != null) {
                await launchUrl(
                  Uri.parse(data.catalouhefile.toString()),
                  mode: LaunchMode.externalApplication,
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: newRedLightColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/iconsnew/pdfIcon.png',
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'PDF',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: newRedColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
