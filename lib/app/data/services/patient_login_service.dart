import 'package:cuidame/app/configs/constants/toast_type.dart';
import 'package:cuidame/app/data/models/patient/patient_qr_model.dart';
import 'package:cuidame/app/data/repositories/patient_repository.dart';
import 'package:cuidame/app/data/storage/patient_token_storage.dart';
import 'package:cuidame/app/router/routes.dart';
import 'package:cuidame/app/utils/utils.dart';
import 'package:cuidame/app/utils/utils_logger.dart';
import 'package:get/get.dart';

class PatientLoginService {
  final PatientRepository _patientRepository;
  final PatientTokenStorage _patientTokenStorage;

  final _userToken = RxnString();
  final _qrCode = RxnString();
  final _loading = false.obs;

  PatientLoginService(
    this._patientRepository,
    this._patientTokenStorage,
  ) {
    checkPatientIsLogged();
  }

  String? get qrCode => _qrCode.value;
  bool get loading => _loading.value;
  Future<String?> get userToken async => await _patientTokenStorage.getToken();

  checkPatientIsLogged() async {
    final token = await _patientTokenStorage.getToken();
    if (token != null) {
      UtilsLogger().i('Token: $token');
      _userToken.value = token;
      Get.offAllNamed(Routes.patientSchedulings);
    }
  }

  Stream socketConnected() {
    return _patientRepository.socketConnected;
  }

  void patientQrListen() {
    _patientRepository.patientQrListen().listen((e) {
      _qrCode.value = e.token;
      _loading.value = false;
    });
  }

  void patientQrConnect(PatientQrModel patientQr) {
    _loading.value = true;
    _patientRepository.patientQrConnect(patientQr).listen((e) {
      UtilsLogger().i(e);
    });
  }

  void patientFinishLoginListen() {
    _patientRepository.patientFinishLoginListen().listen((e) {
      UtilsLogger().i(e);
      _patientTokenStorage.setToken(e.token);
      Get.offAllNamed(Routes.patientSchedulings);
    });
  }

  void signOut() async {
    final res = await _patientTokenStorage.removeToken();
    if (res ?? false) {
      Get.offAllNamed(Routes.start);
    } else {
      Utils.toast(
        'Erro',
        'Houve um erro ao tentar sair',
        ToastType.error,
      );
    }
  }
}
