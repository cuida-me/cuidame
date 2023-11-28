import 'package:cuidame/app/data/services/user_login_service.dart';
import 'package:get/get.dart';

class MyProfileController extends GetxController {
  final UserLoginService userLoginService;

  final name = RxnString();
  final dateOfBirth = Rxn<DateTime>();
  final gender = RxnString();

  MyProfileController(this.userLoginService);

  String? get validateName {
    if (name.value == null) 'O nome é obrigatório';

    return null;
  }

  @override
  void onInit() {
    super.onInit();
    name.value = userLoginService.user?.displayName;
  }

  void onChangeGender(value) {

  }

  void signOut() {
    userLoginService.signOut();
  }
}
