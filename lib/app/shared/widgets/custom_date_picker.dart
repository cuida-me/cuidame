import 'package:flutter/material.dart';
import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({
    super.key,
    this.title,
    this.hintText,
    this.enabled,
    this.initialDate,
    this.dateOnly,
    this.onChange,
    this.enableAllPeriod,
    this.disableFutureDate,
    this.firstDate,
  });

  final String? title;
  final String? hintText;
  final bool? enabled;
  final DateTime? initialDate;
  final bool? dateOnly;
  final ValueChanged<DateTime?>? onChange;
  final bool? enableAllPeriod;
  final bool? disableFutureDate;
  final DateTime? firstDate;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat(
      (dateOnly ?? false) ? 'dd/MM/yyyy' : 'dd/MM/yyyy HH:mm',
    );

    DateTime? date = initialDate;
    final dateNonNull = DateTime.now();

    final controller = TextEditingController(
      text: date != null
          ? dateFormat.format(date)
          : hintText == null
              ? 'Todas as datas'
              : null,
    );

    Future<void> selectDate() async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: date ?? dateNonNull,
        currentDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: disableFutureDate ?? false ? DateTime.now() : DateTime(DateTime.now().year + 1),
        locale: const Locale('pt', 'BR'),
        initialDatePickerMode: DatePickerMode.day,
        cancelText: (enableAllPeriod ?? false) ? 'Todas as datas' : null,
      );

      if (pickedDate == null) {
        if (enableAllPeriod ?? false) controller.text = 'Todas as datas';

        if (onChange != null) {
          if (enableAllPeriod ?? false) {
            onChange!(null);
          } else {
            onChange!(date);
          }
        }
      } else {
        if (dateOnly ?? false) {
          date = pickedDate;
          controller.text = dateFormat.format(pickedDate);

          if (onChange != null) onChange!(pickedDate);
        } else {
          final TimeOfDay? pickedTime = await showTimePicker(
            context: Get.context!,
            initialTime: TimeOfDay.fromDateTime(date ?? dateNonNull),
            initialEntryMode: TimePickerEntryMode.input,
            errorInvalidText: 'Hora inválida',
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  alwaysUse24HourFormat: true,
                ),
                child: child!,
              );
            },
          );

          date = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime?.hour ?? date?.hour ?? 0,
            pickedTime?.minute ?? date?.minute ?? 0,
            date?.second ?? pickedDate.second,
          );

          controller.text = dateFormat.format(date!);
          if (onChange != null) onChange!(date);
        }
      }
    }

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
          enabled: enabled,
          controller: controller,
          readOnly: true,
          onTap: selectDate,
          textAlignVertical: TextAlignVertical.bottom,
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: Spacements.S,
              vertical: Spacements.S,
            ),
            filled: true,
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
