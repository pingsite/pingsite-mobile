import 'package:intl/intl.dart';

class ChatMessage {
  final String? text;
  final DateTime received = DateTime.now();
  ChatMessage({this.text});

  get time => DateFormat.Hms().format(received);
}
