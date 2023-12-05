import 'package:cuidame/app/modules/caregiver/navigation/controllers/navigation_controller.dart';
import 'package:cuidame/app/modules/caregiver/patient_profile/patient_profile_page.dart';
import 'package:cuidame/app/modules/caregiver/patient_report/patient_report_page.dart';
import 'package:cuidame/app/shared/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/modules/caregiver/patient_medication/patient_medication_page.dart';
import 'package:cuidame/app/shared/widgets/floating_navigation_bar.dart';
import 'package:cuidame/app/shared/widgets/carregiver_app_bar.dart';
import 'package:get/get.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final controller = DependencesInjector.get<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.loading) {
        return const LoadingWidget();
      }
      return Scaffold(
        backgroundColor: AppColors.light,
        appBar: CaregiverAppBar(
          appBar: AppBar(),
          subTitle: Obx(
            () => Text(
              controller.subTitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
        body: TabBarView(
          controller: controller.tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            Center(child: PatientMedicationPage()),
            Center(child: PatientReportPage()),
            Center(child: PatientProfilePage()),
          ],
        ),
        bottomNavigationBar: FloatingNavigationBar(
          buttons: [
            Obx(
              () => IconButton(
                onPressed: () {
                  controller.onItemTapped(0);
                },
                icon: Icon(
                  controller.selectIndex.value != 0 ? Icons.medical_services_outlined : Icons.medical_services,
                ),
                color: AppColors.light,
                iconSize: Spacements.L,
                tooltip: 'Paciente',
              ),
            ),
            Obx(
              () => IconButton(
                onPressed: controller.existPatient
                    ? () {
                        controller.onItemTapped(1);
                      }
                    : null,
                icon: Icon(
                  controller.selectIndex.value != 1 ? Icons.assignment_outlined : Icons.assignment,
                ),
                color: AppColors.light.withOpacity(controller.existPatient ? 1 : .3),
                iconSize: Spacements.L,
                tooltip: 'Relatório',
              ),
            ),
            Obx(
              () => IconButton(
                onPressed: controller.existPatient
                    ? () {
                        controller.onItemTapped(2);
                      }
                    : null,
                icon: Icon(
                  controller.selectIndex.value != 2 ? Icons.person_outline : Icons.person,
                ),
                color: AppColors.light.withOpacity(controller.existPatient ? 1 : .3),
                iconSize: Spacements.L,
                tooltip: 'Usuário',
              ),
            ),
          ],
        ),
      );
    });
  }
}
