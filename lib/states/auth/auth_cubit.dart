import 'package:bloc/bloc.dart';
import 'package:composers_lounge/model/user.dart';
import 'package:composers_lounge/services/auth_service.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;

  AuthCubit(this._authService) : super(const AuthInitial());

  User? get user => state is AuthSuccessful
      ? (state as AuthSuccessful).user
      : state is AuthUpdated
          ? (state as AuthUpdated).user
          : null;

  Future<void> login(String username) async {
    emit(const AuthLoading());
    final user = await _authService.login(username);
    if (user == null) {
      emit(const AuthError('Wrong username!'));
      return;
    }
    emit(AuthSuccessful(user));
  }

  void setUserPhoto(String photoUrl) {
    if (user == null) {
      return;
    }
    emit(AuthUpdated(user!.copyWith(photoUrl: photoUrl)));
  }

  void logOut() {
    // _authService.logOut((state as AuthLoaded).user); // ?
    emit(const AuthUpdated(null));
  }

  void updateConnectionToken(String connectionToken) async {
    User? updatedUser = await _authService.updateConnectionToken(connectionToken);
    if (updatedUser == null) {
      return;
    }
    emit(AuthUpdated(updatedUser));
  }
}
