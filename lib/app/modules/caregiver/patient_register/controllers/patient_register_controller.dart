import 'package:cuidame/app/data/models/patient_model.dart';
import 'package:cuidame/app/data/repositories/caregiver_repository.dart';
import 'package:cuidame/app/data/services/caregiver_service.dart';
import 'package:cuidame/app/router/routes.dart';
import 'package:cuidame/app/utils/utils_logger.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PatientRegisterController extends GetxController {
  final CaregiverRepository _caregiverRepository;
  final CaregiverService _caregiverService;

  PatientRegisterController(this._caregiverRepository, this._caregiverService);

  final loading = false.obs;

  final profilePhoto = Rxn<XFile>();
  final name = RxnString();
  final dateOfBirth = Rxn<DateTime>();
  final gender = RxnInt();

  String? get validateName {
    if (name.value == null) 'O nome é obrigatório';

    return null;
  }

  bool get formValidate {
    if (name.value == null || dateOfBirth.value == null || gender.value == null) return false;

    return true;
  }

  void onChangeGender(value) {
    gender.value = value;
  }

  void submit() {
    final patient = PatientModel(
      name: name.value,
      birthDate: dateOfBirth.value,
      avatar: profilePhoto.value.toString(),
      sex: gender.value,
    );

    loading.value = true;
    _caregiverRepository.createPatient(patient).then((value) {
      if (value) {
        _caregiverService.getPatient();
        Get.toNamed(Routes.patientConnect);
      }
    }).catchError((err) {
      UtilsLogger().e(err);
    }).whenComplete(() => loading.value = false);
  }
}
