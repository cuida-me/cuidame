// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/shared/widgets/custom_text_form_field.dart';
import 'package:cuidame/app/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import 'package:cuidame/app/modules/forgot_password/controllers/forgot_password_controller.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class FormForgotPassword extends StatelessWidget {
  const FormForgotPassword({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ForgotPasswordController controller;

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
            'Recuperar conta',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Spacements.S),
          Text(
            'Informe o email  associado a sua conta para\nrecupera-la.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Spacements.XL),
          Obx(
            () => CustomTextFormField(
              keyboardType: TextInputType.emailAddress,
              title: 'E-mail',
              hintText: 'Digite seu e-mail',
              initialValue: controller.email.value,
              onChanged: (value) {
                controller.email.value = value.isNotEmpty ? value : null;
              },
              errorText: controller.validateEmail,
            ),
          ),
          const SizedBox(height: Spacements.S),
          Obx(
            () => CustomTextFormField(
              keyboardType: TextInputType.emailAddress,
              title: 'Confirme seu e-mail',
              hintText: 'Digite seu e-mail novamente',
              onChanged: (value) {
                controller.reEmail.value = value.isNotEmpty ? value : null;
              },
              errorText: controller.validateReEmail,
            ),
          ),
          const SizedBox(height: Spacements.S),
          Obx(
            () => PrimaryButton(
              onPressed: controller.formValidateForgotPassword ? controller.submit : null,
              text: 'Recuperar conta',
              icon: Icons.arrow_forward,
              expanded: true,
              loading: controller.loading.value,
            ),
          ),
        ],
      ),
    );
  }
}
