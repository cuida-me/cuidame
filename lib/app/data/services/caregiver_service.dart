import 'package:cuidame/app/data/models/caregiver/caregiver_model.dart';
import 'package:cuidame/app/data/models/caregiver/caregiver_update_model.dart';
import 'package:cuidame/app/data/models/patient_model.dart';
import 'package:cuidame/app/data/repositories/caregiver_repository.dart';
import 'package:cuidame/app/utils/utils_logger.dart';
import 'package:get/get.dart';

class CaregiverService {
  final CaregiverRepository _caregiverRepository;

  final _caregiver = Rxn<CaregiverModel>();
  final _patient = Rxn<PatientModel>();

  final _loading = false.obs;

  CaregiverService(this._caregiverRepository) {
    init();
  }

  CaregiverModel? get caregiver => _caregiver.value;
  PatientModel? get patient => _patient.value;
  bool get loading => _loading.value;

  void init() async {
    _loading.value = true;
    await getMyProfile();
    _loading.value = false;
  }

  Future getMyProfile() async {
    await _caregiverRepository.retrieveMyProfile().then((value) {
      _caregiver.value = value;
      _patient.value = value.patient;
    }).catchError((err) {
      UtilsLogger().e(err);
    });
  }

  Future updateMyProfile(CaregiverUpdateModel caregiver) async {
    final res = await _caregiverRepository.updateMyProfile(caregiver);
    if (res != null) {
      await getMyProfile();
    }
  }

  void getPatient() {
    _caregiverRepository.retrievePatient().then((value) {
      _patient.value = value;
    }).catchError((err) {
      UtilsLogger().e(err);
    });
  }
}
