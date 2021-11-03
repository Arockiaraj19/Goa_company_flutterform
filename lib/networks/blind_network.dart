import 'package:dating_app/models/response_model.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/shared/widgets/toast_msg.dart';
import 'package:dio/dio.dart';
import 'client/apiClient.dart';
import 'client/api_list.dart';

class BlindNetwork {
  Future<bool> postBlindRequest(var postData) async {
    Response response;
    try {
      final _dio = apiClient();
      var data = await _dio.then((value) async {
        response = await value.post(blindRequestEndpoint, data: postData);
        print("s");
        print(response.data);
        if (response.statusCode == 200) {
          showtoast(response.data["msg"]);
          ResponseData.fromJson(response.data);
          return true;
        }
      });
      return data;
    } catch (e) {
     throw e;
    }
  }

  Future<List<ResponseData>> getblindMatches() async {
    Response response;
    try {
      final _dio = apiClient();
      String id = await getUserId();
      var data = await _dio.then((value) async {
        response = await value
            .get(userDetailsEndpoint + "/" + id + blindMatchesEndpoint);
        print(response.data);

        if (response.statusCode == 200) {
          return (response.data as List)
              .map((x) => ResponseData.fromJson(x))
              .toList();
        }
      });
      return data;
    } catch (e) {
      throw e;
    }
  }
}
