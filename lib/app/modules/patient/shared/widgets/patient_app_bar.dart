// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuidame/app/data/services/patient_login_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/router/routes.dart';

class PatientAppBar extends StatelessWidget implements PreferredSize {
  final AppBar appBar;
  final Widget? subTitle;
  final bool bgWhite;

  PatientAppBar({
    super.key,
    required this.appBar,
    this.subTitle,
    this.bgWhite = true,
  });

  final patientLoginService = DependencesInjector.get<PatientLoginService>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Obx(
        () => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Get.toNamed(Routes.myProfile);
              },
              child: const CircleAvatar(
                backgroundColor: AppColors.primary,
                radius: 24,
              ),
            ),
            const SizedBox(width: Spacements.S),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Olá ',
                    style: Theme.of(context).textTheme.titleLarge,
                    children: [
                      TextSpan(
                        text: '${patientLoginService.patient?.displayName}!',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
                subTitle ?? const SizedBox(),
              ],
            ),
          ],
        ),
      ),
      centerTitle: false,
      titleSpacing: Spacements.M,
      backgroundColor: bgWhite ? Colors.white : Colors.transparent,
      forceMaterialTransparency: true,
      automaticallyImplyLeading: false,
      // systemOverlayStyle: Systemm,
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => Size.fromHeight(appBar.toolbarHeight ?? appBar.preferredSize.height);
}
