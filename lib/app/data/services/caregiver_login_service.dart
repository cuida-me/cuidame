import 'dart:async';

import 'package:cuidame/app/data/services/caregiver_service.dart';
import 'package:cuidame/app/router/routes.dart';
import 'package:cuidame/app/utils/utils_logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class CaregiverLoginService {
  // ignore: unused_field
  final CaregiverService _caregiverService;

  final _userFirebase = Rxn<User>();

  CaregiverLoginService(this._caregiverService) {
    loadUserLogin();
  }

  User? get user => _userFirebase.value;

  String get userUid => _userFirebase.value?.uid ?? '';

  bool get isAuthenticated => _userFirebase.value != null;

  Future<String?> get userToken async => await _userFirebase.value?.getIdToken();

  loadUserLogin() {
    FirebaseAuth.instance.authStateChanges().listen((value) async {
      _userFirebase.value = value;

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
      if (_userFirebase.value == null) {
        timer.cancel();
      }
      await _userFirebase.value?.reload();
      final user = FirebaseAuth.instance.currentUser;

      if (user != null && user.emailVerified) {
        timer.cancel();
        _userFirebase.value = user;
        Get.offAllNamed(Routes.navigation);
      }
    });
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
