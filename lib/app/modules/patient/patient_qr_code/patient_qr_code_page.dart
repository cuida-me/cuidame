import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/modules/patient/patient_qr_code/controllers/patient_qr_code_controller.dart';
import 'package:cuidame/app/shared/widgets/custom_app_bar.dart';
import 'package:cuidame/app/shared/widgets/primary_button.dart';
import 'package:cuidame/app/shared/widgets/safe_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PatientQrCodePage extends StatefulWidget {
  const PatientQrCodePage({super.key});

  @override
  State<PatientQrCodePage> createState() => _PatientQrCodePageState();
}

class _PatientQrCodePageState extends State<PatientQrCodePage> {
  final controller = DependencesInjector.get<PatientQrCodeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: CustomAppBar(
        context: context,
        title: const Text('Voltar'),
        transparent: true,
      ),
      body: SafeArea(
        child: SafeScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Spacements.XS),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacements.S,
                    vertical: Spacements.L,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.light,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Leia o código QR',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: Spacements.S),
                      Text(
                        'Leia o código QR para vincular este dispositivo \nao cuidador',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: Spacements.XL),
                      Obx(
                        () => SizedBox(
                          height: 250,
                          width: 250,
                          child: QrImageView(
                            data: controller.qrCodeData.value ?? '',
                            version: QrVersions.auto,
                            size: 200,
                          ),
                        ),
                      ),
                      const SizedBox(height: Spacements.XL),
                      PrimaryButton(
                        onPressed: () => controller.refreshQrCode(),
                        text: 'Atualizar',
                        icon: Icons.replay_outlined,
                        expanded: true,
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
