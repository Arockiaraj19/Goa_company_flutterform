import 'package:dating_app/models/imageCheckModel.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dio/dio.dart';

import 'client/apiClient.dart';

class ImageCheckNetwork {
  Future check(String base64) async {
    Response response;
    try {
      response = await Dio()
          .post("http://3.108.51.121:5000/nsfw", data: {"file": base64});
      print("image upload la enna error varuthu");
      print(response.data["0"]);
      return ImageCheckModel.fromMap(response.data["0"]);
    } catch (e) {
      throw e;
    }
  }

  Future addBadCount() async {
    Response response;
    try {
      final _dio = apiClient();
      final id = await getUserId();
      var data = _dio.then((value) async {
        response = await value
            .patch("/user/badcount", data: {"user_id": id, "bad_count": 1});
        print("add bad count response");
        print(response.data);
      });
      return data;
    } catch (e) {
      throw e;
    }
  }
}
