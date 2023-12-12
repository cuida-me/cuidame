import 'package:cuidame/app/configs/constants/toast_type.dart';
import 'package:cuidame/app/data/services/caregiver_service.dart';
import 'package:cuidame/app/router/routes.dart';
import 'package:cuidame/app/utils/utils.dart';
import 'package:cuidame/app/utils/utils_logger.dart';
import 'package:get/get.dart';

class PatientConnectController extends GetxController {
  final CaregiverService _caregiverService;

  final _isRead = false.obs;
  final _loading = false.obs;

  PatientConnectController(this._caregiverService);

  bool get loading => _loading.value;

  Future onReadQRCode(String qrCode) async {
    if (_loading.value || _isRead.value) return;

    _loading.value = true;
    _caregiverService.linkPatientDevice(qrCode).then((value) {
      _isRead.value = true;
      Get.offAllNamed(Routes.navigation);
      Utils.toast('Conectado com sucesso', 'Paciente conectado com sucesso', ToastType.info);
    }).catchError((err) {
      UtilsLogger().e(err);
    }).whenComplete(() => _loading.value = false);
  }
}
