import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/modules/caregiver/patient_connect/controllers/patient_connect_controller.dart';
import 'package:cuidame/app/modules/caregiver/patient_connect/widgets/scan_qrcode.dart';
import 'package:cuidame/app/router/routes.dart';
import 'package:cuidame/app/shared/widgets/custom_app_bar.dart';
import 'package:cuidame/app/shared/widgets/safe_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientConnectPage extends StatefulWidget {
  const PatientConnectPage({super.key});

  @override
  State<PatientConnectPage> createState() => _PatientConnectPageState();
}

class _PatientConnectPageState extends State<PatientConnectPage> {
  final controller = DependencesInjector.get<PatientConnectController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: CustomAppBar(
        context: context,
        title: const Text('Voltar'),
        transparent: true,
        onTap: () {
          Get.offAllNamed(Routes.navigation);
        },
      ),
      body: SafeArea(
        child: SafeScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Spacements.XS),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacements.S,
                vertical: Spacements.M,
              ),
              decoration: BoxDecoration(
                color: AppColors.light,
                borderRadius: BorderRadius.circular(50),
              ),
              child: ScanQRCode(controller: controller),
            ),
          ),
        ),
      ),
    );
  }
}
