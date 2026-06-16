import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/cart/your_order/your_order_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/app_network_image.dart';
import 'package:digitalerp/utils/app_profile_image.dart';
import 'package:digitalerp/utils/dottedline.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:digitalerp/utils/safeAreaWrapper.dart';
import 'package:digitalerp/utils/utils.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class YourOrderView extends StatelessWidget {
  const YourOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//bool inputField = false;
    return GetBuilder<YourOrderController>(
      init: YourOrderController(),
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(AppAssets.dashboardBg),
                            fit: BoxFit.fill)),
                    child: SafeArea(
                        child: MyAppBar(
                            title: 'Your Order',
                            onBackTap: () => controller.backTap())),
                  ),
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: 0,
                  top: Get.height * 0.135,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Get.height * 0.02),
                        controller.isCustomer ?? false
                            ? _companyCard2(controller)
                            : TextFormField(
                                decoration: const InputDecoration()
                                    .searchTxtFieldStyle(
                                        hint: 'Search Customer'),
                                readOnly: true,
                                onTap: () => controller.tapOnSearch(),
                              ),
                        const SizedBox(height: 10),
                        // if (controller.orderController.isManager)
                        //   _dropdown(controller),
                        const SizedBox(height: 20),
                        if (controller.selectCompany != null)
                          _companyCard2(controller),

                        _productList(controller),
                        const SizedBox(height: 10),
                        DottedLine(
                            color: medGreyColor,
                            width: double.maxFinite,
                            space: 2,
                            strokeWidth: 1),
                        const SizedBox(height: 15),
                        _amountLine(
                          controller,
                          name: 'Amount',
                          amount: controller
                              .cartController.cartList.first.subtotal
                              .toString(),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Discount %',
                              style:
                                  const TextStyle().bold.copyWith(fontSize: 14),
                            ),
                            SizedBox(
                              width: 70,
                              height: 25,
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                maxLength: 2,
                                textAlign: TextAlign.center,
                                textAlignVertical: TextAlignVertical.bottom,
                                cursorColor: Colors.grey,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  counterText: '',
// contentPadding: EdgeInsets.all(0),
                                  hintText: '%',
                                  hintTextDirection: TextDirection.rtl,
                                  fillColor: whiteColor,
                                  filled: true,

                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                                style: const TextStyle()
                                    .bold
                                    .copyWith(fontSize: 14, height: 1),
                                controller: controller.discountController,
                                focusNode: controller.discountFocus,
                                onChanged: (value) {
                                  controller.discountCalculate(value);
                                },
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        _amountLine(
                          controller,
                          name: 'Subtotal',
                          amount: controller.subTotal.toString(),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Cash Discount %',
                              style:
                                  const TextStyle().bold.copyWith(fontSize: 14),
                            ),
                            SizedBox(
                              width: 70,
                              height: 25,
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                maxLength: 2,
                                textAlign: TextAlign.center,
                                cursorColor: Colors.grey,
                                keyboardType: TextInputType.number,
                                textAlignVertical: TextAlignVertical.bottom,
                                decoration: InputDecoration(
                                  counterText: '',
                                  hintText: '%',
                                  hintTextDirection: TextDirection.rtl,
                                  fillColor: whiteColor,
                                  filled: true,
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                                style: const TextStyle().bold.copyWith(
                                      fontSize: 14,
                                    ),
                                controller: controller.cashDiscountController,
                                focusNode: controller.cashDiscountFocus,
                                onChanged: (value) {
                                  controller.cashDiscountCalculate(value);
                                },
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        _amountLine(
                          controller,
                          name: 'Grand Total',
                          amount: controller.grandTotal.toStringAsFixed(2),
                        ),
                        const SizedBox(height: 90),
                        Shared.keyboardIsVisible(context)
                            ? const SizedBox(
                                height: 170,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: _bottomBtn(controller),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _productCard(YourOrderController controller, int index) {
    var item = controller.cartController.cartList[index];
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, 3), blurRadius: 5)
            ]),
        height: 105,
        child: Row(
          children: [
            const SizedBox(width: 10),
            AppNetworkImage(
              image: item.productimage ?? '',
              fit: BoxFit.fill,
              height: Get.height * .1,
              width: Get.width * .2,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productname ?? '',
                    style: const TextStyle()
                        .bold
                        .copyWith(fontSize: 14, color: Colors.black),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _txtView(
                          name: 'Qty', value: item.quantity?.toString() ?? ''),
                      _txtView(name: 'Unit', value: item.unit ?? ''),
                      _txtView(
                          name: 'Rate',
                          value: item.itemrate?.toStringAsFixed(2) ?? '0',
                          moneySign: true),
                      _txtView(
                          name: 'Amount',
                          value: item.total?.toStringAsFixed(2) ?? '0',
                          moneySign: true),
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget _txtView(
          {required String name, required String value, bool? moneySign}) =>
      Column(
        children: [
          Text(
            name,
            style: const TextStyle()
                .bold
                .copyWith(fontSize: 12, color: medGreyColor),
          ),
          const SizedBox(height: 8),
          Text(
            moneySign ?? false ? '\u{20B9}$value' : value,
            style: const TextStyle().bold.copyWith(color: Colors.black),
          )
        ],
      );

  Widget _dropdown(YourOrderController controller) =>
      DropdownButtonHideUnderline(
        child: DropdownButton2<ExecutiveDropdownData>(
          buttonHeight: 40,
          buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: dropdownBoxColor,
          ),
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: blueDropdownGr,
          ),
          isExpanded: true,
          value: controller.selectedDropdownValue,
          hint: Text(
            'Select Executive name',
            style: const TextStyle().normal.copyWith(fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
          icon: Image.asset(
            AppAssets.dropdownIcon,
            width: 15,
            height: 15,
          ),
          items: controller.orderController.executiveList.map((items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items.executiveName.toString()),
            );
          }).toList(),
          onChanged: (ExecutiveDropdownData? newValue) {
            controller.setDropdownValue(newValue!);
          },
        ),
      );

/*
  Widget _categoryCard(YourOrderController controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Category',
              style: const TextStyle().bold.copyWith(fontSize: 14)),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: customGradient(
                    topColor: red3Color,
                    bottomColor: red4Color,
                    opacity: 0.13)),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            margin: const EdgeInsets.only(top: 15, bottom: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppAssets.shoesCategoryIcon,
                  height: 26,
                ),
                const SizedBox(width: 10),
                Text(
                  'Shoes',
                  style: const TextStyle().bold.copyWith(color: categoryColor),
                )
              ],
            ),
          ),
        ],
      );
*/

  Widget _companyCard(YourOrderController controller) {
    print("==>${controller.selectCompany?.partyid}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Company Name',
            style: const TextStyle().bold.copyWith(fontSize: 14)),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: orangeDropdownGr(.19)),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              ProfileImageView(
                  size: 40,
                  imageUrl: controller.selectCompany?.partyid.toString() ?? '',
                  borderSize: 2),
              ProfileImageView(
                  size: 40,
                  imageUrl: controller.selectCompany?.partyid.toString() ?? '',
                  borderSize: 2),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  controller.selectCompany?.partyname ?? "",
                  style: const TextStyle().bold,
                  maxLines: 2,
                ),
              )
            ],
          ),
        ),
