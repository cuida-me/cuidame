// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/modules/patient/patient_schedulings/controllers/patient_schedulings_controller.dart';
import 'package:cuidame/app/shared/widgets/medication_card.dart';

class ListMedications extends StatelessWidget {
  final PatientSchedulingsController controller;

  const ListMedications({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    Widget buildSchedulingsDelayed() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'A medicação está em atraso!',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: Spacements.S),
          ListView.separated(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (_, i) {
              final scheduling = controller.schedulingsDelayed?[i];
              return MedicationCard(
                onTap: () {
                  controller.medicationTaken(
                    controller.schedule!.dayWeek,
                    scheduling.id,
                  );
                },
                scheduling: scheduling!,
                borderColor: AppColors.lightRed,
                schedulingType: scheduling.type,
              );
            },
            separatorBuilder: (_, i) => const SizedBox(height: Spacements.M),
            itemCount: controller.schedulingsDelayed?.length ?? 0,
          ),
          const SizedBox(height: Spacements.M),
        ],
      );
    }

    Widget buildSchedulingsCloseToTime() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'É hora da medicação...',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: Spacements.S),
          ListView.separated(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (_, i) {
              final scheduling = controller.schedulingsCloseToTime?[i];
              return MedicationCard(
                onTap: () {
                  controller.medicationTaken(
                    controller.schedule!.dayWeek,
                    scheduling.id,
                  );
                },
                scheduling: scheduling!,
                borderColor: AppColors.lightRed,
                schedulingType: scheduling.type,
              );
            },
            separatorBuilder: (_, i) => const SizedBox(height: Spacements.M),
            itemCount: controller.schedulingsCloseToTime?.length ?? 0,
          ),
          const SizedBox(height: Spacements.M),
        ],
      );
    }

    Widget buildSchedulingsInTime() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hoje',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: Spacements.S),
          ListView.separated(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (_, i) {
              final scheduling = controller.schedulingsInTimeAndTaken?[i];
              return MedicationCard(
                onTap: () {
                  controller.medicationTaken(
                    controller.schedule!.dayWeek,
                    scheduling.id,
                  );
                },
                scheduling: scheduling!,
                borderColor: AppColors.lightRed,
                schedulingType: scheduling.type,
              );
            },
            separatorBuilder: (_, i) => const SizedBox(height: Spacements.M),
            itemCount: controller.schedulingsInTimeAndTaken?.length ?? 0,
          ),
          const SizedBox(height: Spacements.M),
        ],
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (controller.schedulingsDelayed?.isNotEmpty ?? false) buildSchedulingsDelayed(),
          if (controller.schedulingsCloseToTime?.isNotEmpty ?? false) buildSchedulingsCloseToTime(),
          if (controller.schedulingsInTimeAndTaken?.isNotEmpty ?? false) buildSchedulingsInTime(),
        ],
      ),
    );
  }
}
