import 'dart:async';

import 'package:cuidame/app/data/models/patient/patient_model.dart';
import 'package:cuidame/app/data/models/scheduling_day_model.dart';
import 'package:cuidame/app/data/models/scheduling_medication_type.dart';
import 'package:cuidame/app/data/repositories/patient_repository.dart';
import 'package:cuidame/app/data/services/scheduling_service.dart';
import 'package:cuidame/app/utils/utils_datetime.dart';
import 'package:cuidame/app/utils/utils_logger.dart';
import 'package:get/get.dart';

class PatientService {
  final PatientRepository _patientRepository;
  final SchedulingService _schedulingService;

  final _user = Rxn<PatientModel>();

  final _schedulingWeek = Rxn<List<SchedulingDayModel>>();
  final _schedule = Rxn<SchedulingDayModel>();
  final _schedulings = Rxn<List<SchedulingModel>>();

  final _minutesAdvance = 15;

  Timer? _schedulingListenTimer;

  final _loading = false.obs;

  PatientService(
    this._patientRepository,
    this._schedulingService,
  );

  PatientModel? get user => _user.value;

  bool get isSchedulings {
    return _schedulings.value?.isNotEmpty ?? false;
  }

  List<SchedulingDayModel>? get schedules => _schedulingWeek.value;
  SchedulingDayModel? get schedule => _schedule.value;
  List<SchedulingModel>? get schedulings => _schedulings.value;

  bool get loading => _loading.value;

  init() async {
    _loading.value = true;
    await Future.wait([
      getMyProfile(),
      retrieveSchedulingWeek(),
    ]);
    _loading.value = false;
  }

  Future getMyProfile() async {
    await _patientRepository.retrieveMyProfile().then((value) {
      _user.value = value;
    }).catchError((err) {
      UtilsLogger().e(err);
    });
  }

  Future retrieveSchedulingWeek() async {
    await _patientRepository.retrieveSchedulingWeek().then((value) async {
      final currentDate = DateTime.now();
      _schedulingWeek.value = value;

      _schedule.value = value.firstWhereOrNull((e) => UtilsDateTime.isSameDay(e.date, currentDate));

      await _schedulingService.cancelAllSchedules();
      _schedule.value?.schedulings?.forEach((e) {
        _schedulingService.scheduleMedication(e);
      });

      _sortSchedulings();
    }).catchError((err) {
      UtilsLogger().e(err);
    });
  }

  void medicationTaken(int dayWeek, int idScheduling) async {
    _schedulings.value?.firstWhere((e) => e.id == idScheduling).medicationTakenTime = DateTime.now();
    _sortSchedulings();

    await _patientRepository.schedulingDone(idScheduling).then((res) {
      if (!res) {
        _schedulings.value?.firstWhere((e) => e.id == idScheduling).medicationTakenTime = null;
        _sortSchedulings();
      }
    });
  }

  void _sortSchedulings() {
    _schedulings.value = _schedule.value?.schedulings?.map((e) {
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
