import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dio/dio.dart';

import 'client/api_list.dart';

class Topic {
  Future subscripeToken(token, topic) async {
    try {
      Response response = await Dio().post(
        'https://iid.googleapis.com/iid/v1/' + token + '/rel/topics/' + topic,
        options: Options(
          headers: {'Authorization': 'key=' + fcm_server_key},
        ),
      );
      print(response.data);
      print("response topic" + topic);
      return true;
    } catch (e) {
      print(e);
    }
  }
}

class DynamcLink {
  Future<String> creatLink(String refId) async {
    try {
      Response response = await Dio().post(
          'https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=$webapikey',
          data: {
            "dynamicLinkInfo": {
              "domainUriPrefix": 'https://life2sparks.page.link',
              "link": "https://life2sparks.page.link/ref?id=$refId",
              "androidInfo": {"androidPackageName": "com.life2sparks"},
              "iosInfo": {"iosBundleId": "com.example.ios"}
            }
          });

      print("dynamic link data");
      return response.data["shortLink"].toString();
    } catch (e) {
      print(e);
    }
  }
}
