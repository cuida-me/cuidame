import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';

class StartController extends GetxController {
  Future<void> initUniLinks() async {
    try {
      final initialUri = await getInitialUri();
      print(initialUri);
    } on FormatException catch (e) {
      print('**App Link Error: ${e.message}');
    }
  }
}
