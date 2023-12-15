import 'package:cuidame/app/configs/app_assets.dart';
import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/modules/start/controllers/start_controller.dart';
import 'package:cuidame/app/router/routes.dart';
import 'package:cuidame/app/shared/widgets/circle_button.dart';
import 'package:cuidame/app/shared/widgets/primary_button.dart';
import 'package:cuidame/app/shared/widgets/safe_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final controller = DependencesInjector.get<StartController>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(Spacements.XS),
              child: SafeScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: size.height * .2),
                    const Image(
                      image: AssetImage(
                        AppAssets.logoIcon,
                      ),
                      height: 140,
                    ),
                    SizedBox(height: size.height * .2),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(Spacements.S),
                      decoration: BoxDecoration(
                        color: AppColors.light,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'cuida.me',
                            style: Theme.of(context).textTheme.headlineLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: Spacements.S),
                          Text(
                            'Você cuida, nós te ajudamos',
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: Spacements.XL),
                          Row(
                            children: [
                              Obx(
                                () => TextButton(
                                  style: TextButton.styleFrom(
                                    shadowColor: AppColors.black,
                                    backgroundColor: AppColors.lightGray,
                                    elevation: 2,
                                    shape: const CircleBorder(),
                                  ),
                                  onPressed: controller.signInGoogle,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: Spacements.XS,
                                      horizontal: Spacements.XS,
                                    ),
                                    child: !controller.loadingSignInGoogle.value
                                        ? const Image(
                                            image: AssetImage(AppAssets.googleIcon),
                                          )
                                        : const CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                              const SizedBox(width: Spacements.XS),
                              Expanded(
                                child: PrimaryButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.register);
                                  },
                                  expanded: true,
                                  text: 'Cadastre-se',
                                  icon: Icons.arrow_outward,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: Spacements.XS),
                          Material(
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(Routes.signIn);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(Spacements.XXS),
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: 'Já possui uma conta ?',
                                    style: Theme.of(context).textTheme.bodyLarge,
                                    children: [
                                      TextSpan(
                                        text: ' Acessar',
                                        style: Theme.of(context).textTheme.labelLarge,
                                      ),
                                    ],
                                  ),
                                ),
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
            Positioned(
              right: 0,
              child: CircleButton(
                onTap: () {
                  Get.toNamed(Routes.patientQrCode);
                },
                backGroundColor: AppColors.light,
                elevation: 1,
                icon: Icons.qr_code_2,
                sizeIcon: Spacements.L,
                sizeCircle: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
