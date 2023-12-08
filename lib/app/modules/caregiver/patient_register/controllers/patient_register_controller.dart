import 'package:cuidame/app/configs/constants/toast_type.dart';
import 'package:cuidame/app/data/models/patient/patient_model.dart';
import 'package:cuidame/app/data/repositories/caregiver_repository.dart';
import 'package:cuidame/app/data/repositories/firebase_storage_repository.dart';
import 'package:cuidame/app/data/services/caregiver_service.dart';
import 'package:cuidame/app/router/routes.dart';
import 'package:cuidame/app/utils/utils.dart';
import 'package:cuidame/app/utils/utils_logger.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PatientRegisterController extends GetxController {
  final CaregiverRepository _caregiverRepository;
  final CaregiverService _caregiverService;
  final FirebaseStorageRepository _firebaseStorageRepository;

  PatientRegisterController(
    this._caregiverRepository,
    this._caregiverService,
    this._firebaseStorageRepository,
  );

  final loadingPatientPhoto = false.obs;
  final loading = false.obs;

  final patientPhoto = RxnString();
  final name = RxnString();
  final dateOfBirth = Rxn<DateTime>();
  final gender = RxnInt();

  String? get validateName {
    if (name.value == null) 'O nome é obrigatório';

    return null;
  }

  bool get formValidate {
    if (name.value == null || dateOfBirth.value == null || gender.value == null || loadingPatientPhoto.value) {
      return false;
    }

    return true;
  }

  void onChangeGender(value) {
    gender.value = value;
  }

  void uploadProfilePhoto(XFile? file) {
    if (file == null) return;
    loadingPatientPhoto.value = true;
    _firebaseStorageRepository.uploadPatientProfilePhoto(file).then((value) {
      patientPhoto.value = value;
    }).catchError((err) {
      UtilsLogger().e(err);
    }).whenComplete(() => loadingPatientPhoto.value = false);
  }

  void submit() {
    final patient = PatientModel(
      name: name.value,
      birthDate: dateOfBirth.value,
      avatar: patientPhoto.value,
      sex: gender.value,
    );

    loading.value = true;
    _caregiverRepository.createPatient(patient).then((value) {
      if (value) {
        _caregiverService.getPatient();
        Get.offAndToNamed(Routes.patientConnect);
        Utils.toast(
          'Paciente criado com sucesso',
          'Agora vamos conectar',
          ToastType.error,
        );
      }
    }).catchError((err) {
      UtilsLogger().e(err);
    }).whenComplete(() => loading.value = false);
  }
}
