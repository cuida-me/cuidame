import 'package:cuidame/app/configs/constants/toast_type.dart';
import 'package:cuidame/app/data/models/caregiver/caregiver_update_model.dart';
import 'package:cuidame/app/data/repositories/firebase_storage_repository.dart';
import 'package:cuidame/app/data/services/caregiver_login_service.dart';
import 'package:cuidame/app/data/services/caregiver_service.dart';
import 'package:cuidame/app/utils/utils.dart';
import 'package:cuidame/app/utils/utils_logger.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MyProfileController extends GetxController {
  final CaregiverLoginService _caregiverLoginService;
  final CaregiverService _caregiverService;
  final FirebaseStorageRepository _firebaseStorageRepository;

  final avatar = RxnString();
  final name = RxnString();
  final dateOfBirth = Rxn<DateTime>();
  final gender = RxnInt();

  final loadingProfilePhoto = false.obs;
  final loading = false.obs;

  MyProfileController(
    this._caregiverLoginService,
    this._caregiverService,
    this._firebaseStorageRepository,
  );

  String? get validateName {
    if (name.value == null) 'O nome é obrigatório';

    return null;
  }

  bool get formValidate {
    if (name.value == null || loadingProfilePhoto.value) return false;
    return true;
  }

  @override
  void onInit() {
    super.onInit();
    initForm();
  }

  void initForm() {
    final caregiver = _caregiverService.caregiver;
    avatar.value = caregiver?.avatar;
    name.value = caregiver?.name;
    dateOfBirth.value = caregiver?.birthDate;
    gender.value = caregiver?.sex;
  }

  void onChangeDate(value) {
    dateOfBirth.value = value;
  }

  void onChangeGender(value) {
    gender.value = value;
  }

  void uploadProfilePhoto(XFile? file) {
    if (file == null) return;
    loadingProfilePhoto.value = true;
    _firebaseStorageRepository.uploadCaregiverProfilePhoto(file).then((value) {
      avatar.value = value;
    }).catchError((err) {
      UtilsLogger().e(err);
    }).whenComplete(() => loadingProfilePhoto.value = false);
  }

  void submit() {
    final caregiverUpdate = CaregiverUpdateModel(
      avatar: avatar.value,
      name: name.value,
      birthDate: dateOfBirth.value,
      sex: gender.value,
    );

    loading.value = true;
    _caregiverService.updateMyProfile(caregiverUpdate).then((value) {
      _caregiverService.getMyProfile();
      Utils.toast(
        'Salvado com sucesso',
        'Seus dados foram alterados',
        ToastType.success,
      );
    }).catchError((err) {
      UtilsLogger().e(err);
    }).whenComplete(() => loading.value = false);
  }

  void signOut() {
    _caregiverLoginService.signOut();
  }
}
