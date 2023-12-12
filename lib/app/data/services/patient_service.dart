import 'package:cuidame/app/data/models/patient/patient_qr_model.dart';
import 'package:cuidame/app/data/repositories/patient_repository.dart';
import 'package:cuidame/app/utils/utils_logger.dart';
import 'package:get/get.dart';

class PatientService {
  final PatientRepository _patientRepository;

  final _qrCode = RxnString();

  final _loading = false.obs;

  PatientService(this._patientRepository);

  String? get qrCode => _qrCode.value;
  bool get loading => _loading.value;

  Stream socketConnected() {
    return _patientRepository.socketConnected;
  }

  void patientQrListen() {
    _patientRepository.patientQrListen().listen((e) {
      _qrCode.value = e.token;
    });
  }

  void patientQrConnect(PatientQrModel patientQr) {
    _patientRepository.patientQrConnect(patientQr).listen((e) {
      UtilsLogger().i(e);
    });
  }

  void patientFinishLoginListen() {
    _patientRepository.patientFinishLoginListen().listen((e) {
      UtilsLogger().i(e);
    });
  }
}
