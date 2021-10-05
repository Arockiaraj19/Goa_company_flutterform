import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerEffects(BuildContext context){
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade200,
    highlightColor: Colors.grey.shade50,
    child: Container(
      color: Colors.grey,
    ),
  );
}