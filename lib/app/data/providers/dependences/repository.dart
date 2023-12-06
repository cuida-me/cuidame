import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/data/repositories/caregiver_repository.dart';
import 'package:cuidame/app/data/repositories/firebase_storage_repository.dart';
import 'package:cuidame/app/data/repositories/schedulings_repository.dart';
import 'package:cuidame/app/data/services/user_login_service.dart';

void setupRepositoryInjections() {
  DependencesInjector.registerFactory<SchedulesRepository>(
    () => SchedulesRepositoryImpl(),
  );

  DependencesInjector.registerFactory<CaregiverRepository>(
    () => CaregiverRepositoryImpl(),
  );

  DependencesInjector.registerFactory<FirebaseStorageRepository>(
    () => FirebaseStorageRepositoryImpl(
      DependencesInjector.get<UserLoginService>(),
    ),
  );
}
