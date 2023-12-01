import 'package:cuidame/app/configs/app_assets.dart';
import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/constants/toast_type.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/data/services/local_notification_service.dart';
import 'package:cuidame/app/shared/gutter.dart';
import 'package:cuidame/app/shared/widgets/custom_app_bar.dart';
import 'package:cuidame/app/shared/widgets/primary_button.dart';
import 'package:cuidame/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationPermissionPage extends StatefulWidget {
  const NotificationPermissionPage({super.key});

  @override
  State<NotificationPermissionPage> createState() => _NotificationPermissionPageState();
}

class _NotificationPermissionPageState extends State<NotificationPermissionPage> {
  final notificationService = DependencesInjector.get<LocalNotificationService>();
  @override
  Widget build(BuildContext context) {
    final bodyText = notificationService.statusNotificationPermission.isPermanentlyDenied
        ? 'Precisamos da permissão da notificação para que o app funcione de forma correta, para isso clique em configurações e habilite as notificações'
        : 'Precisamos da permissão da notificação para que o app funcione de forma correta';
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: CustomAppBar(
        context: context,
        backgroundColor: AppColors.primary,
        title: const Text('Voltar'),
        transparent: true,
        onTap: () {
          if (notificationService.statusNotificationPermission.isGranted) {
            Get.back();
          } else {
            Utils.toast('Permissão', 'Você precisa dar permissão de notificação', ToastType.warning);
          }
        },
      ),
      body: SafeArea(
        child: Gutter(
          isSmall: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              const Image(
                image: AssetImage(
                  AppAssets.logoIcon,
                ),
                height: 140,
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacements.S,
                  vertical: Spacements.M,
                ),
                decoration: BoxDecoration(
                  color: AppColors.light,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Permitir notificações',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Spacements.S),
                    Text(
                      bodyText,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Spacements.XL),
                    const Image(
                      image: AssetImage(AppAssets.doNotDisturb),
                      height: 157,
                    ),
                    const SizedBox(height: Spacements.XL),
                    PrimaryButton(
                      onPressed: () {
                        if (notificationService.statusNotificationPermission.isDenied) {
                          notificationService.checkPermission();
                        } else {
                          notificationService.openSettings();
                        }
                      },
                      text: 'Habilitar notificações',
                      icon: Icons.notifications_outlined,
                      expanded: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
