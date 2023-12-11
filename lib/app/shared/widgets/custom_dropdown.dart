// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    super.key,
    required this.onChanged,
    this.items,
    this.value,
    this.title,
    this.hintText,
    this.enabled,
  });

  final Function(dynamic) onChanged;
  final List<CustomDropdownItem>? items;
  final dynamic value;
  final String? title;
  final String? hintText;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.midGray,
                ),
          ),
        DropdownButtonFormField(
          value: value,
          onChanged: enabled ?? true ? onChanged : null,
          alignment: Alignment.centerLeft,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: enabled ?? true ? AppColors.black : AppColors.midGray,
                decoration: TextDecoration.none,
              ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.midGray),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: Spacements.S,
              vertical: Spacements.S,
            ),
            filled: true,
            fillColor: enabled ?? true ? AppColors.lightGray : AppColors.midGray,
            errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.error,
                ),
            alignLabelWithHint: true,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          icon: const SizedBox(),
          dropdownColor: AppColors.light,
          isExpanded: true,
          items: items
              ?.map(
                (e) => DropdownMenuItem(
                  value: e.value,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    e.text,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: enabled ?? true ? AppColors.black : AppColors.midGray,
                        ),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class CustomDropdownItem {
  String text;
  dynamic value;

  CustomDropdownItem({
    required this.text,
    required this.value,
  });
}
