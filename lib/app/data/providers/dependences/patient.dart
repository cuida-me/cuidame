import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/data/repositories/schedulings_repository.dart';
import 'package:cuidame/app/data/services/scheduling_service.dart';
import 'package:cuidame/app/modules/patient/patient_qr_code/controllers/patient_qr_code_controller.dart';
import 'package:cuidame/app/modules/patient/patient_schedulings/controllers/patient_schedulings_controller.dart';

void setupPatientInjections() {
  DependencesInjector.registerFactory<PatientQrCodeController>(
    () => PatientQrCodeController(),
  );

  DependencesInjector.registerFactory<PatientSchedulingsController>(
    () => PatientSchedulingsController(
      DependencesInjector.get<SchedulesRepository>(),
      DependencesInjector.get<SchedulingService>(),
    ),
  );
}
