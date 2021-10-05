import 'package:dating_app/models/response_model.dart';
import 'package:dating_app/models/interest.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/models/user_suggestion.dart';
// import 'package:dating_app/models/user_suggestion.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dio/dio.dart';

import 'client/apiClient.dart';
import 'client/api_list.dart';

class UploadImage{

  Future<String> uploadImage(String img64,int type) async {

    Response response;
    try {
      final _dio = apiClient();
      String id=await getUserId();
      print(img64);
      var data= _dio.then((value) async {
        response =await value.post(url_image_upload,
            data: {"user":id,"image_path":"$img64","type":type.toString()}
        );
        print(response.data);
        if (response.statusCode == 200) {
          print(ResponseData2.fromJson(response.data).path);
          return ResponseData2.fromJson(response.data).path;
        }
      });
      return data;
    } catch (e) {
      print(e);
    }
  }

}