import 'package:cuidame/app/configs/app_assets.dart';
import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:flutter/material.dart';

class NoMedication extends StatelessWidget {
  const NoMedication({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppAssets.noSchedulings),
        const SizedBox(height: Spacements.S),
        Text(
          'Volte mais tarde enquanto preparamos tudo',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
