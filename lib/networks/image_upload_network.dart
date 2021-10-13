import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:dating_app/models/response_model.dart';
import 'package:dating_app/models/interest.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/models/user_suggestion.dart';
// import 'package:dating_app/models/user_suggestion.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import 'client/apiClient.dart';
import 'client/api_list.dart';

class UploadImage {
  Future uploadImage(img64) async {
    Response response;
    try {
      final _dio = apiClient();
      String id = await getUserId();

      var data = _dio.then((value) async {
        response = await value.get(
          url_image_upload,
          queryParameters: {
            "directory": "user_gallery",
            "filename": "IMG_${id}_${DateTime.now().millisecond}.jpg",
          },
        );
        print("response from edit profile data image");
        print(response.data);

        if (response.statusCode == 200) {
          try {
            Response imageresult =
                await uploadaws(response.data["uploadUrl"], img64);
            print("image result");
            print(imageresult);
          } catch (e) {
            print(e);
          }
        }
      });
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future uploadaws(String uploadUrl, image) async {
    print("uploadaws");
    print(uploadUrl);
    print("image path");
    print(image);
    try {
      Response result = await Dio().put(
        uploadUrl,
        data: File(image),
      );
      if (result.statusCode == 200) {
        print("image result");
        print(result.data);
      }

      return result;
    } catch (e) {
      print(e);
    }
  }
}
