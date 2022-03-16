import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class User {
  final String accessToken;
  final String refreshToken;
  final String displayName;
  final String email;

  User(
      {required this.accessToken,
      required this.refreshToken,
      required this.displayName,
      required this.email});

  store() async {
    const storage = FlutterSecureStorage();
    await storage.write(key: 'user', value: jsonEncode(toJson()));
  }

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'refreshToken': displayName,
        'displayName': displayName,
        'email': email,
      };

  static User fromJson(Map<String, dynamic> json) {
    User user = User(
        accessToken: json['data']['access_token'],
        refreshToken: json['data']['refresh_token'],
        displayName: json['user']['display_name'] ?? 'PingSite User',
        email: json['user']['email']);
    user.store();
    return user;
  }

  static Future<User?> fromStorage() async {
    const storage = FlutterSecureStorage();
    String? user = await storage.read(key: 'user');
    if (user == null) {
      return null;
    }
    Map<String, dynamic> decoded = jsonDecode(user);
    return User(
        accessToken: decoded['accessToken'],
        refreshToken: decoded['refreshToken'],
        displayName: decoded['displayName'],
        email: decoded['email']);
  }
}
