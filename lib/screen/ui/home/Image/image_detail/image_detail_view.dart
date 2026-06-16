import 'package:cached_network_image/cached_network_image.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/Image/image_detail/image_detail_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/gradient_icon_app_button.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageDetailView extends StatelessWidget {
  const ImageDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageDetailController>(
      init: ImageDetailController(),
      builder: (controller) => Scaffold(
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
                          image: AssetImage(AppAssets.dashboardBg), fit: BoxFit.fill)),
                  child: SafeArea(
                      child:
                          MyAppBar(title: 'Image Details', onBackTap: () => controller.backTap())),
                ),
              ),
              Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                top: Get.height * 0.135,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: (MediaQuery.of(context).viewInsets.bottom > 0) ? 200 : 0,
                    right: 20,
                    left: 20,
                  ),
                  child: Column(
                    children: [
                      imageSection(controller),
                      txtFieldSection(controller),
                      const SizedBox(height: 40),
                      buttonSection(controller),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageSection(ImageDetailController controller) {
    return RepaintBoundary(
      key: controller.globalKey,
      child: Container(
        height: 200,
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 5))
            ]),
        margin: const EdgeInsets.symmetric(vertical: 10),
        clipBehavior: Clip.antiAlias,
        child: CachedNetworkImage(
          imageUrl: controller.data?.image??'',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget txtFieldSection(ImageDetailController controller) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23),
        child: Column(
          children: [
            TextFormField(
              style: const TextStyle().light,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              controller: controller.groupController,
              focusNode: controller.groupFocus,
              decoration: const InputDecoration().txtFieldStyle2(
                  hintText: 'Enter Name',
                  labelName: 'Group',
                  bottomAlwaysPurple:  true),
              readOnly: controller.isReadOnly,
            ),
            TextFormField(
              style: const TextStyle().light,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              controller: controller.titleController,
              focusNode: controller.titleFocus,
              decoration: const InputDecoration().txtFieldStyle2(
                  hintText: 'Enter Title',
                  labelName: 'Title',
                  bottomAlwaysPurple:  true),
              readOnly: controller.isReadOnly,
            ),
            TextFormField(
              style: const TextStyle().light,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              controller: controller.descriptionController,
              minLines: 5,
              maxLines: 5,
              focusNode: controller.descriptionFocus,
              decoration: const InputDecoration().txtFieldStyle2(
                  hintText: 'Enter Description',
                  labelName: 'Description',
                  bottomAlwaysPurple: true),
              readOnly: controller.isReadOnly,
            ),
          ],
        ),
      );

  Widget buttonSection(ImageDetailController controller) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          /*InkWell(
            onTap: () => controller.tapOnEditButton(),
            child: Image.asset(
              AppAssets.editIcon,
              height: 90,
              fit: BoxFit.fill,
            ),
          ),
          InkWell(
            onTap: () => controller.tapOnShareButton(),
            child: Image.asset(
              AppAssets.shareIcon,
              height: 90,
              fit: BoxFit.fill,
            ),
          ),*/
          GradientIconButton(
            onPressed: () => controller.tapOnDownloadButton(),
            iconSize: 18,
            radius: 30,
            vPadding: 18,
            hPadding: 18,
            topColor: purpleColor,
            bottomColor: blueColor,
            icon: AppAssets.downloadIcon,
            shadowRadius: 15,
          ),
          const SizedBox(width: 30),
          GradientIconButton(
            onPressed: () => controller.tapOnShareButton(),
            iconSize: 18,
            radius: 30,
            vPadding: 18,
            hPadding: 18,
            topColor: orangeColor,
            bottomColor: red2Color,
            shadowColor: const Color(0xffFB9E61),
            icon: AppAssets.shareIcon,
            shadowRadius: 15,
          ),
        ],
      );
}
