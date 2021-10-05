import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';

class SlidersFeilds extends StatefulWidget {
  SlidersFeilds({Key key}) : super(key: key);

  @override
  _SlidersFeildsState createState() => _SlidersFeildsState();
}

class _SlidersFeildsState extends State<SlidersFeilds> {
  RangeValues _currentRangeValues = const RangeValues(40, 80);
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

      ],
    );
  }
}
