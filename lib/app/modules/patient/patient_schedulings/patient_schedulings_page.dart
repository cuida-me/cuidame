import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/modules/patient/patient_schedulings/controllers/patient_schedulings_controller.dart';
import 'package:cuidame/app/modules/patient/patient_schedulings/widgets/list_medications.dart';
import 'package:cuidame/app/modules/patient/patient_schedulings/widgets/no_medication.dart';
import 'package:cuidame/app/modules/patient/shared/widgets/patient_app_bar.dart';
import 'package:cuidame/app/shared/gutter.dart';
import 'package:cuidame/app/shared/widgets/week_patient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientSchedulingsPage extends StatefulWidget {
  const PatientSchedulingsPage({super.key});

  @override
  State<PatientSchedulingsPage> createState() => _PatientSchedulingsPageState();
}

class _PatientSchedulingsPageState extends State<PatientSchedulingsPage> {
  final controller = DependencesInjector.get<PatientSchedulingsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      appBar: PatientAppBar(
        appBar: AppBar(),
        subTitle: Text(
          'Vamos verificar seu plano para hoje',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      body: SafeArea(
        child: Gutter(
          hidePaddingBottom: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(
                () => controller.loading.value
                    ? const CircularProgressIndicator()
                    : WeekPatient(schedulingDayModel: controller.schedules.value),
              ),
              const SizedBox(height: Spacements.L),
              Expanded(
                child: Obx(
                  () => !controller.loading.value && controller.isSchedulings
                      ? ListMedications(controller: controller)
                      : controller.loading.value
                          ? const Center(child: CircularProgressIndicator())
                          : const NoMedication(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
