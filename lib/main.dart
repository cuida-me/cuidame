import 'package:cuidame/app/app.dart';
import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: '.env');
  DependencesInjector.setup();
  runApp(const App());
}
