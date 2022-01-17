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
}
