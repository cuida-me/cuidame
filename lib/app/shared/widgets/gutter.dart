// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:cuidame/app/configs/constants/spacements.dart';

class Gutter extends StatelessWidget {
  const Gutter({
    Key? key,
    this.child,
  }) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Spacements.L,
        right: Spacements.M,
        left: Spacements.M,
      ),
      child: child,
    );
  }
}
