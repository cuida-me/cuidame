import 'dart:async';

import 'package:cuidame/app/configs/constants/toast_type.dart';
import 'package:cuidame/app/data/services/user_login_service.dart';
import 'package:cuidame/app/utils/utils.dart';
import 'package:get/get.dart';

class ConfirmEmailController extends GetxController {
  final UserLoginService _userLoginService;

  final loading = false.obs;

  final timerSendEmail = RxnInt();

  ConfirmEmailController(this._userLoginService) {
    _userLoginService.listenEmailVerify();
  }

  void resendEmail() {
    loading(true);
    _userLoginService.user?.sendEmailVerification().then((_) {
      initTimerSendEmail();
      Utils.toast('Confirme seu e-mail', 'E-mail reenviado com sucesso', ToastType.info);
    }).whenComplete(() {
      loading(false);
    });
  }

  void initTimerSendEmail() {
    timerSendEmail.value = 60;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timer.tick == 60) {
        timerSendEmail.value = null;
        timer.cancel();
      } else {
        timerSendEmail.value = 60 - timer.tick;
      }
    });
  }

  void signOut() {
    _userLoginService.signOut();
  }
}
