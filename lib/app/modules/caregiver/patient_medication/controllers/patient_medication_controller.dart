import 'package:cuidame/app/data/models/scheduling_day_model.dart';
import 'package:cuidame/app/data/repositories/schedulings_repository.dart';
import 'package:cuidame/app/data/services/user_login_service.dart';
import 'package:get/get.dart';

class PatientMedicationController extends GetxController {
  // ignore: unused_field
  final UserLoginService _userLoginService;
  final SchedulesRepository _schedulesRepository;

  final loading = false.obs;

  final schedules = Rxn<List<SchedulingDayModel>>();

  final patient = RxnString('');

  PatientMedicationController(
    this._userLoginService,
    this._schedulesRepository,
  ) {
    getSchedules();
  }

  void getSchedules() {
    loading(true);
    _schedulesRepository.retrieveSchedules().then((value) {
      schedules.value = value;
    }).whenComplete(() => loading(false));
  }
}
