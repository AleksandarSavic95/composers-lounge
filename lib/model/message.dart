import 'package:composers_lounge/services/socket_message.dart';

class Message {
  final DateTime sentOn;
  final String content;
  final String sender;
  final String? avatarUrl;

  Message({
    required this.sentOn,
    required this.content,
    required this.sender,
    this.avatarUrl,
  });

  factory Message.fromMsgBusMessage(MessageToClient m) {
    return Message(content: m.payload, sender: m.from, sentOn: DateTime.now());
  }
}
