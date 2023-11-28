import 'package:cuidame/app/configs/app_assets.dart';
import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/modules/register/controllers/register_controller.dart';
import 'package:cuidame/app/modules/register/widgets/register_first_step.dart';
import 'package:cuidame/app/modules/register/widgets/register_second_step.dart';
import 'package:cuidame/app/shared/widgets/custom_app_bar.dart';
import 'package:cuidame/app/shared/widgets/safe_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controller = DependencesInjector.get<RegisterController>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: CustomAppBar(
        context: context,
        transparent: true,
        title: Obx(() => Text(controller.titleBar.value)),
        onTap: controller.backToEmail,
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
                  if (controller.choosePassword.value) return RegisterSecondStep(controller: controller);

                  return RegisterFirstStep(controller: controller);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
