import 'dart:io';
import 'package:cuidame/app/data/models/patient/patient_qr_model.dart';
import 'package:cuidame/app/data/services/patient_login_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';

class PatientQrCodeController extends GetxController {
  final PatientLoginService _patientLoginService;

  String? _deviceId;

  PatientQrCodeController(this._patientLoginService) {
    initSocketConnection();
  }

  String? get qrCode => _patientLoginService.qrCode;
  bool get loadingQrCode => _patientLoginService.qrCode == null;
  bool get loading => _patientLoginService.loading;

  void initSocketConnection() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      _deviceId = androidInfo.id;
    }

    _patientLoginService.socketConnected().listen((e) {
      _patientLoginService.patientQrListen();
      _patientLoginService.patientQrConnect(PatientQrModel(deviceId: _deviceId!));
      _patientLoginService.patientFinishLoginListen();
    });
  }

  void refreshQrCode() {
    if (loading) return;
    _patientLoginService.patientQrConnect(PatientQrModel(deviceId: _deviceId!));
  }
}
