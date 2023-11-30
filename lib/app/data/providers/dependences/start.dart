import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/data/providers/http/http_client.dart';
import 'package:cuidame/app/data/services/local_notification_service.dart';
import 'package:cuidame/app/data/services/user_login_service.dart';
import 'package:cuidame/app/modules/caregiver/navigation/controllers/navigation_controller.dart';
import 'package:cuidame/app/modules/confirm_email/controllers/confirm_email_controller.dart';
import 'package:cuidame/app/modules/forgot_password/controllers/forgot_password_controller.dart';
import 'package:cuidame/app/modules/register/controllers/register_controller.dart';
import 'package:cuidame/app/modules/signin/controllers/signin_controller.dart';
import 'package:cuidame/app/modules/start/controllers/start_controller.dart';

void setupStartInjections() {
  DependencesInjector.registerLazySingleton<UserLoginService>(
    () => UserLoginService(),
  );

  DependencesInjector.registerLazySingleton<LocalNotificationService>(
    () => LocalNotificationService(),
  );

  DependencesInjector.registerFactory<HttpClient>(
    () => HttpClient(
      DependencesInjector.get<UserLoginService>(),
    ),
  );

  DependencesInjector.registerFactory<StartController>(
    () => StartController(),
  );

  DependencesInjector.registerFactory<SignInController>(
    () => SignInController(),
  );

  DependencesInjector.registerFactory<RegisterController>(
    () => RegisterController(),
  );

  DependencesInjector.registerFactory<ConfirmEmailController>(
    () => ConfirmEmailController(
      DependencesInjector.get<UserLoginService>(),
    ),
  );

  DependencesInjector.registerFactory<ForgotPasswordController>(
    () => ForgotPasswordController(),
  );

  DependencesInjector.registerLazySingleton<NavigationController>(
    () => NavigationController(),
  );
}
