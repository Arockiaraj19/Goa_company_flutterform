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
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:html' as html;
import 'client/apiClient.dart';
import 'client/api_list.dart';

class UploadImage {
  Future uploadImage(img64, String type) async {
    Response response;
    try {
      final _dio = apiClient();
      String id = await getUserId();

      var data = _dio.then((value) async {
        response = await value.get(
          url_image_upload,
          queryParameters: {
            "directory": type,
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

  Future<bool> deleteImage(
      List<String> deleteImage, List<String> existingPath, String type) async {
    print("delete image api call aakutha");
    Response response;
    try {
      final _dio = apiClient();
      String userId = await getUserId();
      var data = _dio.then((value) async {
        response = await value.delete("/user/images/", data: {
          "url": deleteImage,
          "directory": type,
          "user": userId,
          "existing_paths": existingPath
        });

        if (response.statusCode == 200) {
          return true;
        }
      });
      return data;
    } catch (e) {
      throw e;
    }
  }
}

class UploadImageWeb {
  Future uploadImage(Uint8List img64, String type) async {
    Response response;
    try {
      final _dio = apiClient();
      String id = await getUserId();

      var data = _dio.then((value) async {
        response = await value.get(
          url_image_upload,
          queryParameters: {
            "directory": type,
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

  Future uploadaws(String uploadUrl, Uint8List image) async {
    try {
      Response result = await Dio().put(
        uploadUrl,
        data: File.fromRawPath(image).openRead(),
        options: Options(
          contentType: "image/jpeg",
          headers: {
            "Content-Length": File.fromRawPath(image).lengthSync(),
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

  Future<bool> deleteImage(
      List<String> deleteImage, List<String> existingPath, String type) async {
    print("delete image api call aakutha");
    Response response;
    try {
      final _dio = apiClient();
      String userId = await getUserId();
      var data = _dio.then((value) async {
        response = await value.delete("/user/images/", data: {
          "url": deleteImage,
          "directory": type,
          "user": userId,
          "existing_paths": existingPath
        });

        if (response.statusCode == 200) {
          return true;
        }
      });
      return data;
    } catch (e) {
      throw e;
    }
  }
}
