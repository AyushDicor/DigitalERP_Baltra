// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/order/select_category/product_list/product_list_controller.dart';
// import 'package:digitalerp/utils/app_constant_new.dart';
// import 'package:digitalerp/utils/app_network_image.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../../../utils/all_screens_dialog_box/product_list_filter/product_list_filter_view.dart';
//
// class ProductListView extends StatelessWidget {
//   const ProductListView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ProductListController>(
//       init: ProductListController(),
//       builder: (ctrl) => Scaffold(
//         backgroundColor: Colors.white,
//         body: SafeArea(
//           bottom: false,
//           child: Column(
//             children: [
//               MyAppBar(
//                 title: 'Product',
//                 onBackTap: () => ctrl.backTap(),
//                 onFilterTap: () => Get.dialog(const ProductListFilterView()),
//                 showCartIcon: true,
//                 onCartTap: () => ctrl.tapOnCart2(),
//               ),
//               const SizedBox(height: 8),
//               _searchBar(ctrl),
//               const SizedBox(height: 12),
//               _categoryTabs(ctrl),
//               const SizedBox(height: 12),
//               _listHeader(ctrl),
//               const SizedBox(height: 8),
//               Expanded(
//                 child: ctrl.isListLoading
//                     ? const Center(
//                         child: CircularProgressIndicator(color: newBlueColor))
//                     : ctrl.productList.isEmpty
//                         ? const Center(
//                             child: Text('No products found',
//                                 style: TextStyle(color: newTextSecondary)))
//                         : GridView.builder(
//                             padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
//                             itemCount: ctrl.productList.length,
//                             gridDelegate:
//                                 SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: ctrl.isGridView ? 2 : 1,
//                               childAspectRatio: ctrl.isGridView ? 0.6 : 3.0,
//                               crossAxisSpacing: 12,
//                               mainAxisSpacing: 12,
//                             ),
//                             itemBuilder: (_, i) => ctrl.isGridView
//                                 ? _gridCard(ctrl, i)
//                                 : _listCard(ctrl, i),
//                           ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   //  Search bar 
//   Widget _searchBar(ProductListController ctrl) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: TextFormField(
//         controller: ctrl.searchController,
//         onChanged: ctrl.searchProduct,
//         style: const TextStyle(fontSize: 14, color: newTextPrimary),
//         decoration: InputDecoration(
//           hintText: 'Search',
//           hintStyle: const TextStyle(color: newTextHint, fontSize: 14),
//           prefixIcon:
//               const Icon(Icons.search, color: newTextSecondary, size: 20),
//           filled: true,
//           fillColor: newSurfaceColor,
//           contentPadding:
//               const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//           border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(18),
//               borderSide: const BorderSide(color: newBorderColor)),
//           enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(18),
//               borderSide: const BorderSide(color: newBorderColor)),
//           focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(18),
//               borderSide: const BorderSide(color: newBlueColor, width: 1.5)),
//         ),
//       ),
//     );
//   }
//
//   //  Category tabs 
//   Widget _categoryTabs(ProductListController ctrl) {
//     return SizedBox(
//       height: 40,
//       child: ListView(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         scrollDirection: Axis.horizontal,
//         children: [
//           _catTab(
//               'All', ctrl.selectedIndex == -1, () => ctrl.setSelectedIndex(-1)),
//           ...List.generate(
//             ctrl.subCategoryList.length,
//             (i) => _catTab(
//               ctrl.subCategoryList[i].subcategoryname ?? '',
//               ctrl.selectedIndex == i,
//               () => ctrl.setSelectedIndex(i),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _catTab(String label, bool active, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.only(right: 8),
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         decoration: BoxDecoration(
//           color: active ? Colors.white : Colors.transparent,
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: active ? newBlueColor : newBorderColor),
//         ),
//         alignment: Alignment.center,
//         child: Text(label,
//             style: TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//               color: active ? newBlueColor : newTextSecondary,
//             )),
//       ),
//     );
//   }
//
//   //  List header 
//   Widget _listHeader(ProductListController ctrl) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Text('All Products',
//               style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w800,
//                   color: newTextPrimary)),
//           GestureDetector(
//             onTap: ctrl.tapOnListViewType,
//             child: Container(
//               width: 36,
//               height: 36,
//               decoration: BoxDecoration(
//                   color: newBlueLightColor,
//                   borderRadius: BorderRadius.circular(8)),
//               child: Icon(
//                 ctrl.isGridView
//                     ? Icons.view_list_rounded
//                     : Icons.grid_view_rounded,
//                 size: 20,
//                 color: newBlueColor,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   //  Grid card 
//   Widget _gridCard(ProductListController ctrl, int index) {
//     final item = ctrl.productList[index];
//     return GestureDetector(
//       onTap: () => ctrl.tapOnProduct(item.itemid.toString()),
//       child: Container(
//         decoration: BoxDecoration(
//           color: newSurfaceColor,
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(color: newBorderColor),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Image area
//             Expanded(
//               flex: 3,
//               child: Stack(
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius:
//                           const BorderRadius.vertical(top: Radius.circular(14)),
//                     ),
//                     child: AppNetworkImage(
//                         image: item.itemimage ?? '', fit: BoxFit.contain),
//                   ),
//                   if (true) // discount badge placeholder
//                     Positioned(
//                       top: 8,
//                       left: 8,
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 6, vertical: 2),
//                         decoration: BoxDecoration(
//                             color: newBlueColor,
//                             borderRadius: BorderRadius.circular(4)),
//                         child: const Text('30% OFF',
//                             style: TextStyle(
//                                 fontSize: 9,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.white)),
//                       ),
//                     ),
//                   Positioned(
//                     top: 8,
//                     right: 8,
//                     child: Container(
//                       width: 28,
//                       height: 28,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           shape: BoxShape.circle,
//                           border: Border.all(color: newBorderColor)),
//                       child: const Icon(Icons.favorite_border_rounded,
//                           size: 14, color: newBlueColor),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Info area
//             Expanded(
//               flex: 2,
//               child: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(item.itemname ?? '',
//                         style: const TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600,
//                             color: newTextPrimary),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis),
//                     Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('₹${item.rate?.toStringAsFixed(0) ?? '0'}',
//                               style: const TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w800,
//                                   color: newBlueColor)),
//                           Row(children: [
//                             const Icon(Icons.star_rounded,
//                                 size: 13, color: Color(0xFFF59E0B)),
//                             const SizedBox(width: 2),
//                             const Text('4.4',
//                                 style: TextStyle(
//                                     fontSize: 11, color: newTextSecondary)),
//                           ]),
//                         ]),
//                     _qtyRow(ctrl, index),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   //  List card 
//   Widget _listCard(ProductListController ctrl, int index) {
//     final item = ctrl.productList[index];
//     return GestureDetector(
//       onTap: () => ctrl.tapOnProduct(item.itemid.toString()),
//       child: Container(
//         decoration: BoxDecoration(
//           color: newSurfaceColor,
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(color: newBorderColor),
//         ),
//         child: Row(
//           children: [
//             // Image
//             Stack(children: [
//               Container(
//                 width: 90,
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius:
//                       BorderRadius.horizontal(left: Radius.circular(14)),
//                 ),
//                 child: AppNetworkImage(
//                     image: item.itemimage ?? '', fit: BoxFit.contain),
//               ),
//               Positioned(
//                 top: 6,
//                 left: 6,
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//                   decoration: BoxDecoration(
//                       color: newBlueColor,
//                       borderRadius: BorderRadius.circular(4)),
//                   child: const Text('30% OFF',
//                       style: TextStyle(
//                           fontSize: 8,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.white)),
//                 ),
//               ),
//             ]),
//             // Content
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: Text(item.itemname ?? '',
//                                 style: const TextStyle(
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.w600,
//                                     color: newTextPrimary),
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis),
//                           ),
//                           const Icon(Icons.favorite_border_rounded,
//                               size: 18, color: newBlueColor),
//                         ]),
//                     Row(children: [
//                       const Icon(Icons.star_rounded,
//                           size: 14, color: Color(0xFFF59E0B)),
//                       const SizedBox(width: 3),
//                       const Text('4.4',
//                           style:
//                               TextStyle(fontSize: 12, color: newTextSecondary)),
//                     ]),
//                     Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text('₹${item.rate?.toStringAsFixed(0) ?? '0'}',
//                                     style: const TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.w800,
//                                         color: newBlueColor)),
//                                 const Text('per unit',
//                                     style: TextStyle(
//                                         fontSize: 10, color: newTextSecondary)),
//                               ]),
//                           _qtyRow(ctrl, index),
//                         ]),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   //  Qty controller 
//   Widget _qtyRow(ProductListController ctrl, int index) {
//     final item = ctrl.productList[index];
//     if (!(item.isInCart ?? false)) {
//       return GestureDetector(
//         onTap: () => ctrl.addToCart(index),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//           decoration: BoxDecoration(
//               color: newBlueColor, borderRadius: BorderRadius.circular(20)),
//           child: const Icon(Icons.add, color: Colors.white, size: 16),
//         ),
//       );
//     }
//     return Container(
//       decoration: BoxDecoration(
//           border: Border.all(color: newBlueColor),
//           borderRadius: BorderRadius.circular(20)),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           _qtyBtn(Icons.remove, () {
//             if ((item.quantity ?? 1) > 1)
//               ctrl.productQtyDecrease(index);
//             else
//               ctrl.removeFromCart(index);
//           }),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Text('${item.quantity?.toInt() ?? 1}',
//                 style: const TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w700,
//                     color: newBlueColor)),
//           ),
//           _qtyBtn(Icons.add, () => ctrl.productQtyIncrease(index),
//               filled: true),
//         ],
//       ),
//     );
//   }
//
//   Widget _qtyBtn(IconData icon, VoidCallback onTap, {bool filled = false}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 28,
//         height: 28,
//         decoration: BoxDecoration(
//           color: filled ? newBlueColor : Colors.transparent,
//           shape: BoxShape.circle,
//         ),
//         child:
//             Icon(icon, size: 14, color: filled ? Colors.white : newBlueColor),
//       ),
//     );
//   }
// }

