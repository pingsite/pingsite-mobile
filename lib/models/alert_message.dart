import 'package:intl/intl.dart';

class AlertMessage {
  final String? text;
  final DateTime received = DateTime.now();
  AlertMessage({this.text});

  get time => DateFormat.Hms().format(received);
}
