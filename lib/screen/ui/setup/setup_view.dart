// import 'dart:convert';
// import 'dart:io';
//
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant_new.dart';
// import 'package:digitalerp/utils/app_profile_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// import 'setup_controller.dart';
//
// class SetupView extends StatelessWidget {
//   const SetupView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<SetupController>(
//       init: SetupController(),
//       builder: (controller) => Scaffold(
//         // resizeToAvoidBottomInset: false,
//         backgroundColor: whiteBoxColor,
//         body: LayoutBuilder(
//           builder: (context, constraint) => SingleChildScrollView(
//             child: Container(
//               height: context.height,
//               width: context.width,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(
//                     AppAssets.setupBg,
//                   ),
//                   fit: BoxFit.fill,
//                 ),
//               ),
//               child: SafeArea(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Row(
//                       children: [
//                         const SizedBox(width: 45),
//                         /*
//                         InkWell(
//                           onTap: () => controller.backTap(),
//                           child: Image.asset(
//                             AppAssets.backIcon,
//                             height: 28,
//                             width: 28,
//                             // fit: BoxFit.fill,
//                           ),
//                         ),
//
//                          */
//                         Expanded(
//                             child: Text(
//                           'Setup Profile',
//                           style: const TextStyle().bold.copyWith(color: Colors.white, fontSize: 20),
//                           textAlign: TextAlign.center,
//                         )),
//                         TextButton(
//                           onPressed: () {
//                             controller.tapOnSkip();
//                           },
//                           child: Text(
//                             'Skip',
//                             style: const TextStyle().normal.copyWith(fontSize: 14, color: Colors.white),
//                           ),
//                         ),
//                       ],
//                     ),
//                     /*
//                     Card(
//                       shape: const CircleBorder(side: BorderSide(color: Colors.white, width: 4)),
//                       elevation: 10,
//                       clipBehavior: Clip.antiAliasWithSaveLayer,
//                       child: SizedBox(
//                         height: Get.height * .2,
//                         child: controller.selectedImage.isEmpty
//                             ? CircleAvatar(
//                                 radius: Get.height * .075,
//                                 backgroundColor: Colors.white,
//                                 child: ClipOval(
//                                   child: AppNetworkImage(
//                                     image: controller.userData.photo.toString(),
//                                     fit: BoxFit.fill,
//                                   ),
//                                 ))
//                             : Image.file(
//                                 File(controller.selectedImage.value),
//                                 height: Get.height * .2,
//                                 // fit: BoxFit.fill,
//                               ),
//                       ),
//                     ),
//
//                      */
//                     SizedBox(height: Get.height * .02),
//                     controller.selectedImage.isEmpty
//                         ? ProfileImageView(
//                             size: Get.height * .16,
//                             imageUrl: controller.userData.photo.toString(),
//                           )
//                         : ProfileImageView(
//                             size: Get.height * .16,
//                             fileImage: controller.selectedImage.toString(),
//                           ),
//                     TextButton(
//                       onPressed: () {
//                         _showImageDialog(controller);
//                       },
//                       child: Text(
//                         'Add Profile Photo',
//                         style: const TextStyle().normal.copyWith(
//                               fontSize: 12,
//                               color: unselectedColor,
//                             ),
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     /*
//                     ElevatedButton(
//                       onPressed: () {},
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(25),
//                           gradient: const LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               orangeColor,
//                               red2Color,
//                             ],
//                           ),
//                           boxShadow: const [
//                             BoxShadow(
//                                 spreadRadius: 2,
//                                 blurRadius: 2,
//                                 color: Colors.black12,
//                                 offset: Offset(0, 5)),
//                           ],
//                         ),
//                         child: Text(
//                           controller.userData.usertype.toString(),
//                           style: const TextStyle().bold.copyWith(color: Colors.white),
//                         ),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         primary: Colors.transparent,
//                         padding: EdgeInsets.zero,
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//                       ),
//                     ),
//
//                      */
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 40),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             TextFormField(
//                               style: const TextStyle().light,
//                               keyboardType: TextInputType.text,
//                               textInputAction: TextInputAction.next,
//                               controller: controller.nameController,
//                               focusNode: controller.nameFocus,
//                               // decoration: const InputDecoration()
//                               //     .txtFieldStyle(hintText: 'Enter Name', labelName: 'Name')
//                               //     .copyWith(
//                               //       suffixIcon: const Icon(Icons.person, color: unselectedColor),
//                               //       suffixIconConstraints:
//                               //           const BoxConstraints(maxHeight: 40, maxWidth: 40),
//                               decoration: const InputDecoration().profileTxtField(
//                                   hintText: 'Enter Name',
//                                   labelName: 'Name',
//                                   icon: AppAssets.userIcon,
//                                   iconColor: controller.addressFocus.hasFocus ? null : Colors.grey),
//                             ),
//                             TextFormField(
//                               style: const TextStyle().light,
//                               keyboardType: TextInputType.emailAddress,
//                               textInputAction: TextInputAction.next,
//                               controller: controller.emailController,
//                               focusNode: controller.emailFocus,
//                               // decoration: const InputDecoration()
//                               //     .txtFieldStyle(hintText: 'Enter Email', labelName: 'Email')
//                               //     .copyWith(
//                               //       suffixIcon:
//                               //           const Icon(Icons.mail_sharp, color: unselectedColor),
//                               //       suffixIconConstraints:
//                               //           const BoxConstraints(maxHeight: 40, maxWidth: 40),
//                               //     ),
//                               decoration: const InputDecoration().profileTxtField(
//                                   hintText: 'Enter Email',
//                                   labelName: 'Email',
//                                   icon: AppAssets.mailIcon,
//                                   iconColor: controller.addressFocus.hasFocus ? null : Colors.grey),
//                             ),
//                             TextFormField(
//                               style: const TextStyle().light,
//                               keyboardType: TextInputType.text,
//                               textInputAction: TextInputAction.next,
//                               controller: controller.addressController,
//                               focusNode: controller.addressFocus,
//                               // decoration: const InputDecoration()
//                               //     .txtFieldStyle(hintText: 'Enter Address', labelName: 'Address')
//                               //     .copyWith(
//                               //       suffixIcon: const Icon(Icons.perm_contact_calendar,
//                               //           color: unselectedColor),
//                               //       suffixIconConstraints:
//                               //           const BoxConstraints(maxHeight: 40, maxWidth: 40),
//                               //     ),
//                               decoration: const InputDecoration().profileTxtField(
//                                   hintText: 'Enter Address',
//                                   labelName: 'Address',
//                                   icon: AppAssets.addressIcon,
//                                   iconColor: controller.addressFocus.hasFocus ? null : Colors.grey),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     controller.isBusy
//                         ? const Center(
//                             child: CircularProgressIndicator(
//                               color: purpleColor,
//                             ),
//                           )
//                         : ElevatedButton(
//                             onPressed: () {
//                               controller.tapOnSetupProfile();
//                             },
//                             style: ElevatedButton.styleFrom(
//                               elevation: 10,
//                               padding: EdgeInsets.zero,
//                               backgroundColor: Colors.transparent,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(40.0),
//                               ),
//                             ),
//                             child: Container(
//                               // width: Get.width,
//                               padding: const EdgeInsets.symmetric(vertical: 20),
//                               decoration: const BoxDecoration(
//                                 borderRadius: BorderRadius.vertical(
//                                   top: Radius.circular(40.0),
//                                 ),
//                                 gradient: LinearGradient(
//                                   begin: Alignment.topCenter,
//                                   end: Alignment.bottomCenter,
//                                   colors: [
//                                     grTopColor,
//                                     grBottomColor,
//                                   ],
//                                 ),
//                               ),
//                               alignment: Alignment.center,
//                               child: Text(
//                                 'Setup Profile',
//                                 style: const TextStyle().bold.copyWith(color: Colors.white),
//                               ),
//                             ),
//                           ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   _showImageDialog(SetupController value) {
//     return Get.defaultDialog(
//       title: 'Choose Option',
//       radius: 8,
//       titleStyle: const TextStyle().normal,
//       content: Column(
//         children: [
//           InkWell(
//             onTap: () {
//               _getImage(ImageSource.gallery, value);
//             },
//             child: Text(
//               'Select Image From Gallery',
//               style: const TextStyle().normal,
//             ),
//           ),
//           SizedBox(height: Get.height * .02),
//           InkWell(
//             onTap: () {
//               _getImage(ImageSource.camera, value);
//             },
//             child: Text(
//               'Take picture',
//               style: const TextStyle().normal,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _getImage(ImageSource source, SetupController value) async {
//     Get.back();
//     var pickedFile = await value.picker.pickImage(
//       source: source,
//       imageQuality: 65,
//     );
//     if (pickedFile != null) {
//       var file = File(pickedFile.path);
//       value.selectedImageBase64.value = base64.encode(file.readAsBytesSync());
//       value.selectedImageFileName.value = file.path.split('/').last;
//       value.setSelectedImage(file.path);
//     }
//   }
// }

import 'dart:convert';
import 'dart:io';

import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/app_profile_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'setup_controller.dart';

//  Design tokens 
const Color _kBlue = Color(0xFF4361EE);
const Color _kBlueBg = Color(0xFFEEF1FF);
const Color _kBorder = Color(0xFFE2E8F0);
const Color _kTextPrimary = Color(0xFF0F172A);
const Color _kTextSub = Color(0xFF64748B);
const Color _kTextHint = Color(0xFF94A3B8);
const Color _kBg = Color(0xFFF5F6FA);

class SetupView extends StatelessWidget {
  const SetupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SetupController>(
      init: SetupController(),
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: [
              //  Header 
              Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(children: [
                  const Expanded(
                    child: Text(
                      'Setup Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: _kTextPrimary,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: controller.tapOnSkip,
                    style: TextButton.styleFrom(
                      foregroundColor: _kBlue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                    ),
                    child: const Text('Skip',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                  ),
                ]),
              ),

              //  Body 
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 24,
                    bottom:
                        MediaQuery.of(context).viewInsets.bottom > 0 ? 200 : 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //  Avatar 
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // Decorative outer ring
                          Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: _kBlue.withValues(alpha: 0.25),
                                  width: 3),
                            ),
                          ),
                          // Avatar
                          GestureDetector(
                            onTap: () => _showImageDialog(controller),
                            child: controller.selectedImage.isEmpty
                                ? ProfileImageView(
                                    size: 96,
                                    imageUrl:
                                        controller.userData.photo.toString(),
                                  )
                                : ProfileImageView(
                                    size: 96,
                                    fileImage:
                                        controller.selectedImage.toString(),
                                  ),
                          ),
                          // Camera badge
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () => _showImageDialog(controller),
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: _kBlue,
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                ),
                                child: const Icon(Icons.camera_alt_outlined,
                                    color: Colors.white, size: 15),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () => _showImageDialog(controller),
                        child: const Text(
                          'Change Profile Photo',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: _kBlue),
                        ),
                      ),

                      const SizedBox(height: 32),

                      //  Name field 
                      _sectionLabel('Full Name'),
                      _inputField(
                        controller: controller.nameController,
                        focusNode: controller.nameFocus,
                        hint: 'Enter your name',
                        icon: Icons.person_outline_rounded,
                        keyboardType: TextInputType.name,
                        action: TextInputAction.next,
                      ),
                      const SizedBox(height: 16),

                      //  Email field 
                      _sectionLabel('Email'),
                      _inputField(
                        controller: controller.emailController,
                        focusNode: controller.emailFocus,
                        hint: 'Enter your email',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        action: TextInputAction.next,
                      ),
                      const SizedBox(height: 16),

                      //  Address field 
                      _sectionLabel('Address'),
                      _inputField(
                        controller: controller.addressController,
                        focusNode: controller.addressFocus,
                        hint: 'Enter your address',
                        icon: Icons.location_on_outlined,
                        keyboardType: TextInputType.streetAddress,
                        action: TextInputAction.done,
                        maxLines: 2,
                      ),

                      const SizedBox(height: 36),

                      //  Submit button 
                      controller.isBusy
                          ? const CircularProgressIndicator(color: _kBlue)
                          : SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: controller.tapOnSetupProfile,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _kBlue,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                child: const Text(
                                  'Save Profile',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
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

  //  Section label 
  Widget _sectionLabel(String label) => Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(label,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _kTextPrimary)),
        ),
      );

  //  Input field 
  Widget _inputField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    TextInputAction action = TextInputAction.next,
    int maxLines = 1,
  }) =>
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _kBorder),
        ),
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          textInputAction: action,
          maxLines: maxLines,
          style: const TextStyle(fontSize: 14, color: _kTextPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 14, color: _kTextHint),
            prefixIcon: Icon(icon, color: _kTextSub, size: 20),
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          ),
        ),
      );

  //  Image picker dialog 
  void _showImageDialog(SetupController controller) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Choose Option',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: _kTextPrimary)),
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: _kBorder),
            const SizedBox(height: 8),

            // Gallery option
            ListTile(
              onTap: () {
                Get.back();
                _getImage(ImageSource.gallery, controller);
              },
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: _kBlueBg, borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.photo_library_outlined,
                    color: _kBlue, size: 20),
              ),
              title: const Text('Select from Gallery',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _kTextPrimary)),
              contentPadding: EdgeInsets.zero,
            ),

            // Camera option
            ListTile(
              onTap: () {
                Get.back();
                _getImage(ImageSource.camera, controller);
              },
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: _kBlueBg, borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.camera_alt_outlined,
                    color: _kBlue, size: 20),
              ),
              title: const Text('Take a Photo',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _kTextPrimary)),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }

  //  Image picker logic (unchanged) 
  void _getImage(ImageSource source, SetupController value) async {
    final pickedFile = await value.picker.pickImage(
      source: source,
      imageQuality: 65,
    );
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      value.selectedImageBase64.value = base64.encode(file.readAsBytesSync());
      value.selectedImageFileName.value = file.path.split('/').last;
      value.setSelectedImage(file.path);
    }
  }
}
