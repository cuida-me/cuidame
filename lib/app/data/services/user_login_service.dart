import 'dart:async';

import 'package:cuidame/app/router/routes.dart';
import 'package:cuidame/app/utils/utils_logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class UserLoginService {
  final _user = Rxn<User>();

  UserLoginService() {
    initAuthListen();
  }

  initAuthListen() {
    FirebaseAuth.instance.authStateChanges().listen((value) async {
      _user.value = value;

      if (value != null) {
        var token = await value.getIdToken();

        if (kDebugMode) UtilsLogger().i('User Token: $token');

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
      if (_user.value == null) {
        timer.cancel();
      }
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

  Future<String?> get userToken async => await _user.value?.getIdToken();

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
