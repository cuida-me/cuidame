import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cuidame/app/app.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/utils/utils_notification.dart';
import 'package:cuidame/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  AwesomeNotifications().initialize(
    'resource://drawable/app_icon',
    [
      NotificationChannel(
        channelGroupKey: UtilsNotification.channelGroupKeySchedulingMedication,
        channelKey: UtilsNotification.channelKeySchedulingMedication,
        channelName: 'Scheduling Medications',
        channelDescription: 'Warning to take the medicine',
        defaultColor: AppColors.primary,
        ledColor: AppColors.light,
        playSound: true,
        soundSource: 'resource://raw/custom_alarm',
        enableLights: true,
        enableVibration: true,
        criticalAlerts: true,
        locked: true,
        importance: NotificationImportance.Max,
        defaultPrivacy: NotificationPrivacy.Public,
        channelShowBadge: true,
      ),
    ],
    channelGroups: [],
    debug: kDebugMode,
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: '.env.dev');
  DependencesInjector.setup();
  runApp(const App());
}
