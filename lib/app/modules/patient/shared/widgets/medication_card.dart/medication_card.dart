// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuidame/app/data/models/scheduling_medication_type.dart';
import 'package:flutter/material.dart';
import 'package:cuidame/app/configs/app_assets.dart';
import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/data/models/scheduling_day_model.dart';
import 'package:cuidame/app/shared/widgets/circle_button.dart';
import 'package:cuidame/app/utils/utils_datetime.dart';

class MedicationCard extends StatelessWidget {
  final SchedulingModel scheduling;
  final VoidCallback? onTap;
  final Color? borderColor;
  final SchedulingMedicationType schedulingType;

  const MedicationCard({
    super.key,
    required this.scheduling,
    this.onTap,
    this.borderColor,
    this.schedulingType = SchedulingMedicationType.inTime,
  });

  @override
  Widget build(BuildContext context) {
    bool medicationTaken() {
      return schedulingType == SchedulingMedicationType.taken;
    }

    TextDecoration textDecoration = medicationTaken() ? TextDecoration.lineThrough : TextDecoration.none;

    Color bgColor() {
      switch (schedulingType) {
        case SchedulingMedicationType.taken:
          return AppColors.success;
        case SchedulingMedicationType.closeToTime:
          return AppColors.darkOrange;
        case SchedulingMedicationType.delayed:
          return AppColors.pastelRed;
        case SchedulingMedicationType.inTime:
          return AppColors.tertiary;
        default:
          return AppColors.tertiary;
      }
    }

    Color textColor() {
      switch (schedulingType) {
        case SchedulingMedicationType.taken:
          return AppColors.light;
        case SchedulingMedicationType.closeToTime:
          return AppColors.black;
        case SchedulingMedicationType.delayed:
          return AppColors.light;
        case SchedulingMedicationType.inTime:
          return AppColors.black;
        default:
          return AppColors.black;
      }
    }

    Widget buildButtonCardMedication(String text, Color bgColor, Color textColor, VoidCallback? onTap) {
      return Expanded(
        child: TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            backgroundColor: bgColor,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Spacements.XXS),
            ),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: textColor,
                ),
          ),
        ),
      );
    }

    Widget buildCardMedication() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.transparent,
            child: Image.asset(
              AppAssets.pillMedicine,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: Spacements.XS),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                scheduling.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: textColor(),
                      decoration: textDecoration,
                      decorationColor: AppColors.light,
                      decorationThickness: 2,
                    ),
              ),
              const SizedBox(height: Spacements.XXS),
              Text(
                '${UtilsDateTime.timeString(scheduling.medicationTime)} - ${scheduling.quantity} ${scheduling.dosage}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: textColor(),
                      decoration: textDecoration,
                      decorationColor: AppColors.light,
                      decorationThickness: 2,
                    ),
              ),
            ],
          ),
          const Spacer(),
          CircleButton(
            onTap: medicationTaken() ? () {} : onTap,
            icon: Icons.check,
            iconColor: textColor(),
            elevation: medicationTaken() ? 0 : 2,
            backGroundColor: bgColor(),
            sizeIcon: 24,
          ),
        ],
      );
    }

    Widget buildCardMedicationExpand() {
      return Padding(
        padding: const EdgeInsets.only(
          bottom: Spacements.XS,
          top: Spacements.XXS,
          left: Spacements.XS,
          right: Spacements.XS,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      scheduling.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: textColor(),
                          ),
                    ),
                    const SizedBox(height: Spacements.XXS),
                    Text(
                      'Horário: ${UtilsDateTime.timeString(scheduling.medicationTime)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: textColor(),
                          ),
                    ),
                    const SizedBox(height: Spacements.XXS),
                    Text(
                      'Dosagem: ${scheduling.quantity} ${scheduling.dosage}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: textColor(),
                          ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    AppAssets.pillMedicine,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(height: Spacements.XS),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildButtonCardMedication(
                  'Pedir ajuda',
                  AppColors.lightYellow,
                  AppColors.black,
                  () {},
                ),
                const SizedBox(width: Spacements.M),
                buildButtonCardMedication(
                  'Já bebi',
                  AppColors.success,
                  AppColors.light,
                  onTap,
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: Spacements.XXS),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Spacements.S),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.3),
            offset: const Offset(1, 1),
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
        gradient: LinearGradient(
          colors: [
            borderColor ?? AppColors.darkGreen,
            bgColor(),
          ],
          stops: const [0.02, 0.02],
        ),
      ),
      padding: const EdgeInsets.all(Spacements.XS),
      child: schedulingType == SchedulingMedicationType.inTime || schedulingType == SchedulingMedicationType.taken
          ? buildCardMedication()
          : buildCardMedicationExpand(),
    );
  }
}
