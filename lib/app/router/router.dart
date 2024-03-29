import 'package:cuidame/app/modules/caregiver/add_medication/add_medication_page.dart';
import 'package:cuidame/app/modules/caregiver/my_profile/my_profile_page.dart';
import 'package:cuidame/app/modules/caregiver/navigation/navigation_page.dart';
import 'package:cuidame/app/modules/caregiver/patient_connect/patient_connect_page.dart';
import 'package:cuidame/app/modules/caregiver/patient_register/patient_register_page.dart';
import 'package:cuidame/app/modules/confirm_email/confirm_email_page.dart';
import 'package:cuidame/app/modules/forgot_password/forgot_password_page.dart';
import 'package:cuidame/app/modules/init/init_page.dart';
import 'package:cuidame/app/modules/patient/my_profile_patient/my_profile_patient_page.dart';
import 'package:cuidame/app/modules/patient/patient_qr_code/patient_qr_code_page.dart';
import 'package:cuidame/app/modules/patient/patient_schedulings/patient_schedulings_page.dart';
import 'package:cuidame/app/modules/permissions/notification_permission_page.dart';
import 'package:cuidame/app/modules/permissions/notification_policy_permission_page.dart';
import 'package:cuidame/app/modules/register/register_page.dart';
import 'package:cuidame/app/modules/signin/signin_page.dart';
import 'package:cuidame/app/modules/start/start_page.dart';
import 'package:cuidame/app/router/routes.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static Map<String, WidgetBuilder> routes = {
    Routes.init: (_) => const InitPage(),
    Routes.start: (_) => const StartPage(),
    Routes.signIn: (_) => const SignInPage(),
    Routes.register: (_) => const RegisterPage(),
    Routes.confirmEmail: (_) => const ConfirmEmailPage(),
    Routes.forgotPassword: (_) => const ForgotPasswordPage(),
    Routes.navigation: (_) => const NavigationPage(),
    Routes.myProfile: (_) => const MyProfilePage(),
    Routes.patientRegister: (_) => const PatientRegisterPage(),
    Routes.patientConnect: (_) => const PatientConnectPage(),
    Routes.addMedication: (_) => const AddMedicationPage(),
    Routes.patientQrCode: (_) => const PatientQrCodePage(),
    Routes.notificationPermission: (_) => const NotificationPermissionPage(),
    Routes.notificationPolicyPermission: (_) => const NotificationPolicyPermissionPage(),
    Routes.patientSchedulings: (_) => const PatientSchedulingsPage(),
    Routes.myProfilePatient: (_) => const MyProfilePatientPage(),
  };

  static Route<dynamic> onGenerateUnknowedRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          body: Center(
            child: Text('Nenhuma rota definida para ${settings.name}'),
          ),
        );
      },
    );
  }
}
