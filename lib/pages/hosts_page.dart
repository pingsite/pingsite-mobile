import 'package:flutter/material.dart';

class HostsPage extends StatefulWidget {
  const HostsPage({Key? key}) : super(key: key);

  @override
  State<HostsPage> createState() => _HostsPageState();
}

class _HostsPageState extends State<HostsPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Hosts Page"));
  }
}
