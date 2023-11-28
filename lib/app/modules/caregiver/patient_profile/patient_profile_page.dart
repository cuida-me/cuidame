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
        String title, Color iconColor, Color backgroundColor, IconData icon, VoidCallback? onTap) {
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
            sizeCircle: 80,
            sizeIcon: 42,
            onTap: onTap,
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
                profilePhoto: controller.profilePhoto.value,
                onFile: (file) {
                  controller.profilePhoto.value = file;
                },
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
                  () {},
                ),
                circleButtonWithTitle(
                  'Excluir Paciente',
                  AppColors.light,
                  AppColors.error,
                  Icons.delete_forever,
                  () {},
                ),
                circleButtonWithTitle(
                  'Salvar Alterações',
                  AppColors.light,
                  AppColors.success,
                  Icons.save_outlined,
                  () {},
                ),
              ],
            ),
            const SizedBox(height: Spacements.M),
            CustomTextFormField(
              keyboardType: TextInputType.emailAddress,
              title: 'Nome',
              hintText: 'Digite seu nome',
              initialValue: controller.name.value,
              onChanged: (value) {
                controller.name.value = value.isNotEmpty ? value : null;
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
                    initialDate: controller.dateOfBirth.value,
                    onChange: (value) {
                      controller.dateOfBirth.value = value;
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
                        text: 'Feminino',
                        value: 0,
                      ),
                      CustomDropdownItem(
                        text: 'Masculino',
                        value: 1,
                      ),
                    ],
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
