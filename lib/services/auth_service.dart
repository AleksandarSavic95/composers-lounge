import 'dart:io';
import 'dart:math';
import 'package:composers_lounge/model/user.dart';

abstract class AuthService {
  Future<User?> login(String username);

  Future<String?> uploadUserPhoto(File photoFile);
  Future<User?> updateConnectionToken(String connectionToken);
}

class AuthServiceMock extends AuthService {
  late User user;

  Map<String, User> db = {
    'Lizt': User(
      id: 'u_1',
      // connectionToken: 'conn_1', // no connection token - should be generated by backend on login/signup
      username: 'Lizt',
    ),
    'Beethoven': User(
      id: 'u_2',
      // connectionToken: 'conn_2', // no connection token - should be generated by backend on login/signup
      username: 'Beethoven',
    ),
  };

  @override
  Future<User?> login(String username) async {
    await Future.delayed(const Duration(seconds: 2));
    if (!db.containsKey(username)) {
      return null;
    }
    user = db[username]!;
    return user;
  }

  @override
  Future<User?> updateConnectionToken(String connectionToken) async {
    user = db[user.username]!.copyWith(connectionToken: connectionToken);
    db[user.username] = user;
    return user;
  }

  @override
  Future<String?> uploadUserPhoto(File photoFile) async {
    await Future.delayed(const Duration(seconds: 2));
    // Probably - https://wiki.vaud.cloud/en/documentation/msgbus/api#connectionsupdates-a-connections-metadata
    return 'https://i.pravatar.cc/400?img=${Random().nextInt(70)}';
  }
}
