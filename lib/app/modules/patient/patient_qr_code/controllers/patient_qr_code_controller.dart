import 'dart:math';

import 'package:cuidame/app/router/routes.dart';
import 'package:get/get.dart';

class PatientQrCodeController extends GetxController {
  final qrCodeData = RxnString();

  PatientQrCodeController() {
    qrCodeData.value = Random().nextDouble().toString();
  }

  void refreshQrCode() {
    qrCodeData.value = Random().nextDouble().toString();
    Get.offAllNamed(Routes.patientSchedulings);
  }
}