import 'package:digitalerp/screen/ui/home/order/select_category/product_list/product_list_controller.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../utils/all_screens_dialog_box/product_list_filter/product_list_filter_view.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductListController>(
      init: ProductListController(),
      builder: (ctrl) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _appBar(ctrl),
              const SizedBox(height: 10),
              _searchBar(ctrl),
              const SizedBox(height: 10),
              _categoryTabs(ctrl),
              const SizedBox(height: 10),
              _listHeader(ctrl),
              const SizedBox(height: 8),
              Expanded(
                child: ctrl.isListLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: newBlueColor))
                    : ctrl.productList.isEmpty
                        ? const Center(
                            child: Text('No products found',
                                style: TextStyle(color: newTextSecondary)))
                        : ctrl.isGridView
                            //  GRID: GridView with fixed aspect ratio 
                            ? GridView.builder(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 100),
                                itemCount: ctrl.productList.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.62,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                ),
                                itemBuilder: (_, i) => _gridCard(ctrl, i),
                              )
                            //  LIST: ListView so cards self-size naturally 
                            : ListView.builder(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 100),
                                itemCount: ctrl.productList.length,
                                itemBuilder: (_, i) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: _listCard(ctrl, i),
                                ),
                              ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //  AppBar 
  Widget _appBar(ProductListController ctrl) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(8, 6, 12, 6),
      child: Row(children: [
        GestureDetector(
          onTap: () => ctrl.backTap(),
          child: Container(
            width: 38,
            height: 38,
            // decoration: BoxDecoration(
            //     color: newSurfaceColor,
            //     borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                size: 20, color: newTextPrimary),
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Text('Product',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: newTextPrimary)),
        ),
        GestureDetector(
          onTap: () => Get.dialog(const ProductListFilterView()),
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
                color: purpleLightest,
                borderRadius: BorderRadius.circular(18)),
            alignment: Alignment.center,
            child:
                const Icon(Icons.filter_list_sharp, size: 20, color: purpleColor),
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () => ctrl.tapOnCart2(),
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
                color: purpleLightest,
                borderRadius: BorderRadius.circular(18)),
            alignment: Alignment.center,
            child: const Icon(Icons.shopping_cart_outlined,
                size: 20, color: purpleColor),
          ),
        ),
      ]),
    );
  }

  //  Search bar 
  Widget _searchBar(ProductListController ctrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        controller: ctrl.searchController,
        onChanged: ctrl.searchProduct,
        style: const TextStyle(fontSize: 14, color: newTextPrimary),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: const TextStyle(color: newTextHint, fontSize: 14),
          prefixIcon:
              const Icon(Icons.search, color: newTextSecondary, size: 20),
          filled: true,
          fillColor: newSurfaceColor,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: newBorderColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: newBorderColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: newBlueColor, width: 1.5)),
        ),
      ),
    );
  }

  //  Category tabs 
  Widget _categoryTabs(ProductListController ctrl) {
    return SizedBox(
      height: 40,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        children: [
          _catTab(
              'All', ctrl.selectedIndex == -1, () => ctrl.setSelectedIndex(-1)),
          ...List.generate(
            ctrl.subCategoryList.length,
            (i) => _catTab(
              ctrl.subCategoryList[i].subcategoryname ?? '',
              ctrl.selectedIndex == i,
              () => ctrl.setSelectedIndex(i),
            ),
          ),
        ],
      ),
    );
  }

  Widget _catTab(String label, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: active ? newBlueColor : newBorderColor),
        ),
        alignment: Alignment.center,
        child: Text(label,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: active ? newBlueColor : newTextSecondary)),
      ),
    );
  }

  //  List header 
  Widget _listHeader(ProductListController ctrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('All Products',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: newTextPrimary)),
          GestureDetector(
            onTap: ctrl.tapOnListViewType,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                  color: newBlueLightColor,
                  borderRadius: BorderRadius.circular(8)),
              child: Icon(
                ctrl.isGridView
                    ? Icons.grid_view_sharp
                    : Icons.view_list_rounded,
                size: 20,
                color: newBlueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  Grid card 
  Widget _gridCard(ProductListController ctrl, int index) {
    final item = ctrl.productList[index];
    return GestureDetector(
      onTap: () => ctrl.tapOnProduct(item.itemid.toString()),
      child: Container(
        decoration: BoxDecoration(
          color: newSurfaceColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: newBorderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fixed height image — no overflow possible
            SizedBox(
              height: 130,
              child: Stack(children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(14)),
                  ),
                  child: AppNetworkImage(
                      image: item.itemimage ?? '', fit: BoxFit.contain),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                        color: newBlueColor,
                        borderRadius: BorderRadius.circular(4)),
                    child: const Text('30% OFF',
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: newBorderColor)),
                    child: const Icon(Icons.favorite_border_rounded,
                        size: 14, color: newBlueColor),
                  ),
                ),
              ]),
            ),
            // Info — fills remaining space
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.itemname ?? '',
                        style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: newTextPrimary),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('₹${item.rate?.toStringAsFixed(0) ?? '0'}',
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: newBlueColor)),
                          Row(children: [
                            const Icon(Icons.star_rounded,
                                size: 12, color: Color(0xFFF59E0B)),
                            const SizedBox(width: 2),
                            const Text('4.4',
                                style: TextStyle(
                                    fontSize: 10, color: newTextSecondary)),
                          ]),
                        ]),
                    Align(
                      alignment: Alignment.centerRight,
                      child: _qtyRow(ctrl, index),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //  List card — matches reference exactly 
  Widget _listCard(ProductListController ctrl, int index) {
    final item = ctrl.productList[index];
    return GestureDetector(
      onTap: () => ctrl.tapOnProduct(item.itemid.toString()),
      child: Container(
        decoration: BoxDecoration(
          color: newSurfaceColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: newBorderColor),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //  Square image, fixed 110×110 
            ClipRRect(
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(13)),
              child: SizedBox(
                width: 110,
                height: 110,
                child: Stack(fit: StackFit.expand, children: [
                  Container(
                    color: Colors.white,
                    child: AppNetworkImage(
                        image: item.itemimage ?? '', fit: BoxFit.contain),
                  ),
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                          color: newBlueColor,
                          borderRadius: BorderRadius.circular(4)),
                      child: const Text('30% OFF',
                          style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                    ),
                  ),
                ]),
              ),
            ),

            //  Content 
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Name + heart
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(item.itemname ?? '',
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: newTextPrimary),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.favorite_border_rounded,
                            size: 18, color: newBlueColor),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Stars
                    Row(children: [
                      const Icon(Icons.star_rounded,
                          size: 14, color: Color(0xFFF59E0B)),
                      const SizedBox(width: 3),
                      const Text('4.4',
                          style:
                              TextStyle(fontSize: 12, color: newTextSecondary)),
                    ]),
                    const SizedBox(height: 8),
                    // Price + qty — always fits, no clipping
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('₹${item.rate?.toStringAsFixed(0) ?? '0'}',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: newBlueColor)),
                              const Text('per unit',
                                  style: TextStyle(
                                      fontSize: 10, color: newTextSecondary)),
                            ]),
                        _qtyRow(ctrl, index),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //  Qty row 
  Widget _qtyRow(ProductListController ctrl, int index) {
    final item = ctrl.productList[index];
    if (!(item.isInCart ?? false)) {
      return GestureDetector(
        onTap: () => ctrl.addToCart(index),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
              color: newBlueColor, borderRadius: BorderRadius.circular(20)),
          child: const Icon(Icons.add, color: Colors.white, size: 16),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: newBlueColor),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _qtyBtn(Icons.remove, () {
            if ((item.quantity ?? 1) > 1)
              ctrl.productQtyDecrease(index);
            else
              ctrl.removeFromCart(index);
          }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text('${item.quantity?.toInt() ?? 1}',
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: newBlueColor)),
          ),
          _qtyBtn(Icons.add, () => ctrl.productQtyIncrease(index),
              filled: true),
        ],
      ),
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback onTap, {bool filled = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: filled ? newBlueColor : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child:
            Icon(icon, size: 14, color: filled ? Colors.white : newBlueColor),
      ),
    );
  }
}
