// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/modules/register/controllers/register_controller.dart';
import 'package:cuidame/app/shared/widgets/custom_text_form_field.dart';
import 'package:cuidame/app/shared/widgets/primary_button.dart';

class RegisterFirstStep extends StatelessWidget {
  const RegisterFirstStep({
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
            'Faça seu cadastro',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Spacements.S),
          Text(
            'Preencha as informações abaixo para criar\nsua conta',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Spacements.XL),
          CustomTextFormField(
            title: 'Nome',
            hintText: 'Digite seu nome',
            initialValue: controller.name.value,
            onChanged: (value) {
              controller.name.value = value.isNotEmpty ? value : null;
            },
          ),
          const SizedBox(height: Spacements.S),
          Obx(
            () => CustomTextFormField(
              keyboardType: TextInputType.emailAddress,
              title: 'E-mail',
              hintText: 'Digite seu e-mail',
              initialValue: controller.email.value,
              onChanged: (value) {
                controller.emailExist.value = false;
                controller.email.value = value.isNotEmpty ? value : null;
              },
              errorText: controller.validateEmail,
            ),
          ),
          const SizedBox(height: Spacements.S),
          Obx(
            () => PrimaryButton(
              onPressed: controller.formValidateEmail ? controller.submitFirstStep : null,
              text: 'Próximo',
              icon: Icons.arrow_forward,
              expanded: true,
            ),
          ),
          const SizedBox(height: Spacements.XS),
          Text(
            'Passo 1 de 3',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
