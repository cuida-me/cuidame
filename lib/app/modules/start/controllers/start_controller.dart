// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:cuidame/app/data/repositories/caregiver_repository.dart';
import 'package:cuidame/app/utils/utils_logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';
import 'package:google_sign_in/google_sign_in.dart';

class StartController extends GetxController {
  final CaregiverRepository _caregiverRepository;

  final loadingSignInGoogle = false.obs;

  StartController(this._caregiverRepository);

  Future<void> initUniLinks() async {
    try {
      final initialUri = await getInitialUri();
      print(initialUri);
    } on FormatException catch (e) {
      print('**App Link Error: ${e.message}');
    }
  }

  void signInGoogle() async {
    if (loadingSignInGoogle.value) return;
    loadingSignInGoogle(true);

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn().whenComplete(
          () => loadingSignInGoogle(false),
        );

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    FirebaseAuth.instance.signInWithCredential(credential).then((credential) async {
      
      await _caregiverRepository.registerCaregiver();
    }).catchError((err) {
      UtilsLogger().e(err);
    }).whenComplete(
      () => loadingSignInGoogle(false),
    );
  }
}
