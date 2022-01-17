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
}
