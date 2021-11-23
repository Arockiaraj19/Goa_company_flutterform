import 'package:dating_app/models/user_suggestion.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dio/dio.dart';

import 'client/apiClient.dart';

class Ref {
  Future addReferal() async {
    print("intha referal api call aaakuthaaa");

    Response response;
    String refId = await getRef();
    print(refId);
    try {
      final _dio = apiClient();

      var data = await _dio.then((value) async {
        response = await value.post("/user/coincredit",
            data: {"user_referral_code": refId.trim(), "type":"1"});
        print("response");
        print(response.data);
      });
      return data;
    } catch (e) {
      throw e;
    }
  }

   Future coinCredit(String ref) async {
   

    Response response;
 

    try {
      final _dio = apiClient();

      var data = await _dio.then((value) async {
        response = await value.post("/user/coincredit",
            data: {"user_referral_code":ref, "type":"2"});
        print("response");
        print(response.data);
      });
      return data;
    } catch (e) {
      throw e;
    }
  }
}
