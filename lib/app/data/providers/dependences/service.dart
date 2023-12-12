import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/data/repositories/caregiver_repository.dart';
import 'package:cuidame/app/data/repositories/patient_repository.dart';
import 'package:cuidame/app/data/services/caregiver_login_service.dart';
import 'package:cuidame/app/data/services/caregiver_service.dart';
import 'package:cuidame/app/data/services/local_notification_service.dart';
import 'package:cuidame/app/data/services/patient_login_service.dart';
import 'package:cuidame/app/data/services/patient_service.dart';
import 'package:cuidame/app/data/services/scheduling_service.dart';
import 'package:cuidame/app/data/storage/patient_token_storage.dart';

void setupServiceInjection() {
  DependencesInjector.registerLazySingleton<PatientLoginService>(
    () => PatientLoginService(
      DependencesInjector.get<PatientRepository>(),
      DependencesInjector.get<PatientTokenStorage>(),
    ),
  );

  DependencesInjector.registerLazySingleton<CaregiverLoginService>(
    () => CaregiverLoginService(
      DependencesInjector.get<CaregiverService>(),
    ),
  );

  DependencesInjector.registerLazySingleton<LocalNotificationService>(
    () => LocalNotificationService(),
  );

  DependencesInjector.registerLazySingleton<SchedulingService>(
    () => SchedulingService(
      DependencesInjector.get<LocalNotificationService>(),
    ),
  );

  DependencesInjector.registerLazySingleton<CaregiverService>(
    () => CaregiverService(
      DependencesInjector.get<CaregiverRepository>(),
    ),
  );

  DependencesInjector.registerLazySingleton<PatientService>(
    () => PatientService(
      DependencesInjector.get<PatientRepository>(),
      DependencesInjector.get<SchedulingService>(),
    ),
  );
}
