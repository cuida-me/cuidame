import 'package:cuidame/app/configs/constants/toast_type.dart';
import 'package:cuidame/app/data/models/caregiver/caregiver_update_model.dart';
import 'package:cuidame/app/data/services/caregiver_service.dart';
import 'package:cuidame/app/data/services/user_login_service.dart';
import 'package:cuidame/app/utils/utils.dart';
import 'package:cuidame/app/utils/utils_logger.dart';
import 'package:get/get.dart';

class MyProfileController extends GetxController {
  final UserLoginService _userLoginService;
  final CaregiverService _caregiverService;

  final avatar = RxnString();
  final name = RxnString();
  final dateOfBirth = Rxn<DateTime>();
  final gender = RxnInt();

  final loading = false.obs;

  MyProfileController(this._userLoginService, this._caregiverService);

  String? get validateName {
    if (name.value == null) 'O nome é obrigatório';

    return null;
  }

  bool get formValidate {
    if (name.value == null) return false;
    return true;
  }

  @override
  void onInit() {
    super.onInit();
    initForm();
  }

  void initForm() {
    final caregiver = _caregiverService.caregiver;
    name.value = caregiver?.name;
    dateOfBirth.value = caregiver?.birthDate;
    gender.value = caregiver?.sex;
  }

  void onChangeGender(value) {
    gender.value = value;
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
    _userLoginService.signOut();
  }
}
