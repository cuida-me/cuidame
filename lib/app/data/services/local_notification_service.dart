import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cuidame/app/configs/constants/toast_type.dart';
import 'package:cuidame/app/utils/utils.dart';
import 'package:cuidame/app/utils/utils_notification.dart';

class LocalNotificationService {
  LocalNotificationService() {
    _initialize();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        final allow = await AwesomeNotifications().requestPermissionToSendNotifications(
          channelKey: 'teste',
          permissions: [
            NotificationPermission.Alert,
            NotificationPermission.Sound,
            NotificationPermission.Badge,
            NotificationPermission.Vibration,
            NotificationPermission.Light,
            NotificationPermission.OverrideDnD,
            NotificationPermission.PreciseAlarms,
            NotificationPermission.CriticalAlert,
          ],
        );
        print('Notification is allowed: $allow');
      }
    });
  }

  void _initialize() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: LocalNotificationService.onActionReceivedMethod,
      onNotificationCreatedMethod: LocalNotificationService.onNotificationCreatedMethod,
      onNotificationDisplayedMethod: LocalNotificationService.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: LocalNotificationService.onDismissActionReceivedMethod,
    );
    onNotificationInitialMethod();
  }

  static Future<void> onNotificationInitialMethod() async {
    final receiveAction = await AwesomeNotifications().getInitialNotificationAction();
    if (receiveAction?.channelKey == 'teste') {
      Utils.toast('Notification Initialize', 'body', ToastType.success);
    }
  }

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
    // Your code goes here
    Utils.toast('Notification Created', 'body', ToastType.success);
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
    // Your code goes here
    Utils.toast('Notification Displayed', 'body', ToastType.error);
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
    // Your code goes here
    Utils.toast('Dismiss Action', 'body', ToastType.warning);
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    // Your code goes here
    Utils.toast('Action Received', 'body', ToastType.info);

    // Navigate into pages, avoiding to open the notification details page over another details page already opened
  }

  Future<bool> createNotificationSchedulingMedication(
      int id, String title, String body, DateTime datetimeScheduling) async {
    return await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: UtilsNotification.channelKeySchedulingMedication,
        title: title,
        body: body,
        wakeUpScreen: true,
        category: NotificationCategory.Alarm,
      ),
      schedule: NotificationCalendar.fromDate(
        date: datetimeScheduling,
        allowWhileIdle: true,
        preciseAlarm: true,
      ),
    );
  }
}
