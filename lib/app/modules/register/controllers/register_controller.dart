import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterController extends GetxController {
  final loading = false.obs;

  final titleBar = 'Tela inicial'.obs;

  final name = RxnString();
  final email = RxnString();

  final password = RxnString();
  final rePassword = RxnString();

  final choosePassword = false.obs;
  final emailExist = false.obs;

  bool get formValidateEmail {
    if (name.value == null || email.value == null || validateEmail != null) return false;

    return true;
  }

  String? get validateEmail {
    if (email.value != null && !GetUtils.isEmail(email.value!)) {
      return 'E-mail inválido';
    }
    if (email.value != null && emailExist.value) {
      return 'E-mail já cadastrado';
    }
    return null;
  }

  bool get formValidatePassword {
    if (password.value == null || rePassword.value == null || password.value != rePassword.value) return false;

    return true;
  }

  String? get validatePassword {
    if (password.value != null && password.value!.length < 8) {
      return 'Senha muito curta';
    }
    return null;
  }

  String? get validateRePassword {
    if (rePassword.value != null && password.value != rePassword.value) {
      return 'As senhas são diferentes';
    }
    return null;
  }

  void backToEmail() {
    if (choosePassword.value) {
      choosePassword.value = false;
    } else {
      Get.back();
    }
  }

  void resetFormPassword() {
    password.value = null;
    rePassword.value = null;
  }

  void submitFirstStep() {
    choosePassword(true);
    titleBar('Voltar');
  }

  void submitSecondStep() {
    loading(true);
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email.value!, password: password.value!)
        .then((credential) {
      credential.user?.updateDisplayName(name.value);
      credential.user?.sendEmailVerification().then((_) {});
    }).catchError((err) {
      if (err.code == 'email-already-in-use') {
        emailExist.value = true;
        choosePassword.value = false;
        resetFormPassword();
      }
    }).whenComplete(() => loading(false));
  }
}
