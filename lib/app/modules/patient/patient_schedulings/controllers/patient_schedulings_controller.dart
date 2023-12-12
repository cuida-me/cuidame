import 'package:cuidame/app/data/models/scheduling_day_model.dart';
import 'package:cuidame/app/data/models/scheduling_medication_type.dart';
import 'package:cuidame/app/data/services/patient_service.dart';
import 'package:get/get.dart';

class PatientSchedulingsController extends GetxController {
  final PatientService _patientService;

  PatientSchedulingsController(
    this._patientService,
  ) {
    _patientService.init();
  }

  List<SchedulingDayModel>? get schedules => _patientService.schedules;
  SchedulingDayModel? get schedule => _patientService.schedule;

  bool get loading => _patientService.loading;

  bool get isSchedulings => _patientService.isSchedulings;

  void medicationTaken(int dayWeek, int idScheduling) async {
    _patientService.medicationTaken(dayWeek, idScheduling);
  }

  // SchedulingModel? getScheduling(int dayWeek, String idScheduling) {
  //   final scheduling = schedules.value?.firstWhere((e) => e.dayWeek == dayWeek).schedulings?.firstWhere(
  //         (e) => e.id == int.parse(idScheduling),
  //       );
  //   return scheduling;
  // }

  List<SchedulingModel>? get schedulingsInTimeAndTaken {
    return [
      ..._patientService.schedulings?.where((e) => e.type == SchedulingMedicationType.inTime).toList() ?? [],
      ..._patientService.schedulings?.where((e) => e.type == SchedulingMedicationType.taken).toList() ?? [],
    ];
  }

  List<SchedulingModel>? get schedulingsCloseToTime {
    return _patientService.schedulings?.where((e) => e.type == SchedulingMedicationType.closeToTime).toList();
  }

  List<SchedulingModel>? get schedulingsDelayed {
    return _patientService.schedulings?.where((e) => e.type == SchedulingMedicationType.delayed).toList();
  }
}
