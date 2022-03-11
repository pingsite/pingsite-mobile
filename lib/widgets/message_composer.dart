import 'package:flutter/material.dart';

class MessageComposer extends StatelessWidget {
  final TextEditingController textController;
  final ValueChanged<String> sendMessage;

  const MessageComposer(
      {Key? key, required this.textController, required this.sendMessage})
      : super(key: key);

  @override
  build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                  controller: textController,
                  onSubmitted: sendMessage,
                  decoration: const InputDecoration.collapsed(
                      hintText: "Send a message")),
            ),
            IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => sendMessage(textController.text))
          ],
        ));
  }
}
