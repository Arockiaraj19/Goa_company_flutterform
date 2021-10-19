import 'package:dating_app/networks/client/api_list.dart';
import 'package:dio/dio.dart';

class CountryCodeNetwork {
  Future getcountrycode() async {
    Response response;
    try {
      response = await Dio().get(country_code);
      print("get country code");
      print(response.data);
    } catch (e) {
      print(e);
    }
  }
}
