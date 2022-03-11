import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/api_response.dart';
import 'package:http/http.dart' as http;

String _baseUrl = "https://dev.pingsite.io:4000/api/v1/";

Future<User> authenticateUser(String username, String password) async {
  User user = User();

  var payload = {
    "user": {
      'email': username,
      'password': password,
    }
  };
  try {
    http.Response response = await http.post(Uri.parse('${_baseUrl}session'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(payload));
    debugPrint('response: $response');
    switch (response.statusCode) {
      case 200:
        user = User.fromJson(json.decode(response.body));
        break;
      // case 401:
      //   _LoginResponse.ApiError = ApiError.fromJson(json.decode(response.body));
      //   break;
      // default:
      //   _LoginResponse.ApiError = ApiError.fromJson(json.decode(response.body));
      //   break;
    }
  } on SocketException {
    debugPrint("Server error. Please retry");
    // _LoginResponse.ApiError = ApiError(error: "Server error. Please retry");
  } on Exception catch (e) {
    debugPrint("Server error. Please retry");
    debugPrint(e.toString());
  }
  return user;
}
