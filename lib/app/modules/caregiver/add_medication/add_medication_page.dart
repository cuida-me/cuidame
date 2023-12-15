import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/modules/caregiver/add_medication/controllers/add_medication_controller.dart';
import 'package:cuidame/app/shared/gutter.dart';
import 'package:cuidame/app/shared/widgets/circle_button.dart';
import 'package:cuidame/app/shared/widgets/custom_app_bar.dart';
import 'package:cuidame/app/shared/widgets/custom_dropdown.dart';
import 'package:cuidame/app/shared/widgets/custom_text_form_field.dart';
import 'package:cuidame/app/shared/widgets/primary_button.dart';
import 'package:cuidame/app/shared/widgets/profile_photo.dart';
import 'package:cuidame/app/shared/widgets/safe_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class AddMedicationPage extends StatefulWidget {
  const AddMedicationPage({super.key});

  @override
  State<AddMedicationPage> createState() => _AddMedicationPageState();
}

class _AddMedicationPageState extends State<AddMedicationPage> {
  final controller = DependencesInjector.get<AddMedicationController>();

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

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: CustomAppBar(
        context: context,
        title: const Text('Voltar'),
        transparent: true,
      ),
      body: SafeArea(
        child: SafeScrollView(
          child: Gutter(
            isSmall: true,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacements.S,
                vertical: Spacements.M,
              ),
              decoration: BoxDecoration(
                color: AppColors.light,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Column(
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
                    onFile: controller.uploadMedicationPhoto,
                    profilePhotoUrl: controller.medicationPhoto.value,
                    loading: controller.loadingMedicationPhoto.value,
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
                          initialValue: controller.dosage.value,
                          onChanged: (value) {
                            controller.dosage.value = value.isNotEmpty ? value : null;
                          },
                        ),
                      ),
                      const SizedBox(width: Spacements.S),
                      Obx(
                        () => Expanded(
                          child: controller.medicationTypes?.isNotEmpty ?? false
                              ? CustomDropdown(
                                  title: 'Tipo',
                                  hintText: 'Selecione o tipo da dosagem',
                                  onChanged: controller.onChangeDosageType,
                                  items: controller.medicationTypes
                                      ?.map(
                                        (e) => CustomDropdownItem(text: e.name ?? '', value: e.id),
                                      )
                                      .toList(),
                                )
                              : const SizedBox(),
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
                        buttonDayOfWeek('Dom', 0),
                        const SizedBox(width: Spacements.XS),
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
                      ],
                    ),
                  ),
                  const SizedBox(height: Spacements.S),
                  Obx(
                    () => PrimaryButton(
                      text: 'Salvar',
                      icon: Icons.arrow_forward,
                      expanded: true,
                      onPressed: controller.formValidate ? controller.submit : null,
                      loading: controller.loading.value,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
