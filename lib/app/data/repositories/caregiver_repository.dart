import 'package:cuidame/app/data/models/caregiver/caregiver_model.dart';
import 'package:cuidame/app/data/models/caregiver/caregiver_update_model.dart';
import 'package:cuidame/app/data/models/patient/patient_model.dart';
import 'package:cuidame/app/data/models/patient/patient_update_model.dart';
import 'package:cuidame/app/data/providers/http/http_client.dart';
import 'package:cuidame/app/utils/utils.dart';

abstract class CaregiverRepository {
  Future<bool> registerCaregiver();
  Future<CaregiverModel> retrieveMyProfile();
  Future<CaregiverUpdateModel?> updateMyProfile(CaregiverUpdateModel caregiver);
  Future retrievePatient();
  Future<bool> createPatient(PatientModel patient);
  Future<bool> updatePatient(PatientUpdateModel patient);
  Future<bool> deletePatient();
  Future<bool> linkPatientDevice(String token);
}

class CaregiverRepositoryImpl implements CaregiverRepository {
  @override
  Future<bool> registerCaregiver() async {
    final res = await httpClientCaregiver.post(Uri.https(Utils.apiUrlBase, '/caregiver'));
    return res.statusCode == 201;
  }

  @override
  Future<CaregiverModel> retrieveMyProfile() async {
    final res = await httpClientCaregiver.get(Uri.https(Utils.apiUrlBase, '/caregiver'));
    return CaregiverModel.fromJson(res.body);
  }

  @override
  Future<CaregiverUpdateModel?> updateMyProfile(CaregiverUpdateModel caregiver) async {
    final res = await httpClientCaregiver.put(
      Uri.https(Utils.apiUrlBase, '/caregiver'),
      body: caregiver.toJson(),
    );
    if (res.statusCode == 200) return CaregiverUpdateModel.fromJson(res.body);
    return null;
  }

  @override
  Future<PatientModel?> retrievePatient() async {
    final res = await httpClientCaregiver.get(Uri.https(Utils.apiUrlBase, 'patient'));
    if (res.statusCode == 400) {
      return null;
    }
    return PatientModel.fromJson(res.body);
  }

  @override
  Future<bool> createPatient(PatientModel patient) async {
    final res = await httpClientCaregiver.post(
      Uri.https(Utils.apiUrlBase, '/patient'),
      body: patient.toJson(),
    );

    return res.statusCode == 200 || res.statusCode == 201;
  }

  @override
  Future<bool> updatePatient(PatientUpdateModel patient) async {
    final res = await httpClientCaregiver.put(
      Uri.https(Utils.apiUrlBase, '/patient'),
      body: patient.toJson(),
    );
    return res.statusCode == 200;
  }

  @override
  Future<bool> deletePatient() async {
    final res = await httpClientCaregiver.delete(
      Uri.https(Utils.apiUrlBase, '/patient'),
    );
    return res.statusCode == 200;
  }

  @override
  Future<bool> linkPatientDevice(String token) async {
    final res = await httpClientCaregiver.post(
      Uri.https(Utils.apiUrlBase, '/caregiver/patient/device/$token'),
    );

    return res.statusCode == 200;
  }
}
