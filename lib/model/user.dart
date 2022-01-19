class User {
  final String username;
  final String id;
  final String? connectionToken;
  final String? photoUrl;

  User({
    required this.username,
    required this.id,
    this.connectionToken,
    this.photoUrl,
  });

  User copyWith({
    String? username,
    String? id,
    String? connectionToken,
    String? photoUrl,
  }) {
    return User(
      username: username ?? this.username,
      id: id ?? this.id,
      connectionToken: connectionToken ?? this.connectionToken,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  @override
  String toString() {
    return 'User(username: $username, id: $id, connectionToken: $connectionToken, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.username == username &&
        other.id == id &&
        other.connectionToken == connectionToken &&
        other.photoUrl == photoUrl;
  }

  @override
  int get hashCode {
    return username.hashCode ^ id.hashCode ^ connectionToken.hashCode ^ photoUrl.hashCode;
  }
}
