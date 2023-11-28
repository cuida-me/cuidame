import 'package:cuidame/app/configs/app_assets.dart';
import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendEmailForgotPassword extends StatelessWidget {
  const SendEmailForgotPassword({super.key});

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
            'Acesse seu e-mail',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Spacements.S),
          Text(
            'Te enviamos um e-mail de alteração\nde senha',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Spacements.XL),
          const Image(
            image: AssetImage(AppAssets.forgotPassword),
            height: 157,
          ),
          const SizedBox(height: Spacements.S),
          PrimaryButton(
            onPressed: () => Get.back(),
            text: 'Fazer login',
            icon: Icons.arrow_forward,
            expanded: true,
          ),
        ],
      ),
    );
  }
}
