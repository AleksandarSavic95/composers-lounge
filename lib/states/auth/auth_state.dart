part of 'auth_cubit.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

/// User not logged in.
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Waiting for auth result.
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// User logged in.
class AuthLoaded extends AuthState {
  final User user;
  const AuthLoaded(this.user);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthLoaded && other.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}

/// Login failed.
class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
