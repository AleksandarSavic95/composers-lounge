import 'package:bloc/bloc.dart';
import 'package:composers_lounge/model/user.dart';
import 'package:composers_lounge/services/auth_service.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;

  AuthCubit(this._authService) : super(const AuthInitial());

  Future<void> login(String username) async {
    emit(const AuthLoading());
    final user = await _authService.login(username);
    if (user == null) {
      emit(const AuthError('Wrong username!'));
      return;
    }
    emit(AuthLoaded(user));
  }
}
