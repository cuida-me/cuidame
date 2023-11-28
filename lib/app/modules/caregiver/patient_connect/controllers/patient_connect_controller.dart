import 'package:cuidame/app/configs/constants/toast_type.dart';
import 'package:cuidame/app/utils/utils.dart';
import 'package:get/get.dart';

class PatientConnectController extends GetxController {
  void onReadQRCode(String qrCode) {
    // ignore: avoid_print
    print(qrCode);
    Utils.toast('Lido', qrCode, ToastType.info);
  }
}
