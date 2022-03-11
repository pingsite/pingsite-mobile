import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

String _baseUrl = "https://dev.pingsite.io:4000/api/v1/";

class AuthService {
  Future<bool> checkAuth() async {
    User? user = await User.fromStorage();
    if (user == null) {
      return false;
    }
    return true;
  }

  Future<bool> login(String username, String password) async {

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
          User.fromJson(json.decode(response.body));
          return true;
        // case 401:
        //   _LoginResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        //   break;
        // default:
        //   _LoginResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        //   break;
      }
    } on Exception catch (e) {
      debugPrint("Server error. Please retry");
      debugPrint(e.toString());
    }
    return false;
  }
}
