import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/constants/toast_type.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Utils {
  static void toast(String? title, String? message, [ToastType? toastType]) {
    Color bgColor;
    Color? textColor;

    switch (toastType) {
      case ToastType.success:
        bgColor = AppColors.success;
        textColor = AppColors.light;
        break;
      case ToastType.error:
        bgColor = AppColors.error;
        textColor = AppColors.light;
        break;
      case ToastType.info:
        bgColor = AppColors.tertiary;
        textColor = AppColors.black;
        break;
      case ToastType.warning:
        bgColor = AppColors.warning;
        textColor = AppColors.black;
        break;

      default:
        bgColor = AppColors.tertiary;
        textColor = AppColors.black;
        break;
    }

    Get.snackbar(
      '',
      '',
      titleText: Text(
        title ?? '',
        style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
      ),
      messageText: Text(
        message ?? '',
        style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(
              color: textColor,
            ),
      ),
      boxShadows: [
        BoxShadow(
          offset: const Offset(2, 2),
          color: AppColors.black.withOpacity(0.15),
          blurRadius: 3,
          spreadRadius: 3,
        )
      ],
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(Spacements.S),
      backgroundColor: bgColor,
      borderRadius: 25,
      snackStyle: SnackStyle.FLOATING,
    );
  }
}
