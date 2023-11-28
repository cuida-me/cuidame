import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final loading = false.obs;

  final email = RxnString();
  final reEmail = RxnString();

  final sendEmail = false.obs;

  String? get validateEmail {
    if (email.value != null && !GetUtils.isEmail(email.value!)) {
      return 'E-mail inválido';
    }
    return null;
  }

  String? get validateReEmail {
    if (reEmail.value != null && !GetUtils.isEmail(reEmail.value!)) {
      return 'Os e-mails precisam ser iguais';
    }
    return null;
  }

  bool get formValidateForgotPassword {
    if (email.value == null || reEmail.value == null || validateEmail != null || validateReEmail != null) return false;

    return true;
  }

  void submit() {
    loading(true);
    FirebaseAuth.instance
        .sendPasswordResetEmail(
      email: email.value!,
    )
        .then((_) {
      sendEmail.value = true;
    }).whenComplete(() => loading(false));
  }
}
