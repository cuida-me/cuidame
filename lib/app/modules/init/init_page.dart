import 'package:cuidame/app/configs/app_assets.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:flutter/material.dart';

class InitPage extends StatelessWidget {
  const InitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.splashIcon,
          ),
        ],
      ),
    );
  }
}
