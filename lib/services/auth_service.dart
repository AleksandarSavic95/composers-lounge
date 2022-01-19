import 'dart:io';
import 'dart:math';

import 'package:composers_lounge/model/user.dart';

abstract class AuthService {
  Future<User?> login(String username);

  Future<String?> uploadUserPhoto(File photoFile);
}

class AuthServiceMock extends AuthService {
  static Map db = {
    'Lizt': User(
      id: 'u_1',
      connectionToken: 'api_key_1',
      username: 'Lizt',
    ),
    'Beethoven': User(
      id: 'u_2',
      connectionToken: 'api_key_2',
      username: 'Beethoven',
    ),
  };

  @override
  Future<User?> login(String username) async {
    await Future.delayed(const Duration(seconds: 2));

    return db[username];
  }

  @override
  Future<String?> uploadUserPhoto(File photoFile) async {
    await Future.delayed(const Duration(seconds: 2));
    return 'https://i.pravatar.cc/400?img=${Random().nextInt(70)}';
  }
}
