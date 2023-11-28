// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuidame/app/configs/app_assets.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/router/routes.dart';
import 'package:cuidame/app/shared/widgets/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:cuidame/app/modules/caregiver/patient_medication/controllers/patient_medication_controller.dart';
import 'package:get/get.dart';

class AddNewMedication extends StatelessWidget {
  const AddNewMedication({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PatientMedicationController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Adicione uma medicação!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            CircleButton(
              onTap: () {
                Get.toNamed(Routes.addMedication);
              },
              icon: Icons.add,
              iconColor: AppColors.light,
              sizeCircle: 40,
            ),
          ],
        ),
        const Spacer(),
        const Image(
          image: AssetImage(AppAssets.addMedication),
        ),
        const Spacer(),
      ],
    );
  }
}
