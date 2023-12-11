import 'dart:convert';

import 'package:cuidame/app/data/models/caregiver/caregiver_model.dart';
import 'package:cuidame/app/data/models/caregiver/caregiver_update_model.dart';
import 'package:cuidame/app/data/models/medication/medication_create_model.dart';
import 'package:cuidame/app/data/models/medication/medication_model.dart';
import 'package:cuidame/app/data/models/medication/medication_type_model.dart';
import 'package:cuidame/app/data/models/patient/patient_model.dart';
import 'package:cuidame/app/data/models/patient/patient_update_model.dart';
import 'package:cuidame/app/data/providers/http/http_client.dart';
import 'package:cuidame/app/utils/utils.dart';

abstract class CaregiverRepository {
  Future<bool> registerCaregiver();
  Future<CaregiverModel> retrieveMyProfile();
  Future<CaregiverUpdateModel?> updateMyProfile(CaregiverUpdateModel caregiver);
  Future<bool> deleteMyAccount();
  Future<PatientModel?> retrievePatient();
  Future<bool> createPatient(PatientModel patient);
  Future<bool> updatePatient(PatientUpdateModel patient);
  Future<bool> deletePatient();
  Future<bool> linkPatientDevice(String token);
  Future<List<MedicationTypeModel>> retrieveMedicationTypes();
  Future<MedicationModel> createMedication(MedicationCreateModel medication);
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
  Future<bool> deleteMyAccount() async {
    final res = await httpClientCaregiver.delete(
      Uri.http(Utils.apiUrlBase, '/caregiver'),
    );
    return res.statusCode == 200;
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

  @override
  Future<List<MedicationTypeModel>> retrieveMedicationTypes() async {
    final res = await httpClientCaregiver.get(
      Uri.https(Utils.apiUrlBase, 'medication/types'),
    );
    final resList = jsonDecode(const Utf8Decoder().convert(res.bodyBytes)) as List;

    return resList.map((e) => MedicationTypeModel.fromMap(e)).toList();
  }

  @override
  Future<MedicationModel> createMedication(MedicationCreateModel medication) async {
    final res = await httpClientCaregiver.post(
      Uri.https(Utils.apiUrlBase, 'medication'),
      body: medication.toJson(),
    );

    return MedicationModel.fromJson(res.body);
  }
}
