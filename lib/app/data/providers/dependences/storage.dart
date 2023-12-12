import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/data/storage/patient_token_storage.dart';

void setupStorageInjections() {
  DependencesInjector.registerFactory<PatientTokenStorage>(
    () => PatientTokenStorageImpl(),
  );
}
