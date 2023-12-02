import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:flutter/material.dart';

class Gutter extends StatelessWidget {
  const Gutter({
    super.key,
    required this.child,
    this.isSmall = false,
    this.hidePaddingBottom = false,
  });

  final Widget child;
  final bool? isSmall;
  final bool? hidePaddingBottom;

  @override
  Widget build(BuildContext context) {
    return isSmall ?? false
        ? Padding(
            padding: EdgeInsets.only(
              top: Spacements.XS,
              left: Spacements.XS,
              right: Spacements.XS,
              bottom: hidePaddingBottom ?? false ? 0 : Spacements.XS,
            ),
            child: child,
          )
        : Padding(
            padding: EdgeInsets.only(
              top: Spacements.M,
              left: Spacements.M,
              right: Spacements.M,
              bottom: hidePaddingBottom ?? false ? 0 : Spacements.M,
            ),
            child: child,
          );
  }
}
