import 'package:flutter/material.dart';
import 'package:pingsite/home.dart';
import 'package:pingsite/login.dart';

import 'service/auth.service.dart';

final _auth = AuthService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isAuthed = await _auth.checkAuth();
  Widget _defaultHome = isAuthed ? HomePage() : const LoginPage();
  runApp(MaterialApp(
    title: 'PingSite',
    theme: ThemeData(
      primarySwatch: Colors.indigo,
    ),
    home: _defaultHome,
  ));
}
