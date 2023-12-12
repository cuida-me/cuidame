import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/data/repositories/firebase_storage_repository.dart';
import 'package:cuidame/app/data/services/patient_login_service.dart';
import 'package:cuidame/app/data/services/patient_service.dart';
import 'package:cuidame/app/modules/patient/my_profile_patient/controllers/my_profile_patient_controller.dart';
import 'package:cuidame/app/modules/patient/patient_qr_code/controllers/patient_qr_code_controller.dart';
import 'package:cuidame/app/modules/patient/patient_schedulings/controllers/patient_schedulings_controller.dart';

void setupPatientInjections() {
  DependencesInjector.registerFactory<PatientQrCodeController>(
    () => PatientQrCodeController(
      DependencesInjector.get<PatientLoginService>(),
    ),
  );

  DependencesInjector.registerFactory<PatientSchedulingsController>(
    () => PatientSchedulingsController(
      DependencesInjector.get<PatientService>(),
    ),
  );

  DependencesInjector.registerFactory(
    () => MyProfilePatientController(
      DependencesInjector.get<PatientLoginService>(),
      DependencesInjector.get<PatientService>(),
      DependencesInjector.get<FirebaseStorageRepository>(),
    ),
  );
}
