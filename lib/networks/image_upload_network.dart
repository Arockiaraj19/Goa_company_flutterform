import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:dating_app/models/image_model.dart';
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
            "mimetype": "image/jpeg",
          },
        );
        print("response from edit profile data image");
        print(response.data);

        if (response.statusCode == 200) {
          ImageModel results = ImageModel.fromMap(response.data);
          await uploadaws(results.uploadUrl, img64);
          return results.viewUrl.toString();
        }
      });
      return data;
    } catch (e) {
      throw e;
    }
  }

  Future uploadaws(String uploadUrl, image) async {
    try {
      Response result = await Dio().put(
        uploadUrl,
        data: File(image).openRead(),
        options: Options(
          contentType: "image/jpeg",
          headers: {
            "Content-Length": File(image).lengthSync(),
          },
        ),
      );
      if (result.statusCode == 200) {
        print("image result");
      }

      return result;
    } catch (e) {
      throw e;
    }
  }
}
