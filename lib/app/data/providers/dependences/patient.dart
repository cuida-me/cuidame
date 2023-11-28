import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/modules/patient/patient_qr_code/controllers/patient_qr_code_controller.dart';

void setupPatientInjections() {
  DependencesInjector.registerFactory<PatientQrCodeController>(
    () => PatientQrCodeController(),
  );
}
