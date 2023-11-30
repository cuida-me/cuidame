import 'package:cuidame/app/configs/app_assets.dart';
import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/data/services/local_notification_service.dart';
import 'package:cuidame/app/router/routes.dart';
import 'package:cuidame/app/shared/gutter.dart';
import 'package:cuidame/app/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationPermission extends StatefulWidget {
  const NotificationPermission({super.key});

  @override
  State<NotificationPermission> createState() => _NotificationPermissionState();
}

class _NotificationPermissionState extends State<NotificationPermission> {
  final notificationService = DependencesInjector.get<LocalNotificationService>();
  @override
  Widget build(BuildContext context) {
    final bodyText = notificationService.statusNotificationPermission.isPermanentlyDenied
        ? 'Precisamos da permissão da notificação para que o app funcione de forma correta, para isso clique em configurações e habilite as notificações'
        : 'Precisamos da permissão da notificação para que o app funcione de forma correta';
    return Scaffold(
      backgroundColor: AppColors.primary,
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
                      'Permitir as notificações',
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
                      image: AssetImage(AppAssets.permissionNotification),
                      height: 157,
                    ),
                    const SizedBox(height: Spacements.XL),
                    if (notificationService.statusNotificationPermission.isDenied)
                      PrimaryButton(
                        onPressed: () {
                          notificationService.checkPermission().then((value) {
                            if (value) Get.toNamed(Routes.start);
                          });
                        },
                        text: 'Habilitar Notificações',
                        icon: Icons.notifications_outlined,
                        expanded: true,
                      ),
                    if (notificationService.statusNotificationPermission.isPermanentlyDenied)
                      PrimaryButton(
                        onPressed: () {
                          notificationService.openSettings().then((value) {
                            notificationService.checkPermission().then((value) {
                              if (value) Get.toNamed(Routes.start);
                            });
                          });
                        },
                        text: 'Configurações',
                        icon: Icons.settings_outlined,
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
