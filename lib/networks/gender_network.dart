import 'package:dating_app/models/gender_model.dart';
import 'package:dating_app/networks/client/apiClient.dart';
import 'package:dating_app/networks/client/api_list.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GenderNetwork {
  Future<dynamic> getGenderData() async {
    Response response;
    try {
      final _dio = apiClient();

      var data = _dio.then((value) async {
        response = await value.get(url_get_gender);
        print(response.data);
        if (response.statusCode == 200) {
          // return response.data;
          final results = List<Map<String, dynamic>>.from(response.data);
          print("gender response data");
          print(response.data);
          List<GenderModel> genders = results
              .map((genderData) => GenderModel.fromMap(genderData))
              .toList(growable: false);
          print("genders");
          print(genders);
          return genders;
        }
      });
      return data;
    } catch (e) {
      throw e;
    }
  }
}
