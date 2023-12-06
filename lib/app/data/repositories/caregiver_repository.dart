import 'package:cuidame/app/data/models/caregiver/caregiver_model.dart';
import 'package:cuidame/app/data/models/caregiver/caregiver_update_model.dart';
import 'package:cuidame/app/data/models/patient_model.dart';
import 'package:cuidame/app/data/providers/http/http_client.dart';
import 'package:cuidame/app/utils/utils.dart';

abstract class CaregiverRepository {
  Future<bool> registerCaregiver();
  Future<CaregiverModel> retrieveMyProfile();
  Future<CaregiverUpdateModel?> updateMyProfile(CaregiverUpdateModel caregiver);
  Future retrievePatient();
  Future<bool> createPatient(PatientModel patient);
}

class CaregiverRepositoryImpl implements CaregiverRepository {
  final HttpClient _client;

  CaregiverRepositoryImpl(this._client);

  @override
  Future<bool> registerCaregiver() async {
    final res = await _client.post(Uri.https(Utils.apiUrlBase, '/caregiver'));
    return res.statusCode == 201;
  }

  @override
  Future<CaregiverModel> retrieveMyProfile() async {
    final res = await _client.get(Uri.https(Utils.apiUrlBase, '/caregiver'));
    return CaregiverModel.fromJson(res.body);
  }

  @override
  Future<CaregiverUpdateModel?> updateMyProfile(CaregiverUpdateModel caregiver) async {
    final res = await _client.put(
      Uri.https(Utils.apiUrlBase, '/caregiver'),
      body: caregiver.toJson(),
    );
    if (res.statusCode == 200) return CaregiverUpdateModel.fromJson(res.body);
    return null;
  }

  @override
  Future<PatientModel?> retrievePatient() async {
    final res = await _client.get(Uri.https(Utils.apiUrlBase, 'patient'));
    if (res.statusCode == 400) {
      return null;
    }
    return PatientModel.fromJson(res.body);
  }

  @override
  Future<bool> createPatient(PatientModel patient) async {
    final res = await _client.post(
      Uri.https(Utils.apiUrlBase, '/patient'),
      body: patient.toJson(),
    );

    return res.statusCode == 200 || res.statusCode == 201;
  }
}
