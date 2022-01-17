import 'message.dart';

class Channel {
  final String name;
  final String id;
  final List<Message> messages;

  Channel({
    required this.name,
    required this.id,
    this.messages = const [],
  });
}
