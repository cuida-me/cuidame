// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/modules/caregiver/patient_connect/controllers/patient_connect_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:cuidame/app/configs/constants/spacements.dart';

class ScanQRCode extends StatelessWidget {
  const ScanQRCode({
    super.key,
    required this.controller,
  });

  final PatientConnectController controller;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Conecte-se ao paciente',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Spacements.XS),
        Text(
          'Leia o QR code  gerado a partir do app do paciente \npara conectar.',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Spacements.XS),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacements.M),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Obx(
              () => SizedBox(
                height: size.height * 0.4,
                width: size.width * 0.3,
                child: controller.loading
                    ? Container(
                        decoration: BoxDecoration(
                          color: AppColors.black.withOpacity(0.8),
                        ),
                        child: const Center(
                            child: CircularProgressIndicator(
                          color: AppColors.light,
                        )),
                      )
                    : MobileScanner(
                        controller: MobileScannerController(
                          formats: [BarcodeFormat.qrCode],
                        ),
                        onDetect: (capture) {
                          if (capture.barcodes.first.rawValue != null) {
                            controller.onReadQRCode(capture.barcodes.first.rawValue!);
                          }
                        },
                      ),
              ),
            ),
          ),
        ),
        const Spacer(),
        const SizedBox(height: Spacements.XS),
        Text(
          'Passo 2 de 2',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
