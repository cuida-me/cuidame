import 'package:cuidame/app/data/models/patient/patient_model.dart';
import 'package:cuidame/app/data/services/caregiver_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController with GetSingleTickerProviderStateMixin {
  final CaregiverService _caregiverService;

  NavigationController(this._caregiverService) {
    _caregiverService.init();
  }

  late TabController tabController;

  final selectIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: selectIndex.value,
    );
  }

  PatientModel? get patient => _caregiverService.patient;
  bool get existPatient => patient != null;
  bool get loading => _caregiverService.loading;

  String get subTitle {
    switch (selectIndex.value) {
      case 0:
        return 'Acompanhe o plano do seu paciente!';
      case 1:
        return 'Gere um relatório com o histórico do \nseu paciente';
      case 2:
        return 'Veja as informações do seu paciente';
      default:
        return '';
    }
  }

  void onItemTapped(int index) {
    selectIndex.value = index;
    tabController.animateTo(index);
  }
}
