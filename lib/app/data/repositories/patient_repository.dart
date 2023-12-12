import 'dart:async';

import 'package:cuidame/app/data/models/patient/patient_finish_login_model.dart';
import 'package:cuidame/app/data/models/patient/patient_qr_model.dart';
import 'package:cuidame/app/data/models/patient/patient_token_model.dart';
import 'package:cuidame/app/data/socket/socket_io_client.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart';

abstract class PatientRepository {
  Stream get socketConnected;
  Stream patientQrConnect(PatientQrModel patientQr);
  Stream<PatientTokenModel> patientQrListen();
  Stream<PatientFinishLoginModel> patientFinishLoginListen();
}

class PatientRepositoryImpl implements PatientRepository {
  final SocketIOClient _socketClient;
  Socket? _socket;

  PatientRepositoryImpl(this._socketClient) {
    _socket = _socketClient.socket;
  }

  @override
  Stream get socketConnected => _socketClient.socketConnected;

  @override
  Stream patientQrConnect(PatientQrModel patientQr) {
    final streamController = StreamController();
    _socket?.emit('patient-qr', patientQr.toMap());
    return streamController.stream;
  }

  @override
  Stream<PatientTokenModel> patientQrListen() {
    final streamController = StreamController<PatientTokenModel>();
    _socket?.on('patient-qr', (data) {
      final token = PatientTokenModel.fromMap(data);
      streamController.add(token);
    });
    return streamController.stream;
  }

  @override
  Stream<PatientFinishLoginModel> patientFinishLoginListen() {
    final streamController = StreamController<PatientFinishLoginModel>();
    _socket?.on('finish-login', (data) {
      final finishLogin = PatientFinishLoginModel.fromMap(data);
      streamController.add(finishLogin);
    });
    return streamController.stream;
  }

  Future retrieveMyProfile() async {}
}
