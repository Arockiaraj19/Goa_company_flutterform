import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class LoadingLottie extends StatelessWidget {
  const LoadingLottie({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Lottie.asset(
            'assets/lottie/loadingLottie.json',
            fit: BoxFit.contain),
      );
  }
}
