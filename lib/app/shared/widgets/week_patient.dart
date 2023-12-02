// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/data/models/scheduling_day_model.dart';

class WeekPatient extends StatefulWidget {
  const WeekPatient({
    super.key,
    required this.schedulingDayModel,
  });

  final List<SchedulingDayModel>? schedulingDayModel;

  @override
  State<WeekPatient> createState() => _WeekPatientState();
}

class _WeekPatientState extends State<WeekPatient> {
  final date = DateTime.now();

  final months = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro',
  ];

  Widget cardDay(int day, int weekDay, String dayName) {
    bool isToday() {
      return day == date.day;
    }

    return Expanded(
      child: Container(
        margin: weekDay == 6 ? const EdgeInsets.only(right: 0) : const EdgeInsets.only(right: Spacements.XS),
        padding: const EdgeInsets.symmetric(
          vertical: Spacements.XS,
        ),
        decoration: BoxDecoration(
          color: isToday() ? AppColors.secondary : AppColors.tertiary,
          borderRadius: BorderRadius.circular(Spacements.XS),
        ),
        child: Column(
          children: [
            Text(
              '${dayName.capitalize}',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: isToday() ? AppColors.light : AppColors.black,
                  ),
            ),
            const SizedBox(height: Spacements.XS),
            Text(
              '$day',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: isToday() ? AppColors.light : AppColors.black,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  String getDayOfDate(DateTime date, int daysSubtract) {
    return date.subtract(Duration(days: daysSubtract)).day.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(
              'Semana',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            Text(
              '${months[date.month - 1]}, ${date.year}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        const SizedBox(height: Spacements.XS),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: widget.schedulingDayModel
                  ?.map(
                    (e) => cardDay(e.day, e.dayWeek, e.dayName),
                  )
                  .toList() ??
              [],
        ),
      ],
    );
  }
}
