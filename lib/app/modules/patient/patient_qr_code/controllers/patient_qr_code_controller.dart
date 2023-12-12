import 'dart:io';
import 'package:cuidame/app/data/models/patient/patient_qr_model.dart';
import 'package:cuidame/app/data/services/patient_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';

class PatientQrCodeController extends GetxController {
  final PatientService _patientService;

  PatientQrCodeController(this._patientService) {
    initSocketConnection();
  }

  String? get qrCode => _patientService.qrCode;
  bool get loading => _patientService.qrCode == null;

  void initSocketConnection() async {
    final deviceInfo = DeviceInfoPlugin();
    String? id;

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      id = androidInfo.id;
    }

    _patientService.socketConnected().listen((e) {
      _patientService.patientQrListen();
      _patientService.patientQrConnect(PatientQrModel(deviceId: id!));
      _patientService.patientFinishLoginListen();
    });
  }

  void refreshQrCode() {}
}
