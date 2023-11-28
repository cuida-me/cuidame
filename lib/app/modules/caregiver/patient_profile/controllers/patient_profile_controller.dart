import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PatientProfileController extends GetxController {
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

  void submit() {}
}
