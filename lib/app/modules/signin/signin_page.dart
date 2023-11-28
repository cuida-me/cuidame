import 'package:cuidame/app/configs/app_assets.dart';
import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/modules/signin/controllers/signin_controller.dart';
import 'package:cuidame/app/router/routes.dart';
import 'package:cuidame/app/shared/widgets/custom_app_bar.dart';
import 'package:cuidame/app/shared/widgets/custom_text_form_field.dart';
import 'package:cuidame/app/shared/widgets/primary_button.dart';
import 'package:cuidame/app/shared/widgets/safe_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final controller = DependencesInjector.get<SignInController>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: CustomAppBar(
        context: context,
        backgroundColor: AppColors.primary,
        title: const Text('Tela Inicial'),
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
                        'Acesse a sua conta',
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: Spacements.S),
                      Text(
                        'Preencha as informações abaixo para acessar sua conta de cuidador.',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: Spacements.XL),
                      Obx(
                        () => CustomTextFormField(
                          keyboardType: TextInputType.emailAddress,
                          title: 'E-mail',
                          hintText: 'Digite seu e-mail',
                          onChanged: (value) {
                            controller.email.value = value.isNotEmpty ? value : null;
                          },
                          errorText: controller.validateEmail,
                        ),
                      ),
                      const SizedBox(height: Spacements.S),
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
                        () => PrimaryButton(
                          onPressed: controller.formValidateSignIn ? controller.submit : null,
                          text: 'Acessar',
                          icon: Icons.arrow_forward,
                          expanded: true,
                          loading: controller.loading.value,
                        ),
                      ),
                      const SizedBox(height: Spacements.S),
                      Material(
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(Routes.forgotPassword);
                          },
                          child: Text(
                            'Esqueci minha senha',
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
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
