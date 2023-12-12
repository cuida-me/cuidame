import 'dart:async';

import 'package:cuidame/app/data/models/scheduling_day_model.dart';
import 'package:cuidame/app/data/models/scheduling_medication_type.dart';
import 'package:cuidame/app/data/repositories/schedulings_repository.dart';
import 'package:cuidame/app/data/services/patient_service.dart';
import 'package:cuidame/app/data/services/scheduling_service.dart';
import 'package:cuidame/app/utils/utils_datetime.dart';
import 'package:cuidame/app/utils/utils_logger.dart';
import 'package:get/get.dart';

class PatientSchedulingsController extends GetxController {
  final SchedulesRepository _schedulesRepository;
  final SchedulingService _schedulingService;
  final PatientService _patientService;

  final loading = false.obs;

  final _minutesAdvance = 15;

  final schedules = Rxn<List<SchedulingDayModel>>();
  final schedule = Rxn<SchedulingDayModel>();
  final schedulings = Rxn<List<SchedulingModel>>();

  Timer? _schedulingListenTimer;

  PatientSchedulingsController(
    this._schedulesRepository,
    this._schedulingService,
    this._patientService,
  ) {
    getSchedules();
  }

  bool get isSchedulings {
    return schedulings.value?.isNotEmpty ?? false;
  }

  void getSchedules() {
    loading(true);
    _schedulesRepository.retrieveSchedules().then((value) async {
      final currentDate = DateTime.now();
      schedules.value = value;

      if (value != null) {
        schedule.value = value.firstWhereOrNull((e) => UtilsDateTime.isSameDay(e.date, currentDate));

        await _schedulingService.cancelAllSchedules();
        schedule.value?.schedulings?.forEach((e) {
          _schedulingService.scheduleMedication(e);
        });

        _sortSchedulings();
      }
    }).catchError((err) {
      UtilsLogger().w(err);
    }).whenComplete(() => loading(false));
  }

  void medicationTaken(int dayWeek, int idScheduling) {
    schedulings.value?.firstWhere((e) => e.id == idScheduling).medicationTakenTime = DateTime.now();
    _sortSchedulings();
  }

  SchedulingModel? getScheduling(int dayWeek, String idScheduling) {
    final scheduling = schedules.value?.firstWhere((e) => e.dayWeek == dayWeek).schedulings?.firstWhere(
          (e) => e.id == int.parse(idScheduling),
        );
    return scheduling;
  }

  List<SchedulingModel>? get schedulingsInTimeAndTaken {
    return [
      ...schedulings.value?.where((e) => e.type == SchedulingMedicationType.inTime).toList() ?? [],
      ...schedulings.value?.where((e) => e.type == SchedulingMedicationType.taken).toList() ?? [],
    ];
  }

  List<SchedulingModel>? get schedulingsCloseToTime {
    return schedulings.value?.where((e) => e.type == SchedulingMedicationType.closeToTime).toList();
  }

  List<SchedulingModel>? get schedulingsDelayed {
    return schedulings.value?.where((e) => e.type == SchedulingMedicationType.delayed).toList();
  }

  void _sortSchedulings() {
    schedulings.value = schedule.value?.schedulings?.map((e) {
      if (e.medicationTakenTime != null) {
        e.type = SchedulingMedicationType.taken;
      } else if (_isSchedulingInTime(e.medicationTime)) {
        e.type = SchedulingMedicationType.inTime;
      } else if (_isSchedulingCloseToTime(e.medicationTime, _minutesAdvance)) {
        e.type = SchedulingMedicationType.closeToTime;
      } else if (_isSchedulingDelayed(e.medicationTime)) {
        e.type = SchedulingMedicationType.delayed;
      }
      return e;
    }).toList();
    _schedulingListenTimer?.cancel();
    _schedulingsListen();
  }

  void _schedulingsListen() {
    _schedulingListenTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _sortSchedulings();
    });
  }

  bool _isSchedulingInTime(DateTime? date) {
    if (date == null) return false;
    return !_isSchedulingCloseToTime(date, _minutesAdvance) && !_isSchedulingDelayed(date);
  }

  bool _isSchedulingCloseToTime(DateTime? date, int minutesAdvanced) {
    if (date == null) return false;
    final datePast = date.add(Duration(minutes: -minutesAdvanced));
    final currentDate = DateTime.now();
    if (datePast.isBefore(currentDate) && date.isAfter(currentDate) && date.weekday == currentDate.weekday) {
      return true;
    }
    return false;
  }

  bool _isSchedulingDelayed(DateTime? date) {
    if (date == null) return false;
    final currentDate = DateTime.now();

    if (currentDate.isAfter(date) && date.weekday == currentDate.weekday) {
      return true;
    }
    return false;
  }
}
