import 'package:cuidame/app/configs/app_assets.dart';
import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/modules/forgot_password/controllers/forgot_password_controller.dart';
import 'package:cuidame/app/modules/forgot_password/widgets/form_forgot_password.dart';
import 'package:cuidame/app/modules/forgot_password/widgets/send_email_forgot_password.dart';
import 'package:cuidame/app/shared/widgets/custom_app_bar.dart';
import 'package:cuidame/app/shared/widgets/safe_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final controller = DependencesInjector.get<ForgotPasswordController>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: CustomAppBar(
        context: context,
        backgroundColor: AppColors.primary,
        title: const Text('Voltar'),
        transparent: true,
      ),
      body: SafeArea(
        child: SafeScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Spacements.XS),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: size.height * .05),
                const Image(
                  image: AssetImage(
                    AppAssets.logoIcon,
                  ),
                  height: 140,
                ),
                SizedBox(height: size.height * .05),
                const Spacer(),
                Obx(() {
                  if (controller.sendEmail.value) return const SendEmailForgotPassword();

                  return FormForgotPassword(controller: controller);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
