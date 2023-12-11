import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/data/repositories/caregiver_repository.dart';
import 'package:cuidame/app/data/repositories/firebase_storage_repository.dart';
import 'package:cuidame/app/data/services/caregiver_login_service.dart';
import 'package:cuidame/app/data/services/caregiver_service.dart';
import 'package:cuidame/app/modules/caregiver/patient_medication/controllers/patient_medication_controller.dart';
import 'package:cuidame/app/modules/caregiver/my_profile/controllers/my_profile_controller.dart';
import 'package:cuidame/app/modules/caregiver/patient_connect/controllers/patient_connect_controller.dart';
import 'package:cuidame/app/modules/caregiver/patient_profile/controllers/patient_profile_controller.dart';
import 'package:cuidame/app/modules/caregiver/patient_register/controllers/patient_register_controller.dart';
import 'package:cuidame/app/modules/caregiver/patient_report/controllers/patient_report_controller.dart';

void setupHomeInjections() {
  DependencesInjector.registerFactory<PatientMedicationController>(
    () => PatientMedicationController(
      DependencesInjector.get<CaregiverLoginService>(),
      DependencesInjector.get<CaregiverService>(),
    ),
  );

  DependencesInjector.registerFactory<PatientReportController>(
    () => PatientReportController(),
  );

  DependencesInjector.registerFactory<PatientProfileController>(
    () => PatientProfileController(
      DependencesInjector.get<CaregiverService>(),
      DependencesInjector.get<FirebaseStorageRepository>(),
    ),
  );

  DependencesInjector.registerFactory<MyProfileController>(
    () => MyProfileController(
      DependencesInjector.get<CaregiverLoginService>(),
      DependencesInjector.get<CaregiverService>(),
      DependencesInjector.get<FirebaseStorageRepository>(),
    ),
  );

  DependencesInjector.registerFactory<PatientRegisterController>(
    () => PatientRegisterController(
      DependencesInjector.get<CaregiverRepository>(),
      DependencesInjector.get<CaregiverService>(),
      DependencesInjector.get<FirebaseStorageRepository>(),
    ),
  );

  DependencesInjector.registerFactory<PatientConnectController>(
    () => PatientConnectController(
      DependencesInjector.get<CaregiverService>(),
    ),
  );
}
