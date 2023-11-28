import 'dart:math';

import 'package:get/get.dart';

class PatientQrCodeController extends GetxController {
  final qrCodeData = RxnString();

  PatientQrCodeController() {
    qrCodeData.value = Random().nextDouble().toString();
  }

  void refreshQrCode() {
    qrCodeData.value = Random().nextDouble().toString();
  }
}
