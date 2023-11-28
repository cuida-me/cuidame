import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final loading = false.obs;

  final email = RxnString();
  final password = RxnString();

  final signInEmail = false.obs;

  bool get formValidateSignIn {
    if (email.value == null || password.value == null || validateEmail != null || validatePassword != null) {
      return false;
    }

    return true;
  }

  String? get validateEmail {
    if (email.value != null && !GetUtils.isEmail(email.value!)) {
      return 'E-mail inválido';
    }
    return null;
  }

  String? get validatePassword {
    if (password.value != null && password.value!.length < 8) {
      return 'Senha muito curta';
    }
    return null;
  }

  void submit() {
    loading(true);
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: email.value!,
          password: password.value!,
        )
        .then((value) {})
        .catchError((err) {
      print(err);
    }).whenComplete(() => loading(false));
  }
}
