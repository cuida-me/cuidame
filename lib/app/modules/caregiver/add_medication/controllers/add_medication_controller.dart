import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMedicationController extends GetxController {
  final medicationName = RxnString();
  final dosage = RxnInt();
  final dosageType = RxnString();
  final timeSchedulers = Rx<List<TimeOfDay>>([]);
  final daysSelected = Rx<List<int>>([]);

  bool get formValidate {
    if (medicationName.value == null || dosage.value == null || dosageType.value == null) return false;

    return true;
  }

  void onChangeDosageType(value) {}

  void addTimeScheduler(TimeOfDay? time) {
    if (time != null) {
      timeSchedulers.value.add(time);
      timeSchedulers.refresh();
    }
  }

  void removeTimeScheduler(TimeOfDay time) {
    timeSchedulers.value.remove(time);
    timeSchedulers.refresh();
  }

  void selectDayWeek(int dayWeek) {
    int? daySelected = daysSelected.value.firstWhereOrNull((dayWeekSelected) => dayWeek == dayWeekSelected);

    if (daySelected == null) {
      daysSelected.value.add(dayWeek);
    } else {
      daysSelected.value.remove(dayWeek);
    }
    daysSelected.refresh();
  }

  bool dayWeekSelected(int dayWeek) {
    int? daySelected = daysSelected.value.firstWhereOrNull((dayWeekSelected) => dayWeek == dayWeekSelected);
    return daySelected != null;
  }
}
