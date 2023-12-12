import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/data/repositories/caregiver_repository.dart';
import 'package:cuidame/app/data/repositories/firebase_storage_repository.dart';
import 'package:cuidame/app/data/repositories/patient_repository.dart';
import 'package:cuidame/app/data/repositories/schedulings_repository.dart';
import 'package:cuidame/app/data/services/caregiver_login_service.dart';
import 'package:cuidame/app/data/socket/socket_io_client.dart';

void setupRepositoryInjections() {
  DependencesInjector.registerLazySingleton<SchedulesRepository>(
    () => SchedulesRepositoryImpl(),
  );

  DependencesInjector.registerLazySingleton<CaregiverRepository>(
    () => CaregiverRepositoryImpl(),
  );

  DependencesInjector.registerLazySingleton<FirebaseStorageRepository>(
    () => FirebaseStorageRepositoryImpl(
      DependencesInjector.get<CaregiverLoginService>(),
    ),
  );

  DependencesInjector.registerLazySingleton<PatientRepository>(
    () => PatientRepositoryImpl(
      DependencesInjector.get<SocketIOClient>(),
    ),
  );
}
