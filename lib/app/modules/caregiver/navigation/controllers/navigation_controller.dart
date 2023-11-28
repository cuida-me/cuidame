import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final selectIndex = 0.obs;

  final patient = RxnString('');

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: selectIndex.value,
    );
  }

  bool get existPatient => patient.value != null;

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
