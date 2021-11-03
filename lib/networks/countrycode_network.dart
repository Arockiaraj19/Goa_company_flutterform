import 'package:dating_app/models/country_code_model.dart';
import 'package:dating_app/networks/client/api_list.dart';
import 'package:dio/dio.dart';

import 'client/apiClient.dart';

class CountryCodeNetwork {
  Future getcountrycode(keyword) async {
    Response response;
    try {
      final _dio = authClient();

      var data = await _dio.then((value) async {
        response = await value
            .get(country_code, queryParameters: {"searchkey": keyword});
        final results = List<Map<String, dynamic>>.from(response.data);
        print("country code");
        print(response.data);
        List<CountryCode> finaldata = results
            .map((codeData) => CountryCode.fromMap(codeData))
            .toList(growable: false);

        return finaldata;
      });
      return data;
    } catch (e) {
      throw e;
    }
  }
}
