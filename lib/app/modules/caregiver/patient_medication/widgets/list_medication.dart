// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuidame/app/configs/app_assets.dart';
import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/extensions/hex_color.dart';
import 'package:cuidame/app/router/routes.dart';
import 'package:cuidame/app/shared/widgets/circle_button.dart';
import 'package:cuidame/app/shared/widgets/medication_card.dart';
import 'package:flutter/material.dart';
import 'package:cuidame/app/modules/caregiver/patient_medication/controllers/patient_medication_controller.dart';
import 'package:get/get.dart';

class ListMedication extends StatelessWidget {
  const ListMedication({
    super.key,
    required this.controller,
  });

  final PatientMedicationController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              controller.schedulingWeek != null ? 'Hoje' : 'Adicione uma medicação!',
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
        if (controller.schedulingToday != null) ...[
          const SizedBox(height: Spacements.M),
          Expanded(
            child: SingleChildScrollView(
              child: Obx(() {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (_, i) {
                    final scheduling = controller.schedulingToday?.schedulings?[i];
                    return MedicationCard(
                      scheduling: scheduling!,
                      icon: Icons.edit,
                      borderColor: HexColor.fromHex(scheduling.color),
                      onTap: () {
                        // Edit
                      },
                    );
                  },
                  separatorBuilder: (_, i) => const SizedBox(height: Spacements.M),
                  itemCount: controller.schedulingToday?.schedulings?.length ?? 0,
                );
              }),
            ),
          ),
        ] else ...[
          const Spacer(),
          const Image(
            image: AssetImage(AppAssets.addMedication),
          ),
          const Spacer(),
        ]
      ],
    );
  }
}
