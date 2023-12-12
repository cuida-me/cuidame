import 'dart:async';

import 'package:cuidame/app/data/models/patient/patient_qr_model.dart';
import 'package:cuidame/app/data/models/patient/patient_token_model.dart';
import 'package:cuidame/app/utils/utils.dart';
import 'package:cuidame/app/utils/utils_logger.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

abstract class PatientRepository {
  Stream get socketConnected;
  Stream patientQrConnect(PatientQrModel patientQr);
  Stream<PatientTokenModel> patientQrListen();
  Stream patientFinishLoginListen();
}

class PatientRepositoryImpl implements PatientRepository {
  IO.Socket socket = IO.io('https://${Utils.apiUrlBase}', {
    'autoConnect': true,
    'transports': ['websocket']
  });

  final _socketConnectedStream = StreamController<bool>();

  PatientRepositoryImpl() {
    _initSocket();
  }

  @override
  Stream get socketConnected => _socketConnectedStream.stream;

  _initSocket() {
    socket.onConnect((_) {
      UtilsLogger().i('Connected Socket IO');
      _socketConnectedStream.add(true);
    });
    socket.onDisconnect((data) => UtilsLogger().w(data));
    socket.onError((err) => UtilsLogger().e(err));
  }

  @override
  Stream patientQrConnect(PatientQrModel patientQr) {
    final streamController = StreamController();
    socket.emit('patient-qr', patientQr.toMap());
    return streamController.stream;
  }

  @override
  Stream<PatientTokenModel> patientQrListen() {
    final streamController = StreamController<PatientTokenModel>();
    socket.on('patient-qr', (data) {
      final token = PatientTokenModel.fromMap(data);
      streamController.add(token);
    });
    return streamController.stream;
  }

  @override
  Stream patientFinishLoginListen() {
    final streamController = StreamController();
    socket.on('finishi-login', (data) {
      streamController.add(data);
    });
    return streamController.stream;
  }
}
