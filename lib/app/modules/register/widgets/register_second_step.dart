// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/modules/register/controllers/register_controller.dart';
import 'package:cuidame/app/shared/widgets/custom_text_form_field.dart';
import 'package:cuidame/app/shared/widgets/primary_button.dart';

class RegisterSecondStep extends StatelessWidget {
  const RegisterSecondStep({
    super.key,
    required this.controller,
  });

  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: Spacements.L,
        right: Spacements.M,
        left: Spacements.M,
        bottom: Spacements.S,
      ),
      decoration: BoxDecoration(
        color: AppColors.light,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Escolha sua senha',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Spacements.S),
          Text(
            'Sua senha deve ter no mínimo 8 caracteres,\ncontendo um caractere especial.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Spacements.XL),
          Obx(
            () => CustomTextFormField(
              password: true,
              title: 'Senha',
              hintText: 'Digite sua senha',
              onChanged: (value) {
                controller.password.value = value.isNotEmpty ? value : null;
              },
              errorText: controller.validatePassword,
            ),
          ),
          const SizedBox(height: Spacements.S),
          Obx(
            () => CustomTextFormField(
              password: true,
              title: 'Confirme sua senha',
              hintText: 'Digite sua senha novamente',
              onChanged: (value) {
                controller.rePassword.value = value.isNotEmpty ? value : null;
              },
              errorText: controller.validateRePassword,
            ),
          ),
          const SizedBox(height: Spacements.S),
          Obx(
            () => PrimaryButton(
              onPressed: controller.formValidatePassword ? controller.submitSecondStep : null,
              text: 'Próximo',
              icon: Icons.arrow_forward,
              expanded: true,
              loading: controller.loading.value,
            ),
          ),
          const SizedBox(height: Spacements.XS),
          Text(
            'Passo 2 de 3',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
