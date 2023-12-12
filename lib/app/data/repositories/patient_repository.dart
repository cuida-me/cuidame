import 'dart:async';
import 'dart:convert';

import 'package:cuidame/app/data/models/patient/patient_finish_login_model.dart';
import 'package:cuidame/app/data/models/patient/patient_model.dart';
import 'package:cuidame/app/data/models/patient/patient_qr_model.dart';
import 'package:cuidame/app/data/models/patient/patient_token_model.dart';
import 'package:cuidame/app/data/models/scheduling_day_model.dart';
import 'package:cuidame/app/data/providers/http/http_client.dart';
import 'package:cuidame/app/data/socket/socket_io_client.dart';
import 'package:cuidame/app/utils/utils.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart';

abstract class PatientRepository {
  Stream get socketConnected;
  Stream patientQrConnect(PatientQrModel patientQr);
  Stream<PatientTokenModel> patientQrListen();
  Stream<PatientFinishLoginModel> patientFinishLoginListen();
  Future<PatientModel> retrieveMyProfile();
  Future<List<SchedulingDayModel>> retrieveSchedulingWeek();
  Future<bool> schedulingDone(int? id);
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

  @override
  Future<PatientModel> retrieveMyProfile() async {
    final res = await httpClientPatient.get(
      Uri.https(Utils.apiUrlBase, 'patient'),
    );

    return PatientModel.fromJson(res.body);
  }

  @override
  Future<List<SchedulingDayModel>> retrieveSchedulingWeek() async {
    final res = await httpClientPatient.get(
      Uri.https(Utils.apiUrlBase, 'scheduling/week'),
    );

    final resList = jsonDecode(const Utf8Decoder().convert(res.bodyBytes)) as List;

    return resList.map((e) => SchedulingDayModel.fromMap(e)).toList();
  }

  @override
  Future<bool> schedulingDone(int? id) async {
    final res = await httpClientPatient.put(
      Uri.https(Utils.apiUrlBase, 'scheduling/$id'),
    );

    return res.statusCode == 200 || res.statusCode == 201;
  }
}
