import 'package:cuidame/app/data/repositories/patient_repository.dart';
import 'package:cuidame/app/data/storage/patient_token_storage.dart';
import 'package:get/get.dart';

class PatientService {
  final PatientRepository _patientRepository;
  final PatientTokenStorage _patientTokenStorage;

  final _user = RxString('Matheus');
  final _loading = false.obs;

  PatientService(
    this._patientRepository,
    this._patientTokenStorage,
  );

  String get user => _user.value;
  bool get loading => _loading.value;
}
