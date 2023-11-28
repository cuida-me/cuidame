// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';

class FloatingNavigationBar extends StatelessWidget {
  const FloatingNavigationBar({
    Key? key,
    required this.buttons,
  }) : super(key: key);

  final List<Widget> buttons;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: Spacements.M,
        right: Spacements.M,
        left: Spacements.M,
      ),
      child: Material(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(100),
        child: SizedBox(
          width: double.maxFinite,
          height: 92,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: buttons,
          ),
        ),
      ),
    );
  }
}
