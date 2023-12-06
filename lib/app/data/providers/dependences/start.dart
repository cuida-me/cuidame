import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/data/repositories/caregiver_repository.dart';
import 'package:cuidame/app/data/services/caregiver_service.dart';
import 'package:cuidame/app/data/services/patient_login_service.dart';
import 'package:cuidame/app/data/services/user_login_service.dart';
import 'package:cuidame/app/modules/caregiver/navigation/controllers/navigation_controller.dart';
import 'package:cuidame/app/modules/confirm_email/controllers/confirm_email_controller.dart';
import 'package:cuidame/app/modules/forgot_password/controllers/forgot_password_controller.dart';
import 'package:cuidame/app/modules/register/controllers/register_controller.dart';
import 'package:cuidame/app/modules/signin/controllers/signin_controller.dart';
import 'package:cuidame/app/modules/start/controllers/start_controller.dart';

void setupStartInjections() {
  DependencesInjector.registerLazySingleton<PatientLoginService>(
    () => PatientLoginService(),
  );

  DependencesInjector.registerFactory<StartController>(
    () => StartController(),
  );

  DependencesInjector.registerFactory<SignInController>(
    () => SignInController(),
  );

  DependencesInjector.registerFactory<RegisterController>(
    () => RegisterController(
      DependencesInjector.get<CaregiverRepository>(),
    ),
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
    () => NavigationController(
      DependencesInjector.get<CaregiverService>(),
    ),
  );
}
