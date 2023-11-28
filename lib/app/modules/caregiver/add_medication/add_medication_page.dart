import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/modules/caregiver/add_medication/controllers/add_medication_controller.dart';
import 'package:cuidame/app/modules/caregiver/add_medication/widgets/register_medication.dart';
import 'package:cuidame/app/shared/gutter.dart';
import 'package:cuidame/app/shared/widgets/custom_app_bar.dart';
import 'package:cuidame/app/shared/widgets/safe_scroll_view.dart';
import 'package:flutter/material.dart';

class AddMedicationPage extends StatefulWidget {
  const AddMedicationPage({super.key});

  @override
  State<AddMedicationPage> createState() => _AddMedicationPageState();
}

class _AddMedicationPageState extends State<AddMedicationPage> {
  final controller = DependencesInjector.get<AddMedicationController>();
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
          child: Gutter(
            isSmall: true,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacements.S,
                vertical: Spacements.M,
              ),
              decoration: BoxDecoration(
                color: AppColors.light,
                borderRadius: BorderRadius.circular(50),
              ),
              child: RegisterMedication(controller: controller),
            ),
          ),
        ),
      ),
    );
  }
}
