import 'package:cuidame/app/utils/utils.dart';
import 'package:get/get.dart';

class PatientReportController extends GetxController {
  void downloadReport() {
    Utils.toast(
      'Gerando Relatório',
      'Estamos trabalhando no seu relatório',
    );
  }
}
