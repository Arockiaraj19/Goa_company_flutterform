import 'package:dating_app/networks/client/apiClient.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dio/dio.dart';

class MatchNetwork {
  Future getMatchlist() async {
    Response response;
    try {
      final _dio = apiClient();
      final id = await getUserId();
      var data = _dio.then((value) async {
        response = await value.get("/user/$id/profile");
        print("response get match list");
        print(response.data);
      });
      return data;
    } catch (e) {
     throw e;
    }
  }
}
