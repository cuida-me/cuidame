import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.title,
    this.hintText,
    this.password,
    this.enabled,
    this.readOnly,
    this.initialValue,
    this.keyboardType,
    this.controller,
    this.icon,
    this.onChanged,
    this.onFieldSubmitted,
    this.onPressedIcon,
    this.errorText,
    this.maxLines,
    // this.maskFormatters,
    this.onlyNumber,
  }) : super(key: key);

  final String? title;
  final String? hintText;
  final bool? password;
  final bool? enabled;
  final bool? readOnly;
  final String? initialValue;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final IconData? icon;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final VoidCallback? onPressedIcon;
  final String? errorText;
  final int? maxLines;
  // final List<MaskTextInputFormatter>? maskFormatters;
  final bool? onlyNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.midGray,
                ),
          ),
          const SizedBox(height: Spacements.XXS),
        ],
        TextFormField(
          obscureText: password ?? false,
          enabled: enabled,
          controller: controller,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          textAlignVertical: TextAlignVertical.bottom,
          style: Theme.of(context).textTheme.bodyLarge,
          readOnly: readOnly ?? false,
          initialValue: initialValue,
          keyboardType: keyboardType,
          // inputFormatters: [
          //   if (keyboardType != null && !(onlyNumber ?? true)) FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
          //   if (keyboardType != null && (onlyNumber ?? false)) FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          //   if (maskFormatters != null) ...maskFormatters!,
          // ],
          maxLines: maxLines ?? 1,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: Spacements.S,
              vertical: Spacements.S,
            ),
            filled: true,
            errorText: errorText,
            errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.error,
                ),
            fillColor: AppColors.lightGray,
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.midGray),
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: AppColors.lightGray,
              ),
              borderRadius: BorderRadius.circular(Spacements.XS),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: AppColors.error,
              ),
              borderRadius: BorderRadius.circular(Spacements.XS),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: AppColors.error,
              ),
              borderRadius: BorderRadius.circular(Spacements.XS),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: AppColors.lightGray,
              ),
              borderRadius: BorderRadius.circular(Spacements.XS),
            ),
          ),
        ),
      ],
    );
  }
}
