import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/data/repositories/firebase_storage_repository.dart';
import 'package:cuidame/app/data/services/caregiver_service.dart';
import 'package:cuidame/app/modules/caregiver/add_medication/controllers/add_medication_controller.dart';

void setupMedicationInjections() {
  DependencesInjector.registerFactory<AddMedicationController>(
    () => AddMedicationController(
      DependencesInjector.get<CaregiverService>(),
      DependencesInjector.get<FirebaseStorageRepository>(),
    ),
  );
}
