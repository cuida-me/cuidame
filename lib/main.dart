import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cuidame/app/app.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
    'resource://drawable/app_icon',
    [
      NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'teste',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
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
    // Channel groups are only visual and are not required
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: 'teste',
        channelGroupName: 'Basic group',
      )
    ],
    debug: true,
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: '.env');
  DependencesInjector.setup();
  runApp(const App());
}
