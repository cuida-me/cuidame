import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends AppBar {
  CustomAppBar(
      {super.key,
      required BuildContext context,
      Color? backgroundColor,
      double elevation = 0,
      required Widget title,
      bool transparent = false,
      VoidCallback? onTap})
      : super(
          backgroundColor: backgroundColor,
          elevation: elevation,
          title: title,
          centerTitle: false,
          titleTextStyle: Theme.of(context).textTheme.headlineSmall,
          iconTheme: const IconThemeData(
            color: AppColors.black,
          ),
          forceMaterialTransparency: transparent,
          leading: IconButton(
            onPressed: onTap ??
                () {
                  Get.back();
                },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.black,
              size: 30,
            ),
          ),
        );
}
