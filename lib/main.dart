import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pingsite/login.dart';
import 'package:pingsite/service/dev_http.dart';

void main() {
  HttpOverrides.global = DevHttpOverrides();
  runApp(const PingsiteApp());
}

class PingsiteApp extends StatelessWidget {
  const PingsiteApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PingSite',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const LoginPage(),
    );
  }
}
