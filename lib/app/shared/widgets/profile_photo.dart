// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:cuidame/app/shared/widgets/camera_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({
    super.key,
    this.profilePhoto,
    this.profilePhotoUrl,
    required this.onFile,
    this.loading = false,
  });

  final XFile? profilePhoto;
  final String? profilePhotoUrl;
  final Function(XFile? file) onFile;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    bool isProfilePhoto() {
      return profilePhoto != null || profilePhotoUrl != null;
    }

    return Material(
      color: AppColors.lightGray,
      shape: const CircleBorder(),
      elevation: 1,
      child: InkWell(
        onTap: () {
          Get.to(
            CameraWidget(
              onChange: (file) {
                onFile(file);
              },
            ),
          );
          // Get.toNamed(Routes.camera)?.then((file) => onFile(file));
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
              : profilePhotoUrl != null
                  ? Image.network(profilePhotoUrl!).image
                  : null,
          radius: 100,
          child: profilePhoto == null
              ? Center(
                  child: loading
                      ? Container(
                          height: double.maxFinite,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: AppColors.black.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.light,
                            ),
                          ),
                        )
                      : isProfilePhoto()
                          ? null
                          : const Icon(
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
