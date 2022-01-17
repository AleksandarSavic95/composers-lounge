import 'package:composers_lounge/model/user.dart';

abstract class AuthService {
  Future<User?> login(String username);
}

class AuthServiceMock extends AuthService {
  static Map db = {
    'Lizt': User(
      apiKey: 'api_key_1',
      username: 'Lizt',
    ),
    'Beethoven': User(
      apiKey: 'api_key_2',
      username: 'Beethoven',
    ),
  };

  @override
  Future<User?> login(String username) async {
    await Future.delayed(const Duration(seconds: 2));

    return db[username];
  }
}
