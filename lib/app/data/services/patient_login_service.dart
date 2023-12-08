import 'package:cuidame/app/data/models/patient/patient_model.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class PatientLoginService {
  final _patient = Rxn<PatientModel>();

  PatientLoginService() {
    initAuthPatient();
  }

  initAuthPatient() {
    _patient.value = PatientModel(name: 'Samuel');
  }

  PatientModel? get patient => _patient.value;

  void signOut() {}
}
