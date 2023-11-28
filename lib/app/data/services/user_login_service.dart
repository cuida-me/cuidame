import 'dart:async';

import 'package:cuidame/app/router/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserLoginService {
  final _user = Rxn<User>();

  UserLoginService() {
    initAuthListen();
  }

  initAuthListen() {
    FirebaseAuth.instance.authStateChanges().listen((value) {
      _user.value = value;

      if (value != null) {
        if (value.emailVerified) {
          Get.offAllNamed(Routes.navigation);
        } else {
          Get.offAllNamed(Routes.confirmEmail);
        }
      } else {
        Get.offAllNamed(Routes.start);
      }
    });
  }

  listenEmailVerify() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await _user.value?.reload();
      final user = FirebaseAuth.instance.currentUser;

      if (user != null && user.emailVerified) {
        timer.cancel();
        _user.value = user;
        Get.offAllNamed(Routes.navigation);
      }
    });
  }

  User? get user => _user.value;

  bool get isAuthenticated => _user.value != null;

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
