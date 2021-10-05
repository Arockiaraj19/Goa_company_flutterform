import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget noResult(){
  return Column(mainAxisAlignment: MainAxisAlignment.center,
      children:[
        SizedBox(width: double.infinity,height: 300,
            child: Lottie.asset('assets/lottie/no_data.json')),
        Text("No results found !",style: TextStyle(fontSize: 18,),)
      ]);
}