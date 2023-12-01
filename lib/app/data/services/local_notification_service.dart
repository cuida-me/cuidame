import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cuidame/app/configs/constants/toast_type.dart';
import 'package:cuidame/app/router/routes.dart';
import 'package:cuidame/app/utils/utils.dart';
import 'package:cuidame/app/utils/utils_notification.dart';
import 'package:get/route_manager.dart';
import 'package:permission_handler/permission_handler.dart';

class LocalNotificationService {
  final _notificationPermissionList = <NotificationPermission>[
    NotificationPermission.Alert,
    NotificationPermission.Sound,
    NotificationPermission.Badge,
    NotificationPermission.Vibration,
    NotificationPermission.Light,
    NotificationPermission.OverrideDnD,
    NotificationPermission.PreciseAlarms,
    NotificationPermission.CriticalAlert,
    NotificationPermission.Car,
    NotificationPermission.FullScreenIntent,
  ];

  late PermissionStatus _statusNotificationPermission;
  late PermissionStatus _statusNotificationPolicyPermission;

  LocalNotificationService() {
    checkPermission();
  }

  PermissionStatus get statusNotificationPermission => _statusNotificationPermission;
  PermissionStatus get statusNotificationPolicyPermission => _statusNotificationPolicyPermission;

  Future checkPermission() async {
    _statusNotificationPermission = await Permission.notification.request();

    if (_statusNotificationPermission.isDenied || _statusNotificationPermission.isPermanentlyDenied) {
      Get.toNamed(Routes.notificationPermission);
    }

    _statusNotificationPolicyPermission = await Permission.accessNotificationPolicy.status;

    if (_statusNotificationPolicyPermission.isDenied || _statusNotificationPolicyPermission.isPermanentlyDenied) {
      Get.toNamed(Routes.notificationPolicyPermission);
    }

    _initializeNotifications();
  }

  Future<void> openSettings() async {
    openAppSettings();
  }

  Future<void> openDoNotDisturbSettings() async {
    _statusNotificationPolicyPermission = await Permission.accessNotificationPolicy.request();
  }

  Future<void> checkPermissionSendNotification() async {
    await AwesomeNotifications().requestPermissionToSendNotifications(
      channelKey: UtilsNotification.channelKeySchedulingMedication,
      permissions: _notificationPermissionList,
    );
  }

  void _initializeNotifications() {
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
    if (receiveAction?.channelKey == UtilsNotification.channelKeySchedulingMedication) {
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
    int id,
    String title,
    String body,
    DateTime datetimeScheduling,
  ) async {
    if (statusNotificationPermission.isGranted) {
      return await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          channelKey: UtilsNotification.channelKeySchedulingMedication,
          title: title,
          body: body,
          wakeUpScreen: true,
          criticalAlert: true,
          category: NotificationCategory.Alarm,
        ),
        schedule: NotificationCalendar.fromDate(
          date: datetimeScheduling,
          allowWhileIdle: true,
          preciseAlarm: true,
        ),
      );
    } else {
      checkPermission();
      return false;
    }
  }
}
