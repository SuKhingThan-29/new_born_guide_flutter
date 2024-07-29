import 'dart:io';

import 'package:chitmaymay/chitmaymay_api/chitMayMayApi.dart';
import 'package:dio/dio.dart';
import 'requestModel.dart';

class ImageUploadApi {
  static Future<ImageUploadResponse?> profileImageUpload(
      File imageFile, String tokenKey) async {
    ImageUploadResponse? responseMessage;

    var dio = Dio();
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer $tokenKey',
    };
    FormData formData = FormData.fromMap({
      'secret_key': secret_key,
      'image_url': await MultipartFile.fromFile(imageFile.path)
    });
    var response = await dio.post(requestProfileUploadApi,
        data: formData, options: Options(headers: headers));
    if (response.statusCode == 200) {
      responseMessage = ImageUploadResponse.fromJson(response.data);
    }
    return responseMessage;
  }

  static Future<CreateGroupResponse?> requestCreateGroup(String filePath,
      String tokenKey, int userId, String groupName, List<int> members) async {
    CreateGroupResponse? responseMessage;
    var dio = Dio();
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer $tokenKey',
    };
    FormData formData = FormData.fromMap({
      'user_id': userId,
      'group_name': groupName,
      'members[]': members,
      'secret_key': secret_key,
      'group_img': await MultipartFile.fromFile(filePath)
    });
    var response = await dio.post(requestCreateGroupApi,
        data: formData, options: Options(headers: headers));
    if (response.statusCode == 200) {
      responseMessage = CreateGroupResponse.fromJson(response.data);
    }
    return responseMessage;
  }

  static Future<ImageUploadResponse?> chatImageUpload(
      File imageFile, String tokenKey) async {
    ImageUploadResponse? responseMessage;

    var dio = Dio();
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer $tokenKey',
    };
    FormData formData = FormData.fromMap({
      'secret_key': secret_key,
      'file': await MultipartFile.fromFile(imageFile.path)
    });
    var response = await dio.post(requestChatFileUploadApi,
        data: formData, options: Options(headers: headers));
    if (response.statusCode == 200) {
      responseMessage = ImageUploadResponse.fromJson(response.data);
    }
    return responseMessage;
  }
}
