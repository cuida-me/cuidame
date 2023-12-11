import 'package:cuidame/app/data/models/patient/patient_model.dart';
import 'package:cuidame/app/data/models/scheduling_day_model.dart';
import 'package:cuidame/app/data/services/caregiver_login_service.dart';
import 'package:cuidame/app/data/services/caregiver_service.dart';
import 'package:cuidame/app/utils/utils_datetime.dart';
import 'package:get/get.dart';

class PatientMedicationController extends GetxController {
  // ignore: unused_field
  final CaregiverLoginService _caregiverLoginService;
  final CaregiverService _caregiverService;

  final loading = false.obs;

  PatientMedicationController(
    this._caregiverLoginService,
    this._caregiverService,
  );

  PatientModel? get patient => _caregiverService.patient;
  bool get existPatient => patient != null;
  List<SchedulingDayModel>? get schedulingWeek => _caregiverService.schedulingWeek;
  SchedulingDayModel? get schedulingToday {
    final today = DateTime.now();
    return schedulingWeek?.firstWhereOrNull((e) => UtilsDateTime.isSameDay(e.date, today));
  }
}
