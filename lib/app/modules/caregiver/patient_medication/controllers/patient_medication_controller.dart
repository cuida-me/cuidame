import 'package:cuidame/app/data/models/patient_model.dart';
import 'package:cuidame/app/data/models/scheduling_day_model.dart';
import 'package:cuidame/app/data/repositories/schedulings_repository.dart';
import 'package:cuidame/app/data/services/caregiver_service.dart';
import 'package:cuidame/app/data/services/user_login_service.dart';
import 'package:get/get.dart';

class PatientMedicationController extends GetxController {
  // ignore: unused_field
  final UserLoginService _userLoginService;
  final CaregiverService _caregiverService;
  final SchedulesRepository _schedulesRepository;

  final loading = false.obs;

  final schedules = Rxn<List<SchedulingDayModel>>();

  PatientMedicationController(
    this._userLoginService,
    this._caregiverService,
    this._schedulesRepository,
  );

  @override
  void onInit() {
    super.onInit();
    getSchedules();
  }

  PatientModel? get patient => _caregiverService.patient;
  bool get existPatient => patient != null;

  void getSchedules() {
    loading(true);
    _schedulesRepository.retrieveSchedules().then((value) {
      schedules.value = value;
    }).whenComplete(() => loading(false));
  }
}
