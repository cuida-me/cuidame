import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/modules/caregiver/patient_profile/controllers/patient_profile_controller.dart';
import 'package:cuidame/app/shared/gutter.dart';
import 'package:cuidame/app/shared/widgets/custom_date_picker.dart';
import 'package:cuidame/app/shared/widgets/custom_dropdown.dart';
import 'package:cuidame/app/shared/widgets/custom_text_form_field.dart';
import 'package:cuidame/app/shared/widgets/profile_photo.dart';
import 'package:cuidame/app/shared/widgets/circle_button.dart';
import 'package:cuidame/app/shared/widgets/safe_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class PatientProfilePage extends StatefulWidget {
  const PatientProfilePage({super.key});

  @override
  State<PatientProfilePage> createState() => _PatientProfilePageState();
}

class _PatientProfilePageState extends State<PatientProfilePage> {
  final controller = DependencesInjector.get<PatientProfileController>();
  @override
  Widget build(BuildContext context) {
    Widget circleButtonWithTitle(
      String title,
      Color iconColor,
      Color backgroundColor,
      IconData icon,
      VoidCallback? onTap,
      bool? loading,
    ) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: Spacements.XXS),
          CircleButton(
            icon: icon,
            iconColor: iconColor,
            backGroundColor: backgroundColor,
            sizeCircle: 60,
            sizeIcon: 42,
            onTap: onTap,
            loading: loading ?? false,
          ),
        ],
      );
    }

    return SafeScrollView(
      child: Gutter(
        child: Column(
          children: [
            Text(
              'Informações do Paciente',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: Spacements.L),
            Obx(
              () => ProfilePhoto(
                profilePhotoUrl: controller.patient.value?.avatar,
                loading: controller.loadingPatientPhoto.value,
                onFile: controller.uploadProfilePhoto,
              ),
            ),
            const SizedBox(height: Spacements.S),
            Text(
              'Definir foto',
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Spacements.L),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                circleButtonWithTitle(
                  'Vincular Dispositivo',
                  AppColors.light,
                  AppColors.midGray,
                  Icons.qr_code_2,
                  controller.linkPatientDevice,
                  false,
                ),
                Obx(
                  () => circleButtonWithTitle(
                    'Excluir Paciente',
                    AppColors.light,
                    AppColors.error,
                    Icons.delete_forever,
                    controller.deletePatient,
                    controller.loadingDelete.value,
                  ),
                ),
                Obx(
                  () => circleButtonWithTitle(
                    'Salvar Alterações',
                    AppColors.light,
                    AppColors.success,
                    Icons.save_outlined,
                    controller.formValidate ? controller.submit : null,
                    controller.loadingSubmit.value,
                  ),
                )
              ],
            ),
            const SizedBox(height: Spacements.M),
            CustomTextFormField(
              title: 'Nome',
              hintText: 'Digite seu nome',
              initialValue: controller.patient.value?.name,
              onChanged: (value) {
                controller.patient.value?.name = value.isNotEmpty ? value : null;
              },
              errorText: controller.validateName,
            ),
            const SizedBox(height: Spacements.M),
            Row(
              children: [
                Expanded(
                  child: CustomDatePicker(
                    title: 'Data de nascimento',
                    hintText: 'Selecione uma data',
                    dateOnly: true,
                    disableFutureDate: true,
                    initialDate: controller.patient.value?.birthDate,
                    onChange: (value) {
                      controller.patient.value?.birthDate = value;
                    },
                  ),
                ),
                const SizedBox(width: Spacements.S),
                Expanded(
                  child: CustomDropdown(
                    title: 'Sexo',
                    hintText: 'Selecione o sexo',
                    onChanged: controller.onChangeGender,
                    items: [
                      CustomDropdownItem(
                        text: 'Masculino',
                        value: 0,
                      ),
                      CustomDropdownItem(
                        text: 'Feminino',
                        value: 1,
                      ),
                    ],
                    value: controller.patient.value?.sex,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
