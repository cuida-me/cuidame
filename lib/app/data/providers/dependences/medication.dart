import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/modules/caregiver/add_medication/controllers/add_medication_controller.dart';

void setupMedicationInjections() {
  DependencesInjector.registerFactory<AddMedicationController>(
    () => AddMedicationController(),
  );
}
