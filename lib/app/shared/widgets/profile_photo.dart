// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/router/routes.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({
    Key? key,
    this.profilePhoto,
    required this.onFile,
  }) : super(key: key);

  final XFile? profilePhoto;
  final Function(XFile file) onFile;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.lightGray,
      shape: const CircleBorder(),
      elevation: 1,
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes.camera)?.then((file) => onFile(file));
        },
        customBorder: const CircleBorder(),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: profilePhoto != null
              ? FileImage(
                  File(
                    profilePhoto!.path,
                  ),
                )
              : null,
          radius: 100,
          child: profilePhoto == null
              ? const Center(
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: AppColors.midGray,
                    size: 40,
                  ),
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
