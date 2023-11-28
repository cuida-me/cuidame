import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.onPressed,
    this.text,
    this.icon,
    this.expanded = false,
    this.loading = false,
  });

  final VoidCallback? onPressed;
  final String? text;
  final IconData? icon;
  final bool expanded;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shadowColor: AppColors.black,
        elevation: 2,
        backgroundColor: onPressed == null ? AppColors.midGray : AppColors.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Spacements.S,
          horizontal: Spacements.S,
        ),
        child: loading
            ? const Center(
                child: CircularProgressIndicator(
                color: AppColors.primary,
              ))
            : Row(
                children: [
                  Text(
                    text ?? '',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.light,
                        ),
                  ),
                  if (expanded) const Spacer(),
                  Icon(
                    icon,
                    color: AppColors.light,
                    size: Spacements.M,
                  ),
                ],
              ),
      ),
    );
  }
}
