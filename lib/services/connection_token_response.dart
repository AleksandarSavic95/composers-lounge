import 'dart:convert';

class ConnectionTokenResponse {
  final ConnectionToken connectionToken;

  ConnectionTokenResponse(this.connectionToken);

  Map<String, dynamic> toMap() {
    return {
      'connectionToken': connectionToken.toMap(),
    };
  }

  factory ConnectionTokenResponse.fromMap(Map<String, dynamic> map) {
    return ConnectionTokenResponse(
      ConnectionToken.fromMap(map['connectionToken']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ConnectionTokenResponse.fromJson(String source) => ConnectionTokenResponse.fromMap(json.decode(source));
}

class ConnectionToken {
  // InformTopicSubs: true,
  // conId: "string",
  final String connectionToken;
  // connectionTokenId: "string",
  // createdAt: "string",
  // handle: "string",
  // realmId: "string",
  // tenantId: "string",
  final List<String> topics;
  // "ttl": 0,
  // "uid": "string",
  // "used": true

  ConnectionToken(this.connectionToken, this.topics);

  Map<String, dynamic> toMap() {
    return {
      'connectionToken': connectionToken,
      'topics': topics,
    };
  }

  factory ConnectionToken.fromMap(Map<String, dynamic> map) {
    return ConnectionToken(
      map['connectionToken'] ?? '',
      List<String>.from(map['topics']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ConnectionToken.fromJson(String source) => ConnectionToken.fromMap(json.decode(source));
}
