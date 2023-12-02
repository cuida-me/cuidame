import 'dart:async';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/data/models/scheduling_medication_type.dart';
import 'package:cuidame/app/data/models/scheduling_day_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicationCardController extends GetxController {
  final _scheduling = Rxn<SchedulingModel>();

  final schedulingAlertType = Rx<SchedulingMedicationType>(SchedulingMedicationType.inTime);
  final bgColor = Rx<Color>(AppColors.tertiary);
  final textColor = Rx<Color>(AppColors.black);

  MedicationCardController(SchedulingModel? scheduling) {
    _scheduling.value = scheduling;
    _defineScheduleType();
    _defineBgColor();
  }

  bool get medicationTaken => _scheduling.value?.medicationTakenTime != null;
  bool get cardMedicatonCollapse => schedulingAlertType.value == SchedulingMedicationType.inTime || medicationTaken;

  void _defineScheduleType() {
    DateTime? medicationTime;

    switch (schedulingAlertType.value) {
      case SchedulingMedicationType.inTime:
        medicationTime = _scheduling.value?.medicationTime?.add(const Duration(minutes: -15));
      case SchedulingMedicationType.closeToTime:
        medicationTime = _scheduling.value?.medicationTime;
      default:
        medicationTime = _scheduling.value?.medicationTime;
        break;
    }

    final currentTime = DateTime.now();
    final durationNextStep = medicationTime?.difference(currentTime);

    if (medicationTime != null && durationNextStep != null && medicationTime.weekday == currentTime.weekday) {
      Timer(durationNextStep, () {
        switch (schedulingAlertType.value) {
          case SchedulingMedicationType.inTime:
            schedulingAlertType.value = SchedulingMedicationType.closeToTime;
          case SchedulingMedicationType.closeToTime:
            schedulingAlertType.value = SchedulingMedicationType.delayed;
          default:
            break;
        }
        _defineBgColor();
        if (schedulingAlertType.value != SchedulingMedicationType.delayed) _defineScheduleType();
      });
    }
  }

  void _defineBgColor() {
    if (medicationTaken) {
      bgColor(AppColors.success);
      textColor(AppColors.light);
      return;
    }
    switch (schedulingAlertType.value) {
      case SchedulingMedicationType.closeToTime:
        bgColor(AppColors.darkOrange);
        textColor(AppColors.black);
        break;
      case SchedulingMedicationType.delayed:
        bgColor(AppColors.pastelRed);
        textColor(AppColors.light);
        break;
      case SchedulingMedicationType.inTime:
        bgColor(AppColors.tertiary);
        textColor(AppColors.black);
        break;
      default:
        bgColor(AppColors.tertiary);
        textColor(AppColors.black);
        break;
    }
  }
}
