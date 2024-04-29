import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as pth;
import 'package:online_groceries_shop_app_flutter_admin/view_model/splash_view_model.dart';

typedef ResSuccess = Future<void> Function(Map<String, dynamic>);
typedef ResFailure = Future<void> Function(dynamic);

class ServiceCall {
  static void post(Map<String, dynamic> parameter, String path,
      {bool isToken = false, ResSuccess? withSuccess, ResFailure? failure}) {
    Future(() {
      try {
        var headers = {'Content-Type': 'application/x-www-form-urlencoded'};

        if (isToken) {
          var token = Get.find<SplashViewModel>().userPayload.value.authToken;
          headers["access_token"] = token ?? "";
        }

        http
            .post(Uri.parse(path), body: parameter, headers: headers)
            .then((value) {
          if (kDebugMode) {
            print(value.body);
          }
          try {
            var jsonObj =
                json.decode(value.body) as Map<String, dynamic>? ?? {};

            if (withSuccess != null) withSuccess(jsonObj);
          } catch (err) {
            if (failure != null) failure(err.toString());
          }
        }).catchError((e) {
          if (failure != null) failure(e.toString());
        });
      } catch (err) {
        if (failure != null) failure(err.toString());
      }
    });
  }

  static void multipart(Map<String, String> parameter, String path,
      {bool isTokenApi = false,
      Map<String, File>? imgObj,
      ResSuccess? withSuccess,
      ResFailure? failure}) {
    Future(() {
      try {
        var uri = Uri.parse(path);
        var request = http.MultipartRequest('POST', uri);
        request.fields.addAll(parameter);

        if (isTokenApi) {
          var token = Get.find<SplashViewModel>().userPayload.value.authToken;
          request.headers["access_token"] = token ?? "";
        }

        if (kDebugMode) {
          print('Service Call: $path');
          print('Service para: ${parameter.toString()}');
          print('Service header: ${request.headers.toString()}');
        }

        if (imgObj != null) {
          imgObj.forEach((key, value) async {
            var multipartFile = http.MultipartFile(
                key, value.readAsBytes().asStream(), value.lengthSync(),
                filename: pth.basename(value.path));
            request.files.add(multipartFile);
          });
        }

        request.send().then((response) async {
          var value = await response.stream.transform(utf8.decoder).join();

          try {
            if (kDebugMode) {
              print(value);
            }

            var jsonObj = json.decode(value) as Map<String, dynamic>? ?? {};
            if (withSuccess != null) {
              withSuccess(jsonObj);
            }
          } catch (e) {
            if (failure != null) failure(e.toString());
          }
        }).catchError((err) {
          if (failure != null) failure(err.toString());
        });
      } on SocketException catch (e) {
        if (failure != null) failure(e.toString());
      } catch (e) {
        if (failure != null) failure(e.toString());
      }
    });
  }
}
