import 'package:cuidame/app/data/models/scheduling_day_model.dart';
import 'package:cuidame/app/data/services/local_notification_service.dart';
import 'package:cuidame/app/utils/utils.dart';
import 'package:cuidame/app/utils/utils_datetime.dart';

class SchedulingService {
  final LocalNotificationService _localNotificationService;

  SchedulingService(this._localNotificationService);

  Future scheduleMedication(SchedulingModel scheduling) async {
    final exist = await _localNotificationService.checkSchedulingExist(int.parse(scheduling.id));
    if (!exist) {
      if (scheduling.medicationTime != null) {
        await _localNotificationService.createScheduleNotification(
          int.parse(scheduling.id),
          'Está na hora da medicação',
          '${scheduling.name} - ${scheduling.quantity} ${scheduling.dosage}',
          scheduling.medicationTime!,
        );
        Utils.toast(
          'Agendado ${UtilsDateTime.timeString(scheduling.medicationTime)}',
          '${scheduling.name} - ${scheduling.quantity} ${scheduling.dosage}',
        );
      }
    }
  }

  Future cancelAllSchedules() async {
    await _localNotificationService.cancelAllSchedules();
  }
}
