// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SafeScrollView extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;

  const SafeScrollView({
    Key? key,
    required this.child,
    this.padding,
    this.physics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: physics,
          padding: padding,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(child: child),
          ),
        );
      },
    );
  }
}
