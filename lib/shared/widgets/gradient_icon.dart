import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask(this.child);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) =>
          MainTheme.backgroundGradient.createShader(bounds),
      child: child,
    );
  }
}
