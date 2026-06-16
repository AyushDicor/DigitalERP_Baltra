import 'dart:io';
import 'package:digitalerp/utils/app_network_image.dart';
import 'package:flutter/material.dart';

class ProfileImageView extends StatelessWidget {
  final double size;
  final String? imageUrl;
  final String? fileImage;
  final Color? borderColor;
  final double? borderSize;

  const ProfileImageView(
      {Key? key,
      required this.size,
      this.imageUrl,
      this.fileImage,
      this.borderColor,
      this.borderSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: CircleBorder(
        side: BorderSide(
          color: borderColor ?? Colors.white,
          width: borderSize ?? 4,
        ),
      ),
      elevation: 10,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(
        height: size,
        child: fileImage == null
            ? Container(
                height: size,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                clipBehavior: Clip.antiAlias,
                child: AppNetworkImage(
                  image: imageUrl,
                  fit: BoxFit.cover,
                  height: size,
                  width: size,
                ),
              )
            : Image.file(
                File(fileImage!),
                height: size,
                width: size,
                fit: BoxFit.fill,
                isAntiAlias: true,
              ),
      ),
    );
  }
}
