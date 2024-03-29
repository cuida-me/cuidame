// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuidame/app/data/services/caregiver_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/router/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CaregiverAppBar extends StatelessWidget implements PreferredSize {
  final AppBar appBar;
  final Widget? subTitle;

  CaregiverAppBar({
    super.key,
    required this.appBar,
    this.subTitle,
  });

  final caregiverService = DependencesInjector.get<CaregiverService>();

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
              customBorder: const CircleBorder(),
              child: CircleAvatar(
                backgroundColor: AppColors.primary,
                backgroundImage: caregiverService.caregiver != null
                    ? CachedNetworkImageProvider(
                        caregiverService.caregiver?.avatar ?? '',
                      )
                    : null,
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
                        text: '${caregiverService.caregiver?.name}!',
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
      toolbarHeight: 200,
      backgroundColor: AppColors.light,
      forceMaterialTransparency: true,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => Size.fromHeight(appBar.toolbarHeight ?? appBar.preferredSize.height * 1.2);
}
