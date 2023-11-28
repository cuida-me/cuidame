import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/modules/caregiver/add_medication/controllers/add_medication_controller.dart';
import 'package:cuidame/app/shared/widgets/circle_button.dart';
import 'package:cuidame/app/shared/widgets/custom_dropdown.dart';
import 'package:cuidame/app/shared/widgets/custom_text_form_field.dart';
import 'package:cuidame/app/shared/widgets/primary_button.dart';
import 'package:cuidame/app/shared/widgets/profile_photo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class RegisterMedication extends StatelessWidget {
  const RegisterMedication({super.key, required this.controller});

  final AddMedicationController controller;

  @override
  Widget build(BuildContext context) {
    void addTime() async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.dial,
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

      controller.addTimeScheduler(pickedTime);
    }

    Widget timeSchedule(TimeOfDay time) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacements.S,
              vertical: Spacements.XS,
            ),
            decoration: BoxDecoration(
              color: AppColors.lightGray,
              borderRadius: BorderRadius.circular(Spacements.XS),
            ),
            child: Text(
              '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(width: Spacements.XS),
          CircleButton(
            icon: Icons.close,
            iconColor: AppColors.darkGray,
            backGroundColor: AppColors.lightGray,
            padding: EdgeInsets.zero,
            sizeCircle: 28,
            sizeIcon: 18,
            elevation: 2,
            onTap: () {
              controller.removeTimeScheduler(time);
            },
          ),
        ],
      );
    }

    Widget buttonDayOfWeek(String day, int dayWeek) {
      final selected = controller.dayWeekSelected(dayWeek);
      final bgColor = controller.dayWeekSelected(dayWeek) ? AppColors.primary : AppColors.tertiary;
      final textColor = controller.dayWeekSelected(dayWeek) ? AppColors.light : AppColors.midGray;

      return Expanded(
        child: Material(
          color: bgColor,
          borderRadius: BorderRadius.circular(Spacements.XXS),
          child: InkWell(
            onTap: () {
              controller.selectDayWeek(dayWeek);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Spacements.S,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    day,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(color: textColor),
                  ),
                  const SizedBox(height: Spacements.XS),
                  Icon(
                    selected ? Icons.check : Icons.close,
                    color: textColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Adicionar medicação',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Spacements.XS),
        Text(
          'Adicione um medicamento usado pelo paciente \nvocê poderá adicionar mais depois.',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Spacements.L),
        ProfilePhoto(
          onFile: (file) {},
        ),
        const SizedBox(height: Spacements.M),
        CustomTextFormField(
          keyboardType: TextInputType.emailAddress,
          title: 'Nome do medicamento',
          hintText: 'Digite o nome do medicamento',
          initialValue: controller.medicationName.value,
          onChanged: (value) {
            controller.medicationName.value = value.isNotEmpty ? value : null;
          },
        ),
        const SizedBox(height: Spacements.M),
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                keyboardType: TextInputType.number,
                title: 'Dosagem',
                hintText: 'Digite a dosagem',
                initialValue: controller.medicationName.value,
                onChanged: (value) {
                  controller.medicationName.value = value.isNotEmpty ? value : null;
                },
              ),
            ),
            const SizedBox(width: Spacements.S),
            Expanded(
              child: CustomDropdown(
                title: 'Tipo',
                hintText: 'Selecione o tipo da dosagem',
                onChanged: controller.onChangeDosageType,
                items: [
                  CustomDropdownItem(
                    text: 'Cápsula',
                    value: 0,
                  ),
                  CustomDropdownItem(
                    text: 'Comprimido',
                    value: 1,
                  ),
                  CustomDropdownItem(
                    text: 'Gotas',
                    value: 2,
                  ),
                  CustomDropdownItem(
                    text: 'ML',
                    value: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: Spacements.M),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Horários',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.midGray,
                  ),
            ),
            CircleButton(
              icon: Icons.add,
              iconColor: AppColors.darkGray,
              backGroundColor: AppColors.lightGray,
              sizeCircle: 38,
              elevation: 2,
              onTap: addTime,
            ),
          ],
        ),
        const SizedBox(height: Spacements.S),
        Obx(
          () => Wrap(
            spacing: Spacements.XS,
            runSpacing: Spacements.XS,
            children: controller.timeSchedulers.value
                .map(
                  (time) => timeSchedule(time),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: Spacements.M),
        Text(
          'Dias da semana',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.midGray,
              ),
        ),
        const SizedBox(height: Spacements.S),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buttonDayOfWeek('Seg', 1),
              const SizedBox(width: Spacements.XS),
              buttonDayOfWeek('Ter', 2),
              const SizedBox(width: Spacements.XS),
              buttonDayOfWeek('Qua', 3),
              const SizedBox(width: Spacements.XS),
              buttonDayOfWeek('Qui', 4),
              const SizedBox(width: Spacements.XS),
              buttonDayOfWeek('Sex', 5),
              const SizedBox(width: Spacements.XS),
              buttonDayOfWeek('Sab', 6),
              const SizedBox(width: Spacements.XS),
              buttonDayOfWeek('Dom', 0),
            ],
          ),
        ),
        const SizedBox(height: Spacements.S),
        PrimaryButton(
          text: 'Salvar',
          icon: Icons.arrow_forward,
          expanded: true,
          onPressed: () {},
        ),
      ],
    );
  }
}
