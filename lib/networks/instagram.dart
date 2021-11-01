import 'dart:async';
import 'dart:convert';
import 'package:dating_app/models/user_suggestion.dart';
import 'package:dio/dio.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:io';

class Constants {
  static String APP_ID = "1141908882883789";
  static String APP_SECRET = "94a5761e24f4bab30558d9ac19d9ddbf";
}

Future<Token> getToken(String appId, String appSecret) async {
  Stream<String> onCode = await _server();
  String url =
      "https://api.instagram.com/oauth/authorize?client_id=$appId&redirect_uri=https://localhost:8585/&response_type=code";
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  flutterWebviewPlugin.launch(url);
  final String code = await onCode.first;

  Response responses =
      await Dio().post("https://api.instagram.com/oauth/access_token", data: {
    "client_id": appId,
    "redirect_uri": "https://localhost:8585/",
    "client_secret": appSecret,
    "code": code,
    "grant_type": "authorization_code"
  });
  flutterWebviewPlugin.close();
  return new Token.fromMap(jsonDecode(responses.data));
}

Future<Stream<String>> _server() async {
  final StreamController<String> onCode = new StreamController();
  HttpServer server =
      await HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, 8585);
  server.listen((HttpRequest request) async {
    final String code = request.uri.queryParameters["code"];
    request.response
      ..statusCode = 200
      ..headers.set("Content-Type", ContentType.HTML.mimeType)
      ..write("<html><h1>You can now close this window</h1></html>");
    await request.response.close();
    await server.close(force: true);
    onCode.add(code);
    await onCode.close();
  });
  return onCode.stream;
}

class Token {
  String access;
  String id;
  String username;
  String full_name;
  String profile_picture;

  Token.fromMap(Map json) {
    access = json['access_token'];
    id = json['user']['id'];
    username = json['user']['username'];
    full_name = json['user']['full_name'];
    profile_picture = json['user']['profile_picture'];
  }
}
