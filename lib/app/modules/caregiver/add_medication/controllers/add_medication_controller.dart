import 'package:cuidame/app/configs/constants/toast_type.dart';
import 'package:cuidame/app/data/models/medication/medication_create_model.dart';
import 'package:cuidame/app/data/models/medication/medication_type_model.dart';
import 'package:cuidame/app/data/models/scheduling/schedule_selected_model.dart';
import 'package:cuidame/app/data/models/scheduling_day_model.dart';
import 'package:cuidame/app/data/repositories/firebase_storage_repository.dart';
import 'package:cuidame/app/data/services/caregiver_service.dart';
import 'package:cuidame/app/utils/utils.dart';
import 'package:cuidame/app/utils/utils_logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddMedicationController extends GetxController {
  final CaregiverService _caregiverService;
  final FirebaseStorageRepository _firebaseStorageRepository;

  final _scheduling = Rxn<SchedulingModel>();

  final medicationPhoto = RxnString();
  final medicationName = RxnString();
  final dosage = RxnString();
  final dosageType = RxnInt();
  final timeSchedulers = Rx<List<TimeOfDay>>([]);
  final daysSelected = Rx<List<ScheduleSelectedModel>>(
    [
      ScheduleSelectedModel(dailyOfWeek: 0, enabled: false),
      ScheduleSelectedModel(dailyOfWeek: 1, enabled: false),
      ScheduleSelectedModel(dailyOfWeek: 2, enabled: false),
      ScheduleSelectedModel(dailyOfWeek: 3, enabled: false),
      ScheduleSelectedModel(dailyOfWeek: 4, enabled: false),
      ScheduleSelectedModel(dailyOfWeek: 5, enabled: false),
      ScheduleSelectedModel(dailyOfWeek: 6, enabled: false),
    ],
  );

  final loading = false.obs;
  final loadingMedicationPhoto = false.obs;

  AddMedicationController(this._caregiverService, this._firebaseStorageRepository) {
    _scheduling.value = SchedulingModel.fromJson(Get.arguments['scheduling']);

    medicationPhoto.value = scheduling?.image;
    medicationName.value = scheduling?.name;
    dosage.value = scheduling?.dosage;
    dosageType.value = medicationTypes?.firstWhere((e) => e.name == scheduling?.medicationType).id;
    timeSchedulers.value = [];
  }

  SchedulingModel? get scheduling => _scheduling.value;

  bool get formValidate {
    if (medicationName.value == null ||
        dosage.value == null ||
        dosageType.value == null ||
        loadingMedicationPhoto.value) return false;

    return true;
  }

  List<MedicationTypeModel>? get medicationTypes => _caregiverService.medicationTypes;

  void onChangeDosageType(value) {
    dosageType.value = value;
  }

  void uploadMedicationPhoto(XFile? file) {
    if (file == null) return;
    loadingMedicationPhoto.value = true;
    _firebaseStorageRepository.uploadCaregiverProfilePhoto(file).then((value) {
      medicationPhoto.value = value;
    }).catchError((err) {
      UtilsLogger().e(err);
    }).whenComplete(() => loadingMedicationPhoto.value = false);
  }

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
    var daySelected = daysSelected.value.firstWhereOrNull((e) => e.dailyOfWeek == dayWeek);

    if (daySelected != null) {
      daySelected.enabled = !(daySelected.enabled ?? true);
    }

    daysSelected.refresh();
  }

  bool dayWeekSelected(int dayWeek) {
    var daySelected = daysSelected.value.firstWhereOrNull((e) => e.dailyOfWeek == dayWeek)?.enabled ?? false;
    return daySelected;
  }

  void submit() {
    var schedules = daysSelected.value
        .map((e) => MedicationCreateDailySelectedModel(
              dailyOfWeek: e.dailyOfWeek,
              enabled: e.enabled,
            ))
        .toList();

    var medication = MedicationCreateModel(
      name: medicationName.value,
      typeId: dosageType.value,
      avatar: medicationPhoto.value,
      quantity: int.parse(dosage.value ?? '0'),
      times: timeSchedulers.value.map((e) => '${e.hour}:${e.minute}').toList(),
      schedules: schedules,
    );

    loading.value = true;
    _caregiverService.createMedication(medication).then((value) {
      _caregiverService.retrieveSchedulingWeek();
      Get.back();
      Utils.toast(
        'Criado com sucesso',
        'Medicacão cadastrada com sucesso',
        ToastType.success,
      );
    }).catchError((err) {
      UtilsLogger().e(err);
    }).whenComplete(() => loading.value = false);
  }

  void edit() {
    var schedules = daysSelected.value
        .map((e) => MedicationCreateDailySelectedModel(
              dailyOfWeek: e.dailyOfWeek,
              enabled: e.enabled,
            ))
        .toList();

    var medication = MedicationCreateModel(
      name: medicationName.value,
      typeId: dosageType.value,
      avatar: medicationPhoto.value,
      quantity: int.parse(dosage.value ?? '0'),
      times: timeSchedulers.value.map((e) => '${e.hour}:${e.minute}').toList(),
      schedules: schedules,
    );
  }
}
