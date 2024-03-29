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

class NotificationPolicyPermissionPage extends StatefulWidget {
  const NotificationPolicyPermissionPage({super.key});

  @override
  State<NotificationPolicyPermissionPage> createState() => _NotificationPolicyPermissionPageState();
}

class _NotificationPolicyPermissionPageState extends State<NotificationPolicyPermissionPage> {
  final notificationService = DependencesInjector.get<LocalNotificationService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: CustomAppBar(
        context: context,
        backgroundColor: AppColors.primary,
        title: const Text('Voltar'),
        transparent: true,
        onTap: () {
          if (notificationService.statusNotificationPolicyPermission.isGranted) {
            Get.back();
          } else {
            Utils.toast(
                'Permissão', 'Você precisa dar permissão da notificação sobrepor o não pertube', ToastType.warning);
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
                      'Permitir sobrepor o não pertube',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Spacements.S),
                    Text(
                      'Precisamos que habilite o aplicativo para sobrepor o não pertube quando necessário',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Spacements.XL),
                    const Image(
                      image: AssetImage(AppAssets.permissionNotification),
                      height: 157,
                    ),
                    const SizedBox(height: Spacements.XL),
                    PrimaryButton(
                      onPressed: () {
                        notificationService.openDoNotDisturbSettings();
                      },
                      text: 'Configurar não pertube',
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
