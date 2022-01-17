class User {
  final String apiKey;
  final String username;
  final String? photoUrl;

  User({
    required this.apiKey,
    required this.username,
    this.photoUrl,
  });
}
