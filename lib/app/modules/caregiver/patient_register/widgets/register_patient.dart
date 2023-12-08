// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/modules/caregiver/patient_register/controllers/patient_register_controller.dart';
import 'package:cuidame/app/shared/widgets/custom_date_picker.dart';
import 'package:cuidame/app/shared/widgets/custom_dropdown.dart';
import 'package:cuidame/app/shared/widgets/custom_text_form_field.dart';
import 'package:cuidame/app/shared/widgets/primary_button.dart';
import 'package:cuidame/app/shared/widgets/profile_photo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPatient extends StatelessWidget {
  const RegisterPatient({
    super.key,
    required this.controller,
  });

  final PatientRegisterController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Cadastre o paciente',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Spacements.XS),
        Text(
          'Preencha as informações abaixo para cadastrar \no paciente.',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Spacements.L),
        Obx(
          () => ProfilePhoto(
            onFile: controller.uploadProfilePhoto,
            profilePhotoUrl: controller.patientPhoto.value,
            loading: controller.loadingPatientPhoto.value,
          ),
        ),
        const SizedBox(height: Spacements.S),
        Text(
          'Definir foto',
          style: Theme.of(context).textTheme.labelLarge,
          textAlign: TextAlign.center,
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
        const SizedBox(width: Spacements.S),
        Obx(
          () => Expanded(
            child: PrimaryButton(
              onPressed: controller.formValidate ? controller.submit : null,
              text: 'Próximo',
              icon: Icons.arrow_forward,
              expanded: true,
              loading: controller.loading.value,
            ),
          ),
        ),
        const SizedBox(height: Spacements.XS),
        Text(
          'Passo 1 de 2',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
