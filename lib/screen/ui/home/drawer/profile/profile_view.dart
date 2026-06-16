import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_bottom_button.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/app_profile_image.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xFFF0F2F8),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            //  Collapsible hero app bar
            SliverAppBar(
              expandedHeight: 260,
              pinned: true,
              elevation: 0,
              backgroundColor: purpleColor,
              leading: GestureDetector(
                onTap: () => controller.backTap(),
                child: Container(
                  margin: const EdgeInsets.all(10),

                  child: const Icon(Icons.arrow_back_ios_new,
                      color: Colors.white, size: 20),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                titlePadding:
                const EdgeInsets.only(left: 20, bottom: 16),
                title: const Text(
                  'My Profile',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
                background: _HeroBanner(controller: controller),
              ),
            ),

            //  Body content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 24, 18, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section label
                    _sectionLabel('Personal Information'),
                    const SizedBox(height: 14),

                    // Form card
                    _FormCard(controller: controller),

                    const SizedBox(height: 32),

                    // Submit / loader
                    controller.isBusy
                        ? const Center(
                      child: CircularProgressIndicator(
                          color: purpleColor),
                    )
                        : _SubmitButton(
                        onPressed: controller.tapOnEditProfile),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String label) => Row(
    children: [
      Container(
        width: 4,
        height: 18,
        decoration: BoxDecoration(
          color: purpleColor,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      const SizedBox(width: 10),
      Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: purpleColor,
          letterSpacing: 0.2,
        ),
      ),
    ],
  );
}

//
// HERO BANNER — profile photo + name inside the SliverAppBar background
//
class _HeroBanner extends StatelessWidget {
  final ProfileController controller;
  const _HeroBanner({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Gradient background
        Container(
          decoration: const BoxDecoration(
            color: purpleColor
          ),
        ),

        // Decorative circle blobs
        Positioned(
          top: -30,
          right: -40,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha:0.05),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: -30,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha:0.05),
            ),
          ),
        ),

        // Profile photo + camera icon — centered
        Positioned(
          bottom: 36,
          left: 0,
          right: 0,
          child: Center(child: _ProfileAvatar(controller: controller)),
        ),
      ],
    );
  }
}


// PROFILE AVATAR with camera tap

class _ProfileAvatar extends StatelessWidget {
  final ProfileController controller;
  const _ProfileAvatar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Outer glow ring
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF5B8EFF), Color(0xFFABC4FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: purpleColor.withValues(alpha:0.5),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: controller.selectedImage.isEmpty
                ? ProfileImageView(
                size: 96,
                imageUrl: controller
                    .homeController.currentUserData?.photo
                    .toString())
                : ProfileImageView(
              size: 96,
              fileImage: controller.selectedImage.value,
            ),
          ),
        ),

        // Camera button
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () => _showImageDialog(context, controller),
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF5B8EFF), Color(0xFF1C2B6A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: purpleColor.withValues(alpha:0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(Icons.camera_alt_rounded,
                  color: Colors.white, size: 16),
            ),
          ),
        ),
      ],
    );
  }

  void _showImageDialog(BuildContext context, ProfileController value) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFDDE1F0),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Update Profile Photo',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1D2E),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Choose a source to update your photo',
              style: TextStyle(fontSize: 13, color: Color(0xFF8A94B2)),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _SourceTile(
                    icon: Icons.photo_library_outlined,
                    label: 'Gallery',
                    color: const Color(0xFF5B8EFF),
                    onTap: () =>
                        _getImage(ImageSource.gallery, value),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _SourceTile(
                    icon: Icons.camera_enhance_outlined,
                    label: 'Camera',
                    color: purpleColor,
                    onTap: () =>
                        _getImage(ImageSource.camera, value),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  void _getImage(ImageSource source, ProfileController value) async {
    Get.back();
    var pickedFile =
    await value.picker.pickImage(source: source, imageQuality: 65);
    if (pickedFile != null) {
      var file = File(pickedFile.path);
      value.selectedImageBase64.value =
          base64.encode(file.readAsBytesSync());
      value.selectedImageFileName.value = file.path.split('/').last;
      value.setSelectedImage(file.path);
    }
  }
}


// SOURCE TILE (Gallery / Camera)

class _SourceTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _SourceTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: color.withValues(alpha:0.07),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha:0.2)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha:0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// FORM CARD

class _FormCard extends StatelessWidget {
  final ProfileController controller;
  const _FormCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: purpleColor.withValues(alpha:0.06),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          _ErpField(
            label: 'User Type',
            hint: 'User Type',
            ctrl: controller.userTypeController,
            focus: controller.userTypeFocus,
            icon: Icons.badge_outlined,
            readOnly: true,
          ),
          const SizedBox(height: 20),
          _ErpField(
            label: 'Full Name',
            hint: 'Enter your full name',
            ctrl: controller.nameController,
            focus: controller.nameFocus,
            icon: Icons.person_outline_rounded,
          ),
          const SizedBox(height: 20),
          _ErpField(
            label: 'Email Address',
            hint: 'Enter your email',
            ctrl: controller.emailController,
            focus: controller.emailFocus,
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          _ErpField(
            label: 'Office Address',
            hint: 'Enter your office address',
            ctrl: controller.addressController,
            focus: controller.addressFocus,
            icon: Icons.location_on_outlined,
            isLast: true,
          ),
        ],
      ),
    );
  }
}


// ERP TEXT FIELD

class _ErpField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController ctrl;
  final FocusNode focus;
  final IconData icon;
  final bool readOnly;
  final bool isLast;
  final TextInputType keyboardType;

  const _ErpField({
    required this.label,
    required this.hint,
    required this.ctrl,
    required this.focus,
    required this.icon,
    this.readOnly = false,
    this.isLast = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF1C2B6A);
    const subtle = Color(0xFF8A94B2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label row
        Row(
          children: [
            Icon(icon, size: 14, color: subtle),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: subtle,
                letterSpacing: 0.4,
              ),
            ),
            if (readOnly) ...[
              const SizedBox(width: 6),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha:0.08),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'READ ONLY',
                  style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: accent,
                      letterSpacing: 0.5),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),

        // Input
        TextFormField(
          controller: ctrl,
          focusNode: focus,
          readOnly: readOnly,
          keyboardType: keyboardType,
          textInputAction:
          isLast ? TextInputAction.done : TextInputAction.next,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: readOnly
                ? const Color(0xFF8A94B2)
                : const Color(0xFF1A1D2E),
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
                fontSize: 14, color: Color(0xFFBCC4D8)),
            filled: true,
            fillColor: readOnly
                ? const Color(0xFFF5F6FA)
                : const Color(0xFFFAFBFF),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
              const BorderSide(color: Color(0xFFE2E8F5), width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: accent, width: 1.8),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
              const BorderSide(color: Color(0xFFEEF0F7), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}


// SUBMIT BUTTON

class _SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _SubmitButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 54,
        width: double.infinity,
        decoration: BoxDecoration(
          color: purpleColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: purpleColor.withValues(alpha:0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.save_rounded, color: Colors.white, size: 20),
            SizedBox(width: 10),
            Text(
              'Update Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}