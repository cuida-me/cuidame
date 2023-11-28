// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    super.key,
    this.onTap,
    this.icon,
    this.iconColor,
    this.backGroundColor,
    this.sizeCircle,
    this.sizeIcon,
    this.elevation,
    this.padding,
  });

  final VoidCallback? onTap;
  final IconData? icon;
  final Color? iconColor;
  final Color? backGroundColor;
  final double? sizeCircle;
  final double? sizeIcon;
  final double? elevation;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: backGroundColor ?? AppColors.secondary,
        shape: const CircleBorder(),
        elevation: elevation ?? 0,
        padding: padding ?? const EdgeInsets.all(Spacements.XS),
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: sizeIcon,
      ),
    );
  }
}
