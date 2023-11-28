import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/modules/caregiver/patient_register/controllers/patient_register_controller.dart';
import 'package:cuidame/app/modules/caregiver/patient_register/widgets/register_patient.dart';
import 'package:cuidame/app/shared/widgets/custom_app_bar.dart';
import 'package:cuidame/app/shared/widgets/safe_scroll_view.dart';
import 'package:flutter/material.dart';

class PatientRegisterPage extends StatefulWidget {
  const PatientRegisterPage({super.key});

  @override
  State<PatientRegisterPage> createState() => _PatientRegisterPageState();
}

class _PatientRegisterPageState extends State<PatientRegisterPage> {
  final controller = DependencesInjector.get<PatientRegisterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: CustomAppBar(
        context: context,
        title: const Text('Voltar'),
        transparent: true,
      ),
      body: SafeArea(
        child: SafeScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Spacements.XS),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacements.S,
                vertical: Spacements.M,
              ),
              decoration: BoxDecoration(
                color: AppColors.light,
                borderRadius: BorderRadius.circular(50),
              ),
              child: RegisterPatient(controller: controller),
            ),
          ),
        ),
      ),
    );
  }
}
