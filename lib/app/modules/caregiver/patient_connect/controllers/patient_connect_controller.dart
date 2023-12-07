import 'package:cuidame/app/configs/constants/toast_type.dart';
import 'package:cuidame/app/data/services/caregiver_service.dart';
import 'package:cuidame/app/router/routes.dart';
import 'package:cuidame/app/utils/utils.dart';
import 'package:get/get.dart';

class PatientConnectController extends GetxController {
  final CaregiverService _caregiverService;

  PatientConnectController(this._caregiverService);

  Future onReadQRCode(String qrCode) async {
    // ignore: avoid_print
    print(qrCode);
    await _caregiverService.linkPatientDevice(qrCode).then((value) {
      Utils.toast('Lido', qrCode, ToastType.info);
      Get.offAllNamed(Routes.navigation);
    });
  }
}
