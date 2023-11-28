import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/modules/caregiver/patient_medication/controllers/patient_medication_controller.dart';
import 'package:cuidame/app/modules/caregiver/patient_medication/widgets/add_new_medication.dart';
import 'package:cuidame/app/modules/caregiver/patient_medication/widgets/create_new_patient.dart';
import 'package:cuidame/app/modules/caregiver/navigation/controllers/navigation_controller.dart';
import 'package:cuidame/app/shared/gutter.dart';
import 'package:cuidame/app/shared/widgets/week_patient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientMedicationPage extends StatefulWidget {
  const PatientMedicationPage({super.key});

  @override
  State<PatientMedicationPage> createState() => _PatientMedicationPageState();
}

class _PatientMedicationPageState extends State<PatientMedicationPage> {
  final controller = DependencesInjector.get<PatientMedicationController>();
  final controllerNavigation = DependencesInjector.get<NavigationController>();
  @override
  Widget build(BuildContext context) {
    return Gutter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Obx(
            () => controller.loading.value
                ? const CircularProgressIndicator()
                : WeekPatient(
                    schedulingDayModel: controller.schedules.value!,
                  ),
          ),
          const SizedBox(height: Spacements.XL),
          Expanded(
            child: Obx(() {
              if (controller.patient.value != null) return AddNewMedication(controller: controller);
              return CreateNewPatient(controller: controller);
            }),
          ),
        ],
      ),
    );
  }
}
