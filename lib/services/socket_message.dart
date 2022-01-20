import 'dart:convert';

class MsgPacketToClient {
  final List<MessageToClient> messages;

  MsgPacketToClient(this.messages);

  Map<String, dynamic> toMap() {
    return {
      'messages': messages.map((x) => x.toMap()).toList(),
    };
  }

  factory MsgPacketToClient.fromMap(Map<String, dynamic> map) {
    return MsgPacketToClient(
      List<MessageToClient>.from(map['messages']?.map((x) => MessageToClient.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory MsgPacketToClient.fromJson(String source) => MsgPacketToClient.fromMap(json.decode(source));
}

class MessageToClient {
  final String id;
  final String from;
  final String topic;
  final String payload;
  final bool gzip;

  MessageToClient(this.id, this.from, this.topic, this.payload, this.gzip);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'from': from,
      'topic': topic,
      'payload': payload,
      'gzip': gzip,
    };
  }

  factory MessageToClient.fromMap(Map<String, dynamic> map) {
    return MessageToClient(
      map['id'] ?? '',
      map['from'] ?? '',
      map['topic'] ?? '',
      map['payload'] ?? '',
      map['gzip'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageToClient.fromJson(String source) => MessageToClient.fromMap(json.decode(source));
}
