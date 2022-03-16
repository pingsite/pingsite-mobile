import 'package:flutter/material.dart';
import 'package:phoenix_wings/phoenix_wings.dart';
import 'package:pingsite/pages/logs_page.dart';

import '../models/alert_message.dart';
import 'about_page.dart';
import 'hosts_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  final socket = PhoenixSocket("wss://dev.pingsite.io:4000/socket/websocket");

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PhoenixChannel _channel;
  int _selectedTabIndex = 0;
  List<AlertMessage> messages = [];
  var bottomNavigationBarItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.add_comment),
      label: "Hosts",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today),
      label: "Logs",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.account_circle),
      label: "About",
    ),
  ];
  final pages = [
    const HostsPage(),
    const LogsPage(),
    const AboutPage(),
  ];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await connectSocket();
    });
  }

  connectSocket() async {
    await widget.socket.connect();
    _channel = widget.socket.channel("updates:errors");
    _channel.on("say", _say);
    _channel.join();
  }

  _say(payload, _ref, _joinRef) {
    setState(() {
      messages.insert(0, AlertMessage(text: payload["message"]));
    });
  }

  void _onTabPageChanged(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PingSite"),
      ),
      body: pages[_selectedTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavigationBarItems,
        currentIndex: _selectedTabIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onTabPageChanged,
      ),
    );
  }
}
