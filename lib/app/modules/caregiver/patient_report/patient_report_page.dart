import 'package:cuidame/app/configs/app_assets.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/modules/caregiver/patient_report/controllers/patient_report_controller.dart';
import 'package:cuidame/app/shared/gutter.dart';
import 'package:cuidame/app/shared/widgets/circle_button.dart';
import 'package:flutter/material.dart';

class PatientReportPage extends StatefulWidget {
  const PatientReportPage({super.key});

  @override
  State<PatientReportPage> createState() => _PatientReportPageState();
}

class _PatientReportPageState extends State<PatientReportPage> {
  final controller = DependencesInjector.get<PatientReportController>();
  @override
  Widget build(BuildContext context) {
    return Gutter(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Gere um novo relatório',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              CircleButton(
                onTap: () {
                  controller.downloadReport();
                },
                icon: Icons.download,
                iconColor: AppColors.light,
                sizeCircle: 40,
              ),
            ],
          ),
          const Spacer(),
          const Image(
            image: AssetImage(AppAssets.downloadReport),
          ),
        ],
      ),
    );
  }
}
