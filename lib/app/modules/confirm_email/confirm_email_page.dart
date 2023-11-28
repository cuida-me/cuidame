import 'package:cuidame/app/configs/app_assets.dart';
import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/modules/confirm_email/controllers/confirm_email_controller.dart';
import 'package:cuidame/app/shared/widgets/custom_app_bar.dart';
import 'package:cuidame/app/shared/widgets/primary_button.dart';
import 'package:cuidame/app/shared/widgets/safe_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmEmailPage extends StatefulWidget {
  const ConfirmEmailPage({super.key});

  @override
  State<ConfirmEmailPage> createState() => _ConfirmEmailPageState();
}

class _ConfirmEmailPageState extends State<ConfirmEmailPage> {
  final controller = DependencesInjector.get<ConfirmEmailController>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: CustomAppBar(
        context: context,
        transparent: true,
        title: const Text('Sair'),
        onTap: () {
          controller.signOut();
        },
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
                Container(
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
                        'Confirme seu e-mail',
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: Spacements.S),
                      Text(
                        'Enviamos para seu email um link, abra o link\npara validar o seu e-mail',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: Spacements.XL),
                      const Image(
                        image: AssetImage(AppAssets.confirmEmail),
                        height: 157,
                      ),
                      const SizedBox(height: Spacements.S),
                      Obx(
                        () => PrimaryButton(
                          onPressed: controller.timerSendEmail.value == null ? controller.resendEmail : null,
                          text: controller.timerSendEmail.value == null
                              ? 'Reenviar E-mail'
                              : 'Aguarde ${controller.timerSendEmail.value} segundos',
                          icon: controller.timerSendEmail.value == null
                              ? Icons.forward_to_inbox
                              : Icons.mark_email_unread_outlined,
                          expanded: true,
                          loading: controller.loading.value,
                        ),
                      ),
                      const SizedBox(height: Spacements.XS),
                      Text(
                        'Passo 3 de 3',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
