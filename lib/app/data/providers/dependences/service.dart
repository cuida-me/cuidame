import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/data/repositories/caregiver_repository.dart';
import 'package:cuidame/app/data/services/caregiver_service.dart';
import 'package:cuidame/app/data/services/local_notification_service.dart';
import 'package:cuidame/app/data/services/scheduling_service.dart';
import 'package:cuidame/app/data/services/user_login_service.dart';

void setupServiceInjection() {
  DependencesInjector.registerLazySingleton<UserLoginService>(
    () => UserLoginService(),
  );

  DependencesInjector.registerLazySingleton<LocalNotificationService>(
    () => LocalNotificationService(),
  );

  DependencesInjector.registerLazySingleton<SchedulingService>(
    () => SchedulingService(
      DependencesInjector.get<LocalNotificationService>(),
    ),
  );

  DependencesInjector.registerLazySingleton<CaregiverService>(
    () => CaregiverService(
      DependencesInjector.get<CaregiverRepository>(),
    ),
  );
}
