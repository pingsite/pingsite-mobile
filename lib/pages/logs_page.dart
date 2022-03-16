import 'package:flutter/material.dart';

class LogsPage extends StatefulWidget {
  const LogsPage({Key? key}) : super(key: key);

  @override
  State<LogsPage> createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Logs page"));
  }
}
      // body: Column(
      //   children: <Widget>[
      //     Flexible(
      //       child: ListView.builder(
      //         reverse: true,
      //         itemBuilder: (BuildContext context, int index) {
      //           final message = messages[index];
      //           return Card(
      //               child: Column(
      //             children: <Widget>[
      //               ListTile(
      //                   leading: const Icon(Icons.message),
      //                   title: Text(message.text!),
      //                   subtitle: Text(message.time)),
      //             ],
      //           ));
      //         },
      //         itemCount: messages.length,
      //       ),
      //     ),
      //     const Divider(
      //       height: 1.0,
      //     )
      //   ],
      // ),
