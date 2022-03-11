import 'package:flutter/material.dart';
import 'package:phoenix_wings/phoenix_wings.dart';
import 'package:pingsite/widgets/message_composer.dart';

import 'models/chat_message.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  final socket = PhoenixSocket("ws://dev.pingsite.io:4000/socket/websocket");

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PhoenixChannel _channel;
  List<ChatMessage> messages = [];
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    // connectSocket();
    super.initState();
  }

  connectSocket() async {
    await widget.socket.connect();
    // Create a new PhoenixChannel
    _channel = widget.socket.channel("updates:errors");
    // Setup listeners for channel events
    _channel.on("say", _say);
    // Make the request to the server to join the channel
    _channel.join();
  }

  _say(payload, _ref, _joinRef) {
    setState(() {
      messages.insert(0, ChatMessage(text: payload["message"]));
    });
  }

  _sendMessage(message) {
    _channel.push(event: "say", payload: {"message": message});
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PingSite"),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              reverse: true,
              itemBuilder: (BuildContext context, int index) {
                final message = messages[index];
                return Card(
                    child: Column(
                  children: <Widget>[
                    ListTile(
                        leading: const Icon(Icons.message),
                        title: Text(message.text!),
                        subtitle: Text(message.time)),
                  ],
                ));
              },
              itemCount: messages.length,
            ),
          ),
          const Divider(
            height: 1.0,
          ),
          MessageComposer(
            textController: _textController,
            sendMessage: _sendMessage,
          )
        ],
      ),
    );
  }
}
