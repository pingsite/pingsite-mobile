import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pingsite/pages/home_page.dart';
import 'package:pingsite/pages/login_page.dart';
import 'service/auth.service.dart';
import 'dart:developer' as developer;

Future<void> backgroundHandler(RemoteMessage message) async {
  developer.inspect(message);
}

final _auth = AuthService();
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', 'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.high,
    playSound: true,
    showBadge: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isAuthed = await _auth.checkAuth();
  if (isAuthed) {
    await connectFirebase();
  }
  Widget _defaultHome = isAuthed ? HomePage() : const LoginPage();
  runApp(MaterialApp(
    title: 'PingSite',
    theme: ThemeData(
      primarySwatch: Colors.indigo,
    ),
    home: _defaultHome,
  ));
}

connectFirebase() async {
  //received if app is not running
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  // //received if app is in foreground
  // FirebaseMessaging.onMessage.listen((event) {
  //   developer.inspect(event);
  // });
  //
  // //received if app is in background
  // FirebaseMessaging.onMessageOpenedApp.listen((message) {
  //   developer.inspect(message.data);
  // });

  String? token = await FirebaseMessaging.instance.getToken();
  developer.log("Got token $token");
  if (token != null && token.isNotEmpty) {
    _auth.registerDevice(token);
  }
}
