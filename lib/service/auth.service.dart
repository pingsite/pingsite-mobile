import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:pingsite/service/device.service.dart';
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

  Future<bool> registerDevice(String token) async {
    var user = await User.fromStorage();
    if (user == null) {
      return false;
    }
    var deviceId = await DeviceService.getDeviceId();
    var payload = {"device_id": deviceId, "registration_id": token};
    var accessToken = user.accessToken;
    http.Response response = await http.post(
        Uri.parse('${_baseUrl}device/register'),
        headers: {
          "Authorization": accessToken,
          "Content-Type": "application/json"
        },
        body: json.encode(payload));
    developer.inspect(response);
    switch (response.statusCode) {
      case 200:
        return true;
    }

    return false;
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
      developer.inspect(response);
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
      developer.log("Server error. Please retry");
      developer.inspect(e);
    }
    return false;
  }
}
