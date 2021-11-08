import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart';

class Logotext extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GradientText(
      'Spark',
      gradient: LinearGradient(
        colors: [MainTheme.primaryColor, Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      style: TextStyle(fontSize: 44.sp, fontWeight: FontWeight.w700),
    );
  }
}