/*
          Text('Customer Name', style: const TextStyle().bold.copyWith(fontSize: 14)),
          Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10), gradient: blueDropdownGr),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                ProfileImageView(
                    size: 40, imageUrl: controller.selectCompany?.partyid.toString() ?? '', borderSize: 2),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    controller.selectCompany!.partyname ?? "",
                    style: const TextStyle().bold,
                    maxLines: 2,
                  ),
                )
              ],
            ),
          ),

           */
      ],
    );
  }

  Widget _companyCard2(YourOrderController controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Company Name',
              style: const TextStyle().bold.copyWith(fontSize: 14)),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: orangeDropdownGr(.19)),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                ProfileImageView(
                    size: 40,
                    imageUrl:
                        controller.selectCompany?.partyid.toString() ?? '',
                    borderSize: 2),
                const SizedBox(width: 5),
                Expanded(
                  child: controller.isCustomer ?? false
                      ? Text(
                          controller.companyName ?? '',
                          style: const TextStyle().bold,
                          maxLines: 2,
                        )
                      : Text(
                          controller.selectCompany?.partyname ?? "",
                          style: const TextStyle().bold,
                          maxLines: 2,
                        ),
                )
              ],
            ),
          ),
/*
          Text('Customer Name', style: const TextStyle().bold.copyWith(fontSize: 14)),
          Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10), gradient: blueDropdownGr),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                ProfileImageView(
                    size: 40, imageUrl: controller.selectCompany?.partyid.toString() ?? '', borderSize: 2),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    controller.selectCompany!.partyname ?? "",
                    style: const TextStyle().bold,
                    maxLines: 2,
                  ),
                )
              ],
            ),
          ),

           */
        ],
      );

  Widget _productList(YourOrderController controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Product', style: const TextStyle().bold.copyWith(fontSize: 14)),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.cartController.cartList.length,
            itemBuilder: (context, index) {
              return _productCard(controller, index);
            },
          ),
        ],
      );

  Widget _amountLine(YourOrderController controller,
          {required String name, required String amount}) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle().bold.copyWith(fontSize: 14),
          ),
          Text(
            '\u{20B9}${double.parse(amount).toStringAsFixed(2)}',
            style: const TextStyle().bold.copyWith(fontSize: 14),
          ),
        ],
      );

  Widget _bottomBtn(YourOrderController controller) => SafeAreaWrapper(
        child: Container(
          width: Get.width,
          height: 60,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
            gradient: gr1,
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 26),
                  controller.grandTotal == 0.0
                      ? Text(
                          '\u{20B9}${(controller.cartController.cartList.first.subtotal)!.toStringAsFixed(2)}',
                          style: const TextStyle()
                              .bold
                              .copyWith(color: Colors.white, fontSize: 20),
                        )
                      : Text(
                          '\u{20B9}${controller.grandTotal.toStringAsFixed(2)}',
                          style: const TextStyle()
                              .bold
                              .copyWith(color: Colors.white, fontSize: 20),
                        ),
                ],
              ),
              MaterialButton(
                onPressed: () {
                  controller.tapOnPlaceOrder();
                },
                shape: const StadiumBorder(),
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 35),
                child: Text(
                  'Place order',
                  style: const TextStyle().bold.copyWith(color: red2Color),
                ),
              )
            ],
          ),
        ),
      );
}
