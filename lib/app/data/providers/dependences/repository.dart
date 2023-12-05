import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/data/providers/http/http_client.dart';
import 'package:cuidame/app/data/repositories/caregiver_repository.dart';
import 'package:cuidame/app/data/repositories/schedulings_repository.dart';

void setupRepositoryInjections() {
  DependencesInjector.registerFactory<SchedulesRepository>(
    () => SchedulesRepositoryImpl(
      DependencesInjector.get<HttpClient>(),
    ),
  );

  DependencesInjector.registerFactory<CaregiverRepository>(
    () => CaregiverRepositoryImpl(
      DependencesInjector.get<HttpClient>(),
    ),
  );
}
