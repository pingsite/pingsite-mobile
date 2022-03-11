import 'dart:collection';

class LoginResponse {
  late HashMap<String, String> data;
}

class User {
  late String accessToken;
  late String refreshToken;
  late String displayName;
  late String email;

  static User fromJson(Map<String, dynamic> json) {
    User user = User();
    user.accessToken = json['data']['access_token'];
    user.refreshToken = json['data']['refresh_token'];
    user.displayName = json['user']['display_name'];
    user.email = json['user']['email'];
    return user;
  }
}
