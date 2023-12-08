import 'package:cuidame/app/configs/constants/toast_type.dart';
import 'package:cuidame/app/data/models/patient/patient_model.dart';
import 'package:cuidame/app/data/models/patient/patient_update_model.dart';
import 'package:cuidame/app/data/repositories/firebase_storage_repository.dart';
import 'package:cuidame/app/data/services/caregiver_service.dart';
import 'package:cuidame/app/router/routes.dart';
import 'package:cuidame/app/utils/utils.dart';
import 'package:cuidame/app/utils/utils_logger.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PatientProfileController extends GetxController {
  final CaregiverService _caregiverService;
  final FirebaseStorageRepository _firebaseStorageRepository;

  final loadingPatientPhoto = false.obs;
  final loadingSubmit = false.obs;
  final loadingDelete = false.obs;

  final patient = Rxn<PatientModel>();

  PatientProfileController(
    this._caregiverService,
    this._firebaseStorageRepository,
  ) {
    patient.value = _caregiverService.patient;
  }

  String? get validateName {
    if (patient.value?.name == null) 'O nome é obrigatório';

    return null;
  }

  bool get formValidate {
    if (patient.value?.name == null || patient.value?.birthDate == null || patient.value?.sex == null) return false;

    return true;
  }

  void uploadProfilePhoto(XFile? file) {
    if (file == null) return;
    loadingPatientPhoto.value = true;
    _firebaseStorageRepository.uploadPatientProfilePhoto(file).then((value) {
      patient.value?.avatar = value;
    }).catchError((err) {
      UtilsLogger().e(err);
    }).whenComplete(() => loadingPatientPhoto.value = false);
  }

  void onChangeGender(value) {
    patient.value?.sex = value;
  }

  void submit() {
    if (loadingSubmit.value) return;
    var patientUpdate = PatientUpdateModel(
      avatar: patient.value?.avatar,
      name: patient.value?.name,
      birthDate: patient.value?.birthDate,
      sex: patient.value?.sex,
    );
    loadingSubmit.value = true;
    _caregiverService.updatePatient(patientUpdate).then((value) {
      Utils.toast(
        'Dados salvo com sucesso',
        'Paciente atualizado',
        ToastType.success,
      );
    }).catchError((err) {
      UtilsLogger().e(err);
    }).whenComplete(() => loadingSubmit.value = false);
  }

  void deletePatient() {
    loadingDelete.value = true;
    _caregiverService.deletePatient().then((value) {
      Utils.toast(
        'Deletado com sucesso',
        'Paciente deletado',
        ToastType.success,
      );
      Get.offAllNamed(Routes.navigation);
    }).catchError((err) {
      UtilsLogger().e(err);
    }).whenComplete(() => loadingDelete.value = false);
  }

  void linkPatientDevice() {
    Get.toNamed(Routes.patientConnect);
  }
}
