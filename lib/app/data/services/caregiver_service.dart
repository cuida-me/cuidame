import 'package:cuidame/app/data/models/caregiver/caregiver_model.dart';
import 'package:cuidame/app/data/models/caregiver/caregiver_update_model.dart';
import 'package:cuidame/app/data/models/medication/medication_create_model.dart';
import 'package:cuidame/app/data/models/medication/medication_type_model.dart';
import 'package:cuidame/app/data/models/patient/patient_model.dart';
import 'package:cuidame/app/data/models/patient/patient_update_model.dart';
import 'package:cuidame/app/data/models/scheduling_day_model.dart';
import 'package:cuidame/app/data/repositories/caregiver_repository.dart';
import 'package:cuidame/app/utils/utils_logger.dart';
import 'package:get/get.dart';

class CaregiverService {
  final CaregiverRepository _caregiverRepository;

  final _caregiver = Rxn<CaregiverModel>();
  final _patient = Rxn<PatientModel>();
  final _medicationTypes = Rxn<List<MedicationTypeModel>>();
  final _schedulingWeek = Rxn<List<SchedulingDayModel>>();

  final _loading = false.obs;

  CaregiverService(
    this._caregiverRepository,
  );

  CaregiverModel? get caregiver => _caregiver.value;
  PatientModel? get patient => _patient.value;
  bool get loading => _loading.value;
  List<MedicationTypeModel>? get medicationTypes => _medicationTypes.value;
  List<SchedulingDayModel>? get schedulingWeek => _schedulingWeek.value;

  init() async {
    _loading.value = true;
    await Future.wait([
      getMyProfile(),
      retrieveMedicationTypes(),
      retrieveSchedulingWeek(),
    ]);
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

  Future deleteMyAccount() async {
    final res = await _caregiverRepository.deleteMyAccount();
    if (res) {
      // _caregiverLoginService.signOut();
    }
  }

  Future getPatient() async {
    _caregiverRepository.retrievePatient().then((value) {
      _patient.value = value;
    }).catchError((err) {
      UtilsLogger().e(err);
    });
  }

  Future updatePatient(PatientUpdateModel patient) async {
    await _caregiverRepository.updatePatient(patient);
  }

  Future deletePatient() async {
    await _caregiverRepository.deletePatient().then((value) {
      _patient.value = null;
    });
  }

  Future linkPatientDevice(String token) async {
    await _caregiverRepository.linkPatientDevice(token);
  }

  Future retrieveMedicationTypes() async {
    _medicationTypes.value = await _caregiverRepository.retrieveMedicationTypes();
  }

  Future retrieveSchedulingWeek() async {
    await _caregiverRepository.retrieveSchedulingWeek().then((value) {
      _schedulingWeek.value = value;
    }).catchError((err) {
      UtilsLogger().e(err);
    });
  }

  Future createMedication(MedicationCreateModel medication) async {
    await _caregiverRepository.createMedication(medication);
  }

  Future<bool> patientLinkToDevice(String token) async {
    return await _caregiverRepository.linkPatientDevice(token);
  }
}
